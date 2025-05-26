Return-Path: <linux-acpi+bounces-13896-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC17AC3E9F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E134C189870F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D771FCFF3;
	Mon, 26 May 2025 11:31:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F081FA14E;
	Mon, 26 May 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259076; cv=none; b=drXVeQtZ/uIUWKHJej0N1j2+f7+TrUgY41GK7pq3iEmzTnVhYWSIyzXzhHtp2HvMfAmyYXfKB8QRksTUj7AiD0xFm0SXS91d2YaK+ptukbdcYXUq2NNvICpNA81zCPovhOM3ljB+cVhF/ZHl7eniPJu7kMMkG28xDYsfRDTlrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259076; c=relaxed/simple;
	bh=unQHwttsPk2VIVW8P5U8+Uwy9Nf2rG5/z0nIzV6CFQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbsqDoXJLWEhWdHKQr7QZGs9Z+fOEKyAehL+357dxb2ib2KK2k8bixTqaUqEQU9f/7LZpJo6W3uDblRHBg9SluQXKvZ3/K9N0/WWj1WMYp8BoVwv/bZkF3DLhl8HU4GqwxtNF9ULPzvXfbJbb6lgLYv4K2CDeznSBd4YaH3RyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4b5YS36gQHz1R7q2;
	Mon, 26 May 2025 19:28:51 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 64E6F140159;
	Mon, 26 May 2025 19:31:06 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 19:31:05 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robert.moore@intel.com>,
	<lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <yubowen8@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 3/3] cpufreq: CPPC: Remove forward declaration of cppc_cpufreq_register_em()
Date: Mon, 26 May 2025 19:30:57 +0800
Message-ID: <20250526113057.3086513-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

cppc_cpufreq_register_em() is only used in populate_efficiency_class(). A
forward declaration is not necessary. Move cppc_cpufreq_register_em() in
front of populate_efficiency_class() and remove the forward declaration of
cppc_cpufreq_register_em().

No functional change.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index c2be4b188a23..a1fd0ff22bc5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -344,7 +344,6 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 #if defined(CONFIG_ARM64) && defined(CONFIG_ENERGY_MODEL)
 
 static DEFINE_PER_CPU(unsigned int, efficiency_class);
-static void cppc_cpufreq_register_em(struct cpufreq_policy *policy);
 
 /* Create an artificial performance state every CPPC_EM_CAP_STEP capacity unit. */
 #define CPPC_EM_CAP_STEP	(20)
@@ -480,6 +479,18 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 	return 0;
 }
 
+static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data;
+	struct em_data_callback em_cb =
+		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
+
+	cpu_data = policy->driver_data;
+	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
+			get_perf_level_count(policy), &em_cb,
+			cpu_data->shared_cpu_map, 0);
+}
+
 static void populate_efficiency_class(void)
 {
 	struct acpi_madt_generic_interrupt *gicc;
@@ -514,18 +525,6 @@ static void populate_efficiency_class(void)
 	cppc_cpufreq_driver.register_em = cppc_cpufreq_register_em;
 }
 
-static void cppc_cpufreq_register_em(struct cpufreq_policy *policy)
-{
-	struct cppc_cpudata *cpu_data;
-	struct em_data_callback em_cb =
-		EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
-
-	cpu_data = policy->driver_data;
-	em_dev_register_perf_domain(get_cpu_device(policy->cpu),
-			get_perf_level_count(policy), &em_cb,
-			cpu_data->shared_cpu_map, 0);
-}
-
 #else
 static void populate_efficiency_class(void)
 {
-- 
2.33.0


