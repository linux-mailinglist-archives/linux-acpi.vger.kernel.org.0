Return-Path: <linux-acpi+bounces-16137-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B8DB39B15
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 13:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99813361D79
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35B30E0DC;
	Thu, 28 Aug 2025 11:09:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C230DED4;
	Thu, 28 Aug 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379394; cv=none; b=Y6Fqtx1piX73RCeNgrkAh+8+dJgPTIH4SVKF7B2G49E9XudT9ssAXR0XSOPvAXISC4ljQXLsZiIge+sLS5U6c47vEYqyUxfsDijs1HnBs0VeuD12xkWrym9MXTFU2WgjZWqfdDzOafzxthWqK7mAZe5JCKFFQE4lZF7G7Zjj8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379394; c=relaxed/simple;
	bh=uIY1NW3Gz513zTpzuqhxErV1+9SdPYQy/NnPHB8ZdYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeBDw8//S2tzB8QycDX8neCb4EbdMvSGdEGfZtZ7BbXVou5BzkmCPHD6RgW50vngxLlH0uJVV/LHKfH/FEGfF6zAOU1bNyhWQy8kKNv8ZYKBQAbXzqeuo/kyuxaEllUGVs5SmthtsjoTswnbrP5KNTJCI52xNDhUSaAqKLJfu5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cCJZS1hDJz14MRB;
	Thu, 28 Aug 2025 19:09:36 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B7C81800B1;
	Thu, 28 Aug 2025 19:09:43 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemo100006.china.huawei.com (7.202.195.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 19:09:42 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 1/2] cpufreq: CPPC: Don't warn if FIE init fails to read counters
Date: Thu, 28 Aug 2025 19:02:11 +0800
Message-ID: <20250828110212.2108653-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemo100006.china.huawei.com (7.202.195.47)

During the CPPC FIE initialization, reading perf counters on offline cpus
should be expected to fail.  Don't warn on this case.

Also, change the error log level to debug since FIE is optional.

Co-developed-by: Bowen Yu <yubowen8@huawei.com>
Signed-off-by: Bowen Yu <yubowen8@huawei.com> # Changing loglevel to debug
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4a17162a392d..7724318b3415 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -144,16 +144,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
 
 		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
-		if (ret) {
-			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
+		if (ret && cpu_online(cpu)) {
+			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
 				__func__, cpu, ret);
-
-			/*
-			 * Don't abort if the CPU was offline while the driver
-			 * was getting registered.
-			 */
-			if (cpu_online(cpu))
-				return;
+			return;
 		}
 	}
 
-- 
2.33.0


