Return-Path: <linux-acpi+bounces-15692-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770FDB26B88
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593B7AA5066
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 15:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233FA23BCEE;
	Thu, 14 Aug 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6lG4S6l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07E23ABA7;
	Thu, 14 Aug 2025 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186399; cv=none; b=nvaLnhNA4rY5LxH9KAIqH1aOm+i4U9V5H6KDy4dNL+mSzinIXZpFQjNAAUOv+1lA8afte4U+79QrHsbHFydz55kg5oKIUOJZTWchu2adX1uX+SN5IG8jzKdHZkUqx72vYvRIQHToUzKAiwBkNe5T/ZjM/hCh50UbkmHo5pZZ+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186399; c=relaxed/simple;
	bh=SAjpOVy06kEe4dcykDne8LUFQAwV23DbrLG2Adv4PZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FlRC5651fmHcZFoqxuTdonOIHOGfPufbA3vt6Q5/9LQigDGYXo/Rqx5/Rc7Fan4ut0Y33EZvM1KGs3WoEY9uuGvYk6fBMcWhm96KrpKIfQXnyYZT3cU42b91XnXAkMkMWRYxbR99YJt39R1jrKl/Ua1xT5HBuVo3D1DCZaJWSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6lG4S6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88771C4CEEF;
	Thu, 14 Aug 2025 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755186398;
	bh=SAjpOVy06kEe4dcykDne8LUFQAwV23DbrLG2Adv4PZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6lG4S6l3IG649q/NoniQXmtZ62HDtqnfJ2F8/SDmbM8Kdzx4InqnAvehNt5oPK5d
	 eSPdzicEi8Jh5voDZFSndx47Hb1PJ9Cx+nGjtiG4w/IZSVnOpwbjLIPsGqybZ/glig
	 aop7DPUtGdA1oCAWbRhsERjbV3gwL5aK/mfew0kCis34TDJpvvZFmoVIh4xEqgjJwb
	 McJzB1Y8uuvodwiAAOPjlnc/bTm1QrKUTJwCmj1PtFQlWjW3bE02uO8IfUWXbf9E9r
	 RDvU7j1pv4zgoAWNZ2hfF/BeOh4oZ+d57cqmZ7SfWN2yvyhxuaDXUK4PyFFuqeJEor
	 Q2i9E0JMA/CeQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uma9q-007VqB-GI;
	Thu, 14 Aug 2025 16:46:26 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v2 3/4] clocksource/drivers/arm_arch_timer_mmio: Switch over to standalone driver
Date: Thu, 14 Aug 2025 16:46:21 +0100
Message-Id: <20250814154622.10193-4-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250814154622.10193-1-maz@kernel.org>
References: <20250814154622.10193-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com, alexandru.elisei@arm.com, steven.price@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Remove all the MMIO support from the per-CPU timer driver, and switch
over to the standalove driver.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20250807160243.1970533-4-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/Makefile         |   1 +
 drivers/clocksource/arm_arch_timer.c | 686 +++------------------------
 include/clocksource/arm_arch_timer.h |   5 -
 3 files changed, 66 insertions(+), 626 deletions(-)

diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 205bf3b0a8f3f..0dcd958e21443 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_REALTEK_OTTO_TIMER)	+= timer-rtl-otto.o
 
 obj-$(CONFIG_ARC_TIMERS)		+= arc_timer.o
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
+obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer_mmio.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
 obj-$(CONFIG_ARMV7M_SYSTICK)		+= armv7m_systick.o
 obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 80ba6a54248c4..90aeff44a2764 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -34,42 +34,12 @@
 
 #include <clocksource/arm_arch_timer.h>
 
