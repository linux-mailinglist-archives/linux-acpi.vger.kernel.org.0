Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA0030D228
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 04:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhBCDXk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 22:23:40 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:31814 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232972AbhBCDXc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Feb 2021 22:23:32 -0500
Received: from bender.morinfr.org (unknown [82.64.86.27])
        by smtp4-g21.free.fr (Postfix) with ESMTPS id 3141F19F4EA;
        Wed,  3 Feb 2021 04:23:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
        ; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2RJrKuFt+xN8yGchCewWWtCd0+Rd/S2xZWRitUpt08k=; b=ZNnhp1g/XccGeHpt50D0Ysqh6a
        9D7xXQLaqfMigsMEIF14kFMMAn3aR/fejckj6+M4m68+xKrRrJd3BS0tKRvtKAGQ8D2pplHn+6Rjb
        GA1mSd9lX+kuFpRbXrQpEYn8NQ/DDpgkgP1N7xuAa8fLy/vNt88rixp3rQhjXqheaw58=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.92)
        (envelope-from <guillaume@morinfr.org>)
        id 1l78lO-0003yx-Sk; Wed, 03 Feb 2021 04:23:30 +0100
Date:   Wed, 3 Feb 2021 04:23:30 +0100
From:   Guillaume Morin <guillaume@morinfr.org>
To:     viresh.kumar@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc:     guillaume@morinfr.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [BUG] incorrect scaling_max_freq with intel_pstate after
 offline/online]
Message-ID: <20210203032330.GA15282@bender.morinfr.org>
Mail-Followup-To: viresh.kumar@linaro.org, rjw@rjwysocki.net,
        lenb@kernel.org, guillaume@morinfr.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a resend. I was initially stingy on the To and Cc. I hope this
is too many.

I am chasing an issue on 5.4.x+ where scaling_max_freq is decreased to
the first entry in the _PSS table after doing an offline/online of the
cpu (to be 100% clear: scaling_max_freq is fine right after booting).

During intel_pstate_cpu_init(), acpi_processor_get_platform_limit() is
called. That updates FREQ_QOS_MAX constraint *if* perflib_req is not
NULL.  At that point though, the states[0].core_frequency in that table
is "incorrect" because it does not contain the turbo freq range.
states[0].core_frequency is later fixed up by
intel_pstate_init_acpi_perf_limits() after returning from
acpi_processor_get_platform_limit().

During boot, the first call to acpi_processor_get_platform_limit()
happens in the intel_pstate_cpu_init() *before* perflib_req is
initialized. That happens later down cpufreq_online():
acpi_processor_notifier() is called from
blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
CPUFREQ_CREATE_POLICY, policy).

So at that point acpi_processor_get_platform_limit() is not
adding/updating the FREQ_QOS_MAX constraint.  When cpufreq_set_policy()
is called, freq_qos_read_value() for FREQ_QOS_MAX returns the proper
frequency.

However, after an offline/online, the policy is not recreated.
Therefore, perflib_req is != NULL in
acpi_processor_get_platform_limit(), the FREQ_QOS_MAX constraint is then
updated with the "incorrect" states[0].core_frequency. cpufreq_set_policy()
is then called and policy->max is set to that value.

I have not tried to run the current master but my reading of Linus' tree
is that the problem is still present in current kernels. Please let me
know if I am wrong.

ignore_ppc=1 would workaround the issue but that does not seem it was
intended for that purpose since all users of intel_pstate would have to
set it...

I made a simple test patch on top of the 5.4 branch to verify my theory
and it does fix the issue. I am not familiar with this code and
ACPI at all so it might not be the right approach but I am including it
in case it helps:

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 5909e8fa4013..aaef29bc3952 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -393,7 +393,10 @@ static int acpi_processor_get_performance_states(struct acpi_processor *pr)
 	return result;
 }
 
-int acpi_processor_get_performance_info(struct acpi_processor *pr)
+
+
+static int __acpi_processor_get_performance_info(struct acpi_processor *pr,
+					         u64 override_pss0_freq)
 {
 	int result = 0;
 
@@ -414,6 +417,9 @@ int acpi_processor_get_performance_info(struct acpi_processor *pr)
 	if (result)
 		goto update_bios;
 
+	if (override_pss0_freq)
+		pr->performance->states[0].core_frequency = override_pss0_freq;
+
 	/* We need to call _PPC once when cpufreq starts */
 	if (ignore_ppc != 1)
 		result = acpi_processor_get_platform_limit(pr);
@@ -434,6 +440,11 @@ int acpi_processor_get_performance_info(struct acpi_processor *pr)
 #endif
 	return result;
 }
