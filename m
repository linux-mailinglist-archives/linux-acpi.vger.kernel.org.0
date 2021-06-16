Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728483A930A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 08:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhFPGud (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 02:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhFPGua (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 02:50:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D1C061768
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 23:48:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e20so1218757pgg.0
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 23:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHWamenmOHlNmoXLuZe9DO++QMOAk9UZVcjrT6HRY+4=;
        b=EdvUml/9a05FhcQpLX9ydI3EUXlz01ykjhPBZ2zCA+1baNB1swTocErpbKAZJe7MjR
         Y5LRLcoCWr7tOyZh8mgiFJlTlW1ymyZm2DVNqLTHOIgOIcmlxvjV3up2w4sHzowOaChJ
         65TUeeaXW6QyKvM/Xmeq9hzgyW638pAmKf1JKZ32hY7XTT7yWel65Vww6oq6rIYFVr/r
         GXWKooueFwYupxYgkkzvFuJ01oYzlo/ctnXVckbnfSc7zD47amf9tp9830YJSWBuddK9
         ZCgWHf1FMZB2f2cBvqcOGmTZNcAKfpjxtHyMUgQ/wwX8YHsblUub3d0NrC7wm4XdQZOH
         FDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHWamenmOHlNmoXLuZe9DO++QMOAk9UZVcjrT6HRY+4=;
        b=Lkbuz+lMGQvmTI5/aVaoqzQdDgVVGHCRkxpF87/LOKLph/hjfECmx31uTya3uQSWAA
         ywPLBxy0RVaR49zwugwXwFS6lZv76NJ39AREEzgmJEv/rPPNGPh8aJExPGt3A5YPbK2Q
         xRJLpxzoNoYSbEp4lJI+O/ETQfMZQ75l3PNYt9O91UoyNxAi4BLYmYC1cvySCSBOoa7+
         eUjnZBRXixB+lOAiQT5LyoCO85gHVO5xd08IVYNUw9VKBt2lwjkLYOoI4lDmAgAZMUXq
         o8MbM/sKHctSa4AUnt6GDKDk6/CopuoMvtxPMMaoEZ/rS70zwWAzENYnTh9RoLbxbUCM
         2x7g==
X-Gm-Message-State: AOAM531K1fzdL6LUW4MF7kmEYvEcUOP1J1AZ3tFBVrkxznj/GdKPCXhQ
        g1GeI7M0jubvEFcVPO1B+1a3GQ==
X-Google-Smtp-Source: ABdhPJxLDGSfqj9vCMeL5YWhlJPxptsn+YM5ydskdhxt3tKHMtWqat1WJRzV3wzECvggtBtizwpr7A==
X-Received: by 2002:a62:1d0e:0:b029:2d8:30a3:687f with SMTP id d14-20020a621d0e0000b02902d830a3687fmr7996691pfd.17.1623826104569;
        Tue, 15 Jun 2021 23:48:24 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id ig1sm1176056pjb.27.2021.06.15.23.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:48:24 -0700 (PDT)
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
Subject: [PATCH V2 3/3] cpufreq: CPPC: Add support for frequency invariance
Date:   Wed, 16 Jun 2021 12:18:09 +0530
Message-Id: <e7e653ede3ef54acc906d2bde47a3b9a41533404.1623825725.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623825725.git.viresh.kumar@linaro.org>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
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
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |  10 ++
 drivers/cpufreq/cppc_cpufreq.c | 232 ++++++++++++++++++++++++++++++---
 include/linux/arch_topology.h  |   1 +
 kernel/sched/core.c            |   1 +
 4 files changed, 227 insertions(+), 17 deletions(-)

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
index be4f62e2c5f1..63e4cff46f95 100644
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
 
@@ -57,6 +61,183 @@ static struct cppc_workaround_oem_info wa_info[] = {
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
+static void cppc_cpufreq_start_cpu(struct cpufreq_policy *policy,
+				   unsigned int cpu)
+{
+	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+	int ret;
+
+	cppc_fi->cpu = cpu;
+	cppc_fi->cpu_data = policy->driver_data;
+	kthread_init_work(&cppc_fi->work, cppc_scale_freq_workfn);
+	init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
+
+	ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
+	if (ret) {
+		pr_warn("%s: failed to read perf counters: %d\n", __func__,
+			ret);
+		return;
+	}
+
+	/* Register for freq-invariance */
+	topology_set_scale_freq_source(&cppc_sftd, cpumask_of(cpu));
+}
+
+static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy,
+				  unsigned int cpu)
+{
+	struct cppc_freq_invariance *cppc_fi = &per_cpu(cppc_freq_inv, cpu);
+
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC, cpumask_of(cpu));
+
+	irq_work_sync(&cppc_fi->irq_work);
+	kthread_cancel_work_sync(&cppc_fi->work);
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
+
+	cppc_cpufreq_driver.start_cpu = cppc_cpufreq_start_cpu;
+	cppc_cpufreq_driver.stop_cpu = cppc_cpufreq_stop_cpu;
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
@@ -362,26 +543,35 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
-				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf, delivered_perf;
+	u64 reference_perf;
 
-	reference_perf = fb_ctrs_t0.reference_perf;
+	reference_perf = fb_ctrs_t0->reference_perf;
 
-	delta_reference = get_delta(fb_ctrs_t1.reference,
-				    fb_ctrs_t0.reference);
-	delta_delivered = get_delta(fb_ctrs_t1.delivered,
-				    fb_ctrs_t0.delivered);
+	delta_reference = get_delta(fb_ctrs_t1->reference,
+				    fb_ctrs_t0->reference);
+	delta_delivered = get_delta(fb_ctrs_t1->delivered,
+				    fb_ctrs_t0->delivered);
 
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
+				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
+{
+	u64 delivered_perf;
+
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs_t0,
+					       fb_ctrs_t1);
 
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
@@ -405,7 +595,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	if (ret)
 		return ret;
 
-	return cppc_get_rate_from_fbctrs(cpu_data, fb_ctrs_t0, fb_ctrs_t1);
+	return cppc_get_rate_from_fbctrs(cpu_data, &fb_ctrs_t0, &fb_ctrs_t1);
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
@@ -506,14 +696,21 @@ static void cppc_check_hisi_workaround(void)
 
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
@@ -531,6 +728,7 @@ static inline void free_cpu_data(void)
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

