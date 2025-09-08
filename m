Return-Path: <linux-acpi+bounces-16486-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF4B49564
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B9E1897161
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75A3112C7;
	Mon,  8 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMj1Y7n/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD43112B3;
	Mon,  8 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349111; cv=none; b=Aw60ZpWzzM3M+lvz51KRr7YytuKbZ65kFEC0JCXdPU7yYfiFIQdZmv9zvJYd6BWEJ7LP1Dn4dprvGKo5iWQLHTwH4215poImiKv83cKSeLXcxVVy0+eY93QjKlniJaxIwQKpEn3GHcJZoKCL26KoRPvYLXEqTvHvQ0mZjvDxfn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349111; c=relaxed/simple;
	bh=n5HinTVrUC0iRzxGfA4dpDcMkrhdGiAa5ZBfKj1EIe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S06bVP8CQEd2DYwLrgKHRwGdmpK/koqKmGLyH9PeVLTYG72isWovIw/cmoxZCm5bWgzq9J//PQIaqMfiiucJlql4t/lgW3AzUU4WicRyYQDf56P8lukmtp016+Yp0f42ZuANaQJmL6PS1EjrojNT3ePIiTThUpmYApsVpxkjnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMj1Y7n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289F0C4CEF9;
	Mon,  8 Sep 2025 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349111;
	bh=n5HinTVrUC0iRzxGfA4dpDcMkrhdGiAa5ZBfKj1EIe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMj1Y7n/8bLj7xCauG1DDxxqWp7/8Fnmr290aYmzsq/zgEalIiJ8h/kqrJKJVtP4O
	 M/HIEVINJFVyTrTbhm+Suo7EZmF9fhhRvpxKVo6CEKR0nVef99pek1FC03DvbiRqAj
	 ZsHda9SdCdT+RlPWH5YA/fKKwME0pfNi5NB07Xek9Ibi+W7sETzFZsUK5Rk2QW5/Jt
	 dHgGk53wrncnhKFZs1L5I5vuHecwiQG/tmS6giHmHbXc1JM7mSXJxW0vBtFCUXDrIW
	 xDq7mvKyEWHsnys31PSSKbm1+9wy1gZPqOADxhhVhrQk5PXx6Boocihse1/+SEiso0
	 wSr61+9XaQfpg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemT-00000004NTm-1F68;
	Mon, 08 Sep 2025 16:31:49 +0000
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
Subject: [PATCH 14/25] genirq: Update request_percpu_nmi() to take an affinity
Date: Mon,  8 Sep 2025 17:31:16 +0100
Message-Id: <20250908163127.2462948-15-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250908163127.2462948-1-maz@kernel.org>
References: <20250908163127.2462948-1-maz@kernel.org>
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
index 6e3c72e9b41cd..d1f738eb77f1e 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -678,7 +678,9 @@ int armpmu_request_irq(int irq, int cpu)
 			irq_ops = &pmunmi_ops;
 		}
 	} else if (armpmu_count_irq_users(cpu, irq) == 0) {
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
index ac394f0b422b8..a17ac522622e7 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2530,6 +2530,7 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
  * @irq:	Interrupt line to allocate
  * @handler:	Function to be called when the IRQ occurs.
  * @name:	An ascii name for the claiming device
+ * @affinity:	A cpumask describing the target CPUs for this interrupt
  * @dev_id:	A percpu cookie passed back to the handler function
  *
  * This call allocates interrupt resources for a per CPU NMI. Per CPU NMIs
@@ -2547,7 +2548,8 @@ EXPORT_SYMBOL_GPL(__request_percpu_irq);
  * will fail returning a negative value.
  */
 int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
-		       const char *name, void __percpu *dev_id)
+		       const char *name,
+		       const struct cpumask *affinity, void __percpu *dev_id)
 {
 	struct irqaction *action;
 	struct irq_desc *desc;
@@ -2564,13 +2566,14 @@ int request_percpu_nmi(unsigned int irq, irq_handler_t handler,
 	    !irq_supports_nmi(desc))
 		return -EINVAL;
 
-	/* The line cannot already be NMI */
-	if (irq_is_nmi(desc))
+	/* The line cannot be NMI already if the new request covers all CPUs */
+	if (irq_is_nmi(desc) &&
+	    (!affinity || cpumask_equal(affinity, cpu_possible_mask)))
 		return -EINVAL;
 
 	action = create_percpu_irqaction(handler,
 					 IRQF_NO_THREAD | IRQF_NOBALANCING,
-					 name, NULL, dev_id);
+					 name, affinity, dev_id);
 	if (!action)
 		return -ENOMEM;
 
-- 
2.39.2


