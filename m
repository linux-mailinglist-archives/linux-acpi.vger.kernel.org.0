Return-Path: <linux-acpi+bounces-7262-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1916B946EB0
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 14:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187AF1C20D42
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 12:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911B03D0D5;
	Sun,  4 Aug 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMi/xiVI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34033A29F;
	Sun,  4 Aug 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774866; cv=none; b=ffWyLGuyVHu1/1pJbzKqw+OvK7K8/iDkKaLra7wNxImeFS8uwlPwSl4uMsX4HHImSA+YgF+xUj1s8+/5zla5jciiTag/e+oSWcLqZ5A625fVh0o1rDd5AvfbEzyOCK6ZRFE6bVchPOayqO+LTGi52N2Kr0azjugWAE+ksknSYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774866; c=relaxed/simple;
	bh=4wTO45loOxiBgXMX1TvpFAFqq7lkEMFODS2enoTLO/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMAVFGKwFr1UKeM3iZLI5YxN3drj2MvnGf5MfuGnATPt1hgMxu2Yb7AzYF/Jqnz657Ssee92lsNgrxp9OcW/TMwXJA/WcvuxvXrkKTdjZtPLQpdoZOpvC/g2WSn50S+P35pNRBUQ7PTDY+7GGdg0t2lYeS1FcYY6I2em3aHOxYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMi/xiVI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso1560695e9.0;
        Sun, 04 Aug 2024 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722774863; x=1723379663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c74qx6U4WqhaZ6AZfBeapjqYbEWUeFmagdvk1F1/Pww=;
        b=BMi/xiVI3sNKYJtCTIFVXP4SJIj9sNHuRCVRelCXVGBTRqYpZY2fJnLc/2cClZGZfz
         gZmAwIOXaHTlMy+90KstHgVdcyjebH6uST1LjEBiCXfxeq9NkVqPkvW57HptH1+NB1K7
         /kiyQ7ul1I7GiqcllYDlkY3q3KJEpzJALe+DYtGIKYuDq6DfZ5E78iQpXUKOlT5YxvIZ
         DzSfw17KXoFuFRycVINyh9KL1OePVz8Xl0q23xbPJTq6rAhV1xvLqnhybEAoJCwqY3yH
         cy5BDg0jo9VXg/ckgb9OZXdwVtEwolSiG2LDtdwH9/BiYi1UernF8PY2uEKvUftabZMS
         LOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722774863; x=1723379663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c74qx6U4WqhaZ6AZfBeapjqYbEWUeFmagdvk1F1/Pww=;
        b=fSmb0jpXLeJUqu2TavO7nE8T7iBeuXYdyiF6y1Sg9Z4Eb4m3Wblc48znEEmpWACUIe
         EZJVKh75TpRkf4EawG6Vc/YZcjdjaTvDThVpdUdQ2CM4U1+TCOn1uVgbbWQ6x0hNqImB
         emFUAekUcAGWFxFzl91ALo3zGLB3TEth128DgyUOIRPv9VyGD3HsI3PGAqaMXO8txKQ9
         jPxzARU1IV8dMNAP5oGQUsXSiy1K7+pA0Rt+T7dPMvYyxZdLOxrCEpWtRQcBDdpKF5BR
         8iYwJf3dxSS1ZN3UNi5ho5YRsn+TbjmCXzpayOsujpK5/2SFk4oWCd1SPNTXHpWDbkgS
         5UWA==
X-Forwarded-Encrypted: i=1; AJvYcCWEX2hxuz/++B6gHR7RwL0vLN1UD5Bob7tilPpQWPtDTCrFJ6LljP1mxyeUCfj9JjSN6xjXHe/LVtC2z98+t7AYbiqxCTEU1VVlcmVdTWgb3NRSfIF0KgFnFyYYRDhEBVmRaVkTAcyjcw==
X-Gm-Message-State: AOJu0YxdiFBsfGaOmc1fe/GMaPUSeiu6zBIMFcClQJGikF+Jfqyd/jQ9
	59VXQ9K3oGxrzzSfoaFNYNZiwSMDWROGM/rJmVdpdnGTHD4VXgmJ
X-Google-Smtp-Source: AGHT+IHBW0cXyNQc0tmZKtrcJnCuEFTA7+Dz9GzYh3Xci1Otyby5VeLxyTuNwV0G1B1oKPCaqwUV3g==
X-Received: by 2002:a7b:c5c7:0:b0:427:ee01:ebf0 with SMTP id 5b1f17b1804b1-428e4714cfemr88500745e9.8.1722774862903;
        Sun, 04 Aug 2024 05:34:22 -0700 (PDT)
Received: from qamajeed.Home ([39.45.131.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e88f833asm92848145e9.47.2024.08.04.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 05:34:22 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2 4/6] ACPI: battery : Use strscpy instead of strcpy.
Date: Sun,  4 Aug 2024 17:33:11 +0500
Message-Id: <20240804123313.16211-4-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804123313.16211-1-qasim.majeed20@gmail.com>
References: <20240804123313.16211-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in the ACPI battery driver.
strcpy() has been deprecated because it is generally unsafe, so help to
eliminate it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b379401ff1c2..784f9234f1a4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1193,8 +1193,8 @@ static int acpi_battery_add(struct acpi_device *device)
 	if (!battery)
 		return -ENOMEM;
 	battery->device = device;
-	strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
-	strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
+	strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
+	strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
 	device->driver_data = battery;
 	mutex_init(&battery->lock);
 	mutex_init(&battery->sysfs_lock);
-- 
2.34.1


