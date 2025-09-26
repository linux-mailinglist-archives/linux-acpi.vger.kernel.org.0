Return-Path: <linux-acpi+bounces-17349-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A0FBA3C87
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8082B1C0130F
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C51A2FB972;
	Fri, 26 Sep 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpOVhZG3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63F2F6184
	for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892298; cv=none; b=RQ+WT7d+562ttQyA8cpYoaLaaZxgxh9VvESnY21tERH+9B3FNjWLtd0Vt5XTzUpaB2SROyPcWG+miz8p/SlUKVGO/D536lFJ6uL35eRLf1IjG8vRT2o1LBCcvQocG0B+QdaX5AeDx7tR2LFezPQ6v73if8yJkAaG3li/EjhZtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892298; c=relaxed/simple;
	bh=8QXukFFdhrRn2peTuBfsWRiyR8y/J2hEQydiLTT8V2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgAhD+ZTqjrAL02g0VBHonj+XfH6yHiHhaR42pVoz0GGlxm7h6ozMNI6IfIieAPQyUl0x9S2LmD1fNCZBxyk0J8toCja5VhU6ILDadg5zYqWJviYIuIUqw/Lmu4nNRYlc0cXskq/QRV4GeBG1xc9PNDnB6Sif0FVBWFza46kuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CpOVhZG3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57bd7f0e5baso2080233e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 26 Sep 2025 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758892292; x=1759497092; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+IULFJYV86S6ZpfwTIK6NKFvLB7brLHHTAANiqsCeGE=;
        b=CpOVhZG3vaxV2fboQSsRh23NrW90eUjXQS6O48r81fKWyQ1M9GO2uGrcKf4PxEg4gX
         3I3U4y+P23YYueW78VE2BfMvSvXu39119YNbwseVb2awkxTYYHXQa/kSMzK5NKg5BtXz
         /mOmJlsI9jEAHUkIPEXIueXJNLkCDwTnc0SG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758892292; x=1759497092;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IULFJYV86S6ZpfwTIK6NKFvLB7brLHHTAANiqsCeGE=;
        b=NxgJF2VLlhkN6+j3CmBMBerh5oNc0s+bobkwNoD7VYVOIxd+wkCplGAGz/M+8BTg3i
         68730ZDiG8j+zIrbxv4Xtic4Ue5QX/Zls8dSQ8XWrEVCw/eUQgh73yFUEi9olySONW7n
         iKHzyqcE/bC/PSdoZeOFN+vnCr9DyfXVUiG0/lAFyUrBZq0bDISuznSOYHVQB5efoah6
         5p9Cfshcqg/Vrb2RcUdrwMvrQ8Z2cP32KM1UF/8qtcC7ri8q8jtLqLmzdzh4+uAQHrML
         Wi29tKykLDPVIdl1VM2IDbAnykxWwJA/WOAy12XuK34jiNQqcNYP3Fxz37k0h/VWc5tw
         XQRA==
X-Forwarded-Encrypted: i=1; AJvYcCU5YX9iMVANxdEzqsSXDYlZ6H15/fJjGpqspcT/uIZhVJa0dNZNtflkZ0NkemhX1nyIpFqpAwcKXIzL@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUDPwLOXV6ggM7FHoiy/CNdZi1pebb0bQpcXSvFU9Fo4ll5im
	rVSqyOM4CP0ixMjqdAESuj+EgXdBISDAO6pwLR6B9Z/VWl2KGgTfGE9CT+Icbm46/Q==
