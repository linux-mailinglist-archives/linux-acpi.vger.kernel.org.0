Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC46DB14B
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDGRNN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjDGRNL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:13:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568CAF30;
        Fri,  7 Apr 2023 10:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887590; x=1712423590;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gU0+fjD7n8Oa++jPhoowFHj07aGJ2pAuhA7crY5fq4E=;
  b=Fv+tgivrqcKj04zucWxO+rLyYdfQNnZOOw9TzRvrXzLhddK/ykJPno2z
   oXG+xP11MMBRrXrUE+/3Jx2ESw4z9taLyU3m8wdNafFbB0cvk3Xx6D+nA
   WaqnofM3a3Aj4kjM+UP4FkC/zzJj8t98072lIvqWSuXRtUfGVjxLKfRMa
   8an7pk5pPnTnZbr1LxXUCG0gLYTPVZzKtVIeu4nf1HihjRQ2FnD3DvZd0
   ZM6mjYpqG+GOet0qQpC5eUGZ8gkZt4mcbxear+GCjX7AagQHS6AUQ+9CJ
   vb8G+RNYwxQeD73Bi91+Z5G+U7jBlzdplzYo1nI01kNP8MCQ17pfQQTNv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340519881"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="340519881"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="690119044"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="690119044"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:09 -0700
Subject: [PATCH 3 12/23] cxl: Add helper function that calculate QoS values
 for PCI path
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:09 -0700
Message-ID: <168088758909.1441063.6718239019369220365.stgit@djiang5-mobl3>
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

Calculate the link bandwidth and latency for the PCIe path from the device
to the CXL Host Bridge. This does not include the CDAT data from the device
or the switch(es) in the path.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    2 ++
 2 files changed, 63 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8f3bff6a3b3b..9e935d420d00 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2026,6 +2026,67 @@ int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
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


