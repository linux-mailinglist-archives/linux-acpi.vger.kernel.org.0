Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4776B3334D7
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Mar 2021 06:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCJFYG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Mar 2021 00:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhCJFXx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Mar 2021 00:23:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E053C061760
        for <linux-acpi@vger.kernel.org>; Tue,  9 Mar 2021 21:23:53 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n9so9656813pgi.7
        for <linux-acpi@vger.kernel.org>; Tue, 09 Mar 2021 21:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MkVUxgwyPS3aEheKZYSBvapF/1MfUHgnW/8MUkfzrCE=;
        b=o41+CqQkG9FctEKF9oKuahffqzu9TZE/9oxqYUhxniwB3TFnsWlD9AQQAOgDadbjE/
         eQZJhsx7IoMJqbME2V37BWBoV7gF43PFep+bRFmABnnBkCIpHb7IJpXs0eTRHBnXagAG
         HBc+oRWTxoLQdQn8B33suXFnLTjy1RUIcsrQlMlK9wYIYlzUC8kfg03uts5cYWPaEfjg
         7kCJTipkfATqVXd73RDiQHb40sInsdBNngusbPHQVHhE/XoW+BSsdfAD8EBrqlXJN/RO
         iZvw/q73G9npqraJ/yPgCNKTA0N6xum30lHoXe99mDVQL4A5MbW+kNYWV6N8Ba11Y+hE
         5EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MkVUxgwyPS3aEheKZYSBvapF/1MfUHgnW/8MUkfzrCE=;
        b=hnbu7pYD3q8+46z1u8r6karm5Twc8cncTB2J6bx/TJJ5KEnMSnHmCwPkn2rnwSXCd5
         exJf/SejJ6g7w/bZb/HxHSnd1cvZ6ne4nVoScwhCGct/xe0wtfkqZLryoFd4J86i5SuT
         0gWpSp499bCnIWdDtSVMtRwQdn5HCPodFAkUEOL1nQC4oOusRR+v10313/IClUHSBtNg
         6o/N3ApDsTAKWpzpy+tSUuElNX8R44ucnti89B00DwVSY8Mij/ItaIAMFMJ1zq9+U2d1
         zcYuKeBU3lafZe2yUtU9qZpsiP8dkbZmnq0rVDZkUNApqrfKRo9yC6WTi0ci8al2dxN1
         Yjrg==
X-Gm-Message-State: AOAM530vy9+XTacgrD60rNdTeuRvpvkFFs1EjRm0Gd/o7cYOk0J6+jWd
        XDxz0MRrRIJvQwnQZu6ByZ3kIQ==
X-Google-Smtp-Source: ABdhPJy6xnfsJrkUj3uOk6RhMOfN24ZWOtCJb02Yz1JiSld9zo6DEIm3wY/Vx5iSksicOWD+yOq52g==
X-Received: by 2002:aa7:8d92:0:b029:1ee:75d1:c87 with SMTP id i18-20020aa78d920000b02901ee75d10c87mr1573717pfr.9.1615353832983;
        Tue, 09 Mar 2021 21:23:52 -0800 (PST)
Received: from localhost ([122.171.124.15])
        by smtp.gmail.com with ESMTPSA id p184sm14818427pgp.13.2021.03.09.21.23.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Mar 2021 21:23:52 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-pm@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 4/4] cpufreq: CPPC: Add support for frequency invariance
Date:   Wed, 10 Mar 2021 10:53:26 +0530
Message-Id: <19fbb10acaaceaa25671c973b9eb6f170015de00.1615351622.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1615351622.git.viresh.kumar@linaro.org>
References: <cover.1615351622.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Frequency Invariance Engine (FIE) is providing a frequency scaling
correction factor that helps achieve more accurate load-tracking.

Normally, this scaling factor can be obtained directly with the help of
the cpufreq drivers as they know the exact frequency the hardware is
running at. But that isn't the case for CPPC cpufreq driver.

Another way of obtaining that is using the arch specific counter
support, which is already present in kernel, but that hardware is
optional for platforms.

This patch updates the CPPC driver to register itself with the topology
core to provide its own implementation (cppc_scale_freq_tick()) of
topology_scale_freq_tick() which gets called by the scheduler on every
tick. Note that the arch specific counters have higher priority than
CPPC counters, if available, though the CPPC driver doesn't need to have
any special handling for that.

On an invocation of cppc_scale_freq_tick(), we schedule an irq work
(since we reach here from hard-irq context), which then schedules a
normal work item and cppc_scale_freq_workfn() updates the per_cpu
arch_freq_scale variable based on the counter updates since the last
tick.

To allow platforms to disable this CPPC counter-based frequency
invariance support, this is all done under CONFIG_ACPI_CPPC_CPUFREQ_FIE,
which is enabled by default.

