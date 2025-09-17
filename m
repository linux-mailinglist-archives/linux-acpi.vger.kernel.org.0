Return-Path: <linux-acpi+bounces-17070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C700B7CBDA
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 14:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F06E4E11A9
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Sep 2025 12:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2C31A819;
	Wed, 17 Sep 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1rqRLGK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710331A7E7
	for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110866; cv=none; b=s6lnilSAKzMHxeM3CgCjIdCv+VgNswnBsN5B/iD3ZTKIm51sTH6E/SFEOl+CtWml2MV8X8EQT766kFSze9ox2Qn7kVcVKnvdUxp4CyedfYubi7kUW1qi3YlulfrK+i+syV90aNE5RmWSeHvmz8o0xnv69aotYPlTKjX7jP1Vu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110866; c=relaxed/simple;
	bh=0Ha7m8b/+ZHVHZAlQIkXhY2JBJJqlstM5Tl623XLNO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKm9booCnPPQtc8/S3GFlXmEgMLd0hLy05HglPLVwxUkP5xGuVB1UvHMDgAI2Ws/7j+sixV14gT8FrdxxdNWnMCTMxBHyy+1LGQh9uHMIey/xkBMbXtI+ohBeoYXERLw/5jqJFyj1XZX9oJIFnwswqsRFWJYdIAwaZMVwPuEKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1rqRLGK; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3eb0a50a518so1123391f8f.3
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2025 05:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758110863; x=1758715663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iM2iOBhF3jTNwGiyMt11FxfeniZGf805/faeSnHTQeo=;
        b=h1rqRLGKrFFIgQWSLGXPRud2BJGDA1O6bWOV2uskUQCr+YsiW9ZHpchmyZ0tw8tmS+
         M8WhmIP+KiCH/dHwOcE7foBNbBzJTFEFkd4yOetNES3aoynbMHqFrTjJAy8Ex8Ow2f4y
         E2MHBUD6JBB7jdHUKvphyl2wGiwx1tg7cFmTUCHpBEZLW0d38fe17id+9ecJfpBdqmTg
         4CHXg3bwufnOtZefGhsncXYdmusY8ut/q01KucjYnUL/08q/q6EtX2nx16MfI2tBHNUZ
         t5iJzmMguylJI9Zy68theTlt5jXk1wdlTKLXVSUbj7tYyXw+ORdnUKxLpgjxSOinXMZb
         Ffbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758110863; x=1758715663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iM2iOBhF3jTNwGiyMt11FxfeniZGf805/faeSnHTQeo=;
        b=RouF4Q69DrMt9kCQEPb0Qm3sYjvagtmGskqyzpYtqI5Qgvr37wx53G7Au0Dfe9RtHb
         BH51BOUUResXk+SqLlP1ca4VUBSGbXTkst2yf7UJ+wyvukOyU9Z+5URWZwmMbFU9oz2N
         SuzVH4foeuzYKvxqgGUwIUKGTGX8oPSLXe+kavr60kq249LXyxaWVtZzrzn0O9F0hx/I
         n9RzrLDPXHJqH+jHIwhCp+cEhS4gAj19LN69SRDXvQppBueZf9oSdq+M3isde1IbG0eU
         y9UMd0Yr4NX+UX0E2SAET6Raw0zLtf/w0LjqnqhMr1EzdfL4R4bcmKbQKPJTWILlJ0hL
         lAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkKhh/lKl63PG76XE44Pe326j9Vq5+LRuskTRJJQT5JC38/UDCAUgPI6Uu3u/0q6BJgy93FHJyxjdi@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbWkhUrfXX2AY1hhx+/KNJVq2WK8yIZweG2jnqMrwGgb3SFTO
	1ucOUsvoZEO/rKYoyq5cTrNeGqK5P7e3nlfUcJ/cMA4SIEDIz6pfAnLDgoULFN0ByRxOQNsMvPS
	+9eT9eA==
X-Google-Smtp-Source: AGHT+IEFmZwObfFR6PR74lZUpnUMvooCASwa43V7SnenyQCqtdR5oiv4vgIEIY4/wx+xKfDpXGuPB3huCAc=
X-Received: from wrbhb2.prod.google.com ([2002:a05:6000:4902:b0:3ea:892d:90cf])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:178e:b0:3e5:25c2:9637
 with SMTP id ffacd0b85a97d-3ecdf9ba45bmr1712866f8f.17.1758110863238; Wed, 17
 Sep 2025 05:07:43 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:07:18 +0000
In-Reply-To: <20250917120719.2390847-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917120719.2390847-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917120719.2390847-6-srosek@google.com>
Subject: [PATCH v2 5/6] ACPI: platform: Add macro for acpi platform driver
From: Slawomir Rosek <srosek@google.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org, 
	Slawomir Rosek <srosek@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce module_acpi_platform_driver() macro to simplify dynamic
enumeration of ACPI device objects on the platform bus by loadable
modules. Move common code from the intel-hid and intel-vbtn drivers
to the ACPI platform core.

