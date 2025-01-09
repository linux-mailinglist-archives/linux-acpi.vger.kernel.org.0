Return-Path: <linux-acpi+bounces-10452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA188A07B32
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6364B188481E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037421D00E;
	Thu,  9 Jan 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmqX0+ZJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047F21C19F;
	Thu,  9 Jan 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435290; cv=none; b=abWvLp+GF1fUNlwh+YudIj/mHAZWJ9HUV6pcN8035DG670SFLbabN2/9ios9Y9pZLL7MwBwz2jwDA+IMg8XkbHs2ta/sT6y7W/ojrP9jxM3ZmM5u08z6Kui43pfkcuwQjI6Q7UqVOQ1ZtCkHYmbHk2jqq7JW6UTBxtTyMZJ/oVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435290; c=relaxed/simple;
	bh=kQ0xyOrHLHgqL4B8cNM5E02Cets2aU9OrgEWK0BVjpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAWlJc5PsNFqd1AYVEy4kfE/mrLxESd7pY0hOLDZ7Tp8tmKysFpfmopPmXNr55uwypXgeZS5sfne1T/IJRz4nf8l3UkOs70Iezv98mnXWmPQ31xa79/sOEbRD6QQ1BXze0gDb2Dp0DafZJog5WmNbOEO7AzvA4OBUHLwIi1R6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmqX0+ZJ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4affd0fb6adso361771137.1;
        Thu, 09 Jan 2025 07:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435288; x=1737040088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FO0DTPEiGjE6vOWmEKb4fddXaogxmmVS1xP1xC2Y+8=;
        b=OmqX0+ZJEJuzej7XeKFPeU0aR8G/IMWCn+LMqxpccgKix0usCn1zRwftnqNzI7I/X8
         AF29SiF8ca5JgyHD8c4flLgpHquEO8r00n6HYTp/SGwCAr29MjszXSlITEEzHvu0Fimp
         +t+Q4FOU/aaPJRdkgYIIlLn4B6rRytKrNF7KI2LAqiWgu8sXy0kvSTKV2WzbPf31mVeI
         2zeZBuA74CATNQC15deltFZYxxbheffPRR6TvIScXkOEBZLLOVhDav6ozGSJ0K4UmsvZ
         e/SW5kScTtL8Jl7WabC6eTn1jX87S9Xj48lSob2zuc4iEBph6+rAOrQpGJQvCBuCMvzr
         lNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435288; x=1737040088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FO0DTPEiGjE6vOWmEKb4fddXaogxmmVS1xP1xC2Y+8=;
        b=sq7z1uxqdSyd4VyV5+yl5IbwNrzazhnc4AiRHEeIo/UlOSoDNRYwmQNzfF4fu01svM
         x/jVPOtJfQy8H1spHEsVVO4TuTnJhHMtDx2pt6bK9UyySgAQyxn7lKpVvEnjaFnnmpbo
         Ao9y8fQz24I2411xwqQGTmMQPoFaWP1TDtZT8DTJnf6cDn/pX2cJXMLUyroq687JM0h/
         OhHeU58npiRvfK7tn4sf+S0grRi0JWkYFgnONYADlg2Y09+WStG4XP2B9rXBP+JPA3nk
         OdEzSJNsfMkBrLLm7AAI+sYHWOnifTE+dcztca2c4GHzWid/N9dRVQZXFCIJd5lETG6T
         ncTw==
X-Forwarded-Encrypted: i=1; AJvYcCVvMN+/QewMuSCVU2PofaNSCta0S/2as82x4HIIb1pgE9OYA1G5i1OeT41Sh9FYdSevXvF7rG8oE/aO@vger.kernel.org, AJvYcCXs8YRcBMxJHMVnUytcSOu2K9JtO/4xjq06InKho4QPL7xLDlNlx0DIm69fUgpA5DgNaQW98gPVW3McXj7V@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUeo6qgInSCjckfXIsePFaWc2NIqBvX16e790Fec20jozlQKG
	59yBGhmf9CFou+vUGcL4XfkTcPT2X0zVx8uL1QCNfTL+Gmgg+7Zud//L8Jd/
X-Gm-Gg: ASbGncvVDEqW0T5VIsE/TydiwlJXcU1ZiWUmtXM/01M5zRkku0/nj0aTI95PgGaePfQ
	rcMuTPm3XZ8ACQ+b0WvCyTN8sGPT2MFPb0mEn+W4EvDBaBp8VyiVEO2DH9/u8/1YioZOHCz9PwR
	66ERGEPewCgIHugMYTC+VGfn8oWFJnM8yMVuXzJj5aRMGYn1f+z0Y+f7h0Vn6Zpuh8dcEIe6xt4
	EEnsObDU8SXUjt3V3AdpjoNdzT+ZQMH7eiz0MTOwkzyABCtWvASVLg3f7KdBsNG
