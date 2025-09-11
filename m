Return-Path: <linux-acpi+bounces-16665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CD2B53029
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A02F3BBA2B
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Sep 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861583191BF;
	Thu, 11 Sep 2025 11:24:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA331076D;
	Thu, 11 Sep 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589856; cv=none; b=ryVFiNOgKVcw2YEInMwWyObiBscRJqIQPSh7ELn3nPWkoxlgSOfXgXn/2kHIhaVTSZBTeo5fKhWnupr29n6nyzwMuQD9rig4HbkzybL5fdzhO3ed5hoVJxYpY+j2D4h36CxIw/GPspmjEnMKE/Au3BJT3vlQcFGI2Yxrq3Ke/xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589856; c=relaxed/simple;
	bh=vbYroXDGR6aQhaF7Dk7laHsGUNOP3u4tHbEzK0uRwd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4X4epnP5QnNPAphzj5IewxerIAmbrv/gOihQ4zLvH+itEXOm7VGnI7HGq0NY54R6I86hibhkmbbyQBRfSsXz/9eCCRANkQ3cTGUIsdTHpKzpgOfTgj3amLf33NkC/66JxjJTptR+kWtexGgYpd3nfLHuy/gOzW/+L1lJeAbIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cMw922dY2z2VRj3;
	Thu, 11 Sep 2025 19:20:54 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A56E4180042;
	Thu, 11 Sep 2025 19:24:11 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:11 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Sep 2025 19:24:10 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v3 3/3] ACPI: processor: Do not expose the global acpi_idle_driver variable
Date: Thu, 11 Sep 2025 19:24:08 +0800
Message-ID: <20250911112408.1668431-4-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250911112408.1668431-1-lihuisong@huawei.com>
References: <20250911112408.1668431-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Currently, processor_driver just use the global acpi_idle_driver variable
to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
need to expose this global variable defined in processor_idle.c to outside.
So move the related logical to acpi_processor_power_init() and do not
expose it.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_driver.c | 3 +--
 drivers/acpi/processor_idle.c   | 5 +++++
 include/acpi/processor.h        | 1 -
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index bc9f58a02c1d..5d824435b26b 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
-	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
-		acpi_processor_power_init(pr);
+	acpi_processor_power_init(pr);
 
 	acpi_pss_perf_init(pr);
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5dacf41d7cc0..967fb13f38fa 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1404,6 +1404,11 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 {
 	int retval;
 	struct cpuidle_device *dev;
+	struct cpuidle_driver *drv;
+
+	drv = cpuidle_get_driver();
+	if (drv && drv != &acpi_idle_driver)
+		return 0;
 
 	if (disabled_by_idle_boot_param())
 		return 0;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 6ee4a69412de..bd96dde5eef5 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -417,7 +417,6 @@ static inline void acpi_processor_throttling_init(void) {}
 #endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 /* in processor_idle.c */
-extern struct cpuidle_driver acpi_idle_driver;
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
 int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
-- 
2.33.0


