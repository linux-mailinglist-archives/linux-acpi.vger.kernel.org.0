Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FB9D8E76
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 12:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbfJPKsG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 06:48:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55438 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390338AbfJPKsG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2019 06:48:06 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0d0a533394da4905; Wed, 16 Oct 2019 12:48:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [RFT][PATCH 2/3] cpufreq: Use per-policy frequency QoS
Date:   Wed, 16 Oct 2019 12:47:06 +0200
Message-ID: <20154332.AJkCBzCetj@kreacher>
In-Reply-To: <2811202.iOFZ6YHztY@kreacher>
References: <2811202.iOFZ6YHztY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the CPU device PM QoS used for the management of min and max
frequency constraints in cpufreq (and its users) with per-policy
frequency QoS to avoid problems with cpufreq policies covering
more then one CPU.

Namely, a cpufreq driver is registered with the subsys interface
which calls cpufreq_add_dev() for each CPU, starting from CPU0, so
currently the PM QoS notifiers are added to the first CPU in the
policy (i.e. CPU0 in the majority of cases).

In turn, when the cpufreq driver is unregistered, the subsys interface
doing that calls cpufreq_remove_dev() for each CPU, starting from CPU0,
and the PM QoS notifiers are only removed when cpufreq_remove_dev() is
called for the last CPU in the policy, say CPUx, which as a rule is
not CPU0 if the policy covers more than one CPU.  Then, the PM QoS
notifiers cannot be removed, because CPUx does not have them, and
they are still there in the device PM QoS notifiers list of CPU0,
which prevents new PM QoS notifiers from being registered for CPU0
on the next attempt to register the cpufreq driver.

The same issue occurs when the first CPU in the policy goes offline
before unregistering the driver.

After this change it does not matter which CPU is the policy CPU at
the driver registration time and whether or not it is online all the
time, because the frequency QoS is per policy and not per CPU.

Fixes: 18c49926c4bf ("cpufreq: Add QoS requests for userspace constraints")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Diagnosed-by: Viresh Kumar <viresh.kumar@linaro.org> 
Link: https://lore.kernel.org/linux-pm/5ad2624194baa2f53acc1f1e627eb7684c577a19.1562210705.git.viresh.kumar@linaro.org/T/#md2d89e95906b8c91c15f582146173dce2e86e99f
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of https://patchwork.kernel.org/patch/11191343/

---
 drivers/acpi/processor_driver.c            |    9 +---
 drivers/acpi/processor_perflib.c           |   18 ++++----
 drivers/acpi/processor_thermal.c           |   18 ++++----
 drivers/cpufreq/cpufreq.c                  |   59 ++++++++++++-----------------
 drivers/cpufreq/intel_pstate.c             |   30 +++++++-------
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c      |   15 +++----
 drivers/macintosh/windfarm_cpufreq_clamp.c |   38 ++++++++++--------
 drivers/thermal/cpu_cooling.c              |   14 +++---
 include/acpi/processor.h                   |   20 ++++-----
 include/linux/cpufreq.h                    |    7 ++-
 10 files changed, 114 insertions(+), 114 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -13,6 +13,7 @@
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
+#include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
 
@@ -76,8 +77,10 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct dev_pm_qos_request *min_freq_req;
-	struct dev_pm_qos_request *max_freq_req;
+	struct freq_constraints	constraints;
+	struct freq_qos_request	*min_freq_req;
+	struct freq_qos_request	*max_freq_req;
+
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -720,7 +720,7 @@ static ssize_t store_##file_name					\
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	ret = dev_pm_qos_update_request(policy->object##_freq_req, val);\
+	ret = freq_qos_update_request(policy->object##_freq_req, val);\
 	return ret >= 0 ? count : ret;					\
 }
 
@@ -1202,19 +1202,21 @@ static struct cpufreq_policy *cpufreq_po
 		goto err_free_real_cpus;
 	}
 
+	freq_constraints_init(&policy->constraints);
+
 	policy->nb_min.notifier_call = cpufreq_notifier_min;
 	policy->nb_max.notifier_call = cpufreq_notifier_max;
 
