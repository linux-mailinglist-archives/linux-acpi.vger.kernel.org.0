Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571652D981C
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 13:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405045AbgLNMkP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 07:40:15 -0500
Received: from foss.arm.com ([217.140.110.172]:46760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407257AbgLNMkE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Dec 2020 07:40:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB12412FC;
        Mon, 14 Dec 2020 04:39:17 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF7B43F66B;
        Mon, 14 Dec 2020 04:39:15 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     yousaf.kaukab@suse.com, jeremy.linton@arm.com, lukasz.luba@arm.com,
        valentin.schneider@arm.com, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 4/4] cppc_cpufreq: replace per-cpu data array with a list
Date:   Mon, 14 Dec 2020 12:38:23 +0000
Message-Id: <20201214123823.3949-5-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20201214123823.3949-1-ionela.voinescu@arm.com>
References: <20201214123823.3949-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The cppc_cpudata per-cpu storage was inefficient (1) additional to causing
functional issues (2) when CPUs are hotplugged out, due to per-cpu data
being improperly initialised.

(1) The amount of information needed for CPPC performance control in its
    cpufreq driver depends on the domain (PSD) coordination type:

    ANY:    One set of CPPC control and capability data (e.g desired
            performance, highest/lowest performance, etc) applies to all
            CPUs in the domain.

    ALL:    Same as ANY. To be noted that this type is not currently
            supported. When supported, information about which CPUs
            belong to a domain is needed in order for frequency change
            requests to be sent to each of them.

    HW:     It's necessary to store CPPC control and capability
            information for all the CPUs. HW will then coordinate the
            performance state based on their limitations and requests.

    NONE:   Same as HW. No HW coordination is expected.

    Despite this, the previous initialisation code would indiscriminately
    allocate memory for all CPUs (all_cpu_data) and unnecessarily
    duplicate performance capabilities and the domain sharing mask and type
    for each possible CPU.

(2) With the current per-cpu structure, when having ANY coordination,
    the cppc_cpudata cpu information is not initialised (will remain 0)
    for all CPUs in a policy, other than policy->cpu. When policy->cpu is
    hotplugged out, the driver will incorrectly use the uninitialised (0)
    value of the other CPUs when making frequency changes. Additionally,
    the previous values stored in the perf_ctrls.desired_perf will be
    lost when policy->cpu changes.

Therefore replace the array of per cpu data with a list. The memory for
each structure is allocated at policy init, where a single structure
can be allocated per policy, not per cpu. In order to accommodate the
struct list_head node in the cppc_cpudata structure, the now unused cpu
and cur_policy variables are removed.

For example, on a arm64 Juno platform with 6 CPUs: (0, 1, 2, 3) in PSD1,
(4, 5) in PSD2 - ANY coordination, the memory allocation comparison shows:

Before patch:

 - ANY coordination:
   total    slack      req alloc/free  caller
       0        0        0     0/1     _kernel_size_le_hi32+0x0xffff800008ff7810
       0        0        0     0/6     _kernel_size_le_hi32+0x0xffff800008ff7808
     128       80       48     1/0     _kernel_size_le_hi32+0x0xffff800008ffc070
     768        0      768     6/0     _kernel_size_le_hi32+0x0xffff800008ffc0e4

After patch:

 - ANY coordination:
    total    slack      req alloc/free  caller
     256        0      256     2/0     _kernel_size_le_hi32+0x0xffff800008fed410
       0        0        0     0/2     _kernel_size_le_hi32+0x0xffff800008fed274

Additional notes:
 - A pointer to the policy's cppc_cpudata is stored in policy->driver_data
 - Driver registration is skipped if _CPC entries are not present.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/acpi/cppc_acpi.c       | 141 ++++++++++++--------------
 drivers/cpufreq/cppc_cpufreq.c | 174 +++++++++++++++++----------------
 include/acpi/cppc_acpi.h       |   6 +-
 3 files changed, 154 insertions(+), 167 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 62f55db443c1..75aaf94ae0a9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -414,109 +414,88 @@ static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
 	return result;
 }
 
