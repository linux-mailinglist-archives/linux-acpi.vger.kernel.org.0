Return-Path: <linux-acpi+bounces-20971-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNe2NJj4jmnbGAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20971-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 11:10:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC0C134E5A
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F188130138D6
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D034FF59;
	Fri, 13 Feb 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="j9g1yxWj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA6EEAB;
	Fri, 13 Feb 2026 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977387; cv=none; b=uJWum1aUOZ2+NRIfHV/bIphfdhfIwF+uawOML/vljdngI6ACIC/FI2w7oPWFI12GTVq93ZEJzf1vt5Yv4427M5BDxcSzbGqK1712t4VuOEDZOXfwJwWhlh12GZhqgGiSUcBPCxwNx2g/XW0ksN45VscRGbJGZ8Z4Np3NAsKtdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977387; c=relaxed/simple;
	bh=Nn7mpqy84j7r4o94j+tLNNLq6ei9856SBxkLdcCAOOs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCjcGplstKNUCsdrbMRVl1cFznQm5SMdF49xxzyyL1KoYHLUuAWkWgiLzlkfXVHS1ka+i/aPz6V7APInf8H3Y99CBBjpVAo6m54jGQjoGWQzIOhwFv93OtYp9XmC0c8c6svJeodskpKUkYZW0eEzLjKgPdA77x+uxJGUba14W3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=j9g1yxWj; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SZ6Z3f33YNTvJD8jc9k97ue8D159LKUqhh9nY7ZJwWQ=;
	b=j9g1yxWjicYH0bdn/pD6A5aVpsOZbtyZpCRndIRNFC3gSQyblZ9L2XyvKvKWKhgMCbeL3Nequ
	eOkeP7aUfEUoVfG8ZnxOvsqyv22CZE29O6TRfbwYRe5/Jzl4DnI68WYdEyHz+K2/bruaf2JClxw
	V/rFI5P0erXMl83ZdecNiV4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4fC77q6p9tzmV74;
	Fri, 13 Feb 2026 18:04:55 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 700BA4048B;
	Fri, 13 Feb 2026 18:09:36 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Feb
 2026 18:09:35 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <viresh.kumar@linaro.org>,
	<robert.moore@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH v2] ACPI: CPPC: Move reference performance to capabilities
Date: Fri, 13 Feb 2026 18:09:35 +0800
Message-ID: <20260213100935.19111-1-zhangpengjie2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr200004.china.huawei.com (7.202.195.241)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangpengjie2@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-20971-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+]
X-Rspamd-Queue-Id: 0BC0C134E5A
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
changes in v2:
-Adapted the code to the new integration.
Link to v1:https://lore.kernel.org/all/20260129112105.2511748-1-zhangpengjie2@huawei.com/
---
 drivers/acpi/cppc_acpi.c       | 55 +++++++++++++++-------------------
 drivers/cpufreq/cppc_cpufreq.c | 21 +++++++------
 include/acpi/cppc_acpi.h       |  2 +-
 3 files changed, 37 insertions(+), 41 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a09bdabaa804..db1da8717078 100644
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
@@ -1432,20 +1446,10 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
 bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *ref_perf_reg;
-
-	/*
-	 * If reference perf register is not supported then we should use the
-	 * nominal perf value
-	 */
-	ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
-	if (!CPC_SUPPORTED(ref_perf_reg))
-		ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
 
 	return CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
 		CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
-		CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
-		CPC_IN_PCC(ref_perf_reg);
+		CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]);
 }
 EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
 
@@ -1482,10 +1486,10 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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
@@ -1495,19 +1499,11 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 
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
@@ -1524,8 +1520,6 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
 
 	cpc_read(cpunum, delivered_reg, &delivered);
 	cpc_read(cpunum, reference_reg, &reference);
-	cpc_read(cpunum, ref_perf_reg, &ref_perf);
-
 	/*
 	 * Per spec, if ctr_wrap_time optional register is unsupported, then the
 	 * performance counters are assumed to never wrap during the lifetime of
@@ -1535,14 +1529,13 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
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
index 7e8042efedd1..befcbded126a 100644
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
@@ -70,7 +71,7 @@ static void __cppc_scale_freq_tick(struct cppc_freq_invariance *cppc_fi)
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};
 	struct cppc_cpudata *cpu_data;
 	unsigned long local_freq_scale;
-	u64 perf;
+	u64 perf, ref_perf;
 
 	cpu_data = cppc_fi->cpu_data;
 
@@ -79,7 +80,9 @@ static void __cppc_scale_freq_tick(struct cppc_freq_invariance *cppc_fi)
 		return;
 	}
 
-	perf = cppc_perf_from_fbctrs(&cppc_fi->prev_perf_fb_ctrs, &fb_ctrs);
+	ref_perf = cpu_data->perf_caps.reference_perf;
+	perf = cppc_perf_from_fbctrs(ref_perf,
+				     &cppc_fi->prev_perf_fb_ctrs, &fb_ctrs);
 	if (!perf)
 		return;
 
@@ -723,13 +726,11 @@ static inline u64 get_delta(u64 t1, u64 t0)
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
@@ -766,7 +767,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpu);
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
 	struct cppc_cpudata *cpu_data;
-	u64 delivered_perf;
+	u64 delivered_perf, reference_perf;
 	int ret;
 
 	if (!policy)
@@ -783,7 +784,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 			return 0;
 	}
 
-	delivered_perf = cppc_perf_from_fbctrs(&fb_ctrs_t0, &fb_ctrs_t1);
+	reference_perf = cpu_data->perf_caps.reference_perf;
+	delivered_perf = cppc_perf_from_fbctrs(reference_perf,
+					       &fb_ctrs_t0, &fb_ctrs_t1);
 	if (!delivered_perf)
 		goto out_invalid_counters;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4d644f03098e..d3c4999e3551 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -116,6 +116,7 @@ struct cppc_perf_caps {
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


