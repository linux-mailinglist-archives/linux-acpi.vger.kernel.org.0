Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62CF691ACE
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjBJJHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjBJJGj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A5F2313C;
        Fri, 10 Feb 2023 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019977; x=1707555977;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tyAA/0gIK0IYL4MQ6rj9f+aiydACvqCY4T+pqHWSbEY=;
  b=bKTN36axc+rzMWvS/i4F0FV/dF+4f2EdC0pT+uxCXFGpEXqbDFCSOKwI
   B6dZxVHaHIL/poGlDc0bif1Bw0vykKcIOU+3G4PvQ47KNVnMutsXqQZO0
   IZlVPzT5G+Ex2eg3+pSGF1JV2XHPPtJ4Lx5QCPcYQXediwK8JpBNX79rw
   Mcae5TGNS+7E53StpzOAkB1vGwtjwd1dOQ/lJGCwC7uDz1DoIjaUQXRdj
   zmsYog7725RSKassZHzRdIrhsll2CmdD4YGMAPEXeyx6A12iJbBFwS3N+
   1OC+vnHT1Fvk/47e8jSiBQH7n5xoy3NtQf1dD9lk37pnmAqeUXWg8ubDd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329003041"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="329003041"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913463794"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="913463794"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:16 -0800
Subject: [PATCH v2 09/20] cxl/region: Move region-position validation to a
 helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Fan Ni <fan.ni@samsung.com>, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:15 -0800
Message-ID: <167601997584.1924368.4615769326126138969.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
References: <167601992097.1924368.18291887895351917895.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564538779.847146.8356062886811511706.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |  119 +++++++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 43 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ae7d3adcd41a..691605f1e120 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1211,35 +1211,13 @@ static int cxl_region_setup_targets(struct cxl_region *cxlr)
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
@@ -1278,6 +1256,71 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -1288,13 +1331,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -1318,12 +1354,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
@@ -1349,10 +1386,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	p->nr_targets--;
 	cxled->pos = -1;
 	p->targets[pos] = NULL;
-err:
-	for (iter = ep_port; !is_cxl_root(iter);
-	     iter = to_cxl_port(iter->dev.parent))
-		cxl_port_detach_region(iter, cxlr, cxled);
 	return rc;
 }
 

