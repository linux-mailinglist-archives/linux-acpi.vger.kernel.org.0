Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A735303172
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 02:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbhAZBZP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 Jan 2021 20:25:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:32982 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732032AbhAYTlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Jan 2021 14:41:52 -0500
IronPort-SDR: Pb44m1bQZAB0gzxhEWmhpa/obU4hiYVn8NaxLEiMaPDoQnrzDmZu3/2Jn8j4OnlU4pWuwYGOJ8
 Qvn0C8nU6xnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="177218364"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="177218364"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 11:39:58 -0800
IronPort-SDR: kEaY+26mwA4hjcmlS2XO1IrKkqrnNA5G06M8HvS1KPzv4Imocx9cYdedDtFkSxLGfFmtWLDwF6
 KtA+YEExT2VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="402468439"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jan 2021 11:39:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E397B4B1; Mon, 25 Jan 2021 21:39:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 09/10] x86/apb_timer: Remove driver for deprecated platform
Date:   Mon, 25 Jan 2021 21:39:47 +0200
Message-Id: <20210125193948.56760-10-andriy.shevchenko@linux.intel.com>
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
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../admin-guide/kernel-parameters.txt         |   6 -
 arch/x86/Kconfig                              |  12 -
 arch/x86/include/asm/apb_timer.h              |  40 --
 arch/x86/include/asm/intel-mid.h              |  11 -
 arch/x86/kernel/Makefile                      |   1 -
 arch/x86/kernel/apb_timer.c                   | 347 ------------------
 arch/x86/platform/intel-mid/intel-mid.c       |  77 +---
 arch/x86/platform/intel-mid/sfi.c             |  75 ----
 8 files changed, 3 insertions(+), 566 deletions(-)
 delete mode 100644 arch/x86/include/asm/apb_timer.h
 delete mode 100644 arch/x86/kernel/apb_timer.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec19cd00..87a76a04189f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5932,12 +5932,6 @@
 			default x2apic cluster mode on platforms
 			supporting x2apic.
 
-	x86_intel_mid_timer= [X86-32,APBT]
-			Choose timer option for x86 Intel MID platform.
-			Two valid options are apbt timer only and lapic timer
-			plus one apbt timer for broadcast timer.
-			x86_intel_mid_timer=apbt_only | lapic_and_apbt
-
 	xen_512gb_limit		[KNL,X86-64,XEN]
 			Restricts the kernel running paravirtualized under Xen
 			to use only up to 512 GB of RAM. The reason to do so is
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b6dd10b162a..66539749ff43 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -891,18 +891,6 @@ config HPET_EMULATE_RTC
 	def_bool y
 	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
 
-config APB_TIMER
-	def_bool y if X86_INTEL_MID
-	prompt "Intel MID APB Timer Support" if X86_INTEL_MID
-	select DW_APB_TIMER
-	depends on X86_INTEL_MID && SFI
-	help
-	 APB timer is the replacement for 8254, HPET on X86 MID platforms.
-	 The APBT provides a stable time base on SMP
-	 systems, unlike the TSC, but it is more expensive to access,
-	 as it is off-chip. APB timers are always running regardless of CPU
-	 C states, they are used as per CPU clockevent device when possible.
-
 # Mark as expert because too many people got it wrong.
 # The code disables itself when not needed.
 config DMI
diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_timer.h
deleted file mode 100644
index 87ce8e963215..000000000000
--- a/arch/x86/include/asm/apb_timer.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * apb_timer.h: Driver for Langwell APB timer based on Synopsis DesignWare
- *
- * (C) Copyright 2009 Intel Corporation
- * Author: Jacob Pan (jacob.jun.pan@intel.com)
- *
- * Note:
- */
-
-#ifndef ASM_X86_APBT_H
-#define ASM_X86_APBT_H
-#include <linux/sfi.h>
-
-#ifdef CONFIG_APB_TIMER
-
-/* default memory mapped register base */
-#define LNW_SCU_ADDR           0xFF100000
-#define LNW_EXT_TIMER_OFFSET   0x1B800
-#define APBT_DEFAULT_BASE      (LNW_SCU_ADDR+LNW_EXT_TIMER_OFFSET)
-#define LNW_EXT_TIMER_PGOFFSET         0x800
-
-/* APBT clock speed range from PCLK to fabric base, 25-100MHz */
-#define APBT_MAX_FREQ          50000000
-#define APBT_MIN_FREQ          1000000
-#define APBT_MMAP_SIZE         1024
-
-extern void apbt_time_init(void);
-extern void apbt_setup_secondary_clock(void);
-
-extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint);
-extern void sfi_free_mtmr(struct sfi_timer_table_entry *mtmr);
-extern int sfi_mtimer_num;
-
-#else /* CONFIG_APB_TIMER */
-
-static inline void apbt_time_init(void) { }
-
-#endif
-#endif /* ASM_X86_APBT_H */
diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 9a6f8b1bebcd..7bda0587cf70 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -23,7 +23,6 @@ extern void intel_mid_pwr_power_off(void);
 extern int intel_mid_pwr_get_lss_id(struct pci_dev *pdev);
 
 extern int get_gpio_by_name(const char *name);
-extern int __init sfi_parse_mtmr(struct sfi_table_header *table);
 
 /*
  * Here defines the array of devices platform data that IAFW would export
@@ -91,14 +90,6 @@ static inline void intel_scu_devices_destroy(void) { }
 
 #endif /* !CONFIG_X86_INTEL_MID */
 
-enum intel_mid_timer_options {
-	INTEL_MID_TIMER_DEFAULT,
-	INTEL_MID_TIMER_APBT_ONLY,
-	INTEL_MID_TIMER_LAPIC_APBT,
-};
-
-extern enum intel_mid_timer_options intel_mid_timer_options;
-
 /* Bus Select SoC Fuse value */
 #define BSEL_SOC_FUSE_MASK		0x7
 /* FSB 133MHz */
@@ -108,8 +99,6 @@ extern enum intel_mid_timer_options intel_mid_timer_options;
 /* FSB 83MHz */
 #define BSEL_SOC_FUSE_111		0x7
 
-#define SFI_MTMR_MAX_NUM		8
-
 /* The offset for the mapping of global gpio pin to irq */
 #define INTEL_MID_IRQ_OFFSET		0x100
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 5eeb808eb024..2ddf08351f0b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -116,7 +116,6 @@ obj-$(CONFIG_VM86)		+= vm86_32.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_HPET_TIMER) 	+= hpet.o
-obj-$(CONFIG_APB_TIMER)		+= apb_timer.o
 
 obj-$(CONFIG_AMD_NB)		+= amd_nb.o
 obj-$(CONFIG_DEBUG_NMI_SELFTEST) += nmi_selftest.o
