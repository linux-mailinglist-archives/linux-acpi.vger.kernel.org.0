Return-Path: <linux-acpi+bounces-9741-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE1D9D5C62
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 10:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99933B2456F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919F1DF742;
	Fri, 22 Nov 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4JcKc1e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF81DEFF6
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268913; cv=none; b=QD+3VN8XsGt0Z/1RRMq4kkZtL6/z3aaAljl2Ru8B5YEKMe4sORnE2p4OdmictXVfu4CSKiV7gD5G7vGjQimQH1PRPjUmDIljcN47f2gmGg24HF7R2WV6bFmGDsMuI7KfOk2IzO7j4puV/+CwxybvKENdx5+9neR2dmy6NklXisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268913; c=relaxed/simple;
	bh=/xyrOk13WfYwXnzGF1BEMgqEZvLsICd5gWhhYG2cImQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJyw6eHU4kB9xIPHv4YfF4pna02jN9cEYNxa0O+eE/EIOoxkYLPresvm1e1LTIjFwBMMWNiqsnQ1k6D6KbxCN5NObSPig0KcHZRblWwxtkneyeG5UMEzM6BDKmTY+ZPG1OE1IIyl/gwYI4v894rRhySXn+XdoICBHS4ociFF8sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4JcKc1e; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4609c96b2e5so12689561cf.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 01:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732268909; x=1732873709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKV0qKpenqq8YefMBn8axPBP/1pf6x8COWK/EGNLUhk=;
        b=K4JcKc1emtFZL8AasidnVN6IgGI894tWJKkBfVZw+HSi3ezVGLAwmrBzMWDkck6+iW
         pDdzQo5o7QbSRic9VOi/pDSh2Ds0S34oDo/CrG4pTvpaQ8fpk2yy1D7UonxKxXh9njAE
         OZCJpJ4o2hbYu1CN8gTr0RubqdaQQawl0rriQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268909; x=1732873709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKV0qKpenqq8YefMBn8axPBP/1pf6x8COWK/EGNLUhk=;
        b=ZeMVOI6xkG6iCeeebcgMVe+NdwlglQGpyqxbpmlI3QPkM0SfpOHMkgOikmjpxwwpyC
         xd6X2JbDWk6GtvzqZRv9EF1QOHpSveifhox+wo1DFNAk7WjaX6XtsZN4ILObIVQfhnTE
         ezg/QQNGcUkoeUXDf3nkH3rp3OrgE4fGMk4WyGc8YsGSMgiptbGcx7bRkhhFDm2Jr8vF
         IoTZ630skEyqzul5GNZR6IN6BC9eDC2fIE8bF/eJlTZYIgS6H91J64Byppo8SuwjX2Si
         e6nYBN1sjR2qUn9gHJab1gK5/btXJW/v7vO/2tw4z0Ls2xqrGzUCH1OsJdOVxFcCgASO
         pEGA==
X-Forwarded-Encrypted: i=1; AJvYcCXGuurIb2owTFTO1j+Ec9cExtNhuYdgbmmseIddj1V4USnjutrqoKmS5KUaT1FXvzq4yENktG4ySmdG@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpQQuGASC9ZuFSAnQmv6sA8n/UmJzEnQPVrDGYSpHUBbIbVOw
	wK/55PMrhDiWuEuzPjhoyzXWRWo8JPutPzSoyI1YL1pPzbEpUkplxhBD8xYh8Q==
X-Gm-Gg: ASbGncvAd61iDSeb3y5kHWNktobDJjqoIOLZb09ZT2Hn35iX/KDjxhBQpEb7mYGDQki
	PdcTZG6VWsKdypB2b1WzivJWoefCTFOtDFiNuZHPpgg5Nm0gCDfBBUbPJLxTUhY0rjeHwCP/6fs
	GOwUhg5uCIkr7wBzKxUcgGSwcFePL0p3wmxE6rojtrpZ9SnN6k26fy2SXOO+rQIuJsW0VqdKZiS
	0QJAgOF/zGvZOsL4k6D5ZOjtHi6nq1gHOUzfMZ7CFn6qdFkOAaTy3/j8s1oZ//+oNxGvRfTS348
	Ibmb18WizKqOSwFU34oF2kiS
