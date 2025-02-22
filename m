Return-Path: <linux-acpi+bounces-11382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F05A4070A
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 10:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E92C174846
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 09:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31312207673;
	Sat, 22 Feb 2025 09:44:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE020766A;
	Sat, 22 Feb 2025 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217467; cv=none; b=IdKuRIv0ce02tEk/fZTz8FcOOthn464oCEjTgtwBQAyQOg0u6qDsPp14673kLWdl1Rzp9kJAqihh+yj5dr2Uc7lhLEDWDpA6vHk4mlhW99xaHBcJETiuZ4iCdgbELyvh/WlQm6X01ZOh0L0Wr9urEgwZsLd48YJ6b6CHrdsOzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217467; c=relaxed/simple;
	bh=xFwG25lDywktFLiKzvpSN4niTj7Ud4LQO8u56RFEFu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtHUtI46UIM3R+Z+DObboP8zzr/4E6ZZyt6DRq1osDhhJ1hUHnHxf8Kv3Rc8utf+WOPILzzVVM0gpdYnqjMcUz5JKTsHLZZEnnmXkkW62LjaGPQYfcPVm9xo8bmOVVnwQ+MRMwKuATGf3iuMHc2PZdQzl2/kqNRflQAS/jMWmuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30762598511so26274031fa.0;
        Sat, 22 Feb 2025 01:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740217463; x=1740822263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyaGLy6Zazy9Vk9M+oYm8rxavaRsGd6sC1+fkeP904c=;
        b=Gkn4Fgzxn09as2Nyg47OkmnYJgQvoC4L9Oa0MGh71gOr2PlEHY/A121oGKZtzaRtOA
         vwhuWYpd08WrG7vSLjhBlLm3f93pAI46DZUCxFpujzxCTAhmJuDEWMPWwAfmYDzf6zdn
         PD6YyeYdGR3O5ciP48S2Xw8AldSMe1iQSH+3BLIgBEU0zhHHQUDhEFBIVAaBVZRUrWVO
         47IK6fRw0DfQg5d6lMARgqjeyJ2PRShO7ahawR5Zf0wMgSSKcoY5g4RhTZbyg0vTpoAV
         Nh8oL3eX4ZZk2rDVnN/Dow01vffn/fqv49EX7wKeZAzYxe1DHNKiPoQ4qZug6DeWo7pk
         kreQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0+1K85gP0e0mmBB9rLyCWLzh56aZMjpLw/Fk+tWKFMXK2Z0roLKwCZvXWSPYK2NA3EAvJOFrrfhsjGW+6@vger.kernel.org, AJvYcCXiE55TsTedvncRX2o1FTLFG/1XtnZN4S1WNxub6b9NL26Hg0qSEtcx4EN1Gfdyxr+yfinIHFPCjWKb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Sl2L/XKMB6Q4tR8I+GXemCZhlp+OjQQIZLMe3y4DRY5B9i6O
	wJqDNYQlh1aB/1wMzQ4OWDxQM+nrELj3MQts+o+QjAWAHcMHC+9OG0UzxLJF
X-Gm-Gg: ASbGnctx9Z5TdvFfPdS4JRdN3x+xy5w97RZq+KXD+UQwwMTTG7LbJh9b76LgpvEFNBI
	uDyIsVsgWEbAre4+eeexPfIuxpJlq3mGNQrTIuqRGmmkpHxTGpQtvA/ncUopYGqoS68KvNbK2MP
	xUkgJZ7jSw7qWJUz/hPjCqysYdmAMl/uJq98gH6fvBuyjDPlXhlDwEliBukqIs+23xQ0fqlCdo4
	zJjzP3hNCl5WeYHMvE294ZR3qy7ATvmBVqY43NY3OGN217yzUXxl1ttePieTAR3BIzYLsJjjP46
	BITFnlNyhkCixv8wtZWGq/fgwVluoPZ1g3qv2gHpdieqF1PmzfSVWoH05CwiDTDNO6I=
X-Google-Smtp-Source: AGHT+IHGpOe6u4HFAcRwTgyJvSDXK7kdue2hbaz8MOINRJWvlA+HYH3Eojlv3W8izZ5/CNSX7BD0Cg==
X-Received: by 2002:a2e:6a15:0:b0:300:5c57:526b with SMTP id 38308e7fff4ca-30a598dd6d1mr23684711fa.11.1740217462630;
        Sat, 22 Feb 2025 01:44:22 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a33d3a6ffsm17950901fa.32.2025.02.22.01.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 01:44:21 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	W_Armin@gmx.de,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH v4] ACPI: fan: Add fan speed reporting for fans with only _FST