diff --git a/arch/x86/kernel/apb_timer.c b/arch/x86/kernel/apb_timer.c
deleted file mode 100644
index 263eeaddb0aa..000000000000
--- a/arch/x86/kernel/apb_timer.c
+++ /dev/null
@@ -1,347 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * apb_timer.c: Driver for Langwell APB timers
- *
- * (C) Copyright 2009 Intel Corporation
- * Author: Jacob Pan (jacob.jun.pan@intel.com)
- *
- * Note:
- * Langwell is the south complex of Intel Moorestown MID platform. There are
- * eight external timers in total that can be used by the operating system.
- * The timer information, such as frequency and addresses, is provided to the
- * OS via SFI tables.
- * Timer interrupts are routed via FW/HW emulated IOAPIC independently via
- * individual redirection table entries (RTE).
- * Unlike HPET, there is no master counter, therefore one of the timers are
- * used as clocksource. The overall allocation looks like:
- *  - timer 0 - NR_CPUs for per cpu timer
- *  - one timer for clocksource
- *  - one timer for watchdog driver.
- * It is also worth notice that APB timer does not support true one-shot mode,
- * free-running mode will be used here to emulate one-shot mode.
- * APB timer can also be used as broadcast timer along with per cpu local APIC
- * timer, but by default APB timer has higher rating than local APIC timers.
- */
-
-#include <linux/delay.h>
-#include <linux/dw_apb_timer.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/pm.h>
-#include <linux/sfi.h>
-#include <linux/interrupt.h>
-#include <linux/cpu.h>
-#include <linux/irq.h>
-
-#include <asm/fixmap.h>
-#include <asm/apb_timer.h>
-#include <asm/intel-mid.h>
-#include <asm/time.h>
-
-#define APBT_CLOCKEVENT_RATING		110
-#define APBT_CLOCKSOURCE_RATING		250
-
-#define APBT_CLOCKEVENT0_NUM   (0)
-#define APBT_CLOCKSOURCE_NUM   (2)
-
-static phys_addr_t apbt_address;
-static int apb_timer_block_enabled;
-static void __iomem *apbt_virt_address;
-
-/*
- * Common DW APB timer info
- */
-static unsigned long apbt_freq;
-
-struct apbt_dev {
-	struct dw_apb_clock_event_device	*timer;
-	unsigned int				num;
-	int					cpu;
-	unsigned int				irq;
-	char					name[10];
-};
-
-static struct dw_apb_clocksource *clocksource_apbt;
-
-static inline void __iomem *adev_virt_addr(struct apbt_dev *adev)
-{
-	return apbt_virt_address + adev->num * APBTMRS_REG_SIZE;
-}
-
-static DEFINE_PER_CPU(struct apbt_dev, cpu_apbt_dev);
-
-#ifdef CONFIG_SMP
-static unsigned int apbt_num_timers_used;
-#endif
-
-static inline void apbt_set_mapping(void)
-{
-	struct sfi_timer_table_entry *mtmr;
-	int phy_cs_timer_id = 0;
-
-	if (apbt_virt_address) {
-		pr_debug("APBT base already mapped\n");
-		return;
-	}
-	mtmr = sfi_get_mtmr(APBT_CLOCKEVENT0_NUM);
-	if (mtmr == NULL) {
-		printk(KERN_ERR "Failed to get MTMR %d from SFI\n",
-		       APBT_CLOCKEVENT0_NUM);
-		return;
-	}
-	apbt_address = (phys_addr_t)mtmr->phys_addr;
-	if (!apbt_address) {
-		printk(KERN_WARNING "No timer base from SFI, use default\n");
-		apbt_address = APBT_DEFAULT_BASE;
-	}
-	apbt_virt_address = ioremap(apbt_address, APBT_MMAP_SIZE);
-	if (!apbt_virt_address) {
-		pr_debug("Failed mapping APBT phy address at %lu\n",\
-			 (unsigned long)apbt_address);
-		goto panic_noapbt;
-	}
-	apbt_freq = mtmr->freq_hz;
-	sfi_free_mtmr(mtmr);
-
-	/* Now figure out the physical timer id for clocksource device */
-	mtmr = sfi_get_mtmr(APBT_CLOCKSOURCE_NUM);
-	if (mtmr == NULL)
-		goto panic_noapbt;
-
-	/* Now figure out the physical timer id */
-	pr_debug("Use timer %d for clocksource\n",
-		 (int)(mtmr->phys_addr & 0xff) / APBTMRS_REG_SIZE);
-	phy_cs_timer_id = (unsigned int)(mtmr->phys_addr & 0xff) /
-		APBTMRS_REG_SIZE;
-
-	clocksource_apbt = dw_apb_clocksource_init(APBT_CLOCKSOURCE_RATING,
-		"apbt0", apbt_virt_address + phy_cs_timer_id *
-		APBTMRS_REG_SIZE, apbt_freq);
-	return;
-
-panic_noapbt:
-	panic("Failed to setup APB system timer\n");
-
-}
-
-static inline void apbt_clear_mapping(void)
-{
-	iounmap(apbt_virt_address);
-	apbt_virt_address = NULL;
-}
-
-static int __init apbt_clockevent_register(void)
-{
-	struct sfi_timer_table_entry *mtmr;
-	struct apbt_dev *adev = this_cpu_ptr(&cpu_apbt_dev);
-
-	mtmr = sfi_get_mtmr(APBT_CLOCKEVENT0_NUM);
-	if (mtmr == NULL) {
-		printk(KERN_ERR "Failed to get MTMR %d from SFI\n",
-		       APBT_CLOCKEVENT0_NUM);
-		return -ENODEV;
-	}
-
-	adev->num = smp_processor_id();
-	adev->timer = dw_apb_clockevent_init(smp_processor_id(), "apbt0",
-		intel_mid_timer_options == INTEL_MID_TIMER_LAPIC_APBT ?
-		APBT_CLOCKEVENT_RATING - 100 : APBT_CLOCKEVENT_RATING,
-		adev_virt_addr(adev), 0, apbt_freq);
-	/* Firmware does EOI handling for us. */
-	adev->timer->eoi = NULL;
-
-	if (intel_mid_timer_options == INTEL_MID_TIMER_LAPIC_APBT) {
-		global_clock_event = &adev->timer->ced;
-		printk(KERN_DEBUG "%s clockevent registered as global\n",
-		       global_clock_event->name);
-	}
-
-	dw_apb_clockevent_register(adev->timer);
-
-	sfi_free_mtmr(mtmr);
-	return 0;
-}
-
-#ifdef CONFIG_SMP
-
-static void apbt_setup_irq(struct apbt_dev *adev)
-{
-	irq_modify_status(adev->irq, 0, IRQ_MOVE_PCNTXT);
-	irq_set_affinity(adev->irq, cpumask_of(adev->cpu));
-}
-
-/* Should be called with per cpu */
-void apbt_setup_secondary_clock(void)
-{
-	struct apbt_dev *adev;
-	int cpu;
-
-	/* Don't register boot CPU clockevent */
-	cpu = smp_processor_id();
-	if (!cpu)
-		return;
-
-	adev = this_cpu_ptr(&cpu_apbt_dev);
-	if (!adev->timer) {
-		adev->timer = dw_apb_clockevent_init(cpu, adev->name,
-			APBT_CLOCKEVENT_RATING, adev_virt_addr(adev),
-			adev->irq, apbt_freq);
-		adev->timer->eoi = NULL;
-	} else {
-		dw_apb_clockevent_resume(adev->timer);
-	}
-
-	printk(KERN_INFO "Registering CPU %d clockevent device %s, cpu %08x\n",
-	       cpu, adev->name, adev->cpu);
-
-	apbt_setup_irq(adev);
-	dw_apb_clockevent_register(adev->timer);
-
-	return;
-}
-
-/*
- * this notify handler process CPU hotplug events. in case of S0i3, nonboot
- * cpus are disabled/enabled frequently, for performance reasons, we keep the
- * per cpu timer irq registered so that we do need to do free_irq/request_irq.
- *
- * TODO: it might be more reliable to directly disable percpu clockevent device
- * without the notifier chain. currently, cpu 0 may get interrupts from other
- * cpu timers during the offline process due to the ordering of notification.
- * the extra interrupt is harmless.
- */
-static int apbt_cpu_dead(unsigned int cpu)
-{
-	struct apbt_dev *adev = &per_cpu(cpu_apbt_dev, cpu);
-
-	dw_apb_clockevent_pause(adev->timer);
-	if (system_state == SYSTEM_RUNNING) {
-		pr_debug("skipping APBT CPU %u offline\n", cpu);
-	} else {
-		pr_debug("APBT clockevent for cpu %u offline\n", cpu);
-		dw_apb_clockevent_stop(adev->timer);
-	}
-	return 0;
-}
-
-static __init int apbt_late_init(void)
-{
-	if (intel_mid_timer_options == INTEL_MID_TIMER_LAPIC_APBT ||
-		!apb_timer_block_enabled)
-		return 0;
-	return cpuhp_setup_state(CPUHP_X86_APB_DEAD, "x86/apb:dead", NULL,
-				 apbt_cpu_dead);
-}
-fs_initcall(apbt_late_init);
-#else
-
-void apbt_setup_secondary_clock(void) {}
-
-#endif /* CONFIG_SMP */
-
-static int apbt_clocksource_register(void)
-{
-	u64 start, now;
-	u64 t1;
-
-	/* Start the counter, use timer 2 as source, timer 0/1 for event */
-	dw_apb_clocksource_start(clocksource_apbt);
-
-	/* Verify whether apbt counter works */
-	t1 = dw_apb_clocksource_read(clocksource_apbt);
-	start = rdtsc();
-
-	/*
-	 * We don't know the TSC frequency yet, but waiting for
-	 * 200000 TSC cycles is safe:
-	 * 4 GHz == 50us
-	 * 1 GHz == 200us
-	 */
-	do {
-		rep_nop();
-		now = rdtsc();
-	} while ((now - start) < 200000UL);
-
-	/* APBT is the only always on clocksource, it has to work! */
-	if (t1 == dw_apb_clocksource_read(clocksource_apbt))
-		panic("APBT counter not counting. APBT disabled\n");
-
-	dw_apb_clocksource_register(clocksource_apbt);
-
-	return 0;
-}
-
-/*
- * Early setup the APBT timer, only use timer 0 for booting then switch to
- * per CPU timer if possible.
- * returns 1 if per cpu apbt is setup
- * returns 0 if no per cpu apbt is chosen
- * panic if set up failed, this is the only platform timer on Moorestown.
- */
-void __init apbt_time_init(void)
-{
-#ifdef CONFIG_SMP
-	int i;
-	struct sfi_timer_table_entry *p_mtmr;
-	struct apbt_dev *adev;
-#endif
-
-	if (apb_timer_block_enabled)
-		return;
-	apbt_set_mapping();
-	if (!apbt_virt_address)
-		goto out_noapbt;
-	/*
-	 * Read the frequency and check for a sane value, for ESL model
-	 * we extend the possible clock range to allow time scaling.
-	 */
-
-	if (apbt_freq < APBT_MIN_FREQ || apbt_freq > APBT_MAX_FREQ) {
-		pr_debug("APBT has invalid freq 0x%lx\n", apbt_freq);
-		goto out_noapbt;
-	}
-	if (apbt_clocksource_register()) {
-		pr_debug("APBT has failed to register clocksource\n");
-		goto out_noapbt;
-	}
-	if (!apbt_clockevent_register())
-		apb_timer_block_enabled = 1;
-	else {
-		pr_debug("APBT has failed to register clockevent\n");
-		goto out_noapbt;
-	}
-#ifdef CONFIG_SMP
-	/* kernel cmdline disable apb timer, so we will use lapic timers */
-	if (intel_mid_timer_options == INTEL_MID_TIMER_LAPIC_APBT) {
-		printk(KERN_INFO "apbt: disabled per cpu timer\n");
-		return;
-	}
-	pr_debug("%s: %d CPUs online\n", __func__, num_online_cpus());
-	if (num_possible_cpus() <= sfi_mtimer_num)
-		apbt_num_timers_used = num_possible_cpus();
-	else
-		apbt_num_timers_used = 1;
-	pr_debug("%s: %d APB timers used\n", __func__, apbt_num_timers_used);
-
-	/* here we set up per CPU timer data structure */
-	for (i = 0; i < apbt_num_timers_used; i++) {
-		adev = &per_cpu(cpu_apbt_dev, i);
-		adev->num = i;
-		adev->cpu = i;
-		p_mtmr = sfi_get_mtmr(i);
-		if (p_mtmr)
-			adev->irq = p_mtmr->irq;
-		else
-			printk(KERN_ERR "Failed to get timer for cpu %d\n", i);
-		snprintf(adev->name, sizeof(adev->name) - 1, "apbt%d", i);
-	}
-#endif
-
-	return;
-
-out_noapbt:
-	apbt_clear_mapping();
-	apb_timer_block_enabled = 0;
-	panic("failed to enable APB timer\n");
-}
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index ada39fb426dd..864b0c158b2f 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -28,32 +28,8 @@
 #include <asm/io.h>
 #include <asm/i8259.h>
 #include <asm/intel_scu_ipc.h>
