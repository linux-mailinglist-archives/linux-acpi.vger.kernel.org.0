Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6283AE5DC
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 11:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhFUJWp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Jun 2021 05:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhFUJWk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2021 05:22:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5DCC061787
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2021 02:20:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p13so13221604pfw.0
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2021 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v9CpQJBHn1mD56CNWpr1Tpf2MsYJr9cLOW/B9ZtLcrQ=;
        b=mylYZcsEi4JnjamhB4tmmfsBtgKYnQyvHtWiVfCfxeptprLWITq2TTxuIEIVQ+WFJU
         KLqOmEqSUbFRr+3cuDl1pHtIpZh8NUVAL/vBxpK7qLghZ5gYZit8v47wR6ZkTqfkxsV9
         JuxTTJn9jp6mh31pkrqf8CrbsOh/2cPmMWuhpCtEf+9xUNzXpVrQHhnY4zS1WnviP8HW
         QbqdWbjjv6pWKwTsXxo/Y+3bPd5l3H3Hl7S+wAtXBKWuRXI0xe3gBpBm3k8UrVyR5Fay
         D85ZByOC+nl29sKhIfhBluSPdrOEkeGG6mrPJn2dKN3GL0dC3awRYMTso2Qs617wuQvJ
         bGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v9CpQJBHn1mD56CNWpr1Tpf2MsYJr9cLOW/B9ZtLcrQ=;
        b=TbvLB5qeU4NOSWhX9EsU1HRsuMVJ94YB6PDIliZBN9At8jTAlHRGlpApN0N8iglfxH
         ZnKRhoGobapOSwckeIe/9HrL4nkgPpTQuIwwLkuST8F4Bs8K8kZGk5M/vEaUn1chY6x6
         7Lszy6GhVlCOm3OkcbCyUS8w8FAzbN5n5bJvI6sUv0+xjRRv9Oo+OyOU1KClxoDhJQKh
         uGAYk6QJJiyX4k1xdD1eXowfFp9WSmGPQ67S+xRLkrEb+gnDvpZ1HM8kMC3mJys1N9J1
         eoGZGbcSbVpZTXhnCLIN4tKaqtqUDjauWgW1vANaBJe8CE2Kz+dt0LnQ9GFBk1qzl6Pb
         OSZw==
X-Gm-Message-State: AOAM5331q4VNDUYWRTJOUhI2Ha1PPdn7vS2FYyPAEuSNn3XpwqngXGMZ
        3P/5J93ufC1UCYDuNU3B19v+QA==
X-Google-Smtp-Source: ABdhPJwjHOZa9js5f9hzPI3JImy7cY+ou9an6slm5KafdmL1ZhMZy5/jb4PbAAOduRinMlhta/eHmA==
X-Received: by 2002:a63:5d52:: with SMTP id o18mr23136666pgm.440.1624267224517;
        Mon, 21 Jun 2021 02:20:24 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id c18sm15641423pgf.66.2021.06.21.02.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 02:20:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
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
Cc:     linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/4] cpufreq: CPPC: Add support for frequency invariance
Date:   Mon, 21 Jun 2021 14:49:37 +0530
Message-Id: <f963d09e57115969dae32827ade5558b0467d3a0.1624266901.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624266901.git.viresh.kumar@linaro.org>
References: <cover.1624266901.git.viresh.kumar@linaro.org>
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
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |  10 ++
 drivers/cpufreq/cppc_cpufreq.c | 249 +++++++++++++++++++++++++++++++--
 include/linux/arch_topology.h  |   1 +
 kernel/sched/core.c            |   1 +
 4 files changed, 247 insertions(+), 14 deletions(-)

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
index 490175d65082..db550fc92931 100644
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
 
