Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1DF756705
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jul 2023 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGQPBJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jul 2023 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjGQPBB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2023 11:01:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A74310C0
        for <linux-acpi@vger.kernel.org>; Mon, 17 Jul 2023 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689606061; x=1721142061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m1PZkm+J+sfu8/dx/yiU3qLbX3DK0bRFHAEtw3Th7Q4=;
  b=MHRTjyI+0cuJhJgetHTBIjeydz2U8ppyJmlQgIY7I/di9rn8x1lr0vpn
   PX/nIplYd7rRAvO9V+iRbAqgdF6dWu8tQVBMIuJop25DDJZNozwXD7ZkZ
   OWPueTGouB7MdcV39fEPZESJcTg6BMA8I+c++6wYc9KmptTOxYZJ6L+a1
   5nqjtEQQU+cfYAl6mHIqQUs1Fn7LcS+J8ob4SOGO/gxC86CK59vlJ0420
   6l2wgJFGAckfY7Q7hV/Y5MX/xIQ+Kd8Ak4lQnSUM5q1bwMxImKzyYbIFf
   zw3S84db4JrjbnSM901qaOQcLt/JqXOMmqNXo2yFea89St6d2pjaZcZFS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="345541894"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="345541894"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 08:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="726567364"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="726567364"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jul 2023 08:00:57 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, linux-acpi@vger.kernel.org
Cc:     robert.moore@intel.com, pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
Date:   Mon, 17 Jul 2023 17:00:45 +0200
Message-Id: <20230717150047.15196-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717150047.15196-1-cezary.rojewski@intel.com>
References: <20230717150047.15196-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While there is no strict limit to amount of NHLT tables present, usually
just the first one is utilized. To simplify implementation of sound
drivers, provide publicly accessible pointer. Accessing it after calling
acpi_nhlt_get_gbl_table() yields the first NHLT table met during the
scan.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/acpi/Kconfig  |  3 +++
 drivers/acpi/Makefile |  1 +
 drivers/acpi/nhlt.c   | 13 +++++++++++++
 include/acpi/nhlt.h   | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+)
 create mode 100644 drivers/acpi/nhlt.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccbeab9500ec..01ce5d3533db 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -594,6 +594,9 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ACPI_NHLT
+	bool
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index feb36c0b9446..8de34970e7db 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_ACPI)		+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
+obj-$(CONFIG_ACPI_NHLT)		+= nhlt.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa/
 obj-$(CONFIG_ACPI)		+= acpi_memhotplug.o
 obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
diff --git a/drivers/acpi/nhlt.c b/drivers/acpi/nhlt.c
new file mode 100644
index 000000000000..90d74d0d803e
--- /dev/null
+++ b/drivers/acpi/nhlt.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright(c) 2023 Intel Corporation. All rights reserved.
+//
+// Authors: Cezary Rojewski <cezary.rojewski@intel.com>
+//          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
+//
+
+#include <linux/export.h>
+#include <acpi/nhlt.h>
+
+struct acpi_table_nhlt *acpi_gbl_NHLT;
+EXPORT_SYMBOL_GPL(acpi_gbl_NHLT);
diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
index af3ec45ba4f9..a2b93b08218f 100644
--- a/include/acpi/nhlt.h
+++ b/include/acpi/nhlt.h
@@ -13,6 +13,24 @@
 #include <linux/overflow.h>
 #include <linux/types.h>
 
+/* System-wide pointer to the first NHLT table. */
+extern struct acpi_table_nhlt *acpi_gbl_NHLT;
+
+/*
+ * A sound driver may utilize the two below on its initialization and removal
+ * respectively to avoid excessive mapping and unmapping of the memory
+ * occupied by the table between streaming operations.
+ */
+static inline acpi_status acpi_nhlt_get_gbl_table(void)
+{
+	return acpi_get_table(ACPI_SIG_NHLT, 0, (struct acpi_table_header **)(&acpi_gbl_NHLT));
+}
+
+static inline void acpi_nhlt_put_gbl_table(void)
+{
+	acpi_put_table((struct acpi_table_header *)acpi_gbl_NHLT);
+}
+
 #define __acpi_nhlt_endpoint_cfg(ep)	((void *)((ep) + 1))
 
 /*
-- 
2.25.1

