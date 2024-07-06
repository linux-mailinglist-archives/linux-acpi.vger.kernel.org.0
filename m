Return-Path: <linux-acpi+bounces-6783-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4209291C2
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 10:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79A5B21645
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E84B4C3D0;
	Sat,  6 Jul 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRVxZ8SO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605547781;
	Sat,  6 Jul 2024 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253490; cv=none; b=XtExGoshBg/tLCmxe/9p75bcKvV/SoEmQUSNqFbYWwtji/T61fzqx4UWPN21ws4affUGWCnTW3Jtth7/C+/qmKlcXBFg/FukzgxOHjCYEUUQYV6UFUS+R+mbx3vfmQTAtl313OufXyjA2EioIg+EoxLsPsq404d/UTdyVsLL34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253490; c=relaxed/simple;
	bh=F4uqQFVbA9zLBmTHzvRWfP44WgnlCFjFtF4DjGBlRqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqz57E0ea6hhoZqJQdVUf75zCRKcIOWsB1mRC7Vr8njucMWzNqzvQ9teMGDTBgMgQ282CCdvw89U2tgOzOoQvsmmIAJM9f3m0ta5cyDtwSbhZYB/WmdByxD7/OnWhOWFMl9G1BCknxDfZz3NdhU0F9w7RSvK3hypyWRHB6XUffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRVxZ8SO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367a081d1cdso1265511f8f.1;
        Sat, 06 Jul 2024 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720253487; x=1720858287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3fxhsBTrwbycBuKl2A9RrsrM0JOo+6fyQb8KEc5vcA=;
        b=YRVxZ8SO+eDqgyDw5xg+TainZnOxw9ZqCIg0qT3o4wFWxUBDZf2abUp5HBUs7Cq2fP
         V21yAGiw0h7uUwBVbpt+JSfDGs6k4xUpvgIwmF5RxE0N/T4gjzuyYlE5xcdy9CnnpFMl
         BPQK5T2jeenu/a412GfOC4LC5sjkuknmHlyEoIOs2o649WQhFp9IdgB290u20bouZbkn
         9r2X5TEkHQuzHDLo1MMLtvLexIkkWxtbB37QWET5xM46dzc3BCVSfaedssOyIPpi3Dx0
         pzZ+PBSvNUbwBW/lsGTucd8ikJ5FTY9wEizR/KM5iv4EPoLAyBLYjBytrX7DIEpp8jiQ
         IB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720253487; x=1720858287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3fxhsBTrwbycBuKl2A9RrsrM0JOo+6fyQb8KEc5vcA=;
        b=CxftZK0IBriWNRN21SE7mIEVzdZTmBsRP3oQvj1Ky1flVlN2x1EVqT1R6LE3QeaIui
         h9J982wO+X8yFyz6DBVW+a5utoAQGQ4AVGK97yvW+dH9+5IUFXjJhNhEg3CwDbY6r3+W
         X08h9ilIM37sGf1W2idvSehH/wbzU8M5ePWESYggZX3IF7AFBEOamjmDdNGLdDzJr94o
         a5qprmvnozvXzYofVkuT4zMQ0CuWs7I+S3CCw/YDA30LBz8bE4V7dN+5r5YtLJUDPg/y
         VBDjrj/PD7xZtT1SYXYYcCznWnj11rsds7fKzjOGMGwUzaAecZ2Uz9UGVxUVi99oN6Cs
         vC7g==
X-Forwarded-Encrypted: i=1; AJvYcCVfnTQL+njHXmouJ1SgBmzwX1vVIlDqH26natw653wg7jJT+08JH35hPcV4liCKXnaFhhwYtE7vi+3ygkf9CKIKmP9uk2Q3Wy1rs3em5z1Nb0uSRwtbLzaT4GkRKw84Y3cDL37J5hz8KQ==
X-Gm-Message-State: AOJu0YxKNz3sETtMRxYUH6O/8V9YKN8+9HiT7BTKCllNa/t0I+JtPO84
	wWMnh1j75UJyWs1JzXzhamkNgjIHj/Qf/6UiZBWdLhrefFKqooEu
X-Google-Smtp-Source: AGHT+IGPBLGFlHwgc+1BoQ3mJVxMVgNvNrkMiJfuxzoNS5tvieo1k2ohto5NbOyIlZF2yqZgoLlQdA==
X-Received: by 2002:a5d:408c:0:b0:360:7c13:761e with SMTP id ffacd0b85a97d-3679dd71a3dmr5000077f8f.65.1720253486927;
        Sat, 06 Jul 2024 01:11:26 -0700 (PDT)
Received: from qamajeed.Home ([39.45.163.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678e5c2b08sm10235931f8f.71.2024.07.06.01.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:11:26 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 3/4] Updating a deprecated use of strcpy in battry.c file.
Date: Sat,  6 Jul 2024 13:11:03 +0500
Message-Id: <20240706081104.14493-3-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706081104.14493-1-qasim.majeed20@gmail.com>
References: <20240706081104.14493-1-qasim.majeed20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing strcpy with strscpy.
strcpy is a deprecated function.
It should be removed from the kernel source.

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


