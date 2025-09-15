Return-Path: <linux-acpi+bounces-16908-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5DB573D0
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746231895865
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614742F618C;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgP5RyLa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED42F6182;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926637; cv=none; b=qMkRLoJYa1jCSkdXE2GNXuR62l+wbcGeUaWN8ji+REa7KhHYb44YrOFYCJYnnbf9//+dP8dhhDVAObdwMoJP7lZsJOp+soxypAJdLubtDG9h9RzS36rnf/9lok0pM7a2ev7Oygv4OPysD5Hw5aAgREDC+0c5pRoN8rhO16ZTkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926637; c=relaxed/simple;
	bh=ObJzm88OJ49mVZNrIXgLd5Q7+GhtWwWLGemAvCRoya0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0/pvF7FtmkRph5FZXUWuR4hUeIWPseVkoJsMIXsBnUhp0cwzP7g73mjLHm8HdVnSQ8ylPxM5GXPFKuohIRd08/1YN9VXrz5aYEGLECDAA1qUEk71dmdWhTMz/07qT9e2XwFii6P4qrlBYa3c3xEZhTGvbhNCujo/WLF0usG5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgP5RyLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14CFC4CEF9;
	Mon, 15 Sep 2025 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926637;
	bh=ObJzm88OJ49mVZNrIXgLd5Q7+GhtWwWLGemAvCRoya0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgP5RyLabbg6LSTg5bpNOSmiVY6wQkC0XwjFuhIGyyo5S8tPuBLMs7kztQnSIrZ9Z
	 GzaVXR6B9q7rqI2nNURJzuvhY0ArAXqKKngj1vgPj/BOVXZya+TUZTLR1qwTmTrgUA
	 g32LoxILkX0wrOqaNvRB8YaU6Aym3BAdnlUKuSD//nyQ1SSXdLtT0l3/8vyTXDS88K
	 qGN62vNzej0GdTuYKjEwosyGFJwQAv0Yj5WA0YE/KpFX5GBzy9z6CKWD56lSvLKkK4
	 Tlgh7k5TWM0sQJOGCjCfynfdoppgnCAErMQyhe8ovfP9q/fI+vwwJo9z1ZxzFxrPtX
	 pGfrnCOI/ADxA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51P-00000006IHP-0xfB;
	Mon, 15 Sep 2025 08:57:15 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2 16/25] genirq: Allow per-cpu interrupt sharing for non-overlapping affinities
Date: Mon, 15 Sep 2025 09:56:53 +0100
Message-Id: <20250915085702.519996-17-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250915085702.519996-1-maz@kernel.org>
References: <20250915085702.519996-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Interrupt sharing for percpu-devid interrupts is forbidden, and
for good reasons. These are interrupts generated *from* a CPU and
handled by itself (timer, for example). Nobody in their right mind
would put two devices on the same pin (and if they have, they get to
keep the pieces...).

But this also prevents more benign cases, where devices are connected
to groups of CPUs, and for which the affinities are not overlapping.
Effectively, the only thing they share is the interrupt number, and
nothing else.

Let's tweak the definition of IRQF_SHARED applied to percpu_devid
interrupts to allow this particular case. This results in extra
validation at the point of the interrupt being setup and freed,
as well as a tiny bit of extra complexity for interrupts at handling
time (to pick the correct irqaction).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/chip.c   |  8 ++++--
 kernel/irq/manage.c | 67 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 869068ec6ac91..f60a2268fad1f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -898,8 +898,9 @@ void handle_percpu_irq(struct irq_desc *desc)
 void handle_percpu_devid_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
