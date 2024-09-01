Return-Path: <linux-acpi+bounces-8060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C913967BE5
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FA6281CBA
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706E05466B;
	Sun,  1 Sep 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/2CTViG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120752F71;
	Sun,  1 Sep 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725218317; cv=none; b=awVbwnDVANwDoelzu2CT3Lmw53lS0m8wJ+vfwBk0srRIoaslXbMSrpsWr15szm8W7kNoyNvrI3AXIC+c2/aVi9PVoej+oTo9FrU8j9svlum1Yw5ufyonwkBGmAYirIW/rNoRxfVjP+sNsm4ECsyFFKf5Tb1imb0G1jhkA49Ki/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725218317; c=relaxed/simple;
	bh=Y3TN2iBK+WtQDfuqHbW2JzK71f1KKkqWw2unD9tmWik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p/ME56ZfLad9k1ldN9bf14/T6B9cYieo5kBgb2TdHsSY4EuvP09r5vxl7AjDzniUbLmCnvJMIc4O6aMvbj2zXILXAZtLt9jqYRv5S9yxdBKOAUm4MYq/OMDKpuyDraT0xxFvue08ExC8vr9uwrEqPf+Zi3nxqePl7Xi8XJVBbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/2CTViG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c6187b6eso471621f8f.0;
        Sun, 01 Sep 2024 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725218314; x=1725823114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yviYY8iPqwQ8QbaVYbxIF5yWjm8BL9pKLScnubh7/zM=;
        b=Y/2CTViGyWd1xAL1t+N8uJ0MyVrb+mAlqdJVc6y1cHnVshCYYs6DrEZYUtyluEcePK
         P0iNHJANE0T+lpAnmGCvz/70Ii8wo8+EYoUNZMfDILbh3DBDwBW0PAfQWP4ON5XmjAty
         0f36RN8foBuQEhGabQBFqoT0zexV/NWxoJtwRjEMrRTSAG1jzfNVNsfPq1wx4vd6eQ1E
         XvSIMMC4Qlun4c3c9lucOleo49ycnEICWs4Db1K2mzuyLyvQkrfQAoicpN7FdCi2EhF1
         aoB1hN3btKi4YfRhsNtftxA6jd1lZ75rjEWak6ioieo8sSFJW76tNcVJcdPZ9TaI1Q/m
         aVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725218314; x=1725823114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yviYY8iPqwQ8QbaVYbxIF5yWjm8BL9pKLScnubh7/zM=;
        b=Z+mtRCmU2pW/yZWDvdgURkiBckxjSpDuMRRxODmnavqQtkSwDIHf9cKgwyqc3j/z6c
         uD5/yjmjPfH1efJ+IJXQLphRsatNmg2KRkjd0DTJnVfE3c6Q6lLjoctP50hs/neU9UcX
         hSi3LQ347je965dbyPvPqNdHvvGJykIz9XLzXToYQ46HxUyaILnumMgZ74ArdT/JvNNb
         /d7ZeisSmsBselIBH9PiZwUUyRX+/PZk0qZb4pAXKEsMg9l6Cly57EyS3G9nB7QIonAN
         nwscv5W90ZYVptghvtEhTmmRQeYyTz10D//VOJR1EOxxEsinYalq05M1vEBUcGL8MF5l
         M6mg==
X-Forwarded-Encrypted: i=1; AJvYcCU+1i+Fk59VcdNAO06EjLjZPR5Geigte45gwbF8dDDEMAMBYIU2M1kZAp1r4qB7VSjj+7nN2oIDIsBcgnF+@vger.kernel.org, AJvYcCWFydESkGOgaKklcHQJVQsA5ViEaCNc5r+OPqp5yq75YM8+/H3m9prSW7onrTN9xC6igFIqjx6zUqYC@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWnc0mo7xH5NJFjJCPQ8TT04G5H73y0JH87VfWDS22rryIwux
	JvTWEnkW9SYMHzS1i2wf8UcaGs+/RvOq0U8PVbT7DxrLS2znYx2X
X-Google-Smtp-Source: AGHT+IHzAuq6OtiaAsa+R0vPx7jD/3WnrN+UZ1+9P7P232hbJ9Xxyj78IjVL6zW7oLPNiRblh1L7Qw==
X-Received: by 2002:a05:6000:bd0:b0:374:c606:df0a with SMTP id ffacd0b85a97d-374c606dfc7mr1462286f8f.36.1725218313693;
        Sun, 01 Sep 2024 12:18:33 -0700 (PDT)
Received: from qamajeed.Home ([39.45.200.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c15705easm4161458f8f.33.2024.09.01.12.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 12:18:33 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH] ACPI: button: Use strscpy instead of strcpy.
Date: Mon,  2 Sep 2024 00:18:26 +0500
Message-Id: <20240901191826.421488-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
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
<This is more than advertised in the changelog>
The patch has been updated.
---
 drivers/acpi/button.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cc61020756be..51470208e6da 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -547,20 +547,20 @@ static int acpi_button_add(struct acpi_device *device)
 	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_POWER, MAX_ACPI_DEVICE_NAME_LEN);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
 		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP, MAX_ACPI_DEVICE_NAME_LEN);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
 		handler = acpi_lid_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_LID, MAX_ACPI_DEVICE_NAME_LEN);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 		input->open = acpi_lid_input_open;
-- 
2.34.1


