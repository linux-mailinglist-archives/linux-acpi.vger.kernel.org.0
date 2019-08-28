Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B46129FD76
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Aug 2019 10:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH1IuV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Aug 2019 04:50:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39923 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1IuV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Aug 2019 04:50:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id z3so918873pln.6
        for <linux-acpi@vger.kernel.org>; Wed, 28 Aug 2019 01:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Nnv8QQTbl6/pTPsiKbtpWJmv+kviSXUlOqzZyVEImo=;
        b=xhcPOf4JUVCsmsu4786wPuDswAHx6EjrHiu7JBN928Ur2OmJBgkJmq7Zk5ZiLcNu82
         L7s7c/LWhKYbHh3o0WFv4JwcJ9gQx83/CS4O9ejMBxLzSo/aOxGsxZEFPk+Tca27Vjkc
         WUhdwZO5tb0sWW91JMs2bX8equX1xf+C8ynwV/ZtBpSz1PKxYcMfVu6zqQAK8V9q4JCQ
         uN8j5Vm/bNQ9dxtYdKRZwwwUUDBFcL6zBpUDAXKzZwtBppYuUd4cgn4h5TuC7CjwDpD2
         +t+Q4J6ZIHhZBISMvIEDegKjdDicUoW9mr/ysUxQz3qNqtMA90YqwgbuPiDz6urrdg3G
         dk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Nnv8QQTbl6/pTPsiKbtpWJmv+kviSXUlOqzZyVEImo=;
        b=S4YbXv5XkRyIsvj0yeqDUWMbupLc+9lpS9g6ClnpaBQMmIVO/0FJrwp5LhH5/1n9u4
         EnkIM3bTK0i6vaBNKDq/3FymoVSD1yADRPtK4ySIkE0SUUfOsjknVBAF+maoRYWgsJ2b
         8Jou6ZIXVhp8fxDZCcxgwkdWKP13vUdGRPR1U52obtGKKOteBGk8SOGtcjfy7c/hSEBZ
         HtwWKMVs37Fj0+uRzmN24P8Szn/8WkUsTUP8mHL7U5y3douxKv0q0faxjaWCZVcLUmEV
         7WNSn2NxpsKmq8Tzr43BTmP3SfAisQe8TCGk8NItI3w+NNd6/6giqILrUSiLfIfVi9Uj
         3M8w==
X-Gm-Message-State: APjAAAX79MW7uGo6axd9/imrMPlRHeHShxhpj85WQWgSsKS6MbNhlx3w
        fGfN3WYnWGjls+V6zJVTYByCqQ==
X-Google-Smtp-Source: APXvYqz4UJf4HPJLsPKQN1TRFxbv72N6qvCrGmuqVMEXvoXVZ5OGcOascXaCdasWwhADnZg7Cfeakw==
X-Received: by 2002:a17:902:2ea2:: with SMTP id r31mr3246852plb.200.1566982220339;
        Wed, 28 Aug 2019 01:50:20 -0700 (PDT)
Received: from localhost ([122.171.230.51])
        by smtp.gmail.com with ESMTPSA id s7sm2940771pfb.138.2019.08.28.01.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 01:50:19 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH V3 05/10] ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier
Date:   Wed, 28 Aug 2019 14:20:13 +0530
Message-Id: <c9c771b358c7ce7315b1b5a374375de87899f35b.1566982038.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <86dc4a082ea00c278c0e1d7f3fcbdc4ab9af2eec.1563862014.git.viresh.kumar@linaro.org>
References: <86dc4a082ea00c278c0e1d7f3fcbdc4ab9af2eec.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The cpufreq core now takes the min/max frequency constraints via QoS
requests and the CPUFREQ_ADJUST notifier shall get removed later on.

Switch over to using the QoS request for maximum frequency constraint
for acpi driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3:
- Before updating qos request, make sure they are successfully added in
  the first place using dev_pm_qos_request_active() helper.
- reset ignore_ppc from acpi_processor_ignore_ppc_init().

 drivers/acpi/processor_driver.c  |  39 ++++++++++--
 drivers/acpi/processor_perflib.c | 100 ++++++++++++-------------------
 drivers/acpi/processor_thermal.c |  84 +++++++++++++-------------
 include/acpi/processor.h         |  26 +++++---
 4 files changed, 132 insertions(+), 117 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index aea8d674a33d..08da9c29f1e9 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -284,6 +284,29 @@ static int acpi_processor_stop(struct device *dev)
 	return 0;
 }
 
