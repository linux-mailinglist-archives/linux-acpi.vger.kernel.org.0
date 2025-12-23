Return-Path: <linux-acpi+bounces-19794-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3623ECD85F5
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 08:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37BEB3018420
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 07:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E0306B3D;
	Tue, 23 Dec 2025 07:23:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C822068F;
	Tue, 23 Dec 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766474624; cv=none; b=Krnekokc7VEYFPMxSf22bsfZ7Ys7p0oTB7qNNy39Z202cQz2dyavAXraIu9mEXkhY7VJy/GLsStCIeRB6De3MD83PALctpcAI4BM1k15DWUN4U2Fjarr0496vYomt8l/d6j9yaicGd7oI9Me54VO/NbqP0/ZZpr3p9vxSlDThKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766474624; c=relaxed/simple;
	bh=beX0JadXz2cxS1VmJlIMvL+HFk8vzK2c2tXE1RonJf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3YWWY/aqwBEw6ALziF8gk59eZHFQ659UvkxnTMnu6vq2wjoZ3/Iz5vExxqkOLMkvaSVZsoqZvftlYzDIf5dm+RX/ytKO2cAR2kSt/9qqscqPDIEzxl47WdVlsCAHgjwcv6db0Fq/GDI3bBV750ulL8c+JzyAMys7wZiyLZRdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4db5y92wgTzRhSY;
	Tue, 23 Dec 2025 15:20:33 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A1A4201EB;
	Tue, 23 Dec 2025 15:23:40 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 15:23:39 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v5 2/3] cpufreq: CPPC: Factor out cppc_fie_kworker_init()
Date: Tue, 23 Dec 2025 15:21:18 +0800
Message-ID: <20251223072119.3372582-3-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251223072119.3372582-1-zhanjie9@hisilicon.com>
References: <20251223072119.3372582-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Factor out the CPPC FIE kworker init in cppc_freq_invariance_init() because
it's a standalone procedure for use when the CPC regs are in PCC channels.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9eac77c4f294..947b4e2e1d4e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -184,7 +184,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	}
 }
 
-static void __init cppc_freq_invariance_init(void)
+static void cppc_fie_kworker_init(void)
 {
 	struct sched_attr attr = {
 		.size		= sizeof(struct sched_attr),
@@ -201,17 +201,6 @@ static void __init cppc_freq_invariance_init(void)
 	};
 	int ret;
 
-	if (fie_disabled != FIE_ENABLED && fie_disabled != FIE_DISABLED) {
-		fie_disabled = FIE_ENABLED;
-		if (cppc_perf_ctrs_in_pcc()) {
-			pr_info("FIE not enabled on systems with registers in PCC\n");
-			fie_disabled = FIE_DISABLED;
-		}
-	}
-
-	if (fie_disabled)
-		return;
-
 	kworker_fie = kthread_run_worker(0, "cppc_fie");
 	if (IS_ERR(kworker_fie)) {
 		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
@@ -229,6 +218,22 @@ static void __init cppc_freq_invariance_init(void)
 	}
 }
 
+static void __init cppc_freq_invariance_init(void)
+{
+	if (fie_disabled != FIE_ENABLED && fie_disabled != FIE_DISABLED) {
+		fie_disabled = FIE_ENABLED;
+		if (cppc_perf_ctrs_in_pcc()) {
+			pr_info("FIE not enabled on systems with registers in PCC\n");
+			fie_disabled = FIE_DISABLED;
+		}
+	}
+
+	if (fie_disabled)
+		return;
+
+	cppc_fie_kworker_init();
+}
+
 static void cppc_freq_invariance_exit(void)
 {
 	if (fie_disabled)
-- 
2.33.0


