Return-Path: <linux-acpi+bounces-8552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C702098F906
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 23:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6061F21FC5
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Oct 2024 21:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DF1BE871;
	Thu,  3 Oct 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Humini+I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31521748D
	for <linux-acpi@vger.kernel.org>; Thu,  3 Oct 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991497; cv=none; b=pqf1dsKFwPKoVQIzIMvEVwksrYVdalf+wb3mzCF+J22OG9qKmeoWUcgFhJEOQOL6v4UdAk5kNLyXttZRhz0D5bKPgmKqjUlvnsnaBbFx2earv96r9vn8VvAm7e8jUmbqp/nF1zn7G2i4KWvywR9T/dsLYeynqYi+gdFZ9od3wZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991497; c=relaxed/simple;
	bh=wH9oVQ2Y8r4ulDxhmJrVCFo5jjJG3H0Xddr9zIjloq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlpqTFwjxJHVNEXjJqAkCktj+rNUzkemP6CsyC2AOTcjkIJXeehkq8zUYEdoXG6cZ959ZNHoijkIcNMfEskm0DjLsSJYoVcNPUmegzgboMefMxthJRADTSy/9r+8p+QSusLZ2yHyZNrQtrbHgezm3A7zia1XaFOvhKHJ8Pjqel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Humini+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F207C4CED1;
	Thu,  3 Oct 2024 21:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727991496;
	bh=wH9oVQ2Y8r4ulDxhmJrVCFo5jjJG3H0Xddr9zIjloq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Humini+I5cmUFVNPe35q5wSNssV6rfbrjcoZ4qnxnFEG05bjn1AIN3WcGp3J9UBNa
	 mzAASiAJVOmhEdYi9qJJd7uV/f6RfdVxlTakAgR5w6teFd2FcUopxCWRMgWmavmU1m
	 6EdFumt1R36Oz8mJJVJBXZctudcESQr+dFV4DycLbu4/HUHA9OpgI2UQA3fuXr4FfB
	 Uq+kPS9Pnn+Upd1dmQOyTjOYez5DmmH7DnyF0nN2SrWBuH84b31QUDyy0dHf618qbA
	 jMUzlXlRjq4p4roOTfXV2c/DqGfAG9+EhUKuNjDems+0JrXx/4AdtjXYKU0iWQw1kK
	 Puz7drjbDn+2Q==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org,
	linux-acpi@vger.kernel.org,
	Perry Yuan <perry.yuan@amd.com>,
	gautham.shenoy@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] CPPC: Use heterogeneous core topology for identifying boost numerator
Date: Thu,  3 Oct 2024 16:37:59 -0500
Message-ID: <20241003213759.3038862-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003213759.3038862-1-superm1@kernel.org>
References: <20241003213759.3038862-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

AMD heterogeneous designs include two types of cores:
 * Performance
 * Efficiency

Each core type has different highest performance values configured by the
platform.  Drivers such as `amd_pstate` need to identify the type of
core to correctly set an appropriate boost numerator to calculate the
maximum frequency.

X86_FEATURE_HETERO_CORE_TOPOLOGY is used to identify whether the SoC
supports heterogeneous core type by reading CPUID leaf Fn_0x80000026.

On performance cores the scaling factor of 196 is used.  On efficiency
cores the scaling factor is the value reported as the highest perf.
Efficiency cores have the same preferred core rankings.

Suggested-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/include/asm/processor.h | 13 +++++++++++++
 arch/x86/kernel/acpi/cppc.c      | 30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/amd.c        | 29 +++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf..d81a6efa81bb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -691,6 +691,14 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 	return per_cpu(cpu_info.topo.l2c_id, cpu);
 }
 
+/* defined by CPUID_Fn80000026_EBX BIT [31:28] */
+enum amd_core_type {
+	CPU_CORE_TYPE_NO_HETERO_SUP = -1,
+	CPU_CORE_TYPE_PERFORMANCE = 0,
+	CPU_CORE_TYPE_EFFICIENCY = 1,
+	CPU_CORE_TYPE_UNDEFINED = 2,
+};
+
 #ifdef CONFIG_CPU_SUP_AMD
 /*
  * Issue a DIV 0/1 insn to clear any division data from previous DIV
@@ -703,9 +711,14 @@ static __always_inline void amd_clear_divider(void)
 }
 
 extern void amd_check_microcode(void);
+extern enum amd_core_type amd_get_core_type(void);
 #else
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
+static inline enum amd_core_type amd_get_core_type(void)
+{
+	return CPU_CORE_TYPE_NO_HETERO_SUP;
+}
 #endif
 
 extern unsigned long arch_align_stack(unsigned long sp);
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 956984054bf3..ca289e6ec82c 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -217,6 +217,12 @@ int amd_detect_prefcore(bool *detected)
 }
 EXPORT_SYMBOL_GPL(amd_detect_prefcore);
 
+static void amd_do_get_core_type(void *data)
+{
+	enum amd_core_type *core_type = data;
+	*core_type = amd_get_core_type();
+}
+
 /**
  * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
  * @cpu: CPU to get numerator for.
@@ -234,7 +240,9 @@ EXPORT_SYMBOL_GPL(amd_detect_prefcore);
  */
 int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 {
+	enum amd_core_type core_type;
 	bool prefcore;
+	u32 tmp;
 	int ret;
 
 	ret = amd_detect_prefcore(&prefcore);
@@ -261,6 +269,28 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 			break;
 		}
 	}
+
+	/* detect if running on heterogeneous design */
+	smp_call_function_single(cpu, amd_do_get_core_type, &core_type, 1);
+	switch (core_type) {
+	case CPU_CORE_TYPE_NO_HETERO_SUP:
+		break;
+	case CPU_CORE_TYPE_PERFORMANCE:
+		/* use the max scale for performance cores */
+		*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
+		return 0;
+	case CPU_CORE_TYPE_EFFICIENCY:
+		/* use the highest perf value for efficiency cores */
+		ret = amd_get_highest_perf(cpu, &tmp);
+		if (ret)
+			return ret;
+		*numerator = tmp;
+		return 0;
+	default:
+		pr_warn("WARNING: Undefined core type %d found\n", core_type);
+		break;
+	}
+
 	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 015971adadfc..8ad5f1385f0e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1204,3 +1204,32 @@ void amd_check_microcode(void)
 
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
+
+/**
+ * amd_get_core_type - Heterogeneous core type identification
+ *
+ * Returns the CPU type [31:28] (i.e., performance or efficient) of
+ * a CPU in the processor.
+ *
+ * If the processor has no core type support, returns
+ * CPU_CORE_TYPE_NO_HETERO_SUP.
+ */
+enum amd_core_type amd_get_core_type(void)
+{
+	struct {
+		u32  num_processors             :16,
+		     power_efficiency_ranking   :8,
+		     native_model_id            :4,
+		     core_type                  :4;
+	} props;
+
+	if (!cpu_feature_enabled(X86_FEATURE_HETERO_CORE_TOPOLOGY))
+		return CPU_CORE_TYPE_NO_HETERO_SUP;
+
+	cpuid_leaf_reg(0x80000026, CPUID_EBX, &props);
+	if (props.core_type >= CPU_CORE_TYPE_UNDEFINED)
+		return CPU_CORE_TYPE_UNDEFINED;
+
+	return props.core_type;
+}
+EXPORT_SYMBOL_GPL(amd_get_core_type);
-- 
2.43.0


