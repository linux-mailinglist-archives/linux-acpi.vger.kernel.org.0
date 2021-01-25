Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5867930316C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbhAZBZU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 20:25:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:28894 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732028AbhAYTlx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:53 -0500
IronPort-SDR: sBlmqoqDciK4fOB/Qih+HZEBjcswS6PcerPiK8JjMY6UQoDrvNxhLEH5GxRh4IPTYGr2k4Z75B
 XRdqlIsl6EYQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179936901"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="179936901"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:59 -0800
IronPort-SDR: B+OeJTdGs0chfMYr8+OYIkbfgEwlHmWiAkTDsN2mtgW52VBJiIUDB5rB156B43PWDvAkKNBSPG
 lTM/c32xHkVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="504267881"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Jan 2021 11:39:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EE8174E7; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 10/10] mfd: intel_msic: Remove driver for deprecated platform
Date:   Mon, 25 Jan 2021 21:39:48 +0200
Message-Id: <20210125193948.56760-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Intel Moorestown and Medfield are quite old Intel Atom based
32-bit platforms, which were in limited use in some Android phones,
tablets and consumer electronics more than eight years ago.

There are no bugs or problems ever reported outside from Intel
for breaking any of that platforms for years. It seems no real
users exists who run more or less fresh kernel on it. The commit
05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
with this theory.

Due to above and to reduce a burden of supporting outdated drivers
we remove the support of outdated platforms completely.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                                 |   2 -
 arch/x86/include/asm/intel_scu_ipc_legacy.h |  12 -
 drivers/mfd/Kconfig                         |   9 -
 drivers/mfd/Makefile                        |   1 -
 drivers/mfd/intel_msic.c                    | 425 ------------------
 include/linux/mfd/intel_msic.h              | 453 --------------------
 6 files changed, 902 deletions(-)
 delete mode 100644 drivers/mfd/intel_msic.c
 delete mode 100644 include/linux/mfd/intel_msic.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a5f161c9a059..420693499bd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9102,9 +9102,7 @@ F:	drivers/gpio/gpio-*cove.c
 INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
 S:	Maintained
-F:	drivers/mfd/intel_msic.c
 F:	drivers/mfd/intel_soc_pmic*
-F:	include/linux/mfd/intel_msic.h
 F:	include/linux/mfd/intel_soc_pmic*
 
 INTEL PMT DRIVER
diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
index 2232197c24f8..f8b87d8face7 100644
--- a/arch/x86/include/asm/intel_scu_ipc_legacy.h
+++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
@@ -16,24 +16,12 @@
 
 /* Don't call these in new code - they will be removed eventually */
 
-/* Read single register */
-static inline int intel_scu_ipc_ioread8(u16 addr, u8 *data)
-{
-	return intel_scu_ipc_dev_ioread8(NULL, addr, data);
-}
-
 /* Read a vector */
 static inline int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
 {
 	return intel_scu_ipc_dev_readv(NULL, addr, data, len);
 }
 
