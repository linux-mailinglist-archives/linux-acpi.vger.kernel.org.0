Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF65A75C382
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjGUJsv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGUJsY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 05:48:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A730E4
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689932869; x=1721468869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qtiLhsf1muF68bUesmkIPwplSyQK7i0TnEuGTR4VegA=;
  b=Omn+01MrV9rnRUzPNWxtNo8BzAhHTKV8+E7ZKIb9Z9ER3xoW4UQMMDpG
   IRofGlrHgGaQmr+OrNrBVTouElUHLk0BxyvACczRl9PBtwLUd/83NtIAP
   zU9fsn7SdRqEAgMpL7zbPVH1SgURCN+mQImMes5hv28dH01wJO+1WUZ9w
   LhiYxBCYURw/iAuD1kZo9FV5elPicrLYMQ9/elIkMW0CrUTXHEHVofaE6
   SphCRlEE5z+VE1gRk5zWI+qYjWZ+F9mBb3kgfIrdKXxBh39M/tDnV1MU7
   bksCPZw4OKfIrevtBgRlUfV2mW3+PCelhuRyVl2+909uEgNieNUFyErwP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367022168"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367022168"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 02:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="1055508027"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055508027"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 02:47:31 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, robert.moore@intel.com
Cc:     linux-acpi@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v3 1/4] ACPI: NHLT: Device configuration access interface
Date:   Fri, 21 Jul 2023 11:47:19 +0200
Message-Id: <20230721094722.300586-2-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721094722.300586-1-cezary.rojewski@intel.com>
References: <20230721094722.300586-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Device configuration structures are plenty so declare a struct for each
known variant. As neither of them shall be accessed without verifying
the memory block first, introduce macros to make it easy to do so.

Link: https://github.com/acpica/acpica/pull/881
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 include/acpi/actbl2.h | 28 ++++++++++++++++++
 include/acpi/nhlt.h   | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)
 create mode 100644 include/acpi/nhlt.h

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0029336775a9..c4c9a3a89ba6 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -2014,6 +2014,25 @@ struct acpi_nhlt_vendor_mic_count {
 	u8 microphone_count;
 };
 
+/* The only guaranteed configuration space header. Any other requires validation. */
+struct acpi_nhlt_cfg {
+	u32 capabilities_size;
+	u8 capabilities[];
+};
+
+struct acpi_nhlt_devcfg {
+	u32 capabilities_size;
+	u8 virtual_slot;
+	u8 config_type;
+};
+
+struct acpi_nhlt_mic_devcfg {
+	u32 capabilities_size;
+	u8 virtual_slot;
+	u8 config_type;
+	u8 array_type;
+};
+
 struct acpi_nhlt_vendor_mic_config {
 	u8 type;
 	u8 panel;
@@ -2030,6 +2049,15 @@ struct acpi_nhlt_vendor_mic_config {
 	u16 work_horizontal_angle_end;	/* -180 - + 180 with 2 deg step */
 };
 
+struct acpi_nhlt_vendor_mic_devcfg {
+	u32 capabilities_size;
+	u8 virtual_slot;
+	u8 config_type;
+	u8 array_type;
+	u8 num_mics;
+	struct acpi_nhlt_vendor_mic_config mics[];
+};
+
 /* Values for Type field above */
 
 #define ACPI_NHLT_MIC_OMNIDIRECTIONAL       0
diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
new file mode 100644
index 000000000000..af3ec45ba4f9
--- /dev/null
+++ b/include/acpi/nhlt.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright(c) 2023 Intel Corporation. All rights reserved.
+ *
+ * Authors: Cezary Rojewski <cezary.rojewski@intel.com>
+ *          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
+ */
+
+#ifndef __ACPI_NHLT_H__
+#define __ACPI_NHLT_H__
+
+#include <linux/acpi.h>
+#include <linux/overflow.h>
+#include <linux/types.h>
+
+#define __acpi_nhlt_endpoint_cfg(ep)	((void *)((ep) + 1))
+
+/*
+ * As device configuration spaces present in NHLT tables around the world are
+ * not following single pattern, first check if 'capabilities_size' is correct
+ * in respect to size of the specified space type before returning the pointer.
+ */
+#define __acpi_nhlt_endpoint_devcfg(ep, type) ({				\
+	struct acpi_nhlt_cfg *__cfg = __acpi_nhlt_endpoint_cfg(ep);		\
+	__cfg->capabilities_size >= sizeof(type) ?				\
+		((type *)__cfg) : NULL; })
+
+/*
+ * acpi_nhlt_endpoint_devcfg - Test and access device configuration.
+ * @ep:		endpoint for which to retrieve device configuration.
+ *
+ * Return: A pointer to device configuration space or NULL if the space's
+ * 'capabilities_size' is insufficient to cover the nested structure.
+ */
+#define acpi_nhlt_endpoint_devcfg(ep) \
+	__acpi_nhlt_endpoint_devcfg(ep, struct acpi_nhlt_devcfg)
+
+/*
+ * acpi_nhlt_endpoint_mic_devcfg - Test and access device configuration.
+ * @ep:		endpoint for which to retrieve device configuration.
+ *
+ * Return: A pointer to device configuration space or NULL if the space's
+ * 'capabilities_size' is insufficient to cover the nested structure.
+ */
+#define acpi_nhlt_endpoint_mic_devcfg(ep) \
+	__acpi_nhlt_endpoint_devcfg(ep, struct acpi_nhlt_mic_devcfg)
+
+/*
+ * acpi_nhlt_endpoint_vendor_mic_devcfg - Test and access device configuration.
+ * @ep:		endpoint for which to retrieve device configuration.
+ * @ptr:	pointer to a device configuration structure.
+ *
+ * This is the same as acpi_nhlt_endpoint_devcfg(), except that it verifies
+ * if size of the flexible array following the structure header is also
+ * reflected in 'capabilities_size'.
+ *
+ * Return: A pointer to device configuration space or NULL if the space's
+ * 'capabilities_size' is insufficient to cover the nested structure.
+ */
+#define acpi_nhlt_endpoint_vendor_mic_devcfg(ep) ({					\
+	struct acpi_nhlt_vendor_mic_devcfg *__cfg = __acpi_nhlt_endpoint_cfg(ep);	\
+	__cfg->capabilities_size >= sizeof(*__cfg) &&					\
+	__cfg->capabilities_size == struct_size(__cfg, mics, __cfg->num_mics) ?		\
+		__cfg : NULL; })
+
+#endif /* __ACPI_NHLT_H__ */
-- 
2.25.1

