Return-Path: <linux-acpi+bounces-16482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBFFB49562
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DC53AD5F0
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Sep 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7F3101C0;
	Mon,  8 Sep 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+By+vs2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251453101A0;
	Mon,  8 Sep 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349110; cv=none; b=pCaLLTFxP2fFo5oxgoORPv3Bb16ucaW9v+xqsAcJj0pUy1TtEe+4GHW3BQssjcmRt2OrBmE4m8Riow4qdroYDBs7Z1JWIsWu3n/6SUrfzook/eITxxR2BOp5PU9E7Go+GMl44zuADWdB2wHwOivgaLfiOO0XrQPKtjrMtzVsCwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349110; c=relaxed/simple;
	bh=hcTRxpX9qydE6c0M6SiJkgotsgvSQLYSwolxDoJawY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZuvSg3yIpMtbPB2uUsUrZ9ff4SInGSxljCJrC9+GBto2ZrQctohNbO7KyPuGBgMqjQJXKr+oG7waFwZqy1IvxMI02/YVYttDUq48ub6xd4xpMCt3N2PLPXEHtbmOBoo5ke7+S5R7D5RHcQveBiiOjHYNQj/eECRAPKG9/6DN1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+By+vs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07844C4CEF7;
	Mon,  8 Sep 2025 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349110;
	bh=hcTRxpX9qydE6c0M6SiJkgotsgvSQLYSwolxDoJawY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+By+vs2uH3WX2TdZxlAnscUHM7nb6lslD3pfimdi/HZXVzxyYOEZC79HuxnYKau6
	 GD9o5c46Ww/nHRBk+0Xj+jg8p3doV1VXS08HwSgppdw5X6NIOXsITmcBpbA/AKyjSm
	 6i+3SH4SniGWUyOS/uTSkzaayOUR54/n6ovU3fhVleQ2BOBvPSj3Rqiomi369Stxrk
	 lN4YOg+ZfYcMIHsNlnW/BdZhLP4vOEtl1dN3o7ALvL6EJGNDlCDoyI5A7I4UIsSnXw
	 8paPNWR2aezWc/Kl8WzaYiHXhLsbEpLNg+wkzFZpxyx66+Y081izuxen++mEU2ScYO
	 8HWdRaaKv4Rbw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1uvemS-00000004NTm-0vcu;
	Mon, 08 Sep 2025 16:31:48 +0000
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
Subject: [PATCH 10/25] perf: arm_pmu: Add PMU/CPU affinity tracking
Date: Mon,  8 Sep 2025 17:31:12 +0100
Message-Id: <20250908163127.2462948-11-maz@kernel.org>
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

The ARM PMU code is built around the assumption that different CPU
affinities (either a single CPU in the case of an SPI, or a group
of CPUs for a PPI) must result in different IRQ numbers.

This scheme is about to be removed, so the driver must be able to match
the new behaviour.

For this purpose, add a new per-CPU variable that tracks the PMU
affinities on a per-CPU basis, so that the driver can, from any CPU,
find out which other CPUs it is sharing an interrupt number with.

It is likely that some simplifications could result from this scheme,
but this is good enough to get started.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmu.c          | 37 +++++++++++++++++++++++++--------
 drivers/perf/arm_pmu_acpi.c     |  5 +++++
 drivers/perf/arm_pmu_platform.c |  4 ++++
 include/linux/perf/arm_pmu.h    |  1 +
 4 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 5c310e803dd78..6e3c72e9b41cd 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -26,7 +26,7 @@
 
 #include <asm/irq_regs.h>
 
-static int armpmu_count_irq_users(const int irq);
+static int armpmu_count_irq_users(const int this_cpu, const int irq);
 
 struct pmu_irq_ops {
 	void (*enable_pmuirq)(unsigned int irq);
@@ -64,7 +64,7 @@ static void armpmu_enable_percpu_pmuirq(unsigned int irq)
 static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
 				   void __percpu *devid)
 {
-	if (armpmu_count_irq_users(irq) == 1)
+	if (armpmu_count_irq_users(cpu, irq) == 1)
 		free_percpu_irq(irq, devid);
 }
 
@@ -89,7 +89,7 @@ static void armpmu_disable_percpu_pmunmi(unsigned int irq)
 static void armpmu_free_percpu_pmunmi(unsigned int irq, int cpu,
 				      void __percpu *devid)
 {
-	if (armpmu_count_irq_users(irq) == 1)
+	if (armpmu_count_irq_users(cpu, irq) == 1)
 		free_percpu_nmi(irq, devid);
 }
 
