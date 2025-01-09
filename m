Return-Path: <linux-acpi+bounces-10457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E83CEA07B42
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2487E3A8617
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615D21D58F;
	Thu,  9 Jan 2025 15:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNj0v02p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEB21D018;
	Thu,  9 Jan 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435321; cv=none; b=cj2okFT7GON7qWWgGRaPfkYyxdufJbtnSJTb6MuRQnlfX5woklNDx/SN3g4HqtY7V93uhDAp9az/BhgFgBokjmqlKj9obHeEtm46vsFq1eS93tskz6ePzgayEDlytrgTRseWUtNetjHEN8ZEffQC6jypHgA+vxHEmrVLi73aMOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435321; c=relaxed/simple;
	bh=vywDhdcsdLuqHYO3u64jCjCA/7sqHd8JsTiWODBy3Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kkrz3Wd5tkBY8V7x89AjUY85iXF+cZWjcGRTypy5Z5v8muceGlPo9nmf2A9rJBTwV1PFNkdaWfZfkpYXVDMRvibkqOa1OFRCyF61VEWLRlFH6FY5NE/haOExuifEP2H9Ws/FmpNO3sf6OIwhUnvt/6FWMA6m2PM7eLdMhAs5CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNj0v02p; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4b11a110e4eso286404137.1;
        Thu, 09 Jan 2025 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435318; x=1737040118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpRy3dAZpB7RhV9HHTV4GtpVfyLmWse41E4e4Kgh7V0=;
        b=kNj0v02pIJPEKlul3AdQGYspain+7OkzLlcD4F/Hl9wGaO/3eCvuGkb/5kxlWiJdlM
         3jOic+sqpfKbh8fkrR9H9e61KLQhiqBXN5p1J+kaoG5472hHa7d3tNa+4IWvwT28kTgF
         4q+nvTn1wityZQDRtXQUtzWaUV+yIjmffy5kqyzLP91pBy57hHchmWchvqbxBnazUsqG
         PqwO/oRQXHXohYVM5BMW1MVqRbmXNLLUmm7sN9HBV49s7W7Tg/nZnyvVxVGZcRg31kuD
         Ail09xav8OpkSA2JaCdqyohTznW8yryp7iS/73ZZ87M69NXQPdpYidxriyn31jwmdKo7
         IjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435318; x=1737040118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpRy3dAZpB7RhV9HHTV4GtpVfyLmWse41E4e4Kgh7V0=;
        b=Xr46NUjvaXgGJiuVhV89a5fQTzsOTN+K2Q388VdeNmv4KwrjE4ETSIIFIhC1ZZaY5X
         n+LqYsB36YgU/0UNE9cgcWrEUj0y7CKtAwYEOIZFDueQKhbndQ6v9hizW8KzuKlYg6/9
         /gMU8/oO3G2MoGNUWUDl41tG1PQA3+Y/QQorzDGh/SHlxGPdkEgNOv4hzI1YDaCNJLaE
         Z475n6xaTDvHwQLB7raa8zZEPbLdsq3ScrT06uoQvdJ4CHwDNhkEOvU97Hc5q3BiDVfp
         CzAkBc7UPFYDiapourzwjAyDI+aKZW/BNuKgRFZbP7W4GBtB31NCvDRn8QnvxAQWYhAe
         79Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUc/NBLe+bpxN5tINQ7Wcsn6feVheepEg0PnRbrHlKSG1l21V3FrPd+JHgEad2RyBJquUAb5Uhd3o+iTBZe@vger.kernel.org, AJvYcCVydZWN9hNrXnATsp4GkELauUvs4sQmLa03WYCdZ8WI85HWnY1Zq4Yz3LO5iPhwsXh627Jk+0A3ocWw@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7B+mnQdN0OulU3lB49LsrIXQbVj9RgvGQJ2t3lwnypZMhcET
	Jmg9AO+KIiOW++aAtmMJ+9Pb4V5v+c+SlvlYcbL2vEFk6qLIzAgxM/4ypLCj