+
+int acpi_processor_get_performance_info(struct acpi_processor *pr)
+{
+	return __acpi_processor_get_performance_info(pr, 0);
+}
 EXPORT_SYMBOL_GPL(acpi_processor_get_performance_info);
 
 int acpi_processor_pstate_control(void)
@@ -723,8 +734,9 @@ int acpi_processor_preregister_performance(
 EXPORT_SYMBOL(acpi_processor_preregister_performance);
 
 int
-acpi_processor_register_performance(struct acpi_processor_performance
-				    *performance, unsigned int cpu)
+__acpi_processor_register_performance(struct acpi_processor_performance
+					*performance, unsigned int cpu,
+					u64 override_pss0_freq)
 {
 	struct acpi_processor *pr;
 
@@ -748,7 +760,7 @@ acpi_processor_register_performance(struct acpi_processor_performance
 
 	pr->performance = performance;
 
-	if (acpi_processor_get_performance_info(pr)) {
+	if (__acpi_processor_get_performance_info(pr, override_pss0_freq)) {
 		pr->performance = NULL;
 		mutex_unlock(&performance_mutex);
 		return -EIO;
@@ -758,7 +770,7 @@ acpi_processor_register_performance(struct acpi_processor_performance
 	return 0;
 }
 
-EXPORT_SYMBOL(acpi_processor_register_performance);
+EXPORT_SYMBOL(__acpi_processor_register_performance);
 
 void acpi_processor_unregister_performance(unsigned int cpu)
 {
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 8280fb38cd53..fdf3e90e5f42 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -401,6 +401,7 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 	struct cpudata *cpu;
 	int ret;
 	int i;
+	u64 override_max_freq = 0;
 
 	if (hwp_active) {
 		intel_pstate_set_itmt_prio(policy->cpu);
@@ -412,8 +413,23 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 
 	cpu = all_cpu_data[policy->cpu];
 
-	ret = acpi_processor_register_performance(&cpu->acpi_perf_data,
-						  policy->cpu);
+	/*
+	 * The _PSS table doesn't contain whole turbo frequency range.
+	 * This just contains +1 MHZ above the max non turbo frequency,
+	 * with control value corresponding to max turbo ratio. But
+	 * when cpufreq set policy is called, it will call with this
+	 * max frequency, which will cause a reduced performance as
+	 * this driver uses real max turbo frequency as the max
+	 * frequency. So correct this frequency in _PSS table to
+	 * correct max turbo frequency based on the turbo state.
+	 * Also need to convert to MHz as _PSS freq is in MHz.
+	 */
+	if (!global.turbo_disabled)
+		override_max_freq = policy->cpuinfo.max_freq / 1000;
+
+	ret = __acpi_processor_register_performance(&cpu->acpi_perf_data,
+						  policy->cpu,
+						  override_max_freq);
 	if (ret)
 		return;
 
@@ -442,20 +458,6 @@ static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 			 (u32) cpu->acpi_perf_data.states[i].control);
 	}
 
-	/*
-	 * The _PSS table doesn't contain whole turbo frequency range.
-	 * This just contains +1 MHZ above the max non turbo frequency,
-	 * with control value corresponding to max turbo ratio. But
-	 * when cpufreq set policy is called, it will call with this
-	 * max frequency, which will cause a reduced performance as
-	 * this driver uses real max turbo frequency as the max
-	 * frequency. So correct this frequency in _PSS table to
-	 * correct max turbo frequency based on the turbo state.
-	 * Also need to convert to MHz as _PSS freq is in MHz.
-	 */
-	if (!global.turbo_disabled)
-		cpu->acpi_perf_data.states[0].core_frequency =
-					policy->cpuinfo.max_freq / 1000;
 	cpu->valid_pss_table = true;
 	pr_debug("_PPC limits will be enforced\n");
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 683e124ad517..4b2ce80ffbec 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -250,8 +250,15 @@ extern int acpi_processor_preregister_performance(struct
 						  acpi_processor_performance
 						  __percpu *performance);
 
-extern int acpi_processor_register_performance(struct acpi_processor_performance
-					       *performance, unsigned int cpu);
+extern int __acpi_processor_register_performance(
+					struct acpi_processor_performance
+				        *performance, unsigned int cpu,
+				        u64 override_pss0_freq);
+static inline int acpi_processor_register_performance(
+					struct acpi_processor_performance
+				       *performance, unsigned int cpu) {
+	return __acpi_processor_register_performance(performance, cpu, 0);
+}
 extern void acpi_processor_unregister_performance(unsigned int cpu);
 
 int acpi_processor_pstate_control(void);


-- 
Guillaume Morin <guillaume@morinfr.org>
