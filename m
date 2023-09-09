Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45694799988
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjIIQZS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346382AbjIIOUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561AFE40
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEiYzenJ2v0uacOfeS9KSCDfwh4ycnROiWeTaaakKS0=;
        b=MHWMtfWPiaC1kveUz+ARx5kwaJ25bU7qmayFHwLaiaYeyCExJ2Pzdhsny0AQXseF+ZNoKr
        x7+M1AYbJfpAXjwsyLg6DulHGxi5TU2leobFTzN3mE+8w1LIGBcW0rkST7eIJSX26bsxkc
        1cSYbxLRnZp5HjR47EvrfUyS018+mHw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-ynz5StlFOyG5HXbDUadR8g-1; Sat, 09 Sep 2023 10:18:30 -0400
X-MC-Unique: ynz5StlFOyG5HXbDUadR8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD080803C96;
        Sat,  9 Sep 2023 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C31C414171B6;
        Sat,  9 Sep 2023 14:18:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 5/8] platform/x86: x86-android-tablets: Create a platform_device from module_init()
Date:   Sat,  9 Sep 2023 16:18:13 +0200
Message-ID: <20230909141816.58358-6-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-1-hdegoede@redhat.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Create a platform_device from module_init() and change
x86_android_tablet_init() / cleanup() into platform_device
probe() and remove() functions.

This is a preparation patch for refactoring x86_android_tablet_get_gpiod()
to no longer use gpiolib private functions like gpiochip_find().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/x86/x86-android-tablets/core.c   | 57 ++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index ab8cf22ac5da..3d3101b2848f 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -25,6 +25,8 @@
 #include "../../../gpio/gpiolib.h"
 #include "../../../gpio/gpiolib-acpi.h"
 
