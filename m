Return-Path: <linux-acpi+bounces-17189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FC5B8F85A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48731893737
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6730216B;
	Mon, 22 Sep 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKu4E3jk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AC302149;
	Mon, 22 Sep 2025 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529728; cv=none; b=bkpn2eT7tKu9k/io4iBp8Dd7GTHWgw5RrrLitEMu7MQi5FtzvpTvABLnizLdbbRPJcCSiNWBx98Nk/rS33K8RkMl9k3fMDZJtN4PB3ASczkV+rjY160hNQlBKOC9E+G/Id2cjOVYk7RIA8WimOVSMciYBsCbP1trRS6ty1oGn7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529728; c=relaxed/simple;
	bh=jatrGPs+V413Qd8HV7Zgw/uWOLMuK2m/cjTK6duu/aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgiAES5x9wnjG7qfyaRuOxd1dQkcOfSMUoNp+VvxQpIfdSU0XOemFEYZ18bchCoPu1CSRyaKKJ7qWjX63A48e+LIoTUUoTAnE31iczjW3OGKt9thRWlsGegd5aE9m4OaudFksspsDMYlOXmz1jKijQlQbbtyQumnnF3kBYYh1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKu4E3jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BBFC116B1;
	Mon, 22 Sep 2025 08:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529728;
	bh=jatrGPs+V413Qd8HV7Zgw/uWOLMuK2m/cjTK6duu/aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKu4E3jkq7i6qS5KQd0f8OsGXDqZocsEaFUa+Q8oOVxLkwQ+x7pUm09ggGY8Mh9gw
	 i7CxK15Hj6JI/fda4vo/ZMX9CB2kTK0dsg2TD+IkAJmvNI3vkB3hB0KA1eb4sLZSGF
	 8K4+AvbRoo2aK1H9XCBecdka2KdvoXCT5yXBVqfI7BlrOt5CqcHgPORi1tx6cX2cEO
	 P6zpb8WGvttiO6AWBpkTA64OnAZZcnJPMT3OhDlb3wH291uTBXCBw9dNb8K1Pw5+LH
	 +0+8JJOL1h8bDgc4ElVyod5oqWgl5lc+BBlDt2veaCOBcUrd4dS0+YvaArlNjJHG/t
	 Ih4R4hRv9jg+Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bug-00000008Kds-165t;
	Mon, 22 Sep 2025 08:28:46 +0000
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
	James Clark <james.clark@linaro.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 16/26] genirq: Allow per-cpu interrupt sharing for non-overlapping affinities
Date: Mon, 22 Sep 2025 09:28:23 +0100
Message-ID: <20250922082833.2038905-17-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922082833.2038905-1-maz@kernel.org>
References: <20250922082833.2038905-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com
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
index d1c9e357f64d2..14caa77076192 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -897,8 +897,9 @@ void handle_percpu_irq(struct irq_desc *desc)
 void handle_percpu_devid_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
+	unsigned int cpu = smp_processor_id();
+	struct irqaction *action;
 	irqreturn_t res;
 
 	/*
@@ -910,12 +911,15 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
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
index b1a3140e5f3c9..ea3dbf6fee194 100644
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
2.47.3


