Return-Path: <linux-acpi+bounces-17218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA939B9419C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 05:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F417F3A0
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 03:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0871254B19;
	Tue, 23 Sep 2025 03:24:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA1D2CCC0;
	Tue, 23 Sep 2025 03:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597891; cv=none; b=M2Y+baptPRLGglM+QE+K5JO7hW7fGBFyc6ZnnPiahUmRLaaKDmOFGDbMqYoVA0B3HIfNhusKx0mzECjrKsEixr07Mm5KAs78HUcViG5fcEIWro3dTshpJNGzTM5xOg3/P8Add7D++AGIkKbRPCtzmfrkzz53qjsaN20KK9QLuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597891; c=relaxed/simple;
	bh=46HhC5SLtwVI4XN+e8y+TLbM02Oo6hsorwteXb2ItHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7XoIFRpfRWkhw6LYuk2OA48szUdqWLSilAp/jN0VurqGXWA/V1PkRTf5fqgOisBB3nV+ii8E9rE+7lJU3yf9fUihrIl+W5crz7cz/t0HQd+7rnxDvheKxJ80ULCRGLzrTyDTg+Zqk3jeRFkMmYSxugm32M60AUIEIVK63w5vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cW4y1506Fz24htD;
	Tue, 23 Sep 2025 11:21:13 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B5001402C3;
	Tue, 23 Sep 2025 11:24:45 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 11:24:30 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Sep 2025 11:24:29 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
Subject: [PATCH v5 1/1] ACPI: processor: Do not expose the global acpi_idle_driver variable
Date: Tue, 23 Sep 2025 11:24:28 +0800
Message-ID: <20250923032428.2656329-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250923032428.2656329-1-lihuisong@huawei.com>
References: <20250923032428.2656329-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Currently, processor_driver just use the global acpi_idle_driver variable
to check if the cpuidle driver is acpi_idle_driver. Actually, there is no
need to expose this global variable defined in processor_idle.c to outside.
So move the related check to acpi_processor_power_init() and limit the
global variable to a static one.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_driver.c | 3 +--
 drivers/acpi/processor_idle.c   | 9 ++++++++-
 include/acpi/processor.h        | 1 -
 3 files changed, 9 insertions(+), 4 deletions(-)

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
index 698d14c19587..935ff2aa6f3a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -51,7 +51,7 @@ module_param(latency_factor, uint, 0644);
 
 static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
 
-struct cpuidle_driver acpi_idle_driver = {
+static struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
 };
@@ -1404,6 +1404,13 @@ void acpi_processor_power_init(struct acpi_processor *pr)
 {
 	struct cpuidle_device *dev;
 
+	/*
+	 * The code below only works if the current cpuidle driver is
+	 * acpi_idle_driver.
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


