Return-Path: <linux-acpi+bounces-12887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E91A81D9C
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 08:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2494A7B11
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A121764B;
	Wed,  9 Apr 2025 06:57:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5A2135AD;
	Wed,  9 Apr 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181834; cv=none; b=pgYjxzutolWZOKsdY14hq5IZa6sPF+M79eoDa5cMrrbzUYVWX/HFvzQDFLjIfgTme49pA3MJYRrrevpxnzvRTrTVg/JajfD9fSM0v4kBGk7pGHLQOPist+boRotTIHLD1d14W+kuHF3WOZ+It9wln7MFrZbHDRxZIE4+iLswciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181834; c=relaxed/simple;
	bh=PEccsy/K24DS0RhM/KB6pU2VAZ1yxVdt8mZtrEpb5Uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r36i0/U1fQDCfnCTmcXmNIxjc2vUvnlLxUh/OQG2/SWIAz/UdukWP7t7piP/k5i8E/syFtNatVRPuw9PpGAlVVhmgxKDfJ0cAksRjQd2BZePQq/A+9yBrVsl8maVd/7p/Xv1BL8NBM4jN4iXdpcsqdwf8/lFW5u5AaHnYg7KLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZXYdQ3YXYz13LVx;
	Wed,  9 Apr 2025 14:56:26 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F88A1401E0;
	Wed,  9 Apr 2025 14:57:07 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 14:57:06 +0800
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
Subject: [PATCH v6 3/8] ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
Date: Wed, 9 Apr 2025 14:56:58 +0800
Message-ID: <20250409065703.1461867-4-zhenglifeng1@huawei.com>
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

Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to read
cppc registers.

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2f789d3b3cad..9e26f115e1a9 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1189,13 +1189,13 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
-static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
+static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 {
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
 	struct cpc_register_resource *reg;
 
 	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
 		return -ENODEV;
 	}
 
@@ -1209,7 +1209,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 	}
 
 	if (CPC_IN_PCC(reg)) {
-		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 		struct cppc_pcc_data *pcc_ss_data = NULL;
 		int ret;
 
@@ -1223,7 +1223,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 		down_write(&pcc_ss_data->pcc_lock);
 
 		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
-			ret = cpc_read(cpunum, reg, perf);
+			ret = cpc_read(cpu, reg, val);
 		else
 			ret = -EIO;
 
@@ -1232,7 +1232,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 		return ret;
 	}
 
-	return cpc_read(cpunum, reg, perf);
+	return cpc_read(cpu, reg, val);
 }
 
 /**
@@ -1244,7 +1244,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
  */
 int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
 {
-	return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
+	return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
 
@@ -1257,7 +1257,7 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
  */
 int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
 {
-	return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
+	return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
 }
 
 /**
@@ -1269,7 +1269,7 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
  */
 int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
 {
-	return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
+	return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
 
@@ -1282,7 +1282,7 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
  */
 int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
 {
-	return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
+	return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
 }
 EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
 
-- 
2.33.0