+bool acpi_cpc_valid(void)
+{
+	struct cpc_desc *cpc_ptr;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
+		if (!cpc_ptr)
+			return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(acpi_cpc_valid);
+
 /**
- * acpi_get_psd_map - Map the CPUs in a common freq domain.
- * @all_cpu_data: Ptrs to CPU specific CPPC data including PSD info.
+ * acpi_get_psd_map - Map the CPUs in the freq domain of a given cpu
+ * @cpu: Find all CPUs that share a domain with cpu.
+ * @cpu_data: Pointer to CPU specific CPPC data including PSD info.
  *
  *	Return: 0 for success or negative value for err.
  */
-int acpi_get_psd_map(struct cppc_cpudata **all_cpu_data)
+int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
 {
-	int count_target;
-	int retval = 0;
-	unsigned int i, j;
-	cpumask_var_t covered_cpus;
-	struct cppc_cpudata *pr, *match_pr;
-	struct acpi_psd_package *pdomain;
-	struct acpi_psd_package *match_pdomain;
 	struct cpc_desc *cpc_ptr, *match_cpc_ptr;
-
-	if (!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL))
-		return -ENOMEM;
+	struct acpi_psd_package *match_pdomain;
+	struct acpi_psd_package *pdomain;
+	int count_target, i;
 
 	/*
 	 * Now that we have _PSD data from all CPUs, let's setup P-state
 	 * domain info.
 	 */
-	for_each_possible_cpu(i) {
-		if (cpumask_test_cpu(i, covered_cpus))
-			continue;
-
-		pr = all_cpu_data[i];
-		cpc_ptr = per_cpu(cpc_desc_ptr, i);
-		if (!cpc_ptr) {
-			retval = -EFAULT;
-			goto err_ret;
-		}
+	cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
+	if (!cpc_ptr)
+		return -EFAULT;
 
-		pdomain = &(cpc_ptr->domain_info);
-		cpumask_set_cpu(i, pr->shared_cpu_map);
-		cpumask_set_cpu(i, covered_cpus);
-		if (pdomain->num_processors <= 1)
-			continue;
+	pdomain = &(cpc_ptr->domain_info);
+	cpumask_set_cpu(cpu, cpu_data->shared_cpu_map);
+	if (pdomain->num_processors <= 1)
+		return 0;
 
-		/* Validate the Domain info */
-		count_target = pdomain->num_processors;
-		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
-			pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
-		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
-			pr->shared_type = CPUFREQ_SHARED_TYPE_HW;
-		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
-			pr->shared_type = CPUFREQ_SHARED_TYPE_ANY;
-
-		for_each_possible_cpu(j) {
-			if (i == j)
-				continue;
-
-			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
-			if (!match_cpc_ptr) {
-				retval = -EFAULT;
-				goto err_ret;
-			}
+	/* Validate the Domain info */
+	count_target = pdomain->num_processors;
+	if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
+		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
+		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_HW;
+	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
+		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 
-			match_pdomain = &(match_cpc_ptr->domain_info);
-			if (match_pdomain->domain != pdomain->domain)
-				continue;
+	for_each_possible_cpu(i) {
+		if (i == cpu)
+			continue;
 
-			/* Here i and j are in the same domain */
-			if (match_pdomain->num_processors != count_target) {
-				retval = -EFAULT;
-				goto err_ret;
-			}
+		match_cpc_ptr = per_cpu(cpc_desc_ptr, i);
+		if (!match_cpc_ptr)
+			goto err_fault;
 
-			if (pdomain->coord_type != match_pdomain->coord_type) {
-				retval = -EFAULT;
-				goto err_ret;
-			}
+		match_pdomain = &(match_cpc_ptr->domain_info);
+		if (match_pdomain->domain != pdomain->domain)
+			continue;
 
-			cpumask_set_cpu(j, covered_cpus);
-			cpumask_set_cpu(j, pr->shared_cpu_map);
-		}
+		/* Here i and cpu are in the same domain */
+		if (match_pdomain->num_processors != count_target)
+			goto err_fault;
 
-		for_each_cpu(j, pr->shared_cpu_map) {
-			if (i == j)
-				continue;
+		if (pdomain->coord_type != match_pdomain->coord_type)
+			goto err_fault;
 
-			match_pr = all_cpu_data[j];
-			match_pr->shared_type = pr->shared_type;
-			cpumask_copy(match_pr->shared_cpu_map,
-				     pr->shared_cpu_map);
-		}
+		cpumask_set_cpu(i, cpu_data->shared_cpu_map);
 	}
-	goto out;
 
-err_ret:
-	for_each_possible_cpu(i) {
-		pr = all_cpu_data[i];
+	return 0;
 
-		/* Assume no coordination on any error parsing domain info */
-		cpumask_clear(pr->shared_cpu_map);
-		cpumask_set_cpu(i, pr->shared_cpu_map);
-		pr->shared_type = CPUFREQ_SHARED_TYPE_NONE;
-	}
-out:
-	free_cpumask_var(covered_cpus);
-	return retval;
+err_fault:
+	/* Assume no coordination on any error parsing domain info */
+	cpumask_clear(cpu_data->shared_cpu_map);
+	cpumask_set_cpu(cpu, cpu_data->shared_cpu_map);
+	cpu_data->shared_type = CPUFREQ_SHARED_TYPE_NONE;
+
+	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(acpi_get_psd_map);
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 40b58d2dbbc6..8a482c434ea6 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -30,13 +30,13 @@
 #define DMI_PROCESSOR_MAX_SPEED		0x14
 
 /*
- * These structs contain information parsed from per CPU
- * ACPI _CPC structures.
- * e.g. For each CPU the highest, lowest supported
- * performance capabilities, desired performance level
- * requested etc.
+ * This list contains information parsed from per CPU ACPI _CPC and _PSD
+ * structures: e.g. the highest and lowest supported performance, capabilities,
+ * desired performance, level requested etc. Depending on the share_type, not
+ * all CPUs will have an entry in the list.
  */
-static struct cppc_cpudata **all_cpu_data;
+static LIST_HEAD(cpu_data_list);
+
 static bool boost_supported;
 
 struct cppc_workaround_oem_info {
@@ -148,8 +148,9 @@ static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_data,
 static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int relation)
+
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_freqs freqs;
 	u32 desired_perf;
@@ -183,7 +184,7 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 
 static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	unsigned int cpu = policy->cpu;
 	int ret;
@@ -194,6 +195,12 @@ static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
 	if (ret)
 		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
 			 caps->lowest_perf, cpu, ret);
+
+	/* Remove CPU node from list and free driver data for policy */
+	free_cpumask_var(cpu_data->shared_cpu_map);
+	list_del(&cpu_data->node);
+	kfree(policy->driver_data);
+	policy->driver_data = NULL;
 }
 
 /*
@@ -239,25 +246,61 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 }
 #endif
 
-static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+
+static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	unsigned int cpu = policy->cpu;
-	int i, ret = 0;
+	struct cppc_cpudata *cpu_data;
+	int ret;
+
+	cpu_data = kzalloc(sizeof(struct cppc_cpudata), GFP_KERNEL);
+	if (!cpu_data)
+		goto out;
 
-	cpu_data->cpu = cpu;
-	ret = cppc_get_perf_caps(cpu, caps);
+	if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
+		goto free_cpu;
 
+	ret = acpi_get_psd_map(cpu, cpu_data);
 	if (ret) {
-		pr_debug("Err reading CPU%d perf capabilities. ret:%d\n",
-			 cpu, ret);
-		return ret;
+		pr_debug("Err parsing CPU%d PSD data: ret:%d\n", cpu, ret);
+		goto free_mask;
+	}
+
+	ret = cppc_get_perf_caps(cpu, &cpu_data->perf_caps);
+	if (ret) {
+		pr_debug("Err reading CPU%d perf caps: ret:%d\n", cpu, ret);
+		goto free_mask;
 	}
 
 	/* Convert the lowest and nominal freq from MHz to KHz */
