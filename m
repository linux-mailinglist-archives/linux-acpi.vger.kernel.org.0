Return-Path: <linux-acpi+bounces-6785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEDE929276
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 12:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B35B20CAD
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 10:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2514D8A3;
	Sat,  6 Jul 2024 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eev6C2YU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F547A95B;
	Sat,  6 Jul 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720261036; cv=none; b=RweUqY28l3LxfQ/Fnh0RQoyrhzPwTQFbLIjCNSvUla3C9iLWFo1PVAggoSioSFRrpA1Ce0/AvKS2T6/G0JJX+JOrbKuWy6/7p5ZrQslJPpr2/0orIwB0ce3pFYRAqxEYbMYkMAS7sdOAy6NCEcEKMqaoNcYxpZuSQAHLxfuD4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720261036; c=relaxed/simple;
	bh=Cx3CoKjkKOWMggfaobu1ojgkAKtB3hoHKESSquVw6C8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DWvSkkbk3BlLYri33W5VHGAOk7YODkrHrrmGpH0h+RFb07XNBDhzxDpwBsBmbKExbwkzEMo5oJFgXlQwennRZ1HO+Gdrh6cJoZzMFZQOqU9F55Nh0yz26xEzFrE83q/75Qn34RaNYBR5WEP6fNztNOdke5C5xNRpe6S5mO+2WfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eev6C2YU; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso23622431fa.0;
        Sat, 06 Jul 2024 03:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720261033; x=1720865833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mtf5cQJcG2OUNA2j4NwJD3wssJxEz1X2PUn8pPQqvI=;
        b=Eev6C2YUvljlbtp/FFy01LxwWcpUjm2Ut7lGk+ESjsHmYc8qS1V4hiI9hGaMSsNwyt
         uksY3Gl+/IGLRS51OGI6WRjbZnt/+AKzc3mx3g1xxUOK32IDRUVC1dNGAxDfpGr/4+yU
         ArZ9+Y1bco8YMGAjJ9BtozPAo/3kf8UeAiwQ6zQz8C/WR4VL5dI9lihRf5DBOnHSWLbH
         TMgKpVSNNXFvIrn7hIdCo/6uvet1VW9IwiI7/euUo8lw5ponMLAbAnA/wqxDGdTNIQDE
         LQGC1TUwLSr5FEvKZ74H+PXYJXIAvwnTCiHSCPtKwm+zrGvvWdWdDdfx4oHUnbjQII0Z
         v3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720261033; x=1720865833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mtf5cQJcG2OUNA2j4NwJD3wssJxEz1X2PUn8pPQqvI=;
        b=JLyRUToeWw52T+PzPlXc99CesPp/t1WY/EEJtZhqIavKABmczPfzNh/tAGn3nFMJxK
         bjFUWS33SWf27CZid7+W8aDKKgRkDrj5wX/Z7IKndm8MR7ACgod7kLNYGjpSpUPNuBoG
         nVwhfZNPMwHIPTpdxNx+ENXqMMnuwB8yJFWt1A0fQ1958WpfUrV7i481JlGkTAUsKAaB
         tiWF2kHEM4dN0U1GBNLl4DIlAkn7R4SQ3g/c4rHr2uWePOtWTUPyhKDQjhfNPCEBPEn9
         58zTEU35ZhyliLekZPyj8TdfGYJrQMDbvQuQ5DrbWfSOtgzdjK+DxVyGEkLPDhLFTaHj
         O+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVKxi22AnOpBoVcReITXwy2AJPFrWML8gS+cW0vbW4Qa+CD3wfiPlKrDqkwT+LNkhI/S9wTQ3F+B3b35OLC+3XIDnPXo8SJTIEAbZTJK+aAHrsOuyxjUpsn3D3byaVVgllOTXfX59Hpjw==
X-Gm-Message-State: AOJu0Yy+8FGlNjq1IL/nKUMavzK5aQ2razVvyIOAjqlr+hxN2/Sd7lqh
	voEcP6XxsPNWdoPm03lxNotAX/EG2Qm+3DVB4wTgP3szXNRtbbrg
X-Google-Smtp-Source: AGHT+IF0v/E8P1gsZPyVFbdrgJKd+4rPi6lHFTML/dMGYzqjh9SytQtZ+G3aM/y+xcDGxs8oJZOAuA==
X-Received: by 2002:a05:651c:2226:b0:2ec:4d03:d5ee with SMTP id 38308e7fff4ca-2ee8edd8ccfmr58796651fa.51.1720261032284;
        Sat, 06 Jul 2024 03:17:12 -0700 (PDT)
Received: from qamajeed.Home ([39.45.163.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28d3dasm92117815e9.46.2024.07.06.03.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 03:17:11 -0700 (PDT)
From: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Subject: [PATCH v2 4/4] Updating a deprecated use of strcpy in button.c file.
Date: Sat,  6 Jul 2024 14:58:20 +0500
Message-Id: <20240706095818.96150-1-qasim.majeed20@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi All,

strscpy requires destination size for pointers. (https://elixir.bootlin.com/linux/latest/source/include/linux/string.h#L95)
acpi_device_name is defined as 40 bytes no macro definition for length (https://elixir.bootlin.com/linux/latest/source/include/acpi/acpi_bus.h#L224). 
Placing a constant number to copy is not a good idea. If name lenght chages in future it will be an issue. Replacing name array with acpi_device_name macro for this reason.

ACPI compile time arrays should be defined using a macro. It keeps code change consistent accross the source (#define ACPI_DEVICE_NAME_LENGTH) 
If this suggestions seems good to you, I'll push the patch for the sugested change.

Best Regards,
Qasim

---
	v1-> v2: It fixes the build issue, removes char* name and use acpi_device_name for simplicity.
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