-#define CNTTIDR		0x08
-#define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
-
-#define CNTACR(n)	(0x40 + ((n) * 4))
-#define CNTACR_RPCT	BIT(0)
-#define CNTACR_RVCT	BIT(1)
-#define CNTACR_RFRQ	BIT(2)
-#define CNTACR_RVOFF	BIT(3)
-#define CNTACR_RWVT	BIT(4)
-#define CNTACR_RWPT	BIT(5)
-
-#define CNTPCT_LO	0x00
-#define CNTVCT_LO	0x08
-#define CNTFRQ		0x10
-#define CNTP_CVAL_LO	0x20
-#define CNTP_CTL	0x2c
-#define CNTV_CVAL_LO	0x30
-#define CNTV_CTL	0x3c
-
 /*
  * The minimum amount of time a generic counter is guaranteed to not roll over
  * (40 years)
  */
 #define MIN_ROLLOVER_SECS	(40ULL * 365 * 24 * 3600)
 
-static unsigned arch_timers_present __initdata;
-
-struct arch_timer {
-	void __iomem *base;
-	struct clock_event_device evt;
-};
-
-static struct arch_timer *arch_timer_mem __ro_after_init;
-
-#define to_arch_timer(e) container_of(e, struct arch_timer, evt)
-
 static u32 arch_timer_rate __ro_after_init;
 static int arch_timer_ppi[ARCH_TIMER_MAX_TIMER_PPI] __ro_after_init;
 
@@ -85,7 +55,6 @@ static struct clock_event_device __percpu *arch_timer_evt;
 
 static enum arch_timer_ppi_nr arch_timer_uses_ppi __ro_after_init = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop __ro_after_init;
-static bool arch_timer_mem_use_virtual __ro_after_init;
 static bool arch_counter_suspend_stop __ro_after_init;
 #ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
@@ -121,76 +90,6 @@ static int arch_counter_get_width(void)
 /*
  * Architected system timer support.
  */
-
-static __always_inline
-void arch_timer_reg_write(int access, enum arch_timer_reg reg, u64 val,
-			  struct clock_event_device *clk)
-{
-	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed((u32)val, timer->base + CNTP_CTL);
-			break;
-		case ARCH_TIMER_REG_CVAL:
-			/*
-			 * Not guaranteed to be atomic, so the timer
-			 * must be disabled at this point.
-			 */
-			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			writel_relaxed((u32)val, timer->base + CNTV_CTL);
-			break;
-		case ARCH_TIMER_REG_CVAL:
-			/* Same restriction as above */
-			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else {
-		arch_timer_reg_write_cp15(access, reg, val);
-	}
-}
-
-static __always_inline
-u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
-			struct clock_event_device *clk)
-{
-	u32 val;
-
-	if (access == ARCH_TIMER_MEM_PHYS_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val = readl_relaxed(timer->base + CNTP_CTL);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else if (access == ARCH_TIMER_MEM_VIRT_ACCESS) {
-		struct arch_timer *timer = to_arch_timer(clk);
-		switch (reg) {
-		case ARCH_TIMER_REG_CTRL:
-			val = readl_relaxed(timer->base + CNTV_CTL);
-			break;
-		default:
-			BUILD_BUG();
-		}
-	} else {
-		val = arch_timer_reg_read_cp15(access, reg);
-	}
-
-	return val;
-}
-
 static noinstr u64 raw_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
@@ -424,7 +323,7 @@ void erratum_set_next_event_generic(const int access, unsigned long evt,
 	unsigned long ctrl;
 	u64 cval;
 
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl = arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
@@ -436,7 +335,7 @@ void erratum_set_next_event_generic(const int access, unsigned long evt,
 		write_sysreg(cval, cntv_cval_el0);
 	}
 
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 }
 
 static __maybe_unused int erratum_set_next_event_virt(unsigned long evt,
@@ -667,10 +566,10 @@ static __always_inline irqreturn_t timer_handler(const int access,
 {
 	unsigned long ctrl;
 
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, evt);
+	ctrl = arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
 		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, evt);
+		arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 		evt->event_handler(evt);
 		return IRQ_HANDLED;
 	}
@@ -692,28 +591,14 @@ static irqreturn_t arch_timer_handler_phys(int irq, void *dev_id)
 	return timer_handler(ARCH_TIMER_PHYS_ACCESS, evt);
 }
 