-#include <asm/apb_timer.h>
 #include <asm/reboot.h>
 
-/*
- * the clockevent devices on Moorestown/Medfield can be APBT or LAPIC clock,
- * cmdline option x86_intel_mid_timer can be used to override the configuration
- * to prefer one or the other.
- * at runtime, there are basically three timer configurations:
- * 1. per cpu apbt clock only
- * 2. per cpu always-on lapic clocks only, this is Penwell/Medfield only
- * 3. per cpu lapic clock (C3STOP) and one apbt clock, with broadcast.
- *
- * by default (without cmdline option), platform code first detects cpu type
- * to see if we are on lincroft or penwell, then set up both lapic or apbt
- * clocks accordingly.
- * i.e. by default, medfield uses configuration #2, moorestown uses #1.
- * config #3 is supported but not recommended on medfield.
- *
- * rating and feature summary:
- * lapic (with C3STOP) --------- 100
- * apbt (always-on) ------------ 110
- * lapic (always-on,ARAT) ------ 150
- */
-
-enum intel_mid_timer_options intel_mid_timer_options;
-
 enum intel_mid_cpu_type __intel_mid_cpu_chip;
 EXPORT_SYMBOL_GPL(__intel_mid_cpu_chip);
 
@@ -71,34 +47,11 @@ static void intel_mid_reboot(void)
 	intel_scu_ipc_simple_command(IPCMSG_COLD_RESET, 0);
 }
 
