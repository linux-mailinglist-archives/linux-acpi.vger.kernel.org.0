Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D406DB152
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjDGROP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDGROO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:14:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344DA5CB;
        Fri,  7 Apr 2023 10:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887652; x=1712423652;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ljebYg9qvunRUXg2iAM4lfi0gFE5bHRhzKpxaWOS0Kg=;
  b=jsJ/qoglC+OURq5v35+xXtZFCXTPujm1+XaotFG5tQcn85JbWUSPbA+E
   +X0eGEehyPo193ukw2cpn7vxTKQa5fD7pt5vQNrI/mwo2PA/G7lSU8DMb
   qZTMdCQpEYcoMUi1sN9rOXvhdkZktBdOz5GUX9UhmlapEIhK7C7kyEX8d
   WmJ43M4f7fm8Nx5bPOw3Da+uALsrqICX/vY2Mfm+PGnNMlD7OaE+rZ2DY
   BIxvNZKT9R1pzd3DflYevXFvU+KgtDNANsDE6Ei2+WBfzDdhk6H24plgS
   jh63nwymml+tSa0SDA6QeFpqrokKjbK9Qy/wYDEoBMh9G55rKoC9bCBHC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="345682108"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="345682108"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="831251792"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="831251792"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:54 -0700
Subject: [PATCH 3 19/23] cxl: Wait Memory_Info_Valid before access memory
 related info
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:53 -0700
Message-ID: <168088763346.1441063.5474477785580754741.stgit@djiang5-mobl3>
In-Reply-To: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
References: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

CXL rev3.0 8.1.3.8.2 Memory_Info_valid field

The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
Low registers are valid. The bit must be set within 1 second of reset
deassertion to the device. Check valid bit before we check the
Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
the memory info is valid for consumption.

Fixes: 2e4ba0ec9783 ("cxl/pci: Move cxl_await_media_ready() to the core")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Check both ranges. (Jonathan)
---
 drivers/cxl/core/pci.c |   83 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxlpci.h   |    2 +
 2 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d5a0addbef2..0c314fb8b42c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -101,21 +101,55 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
 
-/*
- * Wait up to @media_ready_timeout for the device to report memory
- * active.
- */
-int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	bool valid = false;
+	int rc, i;
+	u32 temp;
+
+	if (id > CXL_DVSEC_RANGE_MAX)
+		return -EINVAL;
+
+	/* Check MEM INFO VALID bit first, give up after 1s */
+	i = 1;
+	do {
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
+					   &temp);
+		if (rc)
+			return rc;
+
+		valid = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
+		if (valid)
+			break;
+		msleep(1000);
+	} while (i--);
+
+	if (!valid) {
+		dev_err(&pdev->dev,
+			"Timeout awaiting memory range %d valid after 1s.\n",
+			id);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	int d = cxlds->cxl_dvsec;
 	bool active = false;
-	u64 md_status;
 	int rc, i;
+	u32 temp;
 
-	for (i = media_ready_timeout; i; i--) {
-		u32 temp;
+	if (id > CXL_DVSEC_RANGE_MAX)
+		return -EINVAL;
 
+	/* Check MEM ACTIVE bit, up to 60s timeout by default */
+	for (i = media_ready_timeout; i; i--) {
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
 		if (rc)
@@ -134,6 +168,39 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 		return -ETIMEDOUT;
 	}
 
+	return 0;
+}
+
+/*
+ * Wait up to @media_ready_timeout for the device to report memory
+ * active.
+ */
+int cxl_await_media_ready(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	int rc, i, hdm_count;
+	u64 md_status;
+	u16 cap;
+
+	rc = pci_read_config_word(pdev,
+				  d + CXL_DVSEC_CAP_OFFSET, &cap);
+	if (rc)
+		return rc;
+
+	hdm_count = FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
+	for (i = 0; i < hdm_count; i++) {
+		rc = cxl_dvsec_mem_range_valid(cxlds, i);
+		if (rc)
+			return rc;
+	}
+
+	for (i = 0; i < hdm_count; i++) {
+		rc = cxl_dvsec_mem_range_active(cxlds, i);
+		if (rc)
+			return rc;
+	}
+
 	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
 	if (!CXLMDEV_READY(md_status))
 		return -EIO;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index ff4c2d10ca4a..cca86a76bd75 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -32,6 +32,8 @@
 #define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + (i * 0x10))
 #define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
 
+#define CXL_DVSEC_RANGE_MAX		2
+
 /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
 #define CXL_DVSEC_FUNCTION_MAP					2
 