Date: Sat, 22 Feb 2025 10:44:07 +0100
Message-ID: <20250222094407.9753-1-josh@joshuagrisham.com>
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
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

---

v1->v2:
- Still allow acpi4_only_fst fans to update power state on
  suspend/resume
- Fix if / else if logic error
- Also hide hwmon_power_input for acpi4_only_fst fans

v2->v3:
- Still allow acpi4_only_fst fans to set initial power state on probe

v3->v4:
- Small tweaks to naming (acpi4_only_fst became has_fst) and logic flow
  based on feedback from Rafael
- Built against next and tested working on Samsung Galaxy Book2 Pro
---
 drivers/acpi/fan.h       |  1 +
 drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
 drivers/acpi/fan_core.c  | 25 ++++++++++++++++++-------
 drivers/acpi/fan_hwmon.c |  8 ++++++++
 4 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 488b51e2c..15eba1c70 100644
--- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -49,6 +49,7 @@ struct acpi_fan_fst {
 
 struct acpi_fan {
 	bool acpi4;
+	bool has_fst;
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index f4f6e2381..22d29ac24 100644
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
+	if (!fan->acpi4)
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
+	if (!fan->acpi4)
+		return;
+
 	for (i = 0; i < fan->fps_count; ++i)
 		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
 
-	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
 	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
 }
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 10016f52f..8ad12ad3a 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -203,12 +203,16 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
  * --------------------------------------------------------------------------
 */
 
+static bool acpi_fan_has_fst(struct acpi_device *device)
+{
+	return acpi_has_method(device->handle, "_FST");
+}
+
 static bool acpi_fan_is_acpi4(struct acpi_device *device)
 {
 	return acpi_has_method(device->handle, "_FIF") &&
 	       acpi_has_method(device->handle, "_FPS") &&
-	       acpi_has_method(device->handle, "_FSL") &&
-	       acpi_has_method(device->handle, "_FST");
+	       acpi_has_method(device->handle, "_FSL");
 }
 
 static int acpi_fan_get_fif(struct acpi_device *device)
@@ -327,7 +331,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
 	device->driver_data = fan;
 	platform_set_drvdata(pdev, fan);
 
-	if (acpi_fan_is_acpi4(device)) {
+	if (acpi_fan_has_fst(device)) {
+		fan->has_fst = true;
+		fan->acpi4 = acpi_fan_is_acpi4(device);
+	}
+
+	if (fan->acpi4) {
 		result = acpi_fan_get_fif(device);
 		if (result)
 			return result;
@@ -335,7 +344,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_get_fps(device);
 		if (result)
 			return result;
+	}
 
+	if (fan->has_fst) {
 		result = devm_acpi_fan_create_hwmon(device);
 		if (result)
 			return result;
@@ -343,9 +354,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
 		result = acpi_fan_create_attributes(device);
 		if (result)
 			return result;
+	}
 
-		fan->acpi4 = true;
-	} else {
+	if (!fan->acpi4) {
 		result = acpi_device_update_power(device, NULL);
 		if (result) {
 			dev_err(&device->dev, "Failed to set initial power state\n");
@@ -391,7 +402,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 err_unregister:
 	thermal_cooling_device_unregister(cdev);
 err_end:
-	if (fan->acpi4)
+	if (fan->has_fst)
 		acpi_fan_delete_attributes(device);
 
 	return result;
@@ -401,7 +412,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
 {
 	struct acpi_fan *fan = platform_get_drvdata(pdev);
 
-	if (fan->acpi4) {
+	if (fan->has_fst) {
 		struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 
 		acpi_fan_delete_attributes(device);
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index bd0d31a39..e8d906051 100644
--- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -43,6 +43,10 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
 		case hwmon_fan_input:
 			return 0444;
 		case hwmon_fan_target:
+			/* Only acpi4 fans support fan control. */
+			if (!fan->acpi4)
+				return 0;
+
 			/*
 			 * When in fine grain control mode, not every fan control value
 			 * has an associated fan performance state.
@@ -57,6 +61,10 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
 	case hwmon_power:
 		switch (attr) {
 		case hwmon_power_input:
+			/* Only acpi4 fans support fan control. */
+			if (!fan->acpi4)
+				return 0;
+
 			/*
 			 * When in fine grain control mode, not every fan control value
 			 * has an associated fan performance state.
-- 
2.45.2


