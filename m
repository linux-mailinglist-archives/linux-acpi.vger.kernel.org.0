Return-Path: <linux-acpi+bounces-9730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0369D5954
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 07:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1231F21F38
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CD316BE14;
	Fri, 22 Nov 2024 06:20:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1015853D;
	Fri, 22 Nov 2024 06:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256459; cv=none; b=ZMOTXR0cCdi97NBcGdrBwRr2rB0D23nCVLKAL8Ny278al9rsLbRPMh6LFjCx5n6R4+OLHUK+lWauDKjFO8aezQQtYUjwEaOkvrMz6FMj73u/YnBdm6hxjH64QIlFnLjwn2/pBmZPUYl4StjngidZgBF3grfF8xJjlRchrbStoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256459; c=relaxed/simple;
	bh=TuWRusM6SJhP4LkvkK2EuhpbQ/CrQn2lGnTikUVBTro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ov/mKvcyJ2NmuGbMn4tQuX6DYnEuSSko446JqnABkD3M/nPtWm6xMy+vn5jfOq9Qxfr8PqXiScW0MLjYLPnkFFVpa29l6851qkLiiJimlF7gWlHl58m7j/WuJOxj+dDJ5ckv/mZGSjgVfJZj+DBUs/ruEmrk3eUaS2EUd6AX84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XvlK06j40z1V4pg;
	Fri, 22 Nov 2024 14:18:12 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 88D251401F4;
	Fri, 22 Nov 2024 14:20:53 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Nov 2024 14:20:52 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 1/3] ACPI: CPPC: Refactor register get and set ABIs
Date: Fri, 22 Nov 2024 14:20:49 +0800
Message-ID: <20241122062051.3658577-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
References: <20241122062051.3658577-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Refactor register get and set ABIs using cppc_get_reg() and cppc_set_reg().

Rename cppc_get_perf() to cppc_get_reg() as a generic function to read cppc
registers, with two changes:

1. Change the error kind to "no such device" when pcc_ss_id < 0, which
means that this cpu cannot get a valid pcc_ss_id.

2. Add a check to verify if the register is a cpc supported one before
using it.

Add cppc_set_reg() as a generic function for setting cppc registers. Unlike
other set reg ABIs, this function checks CPC_SUPPORTED right after getting
the register, because the rest of the operations are meaningless if this
register is not a cpc supported one.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 191 +++++++++++++++------------------------
 1 file changed, 72 insertions(+), 119 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c1f3568d0c50..9aab22d8136a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1179,10 +1179,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
-static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
+static int cppc_get_reg(int cpunum, enum cppc_regs reg_idx, u64 *val)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
 	struct cpc_register_resource *reg;
+	int pcc_ss_id;
+	int ret = 0;
 
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1191,20 +1194,23 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
+	if (!CPC_SUPPORTED(reg)) {
+		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
+		return -EOPNOTSUPP;
+	}
+
 	if (CPC_IN_PCC(reg)) {
-		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
-		struct cppc_pcc_data *pcc_ss_data = NULL;
-		int ret = 0;
+		pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 
 		if (pcc_ss_id < 0)
-			return -EIO;
+			return -ENODEV;
 
 		pcc_ss_data = pcc_data[pcc_ss_id];
 
 		down_write(&pcc_ss_data->pcc_lock);
 
 		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
-			cpc_read(cpunum, reg, perf);
+			cpc_read(cpunum, reg, val);
 		else
 			ret = -EIO;
 
@@ -1213,21 +1219,65 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 		return ret;
 	}
 
-	cpc_read(cpunum, reg, perf);
+	cpc_read(cpunum, reg, val);
 
 	return 0;
 }
 
+static int cppc_set_reg(int cpu, enum cppc_regs reg_idx, u64 val)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	struct cpc_register_resource *reg;
+	int pcc_ss_id;
+	int ret;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	reg = &cpc_desc->cpc_regs[reg_idx];
+
+	if (!CPC_SUPPORTED(reg)) {
+		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
+		return -EOPNOTSUPP;
+	}
+
+	if (CPC_IN_PCC(reg)) {
+		pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id\n");
+			return -ENODEV;
+		}
+
+		ret = cpc_write(cpu, reg, val);
+		if (ret)
+			return ret;
+
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+		/* after writing CPC, transfer the ownership of PCC to platform */
+		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+		up_write(&pcc_ss_data->pcc_lock);
+		return ret;
+	}
+
+	return cpc_write(cpu, reg, val);
+}
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
  * @desired_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -ERRNO otherwise.
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
-	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
+	return cppc_get_reg(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
 
@@ -1236,11 +1286,11 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
  * @cpunum: CPU from which to get nominal performance.
  * @nominal_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -ERRNO otherwise.
  */
 int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 {
-	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
+	return cppc_get_reg(cpunum, NOMINAL_PERF, nominal_perf);
 }
 
 /**
@@ -1248,11 +1298,11 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
  * @cpunum: CPU from which to get highest performance.
  * @highest_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -ERRNO otherwise.
  */
 int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
-	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
+	return cppc_get_reg(cpunum, HIGHEST_PERF, highest_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
 
@@ -1261,11 +1311,11 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
  * @cpunum: CPU from which to get epp preference value.
  * @epp_perf: Return address.
  *
- * Return: 0 for success, -EIO otherwise.
+ * Return: 0 for success, -ERRNO otherwise.
  */
 int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
-	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
+	return cppc_get_reg(cpunum, ENERGY_PERF, epp_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
 
@@ -1545,44 +1595,14 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
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
 
+	ret = cppc_get_reg(cpunum, AUTO_SEL_ENABLE, &auto_sel);
+	if (ret)
 		return ret;
-	}
 
+	perf_caps->auto_sel = (bool)auto_sel;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
@@ -1594,43 +1614,7 @@ EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
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
+	return cppc_set_reg(cpu, AUTO_SEL_ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
 
@@ -1644,38 +1628,7 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
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
+	return cppc_set_reg(cpu, ENABLE, enable);
 }
 EXPORT_SYMBOL_GPL(cppc_set_enable);
 
-- 
2.33.0


