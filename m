Return-Path: <linux-acpi+bounces-19803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC13DCD8D12
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EECD301EDDF
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17B362137;
	Tue, 23 Dec 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="WsgDX2XV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FB362128;
	Tue, 23 Dec 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484561; cv=none; b=g+rNOSvTiDEO17P0GrdeScnvsnDXkSrlmYC/RylxgPzEo5WMFMY2uHkeJ2whEwG6dbBDVLK2d9gVCAAnk8U2wtju+YeAtswfrT0Q6POHGr5UIU/xQ+kHTFwOWw6v+KcrxtuPxG4EWw7lfgYroJLeihDYq9/8FZQ8Jmo/oM4gMUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484561; c=relaxed/simple;
	bh=5iOoa6o7kPrMy3Gj5oVmhDTpUlAecYaTnK0Lk0GSeII=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFvLsgl/hODtuoS9FtIqGRuYUjYxL/VOdVfmV8ZDmuV4j+n20i+9XlKY7TBmfjjAk2L6H7DzTxAF/m2P8y8EyRgfT9yM+MAZHQDxNdrzlL2KzL+ZLHNayTfEwmS7445wubdt/pGy9GDsl2RgTX3M2IH/JNauzUl3c26c/fHpYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=WsgDX2XV; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qyo+7B1kYT/7BRg6pR5vvli089fnI96ZXjvc9VrY0+k=;
	b=WsgDX2XVayAhBxW3VudqMX8cHufg7ralB7MUC/toxI/aABnUWnj/jsTXOvlFgirT4v6RikiVT
	2gf4Un7Rinj5T8/5HRqMMZO11RpSJJDFQK6ANtBtHLNsUmT18lQOPG+cN/iprtrjKnHZsSqJkTo
	JAQc6gepYqmcbs47blTsJ14=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4db9dG49yjzLlTC;
	Tue, 23 Dec 2025 18:06:10 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 488FC40538;
	Tue, 23 Dec 2025 18:09:16 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 18:09:16 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Dec 2025 18:09:15 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<AmandeepKaur.Longia@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<prime.zeng@hisilicon.com>, <lihuisong@huawei.com>
Subject: [PATCH v1 1/6] ACPI: processor: idle: Optimize ACPI idle driver registration
Date: Tue, 23 Dec 2025 18:09:09 +0800
Message-ID: <20251223100914.2407069-2-lihuisong@huawei.com>
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

Currently, the ACPI idle driver is registered from within a CPU
hotplug callback. Although this didn't cause any functional issues,
this is questionable and confusing. And it is better to register
the cpuidle driver when all of the CPUs have been brought up.

So add a new function to initialize acpi_idle_driver based on the
power management information of an available CPU and register cpuidle
driver in acpi_processor_driver_init().

This commit has four changes under the commit 7a8c994cbb2d (ACPI:
processor: idle: Optimize ACPI idle driver registration):
1) move acpi_processor_register_idle_driver() ahead of the
   driver_register().
2) add acpi_processor_cstate_first_run_checks() before calling
   acpi_processor_get_power_info().
3) squash the commit 9d68320b2bca (ACPI: processor: idle: Fix
   function defined but not used warning) into this commit.
4) use for_each_possible_cpu(cpu) to scan all possible cpus.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
Link: https://patch.msgid.link/20250728070612.1260859-3-lihuisong@huawei.com
[ rjw: Added missing inline modifiers ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_driver.c | 10 ++++-
 drivers/acpi/processor_idle.c   | 66 +++++++++++++++++++++------------
 include/acpi/processor.h        |  2 +
 3 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 65e779be64ff..311863e00ffd 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -259,9 +259,11 @@ static int __init acpi_processor_driver_init(void)
 		acpi_processor_ignore_ppc_init();
 	}
 
+	acpi_processor_register_idle_driver();
+
 	result = driver_register(&acpi_processor_driver);
 	if (result < 0)
-		return result;
+		goto unregister_idle_drv;
 
 	result = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				   "acpi/cpu-drv:online",
@@ -283,8 +285,13 @@ static int __init acpi_processor_driver_init(void)
 	acpi_idle_rescan_dead_smt_siblings();
 
 	return 0;
+
 err:
 	driver_unregister(&acpi_processor_driver);
+
+unregister_idle_drv:
+	acpi_processor_unregister_idle_driver();
+
 	return result;
 }
 
@@ -302,6 +309,7 @@ static void __exit acpi_processor_driver_exit(void)
 	cpuhp_remove_state_nocalls(hp_online);
 	cpuhp_remove_state_nocalls(CPUHP_ACPI_CPUDRV_DEAD);
 	driver_unregister(&acpi_processor_driver);
+	acpi_processor_unregister_idle_driver();
 }
 
 module_init(acpi_processor_driver_init);
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 89f2f08b2554..ca7ae64def73 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1347,7 +1347,49 @@ int acpi_processor_power_state_has_changed(struct acpi_processor *pr)
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
+	for_each_possible_cpu(cpu) {
+		pr = per_cpu(processors, cpu);
+		if (!pr)
+			continue;
+
+		acpi_processor_cstate_first_run_checks();
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
@@ -1362,22 +1404,7 @@ int acpi_processor_power_init(struct acpi_processor *pr)
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
@@ -1390,14 +1417,11 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		 */
 		retval = cpuidle_register_device(dev);
 		if (retval) {
-			if (acpi_processor_registered == 0)
-				cpuidle_unregister_driver(&acpi_idle_driver);
 
 			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
 			kfree(dev);
 			return retval;
 		}
-		acpi_processor_registered++;
 	}
 	return 0;
 }
@@ -1411,10 +1435,6 @@ int acpi_processor_power_exit(struct acpi_processor *pr)
 
 	if (pr->flags.power) {
 		cpuidle_unregister_device(dev);
-		acpi_processor_registered--;
-		if (acpi_processor_registered == 0)
-			cpuidle_unregister_driver(&acpi_idle_driver);
-
 		kfree(dev);
 	}
 
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index d0eccbd920e5..ff864c1cee3a 100644
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
-- 
2.33.0


