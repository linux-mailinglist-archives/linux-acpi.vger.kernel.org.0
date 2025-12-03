Return-Path: <linux-acpi+bounces-19398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1BBC9DA42
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 04:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 653224E0363
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 03:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31542550D4;
	Wed,  3 Dec 2025 03:25:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379EE23E355;
	Wed,  3 Dec 2025 03:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732334; cv=none; b=WIjWTE8eT5cddqpaHUFqXQAp/mFxClNJJU2fvgXVdkNbTqwa/+hfnxFrwa8567dNKt4ZpOEVNyxHPkILnJjdpEaw/cUJ02rlB2HP8ewRZGN+dB+sn70tndjE/0hptLu6SlCdWvDJIFVrKkRBBhJKwLUC1LJ+7kOPgJtNLLo/tZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732334; c=relaxed/simple;
	bh=H4hTHX4jFPl3zNI4/doaj9kvmocQfS77a6wagBHhf78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRdwwHYu1b2jgoBZ5waNmJ7s2OEQi+aJfj4XMv0MUjt5xyxr3ACk87/Ovw5MF+FFbPDlf/X9k2uVbbdXa0QwB+ibRCjpBVbI7wtH6QVPGLglyl9O33BnajPIEoP7G2fyJ2DOOuWI9MFE57nVF52r3m7lzVh2BJ1GiwxveyHgv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dLjdv3zRSzKmB0;
	Wed,  3 Dec 2025 11:23:31 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 31A1C140278;
	Wed,  3 Dec 2025 11:25:24 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemf200017.china.huawei.com (7.202.181.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Dec 2025 11:25:23 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <pierre.gondois@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<zhanjie9@hisilicon.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <yubowen8@huawei.com>, <lihuisong@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>
Subject: [PATCH v4 2/3] cpufreq: CPPC: Factor out cppc_fie_kworker_init()
Date: Wed, 3 Dec 2025 11:24:21 +0800
Message-ID: <20251203032422.3232957-3-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)

Factor out the CPPC FIE kworker init in cppc_freq_invariance_init() because
it's a standalone procedure for use when the CPC regs are in PCC channels.

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


