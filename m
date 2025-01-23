Return-Path: <linux-acpi+bounces-10806-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD8AA1AD26
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 00:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9483C7A521C
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 23:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926A51D5AD4;
	Thu, 23 Jan 2025 23:14:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D611CCB26;
	Thu, 23 Jan 2025 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674046; cv=none; b=S3Z2XZiwoijWMF/TlDmHbOwo1BhiFjv2DZvVpVNzGPJGleFnK6w9BwZAu8vPEv0qo+qIIf/RIBEHXNyVK9S+uVezpWReW9MzdRRjqRv0BBHZh75AIA0Na0ICv+SfvIFrA8u96Yyi6N2f8+E+YytIICLYZ//UIcLWZ6nuV4USs2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674046; c=relaxed/simple;
	bh=pQjo9zo0LjDuMtx2SvhfNbgMCORU/kmYV2NLWfD6Dfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQfZc6/PBvkz4BjxU/Z1+0Kgx8IOEKppM3M5SphEzwXzVE1ef+BdxT+9mfzL6lz7Sdk6u2M0qWwunUxs6cj/jmnAKr3DffxZYPsguDpgqfJXDFTB0eVTdyX89vcyqIf2YeVCi84f+4zD7npg+NLaio43rTK1avGyk35ZU89gfUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54024ecc33dso1542319e87.0;
        Thu, 23 Jan 2025 15:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737674042; x=1738278842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWXRd+Fn35CZTLdvuOqI1ql2LxXrjRMEmBrMaiLCETk=;
        b=nGfeAzCzclhaA76AH3nK90CssICTaYKfJi6hCTJqVjPoNJyUmewrWqnAWMLRWQN3oT
         gbUKCZbJl/TGHCQ/XOT46sqzCqME8DSDuqXCXzOYvQmi9HQY4oT5CsLo8q/6IGrloHLX
         EDEaOzL+0hp66k3yfLodLyG3xkW0NoARDcZ7CWdWd7UNbxSHOnum7H1uYG4pKzITs4U5
         sG2Q++1QHews7Pp9pXXRZLN5ganhZZcI9nUVEkVkoPXrI9m4eWVgZuvREmUwGSpwNmm2
         yu8TpDliqTtB38o3M4vD65zKGzTtzjtcweSwe8b2y9gikfBgN2bCG1tp5z8n6J5/12VB
         4ZLg==
X-Forwarded-Encrypted: i=1; AJvYcCUM4Y9ZH7R8qIIWDIWpEyvQXSz4u7jIGP8jgZK3n1eecOXylPQ+/xmeiUxFAiXnvxT9K4TR6vDehr0ky1Ch@vger.kernel.org, AJvYcCUQdHK5qVB3Y7sXiZw61HkrwMgo8uK6YTlgLJWQwVr/7+xPJ1GNhg0xSdaJN2kG4iGLa+MDtsvEKxaS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/hQUaJD4DxT8AHKcO/kUCXpLHi+fQorB5GbImrklyjT+Ph+A
	+/GXgEDgFJpXwKhOnkvJw1KH9z2uNcq8vVzhh8qnThNvp1iqPoZJ
X-Gm-Gg: ASbGncvfX5t+VTqn9Mtz6NHuKAMYxIq93bNjltb2Uav2pdUTmkTe6co4q2ws+kPs5Kr
	qGZCDTNOc8DFWulzV7cCzJWt2EvoaFWTW/DJNo7ZEYJpKo6c6u5BGXWTZQeBOZTcvL8pVARW1o7
	VSZ53lCHFLwitmK3EbMm0+/wBL/wm96X7Dqy536pQTN5QwWGPbSaIx015zJ0I0pGTrssksaR0v+
	Hh6nbf0lKIeJJUnQiRxBZojip3HUJB61/ySs1WmMrDOoKMERlZSXGAen82/l6z9UgGkvxe+7Z6f
	nf4symujaBaClCe8Oi1Th8YtxbhKexhENpbV43ToblVpPw==
X-Google-Smtp-Source: AGHT+IGMbTb7EZDsEyAYXFr7ZP5LggUwIa3Q/xNhfqVdbUrwXI0HWhss/JFFRl/91QNNeVnt3k25hA==
X-Received: by 2002:a05:6512:ac7:b0:53e:3ac2:9c01 with SMTP id 2adb3069b0e04-5439c24111cmr11865198e87.16.1737674042166;
        Thu, 23 Jan 2025 15:14:02 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8228a4asm80439e87.30.2025.01.23.15.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 15:14:00 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	W_Armin@gmx.de,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH v2] ACPI: fan: Add fan speed reporting for fans with only _FST
Date: Fri, 24 Jan 2025 00:13:54 +0100
Message-ID: <20250123231355.6456-1-josh@joshuagrisham.com>
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

v1->v2:
- Still allow acpi4_only_fst fans to update power state on
  suspend/resume
- Fix if / else if logic error
- Also hide hwmon_power_input for acpi4_only_fst fans
---
 drivers/acpi/fan.h       |  1 +
 drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
 drivers/acpi/fan_core.c  | 20 +++++++++++++++-----
 drivers/acpi/fan_hwmon.c | 12 ++++++++++++
 4 files changed, 50 insertions(+), 20 deletions(-)

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
index 10016f52f..ca4785797 100644
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
@@ -335,7 +345,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_get_fps(device);
 		if (result)
 			return result;
+	}
 
+	if (fan->acpi4 || fan->acpi4_only_fst) {
 		result = devm_acpi_fan_create_hwmon(device);
 		if (result)
 			return result;
@@ -343,8 +355,6 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_create_attributes(device);
 		if (result)
 			return result;
-
-		fan->acpi4 = true;
 	} else {
 		result = acpi_device_update_power(device, NULL);
 		if (result) {
@@ -391,7 +401,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 err_unregister:
 	thermal_cooling_device_unregister(cdev);
 err_end:
-	if (fan->acpi4)
+	if (fan->acpi4 || fan->acpi4_only_fst)
 		acpi_fan_delete_attributes(device);
 
 	return result;
@@ -401,7 +411,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
-	if (fan->acpi4) {
+	if (fan->acpi4 || fan->acpi4_only_fst) {
 		struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 		acpi_fan_delete_attributes(device);
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index bd0d31a39..d0668ecc2 100644
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
@@ -57,6 +63,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
 	case hwmon_power:
 		switch (attr) {
 		case hwmon_power_input:
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


