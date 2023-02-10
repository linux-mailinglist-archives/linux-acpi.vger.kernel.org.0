Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65D6691AD4
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Feb 2023 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjBJJIE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Feb 2023 04:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjBJJHF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Feb 2023 04:07:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24CC10D5;
        Fri, 10 Feb 2023 01:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676020006; x=1707556006;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rZ3O3B8mdY6zXcZ47a8wBl453HTwxqIFLhvZISKfgJs=;
  b=fm/xyL7oCJh5Xb/uBZ7561gSKxsCPNUZLdAzX5c8t+jWN19PqUPpruj6
   eOxHVFhtWSy4l5D34ABFF5bBGb5Q/bWrvBOJM8/jtFUW+MdIg9LyWE16N
   bmBAn9tXBF0SsEnrGEEzcMlVHbDzvhsJSbcr/iCE0WDQoBc7llzyvqVFh
   OXOrTyQ8TYB81O5COMLADcyicN+QFk2Opb9OAtUUXI/iILWPGxJMPX0In
   EJp3ARYnLJK/jS4jhYqpwthWUgeDI2PT24T5qTQGFeDgu269SOBo2/q6U
   pcE+3ZKnrgjYsMjsL0+0WKrTzCpo5XJ+E57CxU36P5ztU5WsBRVZYCFYQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="328062566"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="328062566"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="700392672"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="700392672"
Received: from hrchavan-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.46.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 01:06:45 -0800
Subject: [PATCH v2 14/20] tools/testing/cxl: Define a fixed volatile
 configuration to parse
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Fan Ni <fan.ni@samsung.com>, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Date:   Fri, 10 Feb 2023 01:06:45 -0800
Message-ID: <167602000547.1924368.11613151863880268868.stgit@dwillia2-xfh.jf.intel.com>
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

Tested-by: Fan Ni <fan.ni@samsung.com>
Link: https://lore.kernel.org/r/167564541523.847146.12199636368812381475.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h      |    3 -
 drivers/cxl/core/hdm.c       |    3 +
 drivers/cxl/core/port.c      |    2 +
 drivers/cxl/cxl.h            |    2 +
 drivers/cxl/cxlmem.h         |    3 +
 tools/testing/cxl/test/cxl.c |  147 +++++++++++++++++++++++++++++++++++++++---
 6 files changed, 146 insertions(+), 14 deletions(-)

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
index 8c29026a4b9d..80eccae6ba9e 100644
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
index 59620528571a..b45d2796ef35 100644
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c8ee4bb8cce6..2ac344235235 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -653,8 +653,10 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 
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
index c9da3c699a21..bf7d4c5c8612 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -81,6 +81,9 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 }
 
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
+int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+			 resource_size_t base, resource_size_t len,
+			 resource_size_t skipped);
 
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 920bd969c554..5342f69d70d2 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -703,6 +703,142 @@ static int mock_decoder_reset(struct cxl_decoder *cxld)
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
+	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxled->state = CXL_DECODER_STATE_AUTO;
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
@@ -748,16 +884,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
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

