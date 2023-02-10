Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3F691AD2
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjBJJHm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjBJJGv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:06:51 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF48F1C5B2;
        Fri, 10 Feb 2023 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676019994; x=1707555994;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gr+5ktwk+FAUTV+9ED5wsHL+1owhmcENlu36isQTlcE=;
  b=lo+nyjhMEvmuroe6vQf8V3U8cijZ3IA29aKKBwgWUNvPvX4R3GNBQkSO
   2o4fqOI9gAVzDdwEDUaQot6k1CTyv4DcuZO+z/2njhgkkQgi7SYKVo7eJ
   L75xzxZYmJQPy9W9LfvEU9bwtQu+LZxGQIiuvROzoI+Hpm4X+9nE12ylf
   TTVsM1glSLQFH0TsMYXuZuhsiEpMQlT6xSlqIWnSgAYbiuPLKXZIxHB7L
   WoNPaqNG/cEs4HC2fX7tWIu+MCYcGBj+MN4OyMHW4998+IMYhqaScgbvL
   2KbqEB5jkQXe/zRDLAZhwB8RanM+kmNjwoQA/fJOoxaDxtbTeOIgJkAuM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="329003096"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="329003096"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:34 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="913463888"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="913463888"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:34 -0800
Subject: [PATCH v2 12/20] cxl/port: Split endpoint and switch port probe
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        linux-mm@kvack.org, linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:33 -0800
Message-ID: <167601999378.1924368.15071142145866277623.stgit@dwillia2-xfh.jf.intel.com>
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

Jonathan points out that the shared code between the switch and endpoint
case is small. Before adding another is_cxl_endpoint() conditional,
just split the two cases.

Rather than duplicate the "Couldn't enumerate decoders" error message
take the opportunity to improve the error messages in
devm_cxl_enumerate_decoders().

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Link: http://lore.kernel.org/r/20230208170724.000067ec@Huawei.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   11 ++++++--
 drivers/cxl/port.c     |   69 +++++++++++++++++++++++++++---------------------
 2 files changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index dcc16d7cb8f3..a0891c3464f1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -826,7 +826,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			cxled = cxl_endpoint_decoder_alloc(port);
 			if (IS_ERR(cxled)) {
 				dev_warn(&port->dev,
-					 "Failed to allocate the decoder\n");
+					 "Failed to allocate decoder%d.%d\n",
+					 port->id, i);
 				return PTR_ERR(cxled);
 			}
 			cxld = &cxled->cxld;
@@ -836,7 +837,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			cxlsd = cxl_switch_decoder_alloc(port, target_count);
 			if (IS_ERR(cxlsd)) {
 				dev_warn(&port->dev,
-					 "Failed to allocate the decoder\n");
+					 "Failed to allocate decoder%d.%d\n",
+					 port->id, i);
 				return PTR_ERR(cxlsd);
 			}
 			cxld = &cxlsd->cxld;
@@ -844,13 +846,16 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 
 		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
 		if (rc) {
+			dev_warn(&port->dev,
+				 "Failed to initialize decoder%d.%d\n",
+				 port->id, i);
 			put_device(&cxld->dev);
 			return rc;
 		}
 		rc = add_hdm_decoder(port, cxld, target_map);
 		if (rc) {
 			dev_warn(&port->dev,
-				 "Failed to add decoder to port\n");
+				 "Failed to add decoder%d.%d\n", port->id, i);
 			return rc;
 		}
 	}
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5453771bf330..a8d46a67b45e 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,55 +30,64 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
-static int cxl_port_probe(struct device *dev)
+static int cxl_switch_port_probe(struct cxl_port *port)
 {
-	struct cxl_port *port = to_cxl_port(dev);
 	struct cxl_hdm *cxlhdm;
 	int rc;
 
+	rc = devm_cxl_port_enumerate_dports(port);
+	if (rc < 0)
+		return rc;
 
-	if (!is_cxl_endpoint(port)) {
-		rc = devm_cxl_port_enumerate_dports(port);
-		if (rc < 0)
-			return rc;
-		if (rc == 1)
-			return devm_cxl_add_passthrough_decoder(port);
-	}
+	if (rc == 1)
+		return devm_cxl_add_passthrough_decoder(port);
 
 	cxlhdm = devm_cxl_setup_hdm(port);
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);
 
-	if (is_cxl_endpoint(port)) {
-		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
-		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	return devm_cxl_enumerate_decoders(cxlhdm);
+}
 
-		/* Cache the data early to ensure is_visible() works */
-		read_cdat_data(port);
+static int cxl_endpoint_port_probe(struct cxl_port *port)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_hdm *cxlhdm;
+	int rc;
+
+	cxlhdm = devm_cxl_setup_hdm(port);
+	if (IS_ERR(cxlhdm))
+		return PTR_ERR(cxlhdm);
 
-		get_device(&cxlmd->dev);
-		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
-		if (rc)
-			return rc;
+	/* Cache the data early to ensure is_visible() works */
+	read_cdat_data(port);
 
-		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
-		if (rc)
-			return rc;
+	get_device(&cxlmd->dev);
+	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
+	if (rc)
+		return rc;
 
-		rc = cxl_await_media_ready(cxlds);
-		if (rc) {
-			dev_err(dev, "Media not active (%d)\n", rc);
-			return rc;
-		}
-	}
+	rc = cxl_hdm_decode_init(cxlds, cxlhdm);
+	if (rc)
+		return rc;
 
-	rc = devm_cxl_enumerate_decoders(cxlhdm);
+	rc = cxl_await_media_ready(cxlds);
 	if (rc) {
-		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
+		dev_err(&port->dev, "Media not active (%d)\n", rc);
 		return rc;
 	}
 
-	return 0;
+	return devm_cxl_enumerate_decoders(cxlhdm);
+}
+
+static int cxl_port_probe(struct device *dev)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+
+	if (is_cxl_endpoint(port))
+		return cxl_endpoint_port_probe(port);
+	return cxl_switch_port_probe(port);
 }
 
 static ssize_t CDAT_read(struct file *filp, struct kobject *kobj,

