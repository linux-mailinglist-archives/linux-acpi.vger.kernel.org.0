Return-Path: <linux-acpi+bounces-10542-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F3A0B6B0
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3233A36FE
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E7D22A4EC;
	Mon, 13 Jan 2025 12:21:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF322A4C9;
	Mon, 13 Jan 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770873; cv=none; b=RhjlvvSI8nxNrn8osEPGza43wkavf0ocsGjj72KouDfOb9XfTLXUeFwtYtP6afETtbAVeIbX2sjM5VcoN1vl8I3ilwf3czadVdB/OeZiBXe+xcAke82WSZ46QyJxmyeI/cu9wy4auDJNqE3p9OTW2Wbhp2D3BwBetDG1QvnQmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770873; c=relaxed/simple;
	bh=8vIE7LBUiagQzntywH5R6BsWZ9+UILwDsfERcapNZ9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGZK4Pnd+1iogT++VtvLGzrbWeE/y0F2Rh/Obec0wd5RXAJHW4TfGOPiBtNaByd9qK2NcYx5Y2Ymz2hzUm5sx5RCrd5TRCKMnftI0lLGeEKZXhQo7GDzo/koPj8eIIH8TjrPMyqcf4plZeJOrgx1sA11cjzazuO6YPh6h/5E39M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YWrr95wKHzbk2S;
	Mon, 13 Jan 2025 20:18:01 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 4899B1401F0;
	Mon, 13 Jan 2025 20:21:09 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 20:21:08 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v4 4/6] ACPI: CPPC: Refactor register value get and set ABIs
Date: Mon, 13 Jan 2025 20:21:02 +0800
Message-ID: <20250113122104.3870673-5-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Refactor register value get and set ABIs by using cppc_get_reg_val(),
cppc_set_reg_val() and CPPC_REG_VAL_READ().

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 165 +++------------------------------------
 1 file changed, 11 insertions(+), 154 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 6326a1536cda..03134613311d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1293,56 +1293,10 @@ int cppc_set_##reg_name(int cpu, u64 val)		\
 }							\
 EXPORT_SYMBOL_GPL(cppc_set_##reg_name)
 
-/**
- * cppc_get_desired_perf - Get the desired performance register value.
- * @cpunum: CPU from which to get desired performance.
- * @desired_perf: Return address.
- *
- * Return: 0 for success, -EIO otherwise.
- */
-int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
-{
-	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
-}
-EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
-
-/**
- * cppc_get_nominal_perf - Get the nominal performance register value.
- * @cpunum: CPU from which to get nominal performance.
- * @nominal_perf: Return address.
- *
- * Return: 0 for success, -EIO otherwise.
- */
-int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
-{
-	return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
-}
-
-/**
- * cppc_get_highest_perf - Get the highest performance register value.
- * @cpunum: CPU from which to get highest performance.
- * @highest_perf: Return address.
- *
- * Return: 0 for success, -EIO otherwise.
- */
-int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
-{
-	return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
-}
-EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
-
-/**
- * cppc_get_epp_perf - Get the epp register value.
- * @cpunum: CPU from which to get epp preference value.
- * @epp_perf: Return address.
- *
- * Return: 0 for success, -EIO otherwise.
- */
-int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
-{
-	return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
-}
-EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
+CPPC_REG_VAL_READ(desired_perf, DESIRED_PERF);
+CPPC_REG_VAL_READ(nominal_perf, NOMINAL_PERF);
+CPPC_REG_VAL_READ(highest_perf, HIGHEST_PERF);
+CPPC_REG_VAL_READ(epp_perf, ENERGY_PERF);
 
 /**
  * cppc_get_perf_caps - Get a CPU's performance capabilities.
@@ -1620,44 +1574,14 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
  */
 int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 {
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
-	struct cpc_register_resource *auto_sel_reg;
-	u64  auto_sel;
-
-	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
-		return -ENODEV;
-	}
-
-	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
-
-	if (!CPC_SUPPORTED(auto_sel_reg))
-		pr_warn_once("Autonomous mode is not unsupported!\n");
-
-	if (CPC_IN_PCC(auto_sel_reg)) {
-		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
-		struct cppc_pcc_data *pcc_ss_data = NULL;
-		int ret = 0;
-
-		if (pcc_ss_id < 0)
-			return -ENODEV;
-
-		pcc_ss_data = pcc_data[pcc_ss_id];
-
-		down_write(&pcc_ss_data->pcc_lock);
-
-		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
-			cpc_read(cpunum, auto_sel_reg, &auto_sel);
-			perf_caps->auto_sel = (bool)auto_sel;
-		} else {
-			ret = -EIO;
-		}
-
-		up_write(&pcc_ss_data->pcc_lock);
+	u64 auto_sel;
+	int ret;
 
+	ret = cppc_get_reg_val(cpunum, AUTO_SEL_ENABLE, &auto_sel);
+	if (ret)
 		return ret;
-	}
 
+	perf_caps->auto_sel = (bool)auto_sel;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
@@ -1669,43 +1593,7 @@ EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
  */
 int cppc_set_auto_sel(int cpu, bool enable)
 {
-	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-	struct cpc_register_resource *auto_sel_reg;
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cppc_pcc_data *pcc_ss_data = NULL;
-	int ret = -EINVAL;
-
-	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
-		return -ENODEV;
-	}
-
-	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
-
-	if (CPC_IN_PCC(auto_sel_reg)) {
-		if (pcc_ss_id < 0) {
-			pr_debug("Invalid pcc_ss_id\n");
-			return -ENODEV;
-		}
-
-		if (CPC_SUPPORTED(auto_sel_reg)) {
-			ret = cpc_write(cpu, auto_sel_reg, enable);
-			if (ret)
-				return ret;
-		}
-
-		pcc_ss_data = pcc_data[pcc_ss_id];
-
-		down_write(&pcc_ss_data->pcc_lock);
-		/* after writing CPC, transfer the ownership of PCC to platform */
-		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
-		up_write(&pcc_ss_data->pcc_lock);
-	} else {
-		ret = -ENOTSUPP;
-		pr_debug("_CPC in PCC is not supported\n");
-	}
-
-	return ret;
+	return cppc_set_reg_val(cpu, AUTO_SEL_ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
 
@@ -1719,38 +1607,7 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
  */
 int cppc_set_enable(int cpu, bool enable)
 {
-	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-	struct cpc_register_resource *enable_reg;
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cppc_pcc_data *pcc_ss_data = NULL;
-	int ret = -EINVAL;
-
-	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
-		return -EINVAL;
-	}
-
-	enable_reg = &cpc_desc->cpc_regs[ENABLE];
-
-	if (CPC_IN_PCC(enable_reg)) {
-
-		if (pcc_ss_id < 0)
-			return -EIO;
-
-		ret = cpc_write(cpu, enable_reg, enable);
-		if (ret)
-			return ret;
-
-		pcc_ss_data = pcc_data[pcc_ss_id];
-
-		down_write(&pcc_ss_data->pcc_lock);
-		/* after writing CPC, transfer the ownership of PCC to platfrom */
-		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
-		up_write(&pcc_ss_data->pcc_lock);
-		return ret;
-	}
-
-	return cpc_write(cpu, enable_reg, enable);
+	return cppc_set_reg_val(cpu, ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
 
-- 
2.33.0


