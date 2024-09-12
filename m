Return-Path: <linux-acpi+bounces-8263-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FAD9762AD
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 09:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C4B6B2260B
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Sep 2024 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2B18E03A;
	Thu, 12 Sep 2024 07:28:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423018C90C;
	Thu, 12 Sep 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126108; cv=none; b=kBAPpG3DZfTzemkTc/dl1+Ws6YQhk1SstcEcDE0ULju6kzQ3HArhbkRjJHdmqucgRLyjmtd/9Fij6zQWN9Vl+0rgH8u+dMWG4GczaKhjVJFuqht14nf3CY3QNf9+yzEIlceoc5e4VFy5X6yHXfqDxFNcq0ybIDXMoefQYqGo8Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126108; c=relaxed/simple;
	bh=c4ioEqFecD5E/kf42IBvdX0jUCQz95/TA9LubfcCzhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UK8J0Wqo3UDTA1WBAEqeaETWg0f6EqYhzQ8+Qv5RVYC+M0xMV2J2rNYiVMz2cBNv7IdVb7qAi/tqJRK8K6RC6V52mDkbsKQ161kxS4HfR+wBY67/l21rDxr30cS/s0amGZK7wpK9Ae86CEmGcvvYuBkVcJqraXjqGgUri9F8wOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X48Cs3KxqzyRj4;
	Thu, 12 Sep 2024 15:27:37 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (unknown [7.185.36.137])
	by mail.maildlp.com (Postfix) with ESMTPS id 25D8C1800D4;
	Thu, 12 Sep 2024 15:28:24 +0800 (CST)
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
Subject: [PATCH v2 3/3] cppc_cpufreq: Remove HiSilicon CPPC workaround
Date: Thu, 12 Sep 2024 15:22:31 +0800
Message-ID: <20240912072231.439332-4-zhanjie9@hisilicon.com>
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


