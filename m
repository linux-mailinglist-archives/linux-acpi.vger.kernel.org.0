Return-Path: <linux-acpi+bounces-10142-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 384599F2CAC
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 10:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE79188A847
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3125420100D;
	Mon, 16 Dec 2024 09:16:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DD2200BAA;
	Mon, 16 Dec 2024 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340571; cv=none; b=LxM9uywwyInwvkjzeZaiNc+yPAUtMGwLLdG8d8CADqk0hGrZ/Mgp6I8/Xf9GAY8oPMkKxz4dHQsFi7zSU56dawu5+Y/5VIhC5cdfh9Yg01nmoRHCdkbqmWFPkTDv4qMALZwW/lffthKvJVrEq4yOqQEa1p/NjkRceKwN0rD8doc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340571; c=relaxed/simple;
	bh=xrRcITHs30H6z8klvR2ApPrxKy0KCqRxTfGYNpuCBp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCgqhnEpIiHnY6+klg9+CZzw0ZpR6XT8ZIsLVT5Oksev0vordkGHQ07mqp2DHM9zqAFOZUShYQ/wC6zD+G5sXAsum0gZX+T1PMAizWK4ZCPAKZlNRVS6QMEEv25ZhZebur9AbdREzNOy8mOCVHpnVluFH7e9BG/Y3N8uZR7JKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YBZ5762qyzqV1Z;
	Mon, 16 Dec 2024 17:14:19 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 21BCE1802D0;
	Mon, 16 Dec 2024 17:16:06 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 17:16:05 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <pierre.gondois@arm.com>, <ionela.voinescu@arm.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <zhenglifeng1@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v3 2/4] ACPI: CPPC: Refactor register value get and set ABIs
Date: Mon, 16 Dec 2024 17:16:01 +0800
Message-ID: <20241216091603.1247644-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
References: <20241216091603.1247644-1-zhenglifeng1@huawei.com>
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

Refactor register value get and set ABIs by using cppc_get_reg_val() and
cppc_set_reg_val().

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 111 +++------------------------------------
 1 file changed, 7 insertions(+), 104 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index bb5333a503a2..83c7fcad74ad 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1602,44 +1602,14 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
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
@@ -1651,43 +1621,7 @@ EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
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
 
@@ -1701,38 +1635,7 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
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


