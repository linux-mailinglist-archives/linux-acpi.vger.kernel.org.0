Return-Path: <linux-acpi+bounces-10581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D0BA0FDF7
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 02:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF3E3A0445
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEC224B0E;
	Tue, 14 Jan 2025 01:22:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA04EC5;
	Tue, 14 Jan 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817727; cv=none; b=fzeyS64dnemyZJvWmHZZxYaglG72U4jocGcG6OUf2ov37THYiFXcgcxd+0ags+14jGAQ2aiH0gx2RenXfqxQSzZqYXE/NGW9q25S4z865bhzdt+L9gnuYSq6ow2JgMmCpKjoI+cMQ7SmjjKfA08Og/64OggHcPCn3RNuVhVgfqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817727; c=relaxed/simple;
	bh=+IH/Zbgj6AKu2Zb7+zutdU1a2fn8O2tNsNCrUp1e6W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFf4uWGn4ck0UvTTeCIUpwQyGRnbp0L/4Cet3/hKyytvxm06lM2TT6EHE5ej6nxL2sUNemStW//DZlLQU5OEWUe/WBp/yY1WUFGVL1eEtOAEbv6WbLsyJ6KIVSZzcZXIQYVYESXtBH2ITl4CWJvLyxkC79brNGH/25CU01mJ01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e389d8dc7so4816042e87.0;
        Mon, 13 Jan 2025 17:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736817723; x=1737422523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+STYqbut6K8qwUB/ttsKsOQ8S9frInfKcyWtIs5oRjI=;
        b=ZkGfaikU0cTZg6E/dRl0faMeURxeQR8XSLQxHqnZjDUXdDjExDyWcOio4R3GfxNphS
         dDe4VX0bvVoDp6eZGhCV75ALSPEKx/PCjgdaL1nOdl8neeK3zb9ne13kyYAsZEv4J8c6
         bnFx/6Y6G53wecOHBggGRI60Rnh5mCODu0AarhMgVvzBh9xrM45mnAg/I72SFxIphkIt
         wUjrIs/5DyAg+/k9Bx03KbaRwGXx+t4SvH5LglN1/b08CVlkMMhuE36qZfoHMN+pJPFH
         AZAM+yCeWf3Ha4sOKYAbDL8DP7AY39TAiBrkAB3ZgzjPMuZc60c5HQ2K3cBUzjQ4NRpX
         ZCSg==
X-Forwarded-Encrypted: i=1; AJvYcCUW4J7PwKiTWGfxMm+IMUQFWZvhH2bj/X+V+tahm5CbHVLGIUf1rJX941QWla67buIf5vhQeBHnzuR5@vger.kernel.org, AJvYcCVjS81KWX1dkja+OU5VIdkrFiC9t3p4qx3auJjrgjZc47UG9kHNBUoTwZYdGmDIDXViERmBqzmhRkw0SUoN@vger.kernel.org
X-Gm-Message-State: AOJu0YylF9yFSZf05DF50qeEUla/9A3stQc77LiNw12VjTROKL3kCsXr
	eNR/s3wWqk8l2+azHZ4tmIGDGYu0WaXEKNitVEe1o3prGi8WBExV
X-Gm-Gg: ASbGncvxrWpaxgm7YaGWxs3BQnj/XYetGLUUb2h2xnuduGLnEHxJFWN1kGtLX9p2Zic
	YSNUIdLNaPdzbuJmPJIR6Trh7FYXS2qHm4zBEOuhjQKiLsuJ/Icp4PLbWoqGcWY2vDBBockp6UW
	vFzlzDDdeOsxd+IJwdalq5szyuGMvX+Hh5duuubhopcNz65I+aNFWPqOWThevPllP3zwhexaKfA
	H6rwCD3jej5whv4I4uC0YT4tECg7DuhnTu6Q5fD6Qu+wWdOM0tEVYB4OgglmmR9LND+9sHlt0+G
	EGQYUe0tn+nvmPtbQ3BAwA==
X-Google-Smtp-Source: AGHT+IF2l5PVy91vTFj66p5wYTQHxdupTViszX/+2Cqp8BtYZ8fdqLxQhcLUr5scam++YRq0kXz6Fw==
X-Received: by 2002:a05:6512:3e17:b0:540:3550:b1dd with SMTP id 2adb3069b0e04-542845b188fmr8176393e87.3.1736817723193;
        Mon, 13 Jan 2025 17:22:03 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be54804sm1532169e87.92.2025.01.13.17.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 17:22:01 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	W_Armin@gmx.de,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH] ACPI: fan: Add fan speed reporting for fans with only _FST
Date: Tue, 14 Jan 2025 02:21:50 +0100
Message-ID: <20250114012150.156349-1-josh@joshuagrisham.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add support for ACPI fans with _FST to report their speed even if they do
not support fan control.

As suggested by Armin Wolf [1] and per the Windows Thermal Management
Design Guide [2], Samsung Galaxy Book series devices (and possibly many
more devices where the Windows guide was strictly followed) only implement
the _FST method and do not support ACPI-based fan control.

Currently, these fans are not supported by the kernel driver but this patch
will make some very small adjustments to allow them to be supported.

This patch is tested and working for me on a Samsung Galaxy Book2 Pro whose
DSDT (and several other Samsung Galaxy Book series notebooks which
currently have the same issue) can be found at [3].

