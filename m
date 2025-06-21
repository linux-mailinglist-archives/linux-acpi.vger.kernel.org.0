Return-Path: <linux-acpi+bounces-14492-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D2AE278E
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 07:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6EEE4A07BE
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Jun 2025 05:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B301C19F49E;
	Sat, 21 Jun 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G38nV9c8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202818B47C;
	Sat, 21 Jun 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750485128; cv=none; b=iIxQYqGKGwqeDt9/uOloBtanaudkdE82WxxyGnKL2f+eEnkfMsDnqH1h0qLnYqp2UnkFzapjgRBJGAnxjPWWpnq0004gLR2MlSY9laNlk2GksLzErGNpLwmoyOYIMX1FyNBMiLLU/mmsarVU1YccU+CCrCSO3SVrjHV2Q+exzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750485128; c=relaxed/simple;
	bh=I2qfDeaK/yT5SBxGqMaxj0vINrFUNTL30vXC81G8BN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rtyuOtv2vrpN+Gr/GScQqFG8jwBKFMIYFjt+FDznUuZt+LkgYU+mg6o2u4m8WyqxhmqimrGhhCtwGhMPDfPYXeQzxXaO47eytF/eQ/5pNXL16F3bY++RubdTL8m7fmGamHlpT1u+2HDiaU76WRZN82CaNrPRXsVRqLrN83wA1BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G38nV9c8; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4533fbbd21bso1237325e9.2;
        Fri, 20 Jun 2025 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750485125; x=1751089925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQpUEjf0YxYX6Ci4pItp/DxE3akefzENzegjXg1pXvE=;
        b=G38nV9c8u5CkpiZyU99Zqfgb7VbRBVX4PV0Y7sZAfvozMzifxVMF2cm3p7Nw0TVc4I
         j4COGTefAZBm/YikEtZ4gfoO1WeNFzT+m78Zyb6vuW0YHdyV24UGOairikzy/0l0n9jh
         C2y6SWBdKyM1M+CPMeEfcrBpUqbSiUyJaaaEwfxwscWOhxqR6BE5iUAo0xFACQRWrgR4
         FJ0DA6nQoaYO1SRfD6TGpJOya70uDrUtJnFOMlhV/PI2KzkRF5CRFPzWCK93DEDDbIIW
         QtRSrN4FYbPGlUmfq+19pi4cYoi5u0hIhQZjjj6gbIYO5zJDalZ4DJbochBQHQOd0myu
         V/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750485125; x=1751089925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQpUEjf0YxYX6Ci4pItp/DxE3akefzENzegjXg1pXvE=;
        b=OqlK2q8E0TbkFlNogYctHCr/B+stiIr3lqIMo04YtEY8d4897nrOD9nghVxYR/Cywd
         sVa63qS9Zy5UY2y7QtDBFPetYFo0rQnKbyg/+4J3okbuM346so0tpLCzXnvaNWGZgUcV
         K56w9/zPPBiz65vQvCS8JN/I7cKF17t74y6jYHzZPRTTSWRwf82Hs8nEAqwJXHHG4ynv
         skbksaqtp5tCZYIizQq49JiqqzDtES7mwLij0fFMYiL56h3LMm9WYiob3M1CJcX8eP8h
         cJvuC9cJEu1Swr3izrEp3DYLpK7e+hzIzYD5BNOcpaIC7wmRfSrK74DnXIv0uj9hjC5Z
         B0fA==
X-Forwarded-Encrypted: i=1; AJvYcCWBUtza94n1Hvp6CdCRDekSmeIeN/kzPehGzk/n63+uOvgpki1k2zxm1iyrCZL2ul6OSbaLVecYemFu@vger.kernel.org, AJvYcCWv3hfE457+LaikYWLllRXTvCTnrqx3caTWIevJuawqA8ou9XgrzuP9x+eFKF0kB0TLARGwFwvNX7jY5LYH@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzMUm+9wLsOO6syG76UYwEuv9ogy9u6MuVEj+XnSKZeM92U8G
	TiTjLNdBIae1rr41S4ylAXiI9eOEQZoqxfwgIZMlQODxgPVjVz5tIgU8
X-Gm-Gg: ASbGncsWVdwnq+LkiyDIzSdLFaqd6Ua4aPUrc/yN3KnRFKq610GnRP3vysQWQUv1A2Y
	OKEBrv5zOzamgqoQPx0RXYHXUdzZSf57CrtV2uMElAkXQLg64O3G1IKXQJyNm2F0IhYeliSRaXq
	ynpcWiJvexFr5oKAJ3l9cdx7wU6mBtrOJixgpH+RIRX/2tc9OA2uorsD2zS+d6/FkePFIXEAWlY
	Q5mVbBuGKFIl6kn+dzaHOeL9zs283+fUQZDRD5io0UcNxuwo0Q7p4tbvk32CANLu+RnbWIMIufD
	pf1Q1Gu4fSRTFX9VpdijHxJVpvmC4HnORVX2Bwmv/ho4utZFCBD5Qq3zwWEp94GhkO5G0RHwBRY
	TQKgJvmdNMf8Mt8pD/tm2c0/ny557tTJgWA==
X-Google-Smtp-Source: AGHT+IGpx8LAUbfT+/oAv5emrbinMdbFFJI0Ah20iXYdZhFuPKxIxIt+hSS5OM2azlVyMH9Ov14N1A==
X-Received: by 2002:a05:600c:5494:b0:453:590b:d392 with SMTP id 5b1f17b1804b1-453657bf79cmr18822625e9.2.1750485124972;
        Fri, 20 Jun 2025 22:52:04 -0700 (PDT)
Received: from localhost.localdomain ([102.46.244.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d1190d13sm3785172f8f.90.2025.06.20.22.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 22:52:04 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: skhan@linuxfoundation.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH] ACPI: fan: Replace sprintf/scnprintf with sysfs_emit in show functions
Date: Sat, 21 Jun 2025 08:52:00 +0300
Message-Id: <20250621055200.166361-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update two sysfs show() functions in the ACPI fan driver to use sysfs_emit()
and sysfs_emit_at() instead of sprintf() and scnprintf().

- show_fan_speed(): replaced sprintf() with sysfs_emit().
- show_state(): replaced scnprintf() with sysfs_emit() for the first write,
  and retained sysfs_emit_at() for incremental writes.

This change is in accordance with Documentation/filesystems/sysfs.rst,
which recommends using sysfs_emit/sysfs_emit_at in all sysfs show()
callbacks for buffer safety, clarity, and consistency.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
 drivers/acpi/fan_attr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index 22d29ac2447c..6a53da3d6d82 100644
--- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -22,9 +22,9 @@ static ssize_t show_state(struct device *dev, struct device_attribute *attr, cha
 	int count;
 
 	if (fps->control == 0xFFFFFFFF || fps->control > 100)
-		count = scnprintf(buf, PAGE_SIZE, "not-defined:");
+		count = sysfs_emit(buf, "not-defined:");
 	else
-		count = scnprintf(buf, PAGE_SIZE, "%lld:", fps->control);
+		count = sysfs_emit(buf, "%lld:", fps->control);
 
 	if (fps->trip_point == 0xFFFFFFFF || fps->trip_point > 9)
 		count += sysfs_emit_at(buf, count, "not-defined:");
@@ -59,7 +59,7 @@ static ssize_t show_fan_speed(struct device *dev, struct device_attribute *attr,
 	if (status)
 		return status;
 
-	return sprintf(buf, "%lld\n", fst.speed);
+	return sysfs_emit(buf, "%lld\n", fst.speed);
 }
 
 static ssize_t show_fine_grain_control(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.25.1