-static irqreturn_t arch_timer_handler_phys_mem(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	return timer_handler(ARCH_TIMER_MEM_PHYS_ACCESS, evt);
-}
-
-static irqreturn_t arch_timer_handler_virt_mem(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	return timer_handler(ARCH_TIMER_MEM_VIRT_ACCESS, evt);
-}
-
 static __always_inline int arch_timer_shutdown(const int access,
 					       struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl = arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 
 	return 0;
 }
@@ -728,23 +613,13 @@ static int arch_timer_shutdown_phys(struct clock_event_device *clk)
 	return arch_timer_shutdown(ARCH_TIMER_PHYS_ACCESS, clk);
 }
 
-static int arch_timer_shutdown_virt_mem(struct clock_event_device *clk)
-{
-	return arch_timer_shutdown(ARCH_TIMER_MEM_VIRT_ACCESS, clk);
-}
-
-static int arch_timer_shutdown_phys_mem(struct clock_event_device *clk)
-{
-	return arch_timer_shutdown(ARCH_TIMER_MEM_PHYS_ACCESS, clk);
-}
-
 static __always_inline void set_next_event(const int access, unsigned long evt,
 					   struct clock_event_device *clk)
 {
 	unsigned long ctrl;
 	u64 cnt;
 
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+	ctrl = arch_timer_reg_read_cp15(access, ARCH_TIMER_REG_CTRL);
 	ctrl |= ARCH_TIMER_CTRL_ENABLE;
 	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
 
@@ -753,8 +628,8 @@ static __always_inline void set_next_event(const int access, unsigned long evt,
 	else
 		cnt = __arch_counter_get_cntvct();
 
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CVAL, evt + cnt);
+	arch_timer_reg_write_cp15(access, ARCH_TIMER_REG_CTRL, ctrl);
 }
 
 static int arch_timer_set_next_event_virt(unsigned long evt,
@@ -771,60 +646,6 @@ static int arch_timer_set_next_event_phys(unsigned long evt,
 	return 0;
 }
 
-static noinstr u64 arch_counter_get_cnt_mem(struct arch_timer *t, int offset_lo)
-{
-	u32 cnt_lo, cnt_hi, tmp_hi;
-
-	do {
-		cnt_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
-		cnt_lo = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
-		tmp_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
-	} while (cnt_hi != tmp_hi);
-
-	return ((u64) cnt_hi << 32) | cnt_lo;
-}
-
-static __always_inline void set_next_event_mem(const int access, unsigned long evt,
-					   struct clock_event_device *clk)
-{
-	struct arch_timer *timer = to_arch_timer(clk);
-	unsigned long ctrl;
-	u64 cnt;
-
-	ctrl = arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
-
-	/* Timer must be disabled before programming CVAL */
-	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
-		ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
-		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
-	}
-
-	ctrl |= ARCH_TIMER_CTRL_ENABLE;
-	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
-
-	if (access ==  ARCH_TIMER_MEM_VIRT_ACCESS)
-		cnt = arch_counter_get_cnt_mem(timer, CNTVCT_LO);
-	else
-		cnt = arch_counter_get_cnt_mem(timer, CNTPCT_LO);
-
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CVAL, evt + cnt, clk);
-	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
-}
-
-static int arch_timer_set_next_event_virt_mem(unsigned long evt,
-					      struct clock_event_device *clk)
-{
-	set_next_event_mem(ARCH_TIMER_MEM_VIRT_ACCESS, evt, clk);
-	return 0;
-}
-
-static int arch_timer_set_next_event_phys_mem(unsigned long evt,
-					      struct clock_event_device *clk)
-{
-	set_next_event_mem(ARCH_TIMER_MEM_PHYS_ACCESS, evt, clk);
-	return 0;
-}
-
 static u64 __arch_timer_check_delta(void)
 {
 #ifdef CONFIG_ARM64
@@ -850,63 +671,41 @@ static u64 __arch_timer_check_delta(void)
 	return CLOCKSOURCE_MASK(arch_counter_get_width());
 }
 
