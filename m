Return-Path: <linux-acpi+bounces-10466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25184A07B60
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1B2169697
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA86F21D58F;
	Thu,  9 Jan 2025 15:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc2gvbBv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14215220689;
	Thu,  9 Jan 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435378; cv=none; b=vAzb5349Cxq+ZhhG/x5gQd8phuRpqDmf6ne08oKXjDdkCTs2Gnd/fFYpkx9vlerSYPF1hrLfSMc2nQAIJifi83AEP/UU4vrLXYmxOVyDxniU+EsP5zfqaXqApJlo9AnQyDDr3MmuC2D7oc0pegZMll7LgUBk1zlHZWPklzQ2GGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435378; c=relaxed/simple;
	bh=S6ZvjFeEp+wC82iABXX4BtMKahSZbvZujvbdRq1PYTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pv1vfRDgA/zX1l3DR34fSnXoKAR5TGQj2clcUawjJDX0wrzCsoy0RPKFnXANfIKUbR3bRlsgT9N0FsOGIAgOdNY3nFULX1Y1+DsGsJ8TwhjhZQpHaU7Zo9x7fbkDYJs0jUqtBHKzXSqT8wqlMqZmssjViN9mNHpgn2XIO8u9qpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tc2gvbBv; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afe99e5229so342941137.3;
        Thu, 09 Jan 2025 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435376; x=1737040176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alWZYIMhk442ua4+AXwxd9UcSCUot/ASC61cF7csBfY=;
        b=Tc2gvbBvrVE8Xnm2pxZXquchJKe17O4OR9TYwQ8h9hYwwQev03ZG8gyfpYRu3v4Pto
         vygWlUan445IolsEMVaBspl5ohmu06eTJRD1b3bD40MlfBA5BJECgjntZ4KPBvMhtIL1
         F/TMaa8FDjzNcr+oyo2Qi8xpqiviGPeRqwLzHCIoRvEo8K+zim+c4l3+TYtqEoTtyTjO
         60eH0iSe+HexhtPVF+PiyN7qU/AMwWeTYA+Dqdc3DEcBcmrJFg1SV+pVHncmbF8QRWFu
         1xWZpU/VqJpezmIrXuuv9PjQoKS5D1m1o4LIZGpcN5WDIjIaF/Npkjvc43cXDg7Tn7Fm
         9okA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435376; x=1737040176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alWZYIMhk442ua4+AXwxd9UcSCUot/ASC61cF7csBfY=;
        b=ZPUTo2tSKRa10ZReOppZ/FQaW3KCXAiTRX3ilyKkt54UKFg/hgqOYU6eNvWQGPGixd
         pcIl2QvLdrPvzXoBPA9k31Pod7EjqIw+nKQ0QBLnZQa3q7U4pEZlqmKNz4gfvA/cQV/t
         xDKm96r5bPypbJhmMsUpsGNINdE/7mfZDrTUlAL40oEbNOsFGD1DQjDi+/QmJK92wnFz
         hmbBuGGJMOTi/U3U9LupZ/qUaB2aP280rMUqHq2ueSU/Igh1wdgOf917dYTON5aM8m99
         VykzHzoEIuuxIGAoGL83IoaJ/O7n/JYuKkZJRoba00TyuPDLE6j+MFkAAKj3ZJ2NiRJT
         XVyA==
X-Forwarded-Encrypted: i=1; AJvYcCWYM430eSOB7x6tmE43HwQAbzJOGhmgDJCZRbfT/7UmMcf4Q3NiFl2R1wHuPlQSE8cvyy6rml+LF4/B@vger.kernel.org, AJvYcCXjVxz7PmD232wqE/lteTbo+ea/8GR+iWlx6mWOO+hiyNzMFppRNTscDFp9WE2/75Ln83pJFO/gpIvk+UpZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzhuvlTk4ihlbVu7a/40vkIHuSlzxj+nkQuyuqANYLtXpyRuhih
	phyw8n424GBX82cJjzkxFG0bk7o8dJytENmhcQ3X+yimUaXTTKlrzR+OWMC6
