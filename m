Return-Path: <linux-acpi+bounces-19535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25822CB3328
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C64530D896E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB75242D76;
	Wed, 10 Dec 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdB3HoZ1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB53239573;
	Wed, 10 Dec 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765377891; cv=none; b=OdRLwlQ9JpBm6ZnYyBJ00QQRIp34Y3Q6XsAgcZH6Lb92P/yMW4qtKKktlbCSNoNb16rAWAX6WkA0SUPCybHtPg5im9bzwe52ytQOlgD3iX8+TApkrtwdj9IFpm9wxD+KI9jT7MCx3NCiqFpG4duQYH5J35Ms/ET7ssXmnM+TIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765377891; c=relaxed/simple;
	bh=sZgSTnf71iqDnehUqR7BLf9CFqCxuzsh/RWL8gF7g0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=akG7BH5J5dqwRPZfagRGp+fMY1XeXI9eZhfQL64naHaGAEhv8nf/bEtftybpoRzAD26/E//hIeK4k8I80txK2PgUGPq46Jg8OONSedFZCoU2+sG4TfcKeSZctpMtCFcxHd2cdhhYSYSXuOdYeCdRZekaKjkpLL6Z0UW5uTUEZ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdB3HoZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC2DC19421;
	Wed, 10 Dec 2025 14:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765377891;
	bh=sZgSTnf71iqDnehUqR7BLf9CFqCxuzsh/RWL8gF7g0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DdB3HoZ1e66nFexFVzv3FgYNTRPRxcQEiJBRLprvZCd5PYpLQqyhEaGs88IlKqYhF
	 bR/6wzFBSKuxHgV4Pad/M/Aeb6h3mMXIGpuMZ/SoALtrVJn+x35D8Fao/bqJMrf6e+
	 oJY+EHKLvtpXFSJBc4R8Z6wZRxH22k3ANQ8F67iwO0R5msg3jf505r0lwoOAJw60CL
	 SpK6nzyrb4jNrCrKLUMZ1C8sASglAhOqKtcB2cMFwwipoEzN37YRZ7CNqqIOYaOSfs
	 wk2ZG1DLwpwaXpe7HNfs0MPt9IMoVeq2Bq/SWrl7H7efEoddcYNunPrUKN23KHl8HZ
	 40SBCWcBBWr6Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 3/4] ACPI: thermal: Convert the driver to a platform one
Date: Wed, 10 Dec 2025 15:43:45 +0100
Message-ID: <2249483.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
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
ACPI companions, so convert the ACPI thermal zone driver to a platform
one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -25,6 +25,7 @@
 #include <linux/kmod.h>
 #include <linux/reboot.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
 #include <linux/thermal.h>
 #include <linux/acpi.h>
 #include <linux/workqueue.h>
@@ -776,9 +777,10 @@ static void acpi_thermal_free_thermal_zo
 	kfree(tz);
 }
 
-static int acpi_thermal_add(struct acpi_device *device)
+static int acpi_thermal_probe(struct platform_device *pdev)
 {
 	struct thermal_trip trip_table[ACPI_THERMAL_MAX_NR_TRIPS] = { 0 };
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_thermal_trip *acpi_trip;
 	struct thermal_trip *trip;
 	struct acpi_thermal *tz;
@@ -794,11 +796,12 @@ static int acpi_thermal_add(struct acpi_
 	if (!tz)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, tz);
+
 	tz->device = device;
 	strscpy(tz->name, device->pnp.bus_id);
 	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
-	device->driver_data = tz;
 
 	acpi_thermal_aml_dependency_fix(tz);
 
@@ -895,16 +898,11 @@ free_memory:
 	return result;
 }
 
-static void acpi_thermal_remove(struct acpi_device *device)
+static void acpi_thermal_remove(struct platform_device *pdev)
 {
-	struct acpi_thermal *tz;
-
-	if (!device || !acpi_driver_data(device))
-		return;
+	struct acpi_thermal *tz = platform_get_drvdata(pdev);
 
-	tz = acpi_driver_data(device);
-
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(tz->device, ACPI_DEVICE_NOTIFY,
 				       acpi_thermal_notify);
 
 	flush_workqueue(acpi_thermal_pm_queue);
@@ -922,16 +920,9 @@ static int acpi_thermal_suspend(struct d
 
 static int acpi_thermal_resume(struct device *dev)
 {
-	struct acpi_thermal *tz;
+	struct acpi_thermal *tz = dev_get_drvdata(dev);
 	int i, j;
 
-	if (!dev)
-		return -EINVAL;
-
-	tz = acpi_driver_data(to_acpi_device(dev));
-	if (!tz)
-		return -EINVAL;
-
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		struct acpi_thermal_trip *acpi_trip = &tz->trips.active[i].trip;
 
@@ -958,15 +949,14 @@ static const struct acpi_device_id  ther
 };
 MODULE_DEVICE_TABLE(acpi, thermal_device_ids);
 
-static struct acpi_driver acpi_thermal_driver = {
-	.name = "thermal",
-	.class = ACPI_THERMAL_CLASS,
-	.ids = thermal_device_ids,
-	.ops = {
-		.add = acpi_thermal_add,
-		.remove = acpi_thermal_remove,
-		},
-	.drv.pm = &acpi_thermal_pm,
+static struct platform_driver acpi_thermal_driver = {
+	.probe = acpi_thermal_probe,
+	.remove = acpi_thermal_remove,
+	.driver = {
+		.name = "acpi-thermal",
+		.acpi_match_table = thermal_device_ids,
+		.pm = &acpi_thermal_pm,
+	},
 };
 
 static int thermal_act(const struct dmi_system_id *d)
@@ -1064,7 +1054,7 @@ static int __init acpi_thermal_init(void
 	if (!acpi_thermal_pm_queue)
 		return -ENODEV;
 
-	result = acpi_bus_register_driver(&acpi_thermal_driver);
+	result = platform_driver_register(&acpi_thermal_driver);
 	if (result < 0) {
 		destroy_workqueue(acpi_thermal_pm_queue);
 		return -ENODEV;
@@ -1075,7 +1065,7 @@ static int __init acpi_thermal_init(void
 
 static void __exit acpi_thermal_exit(void)
 {
-	acpi_bus_unregister_driver(&acpi_thermal_driver);
+	platform_driver_unregister(&acpi_thermal_driver);
 	destroy_workqueue(acpi_thermal_pm_queue);
 }
 




