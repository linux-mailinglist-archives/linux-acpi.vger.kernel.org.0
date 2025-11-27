Return-Path: <linux-acpi+bounces-19328-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE8C8F3C5
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 16:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3577F4EABB5
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Nov 2025 15:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73633509A;
	Thu, 27 Nov 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRaokIn7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48C335571
	for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256578; cv=none; b=GL+3ZEm4EmhoEWUkaJqC/Dawxaq0/kI3DDz44pGz8efkKPgG/6xsUQRFtNTmEHiUrhicsjR1xhyVaEZnNtmWs2TdhWaW6zY6ZbiJ7V48ZUfP6ieJ+sDpsrO/Pd6qYQlwm4SzAoIO/3Aq+WYNrdm3wbMuWJa6cEJnKI4x9Qh/7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256578; c=relaxed/simple;
	bh=bINqTcYBnpMiA8eKDMIKE2dhokiXwzdMKmoocGJBxvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2SyKCpY91Q1RQ7s69KoyKFpZ0QjJGb9KO+8e3fXfoPTF7aF9laNPawMKlVIsfFFNLdEodsChydCEmXHYX7RzUd0/L8eXPXj2Rke2qijuL2vlS/Oeg/lSqkAkjpqcm1yfXpRvRLVR5BhHv5FPc7T4n9Wx7yF1vpyXCDKaK+iRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRaokIn7; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11beb0a7bd6so2224653c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 27 Nov 2025 07:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764256574; x=1764861374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETZ2FAyy2v+yzymxyjsZFHVgNltj1Cngjn3GryQ+ajM=;
        b=NRaokIn7ngDIF/Wq3uU5gX7ZGkhdP4fKPoY5KUPMrGq2ekYvdAipM4EkKy2GGJXoOc
         ENH0l4UIxN+JW2h9EKY2KA97FbaTslYFtyxT54c0oRua8lTNbkhfyap0IFMwGchgQq5Q
         7nniLWnbSUGvpWIPs12LGsxPjcbFn2XhR2/KSmBjBHDlZi34SDGdENunj+7oGUtvngi6
         aLsIm6/yQ2MxM9hF1TgQMYw6Ye/lrwRvMnN0m51nhJsO0Lodr9BY5mzyAyhfxoGIShqn
         f6pDQdBZzkU19Pd95cODQL/9COtoLbyOzqayujt3qfo/otTij1lJVwm0zxhsyXVYwSn2
         QLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256574; x=1764861374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETZ2FAyy2v+yzymxyjsZFHVgNltj1Cngjn3GryQ+ajM=;
        b=gX8ujfwx++JtJ+DHRPVQ3rwkA8PUpebWb5ciJf60serX+GxgS4Cy1EGMwfjc1VIsuJ
         3fUTsPHHDF9TIsP8D9f7TJBhsbT/SZUfzDT2HU21xm0oKmS/TIGZB5W9bn/ZIRbkMbrk
         lCej0cTn0nMo6QvfslK3bvRMnq1RLGkqbxgv8TwkLq2EPn1MtXcBjegxkO6lwrAXZio/
         Hlkw2jFQFtNKpgvc2dOuehGyapUk8IGK4toP1P/qpReki7RJUAttYjcRceBi+kDju9vJ
         NkFwAvRE4NwbnzC498FYp9/5wLhn5EUtgTNepQzLtaNcL7iE/15HuAli3wcxWpwCXDJb
         nrwA==
X-Forwarded-Encrypted: i=1; AJvYcCUKBAdRI5CdKop2Ga8BnhJQnHFttG5Z/gwqW9mLNix3OdFQ1txHkHPiv1NBdLXD7JwDkFAuj/FBzxHC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi0NJy/C3w034u+CPVA1ajpiOfrSdlfEDkcioz6q+oxt3I16V5
	cvcYVxXJv9thJPugIyZVClXyT87GE7vVcp3+ExBuhFsZpeF/B/CwBt2i
