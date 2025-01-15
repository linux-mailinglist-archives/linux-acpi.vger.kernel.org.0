Return-Path: <linux-acpi+bounces-10665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA39A11AB5
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2A218852ED
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06A63DABFE;
	Wed, 15 Jan 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3YtoOyu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB29236A97;
	Wed, 15 Jan 2025 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925202; cv=none; b=Bggi2mIZLOFPgkqkBOl76DdDUJuMSMiKoYZwqWEJ5NVoougyln5ka7E3vPXMkl5Q0lf6GSZSu2hzzoDAM+leJUi0Cx9LavhJwfsyrm5PgvzFxBmV3OGRHxElSPMG0Cs/nJ5xz47MtjIEreqaqqrOMi+vXKxpjpBXBZVCgjct80I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925202; c=relaxed/simple;
	bh=PbM/zcyY0K/5Nt9qYtl67Y8YYaYdgMBAFkv4ImIIanc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1Gp1dC7v+u3Aru2jmlNxoVfxOCvgnRQVcixRqidDqq2B5/gbg09f5clIJwBp2ty+QjIl3li+CLnBY9ortUSId76oI32N4XqOrtf5JXft6nn45hYMH3n2vYtntcD0GQ52ZrzuDe04mu4yEUHxuXDb7cR86ElKPM5if4AbW5oDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3YtoOyu; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-85c41442fdeso1504851241.1;
        Tue, 14 Jan 2025 23:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925200; x=1737530000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW3dBpZ0O7d7p58qhz3mJ7R6y6O5YEsEjimqZXlUW1o=;
        b=Z3YtoOyuAk0CbvtmlKgRTnES/hVLEXE76V+nXaf1VQL9v0bOc5VAdfmsk0TUb8iVt3
         RA4Uw4ILhTlNAqpo5B65o5zVcyOinUY/XyZWePCzKqTfOfax29u4FhQoW7Pvt6tDxqjf
         kuCNT0UzGdhUTO2tQRndeWHnTZ22zWo9if+6Nk3EaZCgkGKj2xgmGtckAmX6yc9ejxw3
         +qmGBouSRcLlpVGfhj2SmppXckhQUkLUe2SYwiQSnEopr/7kcBD51y+stS/7+VM01cJU
         8ohP545VbLw27uMSHOqElyHrGrbsSsPX5GfW+Sd1/d3L3N7CvZnWYIjDzM9Sa36Ck0qw
         e54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925200; x=1737530000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lW3dBpZ0O7d7p58qhz3mJ7R6y6O5YEsEjimqZXlUW1o=;
        b=j5MiCXWsGD8WgHoG4wsVn2QhKDhX1JnWN7StkZKaa56D0JRcDupPSOj/mPq4pWPhoJ
         xj8MTwSRTx+37QfV2VdjfZ3cww+CYV1kForbkjeyfx+fKT+nfaun4kevYpYdigF0o4hc
         RN5I0NmHscTfVhfqIQ9QGpAAmd96cF53uRcVFeqy4VXzw80RjxaPHfJvpkpoakXmHEMz
         ezqMLW/WyBwNXt0qI+mBAUIpKojM0TR0qqTDBe+7LtCnKTXlzGnjgbkgvZkMHTrgHstV
         Kn4sL/PXSIti83hxNRhKSfdPeDmWScJ4g9LlXiRNnQ/4CGehk5uF1aK3X7tO/Ya+8ROr
         tNWA==
X-Forwarded-Encrypted: i=1; AJvYcCV8WV4RfKHJJC/CJlGwclsNDCMtCy0ErH0zWuQcKefA+EVT9/1YzrvUHQExv0QcSQNbdH1LFdGSYEjP9+CL@vger.kernel.org, AJvYcCVwHf1dIdaXgddmlK3IABOgNDBqblKZ1kfqUhnFOXMTG1QsrCMf1VwKToxJhrhSXXvY2zCM9D1aI2wC@vger.kernel.org
X-Gm-Message-State: AOJu0YxolizwwAK0EhozVXex5IaojBZHzfgqRFp9WGZJfwXFVmTNjgGe
	BMiZvycLW0QTTNNsAZpS5o1DLUlCIZOAkC8ZhYhb92A/Xcqc9mOKvf4Mmw==
X-Gm-Gg: ASbGnctDbSwjC0/6siKUJs1VOzUWzHwBvuCRlJDs9h5+XtKjQuNnfR7+luwn+9ZLJ66
	/A7Ey7IEIysXD1c90Xlm57f6mGgPedryjFZUKxThmGHy3C/o05yDnfaMjIxckzNRRXthINjoEQ7
	eVwXJh2EzVqkqZIrYOsC/67oV4dGBhLoxth7yrxIPfZI1Vwc0whD/y6Km3+PiL0cn7QG/hvfIkc
	g5b5f9aMhqyu4V6893o1Ty0fLdLd1Y0b260WDAHjgwu1n2woMol0V5DAPgL+fMI
X-Google-Smtp-Source: AGHT+IHpDKyoYatJeGEeuEKMH585YouUcTmDBZjt8YGHiwxRPXxJzIP0oEZ5PqmgvQ5af/7vI57vDg==
X-Received: by 2002:a05:6102:dcf:b0:4b2:5c0a:92c0 with SMTP id ada2fe7eead31-4b3d0fc95bfmr24974842137.13.1736925199632;
        Tue, 14 Jan 2025 23:13:19 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:13:18 -0800 (PST)
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
Subject: [PATCH v3 17/19] ACPI: platform_profile: Clean platform_profile_handler
Date: Wed, 15 Jan 2025 02:10:20 -0500
Message-ID: <20250115071022.4815-18-kuurtb@gmail.com>
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

Remove parent device *dev from platform_profile_handler, as it's no
longer accessed directly. Rename class_dev -> dev.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index f27005a267a1..8a1454e66cf1 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,14 +10,13 @@
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
@@ -90,8 +89,8 @@ static int _notify_class_profile(struct device *dev, void *data)
 	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	lockdep_assert_held(&profile_lock);
-	sysfs_notify(&handler->class_dev.kobj, NULL, "profile");
-	kobject_uevent(&handler->class_dev.kobj, KOBJ_CHANGE);
+	sysfs_notify(&handler->dev.kobj, NULL, "profile");
+	kobject_uevent(&handler->dev.kobj, KOBJ_CHANGE);
 
 	return 0;
 }
@@ -517,12 +516,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	pprof->name = name;
 	pprof->ops = ops;
 	pprof->minor = minor;
-	pprof->class_dev.class = &platform_profile_class;
-	pprof->class_dev.parent = dev;
-	dev_set_drvdata(&pprof->class_dev, drvdata);
-	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
+	pprof->dev.class = &platform_profile_class;
+	pprof->dev.parent = dev;
+	dev_set_drvdata(&pprof->dev, drvdata);
+	dev_set_name(&pprof->dev, "platform-profile-%d", pprof->minor);
 	/* device_register() takes ownership of ppdev */
-	ppdev = &no_free_ptr(pprof)->class_dev;
+	ppdev = &no_free_ptr(pprof)->dev;
 	err = device_register(ppdev);
 	if (err) {
 		put_device(ppdev);
@@ -554,7 +553,7 @@ int platform_profile_remove(struct device *dev)
 	guard(mutex)(&profile_lock);
 
 	id = pprof->minor;
-	device_unregister(&pprof->class_dev);
+	device_unregister(&pprof->dev);
 	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-- 
2.48.0


