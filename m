Return-Path: <linux-acpi+bounces-19797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2106BCD860D
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 08:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD6D3024E53
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA230AD15;
	Tue, 23 Dec 2025 07:23:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692F309F00;
	Tue, 23 Dec 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766474629; cv=none; b=lVhpciqK7HM8twG2bHnCD4yhsaZ+swhhssm+CGdFV/B3yLS9/kmK2raLgabg6/Cys8HHqxf1hCkQg2ts9DqM6AOtg+0DMyeQ4iE8pAWqWpVsN5bho9ABnjGiNCQw3fUxHf93KWBZMpnfpqNLHU+jDeVkuKNucTJiXbRnwjAY0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766474629; c=relaxed/simple;
	bh=tAKBzYW56ZrFMJfQlH//OXo9v1JLLXnTwlw1OiGBtfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojtohsZB/+Wo3ldFmPdgUR10JQjx3iDKo+SQNsijXKsjEBIyOJUlI+iC+k9BVc4V02ZJSNf8DUryC7uWmrgpysg1ftuT1WTtnLz3eTfir9n5zDqWPWcSVVQfhUs0BROFqrMxhqe0j19/lqokppFJI0QHeEEJbdnMG9uKDu+JL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4db5yN6jGKzpStQ;
	Tue, 23 Dec 2025 15:20:44 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 81F2340567;
	Tue, 23 Dec 2025 15:23:39 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 15:23:38 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v5 1/3] ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
Date: Tue, 23 Dec 2025 15:21:17 +0800
Message-ID: <20251223072119.3372582-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251223072119.3372582-1-zhanjie9@hisilicon.com>
References: <20251223072119.3372582-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Factor out cppc_perf_ctrs_in_pcc_cpu() for checking whether per-cpu CPC
regs are defined in PCC channels, and export it out for further use.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++------------------
 include/acpi/cppc_acpi.h |  5 +++++
 2 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index e66e20d1f31b..22d7fd669a6c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1423,6 +1423,32 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 }
 EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
 
+/**
+ * cppc_perf_ctrs_in_pcc_cpu - Check if any perf counters of a CPU are in PCC.
+ * @cpu: CPU on which to check perf counters.
+ *
+ * Return: true if any of the counters are in PCC regions, false otherwise
+ */
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
+	return CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
+		CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
+		CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
+		CPC_IN_PCC(ref_perf_reg);
+}
+EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
+
 /**
  * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC region.
  *
@@ -1437,27 +1463,7 @@ bool cppc_perf_ctrs_in_pcc(void)
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


