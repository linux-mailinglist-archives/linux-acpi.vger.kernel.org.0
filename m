Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7B68B38C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 02:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjBFBDj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 5 Feb 2023 20:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBFBDh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 5 Feb 2023 20:03:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDC614EA0;
        Sun,  5 Feb 2023 17:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675645416; x=1707181416;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t66eRnuPtljjvIsyyQm2MInJpJjgFLhSqg1tPwrvkw4=;
  b=PAO+1yeOOtU3dk87SargORah/X+hU2QTiF7A3L5MgaPgz0Xki/8JmMZz
   k0PovZ738Fu3vgkyMY9qPUNwb2aakCcJLHo9/wXzxZJWqhRr0zSnjZlI8
   StnTb1fNDIhYtVssoxnTRdlAJfapSPf6gEi9m90lr9LVwk5gWVF/rTTr4
   Nkx7l23Hcwlwdy6tBqloFfC2++TtTfgGM1kq2Y4wz7eglqHZRXhHI49VG
   t0xOedRDZ0TPQof1k8tdMZcf1olkDK5xurNvaqbOS5O/XZ56ka307UtdU
   rd9y0k3pYyrca38A8g51SjOFBk2vYOPjVG9U6vzBR5Iko3A6l3fAG4Bi/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309442656"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309442656"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="775006645"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="775006645"
Received: from mkrysak-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.255.187])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 17:03:35 -0800
Subject: [PATCH 12/18] tools/testing/cxl: Define a fixed volatile
 configuration to parse
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Sun, 05 Feb 2023 17:03:35 -0800
Message-ID: <167564541523.847146.12199636368812381475.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
References: <167564534874.847146.5222419648551436750.stgit@dwillia2-xfh.jf.intel.com>
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

Take two endpoints attached to the first switch on the first host-bridge
in the cxl_test topology and define a pre-initialized region. This is a
x2 interleave underneath a x1 CXL Window.

$ modprobe cxl_test
$ # cxl list -Ru
{
  "region":"region3",
  "resource":"0xf010000000",
  "size":"512.00 MiB (536.87 MB)",
  "interleave_ways":2,
  "interleave_granularity":4096,
  "decode_state":"commit"
}

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h      |    3 -
 drivers/cxl/core/hdm.c       |    3 +
 drivers/cxl/core/port.c      |    4 +
 drivers/cxl/cxl.h            |    4 +
 drivers/cxl/cxlmem.h         |    3 +
 tools/testing/cxl/test/cxl.c |  146 +++++++++++++++++++++++++++++++++++++++---
 6 files changed, 148 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5eb873da5a30..479f01da6d35 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -57,9 +57,6 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
 extern struct rw_semaphore cxl_dpa_rwsem;
 
-bool is_switch_decoder(struct device *dev);
-struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
-
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 174cddfec6e8..28fa4d835259 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -279,7 +279,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
-static int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				resource_size_t base, resource_size_t len,
 				resource_size_t skipped)
 {
@@ -295,6 +295,7 @@ static int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
+EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, CXL);
 
 resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
 {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8130430ffbcf..8d0895cbae93 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -458,6 +458,7 @@ bool is_switch_decoder(struct device *dev)
 {
 	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
 }
+EXPORT_SYMBOL_NS_GPL(is_switch_decoder, CXL);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
@@ -485,6 +486,7 @@ struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
 		return NULL;
 	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
 }
