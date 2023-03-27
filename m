Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5511E6CB0EE
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjC0Vqc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjC0Vp5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:45:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DDE30E8;
        Mon, 27 Mar 2023 14:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953550; x=1711489550;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYRH6N4zfhx3kZr9t6XKOJzTYs9F5EponBN8NC06Fzk=;
  b=lADN/S20AiXX/3me4VJsHWvEbWnyOrMkyBh55ygWEtwmzLPiXefonIcY
   eKrEkWhK7XlHXFw8+q7r3KqUyCOcsQB92RfRD3GNp6vtdxHFS37Q+PAHj
   K8X/+uikjqR92xcmg/g+lUqBBHm6WYM8klQX4GLBKkjFhzsbFoSJaKzyX
   d5isfQtr/T1C2BxGE9e6l33hQNebo7K0+ZANdBnoqJajPxWhLNWn50r3J
   wBf3cd/iJsbcaslh+cOhFyZzVXKr+WycecQT+6eZ8Wqjp3nIyUxBLxQXy
   B71kxMWnfEL5+K4lLvyN4qd97U9mmf8bOC6vXKlZz1bA6z94qV6xLvORu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320799240"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320799240"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="660958585"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="660958585"
Received: from spal2-desk3.gar.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:41 -0700
Subject: [PATCH v2 16/21] cxl: Add latency and bandwidth calculations for the
 CXL path
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:45:41 -0700
Message-ID: <167995354137.2857312.1894822835758834110.stgit@djiang5-mobl3>
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

CXL Memory Device SW Guide rev1.0 2.11.2 provides instruction on how to
caluclate latency and bandwidth for CXL memory device. Calculate minimum
bandwidth and total latency for the path from the CXL device to the root
port. The retrieved QTG ID is stored to the cxl_port of the CXL device.

For example for a device that is directly attached to a host bus:
Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
		Latency + Generic Port Latency
Min Bandwidth = Min bandwidth for link bandwidth between HB
		and CXL device, device CDAT bandwidth, and Generic Port
		Bandwidth

For a device that has a switch in between host bus and CXL device:
Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
		Switch (CDAT) Latency + Switch to HB Link Latency +
		Generic Port Latency
Min Bandwidth = Min bandwidth for link bandwidth between CXL device
		to CXL switch, CXL device CDAT bandwidth, CXL switch CDAT
		bandwidth, CXL switch to HB bandwidth, and Generic Port
		Bandwidth.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlpci.h |    1 +
 drivers/cxl/port.c   |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 815bf843018e..8ed8dd6903e9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -119,6 +119,7 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	u64 qos[HMAT_SLLBIS_DATA_TYPE_MAX];
+	u16 qtg_id;
 };
 
 struct sslbis_entry {
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 7839e0244d0d..55517f6f5b84 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -67,6 +67,63 @@ static void dsmas_list_destroy(struct list_head *dsmas_list)
 	}
 }
 
+static int cxl_port_qos_calculate(struct cxl_port *port,
+				  struct list_head *dsmas_list)
+{
+	u64 sw_wr_bw, sw_wr_lat, sw_rd_bw, sw_rd_lat;
+	u64 min_rd_bw, total_rd_lat, min_wr_bw, total_wr_lat;
+	struct qtg_dsm_output *output;
+	struct qtg_dsm_input input;
+	struct dsmas_entry *dent;
+	acpi_handle handle;
+	u64 gp_bw, gp_lat;
+	u64 ds_bw, ds_lat;
+	int rc;
+
+	rc = cxl_port_get_downstream_qos(port, &ds_bw, &ds_lat);
+	if (rc)
+		return rc;
+
+	rc = cxl_port_get_switch_qos(port, &sw_rd_bw, &sw_rd_lat,
+				     &sw_wr_bw, &sw_wr_lat);
+	if (rc && rc != -ENOENT)
+		return rc;
+
+	rc = cxl_acpi_get_hb_qos(port->host_bridge, &gp_lat, &gp_bw);
+	if (rc)
+		return rc;
+
+	min_rd_bw = min_t(u64, ds_bw, sw_rd_bw);
+	min_rd_bw = min_t(u64, gp_bw, min_rd_bw);
+	total_rd_lat = ds_lat + gp_lat + sw_rd_lat;
+
+	min_wr_bw = min_t(u64, ds_bw, sw_wr_bw);
+	min_wr_bw = min_t(u64, gp_bw, min_wr_bw);
+	total_wr_lat = ds_lat + gp_lat + sw_wr_lat;
+
+	handle = cxl_acpi_get_rootdev_handle(&port->dev);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	list_for_each_entry(dent, dsmas_list, list) {
+		input.rd_lat = dent->qos[ACPI_HMAT_READ_LATENCY] + total_rd_lat;
+		input.wr_lat = dent->qos[ACPI_HMAT_WRITE_LATENCY] + total_wr_lat;
+		input.rd_bw = min_t(int, min_rd_bw,
+				    dent->qos[ACPI_HMAT_READ_BANDWIDTH]);
+		input.wr_bw = min_t(int, min_wr_bw,
+				    dent->qos[ACPI_HMAT_WRITE_BANDWIDTH]);
+
+		output = cxl_acpi_evaluate_qtg_dsm(handle, &input);
+		if (IS_ERR(output))
+			continue;
+
+		dent->qtg_id = output->qtg_ids[0];
+		kfree(output);
+	}
+
+	return 0;
+}
+
 static int cxl_switch_port_probe(struct cxl_port *port)
 {
 	struct cxl_hdm *cxlhdm;
@@ -162,6 +219,9 @@ static int cxl_port_probe(struct device *dev)
 				dev_warn(dev, "Failed to parse DSMAS: %d\n", rc);
 			}
 
+			rc = cxl_port_qos_calculate(port, &dsmas_list);
+			if (rc)
+				dev_dbg(dev, "Failed to do QoS calculations\n");
 			dsmas_list_destroy(&dsmas_list);
 		} else {
 			rc = cdat_table_parse_sslbis(port->cdat.table,


