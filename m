Return-Path: <linux-acpi+bounces-17991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3584BF1329
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 14:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BBC18A24E7
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Oct 2025 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE974320A01;
	Mon, 20 Oct 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPoFkUq6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EC3191DC;
	Mon, 20 Oct 2025 12:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963415; cv=none; b=B/QlBq5kuMkWNNxMZPyzH5QN7uF7NaroUDk1xaed2h/cj5HNaRnF+uTqBHQwr4Xwp/BJ3dMQaswFh2D8VBWBWmWeFS6HBg+RkPC/OrwueA0I5tgcGTW7iO+H4+BEtI7LFxGUwg4NbgAa6wzBIW629O8ZmKbnwfpQyBFdVljNNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963415; c=relaxed/simple;
	bh=fmCo5kAFuF89+9VQ2KPmvYqoWYatB7FFfncDu65bz4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfPFVmtiU42M3SVi+D43+SIZueAzD36FsaR5geHms4cwj61QQgVCOHWA6mG9s9VtHvZSgIDtQIiBaboO6nax/W5mtvT8tph6FcdElZBOircwimRCzOfTi/g3tq7uwWsSygzNloPzfs7ESRNBM3bea4kUBacZ0GU9xSGVCtEN/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPoFkUq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A43C116D0;
	Mon, 20 Oct 2025 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760963414;
	bh=fmCo5kAFuF89+9VQ2KPmvYqoWYatB7FFfncDu65bz4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPoFkUq6SCMP+yvqFtWgUaM0MqRXKXuRJVS1ev1OvECehZul96cb2KEU8O9RfEHi2
	 kKc3C4tosdgP7AYOueRvgc4HBf5M37tiVu/yaDgbr9SDHCE0s8E8Ryl+y0E/W8mlLx
	 D5G942Iw5KGNOWECbjpZiir1t8P5kEQSB0z2Hv0XmpAfambm8neNAmx/x7PGpHG2hc
	 6fm49m7QnQKrJcpVy6f4emoLTQs5OjAsdlcPSYS8EdrH+g3IhE2ZCsLlRijiIgrySi
	 BU71TF7RPGZhzPdbZxRac7oobHmLcSb4HbGxuJclWt0yB1TeRO3kH+EDrvi7ALETng
	 gzZrKCOdU3uGw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vAp1g-0000000FUu2-3SEX;
	Mon, 20 Oct 2025 12:30:12 +0000
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
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>
Subject: [PATCH v4 18/26] perf: arm_pmu: Request specific affinities for percpu NMI/IRQ
Date: Mon, 20 Oct 2025 13:29:35 +0100
Message-ID: <20251020122944.3074811-19-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020122944.3074811-1-maz@kernel.org>
References: <20251020122944.3074811-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, mark.rutland@arm.com, will@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, gregkh@linuxfoundation.org, sven@kernel.org, j@jannau.net, suzuki.poulose@arm.com, james.clark@linaro.org, jonathan.cameron@huawei.com, ruanjinjie@huawei.com, alexandru.elisei@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

From: Will Deacon <will@kernel.org>

Let the PMU driver request both NMI and normal IRQs with an affinity
mask matching the PMU affinity.

Signed-off-by: Will Deacon <will@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
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


