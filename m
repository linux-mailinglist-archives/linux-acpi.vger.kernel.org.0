Return-Path: <linux-acpi+bounces-10618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F99A10B39
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6B93AAA34
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1681922C0;
	Tue, 14 Jan 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfC00FDQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC91C5F0F;
	Tue, 14 Jan 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869149; cv=none; b=uV8/ek9/colAsSFSeLO1Vcu2oIHnTOLXFKIw2LcvkjwiSL9MZcNanCFi/JaUpM00YiLzrniy3gl+IMq77rB7fvlh/OGvKRcA/K1N77M7fCPEUxp4H8f7pypvpntaU9EyV6UzWsR3wZql+FyDhzwKoRiNKA4Ell4HL0h5Ps/xoyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869149; c=relaxed/simple;
	bh=UNFLE3ouyw5oZJ+A8XYuo/S4UxIOzyEYBTcCMvSQJgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aibuJGgyXcVS9jSGeFtfLampo1r4CZ5jCmJWPsdkS8N8lI7Rd016u/X+/Bd64K05tdJ0lWgpBSZ39Jec+P+S8l5aZfYR+o1I5MJB2RKqM050X0xQTyjR14Axv+/egai7pcN5NhqHA/5HRxlO3V1Ws8qpr9WoWUMqYa0ZGBioToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfC00FDQ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-518957b0533so1877497e0c.1;
        Tue, 14 Jan 2025 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869146; x=1737473946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuGQ1ZVbISV1fd4ChxW9sFDp4MUhOEtSl7slykO1SWs=;
        b=JfC00FDQhweQjFJ25Zb7uOU+yi3uCc//PUs7dtA/KncCvpZbi0LL4w4BAPQqNAr7zj
         E49yRgq5ttHZ9oTtarzjwxhkZAPgMqNIRk8s+b0sZH2jDJRU+nJp9MBdJRBRgTNy2QKB
         3jO3+ls3szaYICQapANw7r4gkFnyvcgJI3dAum8Ss4Wb0V4KJIc0433IwjEJXDo2j16H
         JY0LxKYJsxTTPwjU+H/+wuuVj60H6B0cTzB46Jj5wglCDbHy2zblbwVjmAHf5FuYoKQp
         YTuscqlyjhAFHh4n67aWbiSn0XKVptRFZz76oUeOOP2x2AL9M/Adsw2St4n8RbIbV24G
         OnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869146; x=1737473946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuGQ1ZVbISV1fd4ChxW9sFDp4MUhOEtSl7slykO1SWs=;
        b=oyzyByxVdT5ztP8PGhdaGIKi6fO2xc9tLZBn9XR4HQddvRmvfXhEqt8KMYHfhYOF/N
         k8+VlvkjCOM1KpuwQ3bjC5QdDfYK6mAabxe/m/ApL2mB6OrqwUP7ntFGD4ymfewPeWVn
         KINeHi8RsqjoYKkxrx06sg3+k4K3Xbe+DD6jme0qm7JmGomGj/E5WD8K4EPE/nrL5FjQ
         LCdc6DKtwVIrWRR/jMCK60cH7muytApOjugm7OlmZD/6qx4/v7qGxtPOhwUIfZEgQnho
         19qTFeLieyhn8FpgNk8onN25+/2ldLzdDls2SIslZvLjOcB5JrkO5uN6RQyyAI4qO3Q6
         JZmw==
X-Forwarded-Encrypted: i=1; AJvYcCUWtRlSOgTFQZ5hLg4pltKBDllRYi8qyplXLaHjb7olgMk0YUDRGpMFd0JDLqBF3ijgw4fGzlcSIeYQ@vger.kernel.org, AJvYcCX9syRQcZDgro7Eb+HdAnD4z4v8ukU5ssmk2y7h7kiWFmUD7dl7C21QbUrG8YCYEMt732qv/ejMp1dh9oIb@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5b8bhq39Q/Npae/wfzTXyhW2nWfLtjxqJOFDUMSJPQOnB+HL
	HmXXjDLPewtNusKmpZCdn1fzpbMYKZQsg81i2JiKvuK8hAbzS6mBWeN2Iw==
X-Gm-Gg: ASbGncuFFXliDdU2WWt3RsbZoILEJRBOBQuz40Gv52sk5102mEuWWOooxc8PYElExuE
	PCip23JkUMP/OPe5Z86QbfBYEXWHSuIpi9ebrDwazsyj/O5MsCp/r7YWKSA8nx0nIKFedEFQOnO
	uiTi0v8xyXzZc62TYqo94+bNvUdeCnvlhrmMWWSp5zF0W7s1Pb8i1q+fsNJVI2L3w0z/mSBiS32
	eZRWou1rcnUgYgUmgDUtVwwePvwE15ayWQjd1T8EBZYVTy2fdLagdvhemuV8sa+
X-Google-Smtp-Source: AGHT+IF1jONKmPd5fYjh66MnEgs9+FR9HZ24HY+drnFS2W/9CvLzo68uJU5k6hwSn2/YoX2DGu44kg==
X-Received: by 2002:a05:6122:8f82:b0:51b:8949:c996 with SMTP id 71dfb90a1353d-51c6c48f340mr19515173e0c.9.1736869146001;
        Tue, 14 Jan 2025 07:39:06 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:39:05 -0800 (PST)
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
Subject: [PATCH v2 17/18] ACPI: platform_profile: Clean platform_profile_handler
Date: Tue, 14 Jan 2025 10:37:25 -0500
Message-ID: <20250114153726.11802-18-kuurtb@gmail.com>
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

Remove parent device *dev from platform_profile_handler, as it's no
longer accessed directly. Rename class_dev -> dev.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/acpi/platform_profile.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index f1749eb7b21b..c44989801f8e 100644
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
@@ -517,13 +516,13 @@ struct device *platform_profile_register(struct device *dev, const char *name,
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
 
@@ -533,10 +532,10 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 	if (err)
 		goto cleanup_cur;
 
-	return &no_free_ptr(pprof)->class_dev;
+	return &no_free_ptr(pprof)->dev;
 
 cleanup_cur:
-	device_unregister(&no_free_ptr(pprof)->class_dev);
+	device_unregister(&no_free_ptr(pprof)->dev);
 
 cleanup_ida:
 	ida_free(&platform_profile_ida, minor);
@@ -552,7 +551,7 @@ int platform_profile_remove(struct device *dev)
 	guard(mutex)(&profile_lock);
 
 	id = pprof->minor;
-	device_unregister(&pprof->class_dev);
+	device_unregister(&pprof->dev);
 	ida_free(&platform_profile_ida, id);
 
 	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-- 
2.47.1


