Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB5303173
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbhAZBZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 20:25:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:32978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732011AbhAYTlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:52 -0500
IronPort-SDR: 04SUIT5keDhTNT9E6J5GlNAonx/L+mwSNSCrx9Tm7iNqxemIgqMUJA5ftEKb0VLlz9t6r8wRIm
 s99KbzWMucOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177218355"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="177218355"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:55 -0800
IronPort-SDR: URFwhV2vTbQUnr66dzqyQ3SnHN29FjQ+p8/SHD0YYcmFjzzDBEyhDQXmJWWqSiVjZYEykRE9Es
 l++UlDitGY3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="402468426"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 11:39:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9DCF4173; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 03/10] x86/platform/intel-mid: Remove unused leftovers (msic_battery)
Date:   Mon, 25 Jan 2021 21:39:41 +0200
Message-Id: <20210125193948.56760-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It seems msic_battery driver was never upstreamed.
Why should we have dead code in the kernel?

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../platform/intel-mid/device_libs/Makefile   |  1 -
 .../device_libs/platform_msic_battery.c       | 32 -------------------
 2 files changed, 33 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_battery.c

diff --git a/arch/x86/platform/intel-mid/device_libs/Makefile b/arch/x86/platform/intel-mid/device_libs/Makefile
index 1ab7813cd627..cf041a9882c0 100644
--- a/arch/x86/platform/intel-mid/device_libs/Makefile
+++ b/arch/x86/platform/intel-mid/device_libs/Makefile
@@ -9,7 +9,6 @@ obj-$(subst m,y,$(CONFIG_BT_HCIUART_BCM)) += platform_bt.o
 # IPC Devices
 obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic.o
 obj-$(subst m,y,$(CONFIG_GPIO_MSIC)) += platform_msic_gpio.o
-obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic_battery.o
 obj-$(subst m,y,$(CONFIG_INTEL_MID_POWER_BUTTON)) += platform_msic_power_btn.o
 obj-$(subst m,y,$(CONFIG_INTEL_MFLD_THERMAL)) += platform_msic_thermal.o
 # SPI Devices
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_msic_battery.c b/arch/x86/platform/intel-mid/device_libs/platform_msic_battery.c
deleted file mode 100644
index f461f84903f8..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_msic_battery.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_msic_battery.c: MSIC battery platform data initialization file
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
-#include <asm/intel-mid.h>
-
-#include "platform_msic.h"
-
-static void __init *msic_battery_platform_data(void *info)
-{
-	return msic_generic_platform_data(info, INTEL_MSIC_BLOCK_BATTERY);
-}
-
-static const struct devs_id msic_battery_dev_id __initconst = {
-	.name = "msic_battery",
-	.type = SFI_DEV_TYPE_IPC,
-	.delay = 1,
-	.msic = 1,
-	.get_platform_data = &msic_battery_platform_data,
-};
-
-sfi_device(msic_battery_dev_id);
-- 
2.29.2

