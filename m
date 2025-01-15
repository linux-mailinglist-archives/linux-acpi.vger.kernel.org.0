Return-Path: <linux-acpi+bounces-10649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A4A11A81
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186BB7A21A3
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C8922FDEA;
	Wed, 15 Jan 2025 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj8LGMNg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB63224B06;
	Wed, 15 Jan 2025 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925084; cv=none; b=ot1eaAJWOqHtJoTyZnu0QkkTlutQU8BfTBpa0MTxSlhK+u5A+XmabKsEn7OeunEC59WH93wu7QZCFxJIONiEmC0QsZSbSNq8yNIwoBS0mn/AzRzOh23wR5vapWkYs60wWEmb7IOhvNBYbNY+I2NmdzwhwdjSqHQp/nJMmpYpylQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925084; c=relaxed/simple;
	bh=+v5slvC+9AbUnLiMkDSfD8wpfPCf9ur/EgttNrQHYa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+jwEy4Kl2F/E8/Plxl4NR9cS133dHqRPDxKf56oJuALcSujzvoPb5BYwdSv2Rcu4vzT0E8Nvg1QdUVJkBXdlDe+SKthCNlM/0PgXI6oxV8waT5gUxodkp/UUMF9avDkBNlfzJOeElnLgFSkR5mUIl6NS6KEkjIpGg5KQXa7efI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj8LGMNg; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-85c559ed230so1471538241.0;
        Tue, 14 Jan 2025 23:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925080; x=1737529880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2VFZUj8BR8/0tTtvf2D7xc26cb5KXgzs6uQ+CX7Ed0=;
        b=gj8LGMNgsgEQ7G0TW0QoiwqagopaCRAKrHQ3UAgwmVdKRxv4ik+UWWd+gtmNIUaQz6
         j9F459tYPbPZVIB0w5V/kpd9+X8lunCi9GYq3iFw3G7Gr40PrwG+pXjns7XU3gHYsZmk
         nrsmOTwQUbMeFDVxu4cvWZqwVrnuWSBaM1H5jT9ZPE01EE1Ei8vdcPlCFCKykbEXo8zm
         YHMz4kW+bcH0eoppArFJ23B/Lf+9U9SrMs2KxRGqbnVBBmbreaeXtzXxKDrjIqzlPBNp
         lhzD6DAFAonY/cwfmn2tNsRIRtD46oDrvxfZa8k5zVNntceSRZXesTE66Epl2KThsNT+
         DLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925080; x=1737529880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2VFZUj8BR8/0tTtvf2D7xc26cb5KXgzs6uQ+CX7Ed0=;
        b=hthFjQw81CcqqpWdWx51gfx0nFOQyF3M1Ff+ruMKVbS62bu+YCnYQ+m54zN+1n/rtT
         XRseACN3OXHOVy3ZPfeOfwki06mxfRprQd5HcQEfx74HI2BCTbgaADUKzWZ8tzvEt9Rd
         XE75g35VnkbF2X3VTMxEbfdoGoOPpJBRCWyqzp0Moh2SogM8lvThY835U5gwdExNTU4p
         qa8vM3elcolx6BQSsrGTahCy9sLvfUVGDIyJJbXHnBA2UFAB7di23Ty7Q8j889VAZ80E
         rz7nYksT01zu39RSe/1LycVHwGC1X3555HQGT2mFVt+kVjltDbLVikapxZvD/KjGHXBE
         Kl9A==
X-Forwarded-Encrypted: i=1; AJvYcCWfrd1HQyB0KQvgeeLI/Bu8hxZSmJ4dE1dFQ0SFlpEr97IZ+kgiFtzclGQeYXuqQ121E/v2wTf778sm@vger.kernel.org, AJvYcCXVKcjRlHUjc9SUBlXdAdrmb4ljv9mTIl1mPFPOa2SXKMSoLhmfUFowIgVEi9h6iL7fL7z3+rTTL00wiCLs@vger.kernel.org
X-Gm-Message-State: AOJu0YwRtEDUOJIWiA7BLkxk6W3pLF8K7sgaSneNZWAHtnstHmWklRDm
	AZO+g1vTYTa2NnQbOrbTr+pYtplu9i76VEHQBU2eb1ZCU0fjtfUE5hKX7Q==
