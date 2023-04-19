Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07E6E8291
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjDSUZC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjDSUYw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:24:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC649DB;
        Wed, 19 Apr 2023 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935764; x=1713471764;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vp+p4HblP9sBBw/+5LSFYVT2ssf/OyRA47CRegfFGNM=;
  b=jvKOw2rnzeW2ILopJVNntRU/WvxyHaRnXhaTF5oz7uqKpK8eQgnk9sDS
   3DQP9homTgoTh9OeZci5CMgPBmaXCxo9tI9+Af3K76EfalTX580DmPcPT
   zF4hJcoJhcLR0ckfUOOIm8OM5H457iBaQ0qnJQDekHTpxBdYcajcekEL+
   xec/9O2zbItfE59TMDE4PTosjfnmR+tpBXPzGZZBWG51f0NFtlz8ZyLXS
   fQrqDoRcAhDaariBl5laXq15Kvh86HMhtK8KLIN+jlrroc1EBbUPuYcoY
   JM1eK0xBWI7YNRmW5rLvVWx5kW/nIEDe2HaY8bWIgGb4iXpnmXx4RyeZd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347408423"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="347408423"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="669112623"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="669112623"
Received: from jdgarvey-mobl.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:22:43 -0700
Subject: [PATCH v4 17/23] cxl: Add helper function to retrieve generic port
 QoS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:22:43 -0700
Message-ID: <168193576307.1178687.1764079544370063327.stgit@djiang5-mobl3>
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

Add CXL helper function that retrieves the bandwidth and latency data of a
generic port by calling acpi_get_genport_attrs() function. A device handle
is passed in constructed from the ACPI HID and UID of the CXL host bridge
(ACPI0016) device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/acpi.c |   30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
index 191644d0ca6d..41eeaa8c272e 100644
--- a/drivers/cxl/core/acpi.c
+++ b/drivers/cxl/core/acpi.c
@@ -148,3 +148,33 @@ struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);
+
+/**
+ * cxl_acpi_get_hb_qos - retrieve QoS data for generic port
+ * @host: 'struct device' of the CXL host bridge
+ * @latency: genport latency data
+ * @bandwidth: genport bandwidth data
+ *
+ * Return: Errno on failure, 0 on success.
+ */
+int cxl_acpi_get_hb_qos(struct device *host, u64 *latency, u64 *bandwidth)
+{
+	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
+	struct acpi_device *adev = ACPI_COMPANION(host);
+	int rc;
+
+	/* ACPI spec 6.5 Table 5.65 */
+	memcpy(handle, acpi_device_hid(adev), 8);
+	memcpy(&handle[8], acpi_device_uid(adev), 4);
+
+	rc = acpi_get_genport_attrs(handle, latency, ACPI_HMAT_ACCESS_LATENCY);
+	if (rc)
+		return rc;
+
+	rc = acpi_get_genport_attrs(handle, bandwidth, ACPI_HMAT_ACCESS_BANDWIDTH);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_acpi_get_hb_qos, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6a6387a545db..f9b9ce2e1647 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -813,6 +813,7 @@ int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
 			    u64 *wr_bw, u64 *wr_lat);
 int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
 				u64 *latency);
+int cxl_acpi_get_hb_qos(struct device *host, u64 *latency, u64 *bandwidth);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


