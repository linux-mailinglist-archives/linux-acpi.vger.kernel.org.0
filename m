Return-Path: <linux-acpi+bounces-10666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D5A11AB8
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB877A154D
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6661DB143;
	Wed, 15 Jan 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRwrl7iM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169461DB13C;
	Wed, 15 Jan 2025 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736925210; cv=none; b=RIac7EJ+sdrUgBv9raL14E8p6NuAdTgeqbZzn3ZpV+h77NDkEAmJKxKLXE+EI68J2htbREdc06hvvh3tu2UreKi+rNvRSYtQ9nGkXVyQLn0VO6lM4U07ZkIOQsAvtxc6zf/Dk2cBR3jP/oF9O+j6liLbC4ADr2h+Jyoco0dSJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736925210; c=relaxed/simple;
	bh=e1ueNPjFTPGDH9jxtLMCUdv6jqcuEiQgi1FB6PFQBQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+xORFT29rslJB+kSUkLjuHKb7PchXrSviQoa0X0bY71SfkkUvxwWmF0+vu/bvWXWqwWByxQcj74EO3YbJ4Rqq9s6ao/IYiUa6LlTgQEYpgC37geJLY5eU8G2ArZgBG7V6Z+pf1yj6OlSZTBciexx+F5+WHIaogOCyAXsLo8Tm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRwrl7iM; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4aff1c57377so336092137.0;
        Tue, 14 Jan 2025 23:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736925206; x=1737530006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enEYXwYCYpXtBd0/XTy30bZ8PlokduQNIpiMs89Aw/0=;
        b=aRwrl7iMTVcp/qlCsB2QJSsC4fDAcE4HpVIJmufGsgLo/nhvpDq/pHxzZ19jPdSUlJ
         vJj0Xs8bIKJZ4ox87VVv1kbu23lf+G5NBHRW9xptYyCyO4xXpxVtW3xPxddUFbsWOZ3m
         C3dSoq99AHmmN3azim0gJBlcCxVN+FspSsx+sYQcT+GdFeEjUHBBYIIswjaJ6ujOLs5B
         EyKbJaKpIE1/S+TMPvgPBN94GMzpFT4vk76vfIM7groBu40pvhGFimkmgkEfkG+d7E2A
         /ekKv1DZxSo+pwflFKByyFryPcsSW9UVPB1dpz1+wxQ3XkV/mgw7YNxXtGfamWby6sIn
         FcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736925206; x=1737530006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enEYXwYCYpXtBd0/XTy30bZ8PlokduQNIpiMs89Aw/0=;
        b=BwfkL8YMVbKun8LtPMKldIPJ5pfsZ3BEeLqwYLYiRWhpNH55Q3b22WtxV+RFM5m2e8
         gQ0CZaN3xLBES7kv2zVDDy65kONHhrweDbL8x1A1UZcigICwhdpMnpEVlFC+6koSUs/1
         6oufadqxO/CfG4PIdNbeVtZtG260tSmGO6OjvkPMBiETOFROlPpbkfOy8QUgkLj1TAPS
         hk9NSYF19wqmNV41xu7IDifLq1Our73AlgE3bMdwYPXp2FvL/BKGCDKoahzOG3erSEn2
         nxyycuh6yQXlqsHTWyfrokj9TrWajDAEqGgRY0BBYe42vZmXQX4heCDOtWsYPAt4vDuo
         /2zg==
X-Forwarded-Encrypted: i=1; AJvYcCU+zV/mrqH6zRKemGf3TaKkyRA+WCIg2rlT9wVDBuSap+zpvbk8P7fiOCXj+ID87M41Zs53QrHl4ACVGMNs@vger.kernel.org, AJvYcCVe9xOj2jDbqmzhhXxKY5oMOuLRVJSGBtdbtWMaY0PcQc6qNjcVkGt64UYk4Wcx1TUYnnUQz5pHcKYP@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwWw2+rZZtkaGDkiDg7hOyydaPuzcJyvyOVzimErcgh3rxOxY
	kJacqhUw+eJppmthGalRKgszRkHnpP/+0PnyZCjNaN5QziV/buYSe+rPiw==
X-Gm-Gg: ASbGnctftm1qh2ysHFhxvs4B1fHP+2XlBDMQdBaQ28yxeWeo14O8EJrMQywUKFnW4Ab
	xI/DVI3Qee+B2tdq3VoHUGDNiUWgrm/2ovMLQeCxqGIYeDZo5uD9QQF6JcH8+DK9HfDQJ5Dbd3k
	f2ojbamIawYxFzh/BxWtmZVr9vl2UyqrNC7x3FrFW7UvsmDxoJrBnEL+45lkCcjl7vi9f5DtAgq
	AOwIwTTP3dccFwscr4ouVx0ctIyiyR+39I2fnukVIqSBswd9l84/FZykim6HqE/
X-Google-Smtp-Source: AGHT+IFbP810wLAbnm3YetLTkB7YCbHpluB/UljnDfgpmNSWiel0H7FaglQjzOqGLVl8RVZD/2RKmA==
X-Received: by 2002:a05:6102:3f15:b0:4b6:99c:dd8f with SMTP id ada2fe7eead31-4b669fae4c9mr1398954137.10.1736925206601;
        Tue, 14 Jan 2025 23:13:26 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f033ffsm5084366137.6.2025.01.14.23.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:13:25 -0800 (PST)
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
Subject: [PATCH v3 18/19] ACPI: platform_profile: Add documentation
Date: Wed, 15 Jan 2025 02:10:21 -0500
Message-ID: <20250115071022.4815-19-kuurtb@gmail.com>
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
2.48.0