X-Gm-Gg: ASbGncsP4gIb0CFdEi3YXpJEIAV31SUt4xmYvRURcmTQNC3p0syHd0kQoSxffmwFGX8
	iaL8vkZBJfjX3DpnNJS5TjCCsd/awqyxYbJmyuJTokT7MlSQX/GivOAQ8QTw0spbXdkmkHJi1MB
	O2fiJ23Hx2i5pQvLoJX+AvuR2CprfIs3MbMMeqhq1dTREysAIDuXpnsXNcso1zs5pzzVr94KaY+
	L0QNw69jWojZ0G/rTc99CwZOg9Pm1+rqu0w/aiohTFLUxsukFi+kBhJwvhHjpiilzUQtkzi8gNE
	R5/qrECNzft2it33ZppxHTRczEhKyc56pg0WKMLGadQBANRRZjDBq/OPHjcUsmmswgwu8fG8Hw5
	UC3ZFyP0xv0Kcc6McvcT/2cGbIvelOBAHGiAIFPrd+2jbPiFD2PhQzg1i02bK7UBbdEFmUv6gyO
	CQRUPgcCpTAiUr6rpVCInnGXgSWR2aKJpZNOnlZSP7PLDCmGgkjbj+BtgEb54qRhFTqQkzbVIg6
	Gropw==
X-Google-Smtp-Source: AGHT+IGlpWqE7oPwKq75vqcftF4x8/6mDQeigZg3ZJsYLEPNDxvoQXhlWwCU0z4N+O8Cg3rUkKIDyg==
X-Received: by 2002:a05:7022:ba1:b0:11b:9386:a38e with SMTP id a92af1059eb24-11c94b908a4mr18238628c88.21.1764256573509;
        Thu, 27 Nov 2025 07:16:13 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb067088sm5099656c88.10.2025.11.27.07.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:16:13 -0800 (PST)
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
Subject: [PATCH v4 2/3] platform/x86: lenovo-wmi-gamezone Use max-power rather than balanced-performance
Date: Thu, 27 Nov 2025 07:16:04 -0800
Message-ID: <20251127151605.1018026-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
References: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When developing the gamezone WMI drivers, "extreme mode" was matched to
the performance platform profile and "performance" was matched to the
balanced-performance platform profile, but only if extreme mode was
fully supported; otherwise performance was matched to the "performance"
platform profile. This has led to quite a bit of confusion with users
not understanding why the LED color indicating the platform profile
doesn't match their expectations.

To solve this, replace the confusing convention by using the new
max-power profile to represent "extreme mode". While add it, update the
documentation to reflect the expected LED colors in each operating mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

driver
---
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 31 +++++++++----------
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 18 +++--------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
index 997263e51a7d..1769ad3d57b9 100644
--- a/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
+++ b/Documentation/wmi/devices/lenovo-wmi-gamezone.rst
@@ -19,27 +19,26 @@ WMI GUID ``887B54E3-DDDC-4B2C-8B88-68A26A8835D0``
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
+ - max-power, purple LED
+ - custom, purple LED
 
-Balanced-Performance
+Extreme Mode
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
+enabled in their BIOS. When available, this mode will be represented by the
+max-power platform profile.
+
+For a subset of these devices the "Extreme Mode" profile is incomplete in
+the BIOS and setting it will cause undefined behavior. A BIOS bug quirk table
+is provided to ensure these devices cannot set "Extreme Mode" from the driver.
 
 Custom Profile
 ~~~~~~~~~~~~~~
diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index 0eb7fe8222f4..df475e52f79d 100644
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
+		*profile = PLATFORM_PROFILE_MAX_POWER;
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
+	case PLATFORM_PROFILE_MAX_POWER:
+		mode = LWMI_GZ_THERMAL_MODE_EXTREME;
+		break;
 	case PLATFORM_PROFILE_CUSTOM:
 		mode = LWMI_GZ_THERMAL_MODE_CUSTOM;
 		break;
@@ -338,7 +330,7 @@ static int lwmi_gz_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 	priv->extreme_supported = lwmi_gz_extreme_supported(profile_support_ver);
 	if (priv->extreme_supported)
-		set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, choices);
+		set_bit(PLATFORM_PROFILE_MAX_POWER, choices);
 
 	return 0;
 }
-- 
2.51.2


