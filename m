Return-Path: <linux-acpi+bounces-8257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277A097629E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 09:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5533282C2B
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 07:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35E18DF7E;
	Thu, 12 Sep 2024 07:26:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C818BC3B;
	Thu, 12 Sep 2024 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125960; cv=none; b=G4G+WrX1L6gjvv8Is4ZxFmiFcYVxOjZIiEIThFaAonzn9HjFj9JcUBPuB2scpIuyQaV/yzGP5/7tVuR+srEg4WW/lTVlO3J7pejc50j4caZOovEgSysWGccf9Saja7/tZ3HYcDB0rQLrS8fAY0YQid2YD9pckGFt+4h0nOMMgbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125960; c=relaxed/simple;
	bh=c4ioEqFecD5E/kf42IBvdX0jUCQz95/TA9LubfcCzhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcW0bcwVBhL4V2UlTsO006B2xEt7l1SswTsKJeUlHrb3E80RS1XUmK5sqrlVEnysSv4oxQ45USyiBCMAXBAZD5I0RlQXwJSE2W/qz2nR1/Q/Up+UWGtug6TWuoLDEyxQi967KLAM3TvjZVKmL8VyYVkcRh8Glj84We6fb7l5sKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X489l65Z7z20nqw;
	Thu, 12 Sep 2024 15:25:47 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id BF90F1400D4;
	Thu, 12 Sep 2024 15:25:54 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 15:25:54 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<wangxiongfeng2@huawei.com>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<wanghuiqiang@huawei.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yangyicong@huawei.com>, <liaochang1@huawei.com>, <zengheng4@huawei.com>
Subject: [PATCH v2 3/3] cppc_cpufreq: Remove HiSilicon CPPC workaround
Date: Thu, 12 Sep 2024 15:20:01 +0800
Message-ID: <20240912072001.433980-4-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240912072001.433980-1-zhanjie9@hisilicon.com>
References: <20240912072001.433980-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)

Since 6c8d750f9784 ("cpufreq / cppc: Work around for Hisilicon CPPC cpufreq"),
we introduce a workround for HiSilicon platforms that do not support
performance feedback counters to get the actual frequency from the desired
performance register.  Later on, FIE is disabled in that workaround as
well.

Now the workround can be handled by the common code.  Desired perf would be
read and converted to frequency if feedback counters don't change.  FIE
would be disabled if the CPPC regs are in PCC region.

Hence, the workaround is no longer needed and can be safely removed, in an
effort to consolidate the cppc_cpufreq driver procedure.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 71 ----------------------------------
 1 file changed, 71 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index c8fe0f1fc22b..f48fc2a21fa8 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -36,24 +36,6 @@ static LIST_HEAD(cpu_data_list);
 
 static bool boost_supported;
 
-struct cppc_workaround_oem_info {
-	char oem_id[ACPI_OEM_ID_SIZE + 1];
-	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
-	u32 oem_revision;
-};
-
-static struct cppc_workaround_oem_info wa_info[] = {
-	{
-		.oem_id		= "HISI  ",
-		.oem_table_id	= "HIP07   ",
-		.oem_revision	= 0,
-	}, {
-		.oem_id		= "HISI  ",
-		.oem_table_id	= "HIP08   ",
-		.oem_revision	= 0,
-	}
-};
-
 static struct cpufreq_driver cppc_cpufreq_driver;
 
 static enum {
@@ -78,7 +60,6 @@ struct cppc_freq_invariance {
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
 static struct kthread_worker *kworker_fie;
 
-static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
 static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
@@ -834,57 +815,6 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.name = "cppc_cpufreq",
 };
 
-/*
- * HISI platform does not support delivered performance counter and
- * reference performance counter. It can calculate the performance using the
- * platform specific mechanism. We reuse the desired performance register to
- * store the real performance calculated by the platform.
- */
-static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
-{
-	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct cppc_cpudata *cpu_data;
-	u64 desired_perf;
-	int ret;
-
-	if (!policy)
-		return -ENODEV;
-
-	cpu_data = policy->driver_data;
-
-	cpufreq_cpu_put(policy);
-
-	ret = cppc_get_desired_perf(cpu, &desired_perf);
-	if (ret < 0)
-		return -EIO;
-
-	return cppc_perf_to_khz(&cpu_data->perf_caps, desired_perf);
-}
-
-static void cppc_check_hisi_workaround(void)
-{
-	struct acpi_table_header *tbl;
-	acpi_status status = AE_OK;
-	int i;
-
-	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
-	if (ACPI_FAILURE(status) || !tbl)
-		return;
-
-	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
-		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
-		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
-		    wa_info[i].oem_revision == tbl->oem_revision) {
-			/* Overwrite the get() callback */
-			cppc_cpufreq_driver.get = hisi_cppc_cpufreq_get_rate;
-			fie_disabled = FIE_DISABLED;
-			break;
-		}
-	}
-
-	acpi_put_table(tbl);
-}
-
 static int __init cppc_cpufreq_init(void)
 {
 	int ret;
@@ -892,7 +822,6 @@ static int __init cppc_cpufreq_init(void)
 	if (!acpi_cpc_valid())
 		return -ENODEV;
 
-	cppc_check_hisi_workaround();
 	cppc_freq_invariance_init();
 	populate_efficiency_class();
 
-- 
2.33.0