+	unsigned int cpu = smp_processor_id();
+	struct irqaction *action;
 	irqreturn_t res;
 
 	/*
@@ -911,12 +912,15 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
+	for (action = desc->action; action; action = action->next)
+		if (cpumask_test_cpu(cpu, action->affinity))
+			break;
+
 	if (likely(action)) {
 		trace_irq_handler_entry(irq, action);
 		res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
 		trace_irq_handler_exit(irq, action, res);
 	} else {
-		unsigned int cpu = smp_processor_id();
 		bool enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
 
 		if (enabled)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 49c237aca2a70..39db60a5f36f3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1418,6 +1418,19 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
 	return 0;
 }
 
+static bool valid_percpu_irqaction(struct irqaction *old, struct irqaction *new)
+{
+	do {
+		if (cpumask_intersects(old->affinity, new->affinity) ||
+		    old->percpu_dev_id == new->percpu_dev_id)
+			return false;
+
+		old = old->next;
+	} while (old);
+
+	return true;
+}
+
 /*
  * Internal function to register an irqaction - typically used to
  * allocate special interrupts that are part of the architecture.
@@ -1438,6 +1451,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	struct irqaction *old, **old_ptr;
 	unsigned long flags, thread_mask = 0;
 	int ret, nested, shared = 0;
+	bool per_cpu_devid;
 
 	if (!desc)
 		return -EINVAL;
@@ -1447,6 +1461,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 	if (!try_module_get(desc->owner))
 		return -ENODEV;
 
+	per_cpu_devid = irq_settings_is_per_cpu_devid(desc);
+
 	new->irq = irq;
 
 	/*
@@ -1554,13 +1570,20 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 */
 		unsigned int oldtype;
 
-		if (irq_is_nmi(desc)) {
+		if (irq_is_nmi(desc) && !per_cpu_devid) {
 			pr_err("Invalid attempt to share NMI for %s (irq %d) on irqchip %s.\n",
 				new->name, irq, desc->irq_data.chip->name);
 			ret = -EINVAL;
 			goto out_unlock;
 		}
 
+		if (per_cpu_devid && !valid_percpu_irqaction(old, new)) {
+			pr_err("Overlapping affinities for %s (irq %d) on irqchip %s.\n",
+				new->name, irq, desc->irq_data.chip->name);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
 		/*
 		 * If nobody did set the configuration before, inherit
 		 * the one provided by the requester.
@@ -1711,7 +1734,7 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		if (!(new->flags & IRQF_NO_AUTOEN) &&
 		    irq_settings_can_autoenable(desc)) {
 			irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
-		} else {
+		} else if (!per_cpu_devid) {
 			/*
 			 * Shared interrupts do not go well with disabling
 			 * auto enable. The sharing interrupt might request
@@ -2346,7 +2369,7 @@ void disable_percpu_nmi(unsigned int irq)
 static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	struct irqaction *action;
+	struct irqaction *action, **action_ptr;
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
 
@@ -2354,21 +2377,33 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 		return NULL;
 
 	scoped_guard(raw_spinlock_irqsave, &desc->lock) {
-		action = desc->action;
-		if (!action || action->percpu_dev_id != dev_id) {
-			WARN(1, "Trying to free already-free IRQ %d\n", irq);
-			return NULL;
+		action_ptr = &desc->action;
+		for (;;) {
+			action = *action_ptr;
+
+			if (!action) {
+				WARN(1, "Trying to free already-free IRQ %d\n", irq);
+				return NULL;
+			}
+
+			if (action->percpu_dev_id == dev_id)
+				break;
+
+			action_ptr = &action->next;
 		}
 
-		if (!cpumask_empty(desc->percpu_enabled)) {
-			WARN(1, "percpu IRQ %d still enabled on CPU%d!\n",
-			     irq, cpumask_first(desc->percpu_enabled));
+		if (cpumask_intersects(desc->percpu_enabled, action->affinity)) {
+			WARN(1, "percpu IRQ %d still enabled on CPU%d!\n", irq,
+			     cpumask_first_and(desc->percpu_enabled, action->affinity));
 			return NULL;
 		}
 
 		/* Found it - now remove it from the list of entries: */
-		desc->action = NULL;
-		desc->istate &= ~IRQS_NMI;
+		*action_ptr = action->next;
+
+		/* Demote from NMI if we killed the last action */
+		if (!desc->action)
+			desc->istate &= ~IRQS_NMI;
 	}
 
 	unregister_handler_proc(irq, action);
@@ -2462,6 +2497,14 @@ struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long f
 	action->percpu_dev_id = dev_id;
 	action->affinity = affinity;
 
+	/*
+	 * We allow some form of sharing for non-overlapping affinity
+	 * masks. Obviously, covering all CPUs prevents any sharing
+	 * the first place.
+	 */
+	if (!cpumask_equal(affinity, cpu_possible_mask))
+		action->flags |= IRQF_SHARED;
+
 	return action;
 }
 
-- 
2.39.2


