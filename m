Return-Path: <linux-acpi+bounces-10608-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF23EA10B14
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF2F169CE5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395831D5AD4;
	Tue, 14 Jan 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+ziSngX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E51D516A;
	Tue, 14 Jan 2025 15:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869114; cv=none; b=qbbnX9Zc7U4JmKkexPlvDEa7E525oPVjd1peXtreYYwsbIRuqbHnodN16gSCQaw2pOXl5LcBrOPzWPxkbjijF53E0MrDIBL0LlZCue9SSuJS7GYD9Ubogbt7TvGTvQZ7ZiVKVoUmZdLgfNad5pTiFSNNbSBYNvjO5PZFPWRAKM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869114; c=relaxed/simple;
	bh=NaOj6JLG8xbse3Z94sPWjBTSVxlI9dvAjjS2f2cWDkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlnnCm7YhlGXNSYC/J2tzN8/2zm/08muXMy89W5r6z6QFBKi+rhmZZ3ZsYCxoj3bSr9U69TM1ALxi57K+2gL8QKgSxO5CLPANFjPw62Dvk3hFtbm0XNAGQLJqDJjF6wTDlTvYXtVUrnuqUs+yxSCcUiYvQqFL8jK6cF+miYTNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+ziSngX; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5189a440a65so3345107e0c.1;
        Tue, 14 Jan 2025 07:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869111; x=1737473911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXXOBPa9TmGwpH3xyz4lwnmEdjwxxKtQdouu9864DVY=;
        b=c+ziSngXHqHdGNLLVlBUxt0Ole9VZDuIDvZltme41A4FPwjK8ce3PsVWyjoBtYcTxx
         A+VEVrMcqVY8ksU1fDoSjVZKlWUpEvGvHUupTe7cli0eoTJ0losivTyyOKJN23mMWDxr
         ddKBuTxc8HSeRtfdSwWD7tze11Qts4YXvkbWHWUAuxVeD5pKAf0JlBm35ZU2elyyUMvr
         sKs9lZNkmNHzixQm4z8vNDp2vA1g58h80/cOcMsN2cUc9N8iTpFRCD3gdHWZRYXVB1EI
         08K5SDiYR2DSqK9pFVnS25/tX378XGrSvLn0FzXwlMEUt2s/56ukp3efUG7rWrSwzfDe
         +6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869111; x=1737473911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXXOBPa9TmGwpH3xyz4lwnmEdjwxxKtQdouu9864DVY=;
        b=u4SRv4JIhDEK9pdOXJPkJ5AVKEbqSjyMFVTwQ3P54qK8OpjeWrjaR0sv7sv2L5oNJR
         8klll4bIJcNqCQAkiBVT0VfthTrBNygMzucNNgYAEUpIl3lZJPuSqytQ8NCz35TAFLDt
         3gZy3Qhhk0w1BFPSZJvnHEIWdeiEsOFJQqo2a0Yw407yj8A+iINFoQbxdznoU5ZvrDfB
         OUcR/HfI32x27j4zjFQAAL+t5KawNwUG2S5tNIzvD4EWULT+d7r80oVA3Oe6UZOQNyOz
         rE92ezFFXtNSy1ER2vq7YgxCDK2WVse1XT1mVbSg8HI0Wbwys0UiOxMUWTvQwt7mTPNA
         dYEw==
X-Forwarded-Encrypted: i=1; AJvYcCX8qo9VHJnw/DzwBsky9BRbw5ugjK41VmP7dLmVSK4NUuJxd9RLlmSOgCr3rdjzIhwfD4kqX9AiFs+negid@vger.kernel.org, AJvYcCXH0mAfsmJoDzNy+B7NZwNC2SyNnPqRmyb/G40xsto/peDWjtT2mCdopRMxNScyemTg8dr20WhMT0sQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZV2DWtdhTB6WT9/YLbvJC/f0Ove1wysYgeo9knUVr/IWNI/R
	1w6P5QRSVPPHCEmA1an+n0SF55Xn3haFbJ7a4aKicj8ZTmDkC1HJwXk9Tg==
X-Gm-Gg: ASbGncsYCQZsQe3D+agJoG0That/1wZF/MsLpNJHNnd2xfmWWtU2aHl5l9vXYkHeoeI
	RTgKHW/UFYZMmqa6HRVprRm02Pxm18vtBBPPktW0VDKuNosAj0pJPDfl1Yb22Hpug66HGuBVU74
	G71oUzS+cHviMEZT8pH6vntP1mBw4F+gYN2DwBszyxmcGs05GAI1zbSqF2u8CEcMnmdeARcwkyF
	MIH+k/TRvmIDly7PJ5YL8gY+FvTNU62+RkduW39bZBnxfMel0nnYE7Ts3d4pcXY
X-Google-Smtp-Source: AGHT+IGymxghO7z8dVU7Eu/b9OLkWgPwGI3fjmUa4U3Fe6h9wktGurAjv35UpLGhpIbvu3eOGVWekg==
X-Received: by 2002:a1f:e286:0:b0:51c:c663:a338 with SMTP id 71dfb90a1353d-51cc663a358mr3941855e0c.4.1736869110818;
        Tue, 14 Jan 2025 07:38:30 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:30 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	"Joshua Grisham" <josh@joshuagrisham.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	"Kurt Borja" <kuurtb@gmail.com>,
	"Maximilian Luz" <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	"Lyndon Sanche" <lsanche@lyndeno.ca>,
	"Ike Panhc" <ike.pan@canonical.com>,
	"Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
	"Mark Pearson" <mpearson-lenovo@squebb.ca>,
	"Alexis Belmonte" <alexbelm48@gmail.com>,
	"Ai Chao" <aichao@kylinos.cn>,
	"Gergo Koteles" <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH v2 07/18] platform/x86: acer-wmi: Use devm_platform_profile_register()
Date: Tue, 14 Jan 2025 10:37:15 -0500
Message-ID: <20250114153726.11802-8-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114153726.11802-1-kuurtb@gmail.com>
References: <20250114153726.11802-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 6953e36dbfde..39ec236b7cdb 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1944,7 +1944,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
 		platform_profile_handler.ops =
 			&acer_predator_v4_platform_profile_ops;
 
-		err = platform_profile_register(&platform_profile_handler, NULL);
+		err = devm_platform_profile_register(&platform_profile_handler, NULL);
 		if (err)
 			return err;
 
@@ -2591,8 +2591,6 @@ static int acer_platform_probe(struct platform_device *device)
 	return 0;
 
 error_hwmon:
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 error_platform_profile:
 	acer_rfkill_exit();
 error_rfkill:
@@ -2613,9 +2611,6 @@ static void acer_platform_remove(struct platform_device *device)
 		acer_backlight_exit();
 
 	acer_rfkill_exit();
-
-	if (platform_profile_support)
-		platform_profile_remove(&platform_profile_handler);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.47.1