+static struct platform_device *x86_android_tablet_device;
+
 static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
 {
 	return gc->label && !strcmp(gc->label, data);
@@ -224,7 +226,7 @@ static __init int x86_instantiate_serdev(const struct x86_serdev_info *info, int
 	return ret;
 }
 
-static void x86_android_tablet_cleanup(void)
+static void x86_android_tablet_remove(struct platform_device *pdev)
 {
 	int i;
 
@@ -255,7 +257,7 @@ static void x86_android_tablet_cleanup(void)
 	software_node_unregister(bat_swnode);
 }
 
-static __init int x86_android_tablet_init(void)
+static __init int x86_android_tablet_probe(struct platform_device *pdev)
 {
 	const struct x86_dev_info *dev_info;
 	const struct dmi_system_id *id;
@@ -266,6 +268,8 @@ static __init int x86_android_tablet_init(void)
 		return -ENODEV;
 
 	dev_info = id->driver_data;
+	/* Allow x86_android_tablet_device use before probe() exits */
+	x86_android_tablet_device = pdev;
 
 	/*
 	 * Since this runs from module_init() it cannot use -EPROBE_DEFER,
@@ -288,7 +292,7 @@ static __init int x86_android_tablet_init(void)
 	if (dev_info->init) {
 		ret = dev_info->init();
 		if (ret < 0) {
-			x86_android_tablet_cleanup();
+			x86_android_tablet_remove(pdev);
 			return ret;
 		}
 		exit_handler = dev_info->exit;
@@ -296,7 +300,7 @@ static __init int x86_android_tablet_init(void)
 
 	i2c_clients = kcalloc(dev_info->i2c_client_count, sizeof(*i2c_clients), GFP_KERNEL);
 	if (!i2c_clients) {
-		x86_android_tablet_cleanup();
+		x86_android_tablet_remove(pdev);
 		return -ENOMEM;
 	}
 
@@ -304,7 +308,7 @@ static __init int x86_android_tablet_init(void)
 	for (i = 0; i < i2c_client_count; i++) {
 		ret = x86_instantiate_i2c_client(dev_info, i);
 		if (ret < 0) {
-			x86_android_tablet_cleanup();
+			x86_android_tablet_remove(pdev);
 			return ret;
 		}
 	}
@@ -312,7 +316,7 @@ static __init int x86_android_tablet_init(void)
 	/* + 1 to make space for (optional) gpio_keys_button pdev */
 	pdevs = kcalloc(dev_info->pdev_count + 1, sizeof(*pdevs), GFP_KERNEL);
 	if (!pdevs) {
-		x86_android_tablet_cleanup();
+		x86_android_tablet_remove(pdev);
 		return -ENOMEM;
 	}
 
@@ -320,14 +324,14 @@ static __init int x86_android_tablet_init(void)
 	for (i = 0; i < pdev_count; i++) {
 		pdevs[i] = platform_device_register_full(&dev_info->pdev_info[i]);
 		if (IS_ERR(pdevs[i])) {
-			x86_android_tablet_cleanup();
+			x86_android_tablet_remove(pdev);
 			return PTR_ERR(pdevs[i]);
 		}
 	}
 
 	serdevs = kcalloc(dev_info->serdev_count, sizeof(*serdevs), GFP_KERNEL);
 	if (!serdevs) {
-		x86_android_tablet_cleanup();
+		x86_android_tablet_remove(pdev);
 		return -ENOMEM;
 	}
 
@@ -335,7 +339,7 @@ static __init int x86_android_tablet_init(void)
 	for (i = 0; i < serdev_count; i++) {
 		ret = x86_instantiate_serdev(&dev_info->serdev_info[i], i);
 		if (ret < 0) {
-			x86_android_tablet_cleanup();
+			x86_android_tablet_remove(pdev);
 			return ret;
 		}
 	}
@@ -346,7 +350,7 @@ static __init int x86_android_tablet_init(void)
 
 		buttons = kcalloc(dev_info->gpio_button_count, sizeof(*buttons), GFP_KERNEL);
 		if (!buttons) {
-			x86_android_tablet_cleanup();
+			x86_android_tablet_remove(pdev);
 			return -ENOMEM;
 		}
 
@@ -354,7 +358,7 @@ static __init int x86_android_tablet_init(void)
 			ret = x86_android_tablet_get_gpiod(dev_info->gpio_button[i].chip,
 							   dev_info->gpio_button[i].pin, &gpiod);
 			if (ret < 0) {
-				x86_android_tablet_cleanup();
+				x86_android_tablet_remove(pdev);
 				return ret;
 			}
 
@@ -369,7 +373,7 @@ static __init int x86_android_tablet_init(void)
 								  PLATFORM_DEVID_AUTO,
 								  &pdata, sizeof(pdata));
 		if (IS_ERR(pdevs[pdev_count])) {
-			x86_android_tablet_cleanup();
+			x86_android_tablet_remove(pdev);
 			return PTR_ERR(pdevs[pdev_count]);
 		}
 		pdev_count++;
@@ -378,8 +382,35 @@ static __init int x86_android_tablet_init(void)
 	return 0;
 }
 
+static struct platform_driver x86_android_tablet_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.remove_new = x86_android_tablet_remove,
+};
+
+static int __init x86_android_tablet_init(void)
+{
+	if (!dmi_first_match(x86_android_tablet_ids)) {
+		pr_err("error loaded on unknown tablet model\n");
+		return -ENODEV;
+	}
+
+	x86_android_tablet_device = platform_create_bundle(&x86_android_tablet_driver,
+						   x86_android_tablet_probe,
+						   NULL, 0, NULL, 0);
+
+	return PTR_ERR_OR_ZERO(x86_android_tablet_device);
+}
+
+static void __exit x86_android_tablet_exit(void)
+{
+	platform_device_unregister(x86_android_tablet_device);
+	platform_driver_unregister(&x86_android_tablet_driver);
+}
+
 module_init(x86_android_tablet_init);
-module_exit(x86_android_tablet_cleanup);
+module_exit(x86_android_tablet_exit);
 
 MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("X86 Android tablets DSDT fixups driver");
-- 
2.41.0

