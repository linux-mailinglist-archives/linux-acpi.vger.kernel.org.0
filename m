Return-Path: <linux-acpi+bounces-13897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA0AC3EA1
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 13:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1CE3A7B7B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 11:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E69F10E3;
	Mon, 26 May 2025 11:31:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6557C1F8ADD;
	Mon, 26 May 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259076; cv=none; b=cF4KKL5KJiMjpaOXH1eTxHMABn5aUnHj/i1+IgQuoZe79sMmH2Xo41F2Vr8T8DnoKL9I9CK6OlgGkEvZKdqK1ZK1E/D8jJCXAkiqBAXTxpL/p3zf1x4z8cPHASgr6jsl7UafR6Tim4+EzKRS4++Nb14BMkcHRfY01ziDPfufUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259076; c=relaxed/simple;
	bh=cN6HWpXVEkQBujIBg2fai31k/ZDEUo0Lfd6hvXZUxhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=le+eS1BKbc1tya8els2X7XbMkq4apkn7Ub5i2CRhgielWEqeZ1nA0BR1IoVmFDgbQ+Txq1LNcG4tH058jtngq9dNzTm1XWDlAZC7cy0l3IlRWUmUopy3Nriq9qvBgOSVpM8SpAMDA/E7Tnkn26dYYyv9kIHLyWhaUcMyanrrTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b5YQK32QKzLph9;
	Mon, 26 May 2025 19:27:21 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id C3E29180489;
	Mon, 26 May 2025 19:31:05 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 19:31:04 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robert.moore@intel.com>,
	<lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <yubowen8@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 2/3] cpufreq: CPPC: Return void in populate_efficiency_class()
Date: Mon, 26 May 2025 19:30:56 +0800
Message-ID: <20250526113057.3086513-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

The return value of populate_efficiency_class() is never needed and the
result of it doesn't affect the initialization of cppc_cpufreq. It makes
more sense to have it return void.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f3b5ea9fcbf5..c2be4b188a23 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -480,7 +480,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 	return 0;
 }
 
-static int populate_efficiency_class(void)
+static void populate_efficiency_class(void)
 {
 	struct acpi_madt_generic_interrupt *gicc;
 	DECLARE_BITMAP(used_classes, 256) = {};
@@ -495,7 +495,7 @@ static int populate_efficiency_class(void)
 	if (bitmap_weight(used_classes, 256) <= 1) {
 		pr_debug("Efficiency classes are all equal (=%d). "
 			"No EM registered", class);
-		return -EINVAL;
+		return;
 	}
 
 	/*
@@ -512,8 +512,6 @@ static int populate_efficiency_class(void)
 		index++;
 	}
 	cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
-
-	return 0;
 }
 
 static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
@@ -529,9 +527,8 @@ static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
 }
 
 #else
-static int populate_efficiency_class(void)
+static void populate_efficiency_class(void)
 {
-	return 0;
 }
 #endif
 
-- 
2.33.0


