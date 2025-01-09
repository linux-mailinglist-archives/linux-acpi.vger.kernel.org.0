Return-Path: <linux-acpi+bounces-10467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CEBA07B65
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF561883C8E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6CB224892;
	Thu,  9 Jan 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUOWJ5zw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE0224888;
	Thu,  9 Jan 2025 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435387; cv=none; b=UDH1I9741LmR2GYlz8OGgoYqp5NzlUBidzVghmjSCv3ax3Bm/ZoDtieT5wUWIRgVJwmt64CW6yaPSPVpaGM1xrRiNjA5VCCyo2ZvsLiIljKUCL/aILBthZdlgwEKA0YbOKv7Cf90nbRQycUEkrOKHb2i3TYNdopQ7XZQIQibuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435387; c=relaxed/simple;
	bh=ueES1CpHxkIOmIdddrXeMAV9rO12JLZzujSA/AYR5iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uo94KCC1jqqPLNVMee30SkJ9Kj5Zscky/aarmPF4xXALOO88Bd9SCcdqKrdAxjkE4tI7xigTh31GS8tOck/U32BDSRnWiazIHAFS+ErPFVtxoAtaql2qv/6X1UHicmd7jvGEYD0NbuHVDABlgVI4PdMdSgU7+LlDvx0aLuZbyek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUOWJ5zw; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4aff31b77e8so427887137.1;
        Thu, 09 Jan 2025 07:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736435384; x=1737040184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXWFMX8a8Q4Pv2GPHLPCd0mT4LshIMD7WrNQh2s1+XA=;
        b=HUOWJ5zwI6QVQBYyLBzSXQLAkG+H6cfWWZJV4G8+WvRDpoY1D2xMjqmqIG4vyE7eU/
         W9yY61mMKeu8FdMW5moV4pMG38D3tf6qJ8uUqW1SL0j5M6DFF5Cn8SJZyqKlxHOigrUg
         p5IBWitrMDuCJKOxMCNWoCBsfoIa9pJR0LPtnpb9HEaTqsS8Az74qI/peQa17eKWjuKH
         0FuZqcRTeSkpviF+r2oKD6KwoR8HkftzyxdWeOHxLu7yFp8grDtCO8wKLQJ5mOblrKw0
         dEZZYAwWv0h7totJf3+mtVOToYC+a6dbr6zrAWr5vGSFSPc481mkCo23MTJA8inVuQZ8
         Z6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435384; x=1737040184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXWFMX8a8Q4Pv2GPHLPCd0mT4LshIMD7WrNQh2s1+XA=;
        b=hl5BxvMDD6hSX2hDC3ldhM8NfzAzWxfOXAGtSCnz0r9/Ix+Ef/0HjWhkc1MXCsY8iU
         NWNdy3dy1vXRforO3JR45u1KzV/05OTl8M5qyTumECtMPlzP0Fwcy6TAaRtsIub4+GIY
         vhMmGHkzketHjYs4z/ww1f0EeEX2xhf0OEaifSFTndem9nKQoW7IkydJLLT6fd+Tm7D7
         FlSdqPGmk/CltP8XISN33m7iAYTi+ccsr9Pw+D+yCqj021C77NcK7Ifqyu3eNOg5vVdQ
         PwHmpFuf88mkLKpiMqYtIrDVWGzBh2eyhrl4lOS04kfLrkBNknyhEOiDL8xHJEwPxFfb
         Of5w==
X-Forwarded-Encrypted: i=1; AJvYcCV13LOjadxFlbyaBl/E5+23Xxee+d7cilUSf3VY4RwVMg5dltdh0EdCONbm9z+ZEmO1YE2F9A9vjeoPrgc2@vger.kernel.org, AJvYcCXk44Op/K9gMqhvZWgcJwUuTtF587360UXCDtkJ08P9Z/P/8HOniPBAnrG2f4RZsn+oiaUFyZcX2F2r@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9lFese2+RGEw6+aULeaHfUpYVnIpW/3B8ARYJc8pecpZPTer
	UpzQSndGvRT9CnVNc0KfscTpBYTM/JdCAgj20NiDon2aPzE32x6Le/1V0VCc
X-Gm-Gg: ASbGnctXeqvjGgWAq7n8Mqsk2ttdo9DUIR2a+pcZmAeEZbfUVveaE4qDpLSL3ZsnqXT
	xMiJRdsYztDlknhjReDlcsLe19iZQ2V4hZr4Kag/6GOCcr6cc74b0ATReaidJRjs0HbfsR4EVFJ
	svGu7JxSFBl+LRpTvo7hyR7AAGY3xG76ek/iJ6HKaYpnWkyF6D60RFGmAkaXnQSJt0bFFb3xKzh
	kPphfuEZVEtJGfCa8Z49dRWaOYSX8jXrtuduHmCPyGIaDh51sQnL1GX1EoYES95
X-Google-Smtp-Source: AGHT+IHTsiyxTdRhLAyXTzqH/vzYBKjh+K4a/SbVvKlT32OwOtIjQS0SYK32yrgF2TjbYCaJTMQ51w==
X-Received: by 2002:a05:6102:cc6:b0:4b2:bc6a:2e8b with SMTP id ada2fe7eead31-4b3d0ef6127mr5990268137.3.1736435383993;
        Thu, 09 Jan 2025 07:09:43 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b608f4a5ddsm1019887137.11.2025.01.09.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:09:43 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Gergo Koteles <soyer@irl.hu>,
	Dell.Client.Kernel@dell.com,
	ibm-acpi-devel@lists.sourceforge.net
Subject: [PATCH 18/18] ACPI: platform_profile: Add documentation
Date: Thu,  9 Jan 2025 10:06:31 -0500
Message-ID: <20250109150731.110799-19-kuurtb@gmail.com>
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

Add kerneldoc and sysfs class documentation.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../ABI/testing/sysfs-class-platform-profile  | 44 +++++++++++++++++++
 drivers/acpi/platform_profile.c               | 33 ++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-platform-profile

diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Documentation/ABI/testing/sysfs-class-platform-profile
new file mode 100644
index 000000000000..59486dc4313f
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
+		POLLPRI will be signalled on any changes, independent of those
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
index 8c79ecab8a6d..5d74675c5419 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -426,6 +426,10 @@ static const struct attribute_group platform_profile_group = {
 	.is_visible = profile_class_is_visible,
 };
 
+/**
+ * platform_profile_notify - Notify class device and legacy sysfs interface
+ * @dev: The class device
+ */
 void platform_profile_notify(struct device *dev)
 {
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
@@ -435,6 +439,11 @@ void platform_profile_notify(struct device *dev)
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
@@ -478,6 +487,15 @@ int platform_profile_cycle(void)
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
@@ -548,6 +566,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
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
@@ -573,6 +597,15 @@ static void devm_platform_profile_release(struct device *dev, void *res)
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
-- 
2.47.1


