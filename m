Return-Path: <linux-acpi+bounces-10715-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298AA12FF0
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4303A694A
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FD18C031;
	Thu, 16 Jan 2025 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh3vWglK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09C18BBBB;
	Thu, 16 Jan 2025 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987327; cv=none; b=MCKTdvLKgLkSAB3ljjne6i3/wgVEH3uIODEvXn37HxxXJxg6eGIV16NLbnWEOAYKRas4Udi++tZSrET4hQhSmgWAuCAme1ItyyKNNhgZbSXLwTJaPqitTqPYalWtnb8u44jK273KZeTpb/ez/nliFyh40UeVarHvsIl98YPKqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987327; c=relaxed/simple;
	bh=tvFFc9jqSfi146uWkP2FXKO3n1Nu/sE1ZirXOELT5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=puK2vlZElc5HyKFjRJHVV91ajYT/eQylwFT5/GgMbt3Iw43b5yYp9n5R3PwXPqPMCAqqtAof+kNBNdSXiGDHlAsiQNtwh9GZI4J/05sdY1v9dp3bpGGnHpIRmoqX2VWS5hmg3zFpmpTtq6kf3N0M3j1QnFJlvcBJvk7ftQPHN/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh3vWglK; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e4a6b978283so2727692276.0;
        Wed, 15 Jan 2025 16:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987322; x=1737592122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJvRoioi4+8IEM/VbOOhuABFD8jxGM+2C0L+Rta5w6U=;
        b=nh3vWglKVx+yzYtbLWSXHcnysUSjpl4U8YcCbkeqUU/ZnlTjQib83LCw6goBzLQzdi
         jaVSXhwB6CB6M0qMkqXoirjFX+FWjyvC7sqRCEb8ERNN5O6yHsIVn6XnBZ3JHkPXYTGH
         gODwNUmsDCBC7sIRq8A6nQzi/0c8YTJXvfYjCAmWpOMbQNlX3dzC8WsHc2+PbZJ0GdJJ
         rJmWtCZawQiiDqhIwwJOApCTFeL1to6DQ8pd1iyZajXVtjNasZr11yIMvmfHhXiVhhB3
         WMxsQCiDAArlnG582F8wAtbHls2zk3CMdeCfcXVuJ6Xo9EZHBJKJ8/w58r5oYGu+5nDa
         ZVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987322; x=1737592122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJvRoioi4+8IEM/VbOOhuABFD8jxGM+2C0L+Rta5w6U=;
        b=nXmY0j5e360PxN+unZ7NYOoX7Txd4G4w9hT6Sca3tEG3nOAvKomqssR1YGDFy0TeTE
         YjFiat9CHsrnQnnwhiUgpjasQsiyMXXuPbCFsuhaIsX998flxahYjjYqwGmgSBnpgbbX
         HvI7h9OrN22+QhFa865UDPwvQsZV7ux5t3j/Qe8W4qLWp5ycns0aOveqQHY/JSe/B6to
         zWmJmbcHwgZntSj148BVDx7kiUaM3jUi+V2YFutX8UcuUZuCK60SwDnM9AraZW6Th9yf
         flB9k3kMfQua4tKPDaWJ6JLF+TeEFSYuCW57wCDo3pNcft7O+Yj1Tq+D2IpRCxqmZ7MY
         XLOg==
X-Forwarded-Encrypted: i=1; AJvYcCUiY4gQ4DN5BXJwNGFDrvKDGt/2vsqHgi2f28EgYkbMn+ZKXLI8r/Fnr/2WozD6mOMmRvbUlzi7AP69@vger.kernel.org, AJvYcCUsoRkPRvsNuE8PJfHRDRJEDw7G7Y61f/XHOZmN+U051wb+bNk09nnRqRV21ZU3H1AwNwr8Cey9XId7p21g@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbmCTIHo9VD6FKTDnyOvT0xZCsH6SYTfhr/KpTu9Dc11SW4w4
	TiPuQ+dq1xIDWVD4L8VnDut1cS9gCHJp8PZSMpQXY6XfeOHF5CqLFQ4Xjw==
X-Gm-Gg: ASbGncvifqiEv88k3MD4ttJqR4bz4a6tOSiXqPVO5r07Y0KFTsDA4EYeaLh6Mycpr58
	K6rxyLMY1QZU9dR8KN4Hl+ri8UhJ0Jj99jV7api+gjELmw4bynVgW3tSvm7VDwgISgFF3dbPGr9
	N/aAuaVE1Ymp0BaZgj7OdAXy7nQ+mAGrghL3R3zJ60cZ3lCn7zhwGJr90ynMA1GO2dS+YFXGKHf
	qT0B/36UNwC6Q0fxM5Yw8xVSG4yPgHAc2YVkEdygNHzwu9x9CAZOcqMgB1M3IXH
