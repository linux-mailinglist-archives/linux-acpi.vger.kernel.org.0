Return-Path: <linux-acpi+bounces-18607-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D30BC3D7A1
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 22:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF1964E2EB6
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Nov 2025 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4893306D2A;
	Thu,  6 Nov 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZz7JGLg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902D3064A2
	for <linux-acpi@vger.kernel.org>; Thu,  6 Nov 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464089; cv=none; b=WQvg3BW4RE7R+VPdkLpd2t6X1GelJf1Dk7tL6agD7E5uOiM+BlHeddKQrhx1a7ZdR3TSN6wbNbtsF6PwCk0uGHKyfATHFYqoE890OTZmtxp1eJSRw+HSvMSUCs95TjRN18v0tigXPAp1Ll5hPhMtrflY5wd0/6cwtJFD9YLXK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464089; c=relaxed/simple;
	bh=o1D+74u0jESsgRq+dEc78taFi1WVB7FieTFi9hP+7qU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vwf005KOwXZEmuiJsEjIvHyuLC5EjxFOLrK+z27800M9V4IvGDRZTQ2vyKTN54zNz87MLwCljyinYB40rYJjMcXcP0FoYh2n7MhWIvU5dAKUF8yqAsUKzGPgG3dfhASAVMDcXDoDYnTxDmRzdp3vcICJdkOfJzyUGOjDd5HWf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZz7JGLg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7afc154e411so67539b3a.1
        for <linux-acpi@vger.kernel.org>; Thu, 06 Nov 2025 13:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762464087; x=1763068887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X+nWVGtuau23CQKffdOvJt/AKrk9R0PxqKgoXH9rgI=;
        b=CZz7JGLgrwvFBipA8YIXNsJw6H5Dh8NlqHK66836nnD4BCUTI9zWYdaSJVJkvI4MuB
         sefHj3tglvb+RNHyEwIMVIBQuJ2RYlsHeUtG8N254NN1okMMIMqD+bEeBJoShnAbV+E3
         ikK7/cuKtyFR2KH/XchCjDiE4jg8mb0frN7LGNFD1pPatKqGZTgocG+JIH6oU8CAP6Nn
         R0CFAp1d45NbUvsRVohKmw/ezH+jFjmX2WBeijgrPkbOtPUoUGjSvO8YVCkaTefbi7Fy
         sYlrXZdF9q8s/1DEvKEcXpOFP2uYjiwTLWio2ppi9Djnbsi7hbfvSMqQXkUR5janDTFV
         /65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762464087; x=1763068887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+X+nWVGtuau23CQKffdOvJt/AKrk9R0PxqKgoXH9rgI=;
        b=c58/4wI/zvzA+AUv3Z8msG/NxjXjIIMzQE16RD7+6ZAqwDdYoz6Tbwq4+xY0LlGt5V
         +MotiRr81VFqBSmtLw4WOH/w5r63W9XYs7pYDq0XEpQ/iySHAv4rq0GrC9Uzu0vETrY7
         oipfuAChEkNdRDpDXwhK32eXaf7cszA/V4N2eWpX0F7QC8j+bQyFD6VEroYih4HGvpzx
         NkwMBs4jq6xYTEMVErfpSyFsvc/O2LwBEuXa2AheYWTzh/JGwGTupB83PakiLk1H06eq
         bKkCchYDZVFdxQZDGIKy3BzZ8SmCa3pKdeytfSYzAZT0xJgzGkp2Ot8Swzl9TJXnEezV
         bH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMfPI8hzqYeiJ3XDdXXLKYycjplV3ERhjusTSC13BB5kMAw9Hx8iNQfsXMeEbMXlszATE2qUK+BkwE@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7V5S4VIlXBjUUwCyP+MV/mo+fkWJm3f8s8IcsXdfnQH12rp8
	5phnhDyE/hX/aat2HMN9Gl55ZrHpzqGBTM9bUmaZtSx895UkSBvUvkxg
X-Gm-Gg: ASbGncuAMUTyAm4EFukNRScFFJkcIg3kMvB4rhCnpPmzyD40s+JPOH/FdXjJkBBYgA3
	AFfZ1sdPKSIr+VAqsEiSTcZAdJcobPdh52Tbi7bwaCsQ3qkGQysBQQYX5TvrvmTEZxy01A7hPOB
	6Ij/IApzO7AaNf/QcInVb7WTLL7EbdLHDBE/9mXgnlptv8gaxHvLQ0pRVNZSfMAtta7ePTVc/7b
	FvTqgTgJWioOWrHgM6ffL9Z5oN3Z+PEtyeq97ohO/5KV/zgPv5o8H0jy8Isc+qglFYPR6sbUwPk
	kHW3D5R3bGGp+pPzkX8qr6ZnxSuQOHNeBx/oeV0CsUDvnoQ53XAOZqLTTEwkeytr63tPu+vjZK8
	sIIb8cOSaKMo+bufhw5tjCxtnXHrw/bR05w2bnDR4F0jnPmow1NMEFV5pltBizxgi2iwe/cn2pc
	497i2FioZLatjAJQ/Ptj6S4v2p02ss0PsdFz+M3V5Cd5Lhbi564km67d4F
