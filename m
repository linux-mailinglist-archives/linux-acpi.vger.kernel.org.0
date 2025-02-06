Return-Path: <linux-acpi+bounces-10910-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848E4A2A959
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F2018839A2
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF223A570;
	Thu,  6 Feb 2025 13:14:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320C235BE4;
	Thu,  6 Feb 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847677; cv=none; b=KJuKPr10F3Ovs3l17AdN2G8zY9533P0duSrQx0LLKbPtsutbF+16tXbiySRk8y14UHsl3+CEbKGgcqvu2cHMfW/mnMBJynWy6fodN9zbPOB+PQ8Ba1R76pwmDQ64ng2oUR8EDVbP1g1f0mi7gwlDXpLALk8qT7tp3IKuyFWwSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847677; c=relaxed/simple;
	bh=oD4CNHGZFnu1bAbRywJFA78m65IicxF9IAjnEYV25Ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aptRw5sIlnq7qWWmEmQor9mjAAji+0z2JerPH5thDsI35trJjNzbAzmT2xZZx4DgZYF9swRkdXtxr5oFJCXtAJ9/NKJqy1lO03FzBrXLGblWoIEXHYHVscAq+iUU1GAj5O/zMk7MmMnjJKpr8iF4BYNEhuD90XiSjDGazUk3foE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YpcwR3V35zrRhk;
	Thu,  6 Feb 2025 21:12:55 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 75DCF14034D;
	Thu,  6 Feb 2025 21:14:31 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 21:14:30 +0800
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
Subject: [PATCH v5 2/8] ACPI: CPPC: Optimize cppc_get_perf()
Date: Thu, 6 Feb 2025 21:14:22 +0800
Message-ID: <20250206131428.3261578-3-zhenglifeng1@huawei.com>
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

Optimize cppc_get_perf() with three changes:

1. Change the error kind to "no such device" when pcc_ss_id < 0, as other
register value getting functions.

2. Add a check to verify if the register is a mandatory or cpc supported
one before using it.

3. Return the result of cpc_read() instead of 0.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 39f019e265da..db22f8f107db 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1201,20 +1201,27 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
+	if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
+		pr_debug("CPC register (reg_idx=%d) is not supported\n", reg_idx);
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
 
@@ -1223,9 +1230,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
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


