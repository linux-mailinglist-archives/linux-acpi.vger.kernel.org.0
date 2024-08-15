Return-Path: <linux-acpi+bounces-7590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EF9952B04
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 11:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D19B21194
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8EB1BCA02;
	Thu, 15 Aug 2024 08:30:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F9B19D09E;
	Thu, 15 Aug 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710600; cv=none; b=Z6PIW3Y1pW+sxYqWgBvOoI/lYMGqPJe3hfQy/AVML/YH09+RuJcx/K5cwClfQX7TdG6Q1vdtQ84uQ1nqAzX+tl5y+eQBRIAY++jaUPfuqSLa1szQWxnxRwTKkswt7Wmb2/ZiroOlGJqYuWmZLJDLN0M7/INQwUYVOV7Zk4xu5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710600; c=relaxed/simple;
	bh=jwyni+JvZIOku6vVjMN4zUjW3UUzN984UojAWvc/JYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qI/OqC3hI/gVHcVox12CpdGRHzOEZWKsmrNCPZpyuoq4ra2bZxQ0aZHAar+R2Dv3stJeGAq/Mj6oxk4hp/tvmEgkg3gCdC0rwPTj/dw0RFIi7X96VXChVyWo/Dz99hN33xf+AHWZ6uN9KUs9/UXETKPJVCLec4ECXfgsdV14+B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF9616A3;
	Thu, 15 Aug 2024 01:30:22 -0700 (PDT)
Received: from e126645.nice.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8416F3F6A8;
	Thu, 15 Aug 2024 01:29:51 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Robert Moore <robert.moore@intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	rust-for-linux@vger.kernel.org
Subject: [RFC PATCH 1/6] ACPI: CPPC: Move struct cppc_cpudata to cppc_cpufreq driver
Date: Thu, 15 Aug 2024 10:29:05 +0200
Message-Id: <20240815082916.1210110-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240815082916.1210110-1-pierre.gondois@arm.com>
References: <20240815082916.1210110-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `struct cppc_cpudata` is populated by the cppc_cpufreq driver.
Outside of the driver's code, it is only used acpi_get_psd_map().

To facilitate a re-implementation of the cppc_cpufreq driver
and its internal data structure in rust:
- Move the structure definition to the driver's code
- Udate acpi_get_psd_map() to take individual parameters instead

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/cppc_acpi.c       | 26 ++++++++++++++++----------
 drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
 include/acpi/cppc_acpi.h       | 13 ++-----------
 3 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d857978f5f4..b0fd141acb9d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -468,17 +468,23 @@ EXPORT_SYMBOL_GPL(cppc_allow_fast_switch);
 /**
  * acpi_get_psd_map - Map the CPUs in the freq domain of a given cpu
  * @cpu: Find all CPUs that share a domain with cpu.
- * @cpu_data: Pointer to CPU specific CPPC data including PSD info.
+ * @shared_cpu_map: cpumask to populate with CPUs belonging to the same _PSD
+ * domain.
+ * @shared_type: P-state coordination type for CPUs in the same _PSD as @cpu.
  *
  *	Return: 0 for success or negative value for err.
  */
