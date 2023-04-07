Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926AC6DB14A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjDGRNG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDGRNF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:13:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9364C15;
        Fri,  7 Apr 2023 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887584; x=1712423584;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xb8LEuAAC0tQp/FGVl8tryrye56REhmRYVJtrAIZn4o=;
  b=OyWf9aCpO/sDDE39aJwqluudEvM6al5Ullhw5FrB9WGKgRVTiYXnKUvy
   pgD1vpLQYytqrumxpuqWAfj+iBbo87G1lGRcH6aKvBqc3xQGvn8k0Dy/H
   eg3XAeU0eQaPwy2+VdhRJqSv5hWSeG46g7N7Mvhg/cQMMkaTlr84I0wRt
   zADwqw68iEZF18CS/GUJ45RKq0WP2lUqntaHJNC6S2f+/47/xkYH/Xz1v
   4o/QwW+1rrguD5vKLuOjeqyZ1E4GfpGc6X1Kdw6AmK4PJMZO/1chd7wLQ
   tSwTLeET/G2y63FNOitaUkfj2eI8SFv5Wu3fvlhRyq6Ba2B/ZVhnb1odF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="344806211"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="344806211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="637766433"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="637766433"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:03 -0700
Subject: [PATCH 3 11/23] cxl: Add helper function that calculates QoS values
 for switches
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:02 -0700
Message-ID: <168088758261.1441063.10463189258856481896.stgit@djiang5-mobl3>
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

The CDAT information from the switch, Switch Scoped Latency and Bandwidth
Information Strucutre (SSLBIS), is parsed and stored in an xarray under the
cxl_port. The QoS data are indexed by the downstream port id.  Walk the CXL
ports from endpoint to root and retrieve the relevant QoS information
(bandwidth and latency) that are from the switch CDAT. If read or write QoS
values are not available, then use the access QoS value.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Move to use 'struct node_hmem_attrs'
---
 drivers/cxl/core/port.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    2 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8febb0a2d116..8f3bff6a3b3b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1945,6 +1945,87 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
 
+/**
+ * cxl_port_get_switch_qos - retrieve QoS data for CXL switches
+ * @port: endpoint cxl_port
+ * @rd_bw: writeback value for min read bandwidth
+ * @rd_lat: writeback value for total read latency
+ * @wr_bw: writeback value for min write bandwidth
+ * @wr_lat: writeback value for total write latency
+ *
+ * Return: Errno on failure, 0 on success. -ENOENT if no switch device
+ */
+int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
+			    u64 *wr_bw, u64 *wr_lat)
+{
+	u64 min_rd_bw = ULONG_MAX;
+	u64 min_wr_bw = ULONG_MAX;
+	struct cxl_dport *dport;
+	struct cxl_port *nport;
+	u64 total_rd_lat = 0;
+	u64 total_wr_lat = 0;
+	struct device *next;
+	int switches = 0;
+	int rc = 0;
+
+	if (!is_cxl_endpoint(port))
+		return -EINVAL;
+
+	/* Skip the endpoint */
+	next = port->dev.parent;
+	nport = to_cxl_port(next);
+	dport = port->parent_dport;
+
+	do {
+		struct node_hmem_attrs *hmem_attrs;
+		u64 lat, bw;
+
+		if (!nport->cdat.table)
+			break;
+
+		if (!dev_is_pci(dport->dport))
+			break;
+
+		hmem_attrs = xa_load(&nport->cdat.sslbis_xa, dport->port_id);
+		if (xa_is_err(hmem_attrs))
+			return xa_err(hmem_attrs);
+
+		if (!hmem_attrs) {
+			hmem_attrs = xa_load(&nport->cdat.sslbis_xa, SSLBIS_ANY_PORT);
+			if (xa_is_err(hmem_attrs))
+				return xa_err(hmem_attrs);
+			if (!hmem_attrs)
+				return -ENXIO;
+		}
+
+		bw = hmem_attrs->write_bandwidth;
+		lat = hmem_attrs->write_latency;
+		min_wr_bw = min_t(u64, min_wr_bw, bw);
+		total_wr_lat += lat;
+
+		bw = hmem_attrs->read_bandwidth;
+		lat = hmem_attrs->read_latency;
+		min_rd_bw = min_t(u64, min_rd_bw, bw);
+		total_rd_lat += lat;
+
+		dport = nport->parent_dport;
+		next = next->parent;
+		nport = to_cxl_port(next);
+		switches++;
+	} while (next);
+
+	*wr_bw = min_wr_bw;
+	*wr_lat = total_wr_lat;
+	*rd_bw = min_rd_bw;
+	*rd_lat = total_rd_lat;
+
+	if (!switches)
+		return -ENOENT;
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_get_switch_qos, CXL);
+
 /* for user tooling to ensure port disable work has completed */
 static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index dc6da641ced0..21e7c1f78f1f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -807,6 +807,8 @@ struct qtg_dsm_output {
 struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 						 struct qtg_dsm_input *input);
 acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
+int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
+			    u64 *wr_bw, u64 *wr_lat);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


