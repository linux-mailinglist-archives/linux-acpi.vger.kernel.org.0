Return-Path: <linux-acpi+bounces-12974-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E4FA85839
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 11:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F22F7B63B5
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4199229CB30;
	Fri, 11 Apr 2025 09:39:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3329C328;
	Fri, 11 Apr 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364349; cv=none; b=PMWFPPxXRW0SPtlk3MSvLnnoVr6VKRxctUeCYLTazQyBHq6ttGhQDlspR7mwq2MHtvEGpnmjrbsln9XS4ZrIWvhl3BXCd6XayUQ+hFKfg/h6laPhbq/x18PvzAbxDtdrkfep+OmNplxrTeStuhQc5xfpktNZ+khGBDuspcw3vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364349; c=relaxed/simple;
	bh=HpU2Gc7E+0ZR9qzAMNrVb+eQ7d8tKFl/t/voxmUs9nk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPgXnTLMuJETMm56VJJ5tD6speDT5PRCDmSWUn987KKLB6gxfkAXfzRQAZsMg/MUbj4+g3MaQOjIfB6YOmRFvpPvHwtmRjOMue63rETcVGtoZuBSi5TDWMPR96qIBlk5IbwD9V7HWr3QypzYThDRwyfOOoZ92jtuYG09LvfE7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZYs813zbvzsTKw;
	Fri, 11 Apr 2025 17:38:57 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 64100140158;
	Fri, 11 Apr 2025 17:38:59 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Apr 2025 17:38:58 +0800
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
Subject: [PATCH v7 3/8] ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
Date: Fri, 11 Apr 2025 17:38:50 +0800
Message-ID: <20250411093855.982491-4-zhenglifeng1@huawei.com>
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

Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
cppc registers.

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4965a6465538..76c5e58e5e99 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1189,16 +1189,16 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
-static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
+static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 {
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cpc_register_resource *reg;
 
-	if (perf == NULL)
+	if (val == NULL)
 		return -EINVAL;
 
 	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
 
@@ -1212,7 +1212,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 	}
 
 	if (CPC_IN_PCC(reg)) {
-		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 		struct cppc_pcc_data *pcc_ss_data = NULL;
 		int ret;
 
@@ -1226,7 +1226,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 		down_write(&pcc_ss_data->pcc_lock);
 
 		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
-			ret = cpc_read(cpunum, reg, perf);
+			ret = cpc_read(cpu, reg, val);
 		else
 			ret = -EIO;
 
@@ -1235,7 +1235,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 		return ret;
 	}
 
-	return cpc_read(cpunum, reg, perf);
+	return cpc_read(cpu, reg, val);
 }
 
 /**
@@ -1247,7 +1247,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
-	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
+	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
 
@@ -1260,7 +1260,7 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
  */
 int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 {
-	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
+	return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
 }
 
 /**
@@ -1272,7 +1272,7 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
  */
 int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
-	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
+	return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
 
@@ -1285,7 +1285,7 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
  */
 int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
-	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
+	return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
 
-- 
2.33.0


