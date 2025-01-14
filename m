Return-Path: <linux-acpi+bounces-10602-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C5A10B00
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3B13A328C
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2031198E9B;
	Tue, 14 Jan 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OExNj7rz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27186189B8C;
	Tue, 14 Jan 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869092; cv=none; b=qWpZCgcs7CCr9Tjv9fgXZnyFuypt0HevXF8fA+CGelAl/WXYN/UIwbrRliMKsM/gkq2YS7PfA9vU93jYWMrsfBP/XZC0CIkK4lW6ZAKQYoW0Or79g77JzienGRE0buasWZjyN1O8B9lABjjlCRTCPsFfDxw/gqcTzwxayz0w4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869092; c=relaxed/simple;
	bh=HFk4lDSX5Cn06cr9o7eTBshvuZtxhybRjGsm5mM64IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8LNiirWzf9+BjVNqgvaXekIsmv7xZOkSZYPwh1dHHkOe3oxIxiQGozx0yeLq/PCN+BGhdnbPA2r0B+/s6tC4VZElOSMdj3ACwbwvGC6b2AJBoQZuF94HLIL4KWa6Mj5c+PvDQYSDG1xuUfCUhKl9TtT1LyaUiZ3KSOahzTe99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OExNj7rz; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51cccafb04aso566885e0c.1;
        Tue, 14 Jan 2025 07:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869090; x=1737473890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v+7fb9Mc4vSFklrQ/EkNnH9q794YIjKIyfQKma+ygc=;
        b=OExNj7rzmfvxY3t9ljWCKKQHXsybCcDYWSbtGzVThJltzrfl7AHhaPH//cVveM4n4U
         oer+vvJH6mxfpfSqeVIPRmE0Zg9qYIjJso/mLkFqEHoTZz5W7B+PGYRbURlBsg8CC4DC
         mbnQXaHN7bBb5JOE4iE5gTZn1xHnKlHXFanga6UftjsgyCYy4uni1BX/0mzOpEJsIO46
         9VbixZOCifCwOlgkZu6qCHoxFi1TGfSan02KsPdcxGwv7/oWBS6mvT463izErLISdKU2
         eFeJ07Fz83Y47XU4rHwfnl9fngkprDCj+I+yovQuRTkLA8FkwnZtChI3WyPb1NA+CPrJ
         A9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869090; x=1737473890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3v+7fb9Mc4vSFklrQ/EkNnH9q794YIjKIyfQKma+ygc=;
        b=cWqz9VUVtACmnQ96zk6nkyKR6P3gYLWTxj2UkCua/1LfkFnJj9IOQnDPVm+nI3e/Z1
         GHdYT4iEnW9HhrStlAMszB3FdUI+KRHryk6s+DYSf8AVwE6sqgFjg47HSJlceubJnWX9
         MQnjXJHqctuGCmfrvnXw+/v5uCniB70WYO1TczjSJZ4mUSJMlKq0VHG7qsuSb1+G/QSi
         vStyFvI1HmSIstw7mLQYormBHuuL5nDdl6eCEs57BthXEBVkczvRFoEJYovClXVZ8+bT
         o/OWD0iZhWNsUzQSjMNXN6u3zuzRhyhvS1g6gWnLRAGxtcWfPOxCqv9WTe1NuVse2lW4
         ZhOw==
X-Forwarded-Encrypted: i=1; AJvYcCUqj46SCWn02dtYM7KvVu1rwoljYiJfYAFZKvSwwkG6W7h9lxaOrpPC+jYTWuQkzvM88ip6inXbgTJc@vger.kernel.org, AJvYcCVz58Kpyon3giNTdV9O0ggUzgca2nzmnGBx9WMBbXF7SsfORqTlH5udt+RawCFlkYpAIeKbqucvbYQrAC7w@vger.kernel.org
X-Gm-Message-State: AOJu0YxaqRGgnMbN0+w7mmzSruFpLPaZcDjhqF8O+cMsZx6coFlL/h2G
	VvnKh8dvvO7WN6Z63k72eZS311+Fz6I/mKlvTQJGiy5Syfvt80PIeyFdVg==
X-Gm-Gg: ASbGncsKySAWdpc0CcMBpSs6ILE2EkrW9QAL7MunvkpJRIYHkg8i/83tnsBxJ11oinF
	D4933ET7sD6FnmcB1Kq3OcEKU04mU29EfQuHymhJ12RYkvUQLToHoyt21xScsOsPyr+jG1Ae86u
	mtE+o7XT2UzFLovniOTpQcwtph+oEbh1hxMgbZDsdS5IcgAvEsPfSIy/ODNZ/Hf5Vcw8byFSiGi
	MEQBEoK+Tl4f3qCI8jI6aoVLwnfQotHthXfvzoSJ/XHCRrwYRY1sL/TZmah0rXj
X-Google-Smtp-Source: AGHT+IGgKrhuAi0NAhA7eSXJVtKxbrbcCUmIbvWEgU9DX8MVVKqBjFnVSLGPY2RpAo0mi6KTyreJoQ==
X-Received: by 2002:a05:6122:4219:b0:51b:8949:c9a7 with SMTP id 71dfb90a1353d-51c6c304a14mr21474351e0c.8.1736869089667;
        Tue, 14 Jan 2025 07:38:09 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:38:08 -0800 (PST)
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
Subject: [PATCH v2 01/18] ACPI: platform_profile: Replace *class_dev member with class_dev
Date: Tue, 14 Jan 2025 10:37:09 -0500
Message-ID: <20250114153726.11802-2-kuurtb@gmail.com>
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

Instead of holding a reference to the class device, embed it the
platform_profile_handler. This involves manually creating and
registering the device and replacing dev_get_drvdata() with the newly
created to_pprof_handler() macro.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  | 36 ++++++++++++++++++--------------
 include/linux/platform_profile.h |  3 ++-
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4c4200a0b1a6..a89f64f13e44 100644
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
 	err = handler->profile_get(handler, &val);
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
@@ -476,11 +478,13 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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
+	if (err) {
+		put_device(&pprof->class_dev);
 		goto cleanup_ida;
 	}
 
@@ -493,7 +497,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	device_unregister(pprof->class_dev);
+	device_unregister(&pprof->class_dev);
 
 cleanup_ida:
 	ida_free(&platform_profile_ida, pprof->minor);
@@ -508,7 +512,7 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
 	guard(mutex)(&profile_lock);
 
 	id = pprof->minor;
-	device_unregister(pprof->class_dev);
+	device_unregister(&pprof->class_dev);
 	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index f1cd4b65e351..8a9b8754f9ac 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -9,6 +9,7 @@
 #ifndef _PLATFORM_PROFILE_H_
 #define _PLATFORM_PROFILE_H_
 
+#include <linux/device.h>
 #include <linux/bitops.h>
 
 /*
@@ -30,7 +31,7 @@ enum platform_profile_option {
 struct platform_profile_handler {
 	const char *name;
 	struct device *dev;
-	struct device *class_dev;
+	struct device class_dev;
 	int minor;
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
 	int (*profile_get)(struct platform_profile_handler *pprof,
-- 
2.47.1


