Return-Path: <linux-acpi+bounces-19399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7954CC9DA48
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 04:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11A93A93EC
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 03:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39AC256C88;
	Wed,  3 Dec 2025 03:25:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3012417FB;
	Wed,  3 Dec 2025 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732335; cv=none; b=COYXxu+siRjF+r9uGiPtxA8lg9E3PgFYxp+ynhsfjCJllxBoIYVOvVaGIAeHPt0ZexGLBFRyRp4/7bb+/pqYSD8gaRuJ7aY7IbGWkRa3P5C7lskgTXh+WLAl9666EXfWWEetNvBFu0oF0toVFVTWeGxe+hM/QUochNpvxJAN3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732335; c=relaxed/simple;
	bh=cpgSJbct+ErUbb8i/hls1/s2X5Og7HFjwl6wIEvcHt8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DcCFjFIBkAaTwZfuOcH2bwoQwx9HMGC4Oh1Oi5TNQInjmdHVr44/ouZj+20B5gFw9m+s3zjxUtpqqC41b5XRckUQghHzAnwte1zqxLPY8t08xcPTro/deuTJzO04XFl8b1eso2hCew3MZG1vt81rkFS8QDcxsXk6fjaHciT+nx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dLjdx0J4TzLlWD;
	Wed,  3 Dec 2025 11:23:33 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id AF48D1A0174;
	Wed,  3 Dec 2025 11:25:24 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Dec 2025 11:25:23 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v4 3/3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
Date: Wed, 3 Dec 2025 11:24:22 +0800
Message-ID: <20251203032422.3232957-4-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)

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
 drivers/cpufreq/cppc_cpufreq.c | 77 +++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 947b4e2e1d4e..36e8a75a37f1 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -54,31 +54,24 @@ static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
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
@@ -102,6 +95,24 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 	per_cpu(arch_freq_scale, cppc_fi->cpu) = local_freq_scale;
 }
 
+static void cppc_scale_freq_tick(void)
+{
+	__cppc_scale_freq_tick(&per_cpu(cppc_freq_inv, smp_processor_id()));
+}
+
+static struct scale_freq_data cppc_sftd = {
+	.source = SCALE_FREQ_SOURCE_CPPC,
+	.set_freq_scale = cppc_scale_freq_tick,
+};
+
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
@@ -110,7 +121,14 @@ static void cppc_irq_work(struct irq_work *irq_work)
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
 
@@ -121,13 +139,14 @@ static void cppc_scale_freq_tick(void)
 	irq_work_queue(&cppc_fi->irq_work);
 }
 
-static struct scale_freq_data cppc_sftd = {
+static struct scale_freq_data cppc_sftd_pcc = {
 	.source = SCALE_FREQ_SOURCE_CPPC,
-	.set_freq_scale = cppc_scale_freq_tick,
+	.set_freq_scale = cppc_scale_freq_tick_pcc,
 };
 
 static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
+	struct scale_freq_data *sftd = &cppc_sftd;
 	struct cppc_freq_invariance *cppc_fi;
 	int cpu, ret;
 
@@ -138,8 +157,11 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		cppc_fi->cpu = cpu;
 		cppc_fi->cpu_data = policy->driver_data;
-		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
-		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+		if (cppc_perf_ctrs_in_pcc_cpu(cpu)) {
+			kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+			init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+			sftd = &cppc_sftd_pcc;
+		}
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
 
@@ -155,7 +177,7 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 	}
 
 	/* Register for freq-invariance */
-	topology_set_scale_freq_source(&cppc_sftd, policy->cpus);
+	topology_set_scale_freq_source(sftd, policy->cpus);
 }
 
 /*
@@ -178,6 +200,8 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
+		if (!cppc_perf_ctrs_in_pcc_cpu(cpu))
+			continue;
 		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
 		irq_work_sync(&cppc_fi->irq_work);
 		kthread_cancel_work_sync(&cppc_fi->work);
@@ -206,6 +230,7 @@ static void cppc_fie_kworker_init(void)
 		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
 			PTR_ERR(kworker_fie));
 		fie_disabled = FIE_DISABLED;
+		kworker_fie = NULL;
 		return;
 	}
 
@@ -215,20 +240,24 @@ static void cppc_fie_kworker_init(void)
 			ret);
 		kthread_destroy_worker(kworker_fie);
 		fie_disabled = FIE_DISABLED;
+		kworker_fie = NULL;
 	}
 }
 
 static void __init cppc_freq_invariance_init(void)
 {
-	if (fie_disabled != FIE_ENABLED && fie_disabled != FIE_DISABLED) {
-		fie_disabled = FIE_ENABLED;
-		if (cppc_perf_ctrs_in_pcc()) {
+	bool perf_ctrs_in_pcc = cppc_perf_ctrs_in_pcc();
+
+	if (fie_disabled == FIE_UNSET) {
+		if (perf_ctrs_in_pcc) {
 			pr_info("FIE not enabled on systems with registers in PCC\n");
 			fie_disabled = FIE_DISABLED;
+		} else {
+			fie_disabled = FIE_ENABLED;
 		}
 	}
 
-	if (fie_disabled)
+	if (fie_disabled || !perf_ctrs_in_pcc)
 		return;
 
 	cppc_fie_kworker_init();
@@ -236,10 +265,8 @@ static void __init cppc_freq_invariance_init(void)
 
 static void cppc_freq_invariance_exit(void)
 {
-	if (fie_disabled)
-		return;
-
-	kthread_destroy_worker(kworker_fie);
+	if (kworker_fie)
+		kthread_destroy_worker(kworker_fie);
 }
 
 #else
-- 
2.33.0