[1]: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-463912dd966d@gmx.de
[2]: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/design-guide
[3]: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e3087a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt

Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
---
 drivers/acpi/fan.h       |  1 +
 drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
 drivers/acpi/fan_core.c  | 24 ++++++++++++++++--------
 drivers/acpi/fan_hwmon.c |  6 ++++++
 4 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 488b51e2c..d0aad88a7 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -49,6 +49,7 @@ struct acpi_fan_fst {
 
 struct acpi_fan {
 	bool acpi4;
+	bool acpi4_only_fst;
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index f4f6e2381..d83f88429 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -75,15 +75,6 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 	struct acpi_fan *fan = acpi_driver_data(device);
 	int i, status;
 
-	sysfs_attr_init(&fan->fine_grain_control.attr);
-	fan->fine_grain_control.show = show_fine_grain_control;
-	fan->fine_grain_control.store = NULL;
-	fan->fine_grain_control.attr.name = "fine_grain_control";
-	fan->fine_grain_control.attr.mode = 0444;
-	status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
-	if (status)
-		return status;
-
 	/* _FST is present if we are here */
 	sysfs_attr_init(&fan->fst_speed.attr);
 	fan->fst_speed.show = show_fan_speed;
@@ -92,7 +83,19 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 	fan->fst_speed.attr.mode = 0444;
 	status = sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr);
 	if (status)
-		goto rem_fine_grain_attr;
+		return status;
+
+	if (fan->acpi4_only_fst)
+		return 0;
+
+	sysfs_attr_init(&fan->fine_grain_control.attr);
+	fan->fine_grain_control.show = show_fine_grain_control;
+	fan->fine_grain_control.store = NULL;
+	fan->fine_grain_control.attr.name = "fine_grain_control";
+	fan->fine_grain_control.attr.mode = 0444;
+	status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
+	if (status)
+		goto rem_fst_attr;
 
 	for (i = 0; i < fan->fps_count; ++i) {
 		struct acpi_fan_fps *fps = &fan->fps[i];
@@ -109,18 +112,18 @@ int acpi_fan_create_attributes(struct acpi_device *device)
 
 			for (j = 0; j < i; ++j)
 				sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
-			goto rem_fst_attr;
+			goto rem_fine_grain_attr;
 		}
 	}
 
 	return 0;
 
-rem_fst_attr:
-	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
-
 rem_fine_grain_attr:
 	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 
+rem_fst_attr:
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
 	return status;
 }
 
@@ -129,9 +132,13 @@ void acpi_fan_delete_attributes(struct acpi_device *device)
 	struct acpi_fan *fan = acpi_driver_data(device);
 	int i;
 
+	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
+
+	if (fan->acpi4_only_fst)
+		return;
+
 	for (i = 0; i < fan->fps_count; ++i)
 		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
 
-	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 }
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 10016f52f..b51b1481c 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -211,6 +211,11 @@ static bool acpi_fan_is_acpi4(struct acpi_device *device)
 	       acpi_has_method(device->handle, "_FST");
 }
 
+static bool acpi_fan_has_fst(struct acpi_device *device)
+{
+	return acpi_has_method(device->handle, "_FST");
+}
+
 static int acpi_fan_get_fif(struct acpi_device *device)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -327,7 +332,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
-	if (acpi_fan_is_acpi4(device)) {
+	if (acpi_fan_is_acpi4(device))
+		fan->acpi4 = true;
+	else if (acpi_fan_has_fst(device))
+		fan->acpi4_only_fst = true;
+
+	if (fan->acpi4) {
 		result = acpi_fan_get_fif(device);
 		if (result)
 			return result;
@@ -335,7 +345,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_get_fps(device);
 		if (result)
 			return result;
-
+	} else if (fan->acpi4 || fan->acpi4_only_fst) {
 		result = devm_acpi_fan_create_hwmon(device);
 		if (result)
 			return result;
@@ -343,8 +353,6 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_create_attributes(device);
 		if (result)
 			return result;
-
-		fan->acpi4 = true;
 	} else {
 		result = acpi_device_update_power(device, NULL);
 		if (result) {
@@ -391,7 +399,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 err_unregister:
 	thermal_cooling_device_unregister(cdev);
 err_end:
-	if (fan->acpi4)
+	if (fan->acpi4 || fan->acpi4_only_fst)
 		acpi_fan_delete_attributes(device);
 
 	return result;
@@ -401,7 +409,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
-	if (fan->acpi4) {
+	if (fan->acpi4 || fan->acpi4_only_fst) {
 		struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 		acpi_fan_delete_attributes(device);
@@ -415,7 +423,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
 static int acpi_fan_suspend(struct device *dev)
 {
 	struct acpi_fan *fan = dev_get_drvdata(dev);
-	if (fan->acpi4)
+	if (fan->acpi4 || fan->acpi4_only_fst)
 		return 0;
 
 	acpi_device_set_power(ACPI_COMPANION(dev), ACPI_STATE_D0);
@@ -428,7 +436,7 @@ static int acpi_fan_resume(struct device *dev)
 	int result;
 	struct acpi_fan *fan = dev_get_drvdata(dev);
 
-	if (fan->acpi4)
+	if (fan->acpi4 || fan->acpi4_only_fst)
 		return 0;
 
 	result = acpi_device_update_power(ACPI_COMPANION(dev), NULL);
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index bd0d31a39..87bee018c 100644
--- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -43,6 +43,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
 		case hwmon_fan_input:
 			return 0444;
 		case hwmon_fan_target:
+			/*
+			 * Fans with only _FST do not support fan control.
+			 */
+			if (fan->acpi4_only_fst)
+				return 0;
+
 			/*
 			 * When in fine grain control mode, not every fan control value
 			 * has an associated fan performance state.
-- 
2.45.2


