Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584AC750213
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 10:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjGLIxv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 04:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGLIxs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 04:53:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A1FB
        for <linux-acpi@vger.kernel.org>; Wed, 12 Jul 2023 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689152022; x=1720688022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m1PZkm+J+sfu8/dx/yiU3qLbX3DK0bRFHAEtw3Th7Q4=;
  b=F+qeRGF9AlBx/fslyJtYQSLQL+yW10oCdaBqOEE0x4xbWXDOWGIuAt2Q
   3YvVlvjKXF0VwGLRZcyMUkf5ddU+KrdQcsCaSAl7+UAITBogZCYCXzVBd
   3XRVqJwzF6qLte8wgaah4pXJdSLjZF966G9PyqMXJznv1LnxLGER5RkE8
   PgFrSoguJsqvwnRLi9TS8/RjNGCE4xk1Z8UBaSmibiFNB0VKBCaFh/kOB
   yKlhRjN8O4gr7Ovuv/CIP/w3OpMhQmvEm7X6rooFOJECctH/+zKhcMZGD
   2j2Y2GeNVc6zk0p4sH9cgI/NQmx1UqQqGh7ombnDsDn4k9tEq+Aa4J/MG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="363704588"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="363704588"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 01:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="724798344"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="724798344"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 01:53:25 -0700
From:   Cezary Rojewski <cezary.rojewski@intel.com>
To:     rafael@kernel.org, linux-acpi@vger.kernel.org
Cc:     robert.moore@intel.com, erik.kaneda@intel.com,
        pierre-louis.bossart@linux.intel.com,
        amadeuszx.slawinski@linux.intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/4] ACPI: NHLT: Introduce acpi_gbl_NHLT
Date:   Wed, 12 Jul 2023 11:10:46 +0200
Message-Id: <20230712091048.2545319-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712091048.2545319-1-cezary.rojewski@intel.com>
References: <20230712091048.2545319-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

