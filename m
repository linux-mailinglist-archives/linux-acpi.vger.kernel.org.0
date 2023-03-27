Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086F06CB0ED
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjC0VqB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjC0Vpw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:45:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF7C2D63;
        Mon, 27 Mar 2023 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953537; x=1711489537;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3D19eVA6StizRDQ3Hc2AQXS3EISK8uXQhS4ITUho+hg=;
  b=l4w31YNRE/cXhbYCdh7MWXIry/7wpTK9Z+1CdU/1DHqNDNeb5edSUx9K
   5PGAQDiEeZl+nd/rHif4v64yiEmPCgcD8dHn/r5FaH87QgQ9HMsHkFhDP
   +nPOWLvb8dAtTU4EzW1lcU21V0uGotPXJvt1C1xnNMKYdXDAMw/E21d5z
   KJKgnifKlcYijfiFmQ+LmiJ4q4f25oNJ81QKLBXk0LcCCZW/WqByDbtlB
   L4q3oS7dtfm5Yo1pW44jocMsrAwgqNvY44CijX7PNBoGFXWDtmD2heZQK
   90+WobnW7cbDz5i6r/vS/1THPDvWkk9Ru+qKEkf2/NpK5BnPFkC6E75q9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="320799140"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="320799140"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="660958536"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="660958536"
Received: from spal2-desk3.gar.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:35 -0700
Subject: [PATCH v2 15/21] cxl: Add helper function to retrieve generic port
 QoS
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:45:35 -0700
Message-ID: <167995353515.2857312.6918225718341979725.stgit@djiang5-mobl3>
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
index 67e844645ef6..56bcf144eede 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -811,6 +811,7 @@ int cxl_port_get_switch_qos(struct cxl_port *port, u64 *rd_bw, u64 *rd_lat,
 			    u64 *wr_bw, u64 *wr_lat);
 int cxl_port_get_downstream_qos(struct cxl_port *port, u64 *bandwidth,
 				u64 *latency);
+int cxl_acpi_get_hb_qos(struct device *host, u64 *latency, u64 *bandwidth);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