+bool acpi_processor_cpufreq_init;
+
+static int acpi_processor_notifier(struct notifier_block *nb,
+				   unsigned long event, void *data)
+{
+	struct cpufreq_policy *policy = data;
+	int cpu = policy->cpu;
+
+	if (event == CPUFREQ_CREATE_POLICY) {
+		acpi_thermal_cpufreq_init(cpu);
+		acpi_processor_ppc_init(cpu);
+	} else if (event == CPUFREQ_REMOVE_POLICY) {
+		acpi_processor_ppc_exit(cpu);
+		acpi_thermal_cpufreq_exit(cpu);
+	}
+
+	return 0;
+}
+
+static struct notifier_block acpi_processor_notifier_block = {
+	.notifier_call = acpi_processor_notifier,
+};
+
 /*
  * We keep the driver loaded even when ACPI is not running.
  * This is needed for the powernow-k8 driver, that works even without
@@ -310,8 +333,12 @@ static int __init acpi_processor_driver_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD, "acpi/cpu-drv:dead",
 				  NULL, acpi_soft_cpu_dead);
 
-	acpi_thermal_cpufreq_init();
-	acpi_processor_ppc_init();
+	if (!cpufreq_register_notifier(&acpi_processor_notifier_block,
+				       CPUFREQ_POLICY_NOTIFIER)) {
+		acpi_processor_cpufreq_init = true;
+		acpi_processor_ignore_ppc_init();
+	}
+
 	acpi_processor_throttling_init();
 	return 0;
 err:
@@ -324,8 +351,12 @@ static void __exit acpi_processor_driver_exit(void)
 	if (acpi_disabled)
 		return;
 
-	acpi_processor_ppc_exit();
-	acpi_thermal_cpufreq_exit();
+	if (acpi_processor_cpufreq_init) {
+		cpufreq_unregister_notifier(&acpi_processor_notifier_block,
+					    CPUFREQ_POLICY_NOTIFIER);
+		acpi_processor_cpufreq_init = false;
+	}
+
 	cpuhp_remove_state_nocalls(hp_online);
 	cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
 	driver_unregister(&acpi_processor_driver);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index ee87cb6f6e59..2261713d1aec 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -50,57 +50,13 @@ module_param(ignore_ppc, int, 0644);
 MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
 		 "limited by BIOS, this should help");
 
-#define PPC_REGISTERED   1
-#define PPC_IN_USE       2
-
-static int acpi_processor_ppc_status;
-
-static int acpi_processor_ppc_notifier(struct notifier_block *nb,
-				       unsigned long event, void *data)
-{
-	struct cpufreq_policy *policy = data;
-	struct acpi_processor *pr;
-	unsigned int ppc = 0;
-
-	if (ignore_ppc < 0)
-		ignore_ppc = 0;
-
-	if (ignore_ppc)
-		return 0;
-
-	if (event != CPUFREQ_ADJUST)
-		return 0;
-
-	mutex_lock(&performance_mutex);
-
-	pr = per_cpu(processors, policy->cpu);
-	if (!pr || !pr->performance)
-		goto out;
-
-	ppc = (unsigned int)pr->performance_platform_limit;
-
-	if (ppc >= pr->performance->state_count)
-		goto out;
-
-	cpufreq_verify_within_limits(policy, 0,
-				     pr->performance->states[ppc].
-				     core_frequency * 1000);
-
-      out:
-	mutex_unlock(&performance_mutex);
-
-	return 0;
-}
-
-static struct notifier_block acpi_ppc_notifier_block = {
-	.notifier_call = acpi_processor_ppc_notifier,
-};
+static bool acpi_processor_ppc_in_use;
 
 static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 {
 	acpi_status status = 0;
 	unsigned long long ppc = 0;
-
+	int ret;
 
 	if (!pr)
 		return -EINVAL;
@@ -112,7 +68,7 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 	status = acpi_evaluate_integer(pr->handle, "_PPC", NULL, &ppc);
 
 	if (status != AE_NOT_FOUND)
-		acpi_processor_ppc_status |= PPC_IN_USE;
+		acpi_processor_ppc_in_use = true;
 
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating _PPC"));
@@ -124,6 +80,17 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
 
 	pr->performance_platform_limit = (int)ppc;
 
+	if (ppc >= pr->performance->state_count ||
+	    unlikely(!dev_pm_qos_request_active(&pr->perflib_req)))
+		return 0;
+
+	ret = dev_pm_qos_update_request(&pr->perflib_req,
+			pr->performance->states[ppc].core_frequency * 1000);
+	if (ret < 0) {
+		pr_warn("Failed to update perflib freq constraint: CPU%d (%d)\n",
+			pr->id, ret);
+	}
+
 	return 0;
 }
 
@@ -184,23 +151,32 @@ int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
 }
 EXPORT_SYMBOL(acpi_processor_get_bios_limit);
 
-void acpi_processor_ppc_init(void)
+void acpi_processor_ignore_ppc_init(void)
 {
-	if (!cpufreq_register_notifier
-	    (&acpi_ppc_notifier_block, CPUFREQ_POLICY_NOTIFIER))
-		acpi_processor_ppc_status |= PPC_REGISTERED;
-	else
-		printk(KERN_DEBUG
-		       "Warning: Processor Platform Limit not supported.\n");
+	if (ignore_ppc < 0)
+		ignore_ppc = 0;
+}
+
+void acpi_processor_ppc_init(int cpu)
+{
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+	int ret;
+
+	ret = dev_pm_qos_add_request(get_cpu_device(cpu),
+				     &pr->perflib_req, DEV_PM_QOS_MAX_FREQUENCY,
+				     INT_MAX);
+	if (ret < 0) {
+		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
+		       ret);
+		return;
+	}
 }
 
-void acpi_processor_ppc_exit(void)
+void acpi_processor_ppc_exit(int cpu)
 {
-	if (acpi_processor_ppc_status & PPC_REGISTERED)
-		cpufreq_unregister_notifier(&acpi_ppc_notifier_block,
-					    CPUFREQ_POLICY_NOTIFIER);
+	struct acpi_processor *pr = per_cpu(processors, cpu);
 
-	acpi_processor_ppc_status &= ~PPC_REGISTERED;
+	dev_pm_qos_remove_request(&pr->perflib_req);
 }
 
 static int acpi_processor_get_performance_control(struct acpi_processor *pr)
@@ -477,7 +453,7 @@ int acpi_processor_notify_smm(struct module *calling_module)
 	static int is_done = 0;
 	int result;
 
-	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
+	if (!acpi_processor_cpufreq_init)
 		return -EBUSY;
 
 	if (!try_module_get(calling_module))
@@ -513,7 +489,7 @@ int acpi_processor_notify_smm(struct module *calling_module)
 	 * we can allow the cpufreq driver to be rmmod'ed. */
 	is_done = 1;
 