-static void __arch_timer_setup(unsigned type,
-			       struct clock_event_device *clk)
+static void __arch_timer_setup(struct clock_event_device *clk)
 {
+	typeof(clk->set_next_event) sne;
 	u64 max_delta;
 
 	clk->features = CLOCK_EVT_FEAT_ONESHOT;
 
-	if (type == ARCH_TIMER_TYPE_CP15) {
-		typeof(clk->set_next_event) sne;
-
-		arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
-
-		if (arch_timer_c3stop)
-			clk->features |= CLOCK_EVT_FEAT_C3STOP;
-		clk->name = "arch_sys_timer";
-		clk->rating = 450;
-		clk->cpumask = cpumask_of(smp_processor_id());
-		clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
-		switch (arch_timer_uses_ppi) {
-		case ARCH_TIMER_VIRT_PPI:
-			clk->set_state_shutdown = arch_timer_shutdown_virt;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
-			sne = erratum_handler(set_next_event_virt);
-			break;
-		case ARCH_TIMER_PHYS_SECURE_PPI:
-		case ARCH_TIMER_PHYS_NONSECURE_PPI:
-		case ARCH_TIMER_HYP_PPI:
-			clk->set_state_shutdown = arch_timer_shutdown_phys;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_phys;
-			sne = erratum_handler(set_next_event_phys);
-			break;
-		default:
-			BUG();
-		}
+	arch_timer_check_ool_workaround(ate_match_local_cap_id, NULL);
 
-		clk->set_next_event = sne;
-		max_delta = __arch_timer_check_delta();
-	} else {
-		clk->features |= CLOCK_EVT_FEAT_DYNIRQ;
-		clk->name = "arch_mem_timer";
-		clk->rating = 400;
-		clk->cpumask = cpu_possible_mask;
-		if (arch_timer_mem_use_virtual) {
-			clk->set_state_shutdown = arch_timer_shutdown_virt_mem;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_virt_mem;
-			clk->set_next_event =
-				arch_timer_set_next_event_virt_mem;
-		} else {
-			clk->set_state_shutdown = arch_timer_shutdown_phys_mem;
-			clk->set_state_oneshot_stopped = arch_timer_shutdown_phys_mem;
-			clk->set_next_event =
-				arch_timer_set_next_event_phys_mem;
-		}
-
-		max_delta = CLOCKSOURCE_MASK(56);
+	if (arch_timer_c3stop)
+		clk->features |= CLOCK_EVT_FEAT_C3STOP;
+	clk->name = "arch_sys_timer";
+	clk->rating = 450;
+	clk->cpumask = cpumask_of(smp_processor_id());
+	clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
+	switch (arch_timer_uses_ppi) {
+	case ARCH_TIMER_VIRT_PPI:
+		clk->set_state_shutdown = arch_timer_shutdown_virt;
+		clk->set_state_oneshot_stopped = arch_timer_shutdown_virt;
+		sne = erratum_handler(set_next_event_virt);
+		break;
+	case ARCH_TIMER_PHYS_SECURE_PPI:
+	case ARCH_TIMER_PHYS_NONSECURE_PPI:
+	case ARCH_TIMER_HYP_PPI:
+		clk->set_state_shutdown = arch_timer_shutdown_phys;
+		clk->set_state_oneshot_stopped = arch_timer_shutdown_phys;
+		sne = erratum_handler(set_next_event_phys);
+		break;
+	default:
+		BUG();
 	}
 
+	clk->set_next_event = sne;
+	max_delta = __arch_timer_check_delta();
+
 	clk->set_state_shutdown(clk);
 
 	clockevents_config_and_register(clk, arch_timer_rate, 0xf, max_delta);
@@ -1029,7 +828,7 @@ static int arch_timer_starting_cpu(unsigned int cpu)
 	struct clock_event_device *clk = this_cpu_ptr(arch_timer_evt);
 	u32 flags;
 
-	__arch_timer_setup(ARCH_TIMER_TYPE_CP15, clk);
+	__arch_timer_setup(clk);
 
 	flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
 	enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
@@ -1075,22 +874,12 @@ static void __init arch_timer_of_configure_rate(u32 rate, struct device_node *np
 		pr_warn("frequency not available\n");
 }
 
-static void __init arch_timer_banner(unsigned type)
+static void __init arch_timer_banner(void)
 {
-	pr_info("%s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
-		type & ARCH_TIMER_TYPE_CP15 ? "cp15" : "",
-		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ?
-			" and " : "",
-		type & ARCH_TIMER_TYPE_MEM ? "mmio" : "",
+	pr_info("cp15 timer running at %lu.%02luMHz (%s).\n",
 		(unsigned long)arch_timer_rate / 1000000,
 		(unsigned long)(arch_timer_rate / 10000) % 100,
-		type & ARCH_TIMER_TYPE_CP15 ?
-			(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys" :
-			"",
-		type == (ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM) ? "/" : "",
-		type & ARCH_TIMER_TYPE_MEM ?
-			arch_timer_mem_use_virtual ? "virt" : "phys" :
-			"");
+		(arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) ? "virt" : "phys");
 }
 
 u32 arch_timer_get_rate(void)
@@ -1108,11 +897,6 @@ bool arch_timer_evtstrm_available(void)
 	return cpumask_test_cpu(raw_smp_processor_id(), &evtstrm_available);
 }
 
-static noinstr u64 arch_counter_get_cntvct_mem(void)
-{
-	return arch_counter_get_cnt_mem(arch_timer_mem, CNTVCT_LO);
-}
-
 static struct arch_timer_kvm_info arch_timer_kvm_info;
 
 struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
@@ -1120,42 +904,35 @@ struct arch_timer_kvm_info *arch_timer_get_kvm_info(void)
 	return &arch_timer_kvm_info;
 }
 
-static void __init arch_counter_register(unsigned type)
+static void __init arch_counter_register(void)
 {
 	u64 (*scr)(void);
+	u64 (*rd)(void);
 	u64 start_count;
 	int width;
 
-	/* Register the CP15 based counter if we have one */
-	if (type & ARCH_TIMER_TYPE_CP15) {
-		u64 (*rd)(void);
-
-		if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
-		    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
-			if (arch_timer_counter_has_wa()) {
-				rd = arch_counter_get_cntvct_stable;
-				scr = raw_counter_get_cntvct_stable;
-			} else {
-				rd = arch_counter_get_cntvct;
-				scr = arch_counter_get_cntvct;
-			}
+	if ((IS_ENABLED(CONFIG_ARM64) && !is_hyp_mode_available()) ||
+	    arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI) {
+		if (arch_timer_counter_has_wa()) {
+			rd = arch_counter_get_cntvct_stable;
+			scr = raw_counter_get_cntvct_stable;
 		} else {
-			if (arch_timer_counter_has_wa()) {
-				rd = arch_counter_get_cntpct_stable;
-				scr = raw_counter_get_cntpct_stable;
-			} else {
-				rd = arch_counter_get_cntpct;
-				scr = arch_counter_get_cntpct;
-			}
+			rd = arch_counter_get_cntvct;
+			scr = arch_counter_get_cntvct;
 		}
-
-		arch_timer_read_counter = rd;
-		clocksource_counter.vdso_clock_mode = vdso_default;
 	} else {
-		arch_timer_read_counter = arch_counter_get_cntvct_mem;
-		scr = arch_counter_get_cntvct_mem;
+		if (arch_timer_counter_has_wa()) {
+			rd = arch_counter_get_cntpct_stable;
+			scr = raw_counter_get_cntpct_stable;
+		} else {
+			rd = arch_counter_get_cntpct;
+			scr = arch_counter_get_cntpct;
+		}
 	}
 
+	arch_timer_read_counter = rd;
+	clocksource_counter.vdso_clock_mode = vdso_default;
+
 	width = arch_counter_get_width();
 	clocksource_counter.mask = CLOCKSOURCE_MASK(width);
 	cyclecounter.mask = CLOCKSOURCE_MASK(width);
@@ -1303,76 +1080,10 @@ static int __init arch_timer_register(void)
 	return err;
 }
 
-static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
-{
-	int ret;
-	irq_handler_t func;
-
-	arch_timer_mem = kzalloc(sizeof(*arch_timer_mem), GFP_KERNEL);
-	if (!arch_timer_mem)
-		return -ENOMEM;
-
-	arch_timer_mem->base = base;
-	arch_timer_mem->evt.irq = irq;
-	__arch_timer_setup(ARCH_TIMER_TYPE_MEM, &arch_timer_mem->evt);
-
-	if (arch_timer_mem_use_virtual)
-		func = arch_timer_handler_virt_mem;
-	else
-		func = arch_timer_handler_phys_mem;
-
-	ret = request_irq(irq, func, IRQF_TIMER, "arch_mem_timer", &arch_timer_mem->evt);
-	if (ret) {
-		pr_err("Failed to request mem timer irq\n");
-		kfree(arch_timer_mem);
-		arch_timer_mem = NULL;
-	}
-
-	return ret;
-}
-
-static const struct of_device_id arch_timer_of_match[] __initconst = {
-	{ .compatible   = "arm,armv7-timer",    },
-	{ .compatible   = "arm,armv8-timer",    },
-	{},
-};
-
-static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
-	{ .compatible   = "arm,armv7-timer-mem", },
-	{},
-};
-
-static bool __init arch_timer_needs_of_probing(void)
-{
-	struct device_node *dn;
-	bool needs_probing = false;
-	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
-
-	/* We have two timers, and both device-tree nodes are probed. */
-	if ((arch_timers_present & mask) == mask)
-		return false;
-
-	/*
-	 * Only one type of timer is probed,
-	 * check if we have another type of timer node in device-tree.
-	 */
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
-		dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
-	else
-		dn = of_find_matching_node(NULL, arch_timer_of_match);
-
-	if (dn && of_device_is_available(dn))
-		needs_probing = true;
-
-	of_node_put(dn);
-
-	return needs_probing;
-}
-
 static int __init arch_timer_common_init(void)
 {
-	arch_timer_banner(arch_timers_present);
-	arch_counter_register(arch_timers_present);
+	arch_timer_banner();
+	arch_counter_register();
 	return arch_timer_arch_init();
 }
 
@@ -1421,13 +1132,11 @@ static int __init arch_timer_of_init(struct device_node *np)
 	u32 rate;
 	bool has_names;
 
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
+	if (arch_timer_evt) {
 		pr_warn("multiple nodes in dt, skipping\n");
 		return 0;
 	}
 
-	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
-
 	has_names = of_property_present(np, "interrupt-names");
 
 	for (i = ARCH_TIMER_PHYS_SECURE_PPI; i < ARCH_TIMER_MAX_TIMER_PPI; i++) {
@@ -1472,283 +1181,22 @@ static int __init arch_timer_of_init(struct device_node *np)
 	if (ret)
 		return ret;
 
-	if (arch_timer_needs_of_probing())
-		return 0;
-
 	return arch_timer_common_init();
 }
 TIMER_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_of_init);
 TIMER_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_of_init);
 