X-Google-Smtp-Source: AGHT+IGkqqWnODk2xignRvaov7QmeTL3jw/lsAM7Pyz5eBZ/ng+3qbMNUUQf4HXvA77w2WK8NKWLDQ==
X-Received: by 2002:ac8:5ac6:0:b0:461:1532:d769 with SMTP id d75a77b69052e-4653d63aebamr22893621cf.54.1732268909452;
        Fri, 22 Nov 2024 01:48:29 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4653c47f124sm9282731cf.62.2024.11.22.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:48:28 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 09:48:04 +0000
Subject: [PATCH v2 7/7] media: ipu-bridge: Remove unneeded conditional
 compilations
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-fix-ipu-v2-7-bba65856e9ff@chromium.org>
References: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
In-Reply-To: <20241122-fix-ipu-v2-0-bba65856e9ff@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The ACPI headers have introduced implementations for some of their
functions when the kernel is not configured with ACPI.

Let's use them instead of our conditional compilation. It is easier to
maintain and less prone to errors.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu-bridge.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index be82bc3e27d0..6bdf42f6769f 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -2,6 +2,7 @@
 /* Author: Dan Scally <djrscally@gmail.com> */
 
 #include <linux/acpi.h>
+#include <acpi/acpi_bus.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
@@ -107,7 +108,6 @@ static const char * const ipu_vcm_types[] = {
 	"lc898212axb",
 };
 
-#if IS_ENABLED(CONFIG_ACPI)
 /*
  * Used to figure out IVSC acpi device by ipu_bridge_get_ivsc_acpi_dev()
  * instead of device and driver match to probe IVSC device.
@@ -131,7 +131,7 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
 			/* camera sensor depends on IVSC in DSDT if exist */
 			for_each_acpi_consumer_dev(ivsc_adev, consumer)
-				if (consumer->handle == handle) {
+				if (ACPI_PTR(consumer->handle) == handle) {
 					acpi_dev_put(consumer);
 					return ivsc_adev;
 				}
@@ -139,12 +139,6 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 
 	return NULL;
 }
-#else
-static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev)
-{
-	return NULL;
-}
-#endif
 
 static int ipu_bridge_match_ivsc_dev(struct device *dev, const void *adev)
 {
@@ -261,9 +255,7 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_orientation(struct acpi_dev
 	struct acpi_pld_info *pld = NULL;
 	acpi_status status = AE_ERROR;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	status = acpi_get_physical_device_location(adev->handle, &pld);
-#endif
 	if (ACPI_FAILURE(status)) {
 		dev_warn(ADEV_DEV(adev), "_PLD call failed, using default orientation\n");
 		return V4L2_FWNODE_ORIENTATION_EXTERNAL;
@@ -498,9 +490,7 @@ static void ipu_bridge_create_connection_swnodes(struct ipu_bridge *bridge,
 	if (sensor->csi_dev) {
 		const char *device_hid = "";
 
-#if IS_ENABLED(CONFIG_ACPI)
 		device_hid = acpi_device_hid(sensor->ivsc_adev);
-#endif
 
 		snprintf(sensor->ivsc_name, sizeof(sensor->ivsc_name), "%s-%u",
 			 device_hid, sensor->link);
@@ -671,11 +661,7 @@ static int ipu_bridge_connect_sensor(const struct ipu_sensor_config *cfg,
 	struct acpi_device *adev = NULL;
 	int ret;
 
-#if IS_ENABLED(CONFIG_ACPI)
 	for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
-#else
-	while (true) {
-#endif
 		if (!ACPI_PTR(adev->status.enabled))
 			continue;
 
@@ -768,15 +754,10 @@ static int ipu_bridge_ivsc_is_ready(void)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++) {
-#if IS_ENABLED(CONFIG_ACPI)
 		const struct ipu_sensor_config *cfg =
 			&ipu_supported_sensors[i];
 
 		for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) {
-#else
-		while (false) {
-			sensor_adev = NULL;
-#endif
 			if (!ACPI_PTR(sensor_adev->status.enabled))
 				continue;
 

-- 
2.47.0.371.ga323438b13-goog