-	if (!(acpi_processor_ppc_status & PPC_IN_USE))
+	if (!acpi_processor_ppc_in_use)
 		module_put(calling_module);
 
 	return 0;
@@ -742,7 +718,7 @@ acpi_processor_register_performance(struct acpi_processor_performance
 {
 	struct acpi_processor *pr;
 
-	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
+	if (!acpi_processor_cpufreq_init)
 		return -EINVAL;
 
 	mutex_lock(&performance_mutex);
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 50fb0107375e..ec2638f1df4f 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -35,7 +35,6 @@ ACPI_MODULE_NAME("processor_thermal");
 #define CPUFREQ_THERMAL_MAX_STEP 3
 
 static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
-static unsigned int acpi_thermal_cpufreq_is_init = 0;
 
 #define reduction_pctg(cpu) \
 	per_cpu(cpufreq_thermal_reduction_pctg, phys_package_first_cpu(cpu))
@@ -61,35 +60,11 @@ static int phys_package_first_cpu(int cpu)
 static int cpu_has_cpufreq(unsigned int cpu)
 {
 	struct cpufreq_policy policy;
-	if (!acpi_thermal_cpufreq_is_init || cpufreq_get_policy(&policy, cpu))
+	if (!acpi_processor_cpufreq_init || cpufreq_get_policy(&policy, cpu))
 		return 0;
 	return 1;
 }
 
-static int acpi_thermal_cpufreq_notifier(struct notifier_block *nb,
-					 unsigned long event, void *data)
-{
-	struct cpufreq_policy *policy = data;
-	unsigned long max_freq = 0;
-
-	if (event != CPUFREQ_ADJUST)
-		goto out;
-
-	max_freq = (
-	    policy->cpuinfo.max_freq *
-	    (100 - reduction_pctg(policy->cpu) * 20)
-	) / 100;
-
-	cpufreq_verify_within_limits(policy, 0, max_freq);
-
-      out:
-	return 0;
-}
-
-static struct notifier_block acpi_thermal_cpufreq_notifier_block = {
-	.notifier_call = acpi_thermal_cpufreq_notifier,
-};
-
 static int cpufreq_get_max_state(unsigned int cpu)
 {
 	if (!cpu_has_cpufreq(cpu))
@@ -108,7 +83,10 @@ static int cpufreq_get_cur_state(unsigned int cpu)
 
 static int cpufreq_set_cur_state(unsigned int cpu, int state)
 {
-	int i;
+	struct cpufreq_policy *policy;
+	struct acpi_processor *pr;
+	unsigned long max_freq;
+	int i, ret;
 
 	if (!cpu_has_cpufreq(cpu))
 		return 0;
@@ -121,33 +99,53 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
 	 * frequency.
 	 */
 	for_each_online_cpu(i) {
-		if (topology_physical_package_id(i) ==
+		if (topology_physical_package_id(i) !=
 		    topology_physical_package_id(cpu))
-			cpufreq_update_policy(i);
+			continue;
+
+		pr = per_cpu(processors, i);
+
+		if (unlikely(!dev_pm_qos_request_active(&pr->thermal_req)))
+			continue;
+
+		policy = cpufreq_cpu_get(i);
+		if (!policy)
+			return -EINVAL;
+
+		max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
+
+		cpufreq_cpu_put(policy);
+
+		ret = dev_pm_qos_update_request(&pr->thermal_req, max_freq);
+		if (ret < 0) {
+			pr_warn("Failed to update thermal freq constraint: CPU%d (%d)\n",
+				pr->id, ret);
+		}
 	}
 	return 0;
 }
 
-void acpi_thermal_cpufreq_init(void)
+void acpi_thermal_cpufreq_init(int cpu)
 {
-	int i;
-
-	i = cpufreq_register_notifier(&acpi_thermal_cpufreq_notifier_block,
-				      CPUFREQ_POLICY_NOTIFIER);
-	if (!i)
-		acpi_thermal_cpufreq_is_init = 1;
+	struct acpi_processor *pr = per_cpu(processors, cpu);
+	int ret;
+
+	ret = dev_pm_qos_add_request(get_cpu_device(cpu),
+				     &pr->thermal_req, DEV_PM_QOS_MAX_FREQUENCY,
+				     INT_MAX);
+	if (ret < 0) {
+		pr_err("Failed to add freq constraint for CPU%d (%d)\n", cpu,
+		       ret);
+		return;
+	}
 }
 
-void acpi_thermal_cpufreq_exit(void)
+void acpi_thermal_cpufreq_exit(int cpu)
 {
-	if (acpi_thermal_cpufreq_is_init)
-		cpufreq_unregister_notifier
-		    (&acpi_thermal_cpufreq_notifier_block,
-		     CPUFREQ_POLICY_NOTIFIER);
+	struct acpi_processor *pr = per_cpu(processors, cpu);
 
-	acpi_thermal_cpufreq_is_init = 0;
+	dev_pm_qos_remove_request(&pr->thermal_req);
 }
-
 #else				/* ! CONFIG_CPU_FREQ */
 static int cpufreq_get_max_state(unsigned int cpu)
 {
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 1194a4c78d55..f936033cb9e6 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -4,6 +4,8 @@
 
 #include <linux/kernel.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/pm_qos.h>
 #include <linux/thermal.h>
 #include <asm/acpi.h>
 
@@ -230,6 +232,8 @@ struct acpi_processor {
 	struct acpi_processor_limit limit;
 	struct thermal_cooling_device *cdev;
 	struct device *dev; /* Processor device. */
+	struct dev_pm_qos_request perflib_req;
+	struct dev_pm_qos_request thermal_req;
 };
 
 struct acpi_processor_errata {
@@ -296,16 +300,22 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 /* in processor_perflib.c */
 
 #ifdef CONFIG_CPU_FREQ
-void acpi_processor_ppc_init(void);
-void acpi_processor_ppc_exit(void);
+extern bool acpi_processor_cpufreq_init;
+void acpi_processor_ignore_ppc_init(void);
+void acpi_processor_ppc_init(int cpu);
+void acpi_processor_ppc_exit(int cpu);
 void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag);
 extern int acpi_processor_get_bios_limit(int cpu, unsigned int *limit);
 #else
-static inline void acpi_processor_ppc_init(void)
+static inline void acpi_processor_ignore_ppc_init(void)
 {
 	return;
 }
-static inline void acpi_processor_ppc_exit(void)
+static inline void acpi_processor_ppc_init(int cpu)
+{
+	return;
+}
+static inline void acpi_processor_ppc_exit(int cpu)
 {
 	return;
 }
@@ -421,14 +431,14 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
 extern const struct thermal_cooling_device_ops processor_cooling_ops;
 #if defined(CONFIG_ACPI_CPU_FREQ_PSS) & defined(CONFIG_CPU_FREQ)
-void acpi_thermal_cpufreq_init(void);
-void acpi_thermal_cpufreq_exit(void);
+void acpi_thermal_cpufreq_init(int cpu);
+void acpi_thermal_cpufreq_exit(int cpu);
 #else
-static inline void acpi_thermal_cpufreq_init(void)
+static inline void acpi_thermal_cpufreq_init(int cpu)
 {
 	return;
 }
-static inline void acpi_thermal_cpufreq_exit(void)
+static inline void acpi_thermal_cpufreq_exit(int cpu)
 {
 	return;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

