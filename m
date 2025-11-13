Return-Path: <linux-acpi+bounces-18881-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4231C5A20F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 22:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBCC64E8148
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 21:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16828324B19;
	Thu, 13 Nov 2025 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm/zOQpQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE543246E7
	for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069207; cv=none; b=myzLEU413gfiN4zMTtei7I+QFJYjwXoXXm0ONFNy9dSS+6fVcWJrLZ0u42t/m4xGQBzhcw0CyUJ6/NO0AUFaTs8R633pIi8zmdx2bVyxS+9X1nriDMeoloGIrx5Dhmb4idXIk2Oq1gaRpVg1zSYhSrcCuyty+PxrfQ0N7Qggrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069207; c=relaxed/simple;
	bh=bINqTcYBnpMiA8eKDMIKE2dhokiXwzdMKmoocGJBxvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IoN4X2dHDH0Zl5uVJiJq6j+WMjyzq5S6G93l/nY9gCiSn5/s2NPcJPjHa7WDC1dlgT34UD0HB7+zP5YbaXgmiTE2dLqA0SAq+o0FFTQEMAf9WBV+OEp8cpiDuZlIn2xVurslck+Qs92sPLebLzAeBFD5QhKOJi/ctDr/6sm6MD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm/zOQpQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7af603c06easo1491261b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 13 Nov 2025 13:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763069204; x=1763674004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETZ2FAyy2v+yzymxyjsZFHVgNltj1Cngjn3GryQ+ajM=;
        b=Tm/zOQpQlcIUrmG0+jB8yc4M8iTsTuc8qRK1RnyS+fcLs4P+5RVKq7laD5rI14Xdq6
         MkGNF5nD+bsi4tDZM6qzotwBAqcJvuompcQG6GzAn75Izac3+mpkBvPpgGRKsAyK6FVh
         JpA4hPrr+ihhxD+elLGZRa3qmPS71kV+rZqRPU/I8u28UG+V+nm1RpWPG6YEDxLt85hB
         yZd4XCmh99WIxQSufm1HQ5E7kE3pNlMftiRTq1cY/c1UQWKBz00LsjP/VUzG8AEPszOZ
         WL6dxvIJrD2d2TmmoPfs9TN/kW5nfPK7EYXZcuqbr0VdS01aPtMNfLgLEla2lez2XJ5s
         qNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763069204; x=1763674004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ETZ2FAyy2v+yzymxyjsZFHVgNltj1Cngjn3GryQ+ajM=;
        b=Sywr+Fw2ckPGyy1v5JxacL1Qb3C0oxlBukky3LyqH5flEDKRS1IDYq94gRTQ1V79ls
         Uy4b1vL7f/nxLDh6nkUCtDqLZZXrgtfWEfFP+1Ms+smvMkM2zPjLvQMtB/EXKtZAHC5G
         w3mKu++k6kR2Sh2dO2d8wJ9XCCN0kBE3t7JfxcEUnh7Bzuu14N6JID6GlwqiyzYGSDjJ
         yTuttrg6eF84Oas3Yptbniet0r5m7FX/OJDxmYU0MSyDJqYWXdSwPNXzA1DFXJ0rskpm
         tbQyzIq9S5i5xeNf7hlRQeAN/sTJCS1PL6vZ1I1h+rGEl5KOHmbqNPqAAI9YfZPulRHH
         ebLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7e3nfy4Fh+ewaeJqJSHTbBSEWP6rsgXTsJ5VFgDRH6piqlHFkFy0Vfg3E3SMoSPbgAus8e7ssrFQ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5MLc2aF0jgpFM9j6/ZJkKwL9MX2x3Xrw3oXKO9bTLLpaMerFP
	Wm/PNGOpVrSfRd1Ky1mgcULq1+nPmiJ/AhANrJDgNfpFQIU3dA4BXa8k
X-Gm-Gg: ASbGncvQS2AEWMDkQZtxVRZgeUll7lL69KeT9khQL4TcY9nqKXZ6EzJQoxrFIG0BiVA
	YwCYGpiF+pG1+sWnmjACPGU4ejikf0kRRuGdu7I0zTq7T+nbInyAj23O3aojiEBxjZEyOGfoNGz
	OxaqqkVw0X0yz8N53wgBNFRkgtA39b7viYiBFRL1fusC3T4EwXmfM5WJWcQ6JUb6Am9GXvWOz5/
	RgrBYndZHKlgKI/Wm8RXqFpTHostW6d1i47Q6YyMy+x2iJ3z2fE09qwfNB3YtLm/5xLlVvJufy9
	RIs/kmFGCLW4aU+701ShnZTGCRzp06WDqqrf43+tpzdItKjfj/d0lzLjZt3br/xG2QnWaBG6AsT
	jWjAjH9ixBn30A5IWCEaD5BfvO1eafksGbQoj+iUXTpuDnpXxw3IBMvvSPHexzhisNe6n6sDfFd
	oFOl/0ehYSPOYHUSTijcugSHf2Om2p9WE75BZ1W1y+Hfrm7zbjxBCC9UU7
X-Google-Smtp-Source: AGHT+IGlGHa64m4FUlNTDBrkTzOJTPv1hG5OJIfDH4dSktE6GCpD7ccEQGk4etzbj8JDAyYp5jdCUQ==
X-Received: by 2002:a05:7022:925:b0:119:e569:f866 with SMTP id a92af1059eb24-11b40e8ad2dmr366548c88.3.1763069204472;
        Thu, 13 Nov 2025 13:26:44 -0800 (PST)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm1811414c88.1.2025.11.13.13.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 13:26:44 -0800 (PST)
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
Subject: [PATCH v3 2/3] platform/x86: lenovo-wmi-gamezone Use max-power rather than balanced-performance
Date: Thu, 13 Nov 2025 13:26:16 -0800
Message-ID: <20251113212639.459896-3-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251113212639.459896-1-derekjohn.clark@gmail.com>
References: <20251113212639.459896-1-derekjohn.clark@gmail.com>
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


