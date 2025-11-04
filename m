Return-Path: <linux-acpi+bounces-18480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B031FC2F852
	for <lists+linux-acpi@lfdr.de>; Tue, 04 Nov 2025 07:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFE9189F72C
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Nov 2025 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1289B22333B;
	Tue,  4 Nov 2025 06:51:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053B21ABC9;
	Tue,  4 Nov 2025 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762239079; cv=none; b=KLES9APJjKZYvgxvY6lnoNSIz9pnuSo7vNbGtWkUoZU9CzD1o7sZUnxW28vWYOY2ZCKmSNttY0XvFpv1uh3D8uEY7bw0jh1FQnUb4AfdoFnoolz1+u+DEWMB9xCUC4EdUT+cP0VtBfu4ESOzpS/4FD9+Kk7UUe//78uGZniHyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762239079; c=relaxed/simple;
	bh=RsL4BomoAXIngr5dz57ebM1HeeCBddI9yZjL9kK0X3k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fv64Rf0zg6Bp5bWfIWJLycv3CZC3XA3CPHTsrs3hSxV3LsCiqfzF0lv/JtfhAnIeQADm/ODCuFgS5CT2ECRe2xYHDIHZCOVQsdcEhqdmOBZuXlYGYKTpRrtirMdEZvfpeVFW2RnsLYzvPQrv/n9Ub61Eb2LNLgb762g7akSd/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4d0zbB3GC9zpStT;
	Tue,  4 Nov 2025 14:49:42 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A73314027A;
	Tue,  4 Nov 2025 14:51:11 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemr500004.china.huawei.com (7.202.195.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 14:51:10 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<prime.zeng@hisilicon.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
Date: Tue, 4 Nov 2025 14:50:39 +0800
Message-ID: <20251104065039.1675549-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500004.china.huawei.com (7.202.195.141)

Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
scheduler tick but defers the update of arch_freq_scale to a separate
thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.

However, this deferred update mechanism is unnecessary and introduces extra
overhead for non-PCC register spaces (e.g. System Memory or FFH), where
accessing the regs won't sleep and can be safely performed from the tick
context.

Furthermore, with the CPPC FIE registered, it throws repeated warnings of
"cppc_scale_freq_workfn: failed to read perf counters" on our platform with
the CPC regs in System Memory and a power-down idle state enabled.  That's
because the remote CPU can be in a power-down idle state, and reading its
perf counters returns 0.  Moving the FIE handling back to the scheduler
tick process makes the CPU handle its own perf counters, so it won't be
idle and the issue would be inherently solved.

To address the above issues, update arch_freq_scale directly in ticks for
non-PCC regs and keep the deferred update mechanism for PCC regs.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
We have tested this on Kunpeng SoCs with the CPC regs both in System Memory
and FFH.  More tests on other platforms are welcome.

Changelog:

v3:
- Stash the state of 'cppc_perf_ctrs_in_pcc' so it won't have to check the CPC
  regs of all CPUs everywhere (Thanks to the suggestion from Beata Michalska).
- Update the commit log, explaining more on the warning issue caused by
  accessing perf counters on remote CPUs.
- Drop Patch 1 that has been accepted, and rebase Patch 2 on that.

v2:
https://lore.kernel.org/linux-pm/20250828110212.2108653-1-zhanjie9@hisilicon.com/
- Update the cover letter and the commit log based on v1 discussion
- Update FIE arch_freq_scale in ticks for non-PCC regs

v1:
https://lore.kernel.org/linux-pm/20250730032312.167062-1-yubowen8@huawei.com/
---
 drivers/cpufreq/cppc_cpufreq.c | 60 ++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9eac77c4f294..4fcaec7e2034 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -48,37 +48,31 @@ struct cppc_freq_invariance {
 };
 
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
+static bool perf_ctrs_in_pcc;
 static struct kthread_worker *kworker_fie;
 
 static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
 
 /**
- * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
- * @work: The work item.
+ * __cppc_scale_freq_tick - CPPC arch_freq_scale updater for frequency invariance
+ * @cppc_fi: per-cpu CPPC FIE data.
  *
- * The CPPC driver register itself with the topology core to provide its own
+ * The CPPC driver registers itself with the topology core to provide its own
  * implementation (cppc_scale_freq_tick()) of topology_scale_freq_tick() which
  * gets called by the scheduler on every tick.
  *
  * Note that the arch specific counters have higher priority than CPPC counters,
  * if available, though the CPPC driver doesn't need to have any special
  * handling for that.
- *
- * On an invocation of cppc_scale_freq_tick(), we schedule an irq work (since we
- * reach here from hard-irq context), which then schedules a normal work item
- * and cppc_scale_freq_workfn() updates the per_cpu arch_freq_scale variable
- * based on the counter updates since the last tick.
  */
-static void cppc_scale_freq_workfn(struct kthread_work *work)
+static void __cppc_scale_freq_tick(struct cppc_freq_invariance *cppc_fi)
 {
-	struct cppc_freq_invariance *cppc_fi;
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};
 	struct cppc_cpudata *cpu_data;
 	unsigned long local_freq_scale;
 	u64 perf;
 
-	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
 	cpu_data = cppc_fi->cpu_data;
 
 	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
@@ -102,6 +96,14 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 	per_cpu(arch_freq_scale, cppc_fi->cpu) = local_freq_scale;
 }
 
