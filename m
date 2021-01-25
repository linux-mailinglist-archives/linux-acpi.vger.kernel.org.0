Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B39302BCA
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Jan 2021 20:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbhAYTlb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 14:41:31 -0500
Received: from mga09.intel.com ([134.134.136.24]:28854 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731919AbhAYTlU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:20 -0500
IronPort-SDR: RIDpzrMel86cx846B77IJEM0poexx7HzLMM+96r2+2SzDz6YTGZ+OaXlFTFq/F+83nPbuzdKET
 8IBO/8QYpK0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179936890"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179936890"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:55 -0800
IronPort-SDR: 6UCbQk3KpBrios7K18Q623lCYKxLETnSU8+ywUef7wLszvGvoLktgenVXNkqlesed3+EEoO6SD
 uu3HCg/xwC/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504267860"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 11:39:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87D51D7; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 01/10] x86/platform/intel-mid: Remove unused leftovers (msic_audio)
Date:   Mon, 25 Jan 2021 21:39:39 +0200
Message-Id: <20210125193948.56760-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit 05f4434bc130 ("ASoC: Intel: remove mfld_machine") removed
the driver, no need to have support files for it.

Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../platform/intel-mid/device_libs/Makefile   |  1 -
 .../device_libs/platform_msic_audio.c         | 42 -------------------
 2 files changed, 43 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/device_libs/platform_msic_audio.c

diff --git a/arch/x86/platform/intel-mid/device_libs/Makefile b/arch/x86/platform/intel-mid/device_libs/Makefile
index 918edac9ab9a..e926577fe665 100644
--- a/arch/x86/platform/intel-mid/device_libs/Makefile
+++ b/arch/x86/platform/intel-mid/device_libs/Makefile
@@ -8,7 +8,6 @@ obj-$(subst m,y,$(CONFIG_BRCMFMAC_SDIO)) += platform_bcm43xx.o
 obj-$(subst m,y,$(CONFIG_BT_HCIUART_BCM)) += platform_bt.o
 # IPC Devices
 obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic.o
-obj-$(subst m,y,$(CONFIG_SND_MFLD_MACHINE)) += platform_msic_audio.o
 obj-$(subst m,y,$(CONFIG_GPIO_MSIC)) += platform_msic_gpio.o
 obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic_ocd.o
 obj-$(subst m,y,$(CONFIG_MFD_INTEL_MSIC)) += platform_msic_battery.o
diff --git a/arch/x86/platform/intel-mid/device_libs/platform_msic_audio.c b/arch/x86/platform/intel-mid/device_libs/platform_msic_audio.c
deleted file mode 100644
index e765da78ad8c..000000000000
--- a/arch/x86/platform/intel-mid/device_libs/platform_msic_audio.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * platform_msic_audio.c: MSIC audio platform data initialization file
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
-#include <linux/platform_device.h>
-#include <linux/mfd/intel_msic.h>
-#include <asm/intel-mid.h>
-
-#include "platform_msic.h"
-
-static void *msic_audio_platform_data(void *info)
-{
-	struct platform_device *pdev;
-
-	pdev = platform_device_register_simple("sst-platform", -1, NULL, 0);
-
-	if (IS_ERR(pdev)) {
-		pr_err("failed to create audio platform device\n");
-		return NULL;
-	}
-
-	return msic_generic_platform_data(info, INTEL_MSIC_BLOCK_AUDIO);
-}
-
-static const struct devs_id msic_audio_dev_id __initconst = {
-	.name = "msic_audio",
-	.type = SFI_DEV_TYPE_IPC,
-	.delay = 1,
-	.msic = 1,
-	.get_platform_data = &msic_audio_platform_data,
-};
-
-sfi_device(msic_audio_dev_id);
-- 
2.29.2

