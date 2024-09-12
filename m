Return-Path: <linux-acpi+bounces-8262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 542DC9762AB
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36A81F23F7A
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3A18DF90;
	Thu, 12 Sep 2024 07:28:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8141885A0;
	Thu, 12 Sep 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126108; cv=none; b=EYsx/rN2GvPXe7oBSDPr2qZ3n+7ezcB3mBfPX1ZjsvHB9t0HlrgOcT5bf4Bid4Hyr/ZfS8YCqsBlC5rqROUgfJMSnaYDpNGZJS6mpxzOXmUIzTZ5X/nWAmxzSuDQOE2D0ho0KDarm58HmGhygF7rnJ8QcdmAjBnYfC5QIndwzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126108; c=relaxed/simple;
	bh=/H2YIJw5ievGhAEmnlbP90Lt0MUxvAMLUfrQg9NxiD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xhr4OAo7nbpLBgnIc6LjKeYBDBnYoCrxERiYWAyCLmpSUs1IUOSaMKKNjL4i4QaBbcyYqt58lLv7K8b/Wapu3fu+a77CQoGVEJhGtmwN4CLIsf1DnkuX3xkmHHB+Yo4B1pOu6kMVimckNJ5yLaifNyYsqz0Ra3JdlAyNAfU5zUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X48Dc5k62z20nvl;
	Thu, 12 Sep 2024 15:28:16 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id B32DC1A016C;
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
Subject: [PATCH v2 1/3] cppc_cpufreq: Return desired perf in ->get() if feedback counters are 0
Date: Thu, 12 Sep 2024 15:22:29 +0800
Message-ID: <20240912072231.439332-2-zhanjie9@hisilicon.com>
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

The CPPC performance feedback counters could return 0 when the target cpu
is in a deep idle state, e.g. powered off, and those counters are not
powered.  In this case, cppc_cpufreq_get_rate() returns 0, and hence,
cpufreq_online() gets a false error and doesn't generate a cpufreq policy,
which happens in cpufreq_add_dev() when a new cpu device is added.

Don't take it as an error and return the frequency corresponding to the
desired perf when the feedback counters are 0.

Fixes: 6a4fec4f6d30 ("cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.")
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32dd375d..6aa3af56924b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -748,18 +748,33 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
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
+	/*
+	 * Feedback counters could be 0 when cores are powered down.
+	 * Take desired perf for reflecting frequency in this case.
+	 */
+	if (ret == -EFAULT) {
+		ret = cppc_get_desired_perf(cpu, &delivered_perf);
+		if (ret)
+			return 0;
+
+		return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
+	}
+
+	return 0;
 }
 
 static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
-- 
2.33.0


