Return-Path: <linux-acpi+bounces-7263-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A67946EB2
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CCA1C202F9
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Aug 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1624779D;
	Sun,  4 Aug 2024 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="disfXSyt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAE3F9F9;
	Sun,  4 Aug 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774868; cv=none; b=eDTnNqIJGcTQw4tBlnUNdw3hjn/+e0QRthGN3SaNV5TCjy58JS7uzG4YBO9m6LqqZkAqHNst1jXZkwwvSsnvskAfh0wzbvOMSMR7E0cQZhT5UXCN9iRpMTS1GMLAL/McnLqfLJ96KZ8OOm0NxMNcTXHWMcLebreBGuMzwxH2AUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774868; c=relaxed/simple;
	bh=W2ngqKSyCOG1mTG9P6WSgKZetYNN23C8r1Rh6nEx9zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L89BVU+yHaxQe3P1zAAEPFoYedGQ0W1j5RXp9t+gAIq/zJ5bdiB7bx1fkI5/axzAFEyljG+dnwCkVkMzpCZJuOjQLIby6SwvhCBfmwTq6t+DSC3oQgxO1ubmahX749ICkWJb5K069EuyGl0+xWqMUMm4PrU1sknssI8Z4gYm8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=disfXSyt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42816ca782dso64566345e9.2;
        Sun, 04 Aug 2024 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722774865; x=1723379665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7fZ7uG8Iwuauo+1YRuo4GmTVYFDs1MFOasO4TGiyX4=;
        b=disfXSytMY9WeQu+BRl4k28n76MWHTZ3iBuHNkvqNL/nAySV3cJcbBP5srUiyoB16h
         FigQt5fiAB26KLmwckGH65HTEoro9rHRyOL8nUrTtpUybi3AqyN3nNgtJpReQ+0w7XD7
         Kp59GfBSGTod4TvoVnUvQ78M5CmeiSxp9rmKsHSADf/v8v63ZF3EaJdSxNwTfaLWHQmV
         iU5VMS873fVWPIsK++TUlTjQxDwQRP9jV8GErlX5TZxWfEFmbLwyuh6AztEqf5BYQeOd
         FCAcx5oH4GgrEIkLVuHPABzz977j6fee0oaDUfXYn82vfi0O+3N4ASxAsYaNiKxkshB4
         O5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722774865; x=1723379665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7fZ7uG8Iwuauo+1YRuo4GmTVYFDs1MFOasO4TGiyX4=;
        b=NH4UW5Dn/DV4BlPXnURNI/XPOKZG1VG3BFCN1xJy/KxZgDq2L0QAw9PPX2reAHkm8O
         29ogsdpOELjm4TXr6cwJzdmwwnnoq3hh+E3R1N3LLOxt7RbNISH7MTKbYzHHXZ/cB3WT
         baIRh494QyX8R1diXCxRufXyUEt2kEo2Q3iIRalv/4GLdyuFbPRt6Z4/ra1mNXL7fko6
         XRYGNnqiDy/s1xseWpyjZJZrGZR6c9hlkKJD15RWngYxBLgBdduwZ86TSneeXTSS5Vsu
         GqtQqcWeZt9aIE1BHd5SqHoyNbC3fWwbKlswgCq9ddEPQ3+kFnh18Nl+xqXGsOFXv9no
         gyQA==
X-Forwarded-Encrypted: i=1; AJvYcCUZI8E8mcxU9WlRcPGtyh7kMjNtD7nCdFQEoV6omMS++v4WBopN8lfk8gG7MfMfb/evOoH1dc0USat0actFIESYzmT4ATk1Qie/YQC39ttGMpaA/fvETg46NShECjzIiv0Qnh8MTydkNQ==
X-Gm-Message-State: AOJu0Yx2I3kCwnBkFqPRT3vo+HBUDLum64pmMNAV55fGmIRQF5jxdDj8
	eIKp5rgbhwvuYWrl5qMmbfAQHtOhsANMAlK8I2zEOiM0aFYwcQtaRMnWgxKE
X-Google-Smtp-Source: AGHT+IFeHDGSA+QAyafS2TtVU1J/1Dkb2Gia83aSlBRyZ3jVJqe+9leIlLY+hrkaEuBU5R1qWCwRDQ==
X-Received: by 2002:a05:600c:3d14:b0:428:6f4:57ff with SMTP id 5b1f17b1804b1-428e6b93fc0mr47288355e9.35.1722774864927;
        Sun, 04 Aug 2024 05:34:24 -0700 (PDT)
Received: from qamajeed.Home ([39.45.131.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e88f833asm92848145e9.47.2024.08.04.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 05:34:24 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2 5/6] ACPI: button: Use strscpy instead of strcpy.
Date: Sun,  4 Aug 2024 17:33:12 +0500
Message-Id: <20240804123313.16211-5-qasim.majeed20@gmail.com>
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

Replace strcpy() with strscpy() in the ACPI button driver.

strcpy() has been deprecated because it is generally unsafe, so help to
eliminate it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88

Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
---
 drivers/acpi/button.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cc61020756be..9dda4a3998f8 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -521,7 +521,7 @@ static int acpi_button_add(struct acpi_device *device)
 	struct input_dev *input;
 	const char *hid = acpi_device_hid(device);
 	acpi_status status;
-	char *name, *class;
+	char *class;
 	int error = 0;
 
 	if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
@@ -540,27 +540,26 @@ static int acpi_button_add(struct acpi_device *device)
 		goto err_free_button;
 	}
 
-	name = acpi_device_name(device);
 	class = acpi_device_class(device);
 
 	if (!strcmp(hid, ACPI_BUTTON_HID_POWER) ||
 	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
+		strscpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME_POWER);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
 		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
+		strscpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME_SLEEP);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
 		handler = acpi_lid_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
+		strscpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 		input->open = acpi_lid_input_open;
@@ -579,7 +578,7 @@ static int acpi_button_add(struct acpi_device *device)
 
 	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
 
-	input->name = name;
+	input->name = acpi_device_name(device);
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
 	input->id.product = button->type;
@@ -636,7 +635,7 @@ static int acpi_button_add(struct acpi_device *device)
 	}
 
 	device_init_wakeup(&device->dev, true);
-	pr_info("%s [%s]\n", name, acpi_device_bid(device));
+	pr_info("%s [%s]\n", input->name, acpi_device_bid(device));
 	return 0;
 
 err_input_unregister:
-- 
2.34.1