-	caps->lowest_freq *= 1000;
-	caps->nominal_freq *= 1000;
+	cpu_data->perf_caps.lowest_freq *= 1000;
+	cpu_data->perf_caps.nominal_freq *= 1000;
+
+	list_add(&cpu_data->node, &cpu_data_list);
+
+	return cpu_data;
+
+free_mask:
+	free_cpumask_var(cpu_data->shared_cpu_map);
+free_cpu:
+	kfree(cpu_data);
+out:
+	return NULL;
+}
+
+static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	unsigned int cpu = policy->cpu;
+	struct cppc_cpudata *cpu_data;
+	struct cppc_perf_caps *caps;
+	int ret;
+
+	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
+	if (!cpu_data) {
+		pr_err("Error in acquiring _CPC/_PSD data for CPU%d.\n", cpu);
+		return -ENODEV;
+	}
+	caps = &cpu_data->perf_caps;
+	policy->driver_data = cpu_data;
 
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
@@ -287,16 +330,12 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		/* Nothing to be done - we'll have a policy for each CPU */
 		break;
 	case CPUFREQ_SHARED_TYPE_ANY:
-		 /* All CPUs in the domain will share a policy */
+		/*
+		 * All CPUs in the domain will share a policy and all cpufreq
+		 * operations will use a single cppc_cpudata structure stored
+		 * in policy->driver_data.
+		 */
 		cpumask_copy(policy->cpus, cpu_data->shared_cpu_map);
