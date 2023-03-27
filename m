Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082FC6CB0E6
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjC0Vp3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjC0VpM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:45:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6C2696;
        Mon, 27 Mar 2023 14:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953511; x=1711489511;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QgESBbS9QqBtr+VC0tuT/jXrT/nLMzpw2FMu9iOcnoI=;
  b=aRPHY/kJ6OX40VKNr9emd/qe3PIgnVTgdsNF2iZ2Z74p9nRA5pK3dXoB
   rRmk6m8ZQOIGW+5Ao9q9Ta48GPRWW3NenO16FxIR8MtPbD//hLNZPaq7F
   O5xRJ4w61LocQgomv4f5V6dMtx7wX8hBXVivV3McQzwugOMOd7tJGWo+A
   Z7vQI3pgOB+WWaqR0Fk2lr1sUayNNBtE8tNmduIXqrdwJNfynjByP8u8a
   gEjU+u7ceYXwv6z0wiefJXUY6GATc7LcGyGqzykCCw6/Rt7D9YsQgK83N
   w7cG1opMWekXyQNQl5BgIR+GrKuhBr+GChqnIAMp2dgWnT8OwAKJdHIwG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337899975"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337899975"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686114752"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686114752"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:11 -0700
Subject: [PATCH v2 11/21] cxl: Add helper function that calculates QoS values
 for switches
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:45:10 -0700
Message-ID: <167995351086.2857312.5620998796872386187.stgit@djiang5-mobl3>
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

The CDAT information from the switch, Switch Scoped Latency and Bandwidth
Information Strucutre (SSLBIS), is parsed and stored in an xarray under the
cxl_port. The QoS data are indexed by the downstream port id.  Walk the CXL
ports from endpoint to root and retrieve the relevant QoS information
(bandwidth and latency) that are from the switch CDAT. If read or write QoS
values are not available, then use the access QoS value.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    2 +
 2 files changed, 91 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a61f9395a209..6e2f8e40757e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1945,6 +1945,95 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
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
+		struct sslbis_entry *sentry;
+		u64 lat, bw;
+
+		if (!nport->cdat.table)
+			break;
+
+		if (!dev_is_pci(dport->dport))
+			break;
+
+		sentry = xa_load(&nport->cdat.sslbis_xa, dport->port_id);
+		if (xa_is_err(sentry))
+			return xa_err(sentry);
+
+		if (!sentry) {
+			sentry = xa_load(&nport->cdat.sslbis_xa, SSLBIS_ANY_PORT);
+			if (xa_is_err(sentry))
+				return xa_err(sentry);
+			if (!sentry)
+				return -ENXIO;
+		}
+
+		bw = sentry->qos[HMAT_SLLBIS_WRITE_BANDWIDTH];
+		if (!bw)
+			bw = sentry->qos[HMAT_SLLBIS_ACCESS_BANDWIDTH];
+		lat = sentry->qos[HMAT_SLLBIS_WRITE_LATENCY];
+		if (!lat)
+			lat = sentry->qos[HMAT_SLLBIS_ACCESS_LATENCY];
+		min_wr_bw = min_t(u64, min_wr_bw, bw);
+		total_wr_lat += lat;
+
+		bw = sentry->qos[HMAT_SLLBIS_READ_BANDWIDTH];
+		if (!bw)
+			bw = sentry->qos[HMAT_SLLBIS_ACCESS_BANDWIDTH];
+		lat = sentry->qos[HMAT_SLLBIS_READ_LATENCY];
+		if (!lat)
+			lat = sentry->qos[HMAT_SLLBIS_ACCESS_LATENCY];
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