X-Google-Smtp-Source: AGHT+IHR8+vSxHEsoYKLoeyXM3WkEK6OcznT73MUUHSpR0cEymgpx8rJkPnHuN4Dr5upn1/aJ1SsfA==
X-Received: by 2002:a05:6a20:9389:b0:342:faff:7a7b with SMTP id adf61e73a8af0-3522b496eaemr1358803637.59.1762464087151;
        Thu, 06 Nov 2025 13:21:27 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d0a6sm521360b3a.12.2025.11.06.13.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:21:26 -0800 (PST)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86: lenovo-wmi-gamezone Use extreme rather than balanced-performance
Date: Thu,  6 Nov 2025 13:21:20 -0800
Message-ID: <20251106212121.447030-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106212121.447030-1-derekjohn.clark@gmail.com>
References: <20251106212121.447030-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When upstreaming the gamezone WMI drivers the "extreme" mode was matched
to performance and performance was matched to balanced-performance, but
only when extreme mode was fully enabled. Otherwise performance was
matched to performance. This has led to quite a bit of confusion with
users not understanding why the LED color indicating the platform
profile doesn't match their expectations.

To solve this, replace the confusing convention with the new "extreme"
profile. While add it, update the documentation to reflect the expected
LED colors in each mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 29 +++++++++----------
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 18 ++++--------
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
index 997263e51a7d..8fa0a27fc05d 100644
--- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
@@ -19,27 +19,24 @@ WMI GUID ``887B54E3-DDDC-4B2C-8B88-68A26A8835D0``
 The Gamezone Data WMI interface provides platform-profile and fan curve
 settings for devices that fall under the "Gaming Series" of Lenovo devices.
 It uses a notifier chain to inform other Lenovo WMI interface drivers of the
-current platform profile when it changes.
+current platform profile when it changes. The currently set profile can be
+determined by the user on the hardware by looking at the color of the power
+or profile LED, depending on the model.
 
 The following platform profiles are supported:
- - low-power
- - balanced
- - balanced-performance
- - performance
- - custom
+ - low-power, blue LED
+ - balanced, white LED
+ - performance, red LED
+ - extreme, purple LED
+ - custom, purple LED
 
-Balanced-Performance
+Extreme
 ~~~~~~~~~~~~~~~~~~~~
 Some newer Lenovo "Gaming Series" laptops have an "Extreme Mode" profile
-enabled in their BIOS. For these devices, the performance platform profile
-corresponds to the BIOS Extreme Mode, while the balanced-performance
-platform profile corresponds to the BIOS Performance mode. For legacy
-devices, the performance platform profile will correspond with the BIOS
-Performance mode.
-
-For some newer devices the "Extreme Mode" profile is incomplete in the BIOS
-and setting it will cause undefined behavior. A BIOS bug quirk table is
-provided to ensure these devices cannot set "Extreme Mode" from the driver.
+enabled in their BIOS. For a subset of these devices the "Extreme Mode"
+profile is incomplete in the BIOS and setting it will cause undefined
+behavior. A BIOS bug quirk table is provided to ensure these devices cannot
+set "Extreme Mode" from the driver.
 
 Custom Profile
 ~~~~~~~~~~~~~~
diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index 0eb7fe8222f4..faabbd4657bd 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -171,14 +171,10 @@ static int lwmi_gz_profile_get(struct device *dev,
 		*profile = PLATFORM_PROFILE_BALANCED;
 		break;
 	case LWMI_GZ_THERMAL_MODE_PERFORMANCE:
-		if (priv->extreme_supported) {
-			*profile = PLATFORM_PROFILE_BALANCED_PERFORMANCE;
-			break;
-		}
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		break;
 	case LWMI_GZ_THERMAL_MODE_EXTREME:
-		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		*profile = PLATFORM_PROFILE_EXTREME;
 		break;
 	case LWMI_GZ_THERMAL_MODE_CUSTOM:
 		*profile = PLATFORM_PROFILE_CUSTOM;
@@ -218,16 +214,12 @@ static int lwmi_gz_profile_set(struct device *dev,
 	case PLATFORM_PROFILE_BALANCED:
 		mode = LWMI_GZ_THERMAL_MODE_BALANCED;
 		break;
-	case PLATFORM_PROFILE_BALANCED_PERFORMANCE:
-		mode = LWMI_GZ_THERMAL_MODE_PERFORMANCE;
-		break;
 	case PLATFORM_PROFILE_PERFORMANCE:
-		if (priv->extreme_supported) {
-			mode = LWMI_GZ_THERMAL_MODE_EXTREME;
-			break;
-		}
 		mode = LWMI_GZ_THERMAL_MODE_PERFORMANCE;
 		break;
+	case PLATFORM_PROFILE_EXTREME:
+		mode = LWMI_GZ_THERMAL_MODE_EXTREME;
+		break;
 	case PLATFORM_PROFILE_CUSTOM:
 		mode = LWMI_GZ_THERMAL_MODE_CUSTOM;
 		break;
@@ -338,7 +330,7 @@ static int lwmi_gz_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 	priv->extreme_supported = lwmi_gz_extreme_supported(profile_support_ver);
 	if (priv->extreme_supported)
-		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+		set_bit(PLATFORM_PROFILE_EXTREME, choices);
 
 	return 0;
 }
-- 
2.51.1


