Return-Path: <linux-acpi+bounces-10619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DF8A10B3F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD913A9C81
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CAC1FECA5;
	Tue, 14 Jan 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKAlP3Rg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131551FC7DC;
	Tue, 14 Jan 2025 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869153; cv=none; b=T8Thfu7MbHXTKERctofGWi6pqVajs2xPF6ir2vQs4bSCvtKzsNCM8KWxJxAAcuqcxMM7VBFy7LMmc9CqBk2CzoZgjjf186mHKjLUheIvhuK88OtfA6BTmeTgfbjKa2aIexDh6ymODDfKFcxjlcW5r3i1REp7VoQ1DGcnu+Ti1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869153; c=relaxed/simple;
	bh=LFD5HnUv6axyJM8IqskxceD+/1v3k1p/nSQV9BE4jMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCQ278nu/T3WINJGwZ2PElimUIg5z9xDJsUtqeYbKfNGFaUuj/migAmT1y7rQ09LFhUiYGTkqzRnsZF5fQSZ7LSHturbwQHWvoYwc2XkiqBMtOkisIIhGlpXZC9QMJz4zxNY1ACDZ7ESiSBfo+6Fp6dcuf+rQxk0nf/ufZzewSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKAlP3Rg; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-518954032b2so1876756e0c.0;
        Tue, 14 Jan 2025 07:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736869149; x=1737473949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI1j7X1Kt0Lk/pNjI2Hh5cyHCwMeZVYB/YjyicpVYZc=;
        b=nKAlP3RgqzYbbkalsNeskZE3ihzrnhgfwqJED3XdimA1Csmt1FcmKfpG9jGRnM8+qe
         V8Q6OYNEzztde2NQlQynVQVgN5Z4cfZOvNcib1so2w2iTJA2oDd6ajEimq5XNTOqVyzd
         vXVzGkPVOzFy0tckyS7ZdLx9yCwzAAHaryFqoCR5vS4rWpF1zzH54qT1fFBD7CrHBOc7
         x6kHPIz+4U1HCiZS28f4Ey2Pu/gKMvdNdIjDCXLQw+MIOVcMXlO2DGDDj1cUh8xbRAi0
         1CqDo9n/LeZOuSzYQO/A8rNsfDDaz72LAXjp8xVCv0BmEZLKbGgd7tukih0Km5Y5wIFU
         Ds6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869149; x=1737473949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI1j7X1Kt0Lk/pNjI2Hh5cyHCwMeZVYB/YjyicpVYZc=;
        b=N0ykjdOYb/pbDEu3hDIcUJz9jwfFuCRcmX+E1fC2H+C0++fI/SC1zF99JGt4OxrBHn
         LdqdFEDwunRFKxynZK2G+ZjVDxvPgmqeHacP0JQUd+u+tOstwLVdXehIXkMcI8n+70Yc
         IdJc37OKeX14RvXIfwi6QeduMPX7hYhf8QJtKF/fDap4dNKdk8BDO9bUvQscVH+CJvWx
         gem5I4cGfu9NjSVvatlw9cVaYAlnwjj2+v8i8MK15gOangxOHo0AaEDtngLLm90j5yBO
         A9wl9ZY5czPkrBvPGZT39MBh0PfgUAFjlnF5bh6WfQsE8kgTDzP9bXBNUok/H05yhaWq
         lt9A==
X-Forwarded-Encrypted: i=1; AJvYcCWXiFtVJcvU03WHI1kQjc2YPVp6y2sqenBs8VjUgLx0Os4feU5rT+AP9rUmEKWxJw99le1CH2KhRH2K@vger.kernel.org, AJvYcCXMMmnpxcK5JEG37fUsaJLCEHrPmpZwXs8J0dm98la2fYmschmstGHy9whxNbCEmDZY+OE5ZroRl4UPZLz6@vger.kernel.org
X-Gm-Message-State: AOJu0YyeuITCjoRrzLXgLLUJOfkN8xhSYqSQeQ8Awlayhben3+lnDQRV
	twWwsW73joBU7j9LkU1OSotTZb3PV7gEIshNOLm+DlNH8BqyBXeo0RR/RA==
X-Gm-Gg: ASbGncv/yNQ6qsw01UGpvKYaXPqoHaaitxCmEuAcgrdGbMsoGk+RJLWjW21P0i8cjda
	aQL1HDLgFbwwW3kL1NKW6xfcX45OnvKgWaGWArc4+c8fa4Q+gTNc2UiSRK3AAsY96nFZ1TTvZpM
	lRfmCOSEFtOo7CtBlQSw0Lh/5ZjbMaet7KkwiWKlW6h5GYWgmW5DZaEtRjV/w9ptOzFYOsgC6i/
	NI4jdc3TO3nia93uB66iD8XDafAqfmBXMxMuzOyLHA8u4F8asgn5JQdK4lbWghy
X-Google-Smtp-Source: AGHT+IGWjNg4O4IOHdix6orWFAznbRve1THMCUqMyQa/ychI5YFbMGSAl/AiMHif0ctQYondNL80+A==
X-Received: by 2002:a05:6122:8f82:b0:51b:8949:c996 with SMTP id 71dfb90a1353d-51c6c48f340mr19515587e0c.9.1736869149474;
        Tue, 14 Jan 2025 07:39:09 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:1159:1ea9:11b1:7af9:1277])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51cd7c56d30sm277e0c.14.2025.01.14.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:39:08 -0800 (PST)
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
Subject: [PATCH v2 18/18] ACPI: platform_profile: Add documentation
Date: Tue, 14 Jan 2025 10:37:26 -0500
Message-ID: <20250114153726.11802-19-kuurtb@gmail.com>
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

Add kerneldoc and sysfs class documentation.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../ABI/testing/sysfs-class-platform-profile  | 44 +++++++++++++++++++
 drivers/acpi/platform_profile.c               | 33 ++++++++++++++
 include/linux/platform_profile.h              | 24 ++++++++++
 3 files changed, 101 insertions(+)
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
index c44989801f8e..9caddac695b8 100644
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
@@ -544,6 +562,12 @@ struct device *platform_profile_register(struct device *dev, const char *name,
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
@@ -569,6 +593,15 @@ static void devm_platform_profile_release(struct device *dev, void *res)
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
index eea1daf85616..eb4dc85dc18c 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -28,6 +28,30 @@ enum platform_profile_option {
 	PLATFORM_PROFILE_LAST, /*must always be last */
 };
 
+/**
+ * struct platform_profile_ops - platform profile operations
+ * @probe:	Callback to setup choices available to the new class device.
+ *		Parameters are:
+ *		@drvdata: drvdata pointer passed to platform_profile_register.
+ *		@choices: Empty choices bitmap which the driver has to manually
+ *			  setup, by using set_bit() in bits corresponding to
+ *			  platform_profile_option values. These values will only
+ *			  be enforced when a new profile is selected from
+ *			  user-space.
+ * @profile_get: Callback that will be called when showing the current platform
+ *		 profile.
+ *		 Parameters are:
+ *		 @dev: Class device.
+ *		 @profile: Pointer to the profile which will be read from
+ *			   user-space. Selected choices are not enforced when
+ *			   modifying this value.
+ * @profile_set: Callback that will be called when storing the new platform
+ *		 profile.
+ *		 Parameters are:
+ *		 @dev: Class device.
+ *		 @profile: New platform profile to be set. Guaranteed to be a
+ *			   value selected in the @probe callback.
+ */
 struct platform_profile_ops {
 	int (*probe)(void *drvdata, unsigned long *choices);
 	int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
-- 
2.47.1