+static void cppc_scale_freq_workfn(struct kthread_work *work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+
+	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
+	__cppc_scale_freq_tick(cppc_fi);
+}
+
 static void cppc_irq_work(struct irq_work *irq_work)
 {
 	struct cppc_freq_invariance *cppc_fi;
@@ -110,7 +112,14 @@ static void cppc_irq_work(struct irq_work *irq_work)
 	kthread_queue_work(kworker_fie, &cppc_fi->work);
 }
 
-static void cppc_scale_freq_tick(void)
+/*
+ * Reading perf counters may sleep if the CPC regs are in PCC.  Thus, we
+ * schedule an irq work in scale_freq_tick (since we reach here from hard-irq
+ * context), which then schedules a normal work item cppc_scale_freq_workfn()
+ * that updates the per_cpu arch_freq_scale variable based on the counter
+ * updates since the last tick.
+ */
+static void cppc_scale_freq_tick_pcc(void)
 {
 	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
 
@@ -121,6 +130,11 @@ static void cppc_scale_freq_tick(void)
 	irq_work_queue(&cppc_fi->irq_work);
 }
 
+static void cppc_scale_freq_tick(void)
+{
+	__cppc_scale_freq_tick(&per_cpu(cppc_freq_inv, smp_processor_id()));
+}
+
 static struct scale_freq_data cppc_sftd = {
 	.source = SCALE_FREQ_SOURCE_CPPC,
 	.set_freq_scale = cppc_scale_freq_tick,
@@ -138,8 +152,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		cppc_fi->cpu = cpu;
 		cppc_fi->cpu_data = policy->driver_data;
-		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
-		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+		if (perf_ctrs_in_pcc) {
+			kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+			init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+		}
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
 
@@ -177,6 +193,9 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	/* policy->cpus will be empty here, use related_cpus instead */
 	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
 
+	if (!perf_ctrs_in_pcc)
+		return;
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		irq_work_sync(&cppc_fi->irq_work);
@@ -201,17 +220,22 @@ static void __init cppc_freq_invariance_init(void)
 	};
 	int ret;
 
+	perf_ctrs_in_pcc = cppc_perf_ctrs_in_pcc();
+
 	if (fie_disabled != FIE_ENABLED && fie_disabled != FIE_DISABLED) {
-		fie_disabled = FIE_ENABLED;
-		if (cppc_perf_ctrs_in_pcc()) {
+		if (!perf_ctrs_in_pcc) {
+			fie_disabled = FIE_ENABLED;
+		} else {
 			pr_info("FIE not enabled on systems with registers in PCC\n");
 			fie_disabled = FIE_DISABLED;
 		}
 	}
 
-	if (fie_disabled)
+	if (fie_disabled || !perf_ctrs_in_pcc)
 		return;
 
+	cppc_sftd.set_freq_scale = cppc_scale_freq_tick_pcc;
+
 	kworker_fie = kthread_run_worker(0, "cppc_fie");
 	if (IS_ERR(kworker_fie)) {
 		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
@@ -231,7 +255,7 @@ static void __init cppc_freq_invariance_init(void)
 
 static void cppc_freq_invariance_exit(void)
 {
-	if (fie_disabled)
+	if (fie_disabled || !perf_ctrs_in_pcc)
 		return;
 
 	kthread_destroy_worker(kworker_fie);
-- 
2.33.0


