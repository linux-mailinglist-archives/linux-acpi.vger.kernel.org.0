Return-Path: <linux-acpi+bounces-16214-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE62B3C84F
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 07:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EA91C8010B
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Aug 2025 05:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAF52C235A;
	Sat, 30 Aug 2025 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5rBQNRe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA932C026E
	for <linux-acpi@vger.kernel.org>; Sat, 30 Aug 2025 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756532077; cv=none; b=KcUefkS5EiiZP3q4rZKIes374s2t6TGs8eGqQziFzTSy59ZCX+BmXArXpmG6Bpq2YYHrheKgc4U9seuO/atBTn4PLYWjWXwc6eUhJxZqNJBj+r8Bv/LrIYfbbbssRXd4CSBCe4dUr8Yp2Km1OEKwJ2yP74xpcJ26EWxQINHAmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756532077; c=relaxed/simple;
	bh=sUg3IHHZ5J75voc11tMfoTslPi25KOJHeq8grWg0c58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NjkPN2RqNT1DYLYGB9fNRO0j9j1h3hrF7nM9v3SMAef3iM06QZYa5QdLHhio5IdAb9/YGnC7kMdjBqNx5232slS+MYHkbAu2AWU1I0rg1Wnlx5vq1BFELZChGHFIMBiOKoX+WC42YgfDe1OuZIHCWrdsYOzLt9+Pv33iPZW9s4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5rBQNRe; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--srosek.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-61cbc94f5b6so2045520a12.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756532074; x=1757136874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f4JCURpD1IE9B1D7dN2Ce6Y8RD7MLQqV22l08LzilKk=;
        b=S5rBQNRe4ZKb85YM/tXPDZ89YQZmQLfqkQBoGl9lxnuUSRlqRy2ko+aL1MT4+INTwT
         ++65d1r1T2luZc6cUzQRwHp4nDwxagnDgnHQ7Oo9NWvIXr0vj0dccrU+I6kRoW7r4kP+
         3NlN0Xr5DgWZa9S63YaB/q0KT89wod1qg3TMxMUEJVhl7m/clNY9vBo/AFDzQxxTG9HR
         5KcAYFbu1jk9x5+HxssDYuP+xK3+3xqilSdVCk4lNsH4YN3XU6rt3wlVa0tDg8nEB4i3
         /zR4KdnziSia4S1PPQFcy106HVa4VBN8wuUr6NEtThhkHiK78eT9fjs6hvS9DCu6UGu3
         RvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756532074; x=1757136874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4JCURpD1IE9B1D7dN2Ce6Y8RD7MLQqV22l08LzilKk=;
        b=wh/Q4Edxo4sK5B+vBB7+CttyTt0GjMBLYKHu8RDH+1ybyWXCz4nxBHO6LmbWZvfV3k
         LfjSmoN6P1nSTEsRGrDNebi9BcT0fpfbKPqf3oObDZewdWK1KlimzAhV/MtzC7E3EUEG
         sZkx/J5DH+nHlD2PzUVFmVnKfWpmWqKdKZsfxmnEUsYgDiKWu5h0u9QNkX2qJ/g6dElf
         xD3a4+15j4UyPt5CIWKL0lyriU1KUqOslKKBC9IfX7EEjxwbBUtyOKqDyxk+pdo4zKq4
         4NtsJ85p61tiHO3f3KXpwnIaL1s/gVduKCKqHgpehkhKwrTgZKje5FUqJJVePBHAGbdq
         jdfA==
X-Forwarded-Encrypted: i=1; AJvYcCW5aw0ClgYfJxZXSvLMOCytkNHI4FqJpe3h33z6KntwJIjSwoDXgdtL89xtraV0cRqZ9RS5NVPKgdY+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz85PnBtE71nrSHWqRar5ZiKDbAJ+T1yFvRzP+JrNjdLCqvmw0c
	MZUQqMLQZ1i5BIReh7c039/dpaWcTQpoo3TGPHcW1Q2yR/hsI0QqlR5eYOgzi6luEiX5QRK0eRT
	6yidM0A==
X-Google-Smtp-Source: AGHT+IGFjIbQG+PkRlvNQXmqvDYraN3w1hWZbvAP9fKh5lxZvzQWxeLmsmHCe5Ni/n5zW0KmqrlkmFZN1Pg=
X-Received: from edn18.prod.google.com ([2002:a05:6402:a0d2:b0:61a:165e:6a2d])
 (user=srosek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:504b:b0:618:aed3:38a
 with SMTP id 4fb4d7f45d1cf-61d26ebbf9fmr774333a12.31.1756532073940; Fri, 29
 Aug 2025 22:34:33 -0700 (PDT)
Date: Sat, 30 Aug 2025 05:34:03 +0000
In-Reply-To: <20250830053404.763995-1-srosek@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830053404.763995-1-srosek@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250830053404.763995-12-srosek@google.com>
Subject: [PATCH v1 11/12] ACPI: platform: Add macro for acpi platform driver
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
 drivers/acpi/acpi_platform.c      | 27 ++++++++++++++++++++
 drivers/platform/x86/intel/hid.c  | 41 +------------------------------
 drivers/platform/x86/intel/vbtn.c | 30 +---------------------
 include/linux/platform_device.h   | 17 +++++++++++++
 4 files changed, 46 insertions(+), 69 deletions(-)

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
index f25a427cccda..e2e0fc95e177 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -766,43 +766,4 @@ static struct platform_driver intel_hid_pl_driver = {
 	.remove = intel_hid_remove,
 };
 
-/*
- * Unfortunately, some laptops provide a _HID="INT33D5" device with
- * _CID="PNP0C02".  This causes the pnpacpi scan driver to claim the
- * ACPI node, so no platform device will be created.  The pnpacpi
- * driver rejects this device in subsequent processing, so no physical
- * node is created at all.
- *
- * As a workaround until the ACPI core figures out how to handle
- * this corner case, manually ask the ACPI platform device code to
- * claim the ACPI node.
- */
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
2.51.0.318.gd7df087d1a-goog