X-Gm-Gg: ASbGncsYA5hRS9KezgvRTEXz08nQBmYmbUyANxg4LEKU+3YD9aCqbG2VAXKCVqRDNpl
	3EEtbOrQEb7TnTZqiyiwMVL7OYM13raMGxbGyU3C0alZYA1IXh+7nEl1z1Tzl6YlAc/ldhKxTVG
	WN8fKF9Sfr37z10UGp3kTaxmH6htf3KqljXJSKi4SHeMaBCwbtcB2XPCs6m9YGoTf7kEbf24VJK
	87aNQEWNyR7M8NpLFHFTVp0qyqpKXQwTlAykTBCIRxyJsL9w2yldFOIPa/t06dG
X-Google-Smtp-Source: AGHT+IFzJbwR1i5MRRJJwaT3bDY8YUxgY0hlGnEP4U8e2NG9/hsZi7OE1YoWuNz7wna4U9mU4EmOWw==
X-Received: by 2002:a05:6102:4a98:b0:4b2:5d65:6f0 with SMTP id ada2fe7eead31-4b3d1048269mr6227064137.19.1736435375741;
        Thu, 09 Jan 2025 07:09:35 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:09:35 -0800 (PST)
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
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 17/18] ACPI: platform_profile: Clean platform_profile_handler
Date: Thu,  9 Jan 2025 10:06:30 -0500
Message-ID: <20250109150731.110799-18-kuurtb@gmail.com>
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

Remove parent device *dev from platform_profile_handler, as it's no
longer accessed directly. Rename class_dev -> dev.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index c7a867bd01df..8c79ecab8a6d 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -11,14 +11,13 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
-#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, class_dev))
+#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, dev))
 
 static DEFINE_MUTEX(profile_lock);
 
 struct platform_profile_handler {
 	const char *name;
-	struct device *dev;
-	struct device class_dev;
+	struct device dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	const struct platform_profile_ops *ops;
@@ -91,8 +90,8 @@ static int _notify_class_profile(struct device *dev, void *data)
 	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	lockdep_assert_held(&profile_lock);
-	sysfs_notify(&handler->class_dev.kobj, NULL, "profile");
-	kobject_uevent(&handler->class_dev.kobj, KOBJ_CHANGE);
+	sysfs_notify(&handler->dev.kobj, NULL, "profile");
+	kobject_uevent(&handler->dev.kobj, KOBJ_CHANGE);
 
 	return 0;
 }
@@ -518,18 +517,18 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	pprof->name = name;
 	pprof->ops = ops;
 	pprof->minor = minor;
-	pprof->class_dev.class = &platform_profile_class;
-	pprof->class_dev.parent = dev;
-	dev_set_drvdata(&pprof->class_dev, drvdata);
-	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
-	err = device_register(&pprof->class_dev);
+	pprof->dev.class = &platform_profile_class;
+	pprof->dev.parent = dev;
+	dev_set_drvdata(&pprof->dev, drvdata);
+	dev_set_name(&pprof->dev, "platform-profile-%d", pprof->minor);
+	err = device_register(&pprof->dev);
 	if (err) {
-		put_device(&no_free_ptr(pprof)->class_dev);
+		put_device(&no_free_ptr(pprof)->dev);
 		goto cleanup_ida;
 	}
 
 	/* After this point, device_unregister will free pprof on error */
-	ppdev = &no_free_ptr(pprof)->class_dev;
+	ppdev = &no_free_ptr(pprof)->dev;
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
@@ -556,7 +555,7 @@ int platform_profile_remove(struct device *dev)
 	guard(mutex)(&profile_lock);
 
 	id = pprof->minor;
-	device_unregister(&pprof->class_dev);
+	device_unregister(&pprof->dev);
 	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-- 
2.47.1


