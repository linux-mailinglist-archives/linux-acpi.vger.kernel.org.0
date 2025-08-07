Return-Path: <linux-acpi+bounces-15569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6149EB1DB41
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 18:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B841AA53E1
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C727147B;
	Thu,  7 Aug 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5dr6u9h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E2271470;
	Thu,  7 Aug 2025 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582574; cv=none; b=i7TcoD53TcsqfuD8yB2IqJLwtOV3F+hvvFwmh7NRvMmDC+fDMG4IcqbUsG84l8GRap9k62LgbkUDzt4IwzJ0IUsJHemRv+iXrMxiXKE6GxpEr8YlHepjBEeJSx+N1V+oHRV3Sh7iQwklbETjjddw91GrU4zvdyNpz3fuosJJln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582574; c=relaxed/simple;
	bh=k6954aQ5t1JPrNiK968zBwo8MyKWRYfR/TmEkAzJRHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuL6U3wyejCuwhClXZ78+nBXQIyMo2XwvSknrRku4mIpXpaNzW8ZeZKVRwOk/uYHiKRbuiM4mGDYRiicX3pmZ5HarJjtptdsr7zCKVRqDR/oyh6f4kEJVSGLnhGhWL0vMf9y+Dmhq9QdL4Z4pB8HXQDe4eXTyR+ftW6huVRES64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5dr6u9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FA8C4CEF1;
	Thu,  7 Aug 2025 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754582574;
	bh=k6954aQ5t1JPrNiK968zBwo8MyKWRYfR/TmEkAzJRHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5dr6u9hAgeJj1bkY86xdiDwx7xdDKm57hYn4wp6h0H1x+14lGujBKwrhkVsK/5nQ
	 rp6EWDeo2eU5Pvp6ZyIZUCm6wDoAFdk0Grn9fQHlJedclksTFdkc3K7iYuy9OmkTQx
	 aXUdZcArT2At29d9pg+qJPBLEk9wvwKKmKhGtxuUc98YRi1NceUUw5iXLi5OyzK2Pr
	 npJSjG1HnNGPt8sNv/1w3nGEUJwCg9a9kcIP2mwZqB+Sa0bRM237raQuj+iDYVeFcb
	 l8PQjMs4UV3z0uBjzPWKWXlQ/16AdlUw9+NNiNCmsKoQC1pfHm2dV/WhmgM2zGkvY1
	 xqrUkh35LMiPQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uk34p-004zf7-3E;
	Thu, 07 Aug 2025 17:02:47 +0100
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
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/4] clocksource/drivers/arm_arch_timer: Add standalone MMIO driver
Date: Thu,  7 Aug 2025 17:02:41 +0100
Message-Id: <20250807160243.1970533-3-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250807160243.1970533-1-maz@kernel.org>
References: <20250807160243.1970533-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Add a new driver for the MMIO side of the ARM architected timer.
Most of it has been lifted from the existing arch timer code,
massaged, and finally rewritten.

It supports both DT and ACPI as firmware descriptions.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 MAINTAINERS                               |   1 +
 drivers/clocksource/arm_arch_timer_mmio.c | 420 ++++++++++++++++++++++
 2 files changed, 421 insertions(+)
 create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5ad..be521c150d3fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1952,6 +1952,7 @@ S:	Maintained
 F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
+F:	drivers/clocksource/arm_arch_timer_mmio.c
 
 ARM GENERIC INTERRUPT CONTROLLER DRIVERS
 M:	Marc Zyngier <maz@kernel.org>
diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/arm_arch_timer_mmio.c
new file mode 100644
index 0000000000000..fa7294ab609ce
--- /dev/null
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  ARM Generic Memory Mapped Timer support
+ *
+ *  Split from drivers/clocksource/arm_arch_timer.c
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ */
+
+#define pr_fmt(fmt) 	"arch_timer_mmio: " fmt
+
+#include <linux/clockchips.h>
+#include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include <clocksource/arm_arch_timer.h>
+
+#define CNTTIDR		0x08
+#define CNTTIDR_VIRT(n)	(BIT(1) << ((n) * 4))
+
+#define CNTACR(n)	(0x40 + ((n) * 4))
+#define CNTACR_RPCT	BIT(0)
+#define CNTACR_RVCT	BIT(1)
+#define CNTACR_RFRQ	BIT(2)
+#define CNTACR_RVOFF	BIT(3)
+#define CNTACR_RWVT	BIT(4)
+#define CNTACR_RWPT	BIT(5)
+
+#define CNTPCT_LO	0x00
+#define CNTVCT_LO	0x08
+#define CNTFRQ		0x10
+#define CNTP_CVAL_LO	0x20
+#define CNTP_CTL	0x2c
+#define CNTV_CVAL_LO	0x30
+#define CNTV_CTL	0x3c
+
+enum arch_timer_access {
+	PHYS_ACCESS,
+	VIRT_ACCESS,
+};
+
+struct arch_timer {
+	struct clock_event_device	evt;
+	struct arch_timer_mem		*gt_block;
+	void __iomem			*base;
+	enum arch_timer_access		access;
+	u32				rate;
+};
+
+#define evt_to_arch_timer(e) container_of(e, struct arch_timer, evt)
+
+static void arch_timer_mmio_write(struct arch_timer *timer,
+				  enum arch_timer_reg reg, u64 val)
+{
+	switch (timer->access) {
+	case PHYS_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed((u32)val, timer->base + CNTP_CTL);
+			return;
+		case ARCH_TIMER_REG_CVAL:
+			/*
+			 * Not guaranteed to be atomic, so the timer
+			 * must be disabled at this point.
+			 */
+			writeq_relaxed(val, timer->base + CNTP_CVAL_LO);
+			return;
+		}
+		break;
+	case VIRT_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			writel_relaxed((u32)val, timer->base + CNTV_CTL);
+			return;
+		case ARCH_TIMER_REG_CVAL:
+			/* Same restriction as above */
+			writeq_relaxed(val, timer->base + CNTV_CVAL_LO);
+			return;
+		}
+		break;
+	}
+
+	/* Should never be here */
+	WARN_ON_ONCE(1);
+}
+
+static u32 arch_timer_mmio_read(struct arch_timer *timer, enum arch_timer_reg reg)
+{
+	switch (timer->access) {
+	case PHYS_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			return readl_relaxed(timer->base + CNTP_CTL);
+		default:
+			break;
+		}
+		break;
+	case VIRT_ACCESS:
+		switch (reg) {
+		case ARCH_TIMER_REG_CTRL:
+			return readl_relaxed(timer->base + CNTV_CTL);
+		default:
+			break;
+		}
+		break;
+	}
+
+	/* Should never be here */
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static noinstr u64 arch_counter_mmio_get_cnt(struct arch_timer *t)
+{
+	int offset_lo = t->access == VIRT_ACCESS ? CNTVCT_LO : CNTPCT_LO;
+	u32 cnt_lo, cnt_hi, tmp_hi;
+
+	do {
+		cnt_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
+		cnt_lo = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo));
+		tmp_hi = __le32_to_cpu((__le32 __force)__raw_readl(t->base + offset_lo + 4));
+	} while (cnt_hi != tmp_hi);
+
+	return ((u64) cnt_hi << 32) | cnt_lo;
+}
+
+static int arch_timer_mmio_shutdown(struct clock_event_device *clk)
+{
+	struct arch_timer *at = evt_to_arch_timer(clk);
+	unsigned long ctrl;
+
+	ctrl = arch_timer_mmio_read(at, ARCH_TIMER_REG_CTRL);
+	ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
+	arch_timer_mmio_write(at, ARCH_TIMER_REG_CTRL, ctrl);
+
+	return 0;
+}
+
+static int arch_timer_mmio_set_next_event(unsigned long evt,
+					  struct clock_event_device *clk)
+{
+	struct arch_timer *timer = evt_to_arch_timer(clk);
+	unsigned long ctrl;
+	u64 cnt;
+
+	ctrl = arch_timer_mmio_read(timer, ARCH_TIMER_REG_CTRL);
+
+	/* Timer must be disabled before programming CVAL */
+	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
+		ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
+		arch_timer_mmio_write(timer, ARCH_TIMER_REG_CTRL, ctrl);
+	}
+
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
+	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+
+	cnt = arch_counter_mmio_get_cnt(timer);
+
+	arch_timer_mmio_write(timer, ARCH_TIMER_REG_CVAL, evt + cnt);
+	arch_timer_mmio_write(timer, ARCH_TIMER_REG_CTRL, ctrl);
+	return 0;
+}
+
+static irqreturn_t arch_timer_mmio_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+	struct arch_timer *at = evt_to_arch_timer(evt);
+	unsigned long ctrl;
+
+	ctrl = arch_timer_mmio_read(at, ARCH_TIMER_REG_CTRL);
+	if (ctrl & ARCH_TIMER_CTRL_IT_STAT) {
+		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
+		arch_timer_mmio_write(at, ARCH_TIMER_REG_CTRL, ctrl);
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static struct arch_timer_mem_frame *find_best_frame(struct platform_device *pdev)
+{
+	struct arch_timer_mem_frame *frame, *best_frame = NULL;
+	struct arch_timer *at = platform_get_drvdata(pdev);
+	void __iomem *cntctlbase;
+	u32 cnttidr;
+
+	cntctlbase = ioremap(at->gt_block->cntctlbase, at->gt_block->size);
+	if (!cntctlbase) {
+		dev_err(&pdev->dev, "Can't map CNTCTLBase @ %pa\n",
+			&at->gt_block->cntctlbase);
+		return NULL;
+	}
+
+	cnttidr = readl_relaxed(cntctlbase + CNTTIDR);
+
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (int i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		u32 cntacr = CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			     CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+
+		frame = &at->gt_block->frame[i];
+		if (!frame->valid)
+			continue;
+
+		/* Try enabling everything, and see what sticks */
+		writel_relaxed(cntacr, cntctlbase + CNTACR(i));
+		cntacr = readl_relaxed(cntctlbase + CNTACR(i));
+
+		/* Pick a suitable frame for which we have an IRQ */
+		if ((cnttidr & CNTTIDR_VIRT(i)) &&
+		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT)) &&
+		    frame->virt_irq) {
+			best_frame = frame;
+			at->access = VIRT_ACCESS;
+			break;
+		}
+
+		if ((~cntacr & (CNTACR_RWPT | CNTACR_RPCT)) ||
+		     !frame->phys_irq)
+			continue;
+
+		at->access = PHYS_ACCESS;
+		best_frame = frame;
+	}
+
+	iounmap(cntctlbase);
+
+	return best_frame;
+}
+
+static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
+{
+	at->evt = (struct clock_event_device) {
+		.features		   = (CLOCK_EVT_FEAT_ONESHOT |
+					      CLOCK_EVT_FEAT_DYNIRQ),
+		.name			   = "arch_mem_timer",
+		.rating			   = 400,
+		.cpumask		   = cpu_possible_mask,
+		.irq 			   = irq,
+		.set_next_event		   = arch_timer_mmio_set_next_event,
+		.set_state_oneshot_stopped = arch_timer_mmio_shutdown,
+		.set_state_shutdown	   = arch_timer_mmio_shutdown,
+	};
+
+	at->evt.set_state_shutdown(&at->evt);
+
+	clockevents_config_and_register(&at->evt, at->rate, 0xf, CLOCKSOURCE_MASK(56));
+
+	enable_irq(at->evt.irq);
+}
+
+static int arch_timer_mmio_frame_register(struct platform_device *pdev,
+					  struct arch_timer_mem_frame *frame)
+{
+	struct arch_timer *at = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	int ret, irq;
+	u32 rate;
+
+	if (!devm_request_mem_region(&pdev->dev, frame->cntbase, frame->size,
+				     "arch_mem_timer"))
+		return -EBUSY;
+
+	at->base = devm_ioremap(&pdev->dev, frame->cntbase, frame->size);
+	if (!at->base) {
+		dev_err(&pdev->dev, "Can't map frame's registers\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Allow "clock-frequency" to override the probed rate. If neither
+	 * lead to something useful, use the CPU timer frequency as the
+	 * fallback. The nice thing about that last point is that we woudn't
+	 * made it here if we didn't have a valid frequency.
+	 */
+	rate = readl_relaxed(at->base + CNTFRQ);
+
+	if (!np || of_property_read_u32(np, "clock-frequency", &at->rate))
+		at->rate = rate;
+
+	if (!at->rate)
+		at->rate = arch_timer_get_rate();
+
+	irq = at->access == VIRT_ACCESS ? frame->virt_irq : frame->phys_irq;
+	ret = devm_request_irq(&pdev->dev, irq, arch_timer_mmio_handler,
+			       IRQF_TIMER | IRQF_NO_AUTOEN, "arch_mem_timer",
+			       &at->evt);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request mem timer irq\n");
+		return ret;
+	}
+
+	/* Afer this point, we're not allowed to fail anymore */
+	arch_timer_mmio_setup(at, irq);
+	return 0;
+}
+
+static int of_populate_gt_block(struct platform_device *pdev,
+				struct arch_timer *at)
+{
+	struct resource res;
+
+	if (of_address_to_resource(pdev->dev.of_node, 0, &res))
+		return -EINVAL;
+
+	at->gt_block->cntctlbase = res.start;
+	at->gt_block->size = resource_size(&res);
+
+	for_each_available_child_of_node_scoped(pdev->dev.of_node, frame_node) {
+		struct arch_timer_mem_frame *frame;
+		u32 n;
+
+		if (of_property_read_u32(frame_node, "frame-number", &n)) {
+			dev_err(&pdev->dev, FW_BUG "Missing frame-number\n");
+			return -EINVAL;
+		}
+		if (n >= ARCH_TIMER_MEM_MAX_FRAMES) {
+			dev_err(&pdev->dev,
+				FW_BUG "Wrong frame-number, only 0-%u are permitted\n",
+			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
+			return -EINVAL;
+		}
+
+		frame = &at->gt_block->frame[n];
+
+		if (frame->valid) {
+			dev_err(&pdev->dev, FW_BUG "Duplicated frame-number\n");
+			return -EINVAL;
+		}
+
+		if (of_address_to_resource(frame_node, 0, &res))
+			return -EINVAL;
+
+		frame->cntbase = res.start;
+		frame->size = resource_size(&res);
+
+		frame->phys_irq = irq_of_parse_and_map(frame_node, 0);
+		frame->virt_irq = irq_of_parse_and_map(frame_node, 1);
+
+		frame->valid = true;
+	}
+
+	return 0;
+}
+
+static int arch_timer_mmio_probe(struct platform_device *pdev)
+{
+	struct arch_timer_mem_frame *frame;
+	struct arch_timer *at;
+	struct device_node *np;
+	int ret;
+
+	np = pdev->dev.of_node;
+
+	at = devm_kmalloc(&pdev->dev, sizeof(*at), GFP_KERNEL | __GFP_ZERO);
+	if (!at)
+		return -ENOMEM;
+
+	if (np) {
+		at->gt_block = devm_kmalloc(&pdev->dev, sizeof(*at->gt_block),
+					    GFP_KERNEL | __GFP_ZERO);
+		if (!at->gt_block)
+			return -ENOMEM;
+		ret = of_populate_gt_block(pdev, at);
+		if (ret)
+			return ret;
+	} else {
+		at->gt_block = dev_get_platdata(&pdev->dev);
+	}
+
+	platform_set_drvdata(pdev, at);
+
+	frame = find_best_frame(pdev);
+	if (!frame) {
+		dev_err(&pdev->dev,
+			"Unable to find a suitable frame in timer @ %pa\n",
+			&at->gt_block->cntctlbase);
+		return -EINVAL;
+	}
+
+	ret = arch_timer_mmio_frame_register(pdev, frame);
+	if (!ret)
+		dev_info(&pdev->dev,
+			 "mmio timer running at %lu.%02luMHz (%s)\n",
+			 (unsigned long)at->rate / 1000000,
+			 (unsigned long)(at->rate / 10000) % 100,
+			 at->access == VIRT_ACCESS ? "virt" : "phys");
+
+	return ret;
+}
+
+static const struct of_device_id arch_timer_mmio_of_table[] = {
+	{ .compatible = "arm,armv7-timer-mem", },
+	{}
+};
+
+static struct platform_driver arch_timer_mmio_drv = {
+	.driver	= {
+		.name = "arch-timer-mmio",
+		.of_match_table	= arch_timer_mmio_of_table,
+	},
+	.probe	= arch_timer_mmio_probe,
+};
+builtin_platform_driver(arch_timer_mmio_drv);
+
+static struct platform_driver arch_timer_mmio_acpi_drv = {
+	.driver	= {
+		.name = "gtdt-arm-mmio-timer",
+	},
+	.probe	= arch_timer_mmio_probe,
+};
+builtin_platform_driver(arch_timer_mmio_acpi_drv);
-- 
2.39.2


