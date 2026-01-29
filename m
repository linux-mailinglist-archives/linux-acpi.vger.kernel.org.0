Return-Path: <linux-acpi+bounces-20763-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLRiNLRCe2n6CwIAu9opvQ
	(envelope-from <linux-acpi+bounces-20763-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 12:21:24 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EA935AF90C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52C9E300159E
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB11385505;
	Thu, 29 Jan 2026 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MIigh4Nx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781C33F8C6;
	Thu, 29 Jan 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685678; cv=none; b=F3CfB8Ee18ga6t5wOOqX8S7uEyKEXnahDycIfwwYz6wt4OObqwgjZ6PM38M92KeEGTIvttlZugic173nmIc4AYGwvz0Zfd+Xxw23J/uzf3jsjuR7uguisocE3pfxXHAD51zXAiu9s6TgwOljNQzjA9wc3RkaLyNHinsDyPV6/Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685678; c=relaxed/simple;
	bh=PTHdOC/2u0HARHpH6dVwNTlez2bWqjnvXYzMqUnzC3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=px11MDcmxkTNSnAFMOB9QtsFPU53q6hAdHqfNMvg4UQshkypSDN+ZZ7Q5IM50JPsl//HXRxNyTDYYBLA2wxxKfNqy7wxWJGGn7PzCluyeO/WjVR8QDQB7A2g2Ri0LfCK+jNJGOxFupaOTig2sUhRyLK1Ioy2hcJ31+ZQj2+fIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MIigh4Nx; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EZRpp77HytR0PUe3OSD6TBzO+l8szB7m4ti/mVeAWw4=;
	b=MIigh4Nx5x89QpbjF2ltaVUTjEKkkoPpF0vo2dM16IuHxDMCvNGRNuRGsi/GZRr+S7yW7MQwN
	F6uzf7b3XqWHEKrsNbX1dxQTOTSZ3qbvTWERB/RXZPdG5d2ItEnHkNE4SKwLs+Rn1P4nYsOyE9c
	flXfuzEO9M47JS/+2NPr1gw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f1xSh184cz1K97P;
	Thu, 29 Jan 2026 19:17:40 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id B61BA40565;
	Thu, 29 Jan 2026 19:21:06 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Jan
 2026 19:21:05 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <viresh.kumar@linaro.org>,
	<robert.moore@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH] ACPI: CPPC: Move reference performance to capabilities
Date: Thu, 29 Jan 2026 19:21:05 +0800
Message-ID: <20260129112105.2511748-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr200004.china.huawei.com (7.202.195.241)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20763-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangpengjie2@huawei.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: EA935AF90C
X-Rspamd-Action: no action

Currently, the `Reference Performance` register is read every time
the CPU frequency is sampled in `cppc_get_perf_ctrs()`. This function
is on the hot path of the cpufreq driver.

Reference Performance indicates the performance level that corresponds
to the Reference Counter incrementing and is not expected to change
dynamically during runtime (unlike the Delivered and Reference counters).

Reading this register in the hot path incurs unnecessary overhead,
particularly on platforms where CPC registers are located in the PCC
(Platform Communication Channel) subspace. This patch moves
`reference_perf` from the dynamic feedback counters structure
(`cppc_perf_fb_ctrs`) to the static capabilities structure
(`cppc_perf_caps`).

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/acpi/cppc_acpi.c       | 57 ++++++++++++++--------------------
 drivers/cpufreq/cppc_cpufreq.c | 21 +++++++------
 include/acpi/cppc_acpi.h       |  2 +-
 3 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e66e20d1f31b..7573ec1cf5f7 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -177,12 +177,12 @@ __ATTR(_name, 0444, show_##_name, NULL)
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, highest_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_perf);
+show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, reference_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_nonlinear_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, guaranteed_perf);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, lowest_freq);
 show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, nominal_freq);
 
-show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
 /* Check for valid access_width, otherwise, fallback to using bit_width */