@@ -100,11 +100,20 @@ static const struct pmu_irq_ops percpu_pmunmi_ops = {
 };
 
 DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
+static DEFINE_PER_CPU(const struct cpumask *, pmu_affinity);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
 
 static bool has_nmi;
 
+void armpmu_register_affinity_group(const struct cpumask *aff_grp)
+{
+	int cpu;
+
+	for_each_cpu(cpu, aff_grp)
+		per_cpu(pmu_affinity, cpu) = aff_grp;
+}
+
 static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
 	if (event->hw.flags & ARMPMU_EVT_64BIT)
@@ -580,11 +589,16 @@ static const struct attribute_group armpmu_common_attr_group = {
 	.attrs = armpmu_common_attrs,
 };
 
-static int armpmu_count_irq_users(const int irq)
+static int armpmu_count_irq_users(const int this_cpu, const int irq)
 {
+	const struct cpumask *affinity;
 	int cpu, count = 0;
 
-	for_each_possible_cpu(cpu) {
+	affinity = per_cpu(pmu_affinity, this_cpu);
+	if (WARN_ON(!affinity))
+		return 0;
+
+	for_each_cpu(cpu, affinity) {
 		if (per_cpu(cpu_irq, cpu) == irq)
 			count++;
 	}
@@ -592,12 +606,17 @@ static int armpmu_count_irq_users(const int irq)
 	return count;
 }
 
-static const struct pmu_irq_ops *armpmu_find_irq_ops(int irq)
+static const struct pmu_irq_ops *armpmu_find_irq_ops(int this_cpu, int irq)
 {
 	const struct pmu_irq_ops *ops = NULL;
+	const struct cpumask *affinity;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	affinity = per_cpu(pmu_affinity, this_cpu);
+	if (!affinity)
+		return NULL;
+
+	for_each_cpu(cpu, affinity) {
 		if (per_cpu(cpu_irq, cpu) != irq)
 			continue;
 
@@ -658,7 +677,7 @@ int armpmu_request_irq(int irq, int cpu)
 			has_nmi = true;
 			irq_ops = &pmunmi_ops;
 		}
-	} else if (armpmu_count_irq_users(irq) == 0) {
+	} else if (armpmu_count_irq_users(cpu, irq) == 0) {
 		err = request_percpu_nmi(irq, handler, "arm-pmu", &cpu_armpmu);
 
 		/* If cannot get an NMI, get a normal interrupt */
@@ -672,7 +691,7 @@ int armpmu_request_irq(int irq, int cpu)
 		}
 	} else {
 		/* Per cpudevid irq was already requested by another CPU */
-		irq_ops = armpmu_find_irq_ops(irq);
+		irq_ops = armpmu_find_irq_ops(cpu, irq);
 
 		if (WARN_ON(!irq_ops))
 			err = -EINVAL;
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 05dda19c5359a..a5956fa728070 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -212,6 +212,11 @@ static int arm_pmu_acpi_parse_irqs(void)
 			pr_warn("No ACPI PMU IRQ for CPU%d\n", cpu);
 		}
 
+		if (irq_is_percpu_devid(irq))
+			armpmu_register_affinity_group(cpu_possible_mask);
+		else
+			armpmu_register_affinity_group(cpumask_of(cpu));
+
 		/*
 		 * Log and request the IRQ so the core arm_pmu code can manage
 		 * it. We'll have to sanity-check IRQs later when we associate
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 9c0494d8a867a..0c7d5065e9074 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -53,6 +53,8 @@ static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq,
 	for_each_cpu(cpu, &pmu->supported_cpus)
 		per_cpu(hw_events->irq, cpu) = irq;
 
+	armpmu_register_affinity_group(&pmu->supported_cpus);
+
 	return 0;
 }
 
@@ -152,6 +154,8 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 		cpumask_set_cpu(cpu, &pmu->supported_cpus);
 	}
 
+	armpmu_register_affinity_group(&pmu->supported_cpus);
+
 	return 0;
 }
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 93c9a26492fcf..7bf548678b288 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -171,6 +171,7 @@ struct pmu_probe_info {
 int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
+void armpmu_register_affinity_group(const struct cpumask *);
 
 #ifdef CONFIG_ACPI
 int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
-- 
2.39.2


