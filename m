Return-Path: <linux-acpi+bounces-8260-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF59762A6
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 09:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1A61C230D4
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 07:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEDE18C929;
	Thu, 12 Sep 2024 07:28:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A3126BFC;
	Thu, 12 Sep 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126107; cv=none; b=q3hyYaex3hvYR9xLQGBlFm/XxX2dQBYP3Tw8jUlTNpzi4cGI4YGPYRK4YAkpXefbCfypLG17NQ2/9YkwVRCsT6dzSWwf8cqAwrigusvzundCEczz27OSrcmlxdlFdRrRDPnIcGtjCU9muYaj8lAYhLFrUtELi5f2GNQBxBC2bwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126107; c=relaxed/simple;
	bh=JotTQJcuWSc00JIJPC8d+bnar+Q9+Y541r+0jRM3BAI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ3xLqR0wv/Pmq9j4IYGckI9TNtyhwMeKmnupjF56UmXpGFGhUsTYoCtgnI1IOepJYgMGyq7bgq90g/ce+f0e258okizVwXSNap1cH71MwMTGRnHeZimgliA/qNfhIpXdu1UYqJrHWCIw9I0i50TTVckgptCnct0oORLuUm+CRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X48Dc6ycjz20nvn;
	Thu, 12 Sep 2024 15:28:16 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id DE3951401F4;
	Thu, 12 Sep 2024 15:28:23 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 15:28:23 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v2 2/3] cppc_cpufreq: Return latest desired perf if feedback counters don't change
Date: Thu, 12 Sep 2024 15:22:30 +0800
Message-ID: <20240912072231.439332-3-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240912072231.439332-1-zhanjie9@hisilicon.com>
References: <20240912072231.439332-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500019.china.huawei.com (7.185.36.137)

The existing cppc_perf_from_fbctrs() returns a cached desired perf if the
delta of feedback counters is 0.  Some platforms may update the real
frequency back to the desired perf reg.  Try getting the latest desired
perf first; if failed, return the cached desired perf.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 6aa3af56924b..c8fe0f1fc22b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -715,7 +715,8 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
-	u64 reference_perf;
+	u64 reference_perf, desired_perf;
+	int cpu, ret;
 
 	reference_perf = fb_ctrs_t0->reference_perf;
 
@@ -725,8 +726,14 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 				    fb_ctrs_t0->delivered);
 
 	/* Check to avoid divide-by zero and invalid delivered_perf */
-	if (!delta_reference || !delta_delivered)
-		return cpu_data->perf_ctrls.desired_perf;
+	if (!delta_reference || !delta_delivered) {
+		cpu = cpumask_first(cpu_data->shared_cpu_map);
+		ret = cppc_get_desired_perf(cpu, &desired_perf);
+		if (ret)
+			return cpu_data->perf_ctrls.desired_perf;
+
+		return desired_perf;
+	}
 
 	return (reference_perf * delta_delivered) / delta_reference;
 }
-- 
2.33.0