@@ -1343,9 +1343,10 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *highest_reg, *lowest_reg,
-		*lowest_non_linear_reg, *nominal_reg, *guaranteed_reg,
-		*low_freq_reg = NULL, *nom_freq_reg = NULL;
-	u64 high, low, guaranteed, nom, min_nonlinear, low_f = 0, nom_f = 0;
+		*lowest_non_linear_reg, *nominal_reg, *reference_reg,
+		*guaranteed_reg, *low_freq_reg = NULL, *nom_freq_reg = NULL;
+	u64 high, low, guaranteed, nom, ref, min_nonlinear,
+	    low_f = 0, nom_f = 0;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
 	int ret = 0, regs_in_pcc = 0;
@@ -1359,6 +1360,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
 	lowest_non_linear_reg = &cpc_desc->cpc_regs[LOW_NON_LINEAR_PERF];
 	nominal_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
+	reference_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
 	low_freq_reg = &cpc_desc->cpc_regs[LOWEST_FREQ];
 	nom_freq_reg = &cpc_desc->cpc_regs[NOMINAL_FREQ];
 	guaranteed_reg = &cpc_desc->cpc_regs[GUARANTEED_PERF];
@@ -1366,6 +1368,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	/* Are any of the regs PCC ?*/
 	if (CPC_IN_PCC(highest_reg) || CPC_IN_PCC(lowest_reg) ||
 		CPC_IN_PCC(lowest_non_linear_reg) || CPC_IN_PCC(nominal_reg) ||
+		(CPC_SUPPORTED(reference_reg) && CPC_IN_PCC(reference_reg)) ||
 		CPC_IN_PCC(low_freq_reg) || CPC_IN_PCC(nom_freq_reg) ||
 		CPC_IN_PCC(guaranteed_reg)) {
 		if (pcc_ss_id < 0) {
@@ -1391,6 +1394,17 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	cpc_read(cpunum, nominal_reg, &nom);
 	perf_caps->nominal_perf = nom;
 
+	/*
+	 * If reference perf register is not supported then we should
+	 * use the nominal perf value
+	 */
+	if (CPC_SUPPORTED(reference_reg)) {
+		cpc_read(cpunum, reference_reg, &ref);
+		perf_caps->reference_perf = ref;
+	} else {
+		perf_caps->reference_perf = nom;
+	}
+
 	if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
 	    IS_NULL_REG(&guaranteed_reg->cpc_entry.reg)) {
 		perf_caps->guaranteed_perf = 0;
@@ -1402,7 +1416,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 	cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;
 
-	if (!high || !low || !nom || !min_nonlinear)
+	if (!high || !low || !nom || !ref || !min_nonlinear)
 		ret = -EFAULT;
 
 	/* Read optional lowest and nominal frequencies if present */
@@ -1437,7 +1451,6 @@ bool cppc_perf_ctrs_in_pcc(void)
 	int cpu;
 
 	for_each_online_cpu(cpu) {
-		struct cpc_register_resource *ref_perf_reg;
 		struct cpc_desc *cpc_desc;
 
 		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
@@ -1446,19 +1459,6 @@ bool cppc_perf_ctrs_in_pcc(void)
 		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
 		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
 			return true;
-
-
-		ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
-
-		/*
-		 * If reference perf register is not supported then we should
-		 * use the nominal perf value
-		 */
-		if (!CPC_SUPPORTED(ref_perf_reg))
-			ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
-
-		if (CPC_IN_PCC(ref_perf_reg))
-			return true;
 	}
 
 	return false;
@@ -1476,10 +1476,10 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *delivered_reg, *reference_reg,
-		*ref_perf_reg, *ctr_wrap_reg;
+		*ctr_wrap_reg;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
-	u64 delivered, reference, ref_perf, ctr_wrap_time;
+	u64 delivered, reference, ctr_wrap_time;
 	int ret = 0, regs_in_pcc = 0;
 
 	if (!cpc_desc) {
@@ -1489,19 +1489,11 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 
 	delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
 	reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
-	ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
 	ctr_wrap_reg = &cpc_desc->cpc_regs[CTR_WRAP_TIME];
 
-	/*
-	 * If reference perf register is not supported then we should
-	 * use the nominal perf value
-	 */
-	if (!CPC_SUPPORTED(ref_perf_reg))
-		ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
-
 	/* Are any of the regs PCC ?*/
 	if (CPC_IN_PCC(delivered_reg) || CPC_IN_PCC(reference_reg) ||
-		CPC_IN_PCC(ctr_wrap_reg) || CPC_IN_PCC(ref_perf_reg)) {
+		CPC_IN_PCC(ctr_wrap_reg)) {
 		if (pcc_ss_id < 0) {
 			pr_debug("Invalid pcc_ss_id\n");
 			return -ENODEV;
@@ -1518,8 +1510,6 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 
 	cpc_read(cpunum, delivered_reg, &delivered);
 	cpc_read(cpunum, reference_reg, &reference);
-	cpc_read(cpunum, ref_perf_reg, &ref_perf);
-
 	/*
 	 * Per spec, if ctr_wrap_time optional register is unsupported, then the
 	 * performance counters are assumed to never wrap during the lifetime of
@@ -1529,14 +1519,13 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 	if (CPC_SUPPORTED(ctr_wrap_reg))
 		cpc_read(cpunum, ctr_wrap_reg, &ctr_wrap_time);
 
-	if (!delivered || !reference ||	!ref_perf) {
+	if (!delivered || !reference) {
 		ret = -EFAULT;
 		goto out_err;
 	}
 
 	perf_fb_ctrs->delivered = delivered;
 	perf_fb_ctrs->reference = reference;
-	perf_fb_ctrs->reference_perf = ref_perf;
 	perf_fb_ctrs->wraparound_time = ctr_wrap_time;
 out_err:
 	if (regs_in_pcc)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9eac77c4f294..90dafb43ab18 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -50,7 +50,8 @@ struct cppc_freq_invariance {
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
 static struct kthread_worker *kworker_fie;
 
-static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+static int cppc_perf_from_fbctrs(u64 reference_perf,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
 
 /**
@@ -76,7 +77,7 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};
 	struct cppc_cpudata *cpu_data;
 	unsigned long local_freq_scale;
-	u64 perf;
+	u64 perf, ref_perf;
 
 	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
 	cpu_data = cppc_fi->cpu_data;
@@ -86,7 +87,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 		return;
 	}
 
-	perf = cppc_perf_from_fbctrs(&cppc_fi->prev_perf_fb_ctrs, &fb_ctrs);
+	ref_perf = cpu_data->perf_caps.reference_perf;
+	perf = cppc_perf_from_fbctrs(ref_perf,
+				     &cppc_fi->prev_perf_fb_ctrs, &fb_ctrs);
 	if (!perf)
 		return;
 
@@ -691,13 +694,11 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+static int cppc_perf_from_fbctrs(u64 reference_perf,
+				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf;
-
-	reference_perf = fb_ctrs_t0->reference_perf;
 
 	delta_reference = get_delta(fb_ctrs_t1->reference,
 				    fb_ctrs_t0->reference);
@@ -734,7 +735,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
 	struct cppc_cpudata *cpu_data;
-	u64 delivered_perf;
+	u64 delivered_perf, reference_perf;
 	int ret;
 
 	if (!policy)
@@ -751,7 +752,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 			return 0;
 	}
 
-	delivered_perf = cppc_perf_from_fbctrs(&fb_ctrs_t0, &fb_ctrs_t1);
+	reference_perf = cpu_data->perf_caps.reference_perf;
+	delivered_perf = cppc_perf_from_fbctrs(reference_perf,
+					       &fb_ctrs_t0, &fb_ctrs_t1);
 	if (!delivered_perf)
 		goto out_invalid_counters;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 13fa81504844..1f7e5f164795 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -115,6 +115,7 @@ struct cppc_perf_caps {
 	u32 guaranteed_perf;
 	u32 highest_perf;
 	u32 nominal_perf;
+	u32 reference_perf;
 	u32 lowest_perf;
 	u32 lowest_nonlinear_perf;
 	u32 lowest_freq;
@@ -133,7 +134,6 @@ struct cppc_perf_ctrls {
 struct cppc_perf_fb_ctrs {
 	u64 reference;
 	u64 delivered;
-	u64 reference_perf;
 	u64 wraparound_time;
 };
 
-- 
2.33.0


