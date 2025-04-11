Return-Path: <linux-acpi+bounces-12973-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A556A85829
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 11:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543601BA499C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E24929CB2B;
	Fri, 11 Apr 2025 09:39:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401A29C32B;
	Fri, 11 Apr 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364349; cv=none; b=cMS3rFPTnVmNZ6Vj6r23q3moTr+vtEcWD8MN66WTq8XeowNy81Ak6MBn9tYhuEY1NAE1iBF90J7r9sihNxckNLlhzMNcl10FC6DVWH4orZNRwRaQK98+AQ+AIG6s4fy8AM6I4pjUigfW20vrWUNTJRhXHrDQ3qf66S1aCKKL5Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364349; c=relaxed/simple;
	bh=RtfeLg4QJnf+E5oqfEImcNL/L/VACvPVo9GpkQWQVzQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoSu7gvaWZEsvXTiyDXj1r67NV6Dl51LlXLmunBr+OEWv3b50FMJuUgEGt0wFdP3drengPAYGO5aiXQ0HgOxVtQZ7JEyK4yTVFmV7ajsVtulPHWLQsSpwP1sYF8U4dcHCmktb9OzXn/w80ZvZ8Y56YYbJ32xnKL8R94ktFY3kU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZYs821gBbzsTMC;
	Fri, 11 Apr 2025 17:38:58 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1297B140158;
	Fri, 11 Apr 2025 17:39:00 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Apr 2025 17:38:59 +0800
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
Subject: [PATCH v7 4/8] ACPI: CPPC: Extract cppc_get_reg_val_in_pcc()
Date: Fri, 11 Apr 2025 17:38:51 +0800
Message-ID: <20250411093855.982491-5-zhenglifeng1@huawei.com>
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

Extract the operations if register is in pcc out from cppc_get_reg_val() as
cppc_get_reg_val_in_pcc().

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 50 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 76c5e58e5e99..3fe801e1ee30 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1189,6 +1189,31 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
+static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
+{
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+	int ret;
+
+	if (pcc_ss_id < 0) {
+		pr_debug("Invalid pcc_ss_id\n");
+		return -ENODEV;
+	}
+
+	pcc_ss_data = pcc_data[pcc_ss_id];
+
+	down_write(&pcc_ss_data->pcc_lock);
+
+	if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
+		ret = cpc_read(cpu, reg, val);
+	else
+		ret = -EIO;
+
+	up_write(&pcc_ss_data->pcc_lock);
+
+	return ret;
+}
+
 static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 {
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
@@ -1211,29 +1236,8 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 		return -EOPNOTSUPP;
 	}
 
-	if (CPC_IN_PCC(reg)) {
-		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-		struct cppc_pcc_data *pcc_ss_data = NULL;
-		int ret;
-
-		if (pcc_ss_id < 0) {
-			pr_debug("Invalid pcc_ss_id\n");
-			return -ENODEV;
-		}
-
-		pcc_ss_data = pcc_data[pcc_ss_id];
-
-		down_write(&pcc_ss_data->pcc_lock);
-
-		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
-			ret = cpc_read(cpu, reg, val);
-		else
-			ret = -EIO;
-
-		up_write(&pcc_ss_data->pcc_lock);
-
-		return ret;
-	}
+	if (CPC_IN_PCC(reg))
+		return cppc_get_reg_val_in_pcc(cpu, reg, val);
 
 	return cpc_read(cpu, reg, val);
 }
-- 
2.33.0