X-Google-Smtp-Source: AGHT+IGl4IYz/3yZadUUvL7dAbHAgHSNh1Rq3g/psvGcRO3ocvXjxYeg0SLdnVoDeEY5rZqWb3gtDA==
X-Received: by 2002:a05:690c:c8b:b0:6ee:8515:6730 with SMTP id 00721157ae682-6f6c9b700bbmr38197427b3.17.1736987322337;
        Wed, 15 Jan 2025 16:28:42 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546c46bdesm27229077b3.50.2025.01.15.16.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:28:42 -0800 (PST)
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
Subject: [PATCH v4 18/19] ACPI: platform_profile: Add documentation
Date: Wed, 15 Jan 2025 19:27:20 -0500
Message-ID: <20250116002721.75592-19-kuurtb@gmail.com>
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

Add kerneldoc and sysfs class documentation.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../ABI/testing/sysfs-class-platform-profile  | 44 +++++++++++++++++++
 drivers/acpi/platform_profile.c               | 33 ++++++++++++++
 include/linux/platform_profile.h              | 10 +++++
 3 files changed, 87 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile

diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
new file mode 100644
index 000000000000..b5a3600080bc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-platform-profile
@@ -0,0 +1,44 @@
+What:		/sys/class/platform-profile/platform-profile-X/name
+Date:		January 2025
+Description:	Name of the class device given by the driver.
+
+		RO
+
+What:		/sys/class/platform-profile/platform-profile-X/choices
+Date:		January 2025
+Description:	This file contains a space-separated list of profiles supported for this device.
+
+		Drivers must use the following standard profile-names:
+
+		====================	========================================
+		low-power		Low power consumption
+		cool			Cooler operation
+		quiet			Quieter operation
+		balanced		Balance between low power consumption
+					and performance
+		balanced-performance	Balance between performance and low
+					power consumption with a slight bias
+					towards performance
+		performance		High performance operation
+		custom			Driver defined custom profile
+		====================	========================================
+
+		RO
+
+What:		/sys/class/platform-profile/platform-profile-X/profile
+Date:		January 2025
+Description:	Reading this file gives the current selected profile for this
+		device. Writing this file with one of the strings from
+		platform_profile_choices changes the profile to the new value.
+
+		This file can be monitored for changes by polling for POLLPRI,
+		POLLPRI will be signaled on any changes, independent of those
+		changes coming from a userspace write; or coming from another
+		source such as e.g. a hotkey triggered profile change handled
+		either directly by the embedded-controller or fully handled
+		inside the kernel.
+
+		This file may also emit the string 'custom' to indicate
+		that the driver is using a driver defined custom profile.
+
+		RW
diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index 8a1454e66cf1..4895f37dd549 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -425,6 +425,10 @@ static const struct attribute_group platform_profile_group = {
 	.is_visible = profile_class_is_visible,
 };
 
+/**
+ * platform_profile_notify - Notify class device and legacy sysfs interface
+ * @dev: The class device
+ */
 void platform_profile_notify(struct device *dev)
 {
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
@@ -434,6 +438,11 @@ void platform_profile_notify(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
+/**
+ * platform_profile_cycle - Cycles profiles available on all registered class devices
+ *
+ * Return: 0 on success, -errno on failure
+ */
 int platform_profile_cycle(void)
 {
 	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
@@ -477,6 +486,15 @@ int platform_profile_cycle(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_cycle);
 
+/**
+ * platform_profile_register - Creates and registers a platform profile class device
+ * @dev: Parent device
+ * @name: Name of the class device
+ * @drvdata: Driver data that will be attached to the class device
+ * @ops: Platform profile's mandatory operations
+ *
+ * Return: pointer to the new class device on success, ERR_PTR on failure
+ */
 struct device *platform_profile_register(struct device *dev, const char *name,
 					 void *drvdata,
 					 const struct platform_profile_ops *ops)
@@ -546,6 +564,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(platform_profile_register);
 
+/**
+ * platform_profile_remove - Unregisters a platform profile class device
+ * @dev: Class device
+ *
+ * Return: 0
+ */
 int platform_profile_remove(struct device *dev)
 {
 	struct platform_profile_handler *pprof = to_pprof_handler(dev);
@@ -571,6 +595,15 @@ static void devm_platform_profile_release(struct device *dev, void *res)
 	platform_profile_remove(*ppdev);
 }
 
+/**
+ * devm_platform_profile_register - Device managed version of platform_profile_register
+ * @dev: Parent device
+ * @name: Name of the class device
+ * @drvdata: Driver data that will be attached to the class device
+ * @ops: Platform profile's mandatory operations
+ *
+ * Return: pointer to the new class device on success, ERR_PTR on failure
+ */
 struct device *devm_platform_profile_register(struct device *dev, const char *name,
 					      void *drvdata,
 					      const struct platform_profile_ops *ops)
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index eea1daf85616..8ab5b0e8eb2c 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,6 +28,16 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
+/**
+ * struct platform_profile_ops - platform profile operations
+ * @probe: Callback to setup choices available to the new class device. These
+ *	   choices will only be enforced when setting a new profile, not when
+ *	   getting the current one.
+ * @profile_get: Callback that will be called when showing the current platform
+ *		 profile in sysfs.
+ * @profile_set: Callback that will be called when storing a new platform
+ *		 profile in sysfs.
+ */
 struct platform_profile_ops {
 	int (*probe)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
-- 
2.48.1


