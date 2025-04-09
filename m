Return-Path: <linux-acpi+bounces-12884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7ADA81D98
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 08:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F5C3A4A0F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234A215182;
	Wed,  9 Apr 2025 06:57:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB8621325F;
	Wed,  9 Apr 2025 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181833; cv=none; b=fuI4wBD/erwrDJ1ZIXyOkH4O8bnpRCmAAP4IR4CI31ZSoXxixI/KymfK5a0Uh6uYEXKDKpVXOjhqsCVyGSMQ8Ru1PdVUUxbRMbm11M7fq2VwTMpF6Yp5Lx3Gxx20YeK25zgFzvqUoB/uNq2q6gXubpKzEkgaK7uzFtUJ/2+7MXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181833; c=relaxed/simple;
	bh=gzNVnkc2fa234tTTUUsjbok/zgXIzT4r8uz35UJgVH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCo+qVPPHW0k4YNhNkgFyfOl0V8tvLgDFWpyoe1a8nMfQ/kWNS78klql8Wj7WpaQedKT53L1rUvJoM0Cji0HCa1Xa2+w4tTMFX2iIdalQYffwXVUFwi3arwPLccQ0gOHa18TfUqdXTGtCX/OtRotV3qcqM2T6ol9TNJS4IgD8fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZXYYt5DbDz69Y1;
	Wed,  9 Apr 2025 14:53:22 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id C6134180B4A;
	Wed,  9 Apr 2025 14:57:07 +0800 (CST)
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
Subject: [PATCH v6 4/8] ACPI: CPPC: Extract cppc_get_reg_val_in_pcc()
Date: Wed, 9 Apr 2025 14:56:59 +0800
Message-ID: <20250409065703.1461867-5-zhenglifeng1@huawei.com>
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

Extract the operations if register is in pcc out from cppc_get_reg_val() as
cppc_get_reg_val_in_pcc().

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 50 ++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9e26f115e1a9..d844d0715761 100644
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
@@ -1208,29 +1233,8 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
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


