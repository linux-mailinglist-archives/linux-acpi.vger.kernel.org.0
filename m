Return-Path: <linux-acpi+bounces-10822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17105A1C29F
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B9CB7A2D28
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DFC1DC9AA;
	Sat, 25 Jan 2025 10:07:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8F1DD0D5;
	Sat, 25 Jan 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737799641; cv=none; b=sy/aYy/S7K90HGfXnDvuLUwZI0i1pRn3bwYibmBgcaNeMWTahMc4x6lHoJjX6sYZwqCC/ejfJz7eyPr6/tAiae6nijrWjOR+yx0j6eFD/hRtSst7KwGt98oOt2AE4tla+EijDuck+Z0mtczN8yyvY2u6cydrV5WcDcSs1dsrjGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737799641; c=relaxed/simple;
	bh=106gxoPgzp0PB86ZGCsVboAv30AVLFAVL76DkpSTBUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIPn5/hnMbVE7TP1wiCjM4byTDp2xa34pMipHR1pDfWLPNzxt7XFFnCuvgFsAkgHra4Ofh0osCvozPH1JTLT5tYts/zqkyH4Dw8JbneAvGMKo6Zzse5XfsvIg7A9Wrql9Rgd0OBkZmWrpzKvEsOtWFH7HxYiiB6KP5C9hrPkyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30167f4c1e3so28374381fa.3;
        Sat, 25 Jan 2025 02:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737799638; x=1738404438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exQX7lnqf4ei1txf0Zz4XrzUF/EuX7n8TanQKddW184=;
        b=IW4yPQ+Qr+0izVkGQ9fhSAbZV3T3xA92hAcUPQR9D1oVecVK+di/rPJBIJY8gmbKYC
         lXbgaeOn54emS7VyCGXIkjRJhT7dsh+cqfzEX9dJ6Uy0Hh+nW0ejkLUIKysiI1yO+Cxe
         Sab9CQAHxdmLrpX4A7Xd6OJF0jycrPYWU5ROO7QLbDVmPL3zpPx9Oowk8RkXDOIHjQqG
         kCo3TeWkGqYc+S9kuzNo+CiwmEVw8vgPIbCkIF8fysrVoabVDpi472IZaXkJh0cvkWUL
         FH1IIa0cHGDZhAl6LKgjcYZUxUoCZzekWIhOr+6Gid0RT7kUmPlNP91+Wh8A0wQYBR1R
         0K1w==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9EqQZgEp4lfmkle/BHS1t/M8m/YNSmV7cKZkpeteS9jNDb5/hw/IVjlMPclBlrSr04W0u4QCnW84@vger.kernel.org, AJvYcCWxv2Im9x4mFyBDf/Ow+o2X1twmD3fCpIL2PDhNwGKP2LLg74mazY/D2/1OWYYM6LVUsT+s7/9N9r93KMLJ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx18cpaaehzNlpP4DqnrAqSFVZr3iHEjBLIglwx/Cqol+IxFki
	PsZF/lV3rNEdhUJC/whXy1/zxTi8H+OnaAPyhYi8p9ndUJDMG+2c
X-Gm-Gg: ASbGncsDXq5wUL/T/D75pFopZwfpozElo330AllF1LE5rPB+1L2hSYplIgP5O2ZtIUn
	SvUyvyC45fAk6a1wEnRIu8CFHnVcfIzxLjLry8DfjJXn3U9GwXyCOGMV7YStTUFhJuvRESDNf/F
	yexBmjAgRTa0KkIE86+Cer/ePNHzdGNImBYuU1yX5ZfYuRd6AUogozp5DlVxTf0PqzLARlgoYb0
	3dVXOmphOzOKXB7zLQdSIFbmEliltTqFsQTQBKW0ULGlS4jMt9lB4BZCnOmGLt25iU6l0HIQxuJ
	+LkK0VDFCAkal1XIAnhHNCz8e71zQuAARRNx5KGUJWSg5Q==
X-Google-Smtp-Source: AGHT+IHP4+o1ia7RydO/pFqGPxhD0TUNcK2FU2+QMbGoIRW5KfwVT4CkSQa/OpyghlMRSlnIT6yPug==
X-Received: by 2002:a05:651c:389:b0:2ff:d2e4:8dd9 with SMTP id 38308e7fff4ca-3072cb8140cmr102568021fa.32.1737799637619;
        Sat, 25 Jan 2025 02:07:17 -0800 (PST)
Received: from galaxybook.local (82-183-24-76.customers.ownit.se. [82.183.24.76])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076ba6bd74sm6772711fa.3.2025.01.25.02.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:07:16 -0800 (PST)
From: Joshua Grisham <josh@joshuagrisham.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	W_Armin@gmx.de,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Joshua Grisham <josh@joshuagrisham.com>
Subject: [PATCH v3] ACPI: fan: Add fan speed reporting for fans with only _FST
Date: Sat, 25 Jan 2025 11:07:11 +0100
Message-ID: <20250125100711.70977-1-josh@joshuagrisham.com>
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

v2->v3:
- Still allow acpi4_only_fst fans to set initial power state on probe
---
 drivers/acpi/fan.h       |  1 +
 drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
 drivers/acpi/fan_core.c  | 22 +++++++++++++++++-----
 drivers/acpi/fan_hwmon.c | 12 ++++++++++++
 4 files changed, 52 insertions(+), 20 deletions(-)

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
index 10016f52f..66aa1be64 100644
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
@@ -343,9 +355,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
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
@@ -391,7 +403,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
 err_unregister:
 	thermal_cooling_device_unregister(cdev);
 err_end:
-	if (fan->acpi4)
+	if (fan->acpi4 || fan->acpi4_only_fst)
 		acpi_fan_delete_attributes(device);
 
 	return result;
@@ -401,7 +413,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
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


