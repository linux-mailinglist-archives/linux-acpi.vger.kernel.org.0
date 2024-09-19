Return-Path: <linux-acpi+bounces-8337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0497C644
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 10:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E669B20F94
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546861991AD;
	Thu, 19 Sep 2024 08:51:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E9199247;
	Thu, 19 Sep 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735915; cv=none; b=tZCkx522JhCxGMMGs4J+sG6LPei9rRH+bnlQujs7i+Mycoku77baT2zXfCkwJO+iPVTF74m2qybrpOVpE27xJmQHUhUgCkcHcg5r1yRAFk7/tJ7JRHWHRP0L1OcVvONNm8gwChx/NNmCu5dQB3c0UWCITAtXWMisGKapq+pfS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735915; c=relaxed/simple;
	bh=IqAS0Movy4BFYsQGAZNHcdrZatMN+0hZqM9XljpmpeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5c+ZYQsgrUqIlBdLu0XUGZeXCTyacohPp9D94z9YWdV4W+oTdf/dBGeG3Rl8+IuVJPadDv3mATqu1guy+42blM3hGBn0yBPwlhfc+iFHdptNxyT1CEUTLW3YNRx+c0m1Pt5cMgLyTDIsnn8QlG9LQBosmwmuU9KYmqqV0JPy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X8Tln4Xkdz1ym6V;
	Thu, 19 Sep 2024 16:51:49 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 407FA140202;
	Thu, 19 Sep 2024 16:51:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 16:51:48 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v3 1/2] cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged
Date: Thu, 19 Sep 2024 16:45:51 +0800
Message-ID: <20240919084552.3591400-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
References: <20240919084552.3591400-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500019.china.huawei.com (7.185.36.137)

The CPPC performance feedback counters could be 0 or unchanged when the
target cpu is in a low-power idle state, e.g. power-gated or clock-gated.

When the counters are 0, cppc_cpufreq_get_rate() returns 0 KHz, which makes
cpufreq_online() get a false error and fail to generate a cpufreq policy.

When the counters are unchanged, the existing cppc_perf_from_fbctrs()
returns a cached desired perf, but some platforms may update the real
frequency back to the desired perf reg.

For the above cases in cppc_cpufreq_get_rate(), get the latest desired perf
to reflect the frequency; if failed, return the cached desired perf.

Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Zeng Heng <zengheng4@huawei.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 49 +++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32dd375d..e55192303a9f 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -118,6 +118,9 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 
 	perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
 				     &fb_ctrs);
+	if (!perf)
+		return;
+
 	cppc_fi->prev_perf_fb_ctrs = fb_ctrs;
 
 	perf <<= SCHED_CAPACITY_SHIFT;
@@ -726,11 +729,26 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 
 	/* Check to avoid divide-by zero and invalid delivered_perf */
 	if (!delta_reference || !delta_delivered)
-		return cpu_data->perf_ctrls.desired_perf;
+		return 0;
 
 	return (reference_perf * delta_delivered) / delta_reference;
 }
 
+static int cppc_get_perf_ctrs_sample(int cpu,
+				     struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs *fb_ctrs_t1)
+{
+	int ret;
+
+	ret = cppc_get_perf_ctrs(cpu, fb_ctrs_t0);
+	if (ret)
+		return ret;
+
+	udelay(2); /* 2usec delay between sampling */
+
+	return cppc_get_perf_ctrs(cpu, fb_ctrs_t1);
+}
+
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
@@ -746,18 +764,29 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 	cpufreq_cpu_put(policy);
 
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
-	if (ret)
-		return 0;
-
-	udelay(2); /* 2usec delay between sampling */
-
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
-	if (ret)
-		return 0;
+	ret = cppc_get_perf_ctrs_sample(cpu, &fb_ctrs_t0, &fb_ctrs_t1);
+	if (ret) {
+		if (ret == -EFAULT)
+			goto out_invalid_counters;
+		else
+			return 0;
+	}
 
 	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
 					       &fb_ctrs_t1);
+	if (!delivered_perf)
+		goto out_invalid_counters;
+
+	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
+
+out_invalid_counters:
+	/*
+	 * Feedback counters could be unchanged or 0 when a cpu enters a
+	 * low-power idle state, e.g. clock-gated or power-gated.
+	 * Get the lastest or cached desired perf for reflecting frequency.
+	 */
+	if (cppc_get_desired_perf(cpu, &delivered_perf))
+		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
 }
-- 
2.33.0


