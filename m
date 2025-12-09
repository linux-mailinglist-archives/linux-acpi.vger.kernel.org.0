Return-Path: <linux-acpi+bounces-19513-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C62CB0299
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F095E3026E20
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E42C0F62;
	Tue,  9 Dec 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozi9QGVN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264B2BEC3F;
	Tue,  9 Dec 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288866; cv=none; b=ib6+AtZjPImE8mjZqknvf4XFmkrdXO4zuqAS/JUvYVGZh4d6O3eiaNe39U/K8H2oMA2boDvnTr14mBzSt4/k06sig9Ucp4lZjincGNP+UokxSRkQhUgG9YOO2X1FcPF3H3Nx5hWWzD+0L704NxtiSgj4FJYC9ClBSKZeAY1Hkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288866; c=relaxed/simple;
	bh=wmIhno+h3xZ0Bg6VyHfRX1zEk6fq2wJP7vNCf/ViQUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZancFklQMaH0wYvCrJh70bdUIB7sDR3TwrlOdZKsUNPmuUP+DKz0YGCwNo5OzQQ6/HoJqps/UpmzVjqy3+1wzoMc5/PuRBV1k7Isfw965hrrsME7Du5S57+Y5IfG7n+Z+UylpZ0m+Rh7Hy/RDoVp/0a8ZHIHMMn0w3xn2qd4odE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozi9QGVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB515C113D0;
	Tue,  9 Dec 2025 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765288866;
	bh=wmIhno+h3xZ0Bg6VyHfRX1zEk6fq2wJP7vNCf/ViQUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozi9QGVNDoimW/mrOMz9ORdgISOf38YsWDhUzcaoc7ExLb+ZDexCu8lxBhnZ965Tb
	 PXvVgFw3ye5BP0rwt0F0WcoI3tnUMfvngPsUsaoZ+0CnCAscVa09nunK61qFCBf3th
	 D9hJY0FAD4qlaZUh/Ap5wk9yLPl5vKJ2FbEFZ3x8SEEs9fOoTjz2f5mkvHzuakVTi5
	 5nXWxx5Agc2bhlmaQQlgQVBeXwO9typYAEE+fPmTlQCeP+PphMbKUVfjb76pGnAHhr
	 u0QkkUWWd1oPkMUEzAkikUXGj8MHYw44F3kar+RcMGFwG1DbTLnDj5UmH9+b+tjUM+
	 RCqoLmFzrSKfA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1 04/10] ACPI: button: Convert the driver to a platform one
Date: Tue, 09 Dec 2025 14:54:25 +0100
Message-ID: <3591652.QJadu78ljV@rafael.j.wysocki>
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
ACPI companions, so convert the ACPI button driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c |   65 +++++++++++++++++++++++++++-----------------------
 drivers/acpi/scan.c   |    9 ------
 2 files changed, 37 insertions(+), 37 deletions(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/platform_device.h>
 #include <acpi/button.h>
 
 #define ACPI_BUTTON_CLASS		"button"
@@ -145,8 +146,8 @@ static const struct dmi_system_id dmi_li
 	{}
 };
 
-static int acpi_button_add(struct acpi_device *device);
-static void acpi_button_remove(struct acpi_device *device);
+static int acpi_button_probe(struct platform_device *pdev);
+static void acpi_button_remove(struct platform_device *pdev);
 
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev);
@@ -157,19 +158,19 @@ static int acpi_button_resume(struct dev
 #endif
 static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_button_resume);
 
