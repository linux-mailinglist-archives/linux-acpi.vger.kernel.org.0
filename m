Return-Path: <linux-acpi+bounces-17190-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1D7B8F85D
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B632A038F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3767F30276E;
	Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrguNaWK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0538E302743;
	Mon, 22 Sep 2025 08:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529729; cv=none; b=P6Dvq88C3czRdmSTRM1eCMWhtyrdHqhnSnfI20hw6nYQNSgh9ZofEJ/lGJUbqyrQPfp1zleFTbwrboopjEtqnmDbXJWrqzt8yY40fpwhTIExYQ9SX6Zovo2dDkVXKVXaqB6Y+8wCMQFg8gsnREoQTbL0DjJuB0em6eDNoG4ER0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529729; c=relaxed/simple;
	bh=LdDBGeu/vP85lq7NNzq3G3yDq8UtLVM6D6o0nOOwgZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyFytgx5J9bpbsSWxgmyAqMj0wwxlEBXjnBXfq2+gArvIterLzqgmXsaLau4MD+XFLCax3Yzs2wHG2MMSNhaWSmm+JPePfky9jgCnEvDwFBg3wWzk+s7VUVnf2EXM0kDCHmnAhxOd4EEAdnf42PBnzmWzX4kxe8DQwloPYftH2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrguNaWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A6CC19422;
	Mon, 22 Sep 2025 08:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758529728;
	bh=LdDBGeu/vP85lq7NNzq3G3yDq8UtLVM6D6o0nOOwgZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrguNaWKyM+dzFtbYImsxdH5B1vU2VN3vBPkKkduQzcEC1RqepokzmRiA+97Tfg7p
	 BbkRCcx6Wby5kr6YZaE5WdmgJ0cyPT/HDRYxtiHxYou8sJGdiITagvX5AFQxYZIL52
	 JMe5UnRncGpIyoS+TzIz8x5R7ATO8ivRCs/qWst+hcP0LBDYikpnb8wjhUDMKgdXhX
	 xzAe74qRdGHRvn5ETQBgRZGSmHkMvqCPux2yXZOeCaPM+q61hi/wsA2yqZJjDj21F6
	 Pg3tT6EM+opuQRrFKpIwHl7bs9gJ7ltPyJbhMiHaKVfSw9JwZsmieeT//5lYijynbi
	 z1qDf1tYP3REg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0bug-00000008Kds-3aGB;
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
Subject: [PATCH v3 18/26] perf: arm_pmu: Request specific affinities for percpu NMI/IRQ
Date: Mon, 22 Sep 2025 09:28:25 +0100
Message-ID: <20250922082833.2038905-19-maz@kernel.org>
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

From: Will Deacon <will@kernel.org>

Let the PMU driver request both NMI and normal IRQs with an affinity
mask matching the PMU affinity.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmu.c          | 44 +++++++++++++++++++--------------
 drivers/perf/arm_pmu_acpi.c     |  2 +-
 drivers/perf/arm_pmu_platform.c |  4 +--
 include/linux/perf/arm_pmu.h    |  4 +--
 4 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 22c601b46c858..959ceb3d1f556 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -26,7 +26,8 @@
 
 #include <asm/irq_regs.h>
 
-static int armpmu_count_irq_users(const int irq);
+static int armpmu_count_irq_users(const struct cpumask *affinity,
+				  const int irq);
 
 struct pmu_irq_ops {
 	void (*enable_pmuirq)(unsigned int irq);
@@ -64,7 +65,9 @@ static void armpmu_enable_percpu_pmuirq(unsigned int irq)
 static void armpmu_free_percpu_pmuirq(unsigned int irq, int cpu,
 				   void __percpu *devid)
 {
-	if (armpmu_count_irq_users(irq) == 1)
+	struct arm_pmu *armpmu = *per_cpu_ptr((void * __percpu *)devid, cpu);
+
+	if (armpmu_count_irq_users(&armpmu->supported_cpus, irq) == 1)
 		free_percpu_irq(irq, devid);
 }
 
@@ -89,7 +92,9 @@ static void armpmu_disable_percpu_pmunmi(unsigned int irq)
 static void armpmu_free_percpu_pmunmi(unsigned int irq, int cpu,
 				      void __percpu *devid)
 {
-	if (armpmu_count_irq_users(irq) == 1)
+	struct arm_pmu *armpmu = *per_cpu_ptr((void * __percpu *)devid, cpu);
+
+	if (armpmu_count_irq_users(&armpmu->supported_cpus, irq) == 1)
 		free_percpu_nmi(irq, devid);
 }
 
@@ -580,11 +585,11 @@ static const struct attribute_group armpmu_common_attr_group = {
 	.attrs = armpmu_common_attrs,
 };
 
-static int armpmu_count_irq_users(const int irq)
+static int armpmu_count_irq_users(const struct cpumask *affinity, const int irq)
 {
 	int cpu, count = 0;
 
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, affinity) {
 		if (per_cpu(cpu_irq, cpu) == irq)
 			count++;
 	}
@@ -592,12 +597,13 @@ static int armpmu_count_irq_users(const int irq)
 	return count;
 }
 
