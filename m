Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62970303170
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbhAZBZR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 20:25:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:17884 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731990AbhAYTlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:52 -0500
IronPort-SDR: yIg1QPgYFK5RRThVeG1Y8171qyys6DmrJVZyi+P+93O3oIKZ1xqx5Qh/NcpuyAUcUoMFvPnCAf
 hZCu3w9whe6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="198569927"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="198569927"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:58 -0800
IronPort-SDR: tol8rmUZecae693wLdLAxXd3O/1JC6IhAz6L4F9whV2/5LUTjUlUzxrLc/7pDhJHw4cHQWGYR3
 o4wqvoPxe4Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="409817646"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Jan 2021 11:39:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D986343B; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 08/10] x86/platform/intel-mid: Remove unused leftovers (vRTC)
Date:   Mon, 25 Jan 2021 21:39:46 +0200
Message-Id: <20210125193948.56760-9-andriy.shevchenko@linux.intel.com>
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
 arch/x86/include/asm/fixmap.h                |   3 -
 arch/x86/include/asm/intel-mid.h             |  10 --
 arch/x86/include/asm/intel_mid_vrtc.h        |  10 --
 arch/x86/include/asm/intel_scu_ipc_legacy.h  |   5 -
 arch/x86/platform/intel-mid/Makefile         |   2 +-
 arch/x86/platform/intel-mid/intel-mid.c      |   2 -
 arch/x86/platform/intel-mid/intel_mid_vrtc.c | 173 -------------------
 arch/x86/platform/intel-mid/sfi.c            |  42 -----
 8 files changed, 1 insertion(+), 246 deletions(-)
 delete mode 100644 arch/x86/include/asm/intel_mid_vrtc.h
 delete mode 100644 arch/x86/platform/intel-mid/intel_mid_vrtc.c

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 9f1a0a987e5e..d0dcefb5cc59 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -108,9 +108,6 @@ enum fixed_addresses {
 #ifdef CONFIG_PARAVIRT_XXL
 	FIX_PARAVIRT_BOOTMAP,
 #endif
-#ifdef	CONFIG_X86_INTEL_MID
-	FIX_LNW_VRTC,
-#endif
 
 #ifdef CONFIG_ACPI_APEI_GHES
 	/* Used for GHES mapping from assorted contexts */
diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index e68ae2155db3..9a6f8b1bebcd 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -23,10 +23,7 @@ extern void intel_mid_pwr_power_off(void);
 extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
 
 extern int get_gpio_by_name(const char *name);
-extern int __init sfi_parse_mrtc(struct sfi_table_header *table);
 extern int __init sfi_parse_mtmr(struct sfi_table_header *table);
-extern int sfi_mrtc_num;
-extern struct sfi_rtc_table_entry sfi_mrtc_array[];
 
 /*
  * Here defines the array of devices platform data that IAFW would export
@@ -112,13 +109,6 @@ extern enum intel_mid_timer_options intel_mid_timer_options;
 #define BSEL_SOC_FUSE_111		0x7
 
 #define SFI_MTMR_MAX_NUM		8
-#define SFI_MRTC_MAX			8
-
-/* VRTC timer */
-#define MRST_VRTC_MAP_SZ		1024
-/* #define MRST_VRTC_PGOFFSET		0xc00 */
-
-extern void intel_mid_rtc_init(void);
 
 /* The offset for the mapping of global gpio pin to irq */
 #define INTEL_MID_IRQ_OFFSET		0x100
diff --git a/arch/x86/include/asm/intel_mid_vrtc.h b/arch/x86/include/asm/intel_mid_vrtc.h
deleted file mode 100644
index 0b44b1abe4d9..000000000000
--- a/arch/x86/include/asm/intel_mid_vrtc.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _INTEL_MID_VRTC_H
-#define _INTEL_MID_VRTC_H
-
-extern unsigned char vrtc_cmos_read(unsigned char reg);
-extern void vrtc_cmos_write(unsigned char val, unsigned char reg);
-extern void vrtc_get_time(struct timespec64 *now);
-extern int vrtc_set_mmss(const struct timespec64 *now);
-
-#endif
diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
index 4cf13fecb673..2232197c24f8 100644
--- a/arch/x86/include/asm/intel_scu_ipc_legacy.h
+++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
@@ -14,11 +14,6 @@
 #define IPCMSG_SOFT_RESET	0xF2
 #define IPCMSG_COLD_BOOT	0xF3
 
-#define IPCMSG_VRTC		0xFA	/* Set vRTC device */
-/* Command id associated with message IPCMSG_VRTC */
-#define IPC_CMD_VRTC_SETTIME      1	/* Set time */
-#define IPC_CMD_VRTC_SETALARM     2	/* Set alarm */
-
 /* Don't call these in new code - they will be removed eventually */
 
 /* Read single register */
diff --git a/arch/x86/platform/intel-mid/Makefile b/arch/x86/platform/intel-mid/Makefile
index cc2549f0ccb1..5794e661050c 100644
--- a/arch/x86/platform/intel-mid/Makefile
+++ b/arch/x86/platform/intel-mid/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_X86_INTEL_MID) += intel-mid.o intel_mid_vrtc.o pwr.o
+obj-$(CONFIG_X86_INTEL_MID) += intel-mid.o pwr.o
 
 # SFI specific code
 ifdef CONFIG_X86_INTEL_MID
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 780728161f7d..ada39fb426dd 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -25,7 +25,6 @@
 #include <asm/apic.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