-static u32 __init
-arch_timer_mem_frame_get_cntfrq(struct arch_timer_mem_frame *frame)
-{
-	void __iomem *base;
-	u32 rate;
-
-	base = ioremap(frame->cntbase, frame->size);
-	if (!base) {
-		pr_err("Unable to map frame @ %pa\n", &frame->cntbase);
-		return 0;
-	}
-
-	rate = readl_relaxed(base + CNTFRQ);
-
-	iounmap(base);
-
-	return rate;
-}
-
-static struct arch_timer_mem_frame * __init
-arch_timer_mem_find_best_frame(struct arch_timer_mem *timer_mem)
-{
-	struct arch_timer_mem_frame *frame, *best_frame = NULL;
-	void __iomem *cntctlbase;
-	u32 cnttidr;
-	int i;
-
-	cntctlbase = ioremap(timer_mem->cntctlbase, timer_mem->size);
-	if (!cntctlbase) {
-		pr_err("Can't map CNTCTLBase @ %pa\n",
-			&timer_mem->cntctlbase);
-		return NULL;
-	}
-
-	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
-
-	/*
-	 * Try to find a virtual capable frame. Otherwise fall back to a
-	 * physical capable frame.
-	 */
-	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
-		u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
-			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
-
-		frame = &timer_mem->frame[i];
-		if (!frame->valid)
-			continue;
-
-		/* Try enabling everything, and see what sticks */
-		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
-		cntacr = readl_relaxed(cntctlbase + CNTACR(i));
-
-		if ((cnttidr & CNTTIDR_VIRT(i)) &&
-		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
-			best_frame = frame;
-			arch_timer_mem_use_virtual = true;
-			break;
-		}
-
-		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
-			continue;
-
-		best_frame = frame;
-	}
-
-	iounmap(cntctlbase);
-
-	return best_frame;
-}
-
-static int __init
-arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
-{
-	void __iomem *base;
-	int ret, irq;
-
-	if (arch_timer_mem_use_virtual)
-		irq = frame->virt_irq;
-	else
-		irq = frame->phys_irq;
-
-	if (!irq) {
-		pr_err("Frame missing %s irq.\n",
-		       arch_timer_mem_use_virtual ? "virt" : "phys");
-		return -EINVAL;
-	}
-
-	if (!request_mem_region(frame->cntbase, frame->size,
-				"arch_mem_timer"))
-		return -EBUSY;
-
-	base = ioremap(frame->cntbase, frame->size);
-	if (!base) {
-		pr_err("Can't map frame's registers\n");
-		return -ENXIO;
-	}
-
-	ret = arch_timer_mem_register(base, irq);
-	if (ret) {
-		iounmap(base);
-		return ret;
-	}
-
-	arch_timers_present |= ARCH_TIMER_TYPE_MEM;
-
-	return 0;
-}
-
-static int __init arch_timer_mem_of_init(struct device_node *np)
-{
-	struct arch_timer_mem *timer_mem;
-	struct arch_timer_mem_frame *frame;
-	struct resource res;
-	int ret = -EINVAL;
-	u32 rate;
-
-	timer_mem = kzalloc(sizeof(*timer_mem), GFP_KERNEL);
-	if (!timer_mem)
-		return -ENOMEM;
-
-	if (of_address_to_resource(np, 0, &res))
-		goto out;
-	timer_mem->cntctlbase = res.start;
-	timer_mem->size = resource_size(&res);
-
-	for_each_available_child_of_node_scoped(np, frame_node) {
-		u32 n;
-		struct arch_timer_mem_frame *frame;
-
-		if (of_property_read_u32(frame_node, "frame-number", &n)) {
-			pr_err(FW_BUG "Missing frame-number.\n");
-			goto out;
-		}
-		if (n >= ARCH_TIMER_MEM_MAX_FRAMES) {
-			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
-			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
-			goto out;
-		}
-		frame = &timer_mem->frame[n];
-
-		if (frame->valid) {
-			pr_err(FW_BUG "Duplicated frame-number.\n");
-			goto out;
-		}
-
-		if (of_address_to_resource(frame_node, 0, &res))
-			goto out;
-
-		frame->cntbase = res.start;
-		frame->size = resource_size(&res);
-
-		frame->virt_irq = irq_of_parse_and_map(frame_node,
-						       ARCH_TIMER_VIRT_SPI);
-		frame->phys_irq = irq_of_parse_and_map(frame_node,
-						       ARCH_TIMER_PHYS_SPI);
-
-		frame->valid = true;
-	}
-
-	frame = arch_timer_mem_find_best_frame(timer_mem);
-	if (!frame) {
-		pr_err("Unable to find a suitable frame in timer @ %pa\n",
-			&timer_mem->cntctlbase);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	rate = arch_timer_mem_frame_get_cntfrq(frame);
-	arch_timer_of_configure_rate(rate, np);
-
-	ret = arch_timer_mem_frame_register(frame);
-	if (!ret && !arch_timer_needs_of_probing())
-		ret = arch_timer_common_init();
-out:
-	kfree(timer_mem);
-	return ret;
-}
-TIMER_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
-		       arch_timer_mem_of_init);
-
 #ifdef CONFIG_ACPI_GTDT