-
-		for_each_cpu(i, policy->cpus) {
-			if (unlikely(i == cpu))
-				continue;
-
-			memcpy(&all_cpu_data[i]->perf_caps, caps,
-			       sizeof(cpu_data->perf_caps));
-		}
 		break;
 	default:
 		pr_debug("Unsupported CPU co-ord type: %d\n",
@@ -304,8 +343,6 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		return -EFAULT;
 	}
 
-	cpu_data->cur_policy = policy;
-
 	/*
 	 * If 'highest_perf' is greater than 'nominal_perf', we assume CPU Boost
 	 * is supported.
@@ -360,9 +397,12 @@ static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu_data,
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
-	struct cppc_cpudata *cpu_data = all_cpu_data[cpu];
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	int ret;
 
+	cpufreq_cpu_put(policy);
+
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
 	if (ret)
 		return ret;
@@ -378,7 +418,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[policy->cpu];
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	int ret;
 
@@ -404,9 +444,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 
 static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
-	unsigned int cpu = policy->cpu;
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 
-	return cpufreq_show_cpus(all_cpu_data[cpu]->shared_cpu_map, buf);
+	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
 }
 cpufreq_freq_attr_ro(freqdomain_cpus);
 
@@ -435,10 +475,13 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
  */
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cppc_cpudata *cpu_data = all_cpu_data[cpu];
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct cppc_cpudata *cpu_data = policy->driver_data;
 	u64 desired_perf;
 	int ret;
 
+	cpufreq_cpu_put(policy);
+
 	ret = cppc_get_desired_perf(cpu, &desired_perf);
 	if (ret < 0)
 		return -EIO;
@@ -471,68 +514,33 @@ static void cppc_check_hisi_workaround(void)
 
 static int __init cppc_cpufreq_init(void)
 {
-	struct cppc_cpudata *cpu_data;
-	int i, ret = 0;
-
-	if (acpi_disabled)
+	if ((acpi_disabled) || !acpi_cpc_valid())
 		return -ENODEV;
 
-	all_cpu_data = kcalloc(num_possible_cpus(), sizeof(void *),
-			       GFP_KERNEL);
-	if (!all_cpu_data)
-		return -ENOMEM;
-
-	for_each_possible_cpu(i) {
-		all_cpu_data[i] = kzalloc(sizeof(struct cppc_cpudata), GFP_KERNEL);
-		if (!all_cpu_data[i])
-			goto out;
-
-		cpu_data = all_cpu_data[i];
-		if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
-			goto out;
-	}
-
-	ret = acpi_get_psd_map(all_cpu_data);
-	if (ret) {
-		pr_debug("Error parsing PSD data. Aborting cpufreq registration.\n");
-		goto out;
-	}
+	INIT_LIST_HEAD(&cpu_data_list);
 
 	cppc_check_hisi_workaround();
 
-	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
-	if (ret)
-		goto out;
+	return cpufreq_register_driver(&cppc_cpufreq_driver);
+}
 
-	return ret;
+static inline void free_cpu_data(void)
+{
+	struct cppc_cpudata *iter, *tmp;
 
-out:
-	for_each_possible_cpu(i) {
-		cpu_data = all_cpu_data[i];
-		if (!cpu_data)
-			break;
-		free_cpumask_var(cpu_data->shared_cpu_map);
-		kfree(cpu_data);
+	list_for_each_entry_safe(iter, tmp, &cpu_data_list, node) {
+		free_cpumask_var(iter->shared_cpu_map);
+		list_del(&iter->node);
+		kfree(iter);
 	}
 
-	kfree(all_cpu_data);
-	return -ENODEV;
 }
 
 static void __exit cppc_cpufreq_exit(void)
 {
-	struct cppc_cpudata *cpu_data;
-	int i;
-
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 
-	for_each_possible_cpu(i) {
-		cpu_data = all_cpu_data[i];
-		free_cpumask_var(cpu_data->shared_cpu_map);
-		kfree(cpu_data);
-	}
-
-	kfree(all_cpu_data);
+	free_cpu_data();
 }
 
 module_exit(cppc_cpufreq_exit);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index a6a9373ab863..232838d28f50 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -124,11 +124,10 @@ struct cppc_perf_fb_ctrs {
 
 /* Per CPU container for runtime CPPC management. */
 struct cppc_cpudata {
-	int cpu;
+	struct list_head node;
 	struct cppc_perf_caps perf_caps;
 	struct cppc_perf_ctrls perf_ctrls;
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
-	struct cpufreq_policy *cur_policy;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
 };
@@ -137,7 +136,8 @@ extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
-extern int acpi_get_psd_map(struct cppc_cpudata **);
+extern bool acpi_cpc_valid(void);
+extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
 extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
-- 
2.29.2.dirty