X-Gm-Gg: ASbGncssI1tRgheylJ6RWtCSyP/I+FErLqfEPCI91/4JYBfhYIEbYSXJe5kcrnnwmkK
	3Ze+JCgtjMGLDIcqQtQcGUuobGm1ft9umuo883u/t+74veG+tlpZwT4jAfPE319aHndy/AAOEZy
	5Kb5NCGU0t0Q4JczUZeaIJo3x4CRyd6V7rFKdxc1z6cPF0HEcJw22NU8bUOhawN5idxFtsHb7i8
	ChoKPjeJpPP7opz4PHqU8Tm9of9ykAJFnq5FdjFuebtw+QEMhOQB/SeBb57IZoBMmi13piKrrSJ
	ibAyJMcA2kKf0adpuQuwo+J76oPe9qQ1gniA7T3E/1obNbZ+gxCRKbpqj9pZfNnMHcdLar7xPcM
	3riGkrao2sK+hSsqCqYeJyhXPvi/dEEHgjOMmIQXeAzN9MBkqgQsVhrHOzfoGlcP69VkpENUgxk
	liCM5OJ8S/aUuA
X-Google-Smtp-Source: AGHT+IE/r2pIJwf7kAuauI+jC65tbRl8WC4I4+SdoNtU43PxQUMr/4vfCOnHocv1AyDV3BygK1ERFA==
X-Received: by 2002:a05:6512:2201:b0:570:e55e:47fc with SMTP id 2adb3069b0e04-582d3c9674cmr2179748e87.54.1758892292030;
        Fri, 26 Sep 2025 06:11:32 -0700 (PDT)
Received: from ribalda.c.googlers.com (64.153.228.35.bc.googleusercontent.com. [35.228.153.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58527c6b014sm123872e87.43.2025.09.26.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 06:11:31 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 26 Sep 2025 13:11:28 +0000
Subject: [PATCH v3 04/12] ACPI: mipi-disco-img: Do not duplicate rotation
 info into swnodes
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-uvc-orientation-v3-4-6dc2fa5b4220@chromium.org>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
In-Reply-To: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
To: Hans de Goede <hansg@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The function v4l2_fwnode_device_parse() is now capable of parsing the
_PLD method, there is no need to duplicate the rotation information in a
swnode.

Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/acpi/mipi-disco-img.c | 15 ---------------
 include/acpi/acpi_bus.h       |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 5b85989f96beeb726f59ac9e12e965a215fb38f6..b58b5ba22a47a4afc5212998074d322f0b7586dc 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -617,21 +617,6 @@ static void init_crs_csi2_swnodes(struct crs_csi2 *csi2)
 
 	adev_fwnode = acpi_fwnode_handle(adev);
 
-	/*
-	 * If the "rotation" property is not present, but _PLD is there,
-	 * evaluate it to get the "rotation" value.
-	 */
-	if (!fwnode_property_present(adev_fwnode, "rotation")) {
-		struct acpi_pld_info *pld;
-
-		if (acpi_get_physical_device_location(handle, &pld)) {
-			swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_ROTATION)] =
-					PROPERTY_ENTRY_U32("rotation",
-							   pld->rotation * 45U);
-			kfree(pld);
-		}
-	}
-
 	if (!fwnode_property_read_u32(adev_fwnode, "mipi-img-clock-frequency", &val))
 		swnodes->dev_props[NEXT_PROPERTY(prop_index, DEV_CLOCK_FREQUENCY)] =
 			PROPERTY_ENTRY_U32("clock-frequency", val);
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index aad1a95e6863d443a45985ba7ec7be4acf8664fe..296716875a3e7977abb7b7dfa89f78664aebd61c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -389,7 +389,6 @@ struct acpi_gpio_mapping;
 #define ACPI_DEVICE_SWNODE_PORT_NAME_LENGTH	8
 
 enum acpi_device_swnode_dev_props {
-	ACPI_DEVICE_SWNODE_DEV_ROTATION,
 	ACPI_DEVICE_SWNODE_DEV_CLOCK_FREQUENCY,
 	ACPI_DEVICE_SWNODE_DEV_LED_MAX_MICROAMP,
 	ACPI_DEVICE_SWNODE_DEV_FLASH_MAX_MICROAMP,

-- 
2.51.0.536.g15c5d4f767-goog


