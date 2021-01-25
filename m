Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8886303119
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732058AbhAYTmX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 14:42:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:32929 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731999AbhAYTlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:52 -0500
IronPort-SDR: hNLogTmN1sCD9dYKwiEzw7GSYCP4l0dpCA5XaT6Bf/lx6PztZfZc1sJEsQ1iDS5p6lHIi4KB2X
 PT/e7oN5g0RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159564594"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="159564594"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:55 -0800
IronPort-SDR: c4kclBX+wmrOM5s8QBBN74awLmejnQmc6fVzU7/6a6QWgnf2FIptIKiOy6HrSMS6N3+qqEP9+r
 AKTGSuAaggvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="368803633"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2021 11:39:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A946517F; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 04/10] x86/platform/intel-mid: Remove unused leftovers (msic_gpio)
Date:   Mon, 25 Jan 2021 21:39:42 +0200
Message-Id: <20210125193948.56760-5-andriy.shevchenko@linux.intel.com>
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
 .../platform/intel-mid/device_libs/Makefile   |  1 -
 .../device_libs/platform_msic_gpio.c          | 43 -------------------
 2 files changed, 44 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_gpio.c

diff --git a/arch/x86/platform/intel-mid/device_libs/Makefile b/arch/x86/platform/intel-mid/device_libs/Makefile
index cf041a9882c0..3688e62ccf80 100644
--- a/arch/x86/platform/intel-mid/device_libs/Makefile
+++ b/arch/x86/platform/intel-mid/device_libs/Makefile
@@ -8,7 +8,6 @@ obj-$(subst m,y,$(CONFIG_BRCMFMAC_SDIO)) += platform_bcm43xx.o
 obj-$(subst m,y,$(CONFIG_BT_HCIUART_BCM)) += platform_bt.o
 # IPC Devices
 obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic.o
-obj-$(subst m,y,$(CONFIG_GPIO_MSIC)) += platform_msic_gpio.o
 obj-$(subst m,y,$(CONFIG_INTEL_MID_POWER_BUTTON)) += platform_msic_power_btn.o
 obj-$(subst m,y,$(CONFIG_INTEL_MFLD_THERMAL)) += platform_msic_thermal.o
 # SPI Devices
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_msic_gpio.c b/arch/x86/platform/intel-mid/device_libs/platform_msic_gpio.c
deleted file mode 100644
index 71a7d6db3878..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_msic_gpio.c
+++ /dev/null
@@ -1,43 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_msic_gpio.c: MSIC GPIO platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/scatterlist.h>
-#include <linux/sfi.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
-#include <linux/mfd/intel_msic.h>
-#include <asm/intel-mid.h>
-
-#include "platform_msic.h"
-
-static void __init *msic_gpio_platform_data(void *info)
-{
-	static struct intel_msic_gpio_pdata msic_gpio_pdata;
-
-	int gpio = get_gpio_by_name("msic_gpio_base");
-
-	if (gpio < 0)
-		return NULL;
-
-	msic_gpio_pdata.gpio_base = gpio;
-	msic_pdata.gpio = &msic_gpio_pdata;
-
-	return msic_generic_platform_data(info, INTEL_MSIC_BLOCK_GPIO);
-}
-
-static const struct devs_id msic_gpio_dev_id __initconst = {
-	.name = "msic_gpio",
-	.type = SFI_DEV_TYPE_IPC,
-	.delay = 1,
-	.msic = 1,
-	.get_platform_data = &msic_gpio_platform_data,
-};
-
-sfi_device(msic_gpio_dev_id);
-- 
2.29.2

