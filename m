Return-Path: <linux-acpi+bounces-10996-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4530A30306
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 06:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB950188B691
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6885A1DE3CA;
	Tue, 11 Feb 2025 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apobd/wV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6A2F5E;
	Tue, 11 Feb 2025 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252795; cv=none; b=RUHdG8jRzUlWqMxZlib9RkhwRZiMJdP3RgjG5xUgL/M9ePJKPwWj0+0f1WWmEw9YufohOWAQvfk5+Smzijztv+TsOTLnPe8u7W25SQFpGQjd+KmEl3nNb1OHOBKynD7H91oZx1M2D6JUKoI0HZJAFmKPq31NoFr/s5vWkUAADXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252795; c=relaxed/simple;
	bh=aDVCUTPGW3J74vVSYJ1HTC+bsu+y9lCjR3mOgNaEKcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o0hCiu4zRaP/6smrGZzSNTNb0W3r/SLKy+JLzB2LFyhLBiHMx199NpdtrzqinxysI1iY4GviYGRu0F7Z15FkkxMOLsFYx6nlx2apCSQJguoZrXSrAeUhAUE6rSC5HZdcWLsP8GMnCONxA5NqCJV2YxQe4Rq56xHBJwG5jOW789M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apobd/wV; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-867129fdb0aso2117249241.1;
        Mon, 10 Feb 2025 21:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739252792; x=1739857592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RNElTNu6sqcvjdUtzkTAHmhDqJhBhVf7/OzwWAdWVmU=;
        b=Apobd/wVFxWa7wktShV3RlMn4r70T93VF6pygpYbDcl4DaROnZgLZXZs7x7yL5juWg
         VL7eXQ7DEWY5ETbgDEm3mv5aMEEoGpLC/Ma3/syHkIsFrhKiULJAQ0hRhd/AyC/6Pe31
         JRTcztHTZ1d0FcUSVMPP4sVvft6ugY5xs4B5QgbdHGLAHUdIAVNrqE2UotgNzbRu4PoF
         XfWjQRiy33GzB6FGSC7Pwr31+Y0j30x9T1RJ8i8HHu3tjL85ayJjcLMW2SgT2z0EZ1YV
         5lp7WDNYkTHhv5EpnsczGU7Whek+XpCKl+komB/i9v5ekx70xLhOmfqqUy1Xz0CGUTCk
         18bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739252792; x=1739857592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNElTNu6sqcvjdUtzkTAHmhDqJhBhVf7/OzwWAdWVmU=;
        b=w9QALAtInQ4UJL539OFu5Oa5YZJ+92w/dry3Lj5iEcAvEN9sugJfU8WaMhL2KSHtuU
         X/R3l33ljfJfMVzXrR4Hzlk7OCeNKsjk3u+xO4KKsniT+R2j8GVObIgD0ST0DXWt4Un/
         Qdp+fxD8/4xe9vsm2zz5GKZKyp0//zU61I0wU6iz76vqPaxyhVZ0YgCl3EdOqIWTKjZ3
         3MvqzoRi6pbjJrb5LvQwgr4v2B5nBmiFuTBGGHzdFSK2lBXdTlbRuUnfbXTzEl7xlkv9
         hgWCXjdNxNg0yXzJXjSzASzrbiILnaxd2IiF7KXEaQcm+UPpcGdUeA4pDhKXOCgoWSNR
         X/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4fKm8L8Lz2aHI7yDf/03KopC2XrKTmssmUHtCPv0hQu0P0tHAnBFJRDIaJhc6iyLE9X9KhrBWkQWCZ4F1@vger.kernel.org, AJvYcCVQuo6or94icAQJcWXw41/l0PLMiom3JFfkwP63BSt2pe4WJwdpwNQ68klHmXplzHZjUF+8cGdsRTAsFRAUPd7+iJ5o7w==@vger.kernel.org, AJvYcCXHYGkBuyp5X+ol2C6Aj5vlPSdLluC9xyJSH1Z1i4Ihkxhr+fEcoVbGN290fkkcJePtcLj424bhJ8+a@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXL1QPnbkNSEcZXHG1SGefNulwye4KG/93FuAOr7m8zlUqjYx
	FT0jD4i7zGsVXrdEgRhIWMYwe/E02Kr/HYBGDewqMpr2n23QCpzx
X-Gm-Gg: ASbGncsbINTjP+PF4F3MnfGKzxql+7SGUUbyZeLVDlJH4xFULCf1WXtXNonwK91i6sp
	QW3+J4wKNybPxWFn0vOgbuOtuVFjAr8Zn8Q1afZ1nHXVp9y3L8bzCm9XirGoonsf+KbrsUe8mKv
	9aRHblQffyz79U1kJ1n8BJShI2BZfiYV7Z7pc7zsKsrq4mNsD+50TAoToVoMtRnTh4izzbb/khr
	pSLKmFhVO5WzJijJXIpwpE4xA9uYmAEDBP5ndOV/iBEfKSyjOuf1SJniHq4VynQnZkOIkK1pIFi
	So+iMttAE7QaonJvOFgqK5M=
X-Google-Smtp-Source: AGHT+IGpCycxeHiwIkdQyJmFgzjzfjrOWUvHTwR+SUeC0c35B+tfnHuLh92U7uKVsTqUzGtr4bgN1w==
X-Received: by 2002:a05:6102:205c:b0:4ba:99b5:60f5 with SMTP id ada2fe7eead31-4ba99b567d4mr5620870137.23.1739252792542;
        Mon, 10 Feb 2025 21:46:32 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:4207:a956:ebad:2a64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866f96809besm1717371241.13.2025.02.10.21.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 21:46:31 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	platform-driver-x86@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH] ACPI: platform_profile: Improve platform_profile_unregister
Date: Tue, 11 Feb 2025 00:46:13 -0500
Message-ID: <20250211054613.15609-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers usually call this method on error/exit paths and do not check
for it's return value, which is always 0 anyway, so make it void. This
is safe to do as currently all drivers use
devm_platform_profile_register().

While at it improve the style and make the function safer by checking
for IS_ERR_OR_NULL before dereferencing the device pointer.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Hi Rafael,

Please tell me if you prefer different commits for this. Also, should we
WARN_ON(IS_ERR_OR_NULL(dev))?

Based on the acpi branch of the linux-pm tree.

~ Kurt
---
 drivers/acpi/platform_profile.c  | 15 ++++++---------
 include/linux/platform_profile.h |  2 +-
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fc92e43d0fe9..59d82386a073 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -569,24 +569,21 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
 /**
  * platform_profile_remove - Unregisters a platform profile class device
  * @dev: Class device
- *
- * Return: 0
  */
-int platform_profile_remove(struct device *dev)
+void platform_profile_remove(struct device *dev)
 {
 	struct platform_profile_handler *pprof = to_pprof_handler(dev);
-	int id;
+
+	if (IS_ERR_OR_NULL(dev))
+		return;
+
 	guard(mutex)(&profile_lock);
 
-	id = pprof->minor;
+	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);
-	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-
 	sysfs_update_group(acpi_kobj, &platform_profile_group);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
 
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 8ab5b0e8eb2c..d5499eca9e1d 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -47,7 +47,7 @@ struct platform_profile_ops {
 struct device *platform_profile_register(struct device *dev, const char *name,
 					 void *drvdata,
 					 const struct platform_profile_ops *ops);
-int platform_profile_remove(struct device *dev);
+void platform_profile_remove(struct device *dev);
 struct device *devm_platform_profile_register(struct device *dev, const char *name,
 					      void *drvdata,
 					      const struct platform_profile_ops *ops);

base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
-- 
2.48.1


