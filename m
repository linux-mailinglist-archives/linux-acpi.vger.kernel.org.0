Return-Path: <linux-acpi+bounces-19507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D720CB0224
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77B0530146D9
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3618326A1A4;
	Tue,  9 Dec 2025 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWBW1kV+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C4524466D;
	Tue,  9 Dec 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288839; cv=none; b=MtModX4wXokTQQ2J8SbhQfGqFCdgbV3j6tIp28h3DpexIva8nrE7Mi0Su8c7Es4IkZWwAHK5Dq/C3q+/5NSC+LXLzb0DhzHxUl93PT1Z0fIAiWqtWR0AcB0a2zDmy59AEdjD5E3fjoehY3ijhubFe8NRGoQrlREc/kJ01BRb5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288839; c=relaxed/simple;
	bh=lECy3hIMZtQ4duI78ym+HT4rPzNxIMC5rWV3+XcTtnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrRfcxrIf8momx8SbZ28ESbrucObVHIipT+i9q29gHFedmwhNoeeMwKxr4wZGQfGYrrPLnN8mZXZYnUpT7BbPA8wmqgDgiPE9Dl11/dJUOBHSpa81i2WRRbBEkURt692iSlaeebgOo5PfqoT1GghZBaw31t2qEdstQ+pUHJPcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWBW1kV+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C54C4CEF5;
	Tue,  9 Dec 2025 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288838;
	bh=lECy3hIMZtQ4duI78ym+HT4rPzNxIMC5rWV3+XcTtnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWBW1kV+TIZiuJh9VMXuIGy+ui9mpMQAr//rrm/g2T49Oi3vpLNd1Xt2x4hoYs3Pr
	 hqbuu0Hz19/ynlz63HaOZviXH+xyUmVk7NnlxsJiiwR4yjGP+Cda0QgRk8ZmtIQP+0
	 OEi2LCKF2KVU4n4E/fC7fkZ0xk+WWYJ8OGpl5TJtPslUAuhvg4wsp+3Ac29rsp73X/
	 yOCT1GyJolgj/oRpvcaSrfWzoE/QjssWrfuEld/0yUFzFaWqnTKnAO7SO02x51RQvq
	 xdcdz0/LRuHycWHmj4tzz+JZVhwZ8ivNc8RdYWqxVCq6J/IFFdRPrU3m8ayshkO879
	 SjD6LOnU8+Mng==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 10/10] ACPI: battery: Convert the driver to a platform one
Date: Tue, 09 Dec 2025 14:59:11 +0100
Message-ID: <117696862.nniJfEyVGO@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2339822.iZASKD2KPV@rafael.j.wysocki>
References: <2339822.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

While binding drivers directly to struct acpi_device objects allows
basic functionality to be provided, at least in the majority of cases,
there are some problems with it, related to general consistency, sysfs
layout, power management operation ordering, and code cleanliness.

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ACPI battery driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c |   63 +++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/types.h>
@@ -1208,26 +1209,26 @@ static void sysfs_battery_cleanup(struct
 	sysfs_remove_battery(battery);
 }
 
-static int acpi_battery_add(struct acpi_device *device)
+static int acpi_battery_probe(struct platform_device *pdev)
 {
-	int result = 0;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_battery *battery;
-
-	if (!device)
-		return -EINVAL;
+	int result;
 
 	if (device->dep_unmet)
 		return -EPROBE_DEFER;
 
-	battery = devm_kzalloc(&device->dev, sizeof(*battery), GFP_KERNEL);
+	battery = devm_kzalloc(&pdev->dev, sizeof(*battery), GFP_KERNEL);
 	if (!battery)
 		return -ENOMEM;
+
+	platform_set_drvdata(pdev, battery);
+
 	battery->device = device;
 	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
-	device->driver_data = battery;
 
-	result = devm_mutex_init(&device->dev, &battery->update_lock);
+	result = devm_mutex_init(&pdev->dev, &battery->update_lock);
 	if (result)
 		return result;
 
@@ -1246,7 +1247,7 @@ static int acpi_battery_add(struct acpi_
 	if (result)
 		goto fail;
 
-	device_init_wakeup(&device->dev, 1);
+	device_init_wakeup(&pdev->dev, true);
 
 	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
 						 acpi_battery_notify, battery);
@@ -1256,41 +1257,38 @@ static int acpi_battery_add(struct acpi_
 	return 0;
 
 fail_pm:
-	device_init_wakeup(&device->dev, 0);
+	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
 	sysfs_battery_cleanup(battery);
+	platform_set_drvdata(pdev, NULL);
 
 	return result;
 }
 
-static void acpi_battery_remove(struct acpi_device *device)
+static void acpi_battery_remove(struct platform_device *pdev)
 {
-	struct acpi_battery *battery;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_battery *battery = platform_get_drvdata(pdev);
 
-	if (!device || !acpi_driver_data(device))
+	if (!device || !battery)
 		return;
 
-	battery = acpi_driver_data(device);
-
 	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
 				       acpi_battery_notify);
 
-	device_init_wakeup(&device->dev, 0);
+	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
 
 	sysfs_battery_cleanup(battery);
+	platform_set_drvdata(pdev, NULL);
 }
 
 /* this is needed to learn about changes made in suspended state */
 static int acpi_battery_resume(struct device *dev)
 {
-	struct acpi_battery *battery;
-
-	if (!dev)
-		return -EINVAL;
+	struct acpi_battery *battery = platform_get_drvdata(to_platform_device(dev));
 
-	battery = acpi_driver_data(to_acpi_device(dev));
 	if (!battery)
 		return -EINVAL;
 
@@ -1304,16 +1302,15 @@ static int acpi_battery_resume(struct de
 
 static DEFINE_SIMPLE_DEV_PM_OPS(acpi_battery_pm, NULL, acpi_battery_resume);
 
-static struct acpi_driver acpi_battery_driver = {
-	.name = "battery",
-	.class = ACPI_BATTERY_CLASS,
-	.ids = battery_device_ids,
-	.ops = {
-		.add = acpi_battery_add,
-		.remove = acpi_battery_remove,
-		},
-	.drv.pm = pm_sleep_ptr(&acpi_battery_pm),
-	.drv.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+static struct platform_driver acpi_battery_driver = {
+	.probe = acpi_battery_probe,
+	.remove = acpi_battery_remove,
+	.driver = {
+		.name = "acpi-battery",
+		.acpi_match_table = battery_device_ids,
+		.pm = pm_sleep_ptr(&acpi_battery_pm),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
 };
 
 static int __init acpi_battery_init(void)
@@ -1323,12 +1320,12 @@ static int __init acpi_battery_init(void
 
 	dmi_check_system(bat_dmi_table);
 
-	return acpi_bus_register_driver(&acpi_battery_driver);
+	return platform_driver_register(&acpi_battery_driver);
 }
 
 static void __exit acpi_battery_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_battery_driver);
+	platform_driver_unregister(&acpi_battery_driver);
 	battery_hook_exit();
 }
 




