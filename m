Return-Path: <linux-acpi+bounces-10915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA20A2A974
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 307F27A3FCD
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22F230997;
	Thu,  6 Feb 2025 13:14:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748C2451D9;
	Thu,  6 Feb 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847682; cv=none; b=FDWwESNzvEx8HGBujyWuS3HLQ4aGWwSdPytSp3urUJivxBEMHWotcp8pFWBG14DCy+DzMEJREG6DIdu6NZuEGsOSc8K2b2MhQwGpiM/NIH/kmBbkinagmh+9xcmrG85TyebpEcpD0yw7AwRj7R5DNUyhP0Wgqx2cM8r83UTDbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847682; c=relaxed/simple;
	bh=YuwtsskjQbXREf3umJAMaaR55thryRj0A/sPk/b4sds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahqnO9Knx7T2lX31pMFpL0zWuV30WoIrFgs7n++lDKERI1YAInzj2MRudEakrzYqL6AuFrwJ1PXrr8R5uZoTFsaMQGUIfYCanzfjUeYAr9FaC4PLOau3x6rRAFtRRmf3FyLdw366b14+a1SLBj5gTn9ZZhYCNNofFwiiDQtMqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ypcv61JwZzmZC0;
	Thu,  6 Feb 2025 21:11:46 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D59C31400CA;
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
Subject: [PATCH v5 4/8] ACPI: CPPC: Add cppc_set_reg_val()
Date: Thu, 6 Feb 2025 21:14:24 +0800
Message-ID: <20250206131428.3261578-5-zhenglifeng1@huawei.com>
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

Add cppc_set_reg_val() as a generic function for setting cppc registers
value, with this features:

1. Check register type. If a register is writeable, it must be a buffer.

2. Check if the register is a optional and null one right after getting the
register.  Because if so, the rest of the operations are meaningless.

3. Extract the operations if register is in pcc out as
cppc_set_reg_val_in_pcc().

These functions can be used to reduce some existing code duplication.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 50 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3c9c4ce2a0b0..17558d2b5ae5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1237,6 +1237,56 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
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
+	/* if a register is writeable, it must be a buffer */
+	if ((reg->type != ACPI_TYPE_BUFFER) ||
+	    (IS_OPTIONAL_CPC_REG(reg_idx) && IS_NULL_REG(&reg->cpc_entry.reg))) {
+		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
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


