Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772C66DB149
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjDGRNA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDGRM7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4300911C;
        Fri,  7 Apr 2023 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887578; x=1712423578;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U9t8irqFfRaxiNZDrcPZ50oWgg6/WGThyNchyUo1CQ0=;
  b=hLRrxmVlDZ0KaOnPZorc7y0Pj+MuY/htrkog14JwbRWwHMEqNbU1UeRc
   qgjJP0J8Q0NKye3QmMXhsDKwZSU+eiO8ZNKnC6JlJB9GWqkw6F6AGS79V
   gzZyHfcPfAM0kkRZyN37rgFPEHNo/umOHEqjHfsWTvVLAWK1AO7+Luydt
   IAA/DP5+0IdStCnr0YZkt/XvxryBT9u4v/O9my/hbdQFpCCJwMhVfIDLe
   YV28wBsxzyvJR4xsJQPBoihDi9HCfyBT+5XK2zJWcR7O81IyocnIdwBb3
   mrRoFstg2/mNV+LtffSr00qgEqf+1EUq1BAzYmyp7yNvpYu97ztcUGDAF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="344806191"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="344806191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="637766403"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="637766403"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:57 -0700
Subject: [PATCH 3 10/23] cxl: Add helpers to calculate pci latency for the CXL
 device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:56 -0700
Message-ID: <168088757644.1441063.5632015975342945863.stgit@djiang5-mobl3>
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

The latency is calculated by dividing the flit size over the bandwidth. Add
support to retrieve the flit size for the CXL device and calculate the
latency of the downstream link.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Fix commit log issues. (Jonathan)
- Fix var declaration issues. (Jonathan)
---
 drivers/cxl/core/pci.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlpci.h   |   15 +++++++++++
 drivers/cxl/pci.c      |   13 ---------
 3 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 1c415b26e866..9d5a0addbef2 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -712,3 +712,71 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, CXL);
+
+static int pcie_speed_to_mbps(enum pci_bus_speed speed)
+{
+	switch (speed) {
+	case PCIE_SPEED_2_5GT:
+		return 2500;
+	case PCIE_SPEED_5_0GT:
+		return 5000;
+	case PCIE_SPEED_8_0GT:
+		return 8000;
+	case PCIE_SPEED_16_0GT:
+		return 16000;
+	case PCIE_SPEED_32_0GT:
+		return 32000;
+	case PCIE_SPEED_64_0GT:
+		return 64000;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int cxl_pci_mbits_to_mbytes(struct pci_dev *pdev)
+{
+	int mbits;
+
+	mbits = pcie_speed_to_mbps(pdev->bus->cur_bus_speed);
+	if (mbits < 0)
+		return mbits;
+
+	return mbits >> 3;
+}
+
+static int cxl_flit_size(struct pci_dev *pdev)
+{
+	if (cxl_pci_flit_256(pdev))
+		return 256;
+
+	return 68;
+}
+
+/**
+ * cxl_pci_get_latency - calculate the link latency for the PCIe link
+ * @pdev - PCI device
+ *
+ * return: calculated latency or -errno
+ *
+ * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
+ * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
+ * LinkProgationLatency is negligible, so 0 will be used
+ * RetimerLatency is assumed to be negligible and 0 will be used
+ * FlitLatency = FlitSize / LinkBandwidth
+ * FlitSize is defined by spec. CXL rev3.0 4.2.1.
+ * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
+ * The FlitLatency is converted to picoseconds.
+ */
+long cxl_pci_get_latency(struct pci_dev *pdev)
+{
+	long bw;
+
+	bw = cxl_pci_mbits_to_mbytes(pdev);
+	if (bw < 0)
+		return bw;
+
+	return cxl_flit_size(pdev) * 1000000L / bw;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 1bca1c0e4b40..795eba31fe29 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -167,6 +167,19 @@ struct cdat_sslbis {
 #define SSLBIS_US_PORT		0x0100
 #define SSLBIS_ANY_PORT		0xffff
 
+/*
+ * CXL v3.0 6.2.3 Table 6-4
+ * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
+ * mode, otherwise it's 68B flits mode.
+ */
+static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
+{
+	u16 lnksta2;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
+}
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
@@ -189,4 +202,6 @@ int cxl_##x##_parse_entry(struct cdat_entry_header *header, void *arg)
 cxl_parse_entry(dsmas);
 cxl_parse_entry(dslbis);
 cxl_parse_entry(sslbis);
+
+long cxl_pci_get_latency(struct pci_dev *pdev);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ea38bd49b0cf..ed39d133b70d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -365,19 +365,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
 }
 
-/*
- * CXL v3.0 6.2.3 Table 6-4
- * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
- * mode, otherwise it's 68B flits mode.
- */
-static bool cxl_pci_flit_256(struct pci_dev *pdev)
-{
-	u16 lnksta2;
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
-	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);


