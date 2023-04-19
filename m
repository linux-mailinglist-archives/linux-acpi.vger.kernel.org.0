Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79A6E828E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjDSUY7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjDSUYE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:24:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2F10CB;
        Wed, 19 Apr 2023 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935734; x=1713471734;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0heK3iWUXBpvImAYgR+fwJoKb1lxTzGRCfK98tP3saY=;
  b=P2rh4iOayHRMWpQ/LO+/F7XuY4qeiSn+r28GQDu9cymAY9ia2DB3gdMs
   JsL36cm7vr133ar+52J71X7JvF3PcFeqTrhrldjX5nrQZIUp1fF71OtIv
   pxP87xw3SvaceK6ngFQ+4qdApeymhaG6ne19aBL5aW58zI1zEenCcGOV5
   HIvsuBSb1UOamgpfO+jJ/sVfq0Bzhl1wHcuEnWqf2sPnHPNx9YzgwTe0+
   fkbB0hSW/iEtKO8H4fL5/dwzAFdpYlOT0nvT2fgsgmvwi3h+KSzunbZEy
   CMnLl8Up2x2WHvtqJZ/KSdyh11W73IFV5nT4pskZR1kkzwf0zcLeM7zSa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373441449"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="373441449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021337075"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="1021337075"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:13 -0700
Subject: [PATCH v4 12/23] cxl: Add helper function that calculate QoS values
 for PCI path
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:22:13 -0700
Message-ID: <168193573330.1178687.2727689734216767954.stgit@djiang5-mobl3>
In-Reply-To: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
References: <168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
v4:
- 0-day fix, remove unused var. Fix checking < 0 for unsigned var.
- Rework port hierachy walk to calculate the latencies correctly
---
 drivers/cxl/core/port.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    2 +
 2 files changed, 85 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 770b540d5325..8da437e038b9 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -2002,6 +2002,89 @@ int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
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
+	long lat;
+
+	*bandwidth = 0;
+	*latency = 0;
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
+	/*
+	 * Walk the cxl_port hierachy to retrieve the link latencies for
+	 * each of the PCIe segments. The loop will obtain the link latency
+	 * via each of the switch downstream port.
+	 */
+	p = port;
+	do {
+		struct cxl_dport *dport = p->parent_dport;
+		struct device *dport_dev, *uport_dev;
+		struct pci_dev *dport_pdev;
+
+		if (!dport)
+			break;
+
+		dport_dev = dport->dport;
+		if (!dev_is_pci(dport_dev))
+			break;
+
+		p = dport->port;
+		uport_dev = p->uport;
+		if (!dev_is_pci(uport_dev))
+			break;
+
+		dport_pdev = to_pci_dev(dport_dev);
+		pdev = to_pci_dev(uport_dev);
+		lat = cxl_pci_get_latency(dport_pdev);
+		if (lat < 0)
+			return lat;
+
+		total_lat += lat;
+	} while (1);
+
+	/*
+	 * pdev would be either the cxl device if there are no switches, or the
+	 * upstream port of the last switch.
+	 */
+	lat = cxl_pci_get_latency(pdev);
+	if (lat < 0)
+		return lat;
+
+	total_lat += lat;
+	*bandwidth = min_bw;
+	*latency = total_lat;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_get_downstream_qos, CXL);
+
 /* for user tooling to ensure port disable work has completed */
 static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76ccc815134f..6a6387a545db 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -811,6 +811,8 @@ struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
 int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
 			    u64 *wr_bw, u64 *wr_lat);
+int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
+				u64 *latency);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