-#include <asm/intel_mid_vrtc.h>
 #include <asm/io.h>
 #include <asm/i8259.h>
 #include <asm/intel_scu_ipc.h>
@@ -159,7 +158,6 @@ void __init x86_intel_mid_early_setup(void)
 
 	x86_init.timers.timer_init = intel_mid_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
-	x86_init.timers.wallclock_init = intel_mid_rtc_init;
 
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 
diff --git a/arch/x86/platform/intel-mid/intel_mid_vrtc.c b/arch/x86/platform/intel-mid/intel_mid_vrtc.c
deleted file mode 100644
index 2226da4f437a..000000000000
--- a/arch/x86/platform/intel-mid/intel_mid_vrtc.c
+++ /dev/null
@@ -1,173 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * intel_mid_vrtc.c: Driver for virtual RTC device on Intel MID platform
- *
- * (C) Copyright 2009 Intel Corporation
- *
- * Note:
- * VRTC is emulated by system controller firmware, the real HW
- * RTC is located in the PMIC device. SCU FW shadows PMIC RTC
- * in a memory mapped IO space that is visible to the host IA
- * processor.
- *
- * This driver is based on RTC CMOS driver.
- */
-
-#include <linux/kernel.h>
-#include <linux/export.h>
-#include <linux/init.h>
-#include <linux/sfi.h>
-#include <linux/platform_device.h>
-#include <linux/mc146818rtc.h>
-
-#include <asm/intel-mid.h>
-#include <asm/intel_mid_vrtc.h>
-#include <asm/time.h>
-#include <asm/fixmap.h>
-
-static unsigned char __iomem *vrtc_virt_base;
-
-unsigned char vrtc_cmos_read(unsigned char reg)
-{
-	unsigned char retval;
-
-	/* vRTC's registers range from 0x0 to 0xD */
-	if (reg > 0xd || !vrtc_virt_base)
-		return 0xff;
-
-	lock_cmos_prefix(reg);
-	retval = __raw_readb(vrtc_virt_base + (reg << 2));
-	lock_cmos_suffix(reg);
-	return retval;
-}
-EXPORT_SYMBOL_GPL(vrtc_cmos_read);
-
-void vrtc_cmos_write(unsigned char val, unsigned char reg)
-{
-	if (reg > 0xd || !vrtc_virt_base)
-		return;
-
-	lock_cmos_prefix(reg);
-	__raw_writeb(val, vrtc_virt_base + (reg << 2));
-	lock_cmos_suffix(reg);
-}
-EXPORT_SYMBOL_GPL(vrtc_cmos_write);
-
-void vrtc_get_time(struct timespec64 *now)
-{
-	u8 sec, min, hour, mday, mon;
-	unsigned long flags;
-	u32 year;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-
-	while ((vrtc_cmos_read(RTC_FREQ_SELECT) & RTC_UIP))
-		cpu_relax();
-
-	sec = vrtc_cmos_read(RTC_SECONDS);
-	min = vrtc_cmos_read(RTC_MINUTES);
-	hour = vrtc_cmos_read(RTC_HOURS);
-	mday = vrtc_cmos_read(RTC_DAY_OF_MONTH);
-	mon = vrtc_cmos_read(RTC_MONTH);
-	year = vrtc_cmos_read(RTC_YEAR);
-
-	spin_unlock_irqrestore(&rtc_lock, flags);
-
-	/* vRTC YEAR reg contains the offset to 1972 */
-	year += 1972;
-
-	pr_info("vRTC: sec: %d min: %d hour: %d day: %d "
-		"mon: %d year: %d\n", sec, min, hour, mday, mon, year);
-
-	now->tv_sec = mktime64(year, mon, mday, hour, min, sec);
-	now->tv_nsec = 0;
-}
-
-int vrtc_set_mmss(const struct timespec64 *now)
-{
-	unsigned long flags;
-	struct rtc_time tm;
-	int year;
-	int retval = 0;
-
-	rtc_time64_to_tm(now->tv_sec, &tm);
-	if (!rtc_valid_tm(&tm) && tm.tm_year >= 72) {
-		/*
-		 * tm.year is the number of years since 1900, and the
-		 * vrtc need the years since 1972.
-		 */
-		year = tm.tm_year - 72;
-		spin_lock_irqsave(&rtc_lock, flags);
-		vrtc_cmos_write(year, RTC_YEAR);
-		vrtc_cmos_write(tm.tm_mon, RTC_MONTH);
-		vrtc_cmos_write(tm.tm_mday, RTC_DAY_OF_MONTH);
-		vrtc_cmos_write(tm.tm_hour, RTC_HOURS);
-		vrtc_cmos_write(tm.tm_min, RTC_MINUTES);
-		vrtc_cmos_write(tm.tm_sec, RTC_SECONDS);
-		spin_unlock_irqrestore(&rtc_lock, flags);
-	} else {
-		pr_err("%s: Invalid vRTC value: write of %llx to vRTC failed\n",
-			__func__, (s64)now->tv_sec);
-		retval = -EINVAL;
-	}
-	return retval;
-}
-
-void __init intel_mid_rtc_init(void)
-{
-	unsigned long vrtc_paddr;
-
-	sfi_table_parse(SFI_SIG_MRTC, NULL, NULL, sfi_parse_mrtc);
-
-	vrtc_paddr = sfi_mrtc_array[0].phys_addr;
-	if (!sfi_mrtc_num || !vrtc_paddr)
-		return;
-
-	vrtc_virt_base = (void __iomem *)set_fixmap_offset_nocache(FIX_LNW_VRTC,
-								vrtc_paddr);
-	x86_platform.get_wallclock = vrtc_get_time;
-	x86_platform.set_wallclock = vrtc_set_mmss;
-}
-
-/*
- * The Moorestown platform has a memory mapped virtual RTC device that emulates
- * the programming interface of the RTC.
- */
-
-static struct resource vrtc_resources[] = {
-	[0] = {
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device vrtc_device = {
-	.name		= "rtc_mrst",
-	.id		= -1,
-	.resource	= vrtc_resources,
-	.num_resources	= ARRAY_SIZE(vrtc_resources),
-};
-
-/* Register the RTC device if appropriate */
-static int __init intel_mid_device_create(void)
-{
-	/* No Moorestown, no device */
-	if (!intel_mid_identify_cpu())
-		return -ENODEV;
-	/* No timer, no device */
-	if (!sfi_mrtc_num)
-		return -ENODEV;
-
-	/* iomem resource */
-	vrtc_resources[0].start = sfi_mrtc_array[0].phys_addr;
-	vrtc_resources[0].end = sfi_mrtc_array[0].phys_addr +
-				MRST_VRTC_MAP_SZ;
-	/* irq resource */
-	vrtc_resources[1].start = sfi_mrtc_array[0].irq;
-	vrtc_resources[1].end = sfi_mrtc_array[0].irq;
-
-	return platform_device_register(&vrtc_device);
-}
-device_initcall(intel_mid_device_create);
diff --git a/arch/x86/platform/intel-mid/sfi.c b/arch/x86/platform/intel-mid/sfi.c
index 2b22587bfd3d..a50698e90a9c 100644
--- a/arch/x86/platform/intel-mid/sfi.c
+++ b/arch/x86/platform/intel-mid/sfi.c
@@ -31,7 +31,6 @@
 #include <asm/apic.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
-#include <asm/intel_mid_vrtc.h>
 #include <asm/io.h>
 #include <asm/i8259.h>
 #include <asm/intel_scu_ipc.h>
@@ -54,12 +53,8 @@ static int i2c_next_dev;
 static int i2c_bus[MAX_SCU_I2C];
 static int gpio_num_entry;
 static u32 sfi_mtimer_usage[SFI_MTMR_MAX_NUM];
-int sfi_mrtc_num;
 int sfi_mtimer_num;
 
-struct sfi_rtc_table_entry sfi_mrtc_array[SFI_MRTC_MAX];
-EXPORT_SYMBOL_GPL(sfi_mrtc_array);
-
 struct blocking_notifier_head intel_scu_notifier =
 			BLOCKING_NOTIFIER_INIT(intel_scu_notifier);
 EXPORT_SYMBOL_GPL(intel_scu_notifier);
@@ -138,43 +133,6 @@ void sfi_free_mtmr(struct sfi_timer_table_entry *mtmr)
 	}
 }
 
