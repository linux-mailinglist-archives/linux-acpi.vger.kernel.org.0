Return-Path: <linux-acpi+bounces-2264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D33680C71A
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 11:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC4C1C20F6B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 10:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584902CCB8;
	Mon, 11 Dec 2023 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e9Z6VU0H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B17D5
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:03 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bee606265so4414619e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291742; x=1702896542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZHd4Q0/7Gj/HYpU63Kx8UoTWa/0lydYthjIniNUNCQ=;
        b=e9Z6VU0HMRxTHvyuiH/ltUBQKXpFUzCHS/NQFabUpxhP0Wmox1yhQ1mgO2Xxl8exVJ
         QEyzcN9sgW7KhRNKCF5nhTv6Cev1nuale7DuSO3hkB+WPKUwzhJ6D2CCPdqOq0yB7ccp
         btA7xXsVEHtlniYXZyaN/s+8Iinl0xARHZZBEZh6PY+hEU21XAQor/FCih3LdUgU3on/
         EJU+uDVbRStHJE37Fh830EY15DOvSyAP7fRYLQ4fUzG1t+jUdZpTHvH9XE1HASSJsgTo
         7P+qRAKP/vlzqfKvJhDJ1immivUd0Li1+cmxwSyL0xbSxS0vd6V4Cbu0Vy1XMAPMzD8L
         4Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291742; x=1702896542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZHd4Q0/7Gj/HYpU63Kx8UoTWa/0lydYthjIniNUNCQ=;
        b=qKBOLg19et7EqA0l+GgNBJtT8qiEVwtbl+xPiqTnrR6vG5vXHa9aZKHKJN86SlrtZJ
         zZO0bB935FqcHJUYNwn5f3P/eWAVA9HnX5eIRnd6HtgCIncmrtJWOKF/aIm/kIpCtCOC
         SNah0Ul3yRL/75kwcdZm5A0aGoIRRLhcFhJKKnXbPrF0YpA8dVA5LRUwT3LhRUzzxUn6
         9dL6TEOtZisWZ0Pg9ERR8l4zfqlZIYUQJNEtQdAWRvedmup38Aw2oEqOrnfM6M77FWSu
         JmYBWp2LcFmeq1ddOEjwLwgO6X//Kq85rw13febAzbbtuNAV5mzrbedaokRf4Ptel0r+
         /Tgw==
X-Gm-Message-State: AOJu0YxgFUjv0yfvLJ+HV8014merU6WcKTswhRA5SPsCH6g4oZPRy5pD
	UdMHK8Sl9sulYOVBF8KCQB7/TA==
X-Google-Smtp-Source: AGHT+IFrfQrPlXixL8v4uqLyOnAzTuVXpzYBMhE3tSsgQhM1DbAB6tCJtvxSEjNEU0w7gT29gOQXMg==
X-Received: by 2002:a05:6512:220d:b0:50a:a327:a463 with SMTP id h13-20020a056512220d00b0050aa327a463mr2086963lfu.13.1702291741735;
        Mon, 11 Dec 2023 02:49:01 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:49:01 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	viresh.kumar@linaro.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	lukasz.luba@arm.com,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: conor.dooley@microchip.com,
	suagrfillet@gmail.com,
	ajones@ventanamicro.com,
	lftan@kernel.org,
	beata.michalska@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 1/7] topology: Add a new arch_scale_freq_reference
Date: Mon, 11 Dec 2023 11:48:49 +0100
Message-Id: <20231211104855.558096-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211104855.558096-1-vincent.guittot@linaro.org>
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a new method to get a unique and fixed max frequency. Currently
cpuinfo.max_freq or the highest (or last) state of performance domain are
used as the max frequency when computing the frequency for a level of
utilization but:
- cpuinfo_max_freq can change at runtime. boost is one example of
  such change.
- cpuinfo.max_freq and last item of the PD can be different leading to
  different results between cpufreq and energy model.

We need to save the reference frequency that has been used when computing
the CPUs capacity and use this fixed and coherent value to convert between
frequency and CPU's capacity.

In fact, we already save the frequency that has been used when computing
the capacity of each CPU. We extend the precision to save kHz instead of
MHz currently and we modify the type to be aligned with other variables
used when converting frequency to capacity and the other way.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/include/asm/topology.h   |  1 +
 arch/arm64/include/asm/topology.h |  1 +
 arch/riscv/include/asm/topology.h |  1 +
 drivers/base/arch_topology.c      | 29 ++++++++++++++---------------
 include/linux/arch_topology.h     |  7 +++++++
 include/linux/sched/topology.h    |  8 ++++++++
 6 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index c7d2510e5a78..853c4f81ba4a 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -13,6 +13,7 @@
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
+#define arch_scale_freq_ref topology_get_freq_ref
 #endif
 
 /* Replace task scheduler's default cpu-invariant accounting */
diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index 9fab663dd2de..a323b109b9c4 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -23,6 +23,7 @@ void update_freq_counters_refs(void);
 #define arch_set_freq_scale topology_set_freq_scale
 #define arch_scale_freq_capacity topology_get_freq_scale
 #define arch_scale_freq_invariant topology_scale_freq_invariant
+#define arch_scale_freq_ref topology_get_freq_ref
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 #define arch_init_invariance_cppc topology_init_cpu_capacity_cppc
diff --git a/arch/riscv/include/asm/topology.h b/arch/riscv/include/asm/topology.h
index e316ab3b77f3..61183688bdd5 100644
--- a/arch/riscv/include/asm/topology.h
+++ b/arch/riscv/include/asm/topology.h
@@ -9,6 +9,7 @@
 #define arch_set_freq_scale		topology_set_freq_scale
 #define arch_scale_freq_capacity	topology_get_freq_scale
 #define arch_scale_freq_invariant	topology_scale_freq_invariant
+#define arch_scale_freq_ref		topology_get_freq_ref
 
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity	topology_get_cpu_scale
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b741b5ba82bd..e8d1cdf1f761 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
+#include <linux/units.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/thermal_pressure.h>
@@ -26,7 +27,8 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
-static DEFINE_PER_CPU(u32, freq_factor) = 1;
+DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
+EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
 {
@@ -170,9 +172,9 @@ DEFINE_PER_CPU(unsigned long, thermal_pressure);
  * operating on stale data when hot-plug is used for some CPUs. The
  * @capped_freq reflects the currently allowed max CPUs frequency due to
  * thermal capping. It might be also a boost frequency value, which is bigger
- * than the internal 'freq_factor' max frequency. In such case the pressure
- * value should simply be removed, since this is an indication that there is
- * no thermal throttling. The @capped_freq must be provided in kHz.
+ * than the internal 'capacity_freq_ref' max frequency. In such case the
+ * pressure value should simply be removed, since this is an indication that
+ * there is no thermal throttling. The @capped_freq must be provided in kHz.
  */
 void topology_update_thermal_pressure(const struct cpumask *cpus,
 				      unsigned long capped_freq)
@@ -183,10 +185,7 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	cpu = cpumask_first(cpus);
 	max_capacity = arch_scale_cpu_capacity(cpu);
-	max_freq = per_cpu(freq_factor, cpu);
-
-	/* Convert to MHz scale which is used in 'freq_factor' */
-	capped_freq /= 1000;
+	max_freq = arch_scale_freq_ref(cpu);
 
 	/*
 	 * Handle properly the boost frequencies, which should simply clean
@@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
 
 	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
 		capacity_scale = max(capacity, capacity_scale);
 	}
 
 	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
+		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 			capacity_scale);
 		topology_set_cpu_scale(cpu, capacity);
@@ -321,15 +320,15 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			cpu_node, raw_capacity[cpu]);
 
 		/*
-		 * Update freq_factor for calculating early boot cpu capacities.
+		 * Update capacity_freq_ref for calculating early boot cpu capacities.
 		 * For non-clk CPU DVFS mechanism, there's no way to get the
 		 * frequency value now, assuming they are running at the same
-		 * frequency (by keeping the initial freq_factor value).
+		 * frequency (by keeping the initial capacity_freq_ref value).
 		 */
 		cpu_clk = of_clk_get(cpu_node, 0);
 		if (!PTR_ERR_OR_ZERO(cpu_clk)) {
-			per_cpu(freq_factor, cpu) =
-				clk_get_rate(cpu_clk) / 1000;
+			per_cpu(capacity_freq_ref, cpu) =
+				clk_get_rate(cpu_clk) / HZ_PER_KHZ;
 			clk_put(cpu_clk);
 		}
 	} else {
@@ -411,7 +410,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus)
-		per_cpu(freq_factor, cpu) = policy->cpuinfo.max_freq / 1000;
+		per_cpu(capacity_freq_ref, cpu) = policy->cpuinfo.max_freq;
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index a07b510e7dc5..32c24ff4f2a8 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -27,6 +27,13 @@ static inline unsigned long topology_get_cpu_scale(int cpu)
 
 void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
 
+DECLARE_PER_CPU(unsigned long, capacity_freq_ref);
+
+static inline unsigned long topology_get_freq_ref(int cpu)
+{
+	return per_cpu(capacity_freq_ref, cpu);
+}
+
 DECLARE_PER_CPU(unsigned long, arch_freq_scale);
 
 static inline unsigned long topology_get_freq_scale(int cpu)
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index de545ba85218..a6e04b4a21d7 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -279,6 +279,14 @@ void arch_update_thermal_pressure(const struct cpumask *cpus,
 { }
 #endif
 
+#ifndef arch_scale_freq_ref
+static __always_inline
+unsigned int arch_scale_freq_ref(int cpu)
+{
+	return 0;
+}
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
-- 
2.34.1