X-Gm-Gg: ASbGncvUU1FHB1lO2UotMQsLtUAvV+rFJV5z6Q03jyf9Mrdt3qPgrQJ4JBjox8TKNvC
	S5D0z1IFmW6i1X46+5ZDs49/ehZsUzf87H9pOhLhmay3LFXRGRDMkrxIdY6VfBLcKDAwQBpsnv9
	nwqHnvao+kCNbmHZov2xf1Z93r9K0bKBwTufK+XKcvFdQEYwurc3rrKBqArkIeifqsEUlz6FlRV
	ssSHhYQz2lW+rVqYuWwLYrmT0o4TGwT6ZrNNqXIRfWSypJtzUH3iaat5L88z8/n
X-Google-Smtp-Source: AGHT+IGAHdeJzu0b7PGqFZwqoj/mdG8XbC2G9kXdf3B0YmwuM/76DJKL2n58Tg4amQ2oQ+ncHyfbLQ==
X-Received: by 2002:a05:6102:418f:b0:4af:e99e:b41b with SMTP id ada2fe7eead31-4b3d104ad80mr27127389137.19.1736925080577;
        Tue, 14 Jan 2025 23:11:20 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:11:19 -0800 (PST)
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
Subject: [PATCH v3 01/19] ACPI: platform_profile: Replace *class_dev member with class_dev
Date: Wed, 15 Jan 2025 02:10:04 -0500
Message-ID: <20250115071022.4815-2-kuurtb@gmail.com>
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

Instead of holding a reference to the class device, embed it the
platform_profile_handler. This involves manually creating and
registering the device and replacing dev_get_drvdata() with the newly
created to_pprof_handler() macro.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c  | 37 +++++++++++++++++---------------
 include/linux/platform_profile.h |  3 ++-
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 4c4200a0b1a6..15f24adc57d4 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -5,11 +5,12 @@
 #include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/init.h>
-#include <linux/kdev_t.h>
 #include <linux/mutex.h>
 #include <linux/platform_profile.h>
 #include <linux/sysfs.h>
 
+#define to_pprof_handler(d)	(container_of(d, struct platform_profile_handler, class_dev))
+
 static DEFINE_MUTEX(profile_lock);
 
 static const char * const profile_names[] = {
@@ -60,7 +61,7 @@ static int _store_class_profile(struct device *dev, void *data)
 	int *bit = (int *)data;
 
 	lockdep_assert_held(&profile_lock);
-	handler = dev_get_drvdata(dev);
+	handler = to_pprof_handler(dev);
 	if (!test_bit(*bit, handler->choices))
 		return -EOPNOTSUPP;
 
@@ -76,11 +77,11 @@ static int _store_class_profile(struct device *dev, void *data)
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
@@ -100,7 +101,7 @@ static int get_class_profile(struct device *dev,
 	int err;
 
 	lockdep_assert_held(&profile_lock);
-	handler = dev_get_drvdata(dev);
+	handler = to_pprof_handler(dev);
 	err = handler->profile_get(handler, &val);
 	if (err) {
 		pr_err("Failed to get profile for handler %s\n", handler->name);
@@ -124,7 +125,7 @@ static int get_class_profile(struct device *dev,
  */
 static ssize_t name_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	return sysfs_emit(buf, "%s\n", handler->name);
 }
@@ -142,7 +143,7 @@ static ssize_t choices_show(struct device *dev,
 			    struct device_attribute *attr,
 			    char *buf)
 {
-	struct platform_profile_handler *handler = dev_get_drvdata(dev);
+	struct platform_profile_handler *handler = to_pprof_handler(dev);
 
 	return _commmon_choices_show(handler->choices, buf);
 }
@@ -229,7 +230,7 @@ static int _aggregate_choices(struct device *dev, void *data)
 	unsigned long *aggregate = data;
 
 	lockdep_assert_held(&profile_lock);
-	handler = dev_get_drvdata(dev);
+	handler = to_pprof_handler(dev);
 	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
 		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
 	else
@@ -410,7 +411,7 @@ static const struct attribute_group platform_profile_group = {
 void platform_profile_notify(struct platform_profile_handler *pprof)
 {
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
-		_notify_class_profile(pprof->class_dev, NULL);
+		_notify_class_profile(&pprof->class_dev, NULL);
 	}
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
 }
@@ -476,11 +477,13 @@ int platform_profile_register(struct platform_profile_handler *pprof)
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
 
@@ -493,7 +496,7 @@ int platform_profile_register(struct platform_profile_handler *pprof)
 	return 0;
 
 cleanup_cur:
-	device_unregister(pprof->class_dev);
+	device_unregister(&pprof->class_dev);
 
 cleanup_ida:
 	ida_free(&platform_profile_ida, pprof->minor);
@@ -508,7 +511,7 @@ int platform_profile_remove(struct platform_profile_handler *pprof)
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
2.48.0


