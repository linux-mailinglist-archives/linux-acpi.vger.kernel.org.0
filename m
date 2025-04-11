Return-Path: <linux-acpi+bounces-12971-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A6BA85824
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 11:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EAA4C5767
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 09:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586B29B219;
	Fri, 11 Apr 2025 09:39:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3072989BF;
	Fri, 11 Apr 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364346; cv=none; b=pIvdADAvvPmfzUX0T8uDAkR/LswMyUuEuJzRmNWmji3RLTCNc5ykWBLukFd2flpm+aah3s0ElfUJVPPtQ3LiWaU0fEhpGueQiOJpI8OvwFgFm0BgbP3X+pQ2KKrWDpu/su8uSQRK+NVi5Al66N5Pr/hAI3fc/xr7LIvQ2f3jof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364346; c=relaxed/simple;
	bh=L016lD/eoONcRqk5z0rANUxO3sx+Cr1+TXV5sochdnU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaGeIIxFLNQ4fyQakLL9UW/ZV1GwSLOhg/L0NUc6hpCJii6VeeKdfoV5NSfS6Y1zeaUSWWRlqK10flXJhaREFdIbGtYZDKh9Y8dPG96ujrmbFWW8H8V3cZ1+TEfAoOn89fy/hM0jirJpYobkvDPsRLmLvZuKm6/SFKUkaDPPaqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZYs8t5vX2z27hS3;
	Fri, 11 Apr 2025 17:39:42 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id ED00218001B;
	Fri, 11 Apr 2025 17:39:01 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Apr 2025 17:39:01 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <perry.yuan@amd.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <zhenglifeng1@huawei.com>, <hepeng68@huawei.com>
Subject: [PATCH v7 7/8] ACPI: CPPC: Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel()
Date: Fri, 11 Apr 2025 17:38:54 +0800
Message-ID: <20250411093855.982491-8-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250411093855.982491-1-zhenglifeng1@huawei.com>
References: <20250411093855.982491-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Modify cppc_get_auto_sel_caps() to cppc_get_auto_sel(). Using a
cppc_perf_caps to carry the value is unnecessary.

Add a check to ensure the pointer 'enable' is not null.

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c     | 18 +++++++++++-------
 drivers/cpufreq/amd-pstate.c |  3 ++-
 include/acpi/cppc_acpi.h     |  6 +++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4863e2dc68e..79553ce74c47 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1612,23 +1612,27 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
 
 /**
- * cppc_get_auto_sel_caps - Read autonomous selection register.
- * @cpunum : CPU from which to read register.
- * @perf_caps : struct where autonomous selection register value is updated.
+ * cppc_get_auto_sel() - Read autonomous selection register.
+ * @cpu: CPU from which to read register.
+ * @enable: Return address.
  */
-int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+int cppc_get_auto_sel(int cpu, bool *enable)
 {
 	u64 auto_sel;
 	int ret;
 
-	ret = cppc_get_reg_val(cpunum, AUTO_SEL_ENABLE, &auto_sel);
+	if (enable == NULL)
+		return -EINVAL;
+
+	ret = cppc_get_reg_val(cpu, AUTO_SEL_ENABLE, &auto_sel);
 	if (ret)
 		return ret;
 
-	perf_caps->auto_sel = (bool)auto_sel;
+	*enable = (bool)auto_sel;
+
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
+EXPORT_SYMBOL_GPL(cppc_get_auto_sel);
 
 /**
  * cppc_set_auto_sel - Write autonomous selection register.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6789eed1bb5b..9cd54d8630cd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -417,6 +417,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	struct cppc_perf_caps cppc_perf;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 numerator;
+	bool auto_sel;
 
 	int ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
 	if (ret)
@@ -438,7 +439,7 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	if (cppc_state == AMD_PSTATE_ACTIVE)
 		return 0;
 
-	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
+	ret = cppc_get_auto_sel(cpudata->cpu, &auto_sel);
 	if (ret) {
 		pr_warn("failed to get auto_sel, ret: %d\n", ret);
 		return 0;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 62d368bcd9ec..31767c65be20 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -159,7 +159,7 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
 extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
-extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
+extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
@@ -229,11 +229,11 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_set_auto_sel(int cpu, bool enable)
+static inline int cppc_get_auto_sel(int cpu, bool *enable)
 {
 	return -EOPNOTSUPP;
 }
-static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.33.0


