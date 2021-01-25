Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699D0302BE3
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 20:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhAYTmg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 14:42:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:28888 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732013AbhAYTlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:52 -0500
IronPort-SDR: 7re2sFOXtHeCvmc2JZxGIjkm+ChRYhUVPQiGcNLYGlPlu6DhzAiLnhQu/C5afIMblkmVikGSKN
 ISmZN27B4p/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179936897"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179936897"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:58 -0800
IronPort-SDR: H+Gh9CMq6E+RhIFLAbBS7wPNYBG4keEA6y81PgmEBpwQtgEofi0qADl3bJ6/G7nvYSQRLfA+CW
 rgGEqeSca66A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504267876"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 11:39:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BEDC015C; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 06/10] x86/platform/intel-mid: Remove unused leftovers (msic_thermal)
Date:   Mon, 25 Jan 2021 21:39:44 +0200
Message-Id: <20210125193948.56760-7-andriy.shevchenko@linux.intel.com>
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
 .../device_libs/platform_msic_thermal.c       | 32 -------------------
 2 files changed, 33 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_thermal.c

diff --git a/arch/x86/platform/intel-mid/device_libs/Makefile b/arch/x86/platform/intel-mid/device_libs/Makefile
index 177e91d565ca..4e4db0c2b225 100644
--- a/arch/x86/platform/intel-mid/device_libs/Makefile
+++ b/arch/x86/platform/intel-mid/device_libs/Makefile
@@ -8,7 +8,6 @@ obj-$(subst m,y,$(CONFIG_BRCMFMAC_SDIO)) += platform_bcm43xx.o
 obj-$(subst m,y,$(CONFIG_BT_HCIUART_BCM)) += platform_bt.o
 # IPC Devices
 obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic.o
-obj-$(subst m,y,$(CONFIG_INTEL_MFLD_THERMAL)) += platform_msic_thermal.o
 # SPI Devices
 obj-$(subst m,y,$(CONFIG_SPI_SPIDEV)) += platform_mrfld_spidev.o
 # I2C Devices
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_msic_thermal.c b/arch/x86/platform/intel-mid/device_libs/platform_msic_thermal.c
deleted file mode 100644
index 4858da1d78c6..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_msic_thermal.c
+++ /dev/null
@@ -1,32 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_msic_thermal.c: msic_thermal platform data initialization file
- *
- * (C) Copyright 2013 Intel Corporation
- * Author: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
- */
-
-#include <linux/input.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/gpio.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/intel_msic.h>
-#include <asm/intel-mid.h>
-
-#include "platform_msic.h"
-
-static void __init *msic_thermal_platform_data(void *info)
-{
-	return msic_generic_platform_data(info, INTEL_MSIC_BLOCK_THERMAL);
-}
-
-static const struct devs_id msic_thermal_dev_id __initconst = {
-	.name = "msic_thermal",
-	.type = SFI_DEV_TYPE_IPC,
-	.delay = 1,
-	.msic = 1,
-	.get_platform_data = &msic_thermal_platform_data,
-};
-
-sfi_device(msic_thermal_dev_id);
-- 
2.29.2

