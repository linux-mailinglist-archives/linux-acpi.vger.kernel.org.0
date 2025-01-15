Return-Path: <linux-acpi+bounces-10657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D155A11A9B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DB61889F2F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2015234D03;
	Wed, 15 Jan 2025 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyr5I/lH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32C231C8E;
	Wed, 15 Jan 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925142; cv=none; b=Knvuy34FJ8mYZz4Xqoy0lw2itVReFoffcKMnffkkmNnJO4y146n0w4hy4NN6FQafhrL8Vd6vBVO/XkAUFgLdhnYpw4VquTP+FiE16vtGX+i7WFp1st3dXKIlK9uxRT8gDOyrNllGwmbv82rhs+L9GaPJ+Le1LEb6bloTZHPrOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925142; c=relaxed/simple;
	bh=B+PxdPDh048pQD/k3PgrUQCKOG60hGDd1vrFivW5ztE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMcQFz44pPV6Om25r5mnmpcuffEfP3cDHijEj3VyiuqwippgS1iVQ6y50hsB4NM3Mh4b3n9Ft2qmw38E2RPBu4br4z7i68wRydkJtruGDvD2y3Gg7ezSi1zT0qRXOhq7nwZdDfgDP7guooL24vqHKaWlwKp7zA8hhU8THl1ePDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyr5I/lH; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4afdf300d07so3692244137.3;
        Tue, 14 Jan 2025 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925140; x=1737529940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXJtZ4DEJ2TVGLd1PBzRyZIRNg5LLQs9jY/0CznM+L0=;
        b=gyr5I/lHT77ag4BV99wRAFzURWhq/IGuthcVVGw73WvJh4NEJnLJYUtNS3DjGiAoWe
         /s47phvihOQmaLv5FB5huXFlaXJwZX+QSAgEGxY3lSTFEY6s/1OibCrXHzwtQYXVEzpo
         wnk5AKV/59Ao47v2mOKz2nP8i6RQX+5o5pgYn/taMaIvurjpZQ0yf9R3Og7RNBtWa1NS
         vxl1WIMI8e99qZGaDyscE2lPQ2q9fxf/qYC3OAJ59mkJLnNvLanYj2XcfeNR4gXW3ABa
         gXq15WBRL026ZhAid/t9VVpRGN811EfOxdZNfiEtI6iR+zbhv9pGmzpjfjryITF3MevW
         DRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925140; x=1737529940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXJtZ4DEJ2TVGLd1PBzRyZIRNg5LLQs9jY/0CznM+L0=;
        b=qDtr5SPcuIibbI7zH0qxwfLu1EeXKHp+cDi7Fu7C4TPzxfNnIQDl9VeqajuDqKpO8d
         r70lbAwnr06nFhSboM4/ne2j+xo1fnWDPHeRVRkhM+h54niiTPd5Tk+3wIHSVw56qxBo
         TV2DRbNS6bf+7JxKopCO02G5Bapkw1lmBLmtgJSjaKSHsdugj7Dmz9AX3y4XTV+3IC9y
         q8zMyKdqUajp7of3xiZvrhuwXL8kzAZJzrPfGC1dTXYBJbqE+Eczn70ACzqh/j22S0Xy
         yVDGW9gUojBMOErBZM7tRxVWYdYB2bhCRQAv/uxKxZuIn8h8cDczVlOdPGGR7aB7y5KQ
         xAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/677YP5yegfoE/fl3+dR8PFuMlLfuGOskxKODYYrAkfUmFTFCVbEBW1UTbYpvYjepgpLuQxJ7rvDl0Pgm@vger.kernel.org, AJvYcCWk/iau2lGVJ1OrYoKZLovXcDZL2lQHIc06UeOZ8BTlZVzObwZysjWj46OBfYnmOsDI2JNeMu2GTrRu@vger.kernel.org
X-Gm-Message-State: AOJu0YwKagiY8HWYhIZEm0iNKH4TAGeZXwH4GQKin9RImXgq1NvQ7BtM
	0j3N+vReo03TY+4Kiido5wEWBXe+O852iiVSHb8BKyAdVL0gFk0CylzQ6g==
X-Gm-Gg: ASbGnctL4pYoCCgXfsoMVznsK+W1XkQw2Ff5KnR/DPtcdt01oT0cRFC1McEvy0ghLTj
	7w5+5MJsXZj4zV+HEu0frtU9FJwXUJlpmtXwKnJHFeWMq9+WoqkJ6NPHN40nNYRf/xvvTkeNcoj
	1Y7D99hMXlL6o3qv00PA1f0V7IjXk2zwiK0yX01PaoGNTao7UfgaSkqinQvN1P7fiB8yHY8rvd4
	3C08EJHDlUfDTEDk/yRpcfvB24cMvbChY6zM301EZDlzynmMeKS0loJ+BXkRzAV
X-Google-Smtp-Source: AGHT+IFX7hf91lbxOibrFIOrjzixs61Nl5Lhpyf5V3eGDskxCLoLgPym7EOm/71BWJs2UjUNJBcKFw==
X-Received: by 2002:a05:6102:808b:b0:4b6:3e7e:ee48 with SMTP id ada2fe7eead31-4b63e7ef1c9mr12231487137.18.1736925139809;
        Tue, 14 Jan 2025 23:12:19 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:12:19 -0800 (PST)
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
Subject: [PATCH v3 09/19] platform/x86: asus-wmi: Use devm_platform_profile_register()
Date: Wed, 15 Jan 2025 02:10:12 -0500
Message-ID: <20250115071022.4815-10-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115071022.4815-1-kuurtb@gmail.com>
References: <20250115071022.4815-1-kuurtb@gmail.com>
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
 drivers/platform/x86/asus-wmi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 3d77f7454953..f8437cff66df 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3895,12 +3895,12 @@ static int platform_profile_setup(struct asus_wmi *asus)
 	asus->platform_profile_handler.dev = dev;
 	asus->platform_profile_handler.ops = &asus_wmi_platform_profile_ops;
 
-	err = platform_profile_register(&asus->platform_profile_handler, asus);
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
2.48.0


