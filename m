Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4F25DE5D
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgIDPtf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgIDPq5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:46:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6C0C06125F
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so7207526wrp.8
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwQjX4axi1OAM1Fql28FiCukUb0sTZUG4ARXSE9mD5M=;
        b=W5igfhsJBABdupfuJeKs8ZFBc1NM6C1W6FgO9n8jRfloEFZuHfxm40QAS/h0T+mdla
         GxyRPVVnObFB5k5pT6P7LzWkxPcP/MWzPisHbMilF4BtXGUxAQrmAkLC2SYa0ju3givG
         KiDdwKVX7TmcUC0CDNP1LOrZJIVzrN6tcy2SQs/cRHBk9SBGF0OnzDbEHmReLwI8YbG5
         curcoJCjYPuMzo5FLZ6jFnrkMlNHbYkNDhaAR9TyFHkFsgDKgsoKwNFbjc2NMsKI1R6k
         W1rLSx82J/qPz/AUX5iCXYPb5sjOPuUGwZzOSxdHC2Yc2zVz0qy+R7vGvyvw8faAPsBr
         sboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwQjX4axi1OAM1Fql28FiCukUb0sTZUG4ARXSE9mD5M=;
        b=m19x2uwEdaNgOssY9oXVv9tWpVbgxeopgncf5bcr248/80g3PzCWx3ZuwIAyqfqLeB
         5Z7gRH91vUwABYRaNX95XYs2Nokyhhf6VGrnWmHXjswBJDH/eEce8W2l/7L0sFYmZJ4C
         oJBmm0zQHwc+WZaVG/ZNm4UY1qlkBwg6mO3yAM9yCltdsywfjQogqPiiS00Lf/mXCXgF
         XgddhqVXiEVfqK2Yaa1vtd0Po7Z4Yjgzu4EEn3y6WWV01vb0DfctdIsmMEIl3y0mFwqt
         1eSR00jcAuotEf/8t22FTachKrFIyhR5Z+NOPU27dS2ivhXPglTnwqEjn8UNxcWhSdgY
         AQWQ==
X-Gm-Message-State: AOAM533akqAzfEamr1jwha+tsM6v8cNrhyMDSGezMwVr5H9qInciRrJ7
        6mi7WW922O5utFgLkeSuk36Sgw==
X-Google-Smtp-Source: ABdhPJzGE6+N2EUSel1NKTUZ8lWtVuw8qctovGj3qxe1uNDtwPtrgatR9NUrM3Nh2Oj68SMpkZq+Bg==
X-Received: by 2002:a5d:69c2:: with SMTP id s2mr8226288wrw.389.1599234404374;
        Fri, 04 Sep 2020 08:46:44 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/23] gpio: mockup: remove the limit on number of dummy chips
Date:   Fri,  4 Sep 2020 17:45:35 +0200
Message-Id: <20200904154547.3836-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200904154547.3836-1-brgl@bgdev.pl>
References: <20200904154547.3836-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

As a preparation for implementing dynamically created dummy GPIO chips:
drop the limit on the number of chips. Let's use a linked list to store
the chip context structures.

Let's rename gpio_mockup_unregister_pdevs() to
gpio_mockup_unregister_devices() as we're now handling structures in
which struct platform_device is embedded instead of operating on
platform devices directly.

Note: this does not remove the limit on the number of ranges passed as a
module parameter. For now nothing changes in how the module works for
user-space. This patch will however allow us to create a higher number
of chips once we can do this dynamically.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 59 ++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 19c092f814fd..801fba6496a4 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irqdomain.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -24,12 +25,11 @@
 #undef pr_fmt
 #define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
 
-#define GPIO_MOCKUP_MAX_GC	10
 /*
  * We're storing two values per chip: the GPIO base and the number
  * of GPIO lines.
  */
-#define GPIO_MOCKUP_MAX_RANGES	(GPIO_MOCKUP_MAX_GC * 2)
+#define GPIO_MOCKUP_MAX_RANGES	(10 * 2)
 /* Maximum of three properties + the sentinel. */
 #define GPIO_MOCKUP_MAX_PROP	4
 
@@ -505,27 +505,37 @@ static struct platform_driver gpio_mockup_driver = {
 	.probe = gpio_mockup_probe,
 };
 
-static struct platform_device *gpio_mockup_pdevs[GPIO_MOCKUP_MAX_GC];
+struct gpio_mockup_device {
+	struct list_head list;
+	struct platform_device *pdev;
+};
 
-static void gpio_mockup_unregister_pdevs(void)
+static LIST_HEAD(gpio_mockup_devices);
+
+static void gpio_mockup_unregister_one_device(struct gpio_mockup_device *dev)
 {
-	struct platform_device *pdev;
-	int i;
+	list_del(&dev->list);
+	platform_device_unregister(dev->pdev);
+	kfree(dev);
+}
 
-	for (i = 0; i < GPIO_MOCKUP_MAX_GC; i++) {
-		pdev = gpio_mockup_pdevs[i];
+static void gpio_mockup_unregister_devices(void)
+{
+	struct gpio_mockup_device *mockup_dev;
+	struct list_head *curr, *next;
 
-		if (pdev)
-			platform_device_unregister(pdev);
+	list_for_each_safe(curr, next, &gpio_mockup_devices) {
+		mockup_dev = list_entry(curr, struct gpio_mockup_device, list);
+		gpio_mockup_unregister_one_device(mockup_dev);
 	}
 }
 
 static int __init gpio_mockup_init(void)
 {
 	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
+	struct gpio_mockup_device *mockup_dev;
 	int i, prop, num_chips, err = 0, base;
 	struct platform_device_info pdevinfo;
-	struct platform_device *pdev;
 	u16 ngpio;
 
 	if ((gpio_mockup_num_ranges < 2) ||
@@ -576,26 +586,37 @@ static int __init gpio_mockup_init(void)
 		pdevinfo.id = i;
 		pdevinfo.properties = properties;
 
-		pdev = platform_device_register_full(&pdevinfo);
-		if (IS_ERR(pdev)) {
+		mockup_dev = kzalloc(sizeof(*mockup_dev), GFP_KERNEL);
+		if (!mockup_dev) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+
+		mockup_dev->pdev = platform_device_register_full(&pdevinfo);
+		if (IS_ERR(mockup_dev->pdev)) {
 			pr_err("error registering device");
-			platform_driver_unregister(&gpio_mockup_driver);
-			gpio_mockup_unregister_pdevs();
-			debugfs_remove_recursive(gpio_mockup_dbg_dir);
-			return PTR_ERR(pdev);
+			kfree(mockup_dev);
+			err = PTR_ERR(mockup_dev->pdev);
+			goto err_out;
 		}
 
-		gpio_mockup_pdevs[i] = pdev;
+		list_add(&mockup_dev->list, &gpio_mockup_devices);
 	}
 
 	return 0;
+
+err_out:
+	platform_driver_unregister(&gpio_mockup_driver);
+	gpio_mockup_unregister_devices();
+	debugfs_remove_recursive(gpio_mockup_dbg_dir);
+	return err;
 }
 
 static void __exit gpio_mockup_exit(void)
 {
 	debugfs_remove_recursive(gpio_mockup_dbg_dir);
 	platform_driver_unregister(&gpio_mockup_driver);
-	gpio_mockup_unregister_pdevs();
+	gpio_mockup_unregister_devices();
 }
 
 module_init(gpio_mockup_init);
-- 
2.26.1