X-Google-Smtp-Source: AGHT+IGwteO2+oDnS4b7ZTJBs+pRAvKcXQBYzvIhgrDoQ5ggqeRAAPmRQBG7yUgUqLG97vOfhndg4A==
X-Received: by 2002:a05:6102:94a:b0:4b2:bceb:1ac6 with SMTP id ada2fe7eead31-4b3d0e5f60amr6393154137.17.1736435287619;
        Thu, 09 Jan 2025 07:08:07 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:08:07 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ai Chao <aichao@kylinos.cn>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 03/18] ACPI: platform_profile: Replace *class_dev member with class_dev
Date: Thu,  9 Jan 2025 10:06:16 -0500
Message-ID: <20250109150731.110799-4-kuurtb@gmail.com>
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

Instead of holding a reference to the class device, embed it the
platform_profile_handler. This involves manually creating and
registering the device and replacing dev_get_drvdata() with the newly
created to_pprof_handler() macro.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  | 36 +++++++++++++++++---------------
 include/linux/platform_profile.h |  3 ++-
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 9cb82173947c..3cbde8dfed0b 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -10,6 +10,8 @@
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
+#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, class_dev))
+
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -60,7 +62,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	int *bit = (int *)data;
 
 	lockdep_assert_held(&profile_lock);
-	handler = dev_get_drvdata(dev);
+	handler = to_pprof_handler(dev);
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
@@ -76,11 +78,11 @@ static int _store_class_profile(struct device *dev, void *data)
  */
 static int _notify_class_profile(struct device *dev, void *data)
 {
-	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	lockdep_assert_held(&profile_lock);
-	sysfs_notify(&handler->class_dev->kobj, NULL, "profile");
-	kobject_uevent(&handler->class_dev->kobj, KOBJ_CHANGE);
+	sysfs_notify(&handler->class_dev.kobj, NULL, "profile");
+	kobject_uevent(&handler->class_dev.kobj, KOBJ_CHANGE);
 
 	return 0;
 }
@@ -100,7 +102,7 @@ static int get_class_profile(struct device *dev,
 	int err;
 
 	lockdep_assert_held(&profile_lock);
-	handler = dev_get_drvdata(dev);
+	handler = to_pprof_handler(dev);
 	err = handler->ops->profile_get(handler, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
@@ -124,7 +126,7 @@ static int get_class_profile(struct device *dev,
  */
 static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	return sysfs_emit(buf, "%s\n", handler->name);
 }
@@ -142,7 +144,7 @@ static ssize_t choices_show(struct device *dev,
 			    struct device_attribute *attr,
 			    char *buf)
 {
-	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	return _commmon_choices_show(handler->choices, buf);
 }
@@ -229,7 +231,7 @@ static int _aggregate_choices(struct device *dev, void *data)
 	unsigned long *aggregate = data;
 
 	lockdep_assert_held(&profile_lock);
-	handler = dev_get_drvdata(dev);
+	handler = to_pprof_handler(dev);
 	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
 		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
 	else
@@ -410,7 +412,7 @@ static const struct attribute_group platform_profile_group = {
 void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
-		_notify_class_profile(pprof->class_dev, NULL);
+		_notify_class_profile(&pprof->class_dev, NULL);
 	}
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
@@ -485,13 +487,13 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	pprof->minor = ida_alloc(&platform_profile_ida, GFP_KERNEL);
 	if (pprof->minor < 0)
 		return pprof->minor;
-	pprof->class_dev = device_create(&platform_profile_class, pprof->dev,
-					 MKDEV(0, 0), pprof, "platform-profile-%d",
-					 pprof->minor);
-	if (IS_ERR(pprof->class_dev)) {
-		err = PTR_ERR(pprof->class_dev);
+
+	pprof->class_dev.class = &platform_profile_class;
+	pprof->class_dev.parent = pprof->dev;
+	dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->minor);
+	err = device_register(&pprof->class_dev);
+	if (err)
 		goto cleanup_ida;
-	}
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 
@@ -502,7 +504,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	device_unregister(pprof->class_dev);
+	device_unregister(&pprof->class_dev);
 
 cleanup_ida:
 	ida_free(&platform_profile_ida, pprof->minor);
@@ -517,7 +519,7 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	guard(mutex)(&profile_lock);
 
 	id = pprof->minor;
-	device_unregister(pprof->class_dev);
+	device_unregister(&pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index 972a62be60b2..f549067539af 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -9,6 +9,7 @@
 #ifndef _PLATFORM_PROFILE_H_
 #define _PLATFORM_PROFILE_H_
 
+#include <linux/device.h>
 #include <linux/bitops.h>
 
 /*
@@ -40,7 +41,7 @@ struct platform_profile_ops {
 struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
-	struct device *class_dev;
+	struct device class_dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	const struct platform_profile_ops *ops;
-- 
2.47.1