-static struct acpi_driver acpi_button_driver = {
-	.name = "button",
-	.class = ACPI_BUTTON_CLASS,
-	.ids = button_device_ids,
-	.ops = {
-		.add = acpi_button_add,
-		.remove = acpi_button_remove,
+static struct platform_driver acpi_button_driver = {
+	.probe = acpi_button_probe,
+	.remove = acpi_button_remove,
+	.driver = {
+		.name = "acpi-button",
+		.acpi_match_table = button_device_ids,
+		.pm = &acpi_button_pm,
 	},
-	.drv.pm = &acpi_button_pm,
 };
 
 struct acpi_button {
 	struct acpi_device *adev;
+	struct platform_device *pdev;
 	unsigned int type;
 	struct input_dev *input;
 	char phys[32];			/* for input device */
@@ -397,7 +398,7 @@ static int acpi_lid_update_state(struct
 		return state;
 
 	if (state && signal_wakeup)
-		acpi_pm_wakeup_event(&device->dev);
+		acpi_pm_wakeup_event(&button->pdev->dev);
 
 	return acpi_lid_notify_state(button, state);
 }
@@ -454,7 +455,7 @@ static void acpi_button_notify(acpi_hand
 		return;
 	}
 
-	acpi_pm_wakeup_event(&device->dev);
+	acpi_pm_wakeup_event(&button->pdev->dev);
 
 	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
@@ -486,8 +487,8 @@ static u32 acpi_button_event(void *data)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_button_suspend(struct device *dev)
 {
-	struct acpi_device *device = to_acpi_device(dev);
-	struct acpi_button *button = acpi_driver_data(device);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct acpi_button *button = platform_get_drvdata(pdev);
 
 	button->suspended = true;
 	return 0;
@@ -495,9 +496,10 @@ static int acpi_button_suspend(struct de
 
 static int acpi_button_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
+	struct acpi_button *button = platform_get_drvdata(pdev);
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct input_dev *input;
-	struct acpi_device *device = to_acpi_device(dev);
-	struct acpi_button *button = acpi_driver_data(device);
 
 	button->suspended = false;
 	if (button->type == ACPI_BUTTON_TYPE_LID) {
@@ -529,8 +531,9 @@ static int acpi_lid_input_open(struct in
 	return 0;
 }
 
-static int acpi_button_add(struct acpi_device *device)
+static int acpi_button_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	acpi_notify_handler handler;
 	struct acpi_button *button;
 	struct input_dev *input;
@@ -547,8 +550,9 @@ static int acpi_button_add(struct acpi_d
 	if (!button)
 		return -ENOMEM;
 
-	device->driver_data = button;
+	platform_set_drvdata(pdev, button);
 
+	button->pdev = pdev;
 	button->adev = device;
 	button->input = input = input_allocate_device();
 	if (!input) {
@@ -599,7 +603,7 @@ static int acpi_button_add(struct acpi_d
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = button->type;
-	input->dev.parent = &device->dev;
+	input->dev.parent = &pdev->dev;
 
 	switch (button->type) {
 	case ACPI_BUTTON_TYPE_POWER:
@@ -653,7 +657,7 @@ static int acpi_button_add(struct acpi_d
 		lid_device = device;
 	}
 
-	device_init_wakeup(&device->dev, true);
+	device_init_wakeup(&pdev->dev, true);
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
@@ -662,13 +666,15 @@ err_input_unregister:
 err_remove_fs:
 	acpi_button_remove_fs(button);
 err_free_button:
+	platform_set_drvdata(pdev, NULL);
 	kfree(button);
 	return error;
 }
 
-static void acpi_button_remove(struct acpi_device *device)
+static void acpi_button_remove(struct platform_device *pdev)
 {
-	struct acpi_button *button = acpi_driver_data(device);
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_button *button = platform_get_drvdata(pdev);
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
@@ -690,6 +696,7 @@ static void acpi_button_remove(struct ac
 
 	acpi_button_remove_fs(button);
 	input_unregister_device(button->input);
+	platform_set_drvdata(pdev, NULL);
 	kfree(button);
 }
 
@@ -727,7 +734,7 @@ module_param_call(lid_init_state,
 		  NULL, 0644);
 MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
-static int acpi_button_register_driver(struct acpi_driver *driver)
+static int __init acpi_button_init(void)
 {
 	const struct dmi_system_id *dmi_id;
 
@@ -743,20 +750,20 @@ static int acpi_button_register_driver(s
 	 * Modules such as nouveau.ko and i915.ko have a link time dependency
 	 * on acpi_lid_open(), and would therefore not be loadable on ACPI
 	 * capable kernels booted in non-ACPI mode if the return value of
-	 * acpi_bus_register_driver() is returned from here with ACPI disabled
+	 * platform_driver_register() is returned from here with ACPI disabled
 	 * when this driver is built as a module.
 	 */
 	if (acpi_disabled)
 		return 0;
 
-	return acpi_bus_register_driver(driver);
+	return platform_driver_register(&acpi_button_driver);
 }
 
-static void acpi_button_unregister_driver(struct acpi_driver *driver)
+static void __exit acpi_button_exit(void)
 {
 	if (!acpi_disabled)
-		acpi_bus_unregister_driver(driver);
+		platform_driver_unregister(&acpi_button_driver);
 }
 
-module_driver(acpi_button_driver, acpi_button_register_driver,
-	       acpi_button_unregister_driver);
+module_init(acpi_button_init);
+module_exit(acpi_button_exit);




