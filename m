Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10BC496A4F
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jan 2022 06:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbiAVF0h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Jan 2022 00:26:37 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52080 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230287AbiAVF0h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 22 Jan 2022 00:26:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V2UlMIQ_1642829189;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0V2UlMIQ_1642829189)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Jan 2022 13:26:31 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     helgaas@kernel.org, rafael@kernel.org
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        xueshuai@linux.alibaba.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 1/2] ACPI: APEI: explicit init HEST and GHES in apci_init
Date:   Sat, 22 Jan 2022 13:26:17 +0800
Message-Id: <20220122052618.1074-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
the estatus memory pool. On the other hand, ghes_init() relies on
sdei_init() to detect the SDEI version and (un)register events. The
dependencies are as follows:

    ghes_init() => acpi_hest_init() => acpi_bus_init() => acpi_init()
    ghes_init() => sdei_init()

HEST is not PCI-specific and initcall ordering is implicit and not
well-defined within a level.

Based on above, remove acpi_hest_init() from acpi_pci_root_init() and
convert ghes_init() and sdei_init() from initcalls to explicit calls in the
following order:

    acpi_hest_init()
    ghes_init()
        sdei_init()

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c    | 19 ++++++++-----------
 drivers/acpi/bus.c          |  2 ++
 drivers/acpi/pci_root.c     |  3 ---
 drivers/firmware/Kconfig    |  1 +
 drivers/firmware/arm_sdei.c | 13 ++-----------
 include/acpi/apei.h         |  4 +++-
 include/linux/arm_sdei.h    |  2 ++
 7 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0c5c9acc6254..aadc0a972f18 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1457,33 +1457,35 @@ static struct platform_driver ghes_platform_driver = {
 	.remove		= ghes_remove,
 };
 
-static int __init ghes_init(void)
+void __init ghes_init(void)
 {
 	int rc;
 
+	sdei_init();
+
 	if (acpi_disabled)
-		return -ENODEV;
+		return;
 
 	switch (hest_disable) {
 	case HEST_NOT_FOUND:
-		return -ENODEV;
+		return;
 	case HEST_DISABLED:
 		pr_info(GHES_PFX "HEST is not enabled!\n");
-		return -EINVAL;
+		return;
 	default:
 		break;
 	}
 
 	if (ghes_disable) {
 		pr_info(GHES_PFX "GHES is not enabled!\n");
-		return -EINVAL;
+		return;
 	}
 
 	ghes_nmi_init_cxt();
 
 	rc = platform_driver_register(&ghes_platform_driver);
 	if (rc)
-		goto err;
+		return;
 
 	rc = apei_osc_setup();
 	if (rc == 0 && osc_sb_apei_support_acked)
@@ -1494,9 +1496,4 @@ static int __init ghes_init(void)
 		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
 	else
 		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
-
-	return 0;
-err:
-	return rc;
 }
-device_initcall(ghes_init);
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 07f604832fd6..3f403db20f69 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1331,6 +1331,8 @@ static int __init acpi_init(void)
 
 	pci_mmcfg_late_init();
 	acpi_iort_init();
+	acpi_hest_init();
+	ghes_init();
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index b76db99cced3..6f9e75d14808 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -22,8 +22,6 @@
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/platform_data/x86/apple.h>
-#include <acpi/apei.h>	/* for acpi_hest_init() */
-
 #include "internal.h"
 
 #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
@@ -943,7 +941,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 
 void __init acpi_pci_root_init(void)
 {
-	acpi_hest_init();
 	if (acpi_pci_disabled)
 		return;
 
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 75cb91055c17..ad114d9cdf8e 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -40,6 +40,7 @@ config ARM_SCPI_POWER_DOMAIN
 config ARM_SDE_INTERFACE
 	bool "ARM Software Delegated Exception Interface (SDEI)"
 	depends on ARM64
+	select ACPI_APEI_GHES
 	help
 	  The Software Delegated Exception Interface (SDEI) is an ARM
 	  standard for registering callbacks from the platform firmware
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index a7e762c352f9..1e1a51510e83 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1059,14 +1059,14 @@ static bool __init sdei_present_acpi(void)
 	return true;
 }
 
-static int __init sdei_init(void)
+void __init sdei_init(void)
 {
 	struct platform_device *pdev;
 	int ret;
 
 	ret = platform_driver_register(&sdei_driver);
 	if (ret || !sdei_present_acpi())
-		return ret;
+		return;
 
 	pdev = platform_device_register_simple(sdei_driver.driver.name,
 					       0, NULL, 0);
@@ -1076,17 +1076,8 @@ static int __init sdei_init(void)
 		pr_info("Failed to register ACPI:SDEI platform device %d\n",
 			ret);
 	}
-
-	return ret;
 }
 
-/*
- * On an ACPI system SDEI needs to be ready before HEST:GHES tries to register
- * its events. ACPI is initialised from a subsys_initcall(), GHES is initialised
- * by device_initcall(). We want to be called in the middle.
- */
-subsys_initcall_sync(sdei_init);
-
 int sdei_event_handler(struct pt_regs *regs,
 		       struct sdei_registered_event *arg)
 {
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index ece0a8af2bae..4e60dd73c3bb 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -27,14 +27,16 @@ extern int hest_disable;
 extern int erst_disable;
 #ifdef CONFIG_ACPI_APEI_GHES
 extern bool ghes_disable;
+void __init ghes_init(void);
 #else
 #define ghes_disable 1
+static inline void ghes_init(void) { }
 #endif
 
 #ifdef CONFIG_ACPI_APEI
 void __init acpi_hest_init(void);
 #else
-static inline void acpi_hest_init(void) { return; }
+static inline void acpi_hest_init(void) { }
 #endif
 
 int erst_write(const struct cper_record_header *record);
diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
index 0a241c5c911d..14dc461b0e82 100644
--- a/include/linux/arm_sdei.h
+++ b/include/linux/arm_sdei.h
@@ -46,9 +46,11 @@ int sdei_unregister_ghes(struct ghes *ghes);
 /* For use by arch code when CPU hotplug notifiers are not appropriate. */
 int sdei_mask_local_cpu(void);
 int sdei_unmask_local_cpu(void);
+void __init sdei_init(void);
 #else
 static inline int sdei_mask_local_cpu(void) { return 0; }
 static inline int sdei_unmask_local_cpu(void) { return 0; }
+static inline void sdei_init(void) { }
 #endif /* CONFIG_ARM_SDE_INTERFACE */
 
 
-- 
2.20.1.12.g72788fdb

