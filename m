Return-Path: <linux-acpi+bounces-8484-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D657B9892EC
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 05:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3281C21D88
	for <lists+linux-acpi@lfdr.de>; Sun, 29 Sep 2024 03:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF18B22F1C;
	Sun, 29 Sep 2024 03:38:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A9E18622;
	Sun, 29 Sep 2024 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727581112; cv=none; b=ZJ4saBBl+FtiqXeUfq+JCXVJEebvLSgUz1KWtMzPESAgQiJYi2yc6xsQcXbcOReuk0yCkfrIWu8Q7N9MHmJWGV+em95g+i+WtAYqY2q7sS3mhbd7hlCyTDfKYECXgpJbiNvYoYUJPJSFd/RvBE2ougGAUfQObyhICQIw7b/fYl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727581112; c=relaxed/simple;
	bh=QyhnZSCV/4kED/+WUoxOEjsEcTST7fFRK0mbp3oR//c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCEgRQWCBbHuPy1XHNQQ6c1UpXl64ZLSERTT3/J20ylCVped0bSNz8MCBfxVYzlztcHDwhtJwB2STcDNGrfdJ/ep6OYKWOsPqD5Vhc/mVaWT9waN6Q2dOJI/FgqR+5UE5KfB2/SZ2KzjCx/51dDmTwNKmBMjRbN33JxFdun9pXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XGVJN1dDmz2Dchg;
	Sun, 29 Sep 2024 11:37:24 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 579371A016C;
	Sun, 29 Sep 2024 11:38:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 11:38:16 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <wangxiongfeng2@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v4 1/2] cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged
Date: Sun, 29 Sep 2024 11:32:13 +0800
Message-ID: <20240929033214.1039485-2-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240929033214.1039485-1-zhanjie9@hisilicon.com>
References: <20240929033214.1039485-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)

The CPPC performance feedback counters could be 0 or unchanged when the
target cpu is in a low-power idle state, e.g. power-gated or clock-gated.

When the counters are 0, cppc_cpufreq_get_rate() returns 0 KHz, which makes
cpufreq_online() get a false error and fail to generate a cpufreq policy.

When the counters are unchanged, the existing cppc_perf_from_fbctrs()
returns a cached desired perf, but some platforms may update the real
frequency back to the desired perf reg.

For the above cases in cppc_cpufreq_get_rate(), get the latest desired perf
from the CPPC reg to reflect the frequency because some platforms may
update the actual frequency back there; if failed, use the cached desired
perf.

Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Zeng Heng <zengheng4@huawei.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
Reviewed-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 57 +++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 1a5ad184d28f..646b466002c6 100644
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
@@ -724,13 +727,31 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 	delta_delivered = get_delta(fb_ctrs_t1->delivered,
 				    fb_ctrs_t0->delivered);
 
-	/* Check to avoid divide-by zero and invalid delivered_perf */
+	/*
+	 * Avoid divide-by zero and unchanged feedback counters.
+	 * Leave it for callers to handle.
+	 */
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
@@ -746,18 +767,32 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
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
+			/* Any of the associated CPPC regs is 0. */
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
+	 * Use desired perf for reflecting frequency.  Get the latest register
+	 * value first as some platforms may update the actual delivered perf
+	 * there; if failed, resort to the cached desired perf.
+	 */
+	if (cppc_get_desired_perf(cpu, &delivered_perf))
+		delivered_perf = cpu_data->perf_ctrls.desired_perf;
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
 }
-- 
2.33.0


