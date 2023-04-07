Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6E6DB148
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDGRMz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjDGRMx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:12:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9210AF3C;
        Fri,  7 Apr 2023 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887571; x=1712423571;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8t2nGx+s7JFBFfgM6MI1h6lYgxIWg/nxB+bI0TPO3rg=;
  b=J8RfdZYttyHnuZllX+od57YJr6gOi0DUaCfm/hjfmCNCeUuzOsHA2xTO
   83BKFbc/Ue0OZngeyQj0ioRcDNvDwkt53cTd3WZfzrbTudLWlh+yPuZgb
   ZmzjIF2OM0B4QR6n25Ey3suvd0eaQmIQ2AeQF4eHIwG/EbkeEmXKCBS32
   0wuRjrgWOSeUdzW720jivcrlsmGNfX//yeu3mmtqQXZYxraOOul5+1pJM
   ImZA6vwa83ZZnn3cRcn2y/yMq7Niy1Uy9aVadwkc09ke+S76NvPqtvGaG
   IH3yaYtWiKF5sDx5vDGzjmS6hW6wl0cdjO17dL0nUU0l/BrpyIAh+yN+f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="331684819"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="331684819"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681086999"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681086999"
Received: from rramanna-mobl1.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:12:50 -0700
Subject: [PATCH 3 09/23] cxl: Add helper function to retrieve ACPI handle of
 CXL root device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:12:50 -0700
Message-ID: <168088757032.1441063.11223896622367813193.stgit@djiang5-mobl3>
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


