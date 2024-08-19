Return-Path: <linux-acpi+bounces-7644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9591B956244
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 06:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACD11F222E8
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 04:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41F014B945;
	Mon, 19 Aug 2024 03:57:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6813D2BE;
	Mon, 19 Aug 2024 03:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039852; cv=none; b=ehR+fapHH7wxhisox/tTH/OaNzPLGmDOb1gAIQ689q77lsWwwkiMjNknCGTEzO9nD5YuAR4WTQrxsSXf8jS9I36/iNYk2BH0K6QQBqS8njW/5D9cpoyB5ePriZH+s49SU1S9fuUgvxyH14GuFPijze+hEgNFSRcAsSG128gMyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039852; c=relaxed/simple;
	bh=MeoyMJD/FG2lYYutmTBc5FDnGdYbT1KGGBnk1Gw5ieA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JmK8go8TBeGddfhsWeh/ECc3FvSwE+7kADXWIn55n8dvUqHXpMYfLR5WoiTYefvZQWGN5Qr+cmilC3ygiEolaeaqW8ZFwBwzbgoiiZ70dLQQzlvn/lpbXuw/q1Cm/T3bUYzeUOQTnRmIynnXa3UonU+NaldvIlNXv/8fKFIDbdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnJfk17WfzpTF8;
	Mon, 19 Aug 2024 11:55:58 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 16542140159;
	Mon, 19 Aug 2024 11:57:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 11:57:25 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxarm@huawei.com>, <liaochang1@huawei.com>, <zhanjie9@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH] cpufreq: CPPC: Return desired perf in ->get() if feedback counters are 0
Date: Mon, 19 Aug 2024 11:51:47 +0800
Message-ID: <20240819035147.2239767-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)

The CPPC performance feedback counters could return 0 when the target cpu
is in a deep idle state (e.g. powered off) and those counters are not
powered.  cppc_cpufreq_get_rate() returns 0 in this case, triggering two
problems:

1. cpufreq_online() gets a false error and doesn't generate a cpufreq
policy, which happens in cpufreq_add_dev() when a new cpu device is added.
2. 'cpuinfo_cur_freq' shows '<unknown>'

Don't take it as an error and return the frequency corresponding to the
desired perf when the feedback counters are 0.

Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32dd375d..1c5eb12c1a5a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -748,18 +748,25 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
 	if (ret)
-		return 0;
+		goto out_err;
 
 	udelay(2); /* 2usec delay between sampling */
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
 	if (ret)
-		return 0;
+		goto out_err;
 
 	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
 					       &fb_ctrs_t1);
 
 	return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
+
+out_err:
+	if (ret == -EFAULT)
+		return cppc_perf_to_khz(&cpu_data->perf_caps,
+					cpu_data->perf_ctrls.desired_perf);
+
+	return 0;
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
-- 
2.33.0


