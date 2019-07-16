Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201C26ACB6
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbfGPQ12 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 12:27:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61747 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbfGPQ1U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 12:27:20 -0400
Received: from 79.184.255.39.ipv4.supernova.orange.pl (79.184.255.39) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 047488ca11a0ecf9; Tue, 16 Jul 2019 18:27:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 1/8] PCI: irq: Introduce rearm_wake_irq()
Date:   Tue, 16 Jul 2019 18:10:03 +0200
Message-ID: <3015522.mud9xMNCOm@kreacher>
In-Reply-To: <71085220.z6FKkvYQPX@kreacher>
References: <71085220.z6FKkvYQPX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new function, rearm_wake_irq(), allowing a wakeup IRQ
to be armed for systen wakeup detection again without running any
action handlers associated with it after it has been armed for
wakeup detection and triggered.

That is useful for IRQs, like ACPI SCI, that may deliver wakeup
as well as non-wakeup interrupts when armed for systen wakeup
detection.  In those cases, it may be possible to determine whether
or not the delivered interrupt is a systen wakeup one without
running the entire action handler (or handlers, if the IRQ is
shared) for the IRQ, and if the interrupt turns out to be a
non-wakeup one, the IRQ can be rearmed with the help of the
new function.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/interrupt.h |    1 +
 kernel/irq/pm.c           |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

Index: linux-pm/kernel/irq/pm.c
===================================================================
--- linux-pm.orig/kernel/irq/pm.c
+++ linux-pm/kernel/irq/pm.c
@@ -177,6 +177,26 @@ static void resume_irqs(bool want_early)
 }
 
 /**
+ * rearm_wake_irq - rearm a wakeup interrupt line after signaling wakeup
+ * @irq: Interrupt to rearm
+ */
+void rearm_wake_irq(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+
+	if (!desc || !(desc->istate & IRQS_SUSPENDED) ||
+	    !irqd_is_wakeup_set(&desc->irq_data))
+		return;
+
+	desc->istate &= ~IRQS_SUSPENDED;
+	irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	__enable_irq(desc);
+
+	irq_put_desc_busunlock(desc, flags);
+}
+
+/**
  * irq_pm_syscore_ops - enable interrupt lines early
  *
  * Enable all interrupt lines with %IRQF_EARLY_RESUME set.
Index: linux-pm/include/linux/interrupt.h
===================================================================
--- linux-pm.orig/include/linux/interrupt.h
+++ linux-pm/include/linux/interrupt.h
@@ -238,6 +238,7 @@ extern void teardown_percpu_nmi(unsigned
 /* The following three functions are for the core kernel use only. */
 extern void suspend_device_irqs(void);
 extern void resume_device_irqs(void);
+extern void rearm_wake_irq(unsigned int irq);
 
 /**
  * struct irq_affinity_notify - context for notification of IRQ affinity changes