-int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
+int acpi_get_psd_map(unsigned int cpu, cpumask_var_t shared_cpu_map,
+		     unsigned int *shared_type)
 {
 	struct cpc_desc *cpc_ptr, *match_cpc_ptr;
 	struct acpi_psd_package *match_pdomain;
 	struct acpi_psd_package *pdomain;
 	int count_target, i;
 
+	if (!shared_cpu_map || !shared_type)
+		return -EINVAL;
+
 	/*
 	 * Now that we have _PSD data from all CPUs, let's setup P-state
 	 * domain info.
@@ -488,18 +494,18 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
 		return -EFAULT;
 
 	pdomain = &(cpc_ptr->domain_info);
-	cpumask_set_cpu(cpu, cpu_data->shared_cpu_map);
+	cpumask_set_cpu(cpu, shared_cpu_map);
 	if (pdomain->num_processors <= 1)
 		return 0;
 
 	/* Validate the Domain info */
 	count_target = pdomain->num_processors;
 	if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
-		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+		*shared_type = CPUFREQ_SHARED_TYPE_ALL;
 	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
-		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_HW;
+		*shared_type = CPUFREQ_SHARED_TYPE_HW;
 	else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
-		cpu_data->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+		*shared_type = CPUFREQ_SHARED_TYPE_ANY;
 
 	for_each_possible_cpu(i) {
 		if (i == cpu)
@@ -520,16 +526,16 @@ int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data)
 		if (pdomain->coord_type != match_pdomain->coord_type)
 			goto err_fault;
 
-		cpumask_set_cpu(i, cpu_data->shared_cpu_map);
+		cpumask_set_cpu(i, shared_cpu_map);
 	}
 
 	return 0;
 
 err_fault:
 	/* Assume no coordination on any error parsing domain info */
-	cpumask_clear(cpu_data->shared_cpu_map);
-	cpumask_set_cpu(cpu, cpu_data->shared_cpu_map);
-	cpu_data->shared_type = CPUFREQ_SHARED_TYPE_NONE;
+	cpumask_clear(shared_cpu_map);
+	cpumask_set_cpu(cpu, shared_cpu_map);
+	*shared_type = CPUFREQ_SHARED_TYPE_NONE;
 
 	return -EFAULT;
 }
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 32780bb4e911..208d7b176fd0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -26,6 +26,16 @@
 
 #include <acpi/cppc_acpi.h>
 
+/* Per CPU container for runtime CPPC management. */
+struct cppc_cpudata {
+	struct list_head node;
+	struct cppc_perf_caps perf_caps;
+	struct cppc_perf_ctrls perf_ctrls;
+	struct cppc_perf_fb_ctrs perf_fb_ctrs;
+	unsigned int shared_type;
+	cpumask_var_t shared_cpu_map;
+};
+
 /*
  * This list contains information parsed from per CPU ACPI _CPC and _PSD
  * structures: e.g. the highest and lowest supported performance, capabilities,
@@ -572,7 +582,8 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 	if (!zalloc_cpumask_var(&cpu_data->shared_cpu_map, GFP_KERNEL))
 		goto free_cpu;
 
-	ret = acpi_get_psd_map(cpu, cpu_data);
+	ret = acpi_get_psd_map(cpu, cpu_data->shared_cpu_map,
+			       &cpu_data->shared_type);
 	if (ret) {
 		pr_debug("Err parsing CPU%d PSD data: ret:%d\n", cpu, ret);
 		goto free_mask;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 930b6afba6f4..5164aaca7eb0 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -126,16 +126,6 @@ struct cppc_perf_fb_ctrs {
 	u64 wraparound_time;
 };
 
-/* Per CPU container for runtime CPPC management. */
-struct cppc_cpudata {
-	struct list_head node;
-	struct cppc_perf_caps perf_caps;
-	struct cppc_perf_ctrls perf_ctrls;
-	struct cppc_perf_fb_ctrs perf_fb_ctrs;
-	unsigned int shared_type;
-	cpumask_var_t shared_cpu_map;
-};
-
 #ifdef CONFIG_ACPI_CPPC_LIB
 extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
@@ -149,7 +139,8 @@ extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int p
 extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
 extern bool acpi_cpc_valid(void);
 extern bool cppc_allow_fast_switch(void);
-extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
+extern int acpi_get_psd_map(unsigned int cpu, cpumask_var_t shared_cpu_map,
+			    unsigned int *shared_type);
 extern unsigned int cppc_get_transition_latency(int cpu);
 extern bool cpc_ffh_supported(void);
 extern bool cpc_supported_by_cpu(void);
-- 
2.25.1


