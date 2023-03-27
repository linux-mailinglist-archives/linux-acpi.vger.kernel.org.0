Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514296CB0EA
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjC0Vpa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjC0VpS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:45:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08971FF2;
        Mon, 27 Mar 2023 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953517; x=1711489517;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6CBLF1DD1zQ6yDOItBTKoL6bG2Pv03DELrI8RTxx4VY=;
  b=Irnj+oqy1cm7I0IX4L7lGhgwPpwIEHoN3mHMgQEaN954sz0yP2AvVkRg
   xDN0MMvMmgrG8cZNuPNo5cR09v81xRqjJAdX1/b1P7d7RxeQFxCeBY5GT
   MgOwER7C/FlnR+zRGMhw0F4jSKucO6luDOA0eUqZc2xM3gpFFU0aEompZ
   Ejy2UQTuWMAzraYSnmwSZ5iPUklbt3jgPVAe/MnOi/hPjB0NGYCgOTy7h
   L+WUrDGlo1erdJx1aAPw8pC5r37SPcCIgS3Y3/aY+ATpWrIFPa8Uw2pif
   mUBqfVJ5U7aLuu/j7fZOr7fT1UOKptuktLX9F6pXDworneUf5o6p+eha7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337899994"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337899994"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686114760"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686114760"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:17 -0700
Subject: [PATCH v2 12/21] cxl: Add helper function that calculate QoS values
 for PCI path
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:45:16 -0700
Message-ID: <167995351670.2857312.8039697517683275636.stgit@djiang5-mobl3>
In-Reply-To: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
References: <167995336797.2857312.539473939839316778.stgit@djiang5-mobl3>
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

Calculate the link bandwidth and latency for the PCIe path from the device
to the CXL Host Bridge. This does not include the CDAT data from the device
or the switch(es) in the path.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    2 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6e2f8e40757e..f78559edd239 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2034,6 +2034,67 @@ int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_port_get_switch_qos, CXL);
 
+/**
+ * cxl_port_get_downstream_qos - retrieve QoS data for PCIE downstream path
+ * @port: endpoint cxl_port
+ * @bandwidth: writeback value for min bandwidth
+ * @latency: writeback value for total latency
+ *
+ * Return: Errno on failure, 0 on success.
+ */
+int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
+				u64 *latency)
+{
+	u64 min_bw = ULONG_MAX;
+	struct pci_dev *pdev;
+	struct cxl_port *p;
+	struct device *dev;
+	u64 total_lat = 0;
+	int devices = 0;
+	u64 lat;
+
+	/* Grab the device that is the PCI device for CXL memdev */
+	dev = port->uport->parent;
+	/* Skip if it's not PCI, most likely a cxl_test device */
+	if (!dev_is_pci(dev))
+		return 0;
+
+	pdev = to_pci_dev(dev);
+	min_bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
+	if (min_bw == 0)
+		return -ENXIO;
+
+	/* convert to MB/s from Mb/s */
+	min_bw >>= 3;
+
+	p = port;
+	do {
+		struct cxl_dport *dport;
+
+		lat = cxl_pci_get_latency(pdev);
+		if (lat < 0)
+			return lat;
+
+		total_lat += lat;
+		devices++;
+
+		dport = p->parent_dport;
+		if (!dport)
+			break;
+
+		p = dport->port;
+		dev = p->uport;
+		if (!dev_is_pci(dev))
+			break;
+		pdev = to_pci_dev(dev);
+	} while (1);
+
+	*bandwidth = min_bw;
+	*latency = total_lat;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_get_downstream_qos, CXL);
+
 /* for user tooling to ensure port disable work has completed */
 static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 21e7c1f78f1f..67e844645ef6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -809,6 +809,8 @@ struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
 int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
 			    u64 *wr_bw, u64 *wr_lat);
+int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
+				u64 *latency);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


