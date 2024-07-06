Return-Path: <linux-acpi+bounces-6784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A52B9291C4
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 10:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 941A5B22262
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919B9481BA;
	Sat,  6 Jul 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyxkTrk0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C8D4D9E3;
	Sat,  6 Jul 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720253495; cv=none; b=DVqIhpqHV1SJQ27FAAe7pEmMcG4Cx8R9MmNiWOql65mgZN7XtPVyM2Na0ebpzMSp/ePC10n6J4w9PUV+TnxOOIRZ5bRFac60gKKiqNr9tXeZrix4epZLVAdWTJQUwL957wD6o6X8yv2/S8CVPLBSE7mWyBNGKMjz0HkIbjgtD6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720253495; c=relaxed/simple;
	bh=pKa+Okrp8HFvyoegiNG5O/Qu4HS3i0dN0VCzZBOFmjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9hccSufxki9k2ETGRwpLgCBoU5etFNMSLQ0MqqoooMcxSeU1YR084i2wOI9N+b3ZUnTzx9g/scXqIkuhdxQkWE4UZGYf+O1tXCFJ4q7LPqdFgxQDjG3704gkI/Jt03UpxHholcTE4t2gYLpxGqvNDch7IIi+JYZzh77/p3n+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyxkTrk0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee90dc1dc1so20877501fa.3;
        Sat, 06 Jul 2024 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720253492; x=1720858292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsjQFQCvqoiusg5g0bghoFxdMmEPMQr/Y48nTfxH8Fs=;
        b=IyxkTrk0L4MTGvIBvQ9sH6a1g9xn9YGkyT0Cn43UpFUjXjUA3AcB3Xi5zU+Lq3cKPd
         2S0EY8WumOe5BClnGdGEaU81TePhC0hjf42z3oVZhSrGOzD5GSY79fpja+fJce4L+COv
         ZUS13n+Kfx2Fts83lAt/SUFcQZ2+N/JeH25fxWbUGN02ttzEhIOH46KCa1NuJEbYeJtP
         DVsspW1VmjA252MkL5Z6xARh/H2S61lLXyN3165oqadJ+JIs2njFdaJm3RpuR47zG92b
         lsXlS3IKjVwqk0O+Ml/aBKkcJCmx+dUwdcr6Nl7XeboKheMv3kxtuQvP2Nv8LQmaECss
         mXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720253492; x=1720858292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsjQFQCvqoiusg5g0bghoFxdMmEPMQr/Y48nTfxH8Fs=;
        b=TvVqmLYB1nOnnd3CjheTdPcRICKMR3WjqDMaFADmB8ZxAJMn0Olf9p1WJ7qrW2tXvu
         n37nJ7jj1rZM8VbFm3QKxsa4q8A3Lc5rgKmv9qR308KOQo4pgBGNbuAs2H9lPaiFGcwm
         PBz5mYMtC2lB8A447ymBD3Nr6Rafpzl5YbtxjdKqhYIaQjF0v/pZLNY53fGFnv1gmUq8
         YFeCmX/shhRisGm1q+KQeDVcoydho0O2mrUcQH3gtBO/SiMlJdE5u33CkbHFlj17kDLJ
         wM7N8yEgNdn0tEzrKgDYtkckwB6787Vtowfzkr3FFtpSTtPQXZxdnYDrqhnbzAmcCbD9
         KPoA==
X-Forwarded-Encrypted: i=1; AJvYcCVjBH0QIAr+PWR2vvAxTFEFAkF3o/EIPujodvYmQj1RFtFI1W5XCBMgRrmm2kmTyQLWQyK03oNod7Kj6yoUhQ975GS7z4b87ogiNtMN22q0zGu5gn/N/p7t733I4JxX4n4KByMBYvA63Q==
X-Gm-Message-State: AOJu0YxoTKFrwIxt1uqF9hW1aHuSnWJWmZ9diJ49uDbrAbzzA01taUkl
	c+p4WXV8pLVEgu403oPXSvajx72zrqAHaqbVTk/9KgrsNLLgR7D7y4w95IHA
X-Google-Smtp-Source: AGHT+IF/fAIXOMgJoLn+gsE/If7tDYT7q+fuwpkdYzhPW1+9vx+FlNTulT4Wh/2s5442+4geqhf43A==
X-Received: by 2002:a05:651c:19a0:b0:2ee:7b93:5209 with SMTP id 38308e7fff4ca-2ee8ee14ee0mr53242151fa.45.1720253491610;
        Sat, 06 Jul 2024 01:11:31 -0700 (PDT)
Received: from qamajeed.Home ([39.45.163.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678e5c2b08sm10235931f8f.71.2024.07.06.01.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:11:31 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH 4/4] Updating a deprecated use of strcpy in button.c file.
Date: Sat,  6 Jul 2024 13:11:04 +0500
Message-Id: <20240706081104.14493-4-qasim.majeed20@gmail.com>
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
 drivers/acpi/button.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index cc61020756be..fa5f079b30d1 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -547,20 +547,20 @@ static int acpi_button_add(struct acpi_device *device)
 	    !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
 		button->type = ACPI_BUTTON_TYPE_POWER;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
 		   !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
 		button->type = ACPI_BUTTON_TYPE_SLEEP;
 		handler = acpi_button_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
 	} else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
 		button->type = ACPI_BUTTON_TYPE_LID;
 		handler = acpi_lid_notify;
-		strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
+		strscpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
 		sprintf(class, "%s/%s",
 			ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
 		input->open = acpi_lid_input_open;
-- 
2.34.1


