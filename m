Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4D345ED4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 14:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhCWNA2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 09:00:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14850 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhCWNAE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Mar 2021 09:00:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F4Wcn4fwYz92NZ;
        Tue, 23 Mar 2021 20:58:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Mar 2021 20:59:52 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] ACPI: AC: fix some errors and warnings reported by checkpatch.pl
Date:   Tue, 23 Mar 2021 20:57:27 +0800
Message-ID: <1616504247-48744-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fix some errors and warnings reported by checkpatch.pl, including
following five types:
ERROR: "foo * bar" should be "foo *bar"
ERROR: code indent should use tabs where possible
WARNING: Block comments use a trailing */ on a separate line
WARNING: braces {} are not necessary for single statement blocks
WARNING: void function return statements are not generally useful

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/acpi/ac.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index b86ee6e..07987854 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -78,17 +78,16 @@ static struct acpi_driver acpi_ac_driver = {
 struct acpi_ac {
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
-	struct acpi_device * device;
+	struct acpi_device *device;
 	unsigned long long state;
 	struct notifier_block battery_nb;
 };
 
 #define to_acpi_ac(x) power_supply_get_drvdata(x)
 
-/* --------------------------------------------------------------------------
-                               AC Adapter Management
-   -------------------------------------------------------------------------- */
-
+/*
+ * AC Adapter Management
+ */
 static int acpi_ac_get_state(struct acpi_ac *ac)
 {
 	acpi_status status = AE_OK;
@@ -109,9 +108,9 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
 	return 0;
 }
 
-/* --------------------------------------------------------------------------
-                            sysfs I/F
-   -------------------------------------------------------------------------- */
+/*
+ * sysfs I/F
+ */
 static int get_ac_property(struct power_supply *psy,
 			   enum power_supply_property psp,
 			   union power_supply_propval *val)
@@ -138,10 +137,9 @@ static enum power_supply_property ac_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
-/* --------------------------------------------------------------------------
-                                   Driver Model
-   -------------------------------------------------------------------------- */
-
+/*
+ * Driver Model
+ */
 static void acpi_ac_notify(struct acpi_device *device, u32 event)
 {
 	struct acpi_ac *ac = acpi_driver_data(device);
@@ -174,8 +172,6 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
 		acpi_notifier_call_chain(device, event, (u32) ac->state);
 		kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
 	}
-
-	return;
 }
 
 static int acpi_ac_battery_notify(struct notifier_block *nb,
@@ -282,9 +278,8 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->battery_nb.notifier_call = acpi_ac_battery_notify;
 	register_acpi_notifier(&ac->battery_nb);
 end:
-	if (result) {
+	if (result)
 		kfree(ac);
-	}
 
 	return result;
 }
@@ -293,7 +288,7 @@ static int acpi_ac_add(struct acpi_device *device)
 static int acpi_ac_resume(struct device *dev)
 {
 	struct acpi_ac *ac;
-	unsigned old_state;
+	unsigned int old_state;
 
 	if (!dev)
 		return -EINVAL;
@@ -352,9 +347,8 @@ static int __init acpi_ac_init(void)
 	}
 
 	result = acpi_bus_register_driver(&acpi_ac_driver);
-	if (result < 0) {
+	if (result < 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
-- 
2.8.1

