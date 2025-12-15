Return-Path: <linux-acpi+bounces-19576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C49CBED09
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4AF1305329C
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Dec 2025 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915D631B10E;
	Mon, 15 Dec 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ8/L1hx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681701A9FAB;
	Mon, 15 Dec 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807446; cv=none; b=kP57hw7yoTI9+a+AkUu8zYJRqWsw/W1pYxv1KNrYTOFUPk9s4KuTFleQ93INrR4lX39/zWeyOyQxh5dvA9z7rDFJqjHYzvApWKM8aDTIEMoz7mCAs9I6KrorZFYXKpJc3BYcG8+OlQ5E3A4955MT7qY+k5ImEN+uj9ifFinNvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807446; c=relaxed/simple;
	bh=T24WwK6VBM/bOIyojAvtkzGKrlnjSMqz6zUAApvu3Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJ1nyHXfcMBzYtttIMuDt2flIGTzeHuRWc0MI8/vk7hr4dD8NhEW1Sw252RjbiLvvXPCgH3OpJ7k0GwdbzLjeqyA/p9rl/0912SHh6xw69PeImkOfl3JF4GSFyXrzlCHV1fd4HxrpW7JiTHntlew2hHubmfbp6ZlCHJsZBLW+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ8/L1hx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E8AC4CEF5;
	Mon, 15 Dec 2025 14:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807445;
	bh=T24WwK6VBM/bOIyojAvtkzGKrlnjSMqz6zUAApvu3Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZ8/L1hxQVoBcJ1zm3a0gYt2yF8ERyjdErhrekeDwmz+pNL7b3uaXH+H5ciX7PzTO
	 RD2kMT/qPR4jILlCIcM7vtldUjv7A/02/MGPLeWKy0hOv5X+dC4n+Xqx+O0HFBvx8z
	 Uc4ICLgSrhEVeZTIqPJPMYwvBPC5BB6HJLiepDNI976EBkmPtSBIlecYp78YsBIkVB
	 XRri4904hllwpmnRZQQMC94sf2Y+cHflGVhZI72NcL3kPDiHR8uy0aToK9Nn8d9tOj
	 R2u7nfRewQxOJHK87R+0ffZ0waeruPELgSpJd6a2YkrSkwcK7VH70kKdFQVCzXFkDD
	 VcPtAH+kStq8w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v2 10/10] ACPI: battery: Convert the driver to a platform one
Date: Mon, 15 Dec 2025 15:03:28 +0100
Message-ID: <3187448.CbtlEUcBR6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2685338.Lt9SDvczpP@rafael.j.wysocki>
References: <2685338.Lt9SDvczpP@rafael.j.wysocki>
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

v1 -> v2:
   * Drop redundant driver_data removal operations.
   * Use dev_get_drvdata() where applicable to get the driver data pointer.

---
 drivers/acpi/battery.c |   61 ++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

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
@@ -1256,7 +1257,7 @@ static int acpi_battery_add(struct acpi_
 	return 0;
 
 fail_pm:
-	device_init_wakeup(&device->dev, 0);
+	device_init_wakeup(&pdev->dev, false);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
 	sysfs_battery_cleanup(battery);
@@ -1264,19 +1265,18 @@ fail:
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
@@ -1285,12 +1285,8 @@ static void acpi_battery_remove(struct a
 /* this is needed to learn about changes made in suspended state */
 static int acpi_battery_resume(struct device *dev)
 {
-	struct acpi_battery *battery;
-
-	if (!dev)
-		return -EINVAL;
+	struct acpi_battery *battery = dev_get_drvdata(dev);
 
-	battery = acpi_driver_data(to_acpi_device(dev));
 	if (!battery)
 		return -EINVAL;
 
@@ -1304,16 +1300,15 @@ static int acpi_battery_resume(struct de
 
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
@@ -1323,12 +1318,12 @@ static int __init acpi_battery_init(void
 
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
 




