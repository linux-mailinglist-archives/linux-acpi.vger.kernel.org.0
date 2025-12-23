Return-Path: <linux-acpi+bounces-19809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31405CD8CFD
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 11:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A5AD302AAD7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 10:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A3636403D;
	Tue, 23 Dec 2025 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="XvcfvQv9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D543624C4;
	Tue, 23 Dec 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484566; cv=none; b=QF2NnWv+pGNJU1BtBGJOf9XoF5jW0XQ6zO8tWqYMEl8vXeDBc9XstmgOwucqiR3LpU78cLACJ6VGBPv6wc4p/9FWjpgtqsmGIX6uaPrFy8yXf74s3PydettucO6ig66kFRj2P5S1ES9i6GWNQ3KbmNLLoZTc/g/Fus9XaefxW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484566; c=relaxed/simple;
	bh=xjJgVzevI7HzLLzS6cbEenhrsLBbDdMKYjyO5SzKePo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+cMApWLxDSxIvybgb6qodYiJApZkSOYGMUZtU9+8k9RO9esg9L2F/7JWMd9g/hKUCfyw+En9rsZvfcbOsRuk9FcsDPj1UFFO0cHyoBWAoKE2Aqng5oQgS/EZFyLKEEz9vC6ZCopMa8hZlGjHwV8H4QO7iTPDWt8BUVqrSuMJNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=XvcfvQv9; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UPh1p6LjMfqkD0orD8NtZ2++bQcUVm2VdFSnmxsJOeo=;
	b=XvcfvQv9csAAUcv56FtIEmp4HZz3woTiXIxYBejv7McxFKuliZWCAJLUL7u0w5zDfYeZiVKeA
	cTNxLiBO/GHV02m8nLLrxEyJK/h7YClxyrvJI54iC3KSTwHF0fSEvIdU2MsJYWfQ2uVrZighZNy
	GxraKLDS4W3Y3IzM/8iFu0k=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4db9dD24fMznTZb;
	Tue, 23 Dec 2025 18:06:08 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E5074056E;
	Tue, 23 Dec 2025 18:09:21 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 18:09:18 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Dec 2025 18:09:18 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<AmandeepKaur.Longia@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 6/6] ACPI: processor: Do not expose global variable acpi_idle_driver
Date: Tue, 23 Dec 2025 18:09:14 +0800
Message-ID: <20251223100914.2407069-7-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251223100914.2407069-1-lihuisong@huawei.com>
References: <20251223100914.2407069-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Move the cpuidle driver check from __acpi_processor_start() to
acpi_processor_power_init() which allows variable acpi_idle_driver to
become static.

No intentional functional impact.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Link: https://patch.msgid.link/20250923032428.2656329-2-lihuisong@huawei.com
[ rjw: Subject tweak, new changelog, adjustment of a new comment ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_driver.c | 3 +--
 drivers/acpi/processor_idle.c   | 9 ++++++++-
 include/acpi/processor.h        | 1 -
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index f5b4f6a29143..882709796b4f 100644
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
index 05425d1b3ef7..427423e7a0c7 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -51,7 +51,7 @@ module_param(latency_factor, uint, 0644);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
-struct cpuidle_driver acpi_idle_driver = {
+static struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
 };
@@ -1395,6 +1395,13 @@ void acpi_processor_power_init(struct acpi_processor *pr)
 {
 	struct cpuidle_device *dev;
 
+	/*
+	 * The code below only works if the current cpuidle driver is the ACPI
+	 * idle driver.
+	 */
+	if (cpuidle_get_driver() != &acpi_idle_driver)
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