-	ret = dev_pm_qos_add_notifier(dev, &policy->nb_min,
-				      DEV_PM_QOS_MIN_FREQUENCY);
+	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MIN,
+				    &policy->nb_min);
 	if (ret) {
 		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
 			ret, cpumask_pr_args(policy->cpus));
 		goto err_kobj_remove;
 	}
 
-	ret = dev_pm_qos_add_notifier(dev, &policy->nb_max,
-				      DEV_PM_QOS_MAX_FREQUENCY);
+	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MIN,
+				    &policy->nb_max);
 	if (ret) {
 		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
 			ret, cpumask_pr_args(policy->cpus));
@@ -1232,8 +1234,8 @@ static struct cpufreq_policy *cpufreq_po
 	return policy;
 
 err_min_qos_notifier:
-	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
-				   DEV_PM_QOS_MIN_FREQUENCY);
+	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
+				 &policy->nb_min);
 err_kobj_remove:
 	cpufreq_policy_put_kobj(policy);
 err_free_real_cpus:
@@ -1250,7 +1252,6 @@ err_free_policy:
 
 static void cpufreq_policy_free(struct cpufreq_policy *policy)
 {
-	struct device *dev = get_cpu_device(policy->cpu);
 	unsigned long flags;
 	int cpu;
 
@@ -1262,10 +1263,10 @@ static void cpufreq_policy_free(struct c
 		per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	dev_pm_qos_remove_notifier(dev, &policy->nb_max,
-				   DEV_PM_QOS_MAX_FREQUENCY);
-	dev_pm_qos_remove_notifier(dev, &policy->nb_min,
-				   DEV_PM_QOS_MIN_FREQUENCY);
+	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MAX,
+				 &policy->nb_max);
+	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
+				 &policy->nb_min);
 
 	if (policy->max_freq_req) {
 		/*
@@ -1274,10 +1275,10 @@ static void cpufreq_policy_free(struct c
 		 */
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 					     CPUFREQ_REMOVE_POLICY, policy);
-		dev_pm_qos_remove_request(policy->max_freq_req);
+		freq_qos_remove_request(policy->max_freq_req);
 	}
 
-	dev_pm_qos_remove_request(policy->min_freq_req);
+	freq_qos_remove_request(policy->min_freq_req);
 	kfree(policy->min_freq_req);
 
 	cpufreq_policy_put_kobj(policy);
