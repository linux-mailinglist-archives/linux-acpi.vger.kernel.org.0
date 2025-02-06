Return-Path: <linux-acpi+bounces-10909-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AB1A2A958
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 980E57A39CB
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4683236A6B;
	Thu,  6 Feb 2025 13:14:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33D235C0B;
	Thu,  6 Feb 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847676; cv=none; b=h3NHmGgoi6Ou5tEkQGRVO4YP06RjYRtLJyvJP6C1BZ9+U3YomiUDaF75gIWep7UnBV6ZZbhVloMIqSH39mAp8tztsfKKjRa4hUYpMSwzfhn4aahDacEntEpAuNe2xynx40Z5BEDkHHJyg9aaXse5p3jgWHq0FxYzFM6nqryyFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847676; c=relaxed/simple;
	bh=LFINFwZDTcrxNkgzrOQp7NsOqsxtGzH4BfLLw8dn9m8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1HShFIMx8zombDYbMJgocvXfJSPt9DZ++fNYZGu74WwgqaQmB/IyXSV/VWWaSlxSYkVm1ol5PVAHBZWejk5rSZrwhX4rzgX/R2U6V8J3/cV1Aacu/81LXchVayHFmXn28+ydPvgg/sagiazF3Hr8dT5Ig9KA1EobQSqO/rIg5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ypct51Y3sz1V65F;
	Thu,  6 Feb 2025 21:10:53 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2ACC91A016C;
	Thu,  6 Feb 2025 21:14:32 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 21:14:31 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <yumpusamongus@gmail.com>,
	<srinivas.pandruvada@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v5 3/8] ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
Date: Thu, 6 Feb 2025 21:14:23 +0800
Message-ID: <20250206131428.3261578-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
cppc registers. And extract the operations if register is in pcc out as
cppc_get_reg_val_in_pcc(). Without functional change.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 66 +++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index db22f8f107db..3c9c4ce2a0b0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1189,48 +1189,52 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
-static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
+static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
 {
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
-	struct cpc_register_resource *reg;
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret;
 
-	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+	if (pcc_ss_id < 0) {
+		pr_debug("Invalid pcc_ss_id\n");
 		return -ENODEV;
 	}
 
-	reg = &cpc_desc->cpc_regs[reg_idx];
+	pcc_ss_data = pcc_data[pcc_ss_id];
 
-	if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
-		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
-		return -EOPNOTSUPP;
-	}
+	down_write(&pcc_ss_data->pcc_lock);
 
-	if (CPC_IN_PCC(reg)) {
-		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
-		struct cppc_pcc_data *pcc_ss_data = NULL;
-		int ret;
+	if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
+		ret = cpc_read(cpu, reg, val);
+	else
+		ret = -EIO;
 
-		if (pcc_ss_id < 0) {
-			pr_debug("Invalid pcc_ss_id\n");
-			return -ENODEV;
-		}
+	up_write(&pcc_ss_data->pcc_lock);
 
-		pcc_ss_data = pcc_data[pcc_ss_id];
+	return ret;
+}
 
-		down_write(&pcc_ss_data->pcc_lock);
+static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *reg;
 
-		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
-			ret = cpc_read(cpunum, reg, perf);
-		else
-			ret = -EIO;
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
 
-		up_write(&pcc_ss_data->pcc_lock);
+	reg = &cpc_desc->cpc_regs[reg_idx];
 
-		return ret;
+	if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
+		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
+		return -EOPNOTSUPP;
 	}
 
-	return cpc_read(cpunum, reg, perf);
+	if (CPC_IN_PCC(reg))
+		return cppc_get_reg_val_in_pcc(cpu, reg, val);
+
+	return cpc_read(cpu, reg, val);
 }
 
 /**
@@ -1242,7 +1246,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
-	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
+	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
 
@@ -1255,7 +1259,7 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
  */
 int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 {
-	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
+	return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
 }
 
 /**
@@ -1267,7 +1271,7 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
  */
 int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
-	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
+	return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
 
@@ -1280,7 +1284,7 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
  */
 int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
-	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
+	return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
 
-- 
2.33.0


