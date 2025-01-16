Return-Path: <linux-acpi+bounces-10698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF7DA12FB9
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D23A5AF3
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D762125B9;
	Thu, 16 Jan 2025 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTgsE5hQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D9134AC;
	Thu, 16 Jan 2025 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987267; cv=none; b=i2pGkms7FISqRyZHng78OyLM99+clMer+TSh+3sh7ukB/fTOiii6RpA7d+b9eQL5+olvU1tVxLkJHBnjLU9UriGzbox9vToUK46hb3F0eRVvdTv3Mwj55n3/RXIVom4Xcav0Lzw//bLrc7dJSDz77HNX2a1XxJHSlxvmfzZbOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987267; c=relaxed/simple;
	bh=DGLD0kmL73nmcq12KV8lTWtz0LccRaUYOUpBkwBP5tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFBwezHE2ljNN5lW/iyV3pOspYkYWs1pzVLYq/a/ORe8/GVZ0OmJzmyz6yNMG526XVU7K88MU0/TzEtHyYvl8L9jI8///yEUtdI5xD749TUJA+jLjcOPz6+IMpF2NAkCxacRK97uno5uYZdmV8mpCP8jXl92+mdQXwdZmLdGghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTgsE5hQ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so556917276.0;
        Wed, 15 Jan 2025 16:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987264; x=1737592064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlFsdCufRBrILboyfB+KwlzmsEr01MCTNdW5OfiDX/8=;
        b=PTgsE5hQJG+MEUTRHszyjf9UIK6gjYcPyK0qW5c8tPADrCXXblgmf2WWCj+tq1y82K
         ICOMpd73s8Zg44fzVL80ej58LAtGyGCtzB35t+Z3403mDltBNgZg6k1TefLtuurQJB4i
         KMaTuYOBVnjrmRbs4ilGu1E7DUmFJPJdttGBPD+ai7cMlmLHLcIS0IlEA0jCh86mQTIw
         u3Kh9cdak9sn04TLkyRcBVfbN2olllM0EEHKihqTjnQOe2YgUGs6i2VdCEze3zzU7U1s
         zFjk//40JvdzAiv3mWgTmxQI8staDc+KiUUqZH+VYtvXORsYTVCShQP+BSWFHCJvoRDi
         P5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987264; x=1737592064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlFsdCufRBrILboyfB+KwlzmsEr01MCTNdW5OfiDX/8=;
        b=imJuNQvURHITuIMf3p/PvSCggXwOI400e0I/oEK7kXEcTCaVFxLIxkMFs25XLwYGUm
         c+nkQKF0Qffq57UQ+cssE4+F1jISLhDks2VIUXU8D91Aj+u8uy+PgOwspXET54xrBnGn
         EZEg5uX9xPcGvMP6gcpwxG365dHbD3e1WIGsrx582xcg3KKqGdSsSHCTxomsxiE4c475
         B914kMgYvqbUD/gHvmdcXZMKiUmQL+sCHYhWaXvBPzpFFL0vLwrpC9d4on4qEjEY1zca
         JXxt2lxyoD1selgOOsxGcAWDorFt95kkLrHf7DbATfKQ3DXMe7oxWziz/Xt8tHVGo96X
         NZBA==
X-Forwarded-Encrypted: i=1; AJvYcCWA/b3YxKEOcrQtBox/nwfo0gESkhWHgoq0vaFg/ctPsH30SHpUn/RJMXNNIAtxwweXSNeE6NB9tcCE@vger.kernel.org, AJvYcCXnx+IoGGM/iSStmFrKg54XQujdS7bsmZ81p496hvzGrYkqk9UoH3c0kecOj26quPpwrnHNeNMrcPR/RXmR@vger.kernel.org
X-Gm-Message-State: AOJu0YzsodR6u7UMm0mT7rhyDERP7bKDpkEymFSQ+Y5JT6MdQzHvJ6ac
	YmTHzOVYHiM3KoI6yWB0Icr+boQkwdZpZiwpY3ie2tyPD5nDYVuHWP6vSA==
X-Gm-Gg: ASbGncuQoQdoPYlxKNdAdaLg8ecA7UYfRdB0e74k+F9yv759OT5beR5keh6CDspmwJE
	/jJICRvl0V/g1U5DuMSdTX5pgkmYpdfJ5ukt4R+5FDl5hpjzQjHTHwJqU3tIVzEpA71NrIhhg64
	+97uABThMJM8p2Bfm6UsV5AaULalcDXdPODatVfJNM9mt1NQ4+kxQD9MErMKmG5b8PXkMPDKqka
	Z9kVLfn1+a0xYN5QqNrUE6MNvLBJmfyKeUStm1o3kYHaZMm5KORng3GEcKoM8Kz
X-Google-Smtp-Source: AGHT+IEbgVKjVbVgHlavzUMdayVgdtOy6e2M9nlksJdMpmo0Ym+3AKwWsF0x15YYMN6xSHoSlc+Wog==
X-Received: by 2002:a05:690c:4b92:b0:6f6:c8d0:c057 with SMTP id 00721157ae682-6f6c8d0c1b9mr62027047b3.35.1736987263980;
        Wed, 15 Jan 2025 16:27:43 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:27:43 -0800 (PST)
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
Subject: [PATCH v4 01/19] ACPI: platform_profile: Replace *class_dev member with class_dev
Date: Wed, 15 Jan 2025 19:27:03 -0500
Message-ID: <20250116002721.75592-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250116002721.75592-1-kuurtb@gmail.com>
References: <20250116002721.75592-1-kuurtb@gmail.com>
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
2.48.1