-static int __init
-arch_timer_mem_verify_cntfrq(struct arch_timer_mem *timer_mem)
-{
-	struct arch_timer_mem_frame *frame;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
-		frame = &timer_mem->frame[i];
-
-		if (!frame->valid)
-			continue;
-
-		rate = arch_timer_mem_frame_get_cntfrq(frame);
-		if (rate == arch_timer_rate)
-			continue;
-
-		pr_err(FW_BUG "CNTFRQ mismatch: frame @ %pa: (0x%08lx), CPU: (0x%08lx)\n",
-			&frame->cntbase,
-			(unsigned long)rate, (unsigned long)arch_timer_rate);
-
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int __init arch_timer_mem_acpi_init(int platform_timer_count)
-{
-	struct arch_timer_mem *timers, *timer;
-	struct arch_timer_mem_frame *frame, *best_frame = NULL;
-	int timer_count, i, ret = 0;
-
-	timers = kcalloc(platform_timer_count, sizeof(*timers),
-			    GFP_KERNEL);
-	if (!timers)
-		return -ENOMEM;
-
-	ret = acpi_arch_timer_mem_init(timers, &timer_count);
-	if (ret || !timer_count)
-		goto out;
-
-	/*
-	 * While unlikely, it's theoretically possible that none of the frames
-	 * in a timer expose the combination of feature we want.
-	 */
-	for (i = 0; i < timer_count; i++) {
-		timer = &timers[i];
-
-		frame = arch_timer_mem_find_best_frame(timer);
-		if (!best_frame)
-			best_frame = frame;
-
-		ret = arch_timer_mem_verify_cntfrq(timer);
-		if (ret) {
-			pr_err("Disabling MMIO timers due to CNTFRQ mismatch\n");
-			goto out;
-		}
-
-		if (!best_frame) /* implies !frame */
-			/*
-			 * Only complain about missing suitable frames if we
-			 * haven't already found one in a previous iteration.
-			 */
-			pr_err("Unable to find a suitable frame in timer @ %pa\n",
-				&timer->cntctlbase);
-	}
-
-	if (best_frame)
-		ret = arch_timer_mem_frame_register(best_frame);
-out:
-	kfree(timers);
-	return ret;
-}
-
-/* Initialize per-processor generic timer and memory-mapped timer(if present) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
-	int ret, platform_timer_count;
+	int ret;
 
-	if (arch_timers_present & ARCH_TIMER_TYPE_CP15) {
+	if (arch_timer_evt) {
 		pr_warn("already initialized, skipping\n");
 		return -EINVAL;
 	}
 
-	arch_timers_present |= ARCH_TIMER_TYPE_CP15;
-
-	ret = acpi_gtdt_init(table, &platform_timer_count);
+	ret = acpi_gtdt_init(table, NULL);
 	if (ret)
 		return ret;
 
@@ -1790,10 +1238,6 @@ static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 	if (ret)
 		return ret;
 
-	if (platform_timer_count &&
-	    arch_timer_mem_acpi_init(platform_timer_count))
-		pr_err("Failed to initialize memory-mapped timer.\n");
-
 	return arch_timer_common_init();
 }
 TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index ce6521ad04d12..2eda895f19f54 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -9,9 +9,6 @@
 #include <linux/timecounter.h>
 #include <linux/types.h>
 
-#define ARCH_TIMER_TYPE_CP15		BIT(0)
-#define ARCH_TIMER_TYPE_MEM		BIT(1)
-
 #define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
 #define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
 #define ARCH_TIMER_CTRL_IT_STAT		(1 << 2)
@@ -51,8 +48,6 @@ enum arch_timer_spi_nr {
 
 #define ARCH_TIMER_PHYS_ACCESS		0
 #define ARCH_TIMER_VIRT_ACCESS		1
-#define ARCH_TIMER_MEM_PHYS_ACCESS	2
-#define ARCH_TIMER_MEM_VIRT_ACCESS	3
 
 #define ARCH_TIMER_MEM_MAX_FRAMES	8
 
-- 
2.39.2