-static void __init intel_mid_setup_bp_timer(void)
-{
-	apbt_time_init();
-	setup_boot_APIC_clock();
-}
-
 static void __init intel_mid_time_init(void)
 {
-	sfi_table_parse(SFI_SIG_MTMR, NULL, NULL, sfi_parse_mtmr);
-
-	switch (intel_mid_timer_options) {
-	case INTEL_MID_TIMER_APBT_ONLY:
-		break;
-	case INTEL_MID_TIMER_LAPIC_APBT:
-		/* Use apbt and local apic */
-		x86_init.timers.setup_percpu_clockev = intel_mid_setup_bp_timer;
-		x86_cpuinit.setup_percpu_clockev = setup_secondary_APIC_clock;
-		return;
-	default:
-		if (!boot_cpu_has(X86_FEATURE_ARAT))
-			break;
-		/* Lapic only, no apbt */
-		x86_init.timers.setup_percpu_clockev = setup_boot_APIC_clock;
-		x86_cpuinit.setup_percpu_clockev = setup_secondary_APIC_clock;
-		return;
-	}
-
-	x86_init.timers.setup_percpu_clockev = apbt_time_init;
+	/* Lapic only, no apbt */
+	x86_init.timers.setup_percpu_clockev = setup_boot_APIC_clock;
+	x86_cpuinit.setup_percpu_clockev = setup_secondary_APIC_clock;
 }
 
 static void intel_mid_arch_setup(void)