X-Gm-Gg: ASbGncuG4CurNPCTWltHWK/6qkLJWXe/nzRYjPzz8E7oO7I6YiVr3z+bhQjSORjEn7H
	FDFvKcBZNeQhg8aoT5KEd5woANzy7MXkez42vMaaM9/47u27K7ljhWkJwbm3x4KtVA2Yjy0xyL0
	/Nh9Do75bJ/z4t4U5mGsIjBzM9Komh6ZZWZUiGuMrK2aW8vyrbkZVCHgOT+DU2x47M5xG9AFUAr
	VmNlP4JClhm6GXARhPmxXSMuZqEFXvcAneaEyEPAHGkNr23XyF3bAAuRn6qDHH9
X-Google-Smtp-Source: AGHT+IGR/+CwNsQKCyZVv7L7iExfv3QE2DSqFOuBUmkY3DxOHBohtIkPAje8Sxp/ioTZav30tJeQOg==
X-Received: by 2002:a05:6102:32c7:b0:4b2:5d10:2cc6 with SMTP id ada2fe7eead31-4b3d0ee5017mr5660651137.6.1736435317983;
        Thu, 09 Jan 2025 07:08:37 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:37 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Mario Limonciello" <mario.limonciello@amd.com>,
	"Armin Wolf" <W_Armin@gmx.de>,
	Joshua Grisham <josh@joshuagrisham.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hans de Goede" <hdegoede@redhat.com>,
	Kurt Borja <kuurtb@gmail.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	"Lee, Chun-Yi" <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Lyndon Sanche <lsanche@lyndeno.ca>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Ai Chao <aichao@kylinos.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 08/18] platform/x86: asus-wmi: Use devm_platform_profile_register()
Date: Thu,  9 Jan 2025 10:06:21 -0500
Message-ID: <20250109150731.110799-9-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109150731.110799-1-kuurtb@gmail.com>
References: <20250109150731.110799-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace platform_profile_register() with it's device managed version.
While at it, pass asus_wmi to the class device as drvdata and replace
uses of container_of() with dev_get_drvdata().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 248490571e8c..5c7099dc6109 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3806,7 +3806,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
 	struct asus_wmi *asus;
 	int tp;
 
-	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
+	asus = dev_get_drvdata(&pprof->class_dev);
 	tp = asus->throttle_thermal_policy_mode;
 
 	switch (tp) {
@@ -3832,7 +3832,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
 	struct asus_wmi *asus;
 	int tp;
 
-	asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
+	asus = dev_get_drvdata(&pprof->class_dev);
 
 	switch (profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
@@ -3895,12 +3895,12 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
-	err = platform_profile_register(&asus->platform_profile_handler, NULL);
+	err = devm_platform_profile_register(&asus->platform_profile_handler, asus);
 	if (err == -EEXIST) {
 		pr_warn("%s, a platform_profile handler is already registered\n", __func__);
 		return 0;
 	} else if (err) {
-		pr_err("%s, failed at platform_profile_register: %d\n", __func__, err);
+		pr_err("%s, failed at devm_platform_profile_register: %d\n", __func__, err);
 		return err;
 	}
 
@@ -4859,8 +4859,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 fail_sysfs:
 fail_custom_fan_curve:
 fail_platform_profile_setup:
-	if (asus->platform_profile_support)
-		platform_profile_remove(&asus->platform_profile_handler);
 fail_fan_boost_mode:
 fail_platform:
 	kfree(asus);
@@ -4886,9 +4884,6 @@ static void asus_wmi_remove(struct platform_device *device)
 	throttle_thermal_policy_set_default(asus);
 	asus_wmi_battery_exit(asus);
 
-	if (asus->platform_profile_support)
-		platform_profile_remove(&asus->platform_profile_handler);
-
 	kfree(asus);
 }
 
-- 
2.47.1


