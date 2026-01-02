Return-Path: <linux-acpi+bounces-19928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7F1CEE6E1
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 12:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE09E30109AB
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 11:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248782F1FC2;
	Fri,  2 Jan 2026 11:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeO8FTQE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91F2DC359;
	Fri,  2 Jan 2026 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767354852; cv=none; b=RjgOLGMIoJAQVvLO9gVGXwZ0VyTEwtKBqLUZcXRI0tdDawkfOtfegkXzfxm/ztYhZ4e1TwOprACa0GzbLeDBDv2rUKchdPGBUrCGs61gmsfIGkWeCPN/9qh5Irz27hIo1KPq4Albbq8s6OxnxhTOIXpV+q5vKQaTNXhAOni+e1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767354852; c=relaxed/simple;
	bh=2Xx0C6sRckmOCl1PETbUgysAHkxCmj0n8xA/BB1JYiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QdcelO01HbXh6Gg7l73GAawf238UTWDTbD/8bllRnZdqoLQCXN5PMc2w/8OyZyF9Znndro1TlHe4MB7faMwX4UwFJl4dnSq6u2F1sQjSiS2WcHN4KN9pH2IGMileAEhgRm3dl72+siTL8w/jOuAuuzt6zH4iaD/CqlPwJaP7k4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeO8FTQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494C1C116B1;
	Fri,  2 Jan 2026 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767354850;
	bh=2Xx0C6sRckmOCl1PETbUgysAHkxCmj0n8xA/BB1JYiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FeO8FTQE+AyFLRJL0dJX0ToQXKZP3ZCTSJo32dfekM70Vo+qGC9LdRffJgOl78J+k
	 oXnjXirbozf2x5+zQADebR4vpEZp3tiGEpEPfolgfxlNosSa5Ezl961e4dH1zrhacs
	 jBXdKjymDHx5eWTNnlphf2hYO6EGfo92NsIb82m2AM2gc80WwDKM4THFlfkea3N9OM
	 PwVmWumi9j8YaqDHnkhlqj2/okDPIpW4Z5FrZRAU5dbwNWuqYEInUXfhr93AIbnuGS
	 SrNbXvoh0DeOUv5SV49JBlYq2FJTNCgU9BjBFfi1Y4opCoUX7Si+JYqGKUX7rizyjr
	 KE8WpPYoiiJfA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Hans de Goede <hansg@kernel.org>
Subject:
 [RESEND][PATCH v1 3/3] ACPI: video: Convert the driver to a platform one
Date: Fri, 02 Jan 2026 12:53:53 +0100
Message-ID: <1957556.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12824456.O9o76ZdvQC@rafael.j.wysocki>
References: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

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
 drivers/acpi/acpi_video.c | 47 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 54e09e7f8e77..944aba605c1a 100644
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
@@ -98,14 +99,13 @@ static const struct acpi_device_id video_device_ids[] = {
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
+	},
 };
 
 struct acpi_video_bus_flags {
@@ -1888,7 +1888,8 @@ static void acpi_video_dev_add_notify_handler(struct acpi_video_device *device)
 		device->flags.notify = 1;
 }
 
-static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
+static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video,
+					     struct platform_device *pdev)
 {
 	struct input_dev *input;
 	struct acpi_video_device *dev;
@@ -1911,7 +1912,7 @@ static int acpi_video_bus_add_notify_handler(struct acpi_video_bus *video)
 	input->phys = video->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = 0x06;
-	input->dev.parent = &video->device->dev;
+	input->dev.parent = &pdev->dev;
 	input->evbit[0] = BIT(EV_KEY);
 	set_bit(KEY_SWITCHVIDEOMODE, input->keybit);
 	set_bit(KEY_VIDEO_NEXT, input->keybit);
@@ -1983,8 +1984,9 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
 
 static int instance;
 
-static int acpi_video_bus_add(struct acpi_device *device)
+static int acpi_video_bus_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_video_bus *video;
 	bool auto_detect;
 	int error;
@@ -2021,6 +2023,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
 		instance++;
 	}
 
+	platform_set_drvdata(pdev, video);
+
 	video->device = device;
 	strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
 	strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
@@ -2068,7 +2072,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	    !auto_detect)
 		acpi_video_bus_register_backlight(video);
 
-	error = acpi_video_bus_add_notify_handler(video);
+	error = acpi_video_bus_add_notify_handler(video, pdev);
 	if (error)
 		goto err_del;
 
@@ -2096,15 +2100,10 @@ static int acpi_video_bus_add(struct acpi_device *device)
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
-- 
2.51.0





