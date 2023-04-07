Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F486DB151
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDGRNv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjDGRNu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:13:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED002729F;
        Fri,  7 Apr 2023 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887629; x=1712423629;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tEKgXBGrCQZJ5AH79Txb90f0fhtVQ6urF776D2C7YiY=;
  b=GmAL8DC5NXIXNy0b5o9QUAyZusagrJa0KJildkJSShj4O4/zGp8nvn6b
   jGIOc4RXGWHlcmP2TPqnYzSGhxvclsp7rrUoAWwuk3tA/M+V80e4e1BjQ
   D9zUPaY0oHRIoLR9M2zsJQ28R8X169Vt26hG4dAOeDZYkGMEdoOVmA9vz
   dfDh7/EXSQZMXgFNIAu6pSCFKKJLkUBsCfox99F1RSyEIYtVMV0aWGFn8
   Z84scGzgDKMoqraMRZJ8eTfLJ29kz6r1QjoV2m+o3DLClqBviIbXBrqno
   kzcqywxtd3bFP6pE/BmsfyBCliISO9P8psHG9kT+59IJ+d+loYNWVUs0W
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="345682060"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="345682060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="831251778"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="831251778"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:48 -0700
Subject: [PATCH 3 18/23] cxl: Add latency and bandwidth calculations for the
 CXL path
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:47 -0700
Message-ID: <168088762770.1441063.9693855327937653263.stgit@djiang5-mobl3>
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
 drivers/cxl/port.c   |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 795eba31fe29..ff4c2d10ca4a 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -120,6 +120,7 @@ struct dsmas_entry {
 	struct range dpa_range;
 	u8 handle;
 	struct node_hmem_attrs hmem_attrs;
+	u16 qtg_id;
 };
 
 /* Sub-table 0: Device Scoped Memory Affinity Structure (DSMAS) */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 164383ed5b7a..dad5258b4604 100644
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
+		input.rd_lat = dent->hmem_attrs.read_latency + total_rd_lat;
+		input.wr_lat = dent->hmem_attrs.write_latency + total_wr_lat;
+		input.rd_bw = min_t(int, min_rd_bw,
+				    dent->hmem_attrs.read_bandwidth);
+		input.wr_bw = min_t(int, min_wr_bw,
+				    dent->hmem_attrs.write_bandwidth);
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
@@ -165,6 +222,10 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 			dev_warn(&port->dev, "Failed to parse DSMAS: %d\n", rc);
 		}
 
+		rc = cxl_port_qos_calculate(port, &dsmas_list);
+		if (rc)
+			dev_dbg(&port->dev, "Failed to do QoS calculations\n");
+
 		dsmas_list_destroy(&dsmas_list);
 	}
 


