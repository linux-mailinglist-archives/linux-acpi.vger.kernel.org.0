Return-Path: <linux-acpi+bounces-13895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB72AC3E9B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A91C3BA258
	for <lists+linux-acpi@lfdr.de>; Mon, 26 May 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE4A1FBC8C;
	Mon, 26 May 2025 11:31:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C610E3;
	Mon, 26 May 2025 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748259074; cv=none; b=J3xMI42LZQDVcG+A+9AJCenK7b1URbS7H+LRWr+d00uEj6PtXwgC754TlUXP8U8ttk2s7I1MtZLGL2VyFL2fJ+ZXy+24neUlJBznwyl4XDVuiDOMCvz/W2lY9EWlNg9Z4wS2opcST+1Rfu1pslZyJijwJyX2XRpuCZZU8/Eb5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748259074; c=relaxed/simple;
	bh=dRcllTXN6ir7VlcxJsOJStnO5Bo4WPD49cLbnqKDFR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJNH8xsl49uQ5/fsjZ7ruW0p4f8UvUfkxg+Xmtx2cNw/NUetegFD/dkdXxPsObwOxiJSm7JEVKJ4D6JUjcHhh9NvICyb6yTufj4a8g19rwzgN8xAloqSYQ/jGV5wtHiqsVaQMEHa9RKBJ8HVGRRlEpC2NN7VWOaqzByRbQkAsZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4b5YQJ5sLBzLphJ;
	Mon, 26 May 2025 19:27:20 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 30A03180489;
	Mon, 26 May 2025 19:31:05 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 19:31:04 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robert.moore@intel.com>,
	<lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <yubowen8@huawei.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 1/3] cpufreq: CPPC: Remove cpu_data_list
Date: Mon, 26 May 2025 19:30:55 +0800
Message-ID: <20250526113057.3086513-2-zhenglifeng1@huawei.com>
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

After commit a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a
list"), cpu_data can be got from policy->driver_data, so cpu_data_list is
not actually needed and can be removed.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 25 -------------------------
 include/acpi/cppc_acpi.h       |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b7c688a5659c..f3b5ea9fcbf5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -26,14 +26,6 @@
 
 #include <acpi/cppc_acpi.h>
 
-/*
- * This list contains information parsed from per CPU ACPI _CPC and _PSD
- * structures: e.g. the highest and lowest supported performance, capabilities,
- * desired performance, level requested etc. Depending on the share_type, not
- * all CPUs will have an entry in the list.
- */
-static LIST_HEAD(cpu_data_list);
-
 static struct cpufreq_driver cppc_cpufreq_driver;
 
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
@@ -567,8 +559,6 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_data(unsigned int cpu)
 		goto free_mask;
 	}
 
-	list_add(&cpu_data->node, &cpu_data_list);
-
 	return cpu_data;
 
 free_mask:
@@ -583,7 +573,6 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 
-	list_del(&cpu_data->node);
 	free_cpumask_var(cpu_data->shared_cpu_map);
 	kfree(cpu_data);
 	policy->driver_data = NULL;
@@ -954,24 +943,10 @@ static int __init cppc_cpufreq_init(void)
 	return ret;
 }
 
-static inline void free_cpu_data(void)
-{
-	struct cppc_cpudata *iter, *tmp;
-
-	list_for_each_entry_safe(iter, tmp, &cpu_data_list, node) {
-		free_cpumask_var(iter->shared_cpu_map);
-		list_del(&iter->node);
-		kfree(iter);
-	}
-
-}
-
 static void __exit cppc_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&cppc_cpufreq_driver);
 	cppc_freq_invariance_exit();
-
-	free_cpu_data();
 }
 
 module_exit(cppc_cpufreq_exit);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 325e9543e08f..20f3d62e7a16 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -139,7 +139,6 @@ struct cppc_perf_fb_ctrs {
 
 /* Per CPU container for runtime CPPC management. */
 struct cppc_cpudata {
-	struct list_head node;
 	struct cppc_perf_caps perf_caps;
 	struct cppc_perf_ctrls perf_ctrls;
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
-- 
2.33.0


