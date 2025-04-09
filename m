Return-Path: <linux-acpi+bounces-12888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084AFA81DA2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 08:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449F81BA459E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AE215046;
	Wed,  9 Apr 2025 06:57:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DF21ABAD;
	Wed,  9 Apr 2025 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181838; cv=none; b=nmPYzQ55JE9OtfjESW2oT187ByOQIOPGEdoo1bMTKLTLwynpQXnNchIRGfOiwqE99DLBFaO1icppA7o4NxkHd3H3eXOyqAxJVV/sPFBmQ2b/qD7MWXCNNdOBq8mciQ0PjPbA8bZtjCpjuVxiCmmF82cvwnrcHuoKCqpvmh2/qhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181838; c=relaxed/simple;
	bh=FwzhynTwPOtOs9JX2lAa6bb/8rafXzd93ZgaE96lIIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2lnt42MS9xgQZpCzdDOKobKGDBIX7g1EpXw/1W2Affa22z0oyG5+42Y/b1R3AxYt2XnX5MZiNhRH+5ufr5SxdBLUBJ5iS9luHOrBUIQni4nwa0kMDu6ay1/JSg4yFvO0rv6iNcW3pItFQufvqh+4sS6rKeRuADU9HIKkRf23no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZXYdR5dZ4z1cyT0;
	Wed,  9 Apr 2025 14:56:27 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 59634180471;
	Wed,  9 Apr 2025 14:57:08 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 14:57:07 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <perry.yuan@amd.com>,
	<pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <zhenglifeng1@huawei.com>, <hepeng68@huawei.com>
Subject: [PATCH v6 5/8] ACPI: CPPC: Add cppc_set_reg_val()
Date: Wed, 9 Apr 2025 14:57:00 +0800
Message-ID: <20250409065703.1461867-6-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250409065703.1461867-1-zhenglifeng1@huawei.com>
References: <20250409065703.1461867-1-zhenglifeng1@huawei.com>
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

Add cppc_set_reg_val() as a generic function for setting cppc registers
value, with this features:

1. Check register. If a register is writeable, it must be a buffer and can
not be null.

2. Extract the operations if register is in pcc out as
cppc_set_reg_val_in_pcc().

This function can be used to reduce some existing code duplication.

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index d844d0715761..cd584ce2634a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1239,6 +1239,55 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 	return cpc_read(cpu, reg, val);
 }
 
+static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
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
+	ret = cpc_write(cpu, reg, val);
+	if (ret)
+		return ret;
+
+	pcc_ss_data = pcc_data[pcc_ss_id];
+
+	down_write(&pcc_ss_data->pcc_lock);
+	/* after writing CPC, transfer the ownership of PCC to platform */
+	ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
+	up_write(&pcc_ss_data->pcc_lock);
+
+	return ret;
+}
+
+static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *reg;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	reg = &cpc_desc->cpc_regs[reg_idx];
+
+	/* if a register is writeable, it must be a buffer and not null */
+	if ((reg->type != ACPI_TYPE_BUFFER) || IS_NULL_REG(&reg->cpc_entry.reg)) {
+		pr_debug("CPC register is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (CPC_IN_PCC(reg))
+		return cppc_set_reg_val_in_pcc(cpu, reg, val);
+
+	return cpc_write(cpu, reg, val);
+}
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
-- 
2.33.0