@@ -163,8 +116,6 @@ void __init x86_intel_mid_early_setup(void)
 
 	x86_init.oem.arch_setup = intel_mid_arch_setup;
 
-	x86_cpuinit.setup_percpu_clockev = apbt_setup_secondary_clock;
-
 	x86_platform.get_nmi_reason = intel_mid_get_nmi_reason;
 
 	x86_init.pci.arch_init = intel_mid_pci_init;
@@ -186,25 +137,3 @@ void __init x86_intel_mid_early_setup(void)
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }
-
-/*
- * if user does not want to use per CPU apb timer, just give it a lower rating
- * than local apic timer and skip the late per cpu timer init.
- */
-static inline int __init setup_x86_intel_mid_timer(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	if (strcmp("apbt_only", arg) == 0)
-		intel_mid_timer_options = INTEL_MID_TIMER_APBT_ONLY;
-	else if (strcmp("lapic_and_apbt", arg) == 0)
-		intel_mid_timer_options = INTEL_MID_TIMER_LAPIC_APBT;
-	else {
-		pr_warn("X86 INTEL_MID timer option %s not recognised use x86_intel_mid_timer=apbt_only or lapic_and_apbt\n",
-			arg);
-		return -EINVAL;
-	}
-	return 0;
-}
-__setup("x86_intel_mid_timer=", setup_x86_intel_mid_timer);
diff --git a/arch/x86/platform/intel-mid/sfi.c b/arch/x86/platform/intel-mid/sfi.c
index a50698e90a9c..63ae342ffb12 100644
--- a/arch/x86/platform/intel-mid/sfi.c
+++ b/arch/x86/platform/intel-mid/sfi.c
@@ -34,7 +34,6 @@
 #include <asm/io.h>
 #include <asm/i8259.h>
 #include <asm/intel_scu_ipc.h>
-#include <asm/apb_timer.h>
 #include <asm/reboot.h>
 
 #define	SFI_SIG_OEM0	"OEM0"