@@ -1357,8 +1358,6 @@ static int cpufreq_online(unsigned int c
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
-		struct device *dev = get_cpu_device(cpu);
-
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j);
@@ -1369,36 +1368,31 @@ static int cpufreq_online(unsigned int c
 		if (!policy->min_freq_req)
 			goto out_destroy_policy;
 
-		ret = dev_pm_qos_add_request(dev, policy->min_freq_req,
-					     DEV_PM_QOS_MIN_FREQUENCY,
-					     policy->min);
+		ret = freq_qos_add_request(&policy->constraints,
+					   policy->min_freq_req, FREQ_QOS_MIN,
+					   policy->min);
 		if (ret < 0) {
 			/*
-			 * So we don't call dev_pm_qos_remove_request() for an
+			 * So we don't call freq_qos_remove_request() for an
 			 * uninitialized request.
 			 */
 			kfree(policy->min_freq_req);
 			policy->min_freq_req = NULL;
-
-			dev_err(dev, "Failed to add min-freq constraint (%d)\n",
-				ret);
 			goto out_destroy_policy;
 		}
 
 		/*
 		 * This must be initialized right here to avoid calling
-		 * dev_pm_qos_remove_request() on uninitialized request in case
+		 * freq_qos_remove_request() on uninitialized request in case
 		 * of errors.
 		 */
 		policy->max_freq_req = policy->min_freq_req + 1;
 
-		ret = dev_pm_qos_add_request(dev, policy->max_freq_req,
-					     DEV_PM_QOS_MAX_FREQUENCY,
-					     policy->max);
+		ret = freq_qos_add_request(&policy->constraints,
+					   policy->max_freq_req, FREQ_QOS_MAX,
+					   policy->max);
 		if (ret < 0) {
 			policy->max_freq_req = NULL;
-			dev_err(dev, "Failed to add max-freq constraint (%d)\n",
-				ret);
 			goto out_destroy_policy;
 		}
 
@@ -2374,7 +2368,6 @@ int cpufreq_set_policy(struct cpufreq_po
 		       struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
-	struct device *cpu_dev = get_cpu_device(policy->cpu);
 	int ret;
 
 	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
@@ -2386,8 +2379,8 @@ int cpufreq_set_policy(struct cpufreq_po
 	 * PM QoS framework collects all the requests from users and provide us
 	 * the final aggregated value here.
 	 */
-	new_policy->min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
-	new_policy->max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
+	new_policy->min = freq_qos_read_value(&policy->constraints, FREQ_QOS_MIN);
+	new_policy->max = freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX);
 
 	/* verify the cpu speed can be set within this limit */
 	ret = cpufreq_driver->verify(new_policy);
@@ -2518,7 +2511,7 @@ static int cpufreq_boost_set_sw(int stat
 			break;
 		}
 
-		ret = dev_pm_qos_update_request(policy->max_freq_req, policy->max);
+		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
 		if (ret < 0)
 			break;
 	}
Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1088,10 +1088,10 @@ static ssize_t store_no_turbo(struct kob
 
 static struct cpufreq_driver intel_pstate;
 
-static void update_qos_request(enum dev_pm_qos_req_type type)
+static void update_qos_request(enum freq_qos_req_type type)
 {
 	int max_state, turbo_max, freq, i, perf_pct;
-	struct dev_pm_qos_request *req;
+	struct freq_qos_request *req;
 	struct cpufreq_policy *policy;
 
 	for_each_possible_cpu(i) {
@@ -1112,7 +1112,7 @@ static void update_qos_request(enum dev_
 		else
 			turbo_max = cpu->pstate.turbo_pstate;
 
-		if (type == DEV_PM_QOS_MIN_FREQUENCY) {
+		if (type == FREQ_QOS_MIN) {
 			perf_pct = global.min_perf_pct;
 		} else {
 			req++;
@@ -1122,7 +1122,7 @@ static void update_qos_request(enum dev_
 		freq = DIV_ROUND_UP(turbo_max * perf_pct, 100);
 		freq *= cpu->pstate.scaling;
 
-		if (dev_pm_qos_update_request(req, freq) < 0)
+		if (freq_qos_update_request(req, freq) < 0)
 			pr_warn("Failed to update freq constraint: CPU%d\n", i);
 	}
 }
@@ -1153,7 +1153,7 @@ static ssize_t store_max_perf_pct(struct
 	if (intel_pstate_driver == &intel_pstate)
 		intel_pstate_update_policies();
 	else
-		update_qos_request(DEV_PM_QOS_MAX_FREQUENCY);
+		update_qos_request(FREQ_QOS_MAX);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -1187,7 +1187,7 @@ static ssize_t store_min_perf_pct(struct
 	if (intel_pstate_driver == &intel_pstate)
 		intel_pstate_update_policies();
 	else
-		update_qos_request(DEV_PM_QOS_MIN_FREQUENCY);
+		update_qos_request(FREQ_QOS_MIN);
 
 	mutex_unlock(&intel_pstate_driver_lock);
 
@@ -2381,7 +2381,7 @@ static unsigned int intel_cpufreq_fast_s
 static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	int max_state, turbo_max, min_freq, max_freq, ret;
-	struct dev_pm_qos_request *req;
+	struct freq_qos_request *req;
 	struct cpudata *cpu;
 	struct device *dev;
 
@@ -2416,15 +2416,15 @@ static int intel_cpufreq_cpu_init(struct
 	max_freq = DIV_ROUND_UP(turbo_max * global.max_perf_pct, 100);
 	max_freq *= cpu->pstate.scaling;
 
-	ret = dev_pm_qos_add_request(dev, req, DEV_PM_QOS_MIN_FREQUENCY,
-				     min_freq);
+	ret = freq_qos_add_request(&policy->constraints, req, FREQ_QOS_MIN,
+				   min_freq);
 	if (ret < 0) {
 		dev_err(dev, "Failed to add min-freq constraint (%d)\n", ret);
 		goto free_req;
 	}
 
-	ret = dev_pm_qos_add_request(dev, req + 1, DEV_PM_QOS_MAX_FREQUENCY,
-				     max_freq);
+	ret = freq_qos_add_request(&policy->constraints, req + 1, FREQ_QOS_MAX,
+				   max_freq);
 	if (ret < 0) {
 		dev_err(dev, "Failed to add max-freq constraint (%d)\n", ret);
 		goto remove_min_req;
@@ -2435,7 +2435,7 @@ static int intel_cpufreq_cpu_init(struct
 	return 0;
 
 remove_min_req:
-	dev_pm_qos_remove_request(req);
+	freq_qos_remove_request(req);
 free_req:
 	kfree(req);
 pstate_exit:
@@ -2446,12 +2446,12 @@ pstate_exit:
 
 static int intel_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
-	struct dev_pm_qos_request *req;
+	struct freq_qos_request *req;
 
 	req = policy->driver_data;
 
-	dev_pm_qos_remove_request(req + 1);
-	dev_pm_qos_remove_request(req);
+	freq_qos_remove_request(req + 1);
+	freq_qos_remove_request(req);
 	kfree(req);
 
 	return intel_pstate_cpu_exit(policy);
Index: linux-pm/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ linux-pm/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(cbe_cpufreq_set_pmode_
 static void cbe_cpufreq_handle_pmi(pmi_message_t pmi_msg)
 {
 	struct cpufreq_policy *policy;
-	struct dev_pm_qos_request *req;
+	struct freq_qos_request *req;
 	u8 node, slow_mode;
 	int cpu, ret;
 
@@ -86,7 +86,7 @@ static void cbe_cpufreq_handle_pmi(pmi_m
 
 	req = policy->driver_data;
 
-	ret = dev_pm_qos_update_request(req,
+	ret = freq_qos_update_request(req,
 			policy->freq_table[slow_mode].frequency);
 	if (ret < 0)
 		pr_warn("Failed to update freq constraint: %d\n", ret);
@@ -103,7 +103,7 @@ static struct pmi_handler cbe_pmi_handle
 
 void cbe_cpufreq_pmi_policy_init(struct cpufreq_policy *policy)
 {
-	struct dev_pm_qos_request *req;
+	struct freq_qos_request *req;
 	int ret;
 
 	if (!cbe_cpufreq_has_pmi)
@@ -113,9 +113,8 @@ void cbe_cpufreq_pmi_policy_init(struct
 	if (!req)
 		return;
 
-	ret = dev_pm_qos_add_request(get_cpu_device(policy->cpu), req,
-				     DEV_PM_QOS_MAX_FREQUENCY,
-				     policy->freq_table[0].frequency);
+	ret = freq_qos_add_request(&policy->constraints, req, FREQ_QOS_MAX,
+				   policy->freq_table[0].frequency);
 	if (ret < 0) {
 		pr_err("Failed to add freq constraint (%d)\n", ret);
 		kfree(req);
@@ -128,10 +127,10 @@ EXPORT_SYMBOL_GPL(cbe_cpufreq_pmi_policy
 
 void cbe_cpufreq_pmi_policy_exit(struct cpufreq_policy *policy)
 {
-	struct dev_pm_qos_request *req = policy->driver_data;
+	struct freq_qos_request *req = policy->driver_data;
 
 	if (cbe_cpufreq_has_pmi) {
-		dev_pm_qos_remove_request(req);
+		freq_qos_remove_request(req);
 		kfree(req);
 	}
 }
Index: linux-pm/include/acpi/processor.h
===================================================================
--- linux-pm.orig/include/acpi/processor.h
+++ linux-pm/include/acpi/processor.h
@@ -232,8 +232,8 @@ struct acpi_processor {
 	struct acpi_processor_limit limit;
 	struct thermal_cooling_device *cdev;
 	struct device *dev; /* Processor device. */
-	struct dev_pm_qos_request perflib_req;
-	struct dev_pm_qos_request thermal_req;
+	struct freq_qos_request perflib_req;
+	struct freq_qos_request thermal_req;
 };
 
 struct acpi_processor_errata {
@@ -302,8 +302,8 @@ static inline void acpi_processor_ffh_cs
 #ifdef CONFIG_CPU_FREQ
 extern bool acpi_processor_cpufreq_init;
 void acpi_processor_ignore_ppc_init(void);
-void acpi_processor_ppc_init(int cpu);
-void acpi_processor_ppc_exit(int cpu);
+void acpi_processor_ppc_init(struct cpufreq_policy *policy);
+void acpi_processor_ppc_exit(struct cpufreq_policy *policy);
 void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 extern int acpi_processor_get_bios_limit(int cpu, unsigned int *limit);
 #else
@@ -311,11 +311,11 @@ static inline void acpi_processor_ignore
 {
 	return;
 }
-static inline void acpi_processor_ppc_init(int cpu)
+static inline void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 {
 	return;
 }
-static inline void acpi_processor_ppc_exit(int cpu)
+static inline void acpi_processor_ppc_exit(struct cpufreq_policy *policy)
 {
 	return;
 }
@@ -431,14 +431,14 @@ static inline int acpi_processor_hotplug
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
 #if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
-void acpi_thermal_cpufreq_init(int cpu);
-void acpi_thermal_cpufreq_exit(int cpu);
+void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
+void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy);
 #else
-static inline void acpi_thermal_cpufreq_init(int cpu)
+static inline void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
 	return;
 }
-static inline void acpi_thermal_cpufreq_exit(int cpu)
+static inline void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	return;
 }
Index: linux-pm/drivers/acpi/processor_driver.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_driver.c
+++ linux-pm/drivers/acpi/processor_driver.c
@@ -290,14 +290,13 @@ static int acpi_processor_notifier(struc
 				   unsigned long event, void *data)
 {
 	struct cpufreq_policy *policy = data;
-	int cpu = policy->cpu;
 
 	if (event == CPUFREQ_CREATE_POLICY) {
-		acpi_thermal_cpufreq_init(cpu);
-		acpi_processor_ppc_init(cpu);
+		acpi_thermal_cpufreq_init(policy);
+		acpi_processor_ppc_init(policy);
 	} else if (event == CPUFREQ_REMOVE_POLICY) {
-		acpi_processor_ppc_exit(cpu);
-		acpi_thermal_cpufreq_exit(cpu);
+		acpi_processor_ppc_exit(policy);
+		acpi_thermal_cpufreq_exit(policy);
 	}
 
 	return 0;
Index: linux-pm/drivers/acpi/processor_perflib.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_perflib.c
+++ linux-pm/drivers/acpi/processor_perflib.c
@@ -81,10 +81,10 @@ static int acpi_processor_get_platform_l
 	pr->performance_platform_limit = (int)ppc;
 
 	if (ppc >= pr->performance->state_count ||
-	    unlikely(!dev_pm_qos_request_active(&pr->perflib_req)))
+	    unlikely(!freq_qos_request_active(&pr->perflib_req)))
 		return 0;
 
-	ret = dev_pm_qos_update_request(&pr->perflib_req,
+	ret = freq_qos_update_request(&pr->perflib_req,
 			pr->performance->states[ppc].core_frequency * 1000);
 	if (ret < 0) {
 		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
@@ -157,28 +157,28 @@ void acpi_processor_ignore_ppc_init(void
 		ignore_ppc = 0;
 }
 
-void acpi_processor_ppc_init(int cpu)
+void acpi_processor_ppc_init(struct cpufreq_policy *policy)
 {
+	int cpu = policy->cpu;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 	int ret;
 
 	if (!pr)
 		return;
 
-	ret = dev_pm_qos_add_request(get_cpu_device(cpu),
-				     &pr->perflib_req, DEV_PM_QOS_MAX_FREQUENCY,
-				     INT_MAX);
+	ret = freq_qos_add_request(&policy->constraints, &pr->perflib_req,
+				   FREQ_QOS_MAX, INT_MAX);
 	if (ret < 0)
 		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
 		       ret);
 }
 
-void acpi_processor_ppc_exit(int cpu)
+void acpi_processor_ppc_exit(struct cpufreq_policy *policy)
 {
-	struct acpi_processor *pr = per_cpu(processors, cpu);
+	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
 
 	if (pr)
-		dev_pm_qos_remove_request(&pr->perflib_req);
+		freq_qos_remove_request(&pr->perflib_req);
 }
 
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
Index: linux-pm/drivers/acpi/processor_thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/processor_thermal.c
+++ linux-pm/drivers/acpi/processor_thermal.c
@@ -105,7 +105,7 @@ static int cpufreq_set_cur_state(unsigne
 
 		pr = per_cpu(processors, i);
 
-		if (unlikely(!dev_pm_qos_request_active(&pr->thermal_req)))
+		if (unlikely(!freq_qos_request_active(&pr->thermal_req)))
 			continue;
 
 		policy = cpufreq_cpu_get(i);
@@ -116,7 +116,7 @@ static int cpufreq_set_cur_state(unsigne
 
 		cpufreq_cpu_put(policy);
 
-		ret = dev_pm_qos_update_request(&pr->thermal_req, max_freq);
+		ret = freq_qos_update_request(&pr->thermal_req, max_freq);
 		if (ret < 0) {
 			pr_warn("Failed to update thermal freq constraint: CPU%d (%d)\n",
 				pr->id, ret);
@@ -125,28 +125,28 @@ static int cpufreq_set_cur_state(unsigne
 	return 0;
 }
 
-void acpi_thermal_cpufreq_init(int cpu)
+void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
 {
+	int cpu = policy->cpu;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 	int ret;
 
 	if (!pr)
 		return;
 
-	ret = dev_pm_qos_add_request(get_cpu_device(cpu),
-				     &pr->thermal_req, DEV_PM_QOS_MAX_FREQUENCY,
-				     INT_MAX);
+	ret = freq_qos_add_request(&policy->constraints, &pr->thermal_req,
+				   FREQ_QOS_MAX, INT_MAX);
 	if (ret < 0)
 		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
 		       ret);
 }
 
-void acpi_thermal_cpufreq_exit(int cpu)
+void acpi_thermal_cpufreq_exit(struct cpufreq_policy *policy)
 {
-	struct acpi_processor *pr = per_cpu(processors, cpu);
+	struct acpi_processor *pr = per_cpu(processors, policy->cpu);
 
 	if (pr)
-		dev_pm_qos_remove_request(&pr->thermal_req);
+		freq_qos_remove_request(&pr->thermal_req);
 }
 #else				/* ! CONFIG_CPU_FREQ */
 static int cpufreq_get_max_state(unsigned int cpu)
Index: linux-pm/drivers/thermal/cpu_cooling.c
===================================================================
--- linux-pm.orig/drivers/thermal/cpu_cooling.c
+++ linux-pm/drivers/thermal/cpu_cooling.c
@@ -88,7 +88,7 @@ struct cpufreq_cooling_device {
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
-	struct dev_pm_qos_request qos_req;
+	struct freq_qos_request qos_req;
 };
 
 static DEFINE_IDA(cpufreq_ida);
@@ -331,7 +331,7 @@ static int cpufreq_set_cur_state(struct
 
 	cpufreq_cdev->cpufreq_state = state;
 
-	return dev_pm_qos_update_request(&cpufreq_cdev->qos_req,
+	return freq_qos_update_request(&cpufreq_cdev->qos_req,
 				cpufreq_cdev->freq_table[state].frequency);
 }
 
@@ -615,9 +615,9 @@ __cpufreq_cooling_register(struct device
 		cooling_ops = &cpufreq_cooling_ops;
 	}
 
-	ret = dev_pm_qos_add_request(dev, &cpufreq_cdev->qos_req,
-				     DEV_PM_QOS_MAX_FREQUENCY,
-				     cpufreq_cdev->freq_table[0].frequency);
+	ret = freq_qos_add_request(&policy->constraints,
+				   &cpufreq_cdev->qos_req, FREQ_QOS_MAX,
+				   cpufreq_cdev->freq_table[0].frequency);
 	if (ret < 0) {
 		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
 		       ret);
@@ -637,7 +637,7 @@ __cpufreq_cooling_register(struct device
 	return cdev;
 
 remove_qos_req:
-	dev_pm_qos_remove_request(&cpufreq_cdev->qos_req);
+	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_table:
@@ -736,7 +736,7 @@ void cpufreq_cooling_unregister(struct t
 	mutex_unlock(&cooling_list_lock);
 
 	thermal_cooling_device_unregister(cdev);
-	dev_pm_qos_remove_request(&cpufreq_cdev->qos_req);
+	freq_qos_remove_request(&cpufreq_cdev->qos_req);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev->freq_table);
Index: linux-pm/drivers/macintosh/windfarm_cpufreq_clamp.c
===================================================================
--- linux-pm.orig/drivers/macintosh/windfarm_cpufreq_clamp.c
+++ linux-pm/drivers/macintosh/windfarm_cpufreq_clamp.c
@@ -18,7 +18,7 @@
 
 static int clamped;
 static struct wf_control *clamp_control;
-static struct dev_pm_qos_request qos_req;
+static struct freq_qos_request qos_req;
 static unsigned int min_freq, max_freq;
 
 static int clamp_set(struct wf_control *ct, s32 value)
@@ -35,7 +35,7 @@ static int clamp_set(struct wf_control *
 	}
 	clamped = value;
 
-	return dev_pm_qos_update_request(&qos_req, freq);
+	return freq_qos_update_request(&qos_req, freq);
 }
 
 static int clamp_get(struct wf_control *ct, s32 *value)
@@ -77,38 +77,44 @@ static int __init wf_cpufreq_clamp_init(
 
 	min_freq = policy->cpuinfo.min_freq;
 	max_freq = policy->cpuinfo.max_freq;
+
+	ret = freq_qos_add_request(&policy->constraints, &qos_req, FREQ_QOS_MAX,
+				   max_freq);
+
 	cpufreq_cpu_put(policy);
 
+	if (ret < 0) {
+		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
+		       ret);
+		return ret;
+	}
+
 	dev = get_cpu_device(0);
 	if (unlikely(!dev)) {
 		pr_warn("%s: No cpu device for cpu0\n", __func__);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail;
 	}
 
 	clamp = kmalloc(sizeof(struct wf_control), GFP_KERNEL);
-	if (clamp == NULL)
-		return -ENOMEM;
-
-	ret = dev_pm_qos_add_request(dev, &qos_req, DEV_PM_QOS_MAX_FREQUENCY,
-				     max_freq);
-	if (ret < 0) {
-		pr_err("%s: Failed to add freq constraint (%d)\n", __func__,
-		       ret);
-		goto free;
+	if (clamp == NULL) {
+		ret = -ENOMEM;
+		goto fail;
 	}
 
 	clamp->ops = &clamp_ops;
 	clamp->name = "cpufreq-clamp";
 	ret = wf_register_control(clamp);
 	if (ret)
-		goto fail;
+		goto free;
+
 	clamp_control = clamp;
 	return 0;
- fail:
-	dev_pm_qos_remove_request(&qos_req);
 
  free:
 	kfree(clamp);
+ fail:
+	freq_qos_remove_request(&qos_req);
 	return ret;
 }
 
@@ -116,7 +122,7 @@ static void __exit wf_cpufreq_clamp_exit
 {
 	if (clamp_control) {
 		wf_unregister_control(clamp_control);
-		dev_pm_qos_remove_request(&qos_req);
+		freq_qos_remove_request(&qos_req);
 	}
 }
 