@@ -57,6 +61,210 @@ static struct cppc_workaround_oem_info wa_info[] = {
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
+
+static struct cpufreq_driver cppc_cpufreq_driver;
+static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
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
+	perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
+				     &fb_ctrs);
+	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
+
+	perf <<= SCHED_CAPACITY_SHIFT;
+	local_freq_scale = div64_u64(perf, cpu_data->perf_caps.highest_perf);
+
+	/* This can happen due to counter's overflow */
+	if (unlikely(local_freq_scale > 1024))
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
+static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int cpu, ret;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	for_each_cpu(cpu, policy->cpus) {
+		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+		cppc_fi->cpu = cpu;
+		cppc_fi->cpu_data = policy->driver_data;
+		kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+
+		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
+		if (ret) {
+			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
+				__func__, cpu, ret);
+			return;
+		}
+	}
+
+	/* Register for freq-invariance */
+	topology_set_scale_freq_source(&cppc_sftd, policy->cpus);
+}
+
+/*
+ * We free all the resources on policy's removal and not on CPU removal as the
+ * irq-work are per-cpu and the hotplug core takes care of flushing the pending
+ * irq-works (hint: smpcfd_dying_cpu()) on CPU hotplug. Even if the kthread-work
+ * fires on another CPU after the concerned CPU is removed, it won't harm.
+ *
+ * We just need to make sure to remove them all on policy->exit().
+ */
+static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
+{
+	struct cppc_freq_invariance *cppc_fi;
+	int cpu;
+
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	/* policy->cpus will be empty here, use related_cpus instead */
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, policy->related_cpus);
+
+	for_each_cpu(cpu, policy->related_cpus) {
+		cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+		irq_work_sync(&cppc_fi->irq_work);
+		kthread_cancel_work_sync(&cppc_fi->work);
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
+}
+
+static void cppc_freq_invariance_exit(void)
+{
+	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
+		return;
+
+	kthread_destroy_worker(kworker_fie);
+	kworker_fie = NULL;
+}
+
+#else
+static inline void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
+{
+}
+
+static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
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
@@ -335,8 +543,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (!ret)
+	if (!ret) {
+		cppc_cpufreq_cpu_fie_init(policy);
 		return 0;
+	}
 
 	pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 		 caps->highest_perf, cpu, ret);
@@ -353,6 +563,8 @@ static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_cpufreq_cpu_fie_exit(policy);
+
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
 
 	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
@@ -372,12 +584,12 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf, delivered_perf;
+	u64 reference_perf;
 
 	reference_perf = fb_ctrs_t0->reference_perf;
 
@@ -386,14 +598,11 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
 	delta_delivered = get_delta(fb_ctrs_t1->delivered,
 				    fb_ctrs_t0->delivered);
 
-	/* Check to avoid divide-by zero */
-	if (delta_reference || delta_delivered)
-		delivered_perf = (reference_perf * delta_delivered) /
-					delta_reference;
-	else
-		delivered_perf = cpu_data->perf_ctrls.desired_perf;
+	/* Check to avoid divide-by zero and invalid delivered_perf */
+	if (!delta_reference || !delta_delivered)
+		return cpu_data->perf_ctrls.desired_perf;
 
-	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
+	return (reference_perf * delta_delivered) / delta_reference;
 }
 
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
@@ -401,6 +610,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct cppc_cpudata *cpu_data = policy->driver_data;
+	u64 delivered_perf;
 	int ret;
 
 	cpufreq_cpu_put(policy);
@@ -415,7 +625,10 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret)
 		return ret;
 
-	return cppc_get_rate_from_fbctrs(cpu_data, &fb_ctrs_t0, &fb_ctrs_t1);
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
+					       &fb_ctrs_t1);
+
+	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
@@ -516,14 +729,21 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
+	int ret;
+
 	if ((acpi_disabled) || !acpi_cpc_valid())
 		return -ENODEV;
 
 	INIT_LIST_HEAD(&cpu_data_list);
 
 	cppc_check_hisi_workaround();
+	cppc_freq_invariance_init();
 
-	return cpufreq_register_driver(&cppc_cpufreq_driver);
+	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
+	if (ret)
+		cppc_freq_invariance_exit();
+
+	return ret;
 }
 
 static inline void free_cpu_data(void)
@@ -541,6 +761,7 @@ static inline void free_cpu_data(void)
 static void __exit cppc_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
+	cppc_freq_invariance_exit();
 
 	free_cpu_data();
 }
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
index 4ca80df205ce..5226cc26a095 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6389,6 +6389,7 @@ int sched_setattr_nocheck(struct task_struct *p, const struct sched_attr *attr)
 {
 	return __sched_setscheduler(p, attr, false, true);
 }
+EXPORT_SYMBOL_GPL(sched_setattr_nocheck);
 
 /**
  * sched_setscheduler_nocheck - change the scheduling policy and/or RT priority of a thread from kernelspace.
-- 
2.31.1.272.g89b43f80a514