-static const struct pmu_irq_ops *armpmu_find_irq_ops(int irq)
+static const struct pmu_irq_ops *
+armpmu_find_irq_ops(const struct cpumask *affinity, int irq)
 {
 	const struct pmu_irq_ops *ops = NULL;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_cpu(cpu, affinity) {
 		if (per_cpu(cpu_irq, cpu) != irq)
 			continue;
 
@@ -609,22 +615,25 @@ static const struct pmu_irq_ops *armpmu_find_irq_ops(int irq)
 	return ops;
 }
 
-void armpmu_free_irq(int irq, int cpu)
+void armpmu_free_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu)
 {
 	if (per_cpu(cpu_irq, cpu) == 0)
 		return;
 	if (WARN_ON(irq != per_cpu(cpu_irq, cpu)))
 		return;
 
-	per_cpu(cpu_irq_ops, cpu)->free_pmuirq(irq, cpu, &cpu_armpmu);
+	per_cpu(cpu_irq_ops, cpu)->free_pmuirq(irq, cpu, armpmu);
 
 	per_cpu(cpu_irq, cpu) = 0;
 	per_cpu(cpu_irq_ops, cpu) = NULL;
 }
 
-int armpmu_request_irq(int irq, int cpu)
+int armpmu_request_irq(struct arm_pmu * __percpu *pcpu_armpmu, int irq, int cpu)
 {
 	int err = 0;
+	struct arm_pmu **armpmu = per_cpu_ptr(pcpu_armpmu, cpu);
+	const struct cpumask *affinity = *armpmu ? &(*armpmu)->supported_cpus :
+						   cpu_possible_mask; /* ACPI */
 	const irq_handler_t handler = armpmu_dispatch_irq;
 	const struct pmu_irq_ops *irq_ops;
 
@@ -646,25 +655,24 @@ int armpmu_request_irq(int irq, int cpu)
 			    IRQF_NOBALANCING | IRQF_NO_AUTOEN |
 			    IRQF_NO_THREAD;
 
-		err = request_nmi(irq, handler, irq_flags, "arm-pmu",
-				  per_cpu_ptr(&cpu_armpmu, cpu));
+		err = request_nmi(irq, handler, irq_flags, "arm-pmu", armpmu);
 
 		/* If cannot get an NMI, get a normal interrupt */
 		if (err) {
 			err = request_irq(irq, handler, irq_flags, "arm-pmu",
-					  per_cpu_ptr(&cpu_armpmu, cpu));
+					  armpmu);
 			irq_ops = &pmuirq_ops;
 		} else {
 			has_nmi = true;
 			irq_ops = &pmunmi_ops;
 		}
-	} else if (armpmu_count_irq_users(irq) == 0) {
-		err = request_percpu_nmi(irq, handler, "arm-pmu", NULL, &cpu_armpmu);
+	} else if (armpmu_count_irq_users(affinity, irq) == 0) {
+		err = request_percpu_nmi(irq, handler, "arm-pmu", affinity, pcpu_armpmu);
 
 		/* If cannot get an NMI, get a normal interrupt */
 		if (err) {
-			err = request_percpu_irq(irq, handler, "arm-pmu",
-						 &cpu_armpmu);
+			err = request_percpu_irq_affinity(irq, handler, "arm-pmu",
+							  affinity, pcpu_armpmu);
 			irq_ops = &percpu_pmuirq_ops;
 		} else {
 			has_nmi = true;
@@ -672,7 +680,7 @@ int armpmu_request_irq(int irq, int cpu)
 		}
 	} else {
 		/* Per cpudevid irq was already requested by another CPU */
-		irq_ops = armpmu_find_irq_ops(irq);
+		irq_ops = armpmu_find_irq_ops(affinity, irq);
 
 		if (WARN_ON(!irq_ops))
 			err = -EINVAL;
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 05dda19c5359a..e80f76d95e68b 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -218,7 +218,7 @@ static int arm_pmu_acpi_parse_irqs(void)
 		 * them with their PMUs.
 		 */
 		per_cpu(pmu_irqs, cpu) = irq;
-		err = armpmu_request_irq(irq, cpu);
+		err = armpmu_request_irq(&probed_pmus, irq, cpu);
 		if (err)
 			goto out_err;
 	}
diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 9c0494d8a867a..1c9e50a132015 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -165,7 +165,7 @@ static int armpmu_request_irqs(struct arm_pmu *armpmu)
 		if (!irq)
 			continue;
 
-		err = armpmu_request_irq(irq, cpu);
+		err = armpmu_request_irq(&hw_events->percpu_pmu, irq, cpu);
 		if (err)
 			break;
 	}
@@ -181,7 +181,7 @@ static void armpmu_free_irqs(struct arm_pmu *armpmu)
 	for_each_cpu(cpu, &armpmu->supported_cpus) {
 		int irq = per_cpu(hw_events->irq, cpu);
 
-		armpmu_free_irq(irq, cpu);
+		armpmu_free_irq(&hw_events->percpu_pmu, irq, cpu);
 	}
 }
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 93c9a26492fcf..6690bd77aa4ee 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -190,8 +190,8 @@ bool arm_pmu_irq_is_nmi(void);
 struct arm_pmu *armpmu_alloc(void);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
-int armpmu_request_irq(int irq, int cpu);
-void armpmu_free_irq(int irq, int cpu);
+int armpmu_request_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
+void armpmu_free_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
 
 #define ARMV8_PMU_PDEV_NAME "armv8-pmu"
 
-- 
2.47.3