Signed-off-by: Slawomir Rosek <srosek@google.com>
---
 drivers/acpi/acpi_platform.c      | 27 +++++++++++++++++++++++++
 drivers/platform/x86/intel/hid.c  | 33 +++----------------------------
 drivers/platform/x86/intel/vbtn.c | 30 +---------------------------
 include/linux/platform_device.h   | 17 ++++++++++++++++
 4 files changed, 48 insertions(+), 59 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 48d15dd785f6..adf32ffa6be6 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -190,6 +190,33 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 }
 EXPORT_SYMBOL_GPL(acpi_create_platform_device);
 
+static acpi_status
+__acpi_platform_driver_register_cb(acpi_handle handle, u32 lvl,
+				void *context, void **rv)
+{
+	const struct acpi_device_id *ids = context;
+	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
+
+	if (dev && acpi_match_device_ids(dev, ids) == 0)
+		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL))) {
+			dev_info(&dev->dev,
+				 "created platform device\n");
+		}
+
+	return AE_OK;
+}
+
+int __acpi_platform_driver_register(struct platform_driver *drv,
+				struct module *owner)
+{
+	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, ACPI_UINT32_MAX,
+			    __acpi_platform_driver_register_cb, NULL,
+			    (void *)drv->driver.acpi_match_table, NULL);
+
+	return __platform_driver_register(drv, owner);
+}
+EXPORT_SYMBOL_GPL(__acpi_platform_driver_register);
+
 void __init acpi_platform_init(void)
 {
 	acpi_reconfig_notifier_register(&acpi_platform_notifier);
diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index f25a427cccda..37f990686446 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -775,34 +775,7 @@ static struct platform_driver intel_hid_pl_driver = {
  *
  * As a workaround until the ACPI core figures out how to handle
  * this corner case, manually ask the ACPI platform device code to
- * claim the ACPI node.
+ * claim the ACPI node by using module_acpi_platform_driver()
+ * instead of the regular module_platform_driver().
  */
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-hid: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_hid_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_hid_ids, NULL);
-
-	return platform_driver_register(&intel_hid_pl_driver);
-}
-module_init(intel_hid_init);
-
-static void __exit intel_hid_exit(void)
-{
-	platform_driver_unregister(&intel_hid_pl_driver);
-}
-module_exit(intel_hid_exit);
+module_acpi_platform_driver(intel_hid_pl_driver);
diff --git a/drivers/platform/x86/intel/vbtn.c b/drivers/platform/x86/intel/vbtn.c
index 232cd12e3c9f..42932479de35 100644
--- a/drivers/platform/x86/intel/vbtn.c
+++ b/drivers/platform/x86/intel/vbtn.c
@@ -390,32 +390,4 @@ static struct platform_driver intel_vbtn_pl_driver = {
 	.remove = intel_vbtn_remove,
 };
 
-static acpi_status __init
-check_acpi_dev(acpi_handle handle, u32 lvl, void *context, void **rv)
-{
-	const struct acpi_device_id *ids = context;
-	struct acpi_device *dev = acpi_fetch_acpi_dev(handle);
-
-	if (dev && acpi_match_device_ids(dev, ids) == 0)
-		if (!IS_ERR_OR_NULL(acpi_create_platform_device(dev, NULL)))
-			dev_info(&dev->dev,
-				 "intel-vbtn: created platform device\n");
-
-	return AE_OK;
-}
-
-static int __init intel_vbtn_init(void)
-{
-	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-			    ACPI_UINT32_MAX, check_acpi_dev, NULL,
-			    (void *)intel_vbtn_ids, NULL);
-
-	return platform_driver_register(&intel_vbtn_pl_driver);
-}
-module_init(intel_vbtn_init);
-
-static void __exit intel_vbtn_exit(void)
-{
-	platform_driver_unregister(&intel_vbtn_pl_driver);
-}
-module_exit(intel_vbtn_exit);
+module_acpi_platform_driver(intel_vbtn_pl_driver);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d33..3b70b054d8a5 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -264,6 +264,14 @@ extern int __platform_driver_register(struct platform_driver *,
 					struct module *);
 extern void platform_driver_unregister(struct platform_driver *);
 
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define acpi_platform_driver_register(drv) \
+	__acpi_platform_driver_register(drv, THIS_MODULE)
+extern int __acpi_platform_driver_register(struct platform_driver *,
+					struct module *);
+
 /* non-hotpluggable platform devices may use this so that probe() and
  * its support may live in __init sections, conserving runtime memory.
  */
@@ -292,6 +300,15 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
 	module_driver(__platform_driver, platform_driver_register, \
 			platform_driver_unregister)
 
+/* module_acpi_platform_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.  This eliminates a lot of
+ * boilerplate.  Each module may only use this macro once, and
+ * calling it replaces module_init() and module_exit()
+ */
+#define module_acpi_platform_driver(__platform_driver) \
+	module_driver(__platform_driver, acpi_platform_driver_register, \
+			platform_driver_unregister)
+
 /* builtin_platform_driver() - Helper macro for builtin drivers that
  * don't do anything special in driver init.  This eliminates some
  * boilerplate.  Each driver may only use this macro once, and
-- 
2.51.0.384.g4c02a37b29-goog


