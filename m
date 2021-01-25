Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D5F30316B
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbhAZBZW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 20:25:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:17883 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731544AbhAYTnQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:43:16 -0500
IronPort-SDR: ZfXsxJ7kphNwEL2LQBoQl9b6ip4cwrkUKXexwi+3A36YwGE2nvc1VjO6mxowLLUoooRz4/jrNN
 u4lKq+5Qmlnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="198569930"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="198569930"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:59 -0800
IronPort-SDR: lb5qUEhjIIpknyDvzEvXHN6V5CUl/IsE9g7AMHqQ2+BfJyvnrrNtV1X9wUhIlzBqkPi7zv4mya
 ryhyWKYfT4bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="577536003"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 25 Jan 2021 11:39:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B510A214; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 05/10] x86/platform/intel-mid: Remove unused leftovers (msic_power_btn)
Date:   Mon, 25 Jan 2021 21:39:43 +0200
Message-Id: <20210125193948.56760-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no driver present, remove the device creation and other leftovers.

Note, for Intel Merrifield there is another driver which is instantiated by
a certain MFD one and does not need any support from device_libs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../platform/intel-mid/device_libs/Makefile   |  2 -
 .../device_libs/platform_mrfld_power_btn.c    | 78 -------------------
 .../device_libs/platform_msic_power_btn.c     | 31 --------
 3 files changed, 111 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_mrfld_power_btn.c
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_power_btn.c

diff --git a/arch/x86/platform/intel-mid/device_libs/Makefile b/arch/x86/platform/intel-mid/device_libs/Makefile
index 3688e62ccf80..177e91d565ca 100644
--- a/arch/x86/platform/intel-mid/device_libs/Makefile
+++ b/arch/x86/platform/intel-mid/device_libs/Makefile
@@ -8,7 +8,6 @@ obj-$(subst m,y,$(CONFIG_BRCMFMAC_SDIO)) += platform_bcm43xx.o
 obj-$(subst m,y,$(CONFIG_BT_HCIUART_BCM)) += platform_bt.o
 # IPC Devices
 obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic.o
-obj-$(subst m,y,$(CONFIG_INTEL_MID_POWER_BUTTON)) += platform_msic_power_btn.o
 obj-$(subst m,y,$(CONFIG_INTEL_MFLD_THERMAL)) += platform_msic_thermal.o
 # SPI Devices
 obj-$(subst m,y,$(CONFIG_SPI_SPIDEV)) += platform_mrfld_spidev.o
@@ -24,5 +23,4 @@ obj-$(subst m,y,$(CONFIG_GPIO_PCA953X)) += platform_pcal9555a.o
 obj-$(subst m,y,$(CONFIG_GPIO_PCA953X)) += platform_tca6416.o
 # MISC Devices
 obj-$(subst m,y,$(CONFIG_KEYBOARD_GPIO)) += platform_gpio_keys.o
-obj-$(subst m,y,$(CONFIG_INTEL_MID_POWER_BUTTON)) += platform_mrfld_power_btn.o
 obj-$(subst m,y,$(CONFIG_RTC_DRV_CMOS)) += platform_mrfld_rtc.o
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_power_btn.c b/arch/x86/platform/intel-mid/device_libs/platform_mrfld_power_btn.c
deleted file mode 100644
index ec2afb41b34a..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_mrfld_power_btn.c
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Intel Merrifield power button support
- *
- * (C) Copyright 2017 Intel Corporation
- *
- * Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
- */
-
-#include <linux/init.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-#include <linux/sfi.h>
-
-#include <asm/intel-mid.h>
-#include <asm/intel_scu_ipc.h>
-
-static struct resource mrfld_power_btn_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device mrfld_power_btn_dev = {
-	.name		= "msic_power_btn",
-	.id		= PLATFORM_DEVID_NONE,
-	.num_resources	= ARRAY_SIZE(mrfld_power_btn_resources),
-	.resource	= mrfld_power_btn_resources,
-};
-
-static int mrfld_power_btn_scu_status_change(struct notifier_block *nb,
-					     unsigned long code, void *data)
-{
-	if (code == SCU_DOWN) {
-		platform_device_unregister(&mrfld_power_btn_dev);
-		return 0;
-	}
-
-	return platform_device_register(&mrfld_power_btn_dev);
-}
-
-static struct notifier_block mrfld_power_btn_scu_notifier = {
-	.notifier_call	= mrfld_power_btn_scu_status_change,
-};
-
-static int __init register_mrfld_power_btn(void)
-{
-	if (intel_mid_identify_cpu() != INTEL_MID_CPU_CHIP_TANGIER)
-		return -ENODEV;
-
-	/*
-	 * We need to be sure that the SCU IPC is ready before
-	 * PMIC power button device can be registered:
-	 */
-	intel_scu_notifier_add(&mrfld_power_btn_scu_notifier);
-
-	return 0;
-}
-arch_initcall(register_mrfld_power_btn);
-
-static void __init *mrfld_power_btn_platform_data(void *info)
-{
-	struct resource *res = mrfld_power_btn_resources;
-	struct sfi_device_table_entry *pentry = info;
-
-	res->start = res->end = pentry->irq;
-	return NULL;
-}
-
-static const struct devs_id mrfld_power_btn_dev_id __initconst = {
-	.name			= "bcove_power_btn",
-	.type			= SFI_DEV_TYPE_IPC,
-	.delay			= 1,
-	.msic			= 1,
-	.get_platform_data	= &mrfld_power_btn_platform_data,
-};
-
-sfi_device(mrfld_power_btn_dev_id);
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_msic_power_btn.c b/arch/x86/platform/intel-mid/device_libs/platform_msic_power_btn.c
deleted file mode 100644
index 3d3de2d59726..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_msic_power_btn.c
+++ /dev/null
@@ -1,31 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_msic_power_btn.c: MSIC power btn platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/scatterlist.h>
-#include <linux/sfi.h>
-#include <linux/init.h>
-#include <linux/mfd/intel_msic.h>
-#include <asm/intel-mid.h>
-
-#include "platform_msic.h"
-
-static void __init *msic_power_btn_platform_data(void *info)
-{
-	return msic_generic_platform_data(info, INTEL_MSIC_BLOCK_POWER_BTN);
-}
-
-static const struct devs_id msic_power_btn_dev_id __initconst = {
-	.name = "msic_power_btn",
-	.type = SFI_DEV_TYPE_IPC,
-	.delay = 1,
-	.msic = 1,
-	.get_platform_data = &msic_power_btn_platform_data,
-};
-
-sfi_device(msic_power_btn_dev_id);
-- 
2.29.2

