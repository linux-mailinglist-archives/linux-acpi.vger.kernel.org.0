Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34986DB147
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDGRMr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDGRMq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E29B9ED1;
        Fri,  7 Apr 2023 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887565; x=1712423565;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7zfqOcVJ02CJZ2p/NGllYcgfY1NukX2REpKJgA7P1A=;
  b=ixgz4OQQYwSmjEGujcqlyJU1JyiUE9Hognr28LdcXgpOMw7/PtaIhObh
   187cxEtozmKa18xm00xbKZ8la4QK9CWVRKb2VqGHsh/yOVUIaccJ/W3ad
   Ucx+oBbVxSO8bGa3PtIgYc+EwpLnMDqI5vDOmrU9StbysyAu5CBSMa5TG
   IC1A6IxsNp3Ozh9yz/8YPNkep2yz3DbGDaTsGrALfexOLa8DwO/SNgnmD
   GRR3XLHRfLKigPT5cmbeTdgIDJAu7h57tGa8LOWOtiWuGF6sLw/PDf4fg
   EVFNpU8qbtX3bslymhUKyDawYjysJ7kmAXJNjXo/2qq8vWGrChV1f29RL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="331684796"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="331684796"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681086991"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681086991"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:44 -0700
Subject: [PATCH 3 08/23] cxl: Add support for _DSM Function for retrieving QTG
 ID
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:44 -0700
Message-ID: <168088756427.1441063.2551375099982005342.stgit@djiang5-mobl3>
In-Reply-To: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
References: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)

Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
an input of an ACPI package with 4 dwords (read latency, write latency,
read bandwidth, write bandwidth). The call returns a package with 1 WORD
that provides the max supported QTG ID and a package that may contain 0 or
more WORDs as the recommended QTG IDs in the recommended order.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Reorder var declaration and use C99 style. (Jonathan)
- Allow >2 ACPI objects in package for future expansion. (Jonathan)
- Check QTG IDs against MAX QTG ID provided by output package. (Jonathan)
---
 drivers/cxl/core/Makefile |    1 
 drivers/cxl/core/acpi.c   |  116 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   16 ++++++
 3 files changed, 133 insertions(+)
 create mode 100644 drivers/cxl/core/acpi.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 867a8014b462..30d61c8cae22 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -13,5 +13,6 @@ cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += cdat.o
+cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
new file mode 100644
index 000000000000..6eda5cad8d59
--- /dev/null
+++ b/drivers/cxl/core/acpi.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include <asm/div64.h>
+#include "cxlpci.h"
+#include "cxl.h"
+
+const guid_t acpi_cxl_qtg_id_guid =
+	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
+		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
+
+/**
+ * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
+ * @handle: ACPI handle
+ * @input: bandwidth and latency data
+ *
+ * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
+ * the QTG IDs that falls within the performance data.
+ */
+struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
+						 struct qtg_dsm_input *input)
+{
+	union acpi_object *out_obj, *out_buf, *pkg;
+	union acpi_object in_buf = {
+		.buffer = {
+			.type = ACPI_TYPE_BUFFER,
+			.pointer = (u8 *)input,
+			.length = sizeof(u32) * 4,
+		},
+	};
+	union acpi_object in_obj = {
+		.package = {
+			.type = ACPI_TYPE_PACKAGE,
+			.count = 1,
+			.elements = &in_buf
+		},
+	};
+	struct qtg_dsm_output *output = NULL;
+	int len, rc, i;
+	u16 *max_qtg;
+
+	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
+	if (!out_obj)
+		return ERR_PTR(-ENXIO);
+
+	if (out_obj->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	/* Check Max QTG ID */
+	pkg = &out_obj->package.elements[0];
+	if (pkg->type != ACPI_TYPE_BUFFER) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	if (pkg->buffer.length != sizeof(u16)) {
+		rc = -ENXIO;
+		goto err;
+	}
+	max_qtg = (u16 *)pkg->buffer.pointer;
+
+	/* Retrieve QTG IDs package */
+	pkg = &out_obj->package.elements[1];
+	if (pkg->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	out_buf = &pkg->package.elements[0];
+	if (out_buf->type != ACPI_TYPE_BUFFER) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	len = out_buf->buffer.length;
+
+	/* It's legal to have 0 QTG entries */
+	if (len == 0)
+		goto out;
+
+	/* Malformed package, not multiple of WORD size */
+	if (len % sizeof(u16)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	output = kmalloc(len + sizeof(*output), GFP_KERNEL);
+	if (!output) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	output->nr = len / sizeof(u16);
+	memcpy(output->qtg_ids, out_buf->buffer.pointer, len);
+
+	for (i = 0; i < output->nr; i++) {
+		if (output->qtg_ids[i] > *max_qtg)
+			pr_warn("QTG ID %u greater than MAX %u\n",
+				output->qtg_ids[i], *max_qtg);
+	}
+
+out:
+	ACPI_FREE(out_obj);
+	return output;
+
+err:
+	ACPI_FREE(out_obj);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 50ac74f66cbd..04b8a032bd14 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,6 +7,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/acpi.h>
 #include <linux/log2.h>
 #include <linux/list.h>
 #include <linux/io.h>
@@ -791,6 +792,21 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 }
 #endif
 
+struct qtg_dsm_input {
+	u32 rd_lat;
+	u32 wr_lat;
+	u32 rd_bw;
+	u32 wr_bw;
+};
+
+struct qtg_dsm_output {
+	int nr;
+	u16 qtg_ids[];
+};
+
+struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
+						 struct qtg_dsm_input *input);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


