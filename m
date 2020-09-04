Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4768C25DE3A
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgIDPsJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgIDPrb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:47:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12110C06123A
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so7184318wrm.9
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grMpfwJBPKz8x8JwdVkKa3ogOmUgQ5L3HbriAAtXMOE=;
        b=T29hggUBZSkRV9pQbFKSYoyB5ydrOKR+eklkTQqELriqTYpxPUnHKrAQ5JKk0Op74Q
         DCxlFEGrV8egWnu5H/c03dcSHHYXjjtqm8rjAsFcvt8PJHS4qak+49XcjgQgBcjgMiI8
         qIDpYQbwqZE2cgT0bB0aDZPqm12ei0JuBbnIxH43DhRDxfoh/lX2p3N0pYHOzXJyZ1Q/
         Q4s6DClwAfE/qxdvNwJgGGMk1CJwX6CFhO4oRx/5G5B4T22zAxPoaWisGxGE1YFintKM
         ACUm9cOFgKwYlDa0KUtbdHlwxYdxWEiIki7K6drA8WjMT3VnCj12hhleiJbWcgTF2y0N
         lMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grMpfwJBPKz8x8JwdVkKa3ogOmUgQ5L3HbriAAtXMOE=;
        b=sB+jrRuRaQUztLK/ed3ASGIrhz001Bx4WSoUJGZs63nIGzMwWa4OANL/v6zhzkQZoP
         OvpVXU73DuOU1SB3FSp2rzamoy6q2OORHjJVT40blk7kUz7n4PwKGgS5dBNT0Yx7GNUK
         1dEARXLqhvVTCwW4y9LMJPzJEA+2byZSzLKLoHT5eI9/CpB+RxDHts6yhEGXGKN+lSAG
         nMZZFPQ0VWpTBRkldzJ1dzQwlkHA7dxZerNZ+gi3+S/YeRzoJUvL2f3hDXXKhLtYEOiK
         B8zAA86C7v0rjxo1n2wZT2OutTMDjah4+VCHaFJwz9ftqjw3eKErcfJ0smxweuKgEh87
         zIPw==
X-Gm-Message-State: AOAM532AXdMcsKWAvu+xCg7UveICQZ9K7MJkOwH5nmM46zlptAzFwKLv
        mw00R8UdrSjmPZsWtFzmiKbKR2qgMvwmkw==
X-Google-Smtp-Source: ABdhPJwF/TdbSD80yVhLNOeAq70EYhl8a4L44K/4AYYY/Rbp36+YEs1GetDpBBcfGubtwwMDMcnZNA==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr8803147wro.178.1599234415760;
        Fri, 04 Sep 2020 08:46:55 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 21/23] gpio: mockup: provide a way to delete dummy chips
Date:   Fri,  4 Sep 2020 17:45:45 +0200
Message-Id: <20200904154547.3836-22-brgl@bgdev.pl>
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

Add a new debugfs attribute 'delete_device' to which the chip label can
be written to dynamically remove the associated dummy device.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 70 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 1353239dc315..9d2de78a45c2 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
 
@@ -668,14 +669,81 @@ static int __init gpio_mockup_register_chips_from_params(void)
 	return 0;
 }
 
-static int __init gpio_mockup_init(void)
+static ssize_t gpio_mockup_debugfs_delete_device_write(struct file *file,
+						const char __user *usr_buf,
+						size_t size, loff_t *ppos)
 {
+	struct gpio_mockup_device *mockup_dev;
+	char label[GPIO_MOCKUP_LABEL_SIZE];
+	struct list_head *curr;
+	struct device *dev;
+	const char *prop;
 	int ret;
 
+	if (*ppos != 0)
+		return -EINVAL;
+
+	ret = getline_from_user(label, sizeof(label), usr_buf, size);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&gpio_mockup_devices_lock);
+
+	list_for_each(curr, &gpio_mockup_devices) {
+		mockup_dev = list_entry(curr, struct gpio_mockup_device, list);
+		dev = &mockup_dev->pdev->dev;
+
+		ret = device_property_read_string(dev, "chip-label", &prop);
+		if (ret) {
+			mutex_unlock(&gpio_mockup_devices_lock);
+			return ret;
+		}
+
+		if (sysfs_streq(label, prop)) {
+			gpio_mockup_unregister_one_device(mockup_dev);
+			mutex_unlock(&gpio_mockup_devices_lock);
+			return size;
+		}
+	}
+
+	mutex_unlock(&gpio_mockup_devices_lock);
+	return -ENODEV;
+}
+
+static const struct file_operations gpio_mockup_debugfs_delete_device_ops = {
+	.owner = THIS_MODULE,
+	.open = gpio_mockup_debugfs_open,
+	.write = gpio_mockup_debugfs_delete_device_write,
+	.llseek = no_llseek,
+	.release = single_release,
+};
+
+static int __init gpio_mockup_debugfs_init(void)
+{
+	struct dentry *entry;
+
 	gpio_mockup_dbg_dir = debugfs_create_dir("gpio-mockup", NULL);
 	if (IS_ERR(gpio_mockup_dbg_dir))
 		return PTR_ERR(gpio_mockup_dbg_dir);
 
+	entry = debugfs_create_file("delete_device", 0200, gpio_mockup_dbg_dir,
+				NULL, &gpio_mockup_debugfs_delete_device_ops);
+	if (IS_ERR(entry)) {
+		debugfs_remove_recursive(gpio_mockup_dbg_dir);
+		return PTR_ERR(entry);
+	}
+
+	return 0;
+}
+
+static int __init gpio_mockup_init(void)
+{
+	int ret;
+
+	ret = gpio_mockup_debugfs_init();
+	if (ret)
+		return ret;
+
 	ret = platform_driver_register(&gpio_mockup_driver);
 	if (ret) {
 		pr_err("error registering platform driver\n");
-- 
2.26.1

