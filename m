Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC96068B386
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjBFBDM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBFBDJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEDC126DD;
        Sun,  5 Feb 2023 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645388; x=1707181388;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pd/OzsallZam53iFg2v2xJwCJFvmTCwZnqxjvamzJrs=;
  b=V6ixechAb0aRGXZJn8LGYRHnpWFwokMukFUkZSNgO3O286d93Qz+2pRd
   It6QuUCPzNPz0q8zDU3uyInALTW715NE1d5UHEvYJ4dQY1uG8EQKL8aRY
   D2URgHZpvHKBYmAywnZ42EzXD6oR/gwarEtJqq8oqWb7/oAIZbdA2nX5m
   d4j+HK6AKaUT45dMwcqzy3kbiHPeNqSGj8o/nLBmmj+DPjH6Of5/UkeLC
   q/VWl5vpnBB9fLyF438ixhX8JGihlu+UBioMRKxbQIKGe6FBUeg8yE7+G
   sJQ8F6LSVC2AxjxNeqII65+G5I1vbFsw9zSKaHKOXwU8kf2HLN5riSvFO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="312763186"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="312763186"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="616291299"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616291299"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:08 -0800
Subject: [PATCH 07/18] cxl/region: Move region-position validation to a
 helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:07 -0800
Message-ID: <167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for region autodiscovery, that needs all devices
discovered before their relative position in the region can be
determined, consolidate all position dependent validation in a helper.

Recall that in the on-demand region creation flow the end-user picks the
position of a given endpoint decoder in a region. In the autodiscovery
case the position of an endpoint decoder can only be determined after
all other endpoint decoders that claim to decode the region's address
range have been enumerated and attached. So, in the autodiscovery case
endpoint decoders may be attached before their relative position is
known. Once all decoders arrive, then positions can be determined and
validated with cxl_region_validate_position() the same as user initiated
on-demand creation.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |  119 +++++++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 43 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 97eafdd75675..c82d3b6f3d1f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1207,35 +1207,13 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
 	return 0;
 }
 
-static int cxl_region_attach(struct cxl_region *cxlr,
-			     struct cxl_endpoint_decoder *cxled, int pos)
+static int cxl_region_validate_position(struct cxl_region *cxlr,
+					struct cxl_endpoint_decoder *cxled,
+					int pos)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *ep_port, *root_port, *iter;
 	struct cxl_region_params *p = &cxlr->params;
-	struct cxl_dport *dport;
-	int i, rc = -ENXIO;
-
-	if (cxled->mode != cxlr->mode) {
-		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
-			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
-		return -EINVAL;
-	}
-
-	if (cxled->mode == CXL_DECODER_DEAD) {
-		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
-		return -ENODEV;
-	}
-
-	/* all full of members, or interleave config not established? */
-	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		dev_dbg(&cxlr->dev, "region already active\n");
-		return -EBUSY;
-	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		dev_dbg(&cxlr->dev, "interleave config missing\n");
-		return -ENXIO;
-	}
+	int i;
 
 	if (pos < 0 || pos >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
@@ -1274,6 +1252,71 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		}
 	}
 
+	return 0;
+}
+
+static int cxl_region_attach_position(struct cxl_region *cxlr,
+				      struct cxl_root_decoder *cxlrd,
+				      struct cxl_endpoint_decoder *cxled,
+				      const struct cxl_dport *dport, int pos)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *iter;
+	int rc;
+
+	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
+		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			dev_name(&cxlrd->cxlsd.cxld.dev));
+		return -ENXIO;
+	}
+
+	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent)) {
+		rc = cxl_port_attach_region(iter, cxlr, cxled, pos);
+		if (rc)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent))
+		cxl_port_detach_region(iter, cxlr, cxled);
+	return rc;
+}
+
+static int cxl_region_attach(struct cxl_region *cxlr,
+			     struct cxl_endpoint_decoder *cxled, int pos)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_port *ep_port, *root_port;
+	struct cxl_dport *dport;
+	int rc = -ENXIO;
+
+	if (cxled->mode != cxlr->mode) {
+		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
+			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
+		return -EINVAL;
+	}
+
+	if (cxled->mode == CXL_DECODER_DEAD) {
+		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
+		return -ENODEV;
+	}
+
+	/* all full of members, or interleave config not established? */
+	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_dbg(&cxlr->dev, "region already active\n");
+		return -EBUSY;
+	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_dbg(&cxlr->dev, "interleave config missing\n");
+		return -ENXIO;
+	}
+
 	ep_port = cxled_to_port(cxled);
 	root_port = cxlrd_to_port(cxlrd);
 	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
@@ -1284,13 +1327,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
-		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
-			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			dev_name(&cxlrd->cxlsd.cxld.dev));
-		return -ENXIO;
-	}
-
 	if (cxled->cxld.target_type != cxlr->type) {
 		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
@@ -1314,12 +1350,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
-	for (iter = ep_port; !is_cxl_root(iter);
-	     iter = to_cxl_port(iter->dev.parent)) {
-		rc = cxl_port_attach_region(iter, cxlr, cxled, pos);
-		if (rc)
-			goto err;
-	}
+	rc = cxl_region_validate_position(cxlr, cxled, pos);
+	if (rc)
+		return rc;
+
+	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
+	if (rc)
+		return rc;
 
 	p->targets[pos] = cxled;
 	cxled->pos = pos;
@@ -1343,10 +1380,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 
 err_decrement:
 	p->nr_targets--;
-err:
-	for (iter = ep_port; !is_cxl_root(iter);
-	     iter = to_cxl_port(iter->dev.parent))
-		cxl_port_detach_region(iter, cxlr, cxled);
 	return rc;
 }
 