+EXPORT_SYMBOL_NS_GPL(to_cxl_switch_decoder, CXL);
 
 static void cxl_ep_release(struct cxl_ep *ep)
 {
@@ -528,7 +530,7 @@ static const struct device_type cxl_port_type = {
 
 bool is_cxl_port(struct device *dev)
 {
-	return dev->type == &cxl_port_type;
+	return dev && dev->type == &cxl_port_type;
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_port, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9b3765c5c81a..4c6ee6c96f23 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -452,6 +452,7 @@ struct cxl_region_params {
  * struct cxl_region - CXL region
  * @dev: This region's device
  * @id: This region's id. Id is globally unique across all regions
+ * @fixed: At least one decoder in this region was locked down at init
  * @mode: Endpoint decoder allocation / access mode
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
@@ -462,6 +463,7 @@ struct cxl_region_params {
 struct cxl_region {
 	struct device dev;
 	int id;
+	bool fixed;
 	enum cxl_decoder_mode mode;
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
@@ -643,8 +645,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
+struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
+bool is_switch_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 						unsigned int nr_targets,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ab138004f644..82a430cfc3ff 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -79,6 +79,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 }
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+			 resource_size_t base, resource_size_t len,
+			 resource_size_t skipped);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 920bd969c554..ea761afa446f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -703,6 +703,141 @@ static int mock_decoder_reset(struct cxl_decoder *cxld)
 	return 0;
 }
 
+static void default_mock_decoder(struct cxl_decoder *cxld)
+{
+	cxld->hpa_range = (struct range){
+		.start = 0,
+		.end = -1,
+	};
+
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = 256;
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+}
+
+static int first_decoder(struct device *dev, void *data)
+{
+	struct cxl_decoder *cxld;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+	cxld = to_cxl_decoder(dev);
+	if (cxld->id == 0)
+		return 1;
+	return 0;
+}
+
+static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
+{
+	struct acpi_cedt_cfmws *window = mock_cfmws[0];
+	struct platform_device *pdev = NULL;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_port *port, *iter;
+	const int size = SZ_512M;
+	struct cxl_memdev *cxlmd;
+	struct cxl_dport *dport;
+	struct device *dev;
+	bool hb0 = false;
+	u64 base;
+	int i;
+
+	if (is_endpoint_decoder(&cxld->dev)) {
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+		cxlmd = cxled_to_memdev(cxled);
+		WARN_ON(!dev_is_platform(cxlmd->dev.parent));
+		pdev = to_platform_device(cxlmd->dev.parent);
+
+		/* check is endpoint is attach to host-bridge0 */
+		port = cxled_to_port(cxled);
+		do {
+			if (port->uport == &cxl_host_bridge[0]->dev) {
+				hb0 = true;
+				break;
+			}
+			if (is_cxl_port(port->dev.parent))
+				port = to_cxl_port(port->dev.parent);
+			else
+				port = NULL;
+		} while (port);
+		port = cxled_to_port(cxled);
+	}
+
+	/*
+	 * The first decoder on the first 2 devices on the first switch
+	 * attached to host-bridge0 mock a fake / static RAM region. All
+	 * other decoders are default disabled. Given the round robin
+	 * assignment those devices are named cxl_mem.0, and cxl_mem.4.
+	 *
+	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
+	 */
+	if (!hb0 || pdev->id % 4 || pdev->id > 4 || cxld->id > 0) {
+		default_mock_decoder(cxld);
+		return;
+	}
+
+	base = window->base_hpa;
+	cxld->hpa_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+
+	cxld->interleave_ways = 2;
+	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_AUTO;
+	port->commit_end = cxld->id;
+	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+
+	/*
+	 * Now that endpoint decoder is set up, walk up the hierarchy
+	 * and setup the switch and root port decoders targeting @cxlmd.
+	 */
+	iter = port;
+	for (i = 0; i < 2; i++) {
+		dport = iter->parent_dport;
+		iter = dport->port;
+		dev = device_find_child(&iter->dev, NULL, first_decoder);
+		/*
+		 * Ancestor ports are guaranteed to be enumerated before
+		 * @port, and all ports have at least one decoder.
+		 */
+		if (WARN_ON(!dev))
+			continue;
+		cxlsd = to_cxl_switch_decoder(dev);
+		if (i == 0) {
+			/* put cxl_mem.4 second in the decode order */
+			if (pdev->id == 4)
+				cxlsd->target[1] = dport;
+			else
+				cxlsd->target[0] = dport;
+		} else
+			cxlsd->target[0] = dport;
+		cxld = &cxlsd->cxld;
+		cxld->target_type = CXL_DECODER_EXPANDER;
+		cxld->flags = CXL_DECODER_F_ENABLE;
+		iter->commit_end = 0;
+		/*
+		 * Switch targets 2 endpoints, while host bridge targets
+		 * one root port
+		 */
+		if (i == 0)
+			cxld->interleave_ways = 2;
+		else
+			cxld->interleave_ways = 1;
+		cxld->interleave_granularity = 256;
+		cxld->hpa_range = (struct range) {
+			.start = base,
+			.end = base + size - 1,
+		};
+		put_device(dev);
+	}
+}
+
 static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
 	struct cxl_port *port = cxlhdm->port;
@@ -748,16 +883,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			cxld = &cxled->cxld;
 		}
 
-		cxld->hpa_range = (struct range) {
-			.start = 0,
-			.end = -1,
-		};
-
-		cxld->interleave_ways = min_not_zero(target_count, 1);
-		cxld->interleave_granularity = SZ_4K;
-		cxld->target_type = CXL_DECODER_EXPANDER;
-		cxld->commit = mock_decoder_commit;
-		cxld->reset = mock_decoder_reset;
+		mock_init_hdm_decoder(cxld);
 
 		if (target_count) {
 			rc = device_for_each_child(port->uport, &ctx,

