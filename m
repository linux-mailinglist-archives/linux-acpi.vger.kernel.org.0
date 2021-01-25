Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DD302BDF
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbhAYTl5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 14:41:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:32937 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbhAYTlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:52 -0500
IronPort-SDR: raxHeuFMUaIXIjX7ehKUPojwDimC0iXbfrQUE3IIdkAkQJSMv4d8zY6R6QpVGzHTylg24ySrkO
 naJ46UZ8SjaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159564604"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="159564604"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:58 -0800
IronPort-SDR: f9en5d6H7gdcJsZsuCGmQSuI/RJgvD0KKaPFjgFkMinrOGMQaPH8cCQ6t0SHBWvmsRClvFLFnX
 1V79xmKa35Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="472462796"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jan 2021 11:39:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF8F5413; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 07/10] x86/platform/intel-mid: Remove unused leftovers (msic)
Date:   Mon, 25 Jan 2021 21:39:45 +0200
Message-Id: <20210125193948.56760-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no driver present, remove the device creation and other leftovers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/x86/include/asm/intel-mid.h              |  7 --
 .../platform/intel-mid/device_libs/Makefile   |  2 -
 .../intel-mid/device_libs/platform_msic.c     | 83 -------------------
 .../intel-mid/device_libs/platform_msic.h     | 15 ----
 arch/x86/platform/intel-mid/sfi.c             |  7 --
 5 files changed, 114 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic.h

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index cf0e25f45422..e68ae2155db3 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -37,7 +37,6 @@ struct devs_id {
 	char name[SFI_NAME_LEN + 1];
 	u8 type;
 	u8 delay;
-	u8 msic;
 	void *(*get_platform_data)(void *info);
 };
 
@@ -83,18 +82,12 @@ static inline enum intel_mid_cpu_type intel_mid_identify_cpu(void)
 	return __intel_mid_cpu_chip;
 }
 
-static inline bool intel_mid_has_msic(void)
-{
-	return (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_PENWELL);
-}
-
 extern void intel_scu_devices_create(void);
 extern void intel_scu_devices_destroy(void);
 
 #else /* !CONFIG_X86_INTEL_MID */
 
 #define intel_mid_identify_cpu()	0
-#define intel_mid_has_msic()		0
 
 static inline void intel_scu_devices_create(void) { }
 static inline void intel_scu_devices_destroy(void) { }
diff --git a/arch/x86/platform/intel-mid/device_libs/Makefile b/arch/x86/platform/intel-mid/device_libs/Makefile
index 4e4db0c2b225..4d008b053ac8 100644
--- a/arch/x86/platform/intel-mid/device_libs/Makefile
+++ b/arch/x86/platform/intel-mid/device_libs/Makefile
@@ -6,8 +6,6 @@ obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI)) += platform_mrfld_sd.o
 # WiFi + BT
 obj-$(subst m,y,$(CONFIG_BRCMFMAC_SDIO)) += platform_bcm43xx.o
 obj-$(subst m,y,$(CONFIG_BT_HCIUART_BCM)) += platform_bt.o
-# IPC Devices
-obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic.o
 # SPI Devices
 obj-$(subst m,y,$(CONFIG_SPI_SPIDEV)) += platform_mrfld_spidev.o
 # I2C Devices
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_msic.c b/arch/x86/platform/intel-mid/device_libs/platform_msic.c
deleted file mode 100644
index b17783d0d4e7..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_msic.c
+++ /dev/null
@@ -1,83 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_msic.c: MSIC platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/scatterlist.h>
-#include <linux/init.h>
-#include <linux/sfi.h>
-#include <linux/mfd/intel_msic.h>
-#include <asm/intel_scu_ipc.h>
-#include <asm/intel-mid.h>
-#include "platform_msic.h"
-
-struct intel_msic_platform_data msic_pdata;
-
-static struct resource msic_resources[] = {
-	{
-		.start	= INTEL_MSIC_IRQ_PHYS_BASE,
-		.end	= INTEL_MSIC_IRQ_PHYS_BASE + 64 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device msic_device = {
-	.name		= "intel_msic",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &msic_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(msic_resources),
-	.resource	= msic_resources,
-};
-
-static int msic_scu_status_change(struct notifier_block *nb,
-				  unsigned long code, void *data)
-{
-	if (code == SCU_DOWN) {
-		platform_device_unregister(&msic_device);
-		return 0;
-	}
-
-	return platform_device_register(&msic_device);
-}
-
-static int __init msic_init(void)
-{
-	static struct notifier_block msic_scu_notifier = {
-		.notifier_call	= msic_scu_status_change,
-	};
-
-	/*
-	 * We need to be sure that the SCU IPC is ready before MSIC device
-	 * can be registered.
-	 */
-	if (intel_mid_has_msic())
-		intel_scu_notifier_add(&msic_scu_notifier);
-
-	return 0;
-}
-arch_initcall(msic_init);
-
-/*
- * msic_generic_platform_data - sets generic platform data for the block
- * @info: pointer to the SFI device table entry for this block
- * @block: MSIC block
- *
- * Function sets IRQ number from the SFI table entry for given device to
- * the MSIC platform data.
- */
-void *msic_generic_platform_data(void *info, enum intel_msic_block block)
-{
-	struct sfi_device_table_entry *entry = info;
-
-	BUG_ON(block < 0 || block >= INTEL_MSIC_BLOCK_LAST);
-	msic_pdata.irq[block] = entry->irq;
-
-	return NULL;
-}
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_msic.h b/arch/x86/platform/intel-mid/device_libs/platform_msic.h
deleted file mode 100644
index 91deb2e65b0e..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_msic.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * platform_msic.h: MSIC platform data header file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-#ifndef _PLATFORM_MSIC_H_
-#define _PLATFORM_MSIC_H_
-
-extern struct intel_msic_platform_data msic_pdata;
-
-void *msic_generic_platform_data(void *info, enum intel_msic_block block);
-
-#endif
diff --git a/arch/x86/platform/intel-mid/sfi.c b/arch/x86/platform/intel-mid/sfi.c
index 30bd5714a3d4..2b22587bfd3d 100644
--- a/arch/x86/platform/intel-mid/sfi.c
+++ b/arch/x86/platform/intel-mid/sfi.c
@@ -338,13 +338,6 @@ static void __init sfi_handle_ipc_dev(struct sfi_device_table_entry *pentry,
 	if (IS_ERR(pdata))
 		return;
 
-	/*
-	 * On Medfield the platform device creation is handled by the MSIC
-	 * MFD driver so we don't need to do it here.
-	 */
-	if (dev->msic && intel_mid_has_msic())
-		return;
-
 	pdev = platform_device_alloc(pentry->name, 0);
 	if (pdev == NULL) {
 		pr_err("out of memory for SFI platform device '%s'.\n",
-- 
2.29.2

