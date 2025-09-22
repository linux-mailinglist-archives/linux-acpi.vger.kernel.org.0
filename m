Return-Path: <linux-acpi+bounces-17170-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CE9B8F36C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 09:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ADF17A81A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC02EF662;
	Mon, 22 Sep 2025 07:04:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9E286A9;
	Mon, 22 Sep 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524641; cv=none; b=BRpv2gAII9sbrdHF1B5Z1yTXZ440inmDFeberXM8HPcMVgu1X5nOv6v+xpHR8kpr0QK3JNu773K/asdo79dtkf5xIrz2Jo+T9gtSfBzhO5YRS3ifXMfmE+K9b1ZEama4ukwQY6mp/f5WnTTL6RHv3IrRoLaW4D1IebrjOa8TL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524641; c=relaxed/simple;
	bh=L2nzYQ6JMIg/ONOfF4+3w4YUx0WkjbbxpvYbuajtGxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/ue2fMwQgQzcxDQx81kNp6dgwt10fJ8nR7UU/4eL5XouKpZKHtXMNe4gcyWrXAU3s8+Rfgjn4WWkroJ6q2IGD6RR/RaZuTXLd3k7iFyUwDrprCDjjQZqj3p6ny5rv4CyCXTUzYP3PjrBEjA1MDxNaaiRWp6FjwsVJbSr26m68M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cVYrX2hSVz13NQ5;
	Mon, 22 Sep 2025 14:59:40 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D90C1400D1;
	Mon, 22 Sep 2025 15:03:56 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 15:03:56 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 15:03:55 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v4 1/1] ACPI: processor: Do not expose the global acpi_idle_driver variable
Date: Mon, 22 Sep 2025 15:03:54 +0800
Message-ID: <20250922070354.485296-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250922070354.485296-1-lihuisong@huawei.com>
References: <20250922070354.485296-1-lihuisong@huawei.com>
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
So move the related check to acpi_processor_power_init() and limit the
global variable to a static one.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_driver.c |  3 +--
 drivers/acpi/processor_idle.c   | 12 +++++++++++-
 include/acpi/processor.h        |  1 -
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index de17c1412678..5d824435b26b 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -166,8 +166,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		dev_dbg(&device->dev, "CPPC data invalid or not present\n");
 
-	if (cpuidle_get_driver() == &acpi_idle_driver)
-		acpi_processor_power_init(pr);
+	acpi_processor_power_init(pr);
 
 	acpi_pss_perf_init(pr);
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 698d14c19587..42948495f4f1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -51,7 +51,7 @@ module_param(latency_factor, uint, 0644);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
-struct cpuidle_driver acpi_idle_driver = {
+static struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
 };
@@ -1402,8 +1402,18 @@ void acpi_processor_unregister_idle_driver(void)
 
 void acpi_processor_power_init(struct acpi_processor *pr)
 {
+	struct cpuidle_driver *drv = cpuidle_get_driver();
 	struct cpuidle_device *dev;
 
+	/*
+	 * Normally, the ACPI idle driver has already been registered before
+	 * CPU online. But the 'drv' may be NULL if register idle driver failed.
+	 * So do not anything if the idle driver isn't acpi_idle_driver or the
+	 * 'drv' is NULL.
+	 */
+	if (drv != &acpi_idle_driver)
+		return;
+
 	if (disabled_by_idle_boot_param())
 		return;
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 24fdaa3c2899..7146a8e9e9c2 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -417,7 +417,6 @@ static inline void acpi_processor_throttling_init(void) {}
 #endif	/* CONFIG_ACPI_CPU_FREQ_PSS */
 
 /* in processor_idle.c */
-extern struct cpuidle_driver acpi_idle_driver;
 #ifdef CONFIG_ACPI_PROCESSOR_IDLE
 void acpi_processor_power_init(struct acpi_processor *pr);
 void acpi_processor_power_exit(struct acpi_processor *pr);
-- 
2.33.0