-/* Write single register */
-static inline int intel_scu_ipc_iowrite8(u16 addr, u8 data)
-{
-	return intel_scu_ipc_dev_iowrite8(NULL, addr, data);
-}
-
 /* Write a vector */
 static inline int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
 {
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index bdfce7b15621..2dc58a92251b 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -659,15 +659,6 @@ config MFD_INTEL_LPSS_PCI
 	  I2C, SPI and HS-UART starting from Intel Sunrisepoint (Intel Skylake
 	  PCH) in PCI mode.
 
-config MFD_INTEL_MSIC
-	bool "Intel MSIC"
-	depends on INTEL_SCU
-	select MFD_CORE
-	help
-	  Select this option to enable access to Intel MSIC (Avatele
-	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
-	  devices used in Intel Medfield platforms.
-
 config MFD_INTEL_PMC_BXT
 	tristate "Intel PMC Driver for Broxton"
 	depends on X86
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 14fdb188af02..be19bc799073 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -214,7 +214,6 @@ obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
 obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
-obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
 obj-$(CONFIG_MFD_INTEL_PMT)	+= intel_pmt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
deleted file mode 100644
index daa772f8146b..000000000000
--- a/drivers/mfd/intel_msic.c
+++ /dev/null
@@ -1,425 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Driver for Intel MSIC
- *
- * Copyright (C) 2011, Intel Corporation
- * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- */
-
-#include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/intel_msic.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-
-#include <asm/intel_scu_ipc.h>
-
-#define MSIC_VENDOR(id)		((id >> 6) & 3)
-#define MSIC_VERSION(id)	(id & 0x3f)
-#define MSIC_MAJOR(id)		('A' + ((id >> 3) & 7))
-#define MSIC_MINOR(id)		(id & 7)
-
-/*
- * MSIC interrupt tree is readable from SRAM at INTEL_MSIC_IRQ_PHYS_BASE.
- * Since IRQ block starts from address 0x002 we need to subtract that from
- * the actual IRQ status register address.
- */
-#define MSIC_IRQ_STATUS(x)	(INTEL_MSIC_IRQ_PHYS_BASE + ((x) - 2))
-#define MSIC_IRQ_STATUS_ACCDET	MSIC_IRQ_STATUS(INTEL_MSIC_ACCDET)
-
-/*
- * The SCU hardware has limitation of 16 bytes per read/write buffer on
- * Medfield.
- */
-#define SCU_IPC_RWBUF_LIMIT	16
-
-/**
- * struct intel_msic - an MSIC MFD instance
- * @pdev: pointer to the platform device
- * @vendor: vendor ID
- * @version: chip version
- * @irq_base: base address of the mapped MSIC SRAM interrupt tree
- */
-struct intel_msic {
-	struct platform_device		*pdev;
-	unsigned			vendor;
-	unsigned			version;
-	void __iomem			*irq_base;
-};
-
-static const struct resource msic_touch_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-static const struct resource msic_adc_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-static const struct resource msic_battery_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-static const struct resource msic_gpio_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-static const struct resource msic_audio_resources[] = {
-	DEFINE_RES_IRQ_NAMED(0, "IRQ"),
-	/*
-	 * We will pass IRQ_BASE to the driver now but this can be removed
-	 * when/if the driver starts to use intel_msic_irq_read().
-	 */
-	DEFINE_RES_MEM_NAMED(MSIC_IRQ_STATUS_ACCDET, 1, "IRQ_BASE"),
-};
-
-static const struct resource msic_hdmi_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-static const struct resource msic_thermal_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-static const struct resource msic_power_btn_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-static const struct resource msic_ocd_resources[] = {
-	DEFINE_RES_IRQ(0),
-};
-
-/*
- * Devices that are part of the MSIC and are available via firmware
- * populated SFI DEVS table.
- */
-static struct mfd_cell msic_devs[] = {
-	[INTEL_MSIC_BLOCK_TOUCH]	= {
-		.name			= "msic_touch",
-		.num_resources		= ARRAY_SIZE(msic_touch_resources),
-		.resources		= msic_touch_resources,
-	},
-	[INTEL_MSIC_BLOCK_ADC]		= {
-		.name			= "msic_adc",
-		.num_resources		= ARRAY_SIZE(msic_adc_resources),
-		.resources		= msic_adc_resources,
-	},
-	[INTEL_MSIC_BLOCK_BATTERY]	= {
-		.name			= "msic_battery",
-		.num_resources		= ARRAY_SIZE(msic_battery_resources),
-		.resources		= msic_battery_resources,
-	},
-	[INTEL_MSIC_BLOCK_GPIO]		= {
-		.name			= "msic_gpio",
-		.num_resources		= ARRAY_SIZE(msic_gpio_resources),
-		.resources		= msic_gpio_resources,
-	},
-	[INTEL_MSIC_BLOCK_AUDIO]	= {
-		.name			= "msic_audio",
-		.num_resources		= ARRAY_SIZE(msic_audio_resources),
-		.resources		= msic_audio_resources,
-	},
-	[INTEL_MSIC_BLOCK_HDMI]		= {
-		.name			= "msic_hdmi",
-		.num_resources		= ARRAY_SIZE(msic_hdmi_resources),
-		.resources		= msic_hdmi_resources,
-	},
-	[INTEL_MSIC_BLOCK_THERMAL]	= {
-		.name			= "msic_thermal",
-		.num_resources		= ARRAY_SIZE(msic_thermal_resources),
-		.resources		= msic_thermal_resources,
-	},
-	[INTEL_MSIC_BLOCK_POWER_BTN]	= {
-		.name			= "msic_power_btn",
-		.num_resources		= ARRAY_SIZE(msic_power_btn_resources),
-		.resources		= msic_power_btn_resources,
-	},
-	[INTEL_MSIC_BLOCK_OCD]		= {
-		.name			= "msic_ocd",
-		.num_resources		= ARRAY_SIZE(msic_ocd_resources),
-		.resources		= msic_ocd_resources,
-	},
-};
-
-/*
- * Other MSIC related devices which are not directly available via SFI DEVS
- * table. These can be pseudo devices, regulators etc. which are needed for
- * different purposes.
- *
- * These devices appear only after the MSIC driver itself is initialized so
- * we can guarantee that the SCU IPC interface is ready.
- */
-static const struct mfd_cell msic_other_devs[] = {
-	/* Audio codec in the MSIC */
-	{
-		.id			= -1,
-		.name			= "sn95031",
-	},
-};
-
-/**
- * intel_msic_reg_read - read a single MSIC register
- * @reg: register to read
- * @val: register value is placed here
- *
- * Read a single register from MSIC. Returns %0 on success and negative
- * errno in case of failure.
- *
- * Function may sleep.
- */
-int intel_msic_reg_read(unsigned short reg, u8 *val)
-{
-	return intel_scu_ipc_ioread8(reg, val);
-}
-EXPORT_SYMBOL_GPL(intel_msic_reg_read);
-
-/**
- * intel_msic_reg_write - write a single MSIC register
- * @reg: register to write
- * @val: value to write to that register
- *
- * Write a single MSIC register. Returns 0 on success and negative
- * errno in case of failure.
- *
- * Function may sleep.
- */
-int intel_msic_reg_write(unsigned short reg, u8 val)
-{
-	return intel_scu_ipc_iowrite8(reg, val);
-}
-EXPORT_SYMBOL_GPL(intel_msic_reg_write);
-
-/**
- * intel_msic_reg_update - update a single MSIC register
- * @reg: register to update
- * @val: value to write to the register
- * @mask: specifies which of the bits are updated (%0 = don't update,
- *        %1 = update)
- *
- * Perform an update to a register @reg. @mask is used to specify which
- * bits are updated. Returns %0 in case of success and negative errno in
- * case of failure.
- *
- * Function may sleep.
- */
-int intel_msic_reg_update(unsigned short reg, u8 val, u8 mask)
-{
-	return intel_scu_ipc_update_register(reg, val, mask);
-}
-EXPORT_SYMBOL_GPL(intel_msic_reg_update);
-
-/**
- * intel_msic_bulk_read - read an array of registers
- * @reg: array of register addresses to read
- * @buf: array where the read values are placed
- * @count: number of registers to read
- *
- * Function reads @count registers from the MSIC using addresses passed in
- * @reg. Read values are placed in @buf. Reads are performed atomically
- * wrt. MSIC.
- *
- * Returns %0 in case of success and negative errno in case of failure.
- *
- * Function may sleep.
- */
-int intel_msic_bulk_read(unsigned short *reg, u8 *buf, size_t count)
-{
-	if (WARN_ON(count > SCU_IPC_RWBUF_LIMIT))
-		return -EINVAL;
-
-	return intel_scu_ipc_readv(reg, buf, count);
-}
-EXPORT_SYMBOL_GPL(intel_msic_bulk_read);
-
-/**
- * intel_msic_bulk_write - write an array of values to the MSIC registers
- * @reg: array of registers to write
- * @buf: values to write to each register
- * @count: number of registers to write
- *
- * Function writes @count registers in @buf to MSIC. Writes are performed
- * atomically wrt MSIC. Returns %0 in case of success and negative errno in
- * case of failure.
- *
- * Function may sleep.
- */
-int intel_msic_bulk_write(unsigned short *reg, u8 *buf, size_t count)
-{
-	if (WARN_ON(count > SCU_IPC_RWBUF_LIMIT))
-		return -EINVAL;
-
-	return intel_scu_ipc_writev(reg, buf, count);
-}
-EXPORT_SYMBOL_GPL(intel_msic_bulk_write);
-
-/**
- * intel_msic_irq_read - read a register from an MSIC interrupt tree
- * @msic: MSIC instance
- * @reg: interrupt register (between %INTEL_MSIC_IRQLVL1 and
- *	 %INTEL_MSIC_RESETIRQ2)
- * @val: value of the register is placed here
- *
- * This function can be used by an MSIC subdevice interrupt handler to read
- * a register value from the MSIC interrupt tree. In this way subdevice
- * drivers don't have to map in the interrupt tree themselves but can just
- * call this function instead.
- *
- * Function doesn't sleep and is callable from interrupt context.
- *
- * Returns %-EINVAL if @reg is outside of the allowed register region.
- */
-int intel_msic_irq_read(struct intel_msic *msic, unsigned short reg, u8 *val)
-{
-	if (WARN_ON(reg < INTEL_MSIC_IRQLVL1 || reg > INTEL_MSIC_RESETIRQ2))
-		return -EINVAL;
-
-	*val = readb(msic->irq_base + (reg - INTEL_MSIC_IRQLVL1));
-	return 0;
-}
-EXPORT_SYMBOL_GPL(intel_msic_irq_read);
-
-static int intel_msic_init_devices(struct intel_msic *msic)
-{
-	struct platform_device *pdev = msic->pdev;
-	struct intel_msic_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	int ret, i;
-
-	if (pdata->gpio) {
-		struct mfd_cell *cell = &msic_devs[INTEL_MSIC_BLOCK_GPIO];
-
-		cell->platform_data = pdata->gpio;
-		cell->pdata_size = sizeof(*pdata->gpio);
-	}
-
-	if (pdata->ocd) {
-		unsigned gpio = pdata->ocd->gpio;
-
-		ret = devm_gpio_request_one(&pdev->dev, gpio,
-					GPIOF_IN, "ocd_gpio");
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register OCD GPIO\n");
-			return ret;
-		}
-
-		ret = gpio_to_irq(gpio);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "no IRQ number for OCD GPIO\n");
-			return ret;
-		}
-
-		/* Update the IRQ number for the OCD */
-		pdata->irq[INTEL_MSIC_BLOCK_OCD] = ret;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(msic_devs); i++) {
-		if (!pdata->irq[i])
-			continue;
-
-		ret = mfd_add_devices(&pdev->dev, -1, &msic_devs[i], 1, NULL,
-				      pdata->irq[i], NULL);
-		if (ret)
-			goto fail;
-	}
-
-	ret = mfd_add_devices(&pdev->dev, 0, msic_other_devs,
-			      ARRAY_SIZE(msic_other_devs), NULL, 0, NULL);
-	if (ret)
-		goto fail;
-
-	return 0;
-
-fail:
-	mfd_remove_devices(&pdev->dev);
-
-	return ret;
-}
-
-static void intel_msic_remove_devices(struct intel_msic *msic)
-{
-	struct platform_device *pdev = msic->pdev;
-
-	mfd_remove_devices(&pdev->dev);
-}
-
-static int intel_msic_probe(struct platform_device *pdev)
-{
-	struct intel_msic_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct intel_msic *msic;
-	struct resource *res;
-	u8 id0, id1;
-	int ret;
-
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data passed\n");
-		return -EINVAL;
-	}
-
-	/* First validate that we have an MSIC in place */
-	ret = intel_scu_ipc_ioread8(INTEL_MSIC_ID0, &id0);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to identify the MSIC chip (ID0)\n");
-		return -ENXIO;
-	}
-
-	ret = intel_scu_ipc_ioread8(INTEL_MSIC_ID1, &id1);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to identify the MSIC chip (ID1)\n");
-		return -ENXIO;
-	}
-
-	if (MSIC_VENDOR(id0) != MSIC_VENDOR(id1)) {
-		dev_err(&pdev->dev, "invalid vendor ID: %x, %x\n", id0, id1);
-		return -ENXIO;
-	}
-
-	msic = devm_kzalloc(&pdev->dev, sizeof(*msic), GFP_KERNEL);
-	if (!msic)
-		return -ENOMEM;
-
-	msic->vendor = MSIC_VENDOR(id0);
-	msic->version = MSIC_VERSION(id0);
-	msic->pdev = pdev;
-
-	/*
-	 * Map in the MSIC interrupt tree area in SRAM. This is exposed to
-	 * the clients via intel_msic_irq_read().
-	 */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	msic->irq_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(msic->irq_base))
-		return PTR_ERR(msic->irq_base);
-
-	platform_set_drvdata(pdev, msic);
-
-	ret = intel_msic_init_devices(msic);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to initialize MSIC devices\n");
-		return ret;
-	}
-
-	dev_info(&pdev->dev, "Intel MSIC version %c%d (vendor %#x)\n",
-		 MSIC_MAJOR(msic->version), MSIC_MINOR(msic->version),
-		 msic->vendor);
-
-	return 0;
-}
-
-static int intel_msic_remove(struct platform_device *pdev)
-{
-	struct intel_msic *msic = platform_get_drvdata(pdev);
-
-	intel_msic_remove_devices(msic);
-
-	return 0;
-}
-
-static struct platform_driver intel_msic_driver = {
-	.probe		= intel_msic_probe,
-	.remove		= intel_msic_remove,
-	.driver		= {
-		.name	= "intel_msic",
-	},
-};
-builtin_platform_driver(intel_msic_driver);
diff --git a/include/linux/mfd/intel_msic.h b/include/linux/mfd/intel_msic.h
deleted file mode 100644
index 317e8608cf41..000000000000
--- a/include/linux/mfd/intel_msic.h
+++ /dev/null
@@ -1,453 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Core interface for Intel MSIC
- *
- * Copyright (C) 2011, Intel Corporation
- * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- */
-
-#ifndef __LINUX_MFD_INTEL_MSIC_H__
-#define __LINUX_MFD_INTEL_MSIC_H__
-
-/* ID */
-#define INTEL_MSIC_ID0			0x000	/* RO */
-#define INTEL_MSIC_ID1			0x001	/* RO */
-
-/* IRQ */
-#define INTEL_MSIC_IRQLVL1		0x002
-#define INTEL_MSIC_ADC1INT		0x003
-#define INTEL_MSIC_CCINT		0x004
-#define INTEL_MSIC_PWRSRCINT		0x005
-#define INTEL_MSIC_PWRSRCINT1		0x006
-#define INTEL_MSIC_CHRINT		0x007
-#define INTEL_MSIC_CHRINT1		0x008
-#define INTEL_MSIC_RTCIRQ		0x009
-#define INTEL_MSIC_GPIO0LVIRQ		0x00a
-#define INTEL_MSIC_GPIO1LVIRQ		0x00b
-#define INTEL_MSIC_GPIOHVIRQ		0x00c
-#define INTEL_MSIC_VRINT		0x00d
-#define INTEL_MSIC_OCAUDIO		0x00e
-#define INTEL_MSIC_ACCDET		0x00f
-#define INTEL_MSIC_RESETIRQ1		0x010
-#define INTEL_MSIC_RESETIRQ2		0x011
-#define INTEL_MSIC_MADC1INT		0x012
-#define INTEL_MSIC_MCCINT		0x013
-#define INTEL_MSIC_MPWRSRCINT		0x014
-#define INTEL_MSIC_MPWRSRCINT1		0x015
-#define INTEL_MSIC_MCHRINT		0x016
-#define INTEL_MSIC_MCHRINT1		0x017
-#define INTEL_MSIC_RTCIRQMASK		0x018
-#define INTEL_MSIC_GPIO0LVIRQMASK	0x019
-#define INTEL_MSIC_GPIO1LVIRQMASK	0x01a
-#define INTEL_MSIC_GPIOHVIRQMASK	0x01b
-#define INTEL_MSIC_VRINTMASK		0x01c
-#define INTEL_MSIC_OCAUDIOMASK		0x01d
-#define INTEL_MSIC_ACCDETMASK		0x01e
-#define INTEL_MSIC_RESETIRQ1MASK	0x01f
-#define INTEL_MSIC_RESETIRQ2MASK	0x020
-#define INTEL_MSIC_IRQLVL1MSK		0x021
-#define INTEL_MSIC_PBCONFIG		0x03e
-#define INTEL_MSIC_PBSTATUS		0x03f	/* RO */
-
-/* GPIO */
-#define INTEL_MSIC_GPIO0LV7CTLO		0x040
-#define INTEL_MSIC_GPIO0LV6CTLO		0x041
-#define INTEL_MSIC_GPIO0LV5CTLO		0x042
-#define INTEL_MSIC_GPIO0LV4CTLO		0x043
-#define INTEL_MSIC_GPIO0LV3CTLO		0x044
-#define INTEL_MSIC_GPIO0LV2CTLO		0x045
-#define INTEL_MSIC_GPIO0LV1CTLO		0x046
-#define INTEL_MSIC_GPIO0LV0CTLO		0x047
-#define INTEL_MSIC_GPIO1LV7CTLOS	0x048
-#define INTEL_MSIC_GPIO1LV6CTLO		0x049
-#define INTEL_MSIC_GPIO1LV5CTLO		0x04a
-#define INTEL_MSIC_GPIO1LV4CTLO		0x04b
-#define INTEL_MSIC_GPIO1LV3CTLO		0x04c
-#define INTEL_MSIC_GPIO1LV2CTLO		0x04d
-#define INTEL_MSIC_GPIO1LV1CTLO		0x04e
-#define INTEL_MSIC_GPIO1LV0CTLO		0x04f
-#define INTEL_MSIC_GPIO0LV7CTLI		0x050
-#define INTEL_MSIC_GPIO0LV6CTLI		0x051
-#define INTEL_MSIC_GPIO0LV5CTLI		0x052
-#define INTEL_MSIC_GPIO0LV4CTLI		0x053
-#define INTEL_MSIC_GPIO0LV3CTLI		0x054
-#define INTEL_MSIC_GPIO0LV2CTLI		0x055
-#define INTEL_MSIC_GPIO0LV1CTLI		0x056
-#define INTEL_MSIC_GPIO0LV0CTLI		0x057
-#define INTEL_MSIC_GPIO1LV7CTLIS	0x058
-#define INTEL_MSIC_GPIO1LV6CTLI		0x059
-#define INTEL_MSIC_GPIO1LV5CTLI		0x05a
-#define INTEL_MSIC_GPIO1LV4CTLI		0x05b
-#define INTEL_MSIC_GPIO1LV3CTLI		0x05c
-#define INTEL_MSIC_GPIO1LV2CTLI		0x05d
-#define INTEL_MSIC_GPIO1LV1CTLI		0x05e
-#define INTEL_MSIC_GPIO1LV0CTLI		0x05f
-#define INTEL_MSIC_PWM0CLKDIV1		0x061
-#define INTEL_MSIC_PWM0CLKDIV0		0x062
-#define INTEL_MSIC_PWM1CLKDIV1		0x063
-#define INTEL_MSIC_PWM1CLKDIV0		0x064
-#define INTEL_MSIC_PWM2CLKDIV1		0x065
-#define INTEL_MSIC_PWM2CLKDIV0		0x066
-#define INTEL_MSIC_PWM0DUTYCYCLE	0x067
-#define INTEL_MSIC_PWM1DUTYCYCLE	0x068
-#define INTEL_MSIC_PWM2DUTYCYCLE	0x069
-#define INTEL_MSIC_GPIO0HV3CTLO		0x06d
-#define INTEL_MSIC_GPIO0HV2CTLO		0x06e
-#define INTEL_MSIC_GPIO0HV1CTLO		0x06f
-#define INTEL_MSIC_GPIO0HV0CTLO		0x070
-#define INTEL_MSIC_GPIO1HV3CTLO		0x071
-#define INTEL_MSIC_GPIO1HV2CTLO		0x072
-#define INTEL_MSIC_GPIO1HV1CTLO		0x073
-#define INTEL_MSIC_GPIO1HV0CTLO		0x074
-#define INTEL_MSIC_GPIO0HV3CTLI		0x075
-#define INTEL_MSIC_GPIO0HV2CTLI		0x076
-#define INTEL_MSIC_GPIO0HV1CTLI		0x077
-#define INTEL_MSIC_GPIO0HV0CTLI		0x078
-#define INTEL_MSIC_GPIO1HV3CTLI		0x079
-#define INTEL_MSIC_GPIO1HV2CTLI		0x07a
-#define INTEL_MSIC_GPIO1HV1CTLI		0x07b
-#define INTEL_MSIC_GPIO1HV0CTLI		0x07c
-
-/* SVID */
-#define INTEL_MSIC_SVIDCTRL0		0x080
-#define INTEL_MSIC_SVIDCTRL1		0x081
-#define INTEL_MSIC_SVIDCTRL2		0x082
-#define INTEL_MSIC_SVIDTXLASTPKT3	0x083	/* RO */
-#define INTEL_MSIC_SVIDTXLASTPKT2	0x084	/* RO */
-#define INTEL_MSIC_SVIDTXLASTPKT1	0x085	/* RO */
-#define INTEL_MSIC_SVIDTXLASTPKT0	0x086	/* RO */
-#define INTEL_MSIC_SVIDPKTOUTBYTE3	0x087
-#define INTEL_MSIC_SVIDPKTOUTBYTE2	0x088
-#define INTEL_MSIC_SVIDPKTOUTBYTE1	0x089
-#define INTEL_MSIC_SVIDPKTOUTBYTE0	0x08a
-#define INTEL_MSIC_SVIDRXVPDEBUG1	0x08b
-#define INTEL_MSIC_SVIDRXVPDEBUG0	0x08c
-#define INTEL_MSIC_SVIDRXLASTPKT3	0x08d	/* RO */
-#define INTEL_MSIC_SVIDRXLASTPKT2	0x08e	/* RO */
-#define INTEL_MSIC_SVIDRXLASTPKT1	0x08f	/* RO */
-#define INTEL_MSIC_SVIDRXLASTPKT0	0x090	/* RO */
-#define INTEL_MSIC_SVIDRXCHKSTATUS3	0x091	/* RO */
-#define INTEL_MSIC_SVIDRXCHKSTATUS2	0x092	/* RO */
-#define INTEL_MSIC_SVIDRXCHKSTATUS1	0x093	/* RO */
-#define INTEL_MSIC_SVIDRXCHKSTATUS0	0x094	/* RO */
-
-/* VREG */
-#define INTEL_MSIC_VCCLATCH		0x0c0
-#define INTEL_MSIC_VNNLATCH		0x0c1
-#define INTEL_MSIC_VCCCNT		0x0c2
-#define INTEL_MSIC_SMPSRAMP		0x0c3
-#define INTEL_MSIC_VNNCNT		0x0c4
-#define INTEL_MSIC_VNNAONCNT		0x0c5
-#define INTEL_MSIC_VCC122AONCNT		0x0c6
-#define INTEL_MSIC_V180AONCNT		0x0c7
-#define INTEL_MSIC_V500CNT		0x0c8
-#define INTEL_MSIC_VIHFCNT		0x0c9
-#define INTEL_MSIC_LDORAMP1		0x0ca
-#define INTEL_MSIC_LDORAMP2		0x0cb
-#define INTEL_MSIC_VCC108AONCNT		0x0cc
-#define INTEL_MSIC_VCC108ASCNT		0x0cd
-#define INTEL_MSIC_VCC108CNT		0x0ce
-#define INTEL_MSIC_VCCA100ASCNT		0x0cf
-#define INTEL_MSIC_VCCA100CNT		0x0d0
-#define INTEL_MSIC_VCC180AONCNT		0x0d1
-#define INTEL_MSIC_VCC180CNT		0x0d2
-#define INTEL_MSIC_VCC330CNT		0x0d3
-#define INTEL_MSIC_VUSB330CNT		0x0d4
-#define INTEL_MSIC_VCCSDIOCNT		0x0d5
-#define INTEL_MSIC_VPROG1CNT		0x0d6
-#define INTEL_MSIC_VPROG2CNT		0x0d7
-#define INTEL_MSIC_VEMMCSCNT		0x0d8
-#define INTEL_MSIC_VEMMC1CNT		0x0d9
-#define INTEL_MSIC_VEMMC2CNT		0x0da
-#define INTEL_MSIC_VAUDACNT		0x0db
-#define INTEL_MSIC_VHSPCNT		0x0dc
-#define INTEL_MSIC_VHSNCNT		0x0dd
-#define INTEL_MSIC_VHDMICNT		0x0de
-#define INTEL_MSIC_VOTGCNT		0x0df
-#define INTEL_MSIC_V1P35CNT		0x0e0
-#define INTEL_MSIC_V330AONCNT		0x0e1
-
-/* RESET */
-#define INTEL_MSIC_CHIPCNTRL		0x100	/* WO */
-#define INTEL_MSIC_ERCONFIG		0x101
-
-/* BURST */
-#define INTEL_MSIC_BATCURRENTLIMIT12	0x102
-#define INTEL_MSIC_BATTIMELIMIT12	0x103
-#define INTEL_MSIC_BATTIMELIMIT3	0x104
-#define INTEL_MSIC_BATTIMEDB		0x105
-#define INTEL_MSIC_BRSTCONFIGOUTPUTS	0x106
-#define INTEL_MSIC_BRSTCONFIGACTIONS	0x107
-#define INTEL_MSIC_BURSTCONTROLSTATUS	0x108
-
-/* RTC */
-#define INTEL_MSIC_RTCB1		0x140	/* RO */
-#define INTEL_MSIC_RTCB2		0x141	/* RO */
-#define INTEL_MSIC_RTCB3		0x142	/* RO */
-#define INTEL_MSIC_RTCB4		0x143	/* RO */
-#define INTEL_MSIC_RTCOB1		0x144
-#define INTEL_MSIC_RTCOB2		0x145
-#define INTEL_MSIC_RTCOB3		0x146
-#define INTEL_MSIC_RTCOB4		0x147
-#define INTEL_MSIC_RTCAB1		0x148
-#define INTEL_MSIC_RTCAB2		0x149
-#define INTEL_MSIC_RTCAB3		0x14a
-#define INTEL_MSIC_RTCAB4		0x14b
-#define INTEL_MSIC_RTCWAB1		0x14c
-#define INTEL_MSIC_RTCWAB2		0x14d
-#define INTEL_MSIC_RTCWAB3		0x14e
-#define INTEL_MSIC_RTCWAB4		0x14f
-#define INTEL_MSIC_RTCSC1		0x150
-#define INTEL_MSIC_RTCSC2		0x151
-#define INTEL_MSIC_RTCSC3		0x152
-#define INTEL_MSIC_RTCSC4		0x153
-#define INTEL_MSIC_RTCSTATUS		0x154	/* RO */
-#define INTEL_MSIC_RTCCONFIG1		0x155
-#define INTEL_MSIC_RTCCONFIG2		0x156
-
-/* CHARGER */
-#define INTEL_MSIC_BDTIMER		0x180
-#define INTEL_MSIC_BATTRMV		0x181
-#define INTEL_MSIC_VBUSDET		0x182
-#define INTEL_MSIC_VBUSDET1		0x183
-#define INTEL_MSIC_ADPHVDET		0x184
-#define INTEL_MSIC_ADPLVDET		0x185
-#define INTEL_MSIC_ADPDETDBDM		0x186
-#define INTEL_MSIC_LOWBATTDET		0x187
-#define INTEL_MSIC_CHRCTRL		0x188
-#define INTEL_MSIC_CHRCVOLTAGE		0x189
-#define INTEL_MSIC_CHRCCURRENT		0x18a
-#define INTEL_MSIC_SPCHARGER		0x18b
-#define INTEL_MSIC_CHRTTIME		0x18c
-#define INTEL_MSIC_CHRCTRL1		0x18d
-#define INTEL_MSIC_PWRSRCLMT		0x18e
-#define INTEL_MSIC_CHRSTWDT		0x18f
-#define INTEL_MSIC_WDTWRITE		0x190	/* WO */
-#define INTEL_MSIC_CHRSAFELMT		0x191
-#define INTEL_MSIC_SPWRSRCINT		0x192	/* RO */
-#define INTEL_MSIC_SPWRSRCINT1		0x193	/* RO */
-#define INTEL_MSIC_CHRLEDPWM		0x194
-#define INTEL_MSIC_CHRLEDCTRL		0x195
-
-/* ADC */
-#define INTEL_MSIC_ADC1CNTL1		0x1c0
-#define INTEL_MSIC_ADC1CNTL2		0x1c1
-#define INTEL_MSIC_ADC1CNTL3		0x1c2
-#define INTEL_MSIC_ADC1OFFSETH		0x1c3	/* RO */
-#define INTEL_MSIC_ADC1OFFSETL		0x1c4	/* RO */
-#define INTEL_MSIC_ADC1ADDR0		0x1c5
-#define INTEL_MSIC_ADC1ADDR1		0x1c6
-#define INTEL_MSIC_ADC1ADDR2		0x1c7
-#define INTEL_MSIC_ADC1ADDR3		0x1c8
-#define INTEL_MSIC_ADC1ADDR4		0x1c9
-#define INTEL_MSIC_ADC1ADDR5		0x1ca
-#define INTEL_MSIC_ADC1ADDR6		0x1cb
-#define INTEL_MSIC_ADC1ADDR7		0x1cc
-#define INTEL_MSIC_ADC1ADDR8		0x1cd
-#define INTEL_MSIC_ADC1ADDR9		0x1ce
-#define INTEL_MSIC_ADC1ADDR10		0x1cf
-#define INTEL_MSIC_ADC1ADDR11		0x1d0
-#define INTEL_MSIC_ADC1ADDR12		0x1d1
-#define INTEL_MSIC_ADC1ADDR13		0x1d2
-#define INTEL_MSIC_ADC1ADDR14		0x1d3
-#define INTEL_MSIC_ADC1SNS0H		0x1d4	/* RO */
-#define INTEL_MSIC_ADC1SNS0L		0x1d5	/* RO */
-#define INTEL_MSIC_ADC1SNS1H		0x1d6	/* RO */
-#define INTEL_MSIC_ADC1SNS1L		0x1d7	/* RO */
-#define INTEL_MSIC_ADC1SNS2H		0x1d8	/* RO */
-#define INTEL_MSIC_ADC1SNS2L		0x1d9	/* RO */
-#define INTEL_MSIC_ADC1SNS3H		0x1da	/* RO */
-#define INTEL_MSIC_ADC1SNS3L		0x1db	/* RO */
-#define INTEL_MSIC_ADC1SNS4H		0x1dc	/* RO */
-#define INTEL_MSIC_ADC1SNS4L		0x1dd	/* RO */
-#define INTEL_MSIC_ADC1SNS5H		0x1de	/* RO */
-#define INTEL_MSIC_ADC1SNS5L		0x1df	/* RO */
-#define INTEL_MSIC_ADC1SNS6H		0x1e0	/* RO */
-#define INTEL_MSIC_ADC1SNS6L		0x1e1	/* RO */
-#define INTEL_MSIC_ADC1SNS7H		0x1e2	/* RO */
-#define INTEL_MSIC_ADC1SNS7L		0x1e3	/* RO */
-#define INTEL_MSIC_ADC1SNS8H		0x1e4	/* RO */
-#define INTEL_MSIC_ADC1SNS8L		0x1e5	/* RO */
-#define INTEL_MSIC_ADC1SNS9H		0x1e6	/* RO */
-#define INTEL_MSIC_ADC1SNS9L		0x1e7	/* RO */
-#define INTEL_MSIC_ADC1SNS10H		0x1e8	/* RO */
-#define INTEL_MSIC_ADC1SNS10L		0x1e9	/* RO */
-#define INTEL_MSIC_ADC1SNS11H		0x1ea	/* RO */
-#define INTEL_MSIC_ADC1SNS11L		0x1eb	/* RO */
-#define INTEL_MSIC_ADC1SNS12H		0x1ec	/* RO */
-#define INTEL_MSIC_ADC1SNS12L		0x1ed	/* RO */
-#define INTEL_MSIC_ADC1SNS13H		0x1ee	/* RO */
-#define INTEL_MSIC_ADC1SNS13L		0x1ef	/* RO */
-#define INTEL_MSIC_ADC1SNS14H		0x1f0	/* RO */
-#define INTEL_MSIC_ADC1SNS14L		0x1f1	/* RO */
-#define INTEL_MSIC_ADC1BV0H		0x1f2	/* RO */
-#define INTEL_MSIC_ADC1BV0L		0x1f3	/* RO */
-#define INTEL_MSIC_ADC1BV1H		0x1f4	/* RO */
-#define INTEL_MSIC_ADC1BV1L		0x1f5	/* RO */
-#define INTEL_MSIC_ADC1BV2H		0x1f6	/* RO */
-#define INTEL_MSIC_ADC1BV2L		0x1f7	/* RO */
-#define INTEL_MSIC_ADC1BV3H		0x1f8	/* RO */
-#define INTEL_MSIC_ADC1BV3L		0x1f9	/* RO */
-#define INTEL_MSIC_ADC1BI0H		0x1fa	/* RO */
-#define INTEL_MSIC_ADC1BI0L		0x1fb	/* RO */
-#define INTEL_MSIC_ADC1BI1H		0x1fc	/* RO */
-#define INTEL_MSIC_ADC1BI1L		0x1fd	/* RO */
-#define INTEL_MSIC_ADC1BI2H		0x1fe	/* RO */
-#define INTEL_MSIC_ADC1BI2L		0x1ff	/* RO */
-#define INTEL_MSIC_ADC1BI3H		0x200	/* RO */
-#define INTEL_MSIC_ADC1BI3L		0x201	/* RO */
-#define INTEL_MSIC_CCCNTL		0x202
-#define INTEL_MSIC_CCOFFSETH		0x203	/* RO */
-#define INTEL_MSIC_CCOFFSETL		0x204	/* RO */
-#define INTEL_MSIC_CCADCHA		0x205	/* RO */
-#define INTEL_MSIC_CCADCLA		0x206	/* RO */
-
-/* AUDIO */
-#define INTEL_MSIC_AUDPLLCTRL		0x240
-#define INTEL_MSIC_DMICBUF0123		0x241
-#define INTEL_MSIC_DMICBUF45		0x242
-#define INTEL_MSIC_DMICGPO		0x244
-#define INTEL_MSIC_DMICMUX		0x245
-#define INTEL_MSIC_DMICCLK		0x246
-#define INTEL_MSIC_MICBIAS		0x247
-#define INTEL_MSIC_ADCCONFIG		0x248
-#define INTEL_MSIC_MICAMP1		0x249
-#define INTEL_MSIC_MICAMP2		0x24a
-#define INTEL_MSIC_NOISEMUX		0x24b
-#define INTEL_MSIC_AUDIOMUX12		0x24c
-#define INTEL_MSIC_AUDIOMUX34		0x24d
-#define INTEL_MSIC_AUDIOSINC		0x24e
-#define INTEL_MSIC_AUDIOTXEN		0x24f
-#define INTEL_MSIC_HSEPRXCTRL		0x250
-#define INTEL_MSIC_IHFRXCTRL		0x251
-#define INTEL_MSIC_VOICETXVOL		0x252
-#define INTEL_MSIC_SIDETONEVOL		0x253
-#define INTEL_MSIC_MUSICSHARVOL		0x254
-#define INTEL_MSIC_VOICETXCTRL		0x255
-#define INTEL_MSIC_HSMIXER		0x256
-#define INTEL_MSIC_DACCONFIG		0x257
-#define INTEL_MSIC_SOFTMUTE		0x258
-#define INTEL_MSIC_HSLVOLCTRL		0x259
-#define INTEL_MSIC_HSRVOLCTRL		0x25a
-#define INTEL_MSIC_IHFLVOLCTRL		0x25b
-#define INTEL_MSIC_IHFRVOLCTRL		0x25c
-#define INTEL_MSIC_DRIVEREN		0x25d
-#define INTEL_MSIC_LINEOUTCTRL		0x25e
-#define INTEL_MSIC_VIB1CTRL1		0x25f
-#define INTEL_MSIC_VIB1CTRL2		0x260
-#define INTEL_MSIC_VIB1CTRL3		0x261
-#define INTEL_MSIC_VIB1SPIPCM_1		0x262
-#define INTEL_MSIC_VIB1SPIPCM_2		0x263
-#define INTEL_MSIC_VIB1CTRL5		0x264
-#define INTEL_MSIC_VIB2CTRL1		0x265
-#define INTEL_MSIC_VIB2CTRL2		0x266
-#define INTEL_MSIC_VIB2CTRL3		0x267
-#define INTEL_MSIC_VIB2SPIPCM_1		0x268
-#define INTEL_MSIC_VIB2SPIPCM_2		0x269
-#define INTEL_MSIC_VIB2CTRL5		0x26a
-#define INTEL_MSIC_BTNCTRL1		0x26b
-#define INTEL_MSIC_BTNCTRL2		0x26c
-#define INTEL_MSIC_PCM1TXSLOT01		0x26d
-#define INTEL_MSIC_PCM1TXSLOT23		0x26e
-#define INTEL_MSIC_PCM1TXSLOT45		0x26f
-#define INTEL_MSIC_PCM1RXSLOT0123	0x270
-#define INTEL_MSIC_PCM1RXSLOT045	0x271
-#define INTEL_MSIC_PCM2TXSLOT01		0x272
-#define INTEL_MSIC_PCM2TXSLOT23		0x273
-#define INTEL_MSIC_PCM2TXSLOT45		0x274
-#define INTEL_MSIC_PCM2RXSLOT01		0x275
-#define INTEL_MSIC_PCM2RXSLOT23		0x276
-#define INTEL_MSIC_PCM2RXSLOT45		0x277
-#define INTEL_MSIC_PCM1CTRL1		0x278
-#define INTEL_MSIC_PCM1CTRL2		0x279
-#define INTEL_MSIC_PCM1CTRL3		0x27a
-#define INTEL_MSIC_PCM2CTRL1		0x27b
-#define INTEL_MSIC_PCM2CTRL2		0x27c
-
-/* HDMI */
-#define INTEL_MSIC_HDMIPUEN		0x280
-#define INTEL_MSIC_HDMISTATUS		0x281	/* RO */
-
-/* Physical address of the start of the MSIC interrupt tree in SRAM */
-#define INTEL_MSIC_IRQ_PHYS_BASE	0xffff7fc0
-
-/**
- * struct intel_msic_gpio_pdata - platform data for the MSIC GPIO driver
- * @gpio_base: base number for the GPIOs
- */
-struct intel_msic_gpio_pdata {
-	unsigned	gpio_base;
-};
-
-/**
- * struct intel_msic_ocd_pdata - platform data for the MSIC OCD driver
- * @gpio: GPIO number used for OCD interrupts
- *
- * The MSIC MFD driver converts @gpio into an IRQ number and passes it to
- * the OCD driver as %IORESOURCE_IRQ.
- */
-struct intel_msic_ocd_pdata {
-	unsigned	gpio;
-};
-
-/* MSIC embedded blocks (subdevices) */
-enum intel_msic_block {
-	INTEL_MSIC_BLOCK_TOUCH,
-	INTEL_MSIC_BLOCK_ADC,
-	INTEL_MSIC_BLOCK_BATTERY,
-	INTEL_MSIC_BLOCK_GPIO,
-	INTEL_MSIC_BLOCK_AUDIO,
-	INTEL_MSIC_BLOCK_HDMI,
-	INTEL_MSIC_BLOCK_THERMAL,
-	INTEL_MSIC_BLOCK_POWER_BTN,
-	INTEL_MSIC_BLOCK_OCD,
-
-	INTEL_MSIC_BLOCK_LAST,
-};
-
-/**
- * struct intel_msic_platform_data - platform data for the MSIC driver
- * @irq: array of interrupt numbers, one per device. If @irq is set to %0
- *	 for a given block, the corresponding platform device is not
- *	 created. For devices which don't have an interrupt, use %0xff
- *	 (this is same as in SFI spec).
- * @gpio: platform data for the MSIC GPIO driver
- * @ocd: platform data for the MSIC OCD driver
- *
- * Once the MSIC driver is initialized, the register interface is ready to
- * use. All the platform devices for subdevices are created after the
- * register interface is ready so that we can guarantee its availability to
- * the subdevice drivers.
- *
- * Interrupt numbers are passed to the subdevices via %IORESOURCE_IRQ
- * resources of the created platform device.
- */
-struct intel_msic_platform_data {
-	int				irq[INTEL_MSIC_BLOCK_LAST];
-	struct intel_msic_gpio_pdata	*gpio;
-	struct intel_msic_ocd_pdata	*ocd;
-};
-
-struct intel_msic;
-
-extern int intel_msic_reg_read(unsigned short reg, u8 *val);
-extern int intel_msic_reg_write(unsigned short reg, u8 val);
-extern int intel_msic_reg_update(unsigned short reg, u8 val, u8 mask);
-extern int intel_msic_bulk_read(unsigned short *reg, u8 *buf, size_t count);
-extern int intel_msic_bulk_write(unsigned short *reg, u8 *buf, size_t count);
-
-/*
- * pdev_to_intel_msic - gets an MSIC instance from the platform device
- * @pdev: platform device pointer
- *
- * The client drivers need to have pointer to the MSIC instance if they
- * want to call intel_msic_irq_read(). This macro can be used for
- * convenience to get the MSIC pointer from @pdev where needed. This is
- * _only_ valid for devices which are managed by the MSIC.
- */
-#define pdev_to_intel_msic(pdev)	(dev_get_drvdata(pdev->dev.parent))
-
-extern int intel_msic_irq_read(struct intel_msic *msic, unsigned short reg,
-			       u8 *val);
-
-#endif /* __LINUX_MFD_INTEL_MSIC_H__ */
-- 
2.29.2

