Return-Path: <linux-acpi+bounces-10543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0576A0B6B2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 13:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20828188722D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4722A4E5;
	Mon, 13 Jan 2025 12:21:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328D22A4D8;
	Mon, 13 Jan 2025 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770874; cv=none; b=lBTU13ar7jy+3PAbnu+MZH05gBxVoANiQbVgcEedoJaO2ODNsXzy4YmvdIoxKv4W3wRHQWZEqq0K16VW8bQAO9w1Xjtduc6S2XH1JJByB2fqPrUKvezSZqmJX3dTKBO31jpSXpwBRzf3G+HDTyei2p0Sr1+efTfFaXUwMvxabrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770874; c=relaxed/simple;
	bh=riDYKMDT3rQAOS0FqVcuDrii6rQKYOQ4q6cN+kTpRL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxm7KgBRxsNm8zXnFGuvw9TtI3r0LFUBrGVvDk5NLJIEodPppk4XFR11H2Kd6ysQsN+YfnLwjsIJE6xhmFK30nX/7Rddu9tTU42o+LvJnIMFgItfvwTvaacLhKuZp93JAOpMeBO5lzwRasdrJ1VlNe17HhX2did5lY2BpUtvxMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YWrr81cZhz1V4jx;
	Mon, 13 Jan 2025 20:18:00 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 941DC1401F4;
	Mon, 13 Jan 2025 20:21:08 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jan 2025 20:21:07 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
	<viresh.kumar@linaro.org>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>
CC: <acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<hepeng68@huawei.com>, <fanghao11@huawei.com>
Subject: [PATCH v4 3/6] ACPI: CPPC: Add macros to generally implement registers getting and setting functions
Date: Mon, 13 Jan 2025 20:21:01 +0800
Message-ID: <20250113122104.3870673-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Add CPPC_REG_VAL_READ() to implement registers getting functions.

Add CPPC_REG_VAL_WRITE() to implement registers setting functions.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 571f94855dce..6326a1536cda 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1279,6 +1279,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	return cpc_write(cpu, reg, val);
 }
 
+#define CPPC_REG_VAL_READ(reg_name, reg_idx)		\
+int cppc_get_##reg_name(int cpu, u64 *val)		\
+{							\
+	return cppc_get_reg_val(cpu, reg_idx, val);	\
+}							\
+EXPORT_SYMBOL_GPL(cppc_get_##reg_name)
+
+#define CPPC_REG_VAL_WRITE(reg_name, reg_idx)		\
+int cppc_set_##reg_name(int cpu, u64 val)		\
+{							\
+	return cppc_set_reg_val(cpu, reg_idx, val);	\
+}							\
+EXPORT_SYMBOL_GPL(cppc_set_##reg_name)
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
-- 
2.33.0


