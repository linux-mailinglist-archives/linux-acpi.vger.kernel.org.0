Return-Path: <linux-acpi+bounces-15292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF429B0F1F2
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jul 2025 14:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB75B581FEE
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jul 2025 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC22E54C8;
	Wed, 23 Jul 2025 12:10:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F86212D83;
	Wed, 23 Jul 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272650; cv=none; b=Z+kypoBjno0MlcVnBVngSsEIAWszBw7kXdsQgagZ0+Nj++XlyixTg/vOrtGqObbKtWdFG4OmBA8MyFd2D4Vf6SPGBGxuipLSX3hApQN90xZ2XCR1+IUuTib/E9g9eG152n7fzfPnuxt3BLMpfBzDWdL4MkJjWlI8ak96BGd80uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272650; c=relaxed/simple;
	bh=uuZlp+3gTyNCopZQ+VugT7LYpsGTyKtvVYIaBL25s9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UlAJ1VA6UjRSMFU10oZg8G2F8XD2A87V0aH4umHVYEvHkO/SFNPqFpAjCo+WwchEJfD2wQL05bpYJlLUoUIE2UenC3YPycUESX3ccfeusjwH+RCnEVeg1lqgs8ohi1zASivAL65R/13VitTAPe8ow/lrfZosACp9cVNds48fNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bnCXd2Z1tz2CfxM;
	Wed, 23 Jul 2025 20:06:25 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B3F81401F1;
	Wed, 23 Jul 2025 20:10:35 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 20:10:35 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Jul 2025 20:10:34 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2] ACPI: processor: idle: Fix resource leak and potential concurrent in acpi_processor_power_init()
Date: Wed, 23 Jul 2025 20:10:34 +0800
Message-ID: <20250723121034.3685996-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100009.china.huawei.com (7.202.194.112)

There are three kind of issues:
1> There are two resource leak issues in acpi_processor_power_init:
   a> Don't unregister acpi_idle_driver when do kzalloc failed.
   b> Don't free cpuidle device memory when register cpuidle device failed.
2> There isn't lock to prevent the global acpi_processor_registered, which
   may lead to concurrent register cpuidle driver.
3> The cpuidle driver should be registered in advance when all of the CPUs
   have been brought up instead of being in a CPU hotplug callback.

To solve these issues, so add a new function to initialize acpi_idle_driver
based on the power management information of an available CPU and register
cpuidle driver in acpi_processor_driver_init().

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 v2: register cpuidle driver in advance when all of the CPUs have been
     brought up.
     v1 link: https://patchwork.kernel.org/project/linux-acpi/patch/20250619061327.1674384-1-lihuisong@huawei.com/
---
 drivers/acpi/processor_driver.c |  5 +++
 drivers/acpi/processor_idle.c   | 71 ++++++++++++++++++++++-----------
 include/acpi/processor.h        |  9 +++++
 3 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 65e779be64ff..ff944c93b6ff 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -263,6 +263,10 @@ static int __init acpi_processor_driver_init(void)
 	if (result < 0)
 		return result;
 
+	result = acpi_processor_register_idle_driver();
+	if (result)
+		pr_info("register idle driver failed, ret = %d.\n", result);
+
 	result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				   "acpi/cpu-drv:online",
 				   acpi_soft_cpu_online, NULL);
@@ -301,6 +305,7 @@ static void __exit acpi_processor_driver_exit(void)
 
 	cpuhp_remove_state_nocalls(hp_online);
 	cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
+	acpi_processor_unregister_idle_driver();
 	driver_unregister(&acpi_processor_driver);
 }
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2c2dc559e0f8..2408f1076631 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1360,7 +1360,52 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	return 0;
 }
 
-static int acpi_processor_registered;
+int acpi_processor_register_idle_driver(void)
+{
+	struct acpi_processor *pr;
+	int cpu;
+	int ret;
+
+	/*
+	 * Acpi idle driver is used by all possible CPUs.
+	 * Install the idle handler by the processor power info of one in them.
+	 * Note that we use previously set idle handler will be used on
+	 * platforms that only support C1.
+	 */
+	for_each_cpu(cpu, (struct cpumask *)cpu_possible_mask) {
+		pr = per_cpu(processors, cpu);
+		if (pr == NULL)
+			continue;
+
+		ret = acpi_processor_get_power_info(pr);
+		if (!ret) {
+			pr->flags.power_setup_done = 1;
+			break;
+		}
+	}
+
+	if (unlikely(!pr))
+		return -ENODEV;
+
+	if (ret) {
+		pr_err("%s get power information failed.\n",
+		       acpi_idle_driver.name);
+		return ret;
+	}
+
+	acpi_processor_setup_cpuidle_states(pr);
+	ret = cpuidle_register_driver(&acpi_idle_driver);
+	if (ret)
+		return ret;
+
+	pr_debug("%s registered with cpuidle\n", acpi_idle_driver.name);
+	return 0;
+}
+
+void acpi_processor_unregister_idle_driver(void)
+{
+	cpuidle_unregister_driver(&acpi_idle_driver);
+}
 
 int acpi_processor_power_init(struct acpi_processor *pr)
 {
@@ -1375,22 +1420,7 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 	if (!acpi_processor_get_power_info(pr))
 		pr->flags.power_setup_done = 1;
 
-	/*
-	 * Install the idle handler if processor power management is supported.
-	 * Note that we use previously set idle handler will be used on
-	 * platforms that only support C1.
-	 */
 	if (pr->flags.power) {
-		/* Register acpi_idle_driver if not already registered */
-		if (!acpi_processor_registered) {
-			acpi_processor_setup_cpuidle_states(pr);
-			retval = cpuidle_register_driver(&acpi_idle_driver);
-			if (retval)
-				return retval;
-			pr_debug("%s registered with cpuidle\n",
-				 acpi_idle_driver.name);
-		}
-
 		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 		if (!dev)
 			return -ENOMEM;
@@ -1403,11 +1433,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		 */
 		retval = cpuidle_register_device(dev);
 		if (retval) {
-			if (acpi_processor_registered == 0)
-				cpuidle_unregister_driver(&acpi_idle_driver);
+			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
+			kfree(dev);
 			return retval;
 		}
-		acpi_processor_registered++;
 	}
 	return 0;
 }
@@ -1421,10 +1450,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 
 	if (pr->flags.power) {
 		cpuidle_unregister_device(dev);
-		acpi_processor_registered--;
-		if (acpi_processor_registered == 0)
-			cpuidle_unregister_driver(&acpi_idle_driver);
-
 		kfree(dev);
 	}
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d0eccbd920e5..3cb41a3f2d9a 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -423,6 +423,8 @@ int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
+int acpi_processor_register_idle_driver(void);
+void acpi_processor_unregister_idle_driver(void);
 #else
 static inline int acpi_processor_power_init(struct acpi_processor *pr)
 {
@@ -443,6 +445,13 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 {
 	return -ENODEV;
 }
+static int acpi_processor_register_idle_driver(void)
+{
+	return -ENODEV;
+}
+static void acpi_processor_unregister_idle_driver(void)
+{
+}
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-- 
2.33.0