@@ -46,14 +45,11 @@ static struct platform_device *ipc_devs[MAX_IPCDEVS];
 static struct spi_board_info *spi_devs[MAX_SCU_SPI];
 static struct i2c_board_info *i2c_devs[MAX_SCU_I2C];
 static struct sfi_gpio_table_entry *gpio_table;
-static struct sfi_timer_table_entry sfi_mtimer_array[SFI_MTMR_MAX_NUM];
 static int ipc_next_dev;
 static int spi_next_dev;
 static int i2c_next_dev;
 static int i2c_bus[MAX_SCU_I2C];
 static int gpio_num_entry;
-static u32 sfi_mtimer_usage[SFI_MTMR_MAX_NUM];
-int sfi_mtimer_num;
 
 struct blocking_notifier_head intel_scu_notifier =
 			BLOCKING_NOTIFIER_INIT(intel_scu_notifier);
@@ -62,77 +58,6 @@ EXPORT_SYMBOL_GPL(intel_scu_notifier);
 #define intel_mid_sfi_get_pdata(dev, priv)	\
 	((dev)->get_platform_data ? (dev)->get_platform_data(priv) : NULL)
 
-/* parse all the mtimer info to a static mtimer array */
-int __init sfi_parse_mtmr(struct sfi_table_header *table)
-{
-	struct sfi_table_simple *sb;
-	struct sfi_timer_table_entry *pentry;
-	struct mpc_intsrc mp_irq;
-	int totallen;
-
-	sb = (struct sfi_table_simple *)table;
-	if (!sfi_mtimer_num) {
-		sfi_mtimer_num = SFI_GET_NUM_ENTRIES(sb,
-					struct sfi_timer_table_entry);
-		pentry = (struct sfi_timer_table_entry *) sb->pentry;
-		totallen = sfi_mtimer_num * sizeof(*pentry);
-		memcpy(sfi_mtimer_array, pentry, totallen);
-	}
-
-	pr_debug("SFI MTIMER info (num = %d):\n", sfi_mtimer_num);
-	pentry = sfi_mtimer_array;
-	for (totallen = 0; totallen < sfi_mtimer_num; totallen++, pentry++) {
-		pr_debug("timer[%d]: paddr = 0x%08x, freq = %dHz, irq = %d\n",
-			totallen, (u32)pentry->phys_addr,
-			pentry->freq_hz, pentry->irq);
-		mp_irq.type = MP_INTSRC;
-		mp_irq.irqtype = mp_INT;
-		mp_irq.irqflag = MP_IRQTRIG_EDGE | MP_IRQPOL_ACTIVE_HIGH;
-		mp_irq.srcbus = MP_BUS_ISA;
-		mp_irq.srcbusirq = pentry->irq;	/* IRQ */
-		mp_irq.dstapic = MP_APIC_ALL;
-		mp_irq.dstirq = pentry->irq;
-		mp_save_irq(&mp_irq);
-		mp_map_gsi_to_irq(pentry->irq, IOAPIC_MAP_ALLOC, NULL);
-	}
-
-	return 0;
-}
-
-struct sfi_timer_table_entry *sfi_get_mtmr(int hint)
-{
-	int i;
-	if (hint < sfi_mtimer_num) {
-		if (!sfi_mtimer_usage[hint]) {
-			pr_debug("hint taken for timer %d irq %d\n",
-				hint, sfi_mtimer_array[hint].irq);
-			sfi_mtimer_usage[hint] = 1;
-			return &sfi_mtimer_array[hint];
-		}
-	}
-	/* take the first timer available */
-	for (i = 0; i < sfi_mtimer_num;) {
-		if (!sfi_mtimer_usage[i]) {
-			sfi_mtimer_usage[i] = 1;
-			return &sfi_mtimer_array[i];
-		}
-		i++;
-	}
-	return NULL;
-}
-
-void sfi_free_mtmr(struct sfi_timer_table_entry *mtmr)
-{
-	int i;
-	for (i = 0; i < sfi_mtimer_num;) {
-		if (mtmr->irq == sfi_mtimer_array[i].irq) {
-			sfi_mtimer_usage[i] = 0;
-			return;
-		}
-		i++;
-	}
-}
-
 /*
  * Parsing GPIO table first, since the DEVS table will need this table
  * to map the pin name to the actual pin.
-- 
2.29.2

