Return-Path: <linux-acpi+bounces-10908-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63DA2A950
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AF23A7244
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F522F3B2;
	Thu,  6 Feb 2025 13:14:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D716232360;
	Thu,  6 Feb 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847675; cv=none; b=BNih1RAB9Ncbb4sABzyNwC80EkzWjTpP11CZHiv2fuz0g+AlzsTyWt9Zk6IInqTNQYrLmcXBm8gGtr9/H1cNT4E4ZAZLlqQRxjjw6e+TxLqKqNeVo1bsOmQSK8fg0JVxVcS24UEqyixw9U6hEi2f5Ko/QDDKYoGkAcUwK4v0Tvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847675; c=relaxed/simple;
	bh=RZnMzdulRLNgifHQdIHsKNjUzLRlnQNJ1xKNoq93Xno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMjkMapxn/0I6Cp9jLakr6/aehHIgykIrR4E3htrboh1Uy9yzb17biYcG50nVOZToIWItoO3yI5F7FV2orlIbfVINgxeIXsY5g4HkNBqiFdlr15CCs5/Ik4HZ/jJc34oAjwrOPlDL8WRDTC3fpweaKUDGHHdsKwDpHwVdf1S0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YpctJ3xFczbnny;
	Thu,  6 Feb 2025 21:11:04 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BFAC6140383;
	Thu,  6 Feb 2025 21:14:30 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Feb 2025 21:14:29 +0800
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
Subject: [PATCH v5 1/8] ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is optional
Date: Thu, 6 Feb 2025 21:14:21 +0800
Message-ID: <20250206131428.3261578-2-zhenglifeng1@huawei.com>
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

In ACPI 6.5, s8.4.6.1 _CPC (Continuous Performance Control), whether each
of the per-cpu cpc_regs[] is mendatory or optional is defined. Since the
CPC_SUPPORTED() check is only for optional cpc field, another macro to
check if the field is optional is needed.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index f193e713825a..39f019e265da 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -129,6 +129,20 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?		\
 				!!(cpc)->cpc_entry.int_value :		\
 				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
+
+/*
+ * Each bit indicates the optionality of the register in per-cpu
+ * cpc_regs[] with the corresponding index. 0 means mandatory and 1
+ * means optional.
+ */
+#define REG_OPTIONAL (0x1FC7D0)
+
+/*
+ * Use the index of the register in per-cpu cpc_regs[] to check if
+ * it's an optional one.
+ */
+#define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
+
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
  * to PCC commands. Keeping it high enough to cover emulators where
-- 
2.33.0


