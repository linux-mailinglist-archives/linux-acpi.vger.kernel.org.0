Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8356CB0E1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Mar 2023 23:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjC0Vp2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Mar 2023 17:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0VpA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Mar 2023 17:45:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415FF26AA;
        Mon, 27 Mar 2023 14:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679953500; x=1711489500;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8t2nGx+s7JFBFfgM6MI1h6lYgxIWg/nxB+bI0TPO3rg=;
  b=dd9j2oCV42Vd50XRQbLlPSqyOT00MErH2ujqV3nCC9/Ng6uepjWB3+uF
   tAqvABXgh51BqDrtTjrP0Gcy001ptocu8Ldg+ettrLxipPCJF3BPhH3/W
   FadYBJpaa1iwq0biuB5zsAlb9LbhAqDRy4hNpKjc5PjguMZkEIIBJFP9i
   l0VQWx3vIPNzlyUZiE/0YIh/JRJ/FppxcP+/3vU9m+kMKieAT4i01AtO0
   gf3eS8Vp8Oz46PzmA5INhqoDL8HGnA+5YtYSF1bc028YRl1BSE7qQi9XA
   b4CpIpLAe9qWLPAyjqLpCht+Fq6xpS7E4Yybz3JJuEn91d0aK/oE+c/tJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337899921"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="337899921"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="686114689"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="686114689"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.91.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 14:44:59 -0700
Subject: [PATCH v2 09/21] cxl: Add helper function to retrieve ACPI handle of
 CXL root device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de
Date:   Mon, 27 Mar 2023 14:44:59 -0700
Message-ID: <167995349900.2857312.16120678350775837497.stgit@djiang5-mobl3>
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

Provide a helper to find the ACPI0017 device in order to issue the _DSM.
The helper will take the 'struct device' from a cxl_port and iterate until
the root device is reached. The ACPI handle will be returned from the root
device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Fix commenting style. (Jonathan)
- Fix var declaration aligning. (Jonathan)
---
 drivers/cxl/core/acpi.c |   34 ++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
index 6eda5cad8d59..191644d0ca6d 100644
--- a/drivers/cxl/core/acpi.c
+++ b/drivers/cxl/core/acpi.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <asm/div64.h>
 #include "cxlpci.h"
 #include "cxl.h"
@@ -13,6 +14,39 @@ const guid_t acpi_cxl_qtg_id_guid =
 	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
 		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
 
+/**
+ * cxl_acpi_get_rootdev_handle - get the ACPI handle of the CXL root device
+ * @dev: 'struct device' to start searching from. Should be from cxl_port->dev.
+ *
+ * Return: acpi_handle on success, errptr of errno on error.
+ *
+ * Looks for the ACPI0017 device and return the ACPI handle
+ **/
+acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev)
+{
+	struct device *itr = dev;
+	struct device *root_dev;
+	acpi_handle handle;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	while (itr->parent) {
+		root_dev = itr;
+		itr = itr->parent;
+	}
+
+	if (!dev_is_platform(root_dev))
+		return ERR_PTR(-ENODEV);
+
+	handle = ACPI_HANDLE(root_dev);
+	if (!handle)
+		return ERR_PTR(-ENODEV);
+
+	return handle;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_acpi_get_rootdev_handle, CXL);
+
 /**
  * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
  * @handle: ACPI handle
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 04b8a032bd14..dc6da641ced0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -806,6 +806,7 @@ struct qtg_dsm_output {
 
 struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 						 struct qtg_dsm_input *input);
+acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


