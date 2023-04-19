Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583FA6E8289
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 22:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjDSUYE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 16:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjDSUWD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 16:22:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632425FD2;
        Wed, 19 Apr 2023 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681935722; x=1713471722;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X0GWJLE9JeAutu840OZai68gJ1BiJ2lE2kdtgKExoMo=;
  b=GA6YGQCeAGHURhcjb6d9Pf/aRBBW5QUf4W2sh3DVi1L6mEgBU8j7n+JW
   26mARNw8Bx4ctBViwjwWiHGMsQl2X+wbMH+x9+rI9mcV4PD+8Opr8lZT/
   nzzNvnX/q7nI0BwF7GJ6OpXM9/2uB5P7mh9xdMyIt1/tqpYiAtfmz0MFo
   gHteVaoggJ5TSda0Bf1vP2bumZ6FSBtdj3DNekKgVs0OIomtvWdbKl78q
   XSIBTqckdP9kHvtlrznCrSUu5egH4UMUSJccjDP9i8DGmNU8AzOh+NJVy
   e9UTVzSgSFyDC4wtfbt0Oqq/14FArpHl/w4ucv74MqHUWadhsGPVLMQru
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="373441402"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="373441402"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="1021337017"
X-IronPort-AV: E=Sophos;i="5.99,210,1677571200"; 
   d="scan'208";a="1021337017"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.179.6])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 13:21:56 -0700
Subject: [PATCH v4 09/23] cxl: Add helper function to retrieve ACPI handle of
 CXL root device
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Wed, 19 Apr 2023 13:21:55 -0700
Message-ID: <168193571575.1178687.18078745201457493723.stgit@djiang5-mobl3>
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
index 6426c4c22e28..d7c1410a437c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -808,6 +808,7 @@ struct qtg_dsm_output {
 
 struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
 						 struct qtg_dsm_input *input);
+acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version


