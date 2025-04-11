Return-Path: <linux-acpi+bounces-12967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C72A8581D
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 11:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB684C3DE4
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1E9298CA4;
	Fri, 11 Apr 2025 09:39:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717F28FFD4;
	Fri, 11 Apr 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364344; cv=none; b=Npr4cAlVR5EP6sNbNj6TLgmKuvYtI7bFkwiym3X7WaDeLosMQi/xmsioxO0eHWWmTt/HFBOuvkLYB//bVykSKbi13sJNScO99f+AqQ9v7oWn4Osn9cHga3n3cKA6fG3PLCu8QPOM/ozQRi8GNQ2BdLM8m/Sw4EZgy1SND0Lbsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364344; c=relaxed/simple;
	bh=5U0HU3WfOT5xRQvfSiSW7Hrl1ntFWO+kzOLjtSBJuW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oC0CmHCsnniPgIki7D3nlcZP60C3tc44mpT9UqqiYSbSCprHSUpPqhcVVY8QKA6lWIzObdSZqC5xwLXfEvyNAoAHJGjKJMhDZl3TP8k/DLjN/thPU474y4TNYWAdQxl0D7EU4qjmBVXIbQrh5A3eCZAyM1ehshoQ2rFexfBz+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZYs2H00zYz2TS5K;
	Fri, 11 Apr 2025 17:33:58 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BB414140275;
	Fri, 11 Apr 2025 17:38:58 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Apr 2025 17:38:57 +0800
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
Subject: [PATCH v7 2/8] ACPI: CPPC: Optimize cppc_get_perf()
Date: Fri, 11 Apr 2025 17:38:49 +0800
Message-ID: <20250411093855.982491-3-zhenglifeng1@huawei.com>
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

Optimize cppc_get_perf() with three changes:

1. Change the error kind to "no such device" when pcc_ss_id < 0, as other
register value getting functions.

2. Add a check to ensure the pointer 'perf' is no null.

3. Add a check to verify if the register is supported to be read before
using it. The logic is:

(1) If the register is of the integer type, check whether the register is
optional and its value is 0. If yes, the register is not supported.

(2) If the register is of other types, a null one is not supported.

4. Return the result of cpc_read() instead of 0.

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 39f019e265da..4965a6465538 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1194,6 +1194,9 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
 	struct cpc_register_resource *reg;
 
+	if (perf == NULL)
+		return -EINVAL;
+
 	if (!cpc_desc) {
 		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
 		return -ENODEV;
@@ -1201,20 +1204,29 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
+	if ((reg->type == ACPI_TYPE_INTEGER && IS_OPTIONAL_CPC_REG(reg_idx) &&
+	     !reg->cpc_entry.int_value) || (reg->type != ACPI_TYPE_INTEGER &&
+	     IS_NULL_REG(&reg->cpc_entry.reg))) {
+		pr_debug("CPC register is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (CPC_IN_PCC(reg)) {
 		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
 		struct cppc_pcc_data *pcc_ss_data = NULL;
-		int ret = 0;
+		int ret;
 
-		if (pcc_ss_id < 0)
-			return -EIO;
+		if (pcc_ss_id < 0) {
+			pr_debug("Invalid pcc_ss_id\n");
+			return -ENODEV;
+		}
 
 		pcc_ss_data = pcc_data[pcc_ss_id];
 
 		down_write(&pcc_ss_data->pcc_lock);
 
 		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
-			cpc_read(cpunum, reg, perf);
+			ret = cpc_read(cpunum, reg, perf);
 		else
 			ret = -EIO;
 
@@ -1223,9 +1235,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 		return ret;
 	}
 
-	cpc_read(cpunum, reg, perf);
-
-	return 0;
+	return cpc_read(cpunum, reg, perf);
 }
 
 /**
-- 
2.33.0


