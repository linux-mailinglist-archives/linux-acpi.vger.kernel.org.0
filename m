Return-Path: <linux-acpi+bounces-12883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEFA81D94
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 08:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9454A105D
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019E215043;
	Wed,  9 Apr 2025 06:57:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2621324E;
	Wed,  9 Apr 2025 06:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181832; cv=none; b=PRe2tA24hJeXUcjR4rBf3JaQrUkUtcz6U6mI8ZdqnmG3WTTpOSZmjqwZsI/Iiri9Cjjr9AD2F3IBTyP1aHjkHZJekkgi4F1tTDi2x9tzD0FjjYjby8xnoeZhbEC6YMEPjXXTEwO1Eydw/2PafL4F+bI/MLjDzgGv28sl8up4pTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181832; c=relaxed/simple;
	bh=azfOtZ+FisifIFITjBNrySyBCSvJfsqNadjetFy/v8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGX5Fi9KcH1eEVeA3TT3yhLR2yAepVS/nIZ6bnCVip6AcstnnCLfPU6MoI7wnC07FA0mdFMqTriO63EWU6FrIWecB5ELETPRtHn7drD3iNcXPo0mKurpQexZPpy2OhbXtKca2FYSz8fGjXu8lt/jcBjXAyb5UnYOS8JmskpOGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZXYYs3prqz69Zw;
	Wed,  9 Apr 2025 14:53:21 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9335D180471;
	Wed,  9 Apr 2025 14:57:06 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 14:57:05 +0800
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
Subject: [PATCH v6 2/8] ACPI: CPPC: Optimize cppc_get_perf()
Date: Wed, 9 Apr 2025 14:56:57 +0800
Message-ID: <20250409065703.1461867-3-zhenglifeng1@huawei.com>
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

Optimize cppc_get_perf() with three changes:

1. Change the error kind to "no such device" when pcc_ss_id < 0, as other
register value getting functions.

2. Add a check to verify if the register is supported to be read before
using it. The logic is:

(1) If the register is of the integer type, check whether the register is
optional and its value is 0. If yes, the register is not supported.

(2) If the register is of other types, a null one is not supported.

3. Return the result of cpc_read() instead of 0.

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 39f019e265da..2f789d3b3cad 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1201,20 +1201,29 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
+	if (reg->type == ACPI_TYPE_INTEGER ?
+	    (IS_OPTIONAL_CPC_REG(reg_idx) && !reg->cpc_entry.int_value) :
+	    IS_NULL_REG(&reg->cpc_entry.reg)) {
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
 
@@ -1223,9 +1232,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
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


