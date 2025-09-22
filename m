Return-Path: <linux-acpi+bounces-17185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C4B8F84E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1D977A988A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678E301464;
	Mon, 22 Sep 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dICzztiA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C430101E;
	Mon, 22 Sep 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529727; cv=none; b=tYf3vvEA67x00Nu+GEiPbJR3L/GMGRyiqrx19qkD/8fP24RY/rmZSvaKbHh8LAC6mr6XGWu/a3VhMMi0xOm8yv361vSPZ5ZCdkWvg2o+05LWTPcqk19MdO1SYb7OsbKvSU+yfo5Y0hRguk0QrttSX5M04QGlJIKTwYXMMLmRkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529727; c=relaxed/simple;
	bh=5oCc+dLTBF6I6+VTyZ2PgmQ5+u/2TekQHk9FmxUKaWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKUHMbCMHqSvcdB+K8Jn0Q4rLE506Rai7FVJWhV2xp+nXXI2Q0HSY9RfvMOTDDcVckNvisWOXsUte5tQtoODL3cy5dfL3DrpgHYBC4SeFUH/2O+8pvLb7Sph/AXHWZpcZTykSMpcg94IuSR7Dv9QjUFEVHMiAYFFKkh+oan0320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dICzztiA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F109C2BCB2;
	Mon, 22 Sep 2025 08:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529727;
	bh=5oCc+dLTBF6I6+VTyZ2PgmQ5+u/2TekQHk9FmxUKaWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dICzztiADFw7mPwKkNslW5gqghRlurC9O0SRGucY2k87PX1vZWmEIG9owrjl1U45+
	 2pukEh1dSEgng0KEuBu9yT2r4wFEvqiPThfaLZ7NzbK/Jr/CQ6eZpFc7UIT2hyZ9Yc
	 QQFH2R1wVOxQiz7wUDqXaNupnOttj9pw8zbOQQZNIHypmXMfTu6epxA0GS1u5H85JC
	 KGtne6OkwvU8zlTwDuX9CNfbZo04rrxo3IIz7yhAEQ/X69jIcFC7Soj7upLry/KSon
	 uge2SJZCzOkU225tDn/257o0PlyQR7yymiNu1Net8fLz96/SmBvbSZcq1f8B6EF+18
	 6Bgt0p4pD3iyQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0buf-00000008Kds-2s5s;
	Mon, 22 Sep 2025 08:28:45 +0000
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
Subject: [PATCH v3 14/26] genirq: Add affinity to percpu_devid interrupt requests
Date: Mon, 22 Sep 2025 09:28:21 +0100
Message-ID: <20250922082833.2038905-15-maz@kernel.org>
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

Add an affinity field to both the irqaction structure and the interrupt
request primitives. Nothing is making use of it yet, and the only value
used it NULL, which is used as a shorthand for cpu_possible_mask.

This will shortly get used with actual affinities.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/interrupt.h |  5 +++--
 kernel/irq/manage.c       | 14 ++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 0ec1a71ab4e84..52147d5f432b3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -125,6 +125,7 @@ struct irqaction {
 		void		*dev_id;
 		void __percpu	*percpu_dev_id;
 	};
+	const struct cpumask	*affinity;
 	struct irqaction	*next;
 	irq_handler_t		thread_fn;
 	struct task_struct	*thread;
@@ -181,7 +182,7 @@ request_any_context_irq(unsigned int irq, irq_handler_t handler,
 extern int __must_check
 __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		     unsigned long flags, const char *devname,
-		     void __percpu *percpu_dev_id);
+		     const cpumask_t *affinity, void __percpu *percpu_dev_id);
 
 extern int __must_check
 request_nmi(unsigned int irq, irq_handler_t handler, unsigned long flags,
@@ -192,7 +193,7 @@ request_percpu_irq(unsigned int irq, irq_handler_t handler,
 		   const char *devname, void __percpu *percpu_dev_id)
 {
 	return __request_percpu_irq(irq, handler, 0,
-				    devname, percpu_dev_id);
+				    devname, NULL, percpu_dev_id);
 }
 
 extern int __must_check
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d9ddc30678b5d..5f4c651677436 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2444,10 +2444,14 @@ int setup_percpu_irq(unsigned int irq, struct irqaction *act)
 
 static
 struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long flags,
-					  const char *devname, void __percpu *dev_id)
+					  const char *devname, const cpumask_t *affinity,
+					  void __percpu *dev_id)
 {
 	struct irqaction *action;
 
+	if (!affinity)
+		affinity = cpu_possible_mask;
+
 	action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);
 	if (!action)
 		return NULL;
@@ -2456,6 +2460,7 @@ struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long f
 	action->flags = flags | IRQF_PERCPU | IRQF_NO_SUSPEND;
 	action->name = devname;
 	action->percpu_dev_id = dev_id;
+	action->affinity = affinity;
 
 	return action;
 }
@@ -2466,6 +2471,7 @@ struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long f
  * @handler:	Function to be called when the IRQ occurs.
  * @flags:	Interrupt type flags (IRQF_TIMER only)
  * @devname:	An ascii name for the claiming device
+ * @affinity:	A cpumask describing the target CPUs for this interrupt
  * @dev_id:	A percpu cookie passed back to the handler function
  *
  * This call allocates interrupt resources, but doesn't enable the interrupt
@@ -2478,7 +2484,7 @@ struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned long f
  */
 int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 			 unsigned long flags, const char *devname,
-			 void __percpu *dev_id)
+			 const cpumask_t *affinity, void __percpu *dev_id)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -2495,7 +2501,7 @@ int __request_percpu_irq(unsigned int irq, irq_handler_t handler,
 	if (flags && flags != IRQF_TIMER)
 		return -EINVAL;
 
-	action = create_percpu_irqaction(handler, flags, devname, dev_id);
+	action = create_percpu_irqaction(handler, flags, devname, affinity, dev_id);
 	if (!action)
 		return -ENOMEM;
 
@@ -2560,7 +2566,7 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 		return -EINVAL;
 
 	action = create_percpu_irqaction(handler, IRQF_NO_THREAD | IRQF_NOBALANCING,
-					 name, dev_id);
+					 name, NULL, dev_id);
 	if (!action)
 		return -ENOMEM;
 
-- 
2.47.3