-/* parse all the mrtc info to a global mrtc array */
-int __init sfi_parse_mrtc(struct sfi_table_header *table)
-{
-	struct sfi_table_simple *sb;
-	struct sfi_rtc_table_entry *pentry;
-	struct mpc_intsrc mp_irq;
-
-	int totallen;
-
-	sb = (struct sfi_table_simple *)table;
-	if (!sfi_mrtc_num) {
-		sfi_mrtc_num = SFI_GET_NUM_ENTRIES(sb,
-						struct sfi_rtc_table_entry);
-		pentry = (struct sfi_rtc_table_entry *)sb->pentry;
-		totallen = sfi_mrtc_num * sizeof(*pentry);
-		memcpy(sfi_mrtc_array, pentry, totallen);
-	}
-
-	pr_debug("SFI RTC info (num = %d):\n", sfi_mrtc_num);
-	pentry = sfi_mrtc_array;
-	for (totallen = 0; totallen < sfi_mrtc_num; totallen++, pentry++) {
-		pr_debug("RTC[%d]: paddr = 0x%08x, irq = %d\n",
-			totallen, (u32)pentry->phys_addr, pentry->irq);
-		mp_irq.type = MP_INTSRC;
-		mp_irq.irqtype = mp_INT;
-		mp_irq.irqflag = MP_IRQTRIG_LEVEL | MP_IRQPOL_ACTIVE_LOW;
-		mp_irq.srcbus = MP_BUS_ISA;
-		mp_irq.srcbusirq = pentry->irq;	/* IRQ */
-		mp_irq.dstapic = MP_APIC_ALL;
-		mp_irq.dstirq = pentry->irq;
-		mp_save_irq(&mp_irq);
-		mp_map_gsi_to_irq(pentry->irq, IOAPIC_MAP_ALLOC, NULL);
-	}
-	return 0;
-}
-
-
 /*
  * Parsing GPIO table first, since the DEVS table will need this table
  * to map the pin name to the actual pin.
-- 
2.29.2

