Return-Path: <linux-acpi+bounces-19397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6438C9DA3C
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 04:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A49984E06B1
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75073250C06;
	Wed,  3 Dec 2025 03:25:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077BE23BD1B;
	Wed,  3 Dec 2025 03:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732334; cv=none; b=pNjMAmI7r0fbyiLKPxNw+4OkS/mOCLmEEuqUd9ml2o/HC9z5f9aeUYlNjpaloS0ZJ4HCEPkvOOWRH763mXRDWk4uQ/FWU9RQ5jCRSRIE1IjG+tdhVp2LnWZn5HA8Z5ORxMMcKP48m3vEgqeto1F0iqCZHYKiAN5RIup0TV+XxLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732334; c=relaxed/simple;
	bh=MeCorG1WDa1qY/vwoV29oADnRR/0jw8sasf0MZ0hsrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FfrB79qoc3jkMtEQTgfzx+Fv5uGacUAkhOPFCFLGgQCjvr5tshGrsPajPrB1RG2yrgGMVtEAR0LTCSvMqx2Lur/bmr/pfou7zkWz4V5HR6ZlSUUvNDLat6JO/c8aHkQmxKwslloCEtQK3vj23U1ykrxSJn3RE8WvxufcYxRA7mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dLjdv1WXYz1cyNt;
	Wed,  3 Dec 2025 11:23:31 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 92B69140278;
	Wed,  3 Dec 2025 11:25:23 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Dec 2025 11:25:22 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v4 1/3] ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
Date: Wed, 3 Dec 2025 11:24:20 +0800
Message-ID: <20251203032422.3232957-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Factor out cppc_perf_ctrs_in_pcc_cpu() for checking whether per-cpu CPC
regs are defined in PCC channels, and export it out for further use.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++-------------------
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3bdeeee3414e..aa80dbcf42c0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1422,6 +1422,29 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
 
+bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *ref_perf_reg;
+
+	/*
+	 * If reference perf register is not supported then we should use the
+	 * nominal perf value
+	 */
+	ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
+	if (!CPC_SUPPORTED(ref_perf_reg))
+		ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
+
+	if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
+	    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
+	    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
+	    CPC_IN_PCC(ref_perf_reg))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
+
 /**
  * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
  *
@@ -1436,27 +1459,7 @@ bool cppc_perf_ctrs_in_pcc(void)
 	int cpu;
 
 	for_each_online_cpu(cpu) {
-		struct cpc_register_resource *ref_perf_reg;
-		struct cpc_desc *cpc_desc;
-
-		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-
-		if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
-		    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
-		    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
-			return true;
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
+		if (cppc_perf_ctrs_in_pcc_cpu(cpu))
 			return true;
 	}
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 13fa81504844..4bcdcaf8bf2c 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -154,6 +154,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_set_enable(int cpu, bool enable);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
+extern bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu);
 extern bool cppc_perf_ctrs_in_pcc(void);
 extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int perf);
 extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int freq);
@@ -204,6 +205,10 @@ static inline int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps)
 {
 	return -EOPNOTSUPP;
 }
+static inline bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
+{
+	return false;
+}
 static inline bool cppc_perf_ctrs_in_pcc(void)
 {
 	return false;
-- 
2.33.0


