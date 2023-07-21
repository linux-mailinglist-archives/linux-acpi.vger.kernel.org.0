Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C975CC69
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGUPsz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGUPsy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 11:48:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AA31BD
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689954533; x=1721490533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LZJu3jvoTsXJwtvaVYECY5sp0CgYqMoY47klmAFc7Q0=;
  b=htZqf5TvgGSNwMHt0cv3EoRIWWhEb0a1ZXML34p/x3/enBLOgNED3FZM
   OJsSmx4TW1UGwPF3X996iUUgOdy4jK8sKKsAMNFIHghF4ITUnV9GCURcu
   mQaN35CJnn0azVZD8FcNCR/kM37tWuUeutAc8noNnvv/wEa1fSukeNOIq
   PLFMavwBTrOgdAsxCBF9mem1ZZg0n0Ka3HZ2ZEUtULycucs0o4h/dExJ9
   ubZCbvhp0yYohSsyoNb7X/EgjboPDjQBQZC8TjF8eZIU5bPBC2o2GQrzV
   X7rKt/E40YoVpxq36N5wlhwho2CD4si7mlyAH2m8SmlnAVIGGrq558AtN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357043528"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357043528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:48:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="868275331"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2023 08:48:52 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, robert.moore@intel.com,
        amadeuszx.slawinski@linux.intel.com,
        andriy.shevchenko@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v4 2/4] ACPI: NHLT: Introduce acpi_gbl_nhlt
Date:   Fri, 21 Jul 2023 17:48:11 +0200
Message-Id: <20230721154813.310996-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721154813.310996-1-cezary.rojewski@intel.com>
References: <20230721154813.310996-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 drivers/acpi/Kconfig  |  3 +++
 drivers/acpi/Makefile |  1 +
 drivers/acpi/nhlt.c   | 47 +++++++++++++++++++++++++++++++++++++++++++
 include/acpi/nhlt.h   | 30 +++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 drivers/acpi/nhlt.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccbeab9500ec..10c16b82a391 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -101,6 +101,9 @@ config ACPI_LPIT
 	depends on X86_64
 	default y
 
+config ACPI_NHLT
+	bool
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
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
index 000000000000..18b2f3752840
--- /dev/null
+++ b/drivers/acpi/nhlt.c
@@ -0,0 +1,47 @@
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
+struct acpi_table_nhlt *acpi_gbl_nhlt;
+EXPORT_SYMBOL_GPL(acpi_gbl_nhlt);
+
+static struct acpi_table_nhlt empty_nhlt = {
+	.header = {
+		.signature = ACPI_SIG_NHLT,
+	},
+};
+
+/**
+ * acpi_nhlt_get_gbl_table - Retrieve a pointer to the first NHLT table.
+ *
+ * If there is no NHLT in the system, acpi_gbl_nhlt will instead point to an
+ * empty table.
+ *
+ * Return: ACPI status code of the operation.
+ */
+acpi_status acpi_nhlt_get_gbl_table(void)
+{
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_NHLT, 0, (struct acpi_table_header **)(&acpi_gbl_nhlt));
+	if (!acpi_gbl_nhlt)
+		acpi_gbl_nhlt = &empty_nhlt;
+	return status;
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_get_gbl_table);
+
+/**
+ * acpi_nhlt_put_gbl_table - Release the global NHLT table.
+ */
+void acpi_nhlt_put_gbl_table(void)
+{
+	acpi_put_table((struct acpi_table_header *)acpi_gbl_nhlt);
+}
+EXPORT_SYMBOL_GPL(acpi_nhlt_put_gbl_table);
diff --git a/include/acpi/nhlt.h b/include/acpi/nhlt.h
index af3ec45ba4f9..e68e0534412d 100644
--- a/include/acpi/nhlt.h
+++ b/include/acpi/nhlt.h
@@ -63,4 +63,34 @@
 	__cfg->capabilities_size == struct_size(__cfg, mics, __cfg->num_mics) ?		\
 		__cfg : NULL; })
 
+#if IS_ENABLED(CONFIG_ACPI_NHLT)
+
+/*
+ * System-wide pointer to the first NHLT table.
+ *
+ * A sound driver may utilize acpi_nhlt_get/put_gbl_table() on its
+ * initialization and removal respectively to avoid excessive mapping
+ * and unmapping of the memory occupied by the table between streaming
+ * operations.
+ */
+extern struct acpi_table_nhlt *acpi_gbl_nhlt;
+
+acpi_status acpi_nhlt_get_gbl_table(void);
+void acpi_nhlt_put_gbl_table(void);
+
+#else /* !CONFIG_ACPI_NHLT */
+
+#define acpi_gbl_nhlt	NULL
+
+static inline acpi_status acpi_nhlt_get_gbl_table(void)
+{
+	return AE_NOT_FOUND;
+}
+
+static inline void acpi_nhlt_put_gbl_table(void)
+{
+}
+
+#endif /* CONFIG_ACPI_NHLT */
+
 #endif /* __ACPI_NHLT_H__ */
-- 
2.25.1

