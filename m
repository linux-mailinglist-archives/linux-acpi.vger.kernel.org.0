Return-Path: <linux-acpi+bounces-15335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B8B13554
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 09:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833F43A8DBB
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Jul 2025 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660B2223335;
	Mon, 28 Jul 2025 07:06:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF059222575;
	Mon, 28 Jul 2025 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686417; cv=none; b=uaOLwRHSSA7un+aBXOtPy38CYBFPx2sAKrMHyWzp3+xLWq/wkGYQjz9LUrTHDnwMLDm7xdbhKMetERcFSs5dTYv8a2BDaYn5fG0g7GVFDwcovCTDxsQbYGDavAYTJrV+84ekrIYJpXrrJ7Ga4imdvS3ZEbgQe9CurrV9C/PfVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686417; c=relaxed/simple;
	bh=PoJ5vpei7VDSNOm7eT3THFt798AZZLZ4nqh5bZq0ljE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liO/fUuL4NnadbqyeKoU2sy4L90VNc3rYojehLkG2Gk7ULESHVz5zdN5eszc3Rhf9iFV3LwEpQ9n6pOGJtWE9J69m6Jn+IKx+1J4Nmhj4n7UogEAg67C14GzFiogDpCjHjBRs8wcTYTvt5+hiEm40O9NIDqN7oNfSWMeZW1Erco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4br8Y647JBzdc6y;
	Mon, 28 Jul 2025 15:02:02 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F19C1800B2;
	Mon, 28 Jul 2025 15:06:15 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 15:06:15 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Jul 2025 15:06:14 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v3 2/2] ACPI: processor: idle: Optimize acpi idle driver registration
Date: Mon, 28 Jul 2025 15:06:12 +0800
Message-ID: <20250728070612.1260859-3-lihuisong@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250728070612.1260859-1-lihuisong@huawei.com>
References: <20250728070612.1260859-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)

Currently, the acpi idle driver is registered from within a CPU
hotplug callback. Although this didn't cause any functional issues,
this is questionable and confusing. And it is better to register
the cpuidle driver when all of the CPUs have been brought up.

So add a new function to initialize acpi_idle_driver based on the
power management information of an available CPU and register cpuidle
driver in acpi_processor_driver_init().

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/acpi/processor_driver.c |  3 ++
 drivers/acpi/processor_idle.c   | 65 +++++++++++++++++++++------------
 include/acpi/processor.h        |  8 ++++
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 65e779be64ff..bc9f58a02c1d 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -263,6 +263,8 @@ static int __init acpi_processor_driver_init(void)
 	if (result < 0)
 		return result;
 
+	acpi_processor_register_idle_driver();
+
 	result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				   "acpi/cpu-drv:online",
 				   acpi_soft_cpu_online, NULL);
@@ -301,6 +303,7 @@ static void __exit acpi_processor_driver_exit(void)
 
 	cpuhp_remove_state_nocalls(hp_online);
 	cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
+	acpi_processor_unregister_idle_driver();
 	driver_unregister(&acpi_processor_driver);
 }
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 031738390f2d..c71802d42e8a 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1360,7 +1360,48 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
 	return 0;
 }
 
-static int acpi_processor_registered;
+void acpi_processor_register_idle_driver(void)
+{
+	struct acpi_processor *pr;
+	int ret = -ENODEV;
+	int cpu;
+
+	/*
+	 * Acpi idle driver is used by all possible CPUs.
+	 * Install the idle handler by the processor power info of one in them.
+	 * Note that we use previously set idle handler will be used on
+	 * platforms that only support C1.
+	 */
+	for_each_cpu(cpu, (struct cpumask *)cpu_possible_mask) {
+		pr = per_cpu(processors, cpu);
+		if (!pr)
+			continue;
+
+		ret = acpi_processor_get_power_info(pr);
+		if (!ret) {
+			pr->flags.power_setup_done = 1;
+			acpi_processor_setup_cpuidle_states(pr);
+			break;
+		}
+	}
+
+	if (ret) {
+		pr_debug("No ACPI power information from any CPUs.\n");
+		return;
+	}
+
+	ret = cpuidle_register_driver(&acpi_idle_driver);
+	if (ret) {
+		pr_debug("register %s failed.\n", acpi_idle_driver.name);
+		return;
+	}
+	pr_debug("%s registered with cpuidle.\n", acpi_idle_driver.name);
+}
+
+void acpi_processor_unregister_idle_driver(void)
+{
+	cpuidle_unregister_driver(&acpi_idle_driver);
+}
 
 int acpi_processor_power_init(struct acpi_processor *pr)
 {
@@ -1375,22 +1416,7 @@ int acpi_processor_power_init(struct acpi_processor *pr)
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
@@ -1403,13 +1429,10 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		 */
 		retval = cpuidle_register_device(dev);
 		if (retval) {
-			if (acpi_processor_registered == 0)
-				cpuidle_unregister_driver(&acpi_idle_driver);
 			kfree(dev);
 			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
 			return retval;
 		}
-		acpi_processor_registered++;
 	}
 	return 0;
 }
@@ -1423,10 +1446,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 
 	if (pr->flags.power) {
 		cpuidle_unregister_device(dev);
-		acpi_processor_registered--;
-		if (acpi_processor_registered == 0)
-			cpuidle_unregister_driver(&acpi_idle_driver);
-
 		kfree(dev);
 	}
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d0eccbd920e5..1249f5e81d92 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -423,6 +423,8 @@ int acpi_processor_power_init(struct acpi_processor *pr);
 int acpi_processor_power_exit(struct acpi_processor *pr);
 int acpi_processor_power_state_has_changed(struct acpi_processor *pr);
 int acpi_processor_hotplug(struct acpi_processor *pr);
+void acpi_processor_register_idle_driver(void);
+void acpi_processor_unregister_idle_driver(void);
 #else
 static inline int acpi_processor_power_init(struct acpi_processor *pr)
 {
@@ -443,6 +445,12 @@ static inline int acpi_processor_hotplug(struct acpi_processor *pr)
 {
 	return -ENODEV;
 }
+static void acpi_processor_register_idle_driver(void)
+{
+}
+static void acpi_processor_unregister_idle_driver(void)
+{
+}
 #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
 
 /* in processor_thermal.c */
-- 
2.33.0