This also exports sched_setattr_nocheck() as the CPPC driver can be
built as a module.

Cc: linux-acpi@vger.kernel.org
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |  10 ++
 drivers/cpufreq/cppc_cpufreq.c | 245 +++++++++++++++++++++++++++++++--
 include/linux/arch_topology.h  |   1 +
 kernel/sched/core.c            |   1 +
 4 files changed, 245 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e65e0a43be64..a5c5f70acfc9 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -19,6 +19,16 @@ config ACPI_CPPC_CPUFREQ
 
 	  If in doubt, say N.
 
+config ACPI_CPPC_CPUFREQ_FIE
+	bool "Frequency Invariance support for CPPC cpufreq driver"
+	depends on ACPI_CPPC_CPUFREQ && GENERIC_ARCH_TOPOLOGY
+	default y
+	help
+	  This extends frequency invariance support in the CPPC cpufreq driver,
+	  by using CPPC delivered and reference performance counters.
+
+	  If in doubt, say N.
+
 config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
 	depends on ARCH_SUNXI
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8a482c434ea6..b8e1b8ea628c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -10,14 +10,18 @@
 
 #define pr_fmt(fmt)	"CPPC Cpufreq:"	fmt
 
+#include <linux/arch_topology.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/dmi.h>
+#include <linux/irq_work.h>
+#include <linux/kthread.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
+#include <uapi/linux/sched/types.h>
 
 #include <asm/unaligned.h>
 
@@ -57,6 +61,204 @@ static struct cppc_workaround_oem_info wa_info[] = {
 	}
 };
 
+#ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
+
+/* Frequency invariance support */
+struct cppc_freq_invariance {
+	int cpu;
+	struct irq_work irq_work;
+	struct kthread_work work;
+	struct cppc_perf_fb_ctrs prev_perf_fb_ctrs;
+	struct cppc_cpudata *cpu_data;
+};
+
+static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
+static struct kthread_worker *kworker_fie;
+static bool fie_disabled;
+
+static struct cpufreq_driver cppc_cpufreq_driver;
+static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t1);
+
+/**
+ * cppc_scale_freq_workfn - CPPC arch_freq_scale updater for frequency invariance
+ * @work: The work item.
+ *
+ * The CPPC driver register itself with the topology core to provide its own
+ * implementation (cppc_scale_freq_tick()) of topology_scale_freq_tick() which
+ * gets called by the scheduler on every tick.
+ *
+ * Note that the arch specific counters have higher priority than CPPC counters,
+ * if available, though the CPPC driver doesn't need to have any special
+ * handling for that.
+ *
+ * On an invocation of cppc_scale_freq_tick(), we schedule an irq work (since we
+ * reach here from hard-irq context), which then schedules a normal work item
+ * and cppc_scale_freq_workfn() updates the per_cpu arch_freq_scale variable
+ * based on the counter updates since the last tick.
+ */
+static void cppc_scale_freq_workfn(struct kthread_work *work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	struct cppc_cpudata *cpu_data;
+	unsigned long local_freq_scale;
+	u64 perf;
+
+	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
+	cpu_data = cppc_fi->cpu_data;
+
+	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
+		pr_warn("%s: failed to read perf counters\n", __func__);
+		return;
+	}
+
+	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+	perf = cppc_perf_from_fbctrs(cpu_data, cppc_fi->prev_perf_fb_ctrs,
+				     fb_ctrs);
+
+	perf <<= SCHED_CAPACITY_SHIFT;
+	local_freq_scale = div64_u64(perf, cpu_data->perf_caps.highest_perf);
+	if (WARN_ON(local_freq_scale > 1024))
+		local_freq_scale = 1024;
+
+	per_cpu(arch_freq_scale, cppc_fi->cpu) = local_freq_scale;
+}
+
+static void cppc_irq_work(struct irq_work *irq_work)
+{
+	struct cppc_freq_invariance *cppc_fi;
+
+	cppc_fi = container_of(irq_work, struct cppc_freq_invariance, irq_work);
+	kthread_queue_work(kworker_fie, &cppc_fi->work);
+}
+
+static void cppc_scale_freq_tick(void)
+{
+	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, smp_processor_id());
+
+	/*
+	 * cppc_get_perf_ctrs() can potentially sleep, call that from the right
+	 * context.
+	 */
+	irq_work_queue(&cppc_fi->irq_work);
+}
+
+static struct scale_freq_data cppc_sftd = {
+	.source = SCALE_FREQ_SOURCE_CPPC,
+	.set_freq_scale = cppc_scale_freq_tick,
+};
+
+static void cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
+					     struct cppc_cpudata *cpu_data)
+{
+	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	struct cppc_freq_invariance *cppc_fi;
+	int i, ret;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	if (fie_disabled)
+		return;
+
+	for_each_cpu(i, policy->cpus) {
+		cppc_fi = &per_cpu(cppc_freq_inv, i);
+		cppc_fi->cpu = i;
+		cppc_fi->cpu_data = cpu_data;
+		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+
+		ret = cppc_get_perf_ctrs(i, &fb_ctrs);
+		if (ret) {
+			pr_warn("%s: failed to read perf counters: %d\n",
+				__func__, ret);
+			fie_disabled = true;
+		} else {
+			cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+		}
+	}
+}
+
+static void __init cppc_freq_invariance_init(void)
+{
+	struct sched_attr attr = {
+		.size		= sizeof(struct sched_attr),
+		.sched_policy	= SCHED_DEADLINE,
+		.sched_nice	= 0,
+		.sched_priority	= 0,
+		/*
+		 * Fake (unused) bandwidth; workaround to "fix"
+		 * priority inheritance.
+		 */
+		.sched_runtime	= 1000000,
+		.sched_deadline = 10000000,
+		.sched_period	= 10000000,
+	};
+	int ret;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	if (fie_disabled)
+		return;
+
+	kworker_fie = kthread_create_worker(0, "cppc_fie");
+	if (IS_ERR(kworker_fie))
+		return;
+
+	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
+	if (ret) {
+		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
+			ret);
+		kthread_destroy_worker(kworker_fie);
+		return;
+	}
+
+	/* Register for freq-invariance */
+	topology_set_scale_freq_source(&cppc_sftd, cpu_present_mask);
+}
+
+static void cppc_freq_invariance_exit(void)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int i;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	if (fie_disabled)
+		return;
+
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpu_present_mask);
+
+	for_each_possible_cpu(i) {
+		cppc_fi = &per_cpu(cppc_freq_inv, i);
+		irq_work_sync(&cppc_fi->irq_work);
+	}
+
+	kthread_destroy_worker(kworker_fie);
+	kworker_fie = NULL;
+}
+
+#else
+static inline void
+cppc_freq_invariance_policy_init(struct cpufreq_policy *policy,
+				 struct cppc_cpudata *cpu_data)
+{
+}
+
+static inline void cppc_freq_invariance_init(void)
+{
+}
+
+static inline void cppc_freq_invariance_exit(void)
+{
+}
+#endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
+
 /* Callback function used to retrieve the max frequency from DMI */
 static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 {
@@ -355,9 +557,12 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
+	if (ret) {
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->highest_perf, cpu, ret);
+	} else {
+		cppc_freq_invariance_policy_init(policy, cpu_data);
+	}
 
 	return ret;
 }
