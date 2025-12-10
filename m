Return-Path: <linux-acpi+bounces-19539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F7CB3380
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 15:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097F0302CB95
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Dec 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DFE21D3F2;
	Wed, 10 Dec 2025 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bf1pEvnV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75771E89C;
	Wed, 10 Dec 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765378304; cv=none; b=H7wpX0bVbshVo2io/AGeUKGG02du0S3AfC1aQdWA32Zy0wnBVY/DrdMqKLBhSPfXPVVYoPzyNLKXbzgXnd4/TgL6OKyMkiCdv6WFeerpWrZOwTLQCUpa27aMnUsEN40b5rlVRoDksxM9jH0hhFgCEcxo9wlO3MIUagpw9aZbYqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765378304; c=relaxed/simple;
	bh=69GZ6K7myq31p73Xg9UwAxgxgZlzGN9bMfB9xCqhWns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJPt/UBdtTRP2ybg/XIDNc5WM2EAG2HafCrjt1Q0EiF7VxMyzxNi7WajwN4TBf0//w44kM3EoCNl+4z+dCu451KuFMU4LAUQi81f2gxf9nOtvLM3Tjgz7V9y4PlAyqFWzjQVKYqO9AX+ogYtTrlga2e2iTDo10epL1lowqoc88A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bf1pEvnV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B50C4CEF1;
	Wed, 10 Dec 2025 14:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765378303;
	bh=69GZ6K7myq31p73Xg9UwAxgxgZlzGN9bMfB9xCqhWns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bf1pEvnVehVlO9hmDsLAt8l/ab9R0w0AqolMSB9QakzFdolSPcCZseQVhnLhbtm5h
	 VezI8r+R3KrFj73LQJZ/gcim2d6zuabrOuhwuefCMzs1J3KXcI/uwMezHhQ6kM7S9p
	 YSxkbkS4GgoL4rgsSMX8mmjEBrFAE4nsYjvPuRm/aPA5RRIBu9+BhPmxaWqR2L+lDu
	 NTy9PggKjHBJ9ktgVEae4594RM7irAne1llmCOCZrokjsxac2Sqbeyfw/s/80Jr670
	 0XY/suePEPp8dtNUqcXJBxLaDiro/DHZGbsK61jkgoFyH5uUaRRB2GOQenX6iv0GMc
	 ThEXAB0LMztsA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 3/3] ACPI: video: Convert the driver to a platform one
Date: Wed, 10 Dec 2025 15:51:32 +0100
Message-ID: <3920674.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8617910.T7Z3S40VBb@rafael.j.wysocki>
References: <8617910.T7Z3S40VBb@rafael.j.wysocki>
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
ACPI companions, so convert the ACPI video driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c |   47 ++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -21,6 +21,7 @@
 #include <linux/sort.h>
 #include <linux/pci.h>
 #include <linux/pci_ids.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
@@ -76,8 +77,8 @@ static int register_count;
 static DEFINE_MUTEX(register_count_mutex);
 static DEFINE_MUTEX(video_list_lock);
 static LIST_HEAD(video_bus_head);
-static int acpi_video_bus_add(struct acpi_device *device);
-static void acpi_video_bus_remove(struct acpi_device *device);
+static int acpi_video_bus_probe(struct platform_device *pdev);
+static void acpi_video_bus_remove(struct platform_device *pdev);
 static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
 
 /*
@@ -98,14 +99,13 @@ static const struct acpi_device_id video
 };
 MODULE_DEVICE_TABLE(acpi, video_device_ids);
 
-static struct acpi_driver acpi_video_bus = {
-	.name = "video",
-	.class = ACPI_VIDEO_CLASS,
-	.ids = video_device_ids,
-	.ops = {
-		.add = acpi_video_bus_add,
-		.remove = acpi_video_bus_remove,
-		},
+static struct platform_driver acpi_video_bus = {
+	.probe = acpi_video_bus_probe,
+	.remove = acpi_video_bus_remove,
+	.driver = {
+		.name = "acpi-video",
+		.acpi_match_table = video_device_ids,
+ 	},
 };
 
 struct acpi_video_bus_flags {
@@ -1888,7 +1888,8 @@ static void acpi_video_dev_add_notify_ha
 		device->flags.notify = 1;
 }
 
-static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
+static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video,
+					     struct platform_device *pdev)
 {
 	struct input_dev *input;
 	struct acpi_video_device *dev;
@@ -1911,7 +1912,7 @@ static int acpi_video_bus_add_notify_han
 	input->phys = video->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = 0x06;
-	input->dev.parent = &video->device->dev;
+	input->dev.parent = &pdev->dev;
 	input->evbit[0] = BIT(EV_KEY);
 	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
 	set_bit(KEY_VIDEO_NEXT, input->keybit);
@@ -1983,8 +1984,9 @@ static int acpi_video_bus_put_devices(st
 
 static int instance;
 
-static int acpi_video_bus_add(struct acpi_device *device)
+static int acpi_video_bus_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
@@ -2021,6 +2023,8 @@ static int acpi_video_bus_add(struct acp
 		instance++;
 	}
 
+	platform_set_drvdata(pdev, video);
+
 	video->device = device;
 	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
 	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
@@ -2068,7 +2072,7 @@ static int acpi_video_bus_add(struct acp
 	    !auto_detect)
 		acpi_video_bus_register_backlight(video);
 
-	error = acpi_video_bus_add_notify_handler(video);
+	error = acpi_video_bus_add_notify_handler(video, pdev);
 	if (error)
 		goto err_del;
 
@@ -2096,15 +2100,10 @@ err_free_video:
 	return error;
 }
 
-static void acpi_video_bus_remove(struct acpi_device *device)
+static void acpi_video_bus_remove(struct platform_device *pdev)
 {
-	struct acpi_video_bus *video = NULL;
-
-
-	if (!device || !acpi_driver_data(device))
-		return;
-
-	video = acpi_driver_data(device);
+	struct acpi_video_bus *video = platform_get_drvdata(pdev);
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       acpi_video_bus_notify);
@@ -2167,7 +2166,7 @@ int acpi_video_register(void)
 
 	dmi_check_system(video_dmi_table);
 
-	ret = acpi_bus_register_driver(&acpi_video_bus);
+	ret = platform_driver_register(&acpi_video_bus);
 	if (ret)
 		goto leave;
 
@@ -2187,7 +2186,7 @@ void acpi_video_unregister(void)
 {
 	mutex_lock(&register_count_mutex);
 	if (register_count) {
-		acpi_bus_unregister_driver(&acpi_video_bus);
+		platform_driver_unregister(&acpi_video_bus);
 		register_count = 0;
 		may_report_brightness_keys = false;
 	}




