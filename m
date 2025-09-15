Return-Path: <linux-acpi+bounces-16907-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8CB573CF
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 10:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404987AAAC8
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DEC2F6175;
	Mon, 15 Sep 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtlC0EEL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13002F616F;
	Mon, 15 Sep 2025 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926636; cv=none; b=aWK4bOa3MGbH03+AVNdY8f2xVKqnPxJ2OAkbMoOe+GH3yf6nSIIlmUCIudXGO7WpKo1ZJqb7gL+0fEv+WtmWtvPEyLOFDOI7qp3Ht9gOuueT/W4HF2tDJegs+3p5BF4VPPQZYKZS6SSE8eEDxgBadpQOXP27R95xTVTgmDA05jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926636; c=relaxed/simple;
	bh=EZQ4JrqHharY6q8WNQFJbTXtkce/9D5/UoLm8tht2Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnQSkiAk4zhnHMWCW4MBS1k1msU+IPjU5E5ZHVV38EfA7debJx4t5vRx4bonF+sVAA3VKNC+Q6kjO9pSlP4HQC55Uc8UfsuNs4IyQqMeH6bQHb+kuc8CuzzXrk/nhpbsQurOl4jupBqqeF02cQVYF4PJ5K8Q3l5YUmoNs8ri6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtlC0EEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0516C4CEFB;
	Mon, 15 Sep 2025 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926636;
	bh=EZQ4JrqHharY6q8WNQFJbTXtkce/9D5/UoLm8tht2Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtlC0EELpPCRFAtkDfYPeiH7WNB1BsZ0mnjdn6xtexr6OJNvwUJSgswNjbDr0kQXk
	 /yL7DdaTGcq7b03y2EYlurobTXdBoPl3TK3x8wBxGE67CNA4YRQELhCKAAHHIhUnAm
	 Lh9NIzh21ByLRvufhT+X9adGDMF2r0+M/E5xR3FRSp+iQuSQI5jyFSqz+MXN/uDuVH
	 C4U789t+OFxeUBcot5BvmVR7K5+V9RX8bftukUn8+vSdUkwjxBERTrJB2dDCrYi5v8
	 xeFQ6UGh2fSIbpzk1W6yOsRWmDAIEsVmSYIgJ6HjKsHp+QGCdW4xA5+QmS9vxPlhU6
	 sUx3ubxdoWOvQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uy51O-00000006IHP-44RS;
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
Subject: [PATCH v2 15/25] genirq: Update request_percpu_nmi() to take an affinity
Date: Mon, 15 Sep 2025 09:56:52 +0100
Message-Id: <20250915085702.519996-16-maz@kernel.org>
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

Continue spreading the notion of affinity to the percpu interrupt
request code by updating the call sites that use request_percpu_nmi()
(all two of them) to take an affinity pointer. This pointer is
firmly NULL for now.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/smp.c   |  2 +-
 drivers/perf/arm_pmu.c    |  4 +++-
 include/linux/interrupt.h |  4 ++--
 kernel/irq/manage.c       | 11 +++++++----
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 68cea3a4a35ca..6fb838eee2e7d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -1094,7 +1094,7 @@ static void ipi_setup_sgi(int ipi)
 	irq = ipi_irq_base + ipi;
 
 	if (ipi_should_be_nmi(ipi)) {
-		err = request_percpu_nmi(irq, ipi_handler, "IPI", &irq_stat);
+		err = request_percpu_nmi(irq, ipi_handler, "IPI", NULL, &irq_stat);
 		WARN(err, "Could not request IRQ %d as NMI, err=%d\n", irq, err);
 	} else {
 		err = request_percpu_irq(irq, ipi_handler, "IPI", &irq_stat);
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 5c310e803dd78..de9eca2290a97 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -659,7 +659,9 @@ int armpmu_request_irq(int irq, int cpu)
 			irq_ops = &pmunmi_ops;
 		}
 	} else if (armpmu_count_irq_users(irq) == 0) {
-		err = request_percpu_nmi(irq, handler, "arm-pmu", &cpu_armpmu);
+		err = request_percpu_nmi(irq, handler, "arm-pmu",
+					 NULL,
+					 &cpu_armpmu);
 
 		/* If cannot get an NMI, get a normal interrupt */
 		if (err) {
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 52147d5f432b3..2134e7c08c169 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -197,8 +197,8 @@ request_percpu_irq(unsigned int irq, irq_handler_t handler,
 }
 
 extern int __must_check
-request_percpu_nmi(unsigned int irq, irq_handler_t handler,
-		   const char *devname, void __percpu *dev);
+request_percpu_nmi(unsigned int irq, irq_handler_t handler, const char *devname,
+		   const struct cpumask *affinity, void __percpu *dev_id);
 
 extern const void *free_irq(unsigned int, void *);
 extern void free_percpu_irq(unsigned int, void __percpu *);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5f4c651677436..49c237aca2a70 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2527,6 +2527,7 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
  * @irq:	Interrupt line to allocate
  * @handler:	Function to be called when the IRQ occurs.
  * @name:	An ascii name for the claiming device
+ * @affinity:	A cpumask describing the target CPUs for this interrupt
  * @dev_id:	A percpu cookie passed back to the handler function
  *
  * This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
@@ -2544,7 +2545,8 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
  * will fail returning a negative value.
  */
 int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
-		       const char *name, void __percpu *dev_id)
+		       const char *name,
+		       const struct cpumask *affinity, void __percpu *dev_id)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -2561,12 +2563,13 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 	    !irq_supports_nmi(desc))
 		return -EINVAL;
 
-	/* The line cannot already be NMI */
-	if (irq_is_nmi(desc))
+	/* The line cannot be NMI already if the new request covers all CPUs */
+	if (irq_is_nmi(desc) &&
+	    (!affinity || cpumask_equal(affinity, cpu_possible_mask)))
 		return -EINVAL;
 
 	action = create_percpu_irqaction(handler, IRQF_NO_THREAD | IRQF_NOBALANCING,
-					 name, NULL, dev_id);
+					 name, affinity, dev_id);
 	if (!action)
 		return -ENOMEM;
 
-- 
2.39.2