@@ -370,12 +575,12 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf, delivered_perf;
+	u64 reference_perf;
 
 	reference_perf = fb_ctrs_t0.reference_perf;
 
@@ -384,12 +589,21 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
 	delta_delivered = get_delta(fb_ctrs_t1.delivered,
 				    fb_ctrs_t0.delivered);
 
-	/* Check to avoid divide-by zero */
-	if (delta_reference || delta_delivered)
-		delivered_perf = (reference_perf * delta_delivered) /
-					delta_reference;
-	else
-		delivered_perf = cpu_data->perf_ctrls.desired_perf;
+	/* Check to avoid divide-by zero and invalid delivered_perf */
+	if (!delta_reference || !delta_delivered)
+		return cpu_data->perf_ctrls.desired_perf;
+
+	return (reference_perf * delta_delivered) / delta_reference;
+}
+
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{
+	u64 delivered_perf;
+
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
+					       fb_ctrs_t1);
 
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
@@ -514,6 +728,8 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
+	int ret;
+
 	if ((acpi_disabled) || !acpi_cpc_valid())
 		return -ENODEV;
 
@@ -521,7 +737,11 @@ static int __init cppc_cpufreq_init(void)
 
 	cppc_check_hisi_workaround();
 
-	return cpufreq_register_driver(&cppc_cpufreq_driver);
+	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
+	if (!ret)
+		cppc_freq_invariance_init();
+
+	return ret;
 }
 
 static inline void free_cpu_data(void)
@@ -538,6 +758,7 @@ static inline void free_cpu_data(void)
 
 static void __exit cppc_cpufreq_exit(void)
 {
+	cppc_freq_invariance_exit();
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
 	free_cpu_data();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 11e555cfaecb..f180240dc95f 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -37,6 +37,7 @@ bool topology_scale_freq_invariant(void);
 enum scale_freq_source {
 	SCALE_FREQ_SOURCE_CPUFREQ = 0,
 	SCALE_FREQ_SOURCE_ARCH,
+	SCALE_FREQ_SOURCE_CPPC,
 };
 
 struct scale_freq_data {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca2bb629595f..3adedc7b1725 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6386,6 +6386,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, false, true);
 }
+EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
-- 
2.25.0.rc1.19.g042ed3e048af

