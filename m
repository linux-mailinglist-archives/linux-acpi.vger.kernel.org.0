Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177F525DE3E
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIDPsI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgIDPre (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 11:47:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB3C0619EA
        for <linux-acpi@vger.kernel.org>; Fri,  4 Sep 2020 08:46:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so6484118wmc.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3aWcm+3JDeJZmE6xtJBDfj0eVLxqNfoBKt8HcdF/1EE=;
        b=CZAvReeuXtd9ZK1t6qgNO75jV6xJlnEXljI4/mnHXpsbq7PxgUPsIC86O2hC0U6rgr
         HGHHIc7tvF/BzZmibkMHYfVKfSiGyR7I0RPNsAB1PY0GSy55ZcCS0Z57NQoFapTJ4LSY
         eafgxUJWblDraafe/Vzru3THELlnIIlm9wJltqiYWF7zS8/ZdjgdqhJ3UI2LPXHNtjQC
         ReTu3FLqRuYrH1XJk5i5MP4EwGTp9sBq+5edDyShrTWEcPqUJ8ItX+22ARKmIoDZksfD
         qHa5OwNLhRuLopdaxi4K7dPnWataLNsZBy3/HbfxRTZVHevoU8J84X38CmWddi3Tsz5P
         eqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3aWcm+3JDeJZmE6xtJBDfj0eVLxqNfoBKt8HcdF/1EE=;
        b=R4mF9vEdjMAd5JPlhw2yVisZVh6Il3JQr92uk2ZBXihRORfpVOeznbzQJ7RGlVYssL
         0WafNDQxbqmrrqAiz0UlS5QuL00JHAHVMwLb/R70qcVoieE3XnBOtwd0nfyUUcFh++ht
         7pmMoaMw2MS+oE1Gzdj79KMWz5jee5j2tNPWRwBtNzZ8We2lCJbYRVodck1DthNP5UKT
         7s8P6bk7fGFc2hmqd8TlijnRXOCy7mtO1V/Rj7HgFxIR3bY+e9Mdzz5O9QdADDBBJH5P
         SqZZdKf/5gQNB5hhe2vALcOFGbmaIec6XFxFiqEr90jZECDl24hrNhTI65+OZK7W8nTQ
         y+qA==
X-Gm-Message-State: AOAM5313hNLrKDxzha7tcfgzVDXlzhZxtgrD8y2wPIAqZ8prrEwBcrKl
        BZEtbkUaw+Riejdv/i+2TD4x3g==
X-Google-Smtp-Source: ABdhPJxw9xJK0XTZm5xxkM2ONzghwfamibziq3gwrnxN4MBR3VhmxObh/FITueCXATZQmz5tZAHJWg==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr8800011wmb.54.1599234416977;
        Fri, 04 Sep 2020 08:46:56 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id q4sm11983375wru.65.2020.09.04.08.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:46:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 22/23] gpio: mockup: provide a way to create new dummy chips
Date:   Fri,  4 Sep 2020 17:45:46 +0200
Message-Id: <20200904154547.3836-23-brgl@bgdev.pl>
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

Add a new debugfs attribute 'new_device' that allows to dynamically
create new dummy chips according to specification.

New chips are created by writing a number of supported parameters to the
new attribute of which 'label' and 'num_lines' are mandatory. The new
attribute is designed to be easily exstensible with new parameters. For
now we simply provide the same functionality that the module params
expose but with the intention of introducing new options (such as custom
line name formats).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c | 231 +++++++++++++++++++++++++++++++++++--
 1 file changed, 220 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index 9d2de78a45c2..6577d18671df 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2014  Kamlakant Patel <kamlakant.patel@broadcom.com>
  * Copyright (C) 2015-2016  Bamvor Jian Zhang <bamv2005@gmail.com>
  * Copyright (C) 2017 Bartosz Golaszewski <brgl@bgdev.pl>
+ * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
 #include <linux/debugfs.h>
@@ -14,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irqdomain.h>
+#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -546,8 +548,8 @@ static void gpio_mockup_unregister_devices(void)
 	mutex_unlock(&gpio_mockup_devices_lock);
 }
 
-static __init char **gpio_mockup_make_line_names(const char *label,
-						 unsigned int num_lines)
+static char **gpio_mockup_make_line_names(const char *label,
+					  unsigned int num_lines)
 {
 	unsigned int i;
 	char **names;
@@ -567,7 +569,7 @@ static __init char **gpio_mockup_make_line_names(const char *label,
 	return names;
 }
 
-static int __init gpio_mockup_register_device(struct property_entry *properties)
+static int gpio_mockup_register_device(struct property_entry *properties)
 {
 	struct gpio_mockup_device *mockup_dev;
 	struct platform_device_info pdevinfo;
@@ -641,8 +643,7 @@ static int __init gpio_mockup_register_chips_from_params(void)
 {
 	int num_chips, i, ret;
 
-	if ((gpio_mockup_num_ranges < 2) ||
-	    (gpio_mockup_num_ranges % 2) ||
+	if ((gpio_mockup_num_ranges % 2) ||
 	    (gpio_mockup_num_ranges > GPIO_MOCKUP_MAX_RANGES))
 		return -EINVAL;
 
@@ -669,6 +670,205 @@ static int __init gpio_mockup_register_chips_from_params(void)
 	return 0;
 }
 
+/*
+ * We store all data associated with device properties in this structure. It's
+ * only needed until we register the platform device at which point the driver
+ * core makes a deep copy of all property data (even the string arrays).
+ *
+ * The reason to keep them bunched up is simple: we can have a single function
+ * to free all resources which simplifies error handling.
+ */
+struct gpio_mockup_prop_data {
+	char chip_label[GPIO_MOCKUP_LABEL_SIZE];
+	u16 ngpio;
+	bool named_lines;
+	char **line_names;
+};
+
+/* We don't free the structure itself - it's expected to live on the stack. */
+static void
+gpio_mockup_free_property_data(struct gpio_mockup_prop_data *prop_data)
+{
+	kfree_strarray(prop_data->line_names, prop_data->ngpio);
+}
+
+/*
+ * Each supported option is parsed by a separate callback - this way the
+ * 'new_device' attribute is easily exstensible.
+ */
+struct gpio_mockup_new_device_opt {
+	char *name;
+	int (*func)(const char *val, struct gpio_mockup_prop_data *prop_data,
+		    struct property_entry *properties, int *prop_idx);
+	bool has_val;
+};
+
+static int
+gpio_mockup_parse_label(const char *val,
+		struct gpio_mockup_prop_data *prop_data,
+		struct property_entry *properties, int *prop_idx)
+{
+	snprintf(prop_data->chip_label, sizeof(prop_data->chip_label), val);
+	properties[(*prop_idx)++] =
+		PROPERTY_ENTRY_STRING("chip-label", prop_data->chip_label);
+
+	return 0;
+}
+
+static int gpio_mockup_parse_num_lines(const char *val,
+			struct gpio_mockup_prop_data *prop_data,
+			struct property_entry *properties, int *prop_idx)
+{
+	int ret;
+
+	ret = kstrtou16(val, 10, &prop_data->ngpio);
+	if (ret) {
+		pr_err("invalid new_lines format: %s\n", val);
+		return ret;
+	}
+
+	properties[(*prop_idx)++] = PROPERTY_ENTRY_U16("nr-gpios",
+						     prop_data->ngpio);
+
+	return 0;
+}
+
+static int gpio_mockup_parse_named_lines(const char *val,
+			struct gpio_mockup_prop_data *prop_data,
+			struct property_entry *properties, int *prop_idx)
+{
+	prop_data->named_lines = true;
+
+	return 0;
+}
+
+static struct gpio_mockup_new_device_opt gpio_mockup_new_device_opts[] = {
+	{
+		.name = "label",
+		.func = gpio_mockup_parse_label,
+		.has_val = true,
+	},
+	{
+		.name = "num_lines",
+		.func = gpio_mockup_parse_num_lines,
+		.has_val = true,
+	},
+	{
+		.name = "named_lines",
+		.func = gpio_mockup_parse_named_lines,
+		.has_val = false,
+	},
+};
+
+static int
+gpio_mockup_parse_one_opt(const char *key, const char *val,
+			  struct gpio_mockup_prop_data *prop_data,
+			  struct property_entry *properties, int *prop_idx)
+{
+	struct gpio_mockup_new_device_opt *opt;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(gpio_mockup_new_device_opts); i++) {
+		opt = &gpio_mockup_new_device_opts[i];
+
+		if (strcmp(key, opt->name) == 0) {
+			if (opt->has_val && !val) {
+				pr_err("%s option requires an argument\n",
+				       opt->name);
+				return -EINVAL;
+			}
+
+			if (!opt->has_val && val) {
+				pr_err("%s option doesn't take any arguments\n",
+				       opt->name);
+				return -EINVAL;
+			}
+
+			return opt->func(val, prop_data, properties, prop_idx);
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int
+gpio_mockup_new_device_from_opts(char *opts,
+				 struct gpio_mockup_prop_data *prop_data)
+{
+	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
+	int prop_idx = 0, ret;
+	char *key, *val;
+
+	memset(properties, 0, sizeof(properties));
+
+	while (*opts) {
+		if (prop_idx >= GPIO_MOCKUP_MAX_PROP)
+			return -EINVAL;
+
+		opts = next_arg(opts, &key, &val);
+
+		ret = gpio_mockup_parse_one_opt(key, val, prop_data,
+						properties, &prop_idx);
+		if (ret)
+			return ret;
+	}
+
+	/* This is the only mandatory property. */
+	if (!prop_data->ngpio) {
+		pr_err("number of lines must be specified\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Line names must be created at the end - once we know how
+	 * many GPIOs there are.
+	 */
+	if (prop_data->named_lines) {
+		prop_data->line_names = gpio_mockup_make_line_names(
+							prop_data->chip_label,
+							prop_data->ngpio);
+		if (!prop_data->line_names)
+			return -ENOMEM;
+
+		properties[prop_idx++] =
+			PROPERTY_ENTRY_STRING_ARRAY_LEN("gpio-line-names",
+							prop_data->line_names,
+							prop_data->ngpio);
+	}
+
+	return gpio_mockup_register_device(properties);
+}
+
+static ssize_t gpio_mockup_debugfs_new_device_write(struct file *file,
+						    const char __user *usr_buf,
+						    size_t size, loff_t *ppos)
+{
+	struct gpio_mockup_prop_data prop_data;
+	char opts[128];
+	int ret;
+
+	if (*ppos != 0 || size > sizeof(opts))
+		return -EINVAL;
+
+	ret = getline_from_user(opts, sizeof(opts), usr_buf, size);
+	if (ret < 0)
+		return ret;
+
+	memset(&prop_data, 0, sizeof(prop_data));
+
+	ret = gpio_mockup_new_device_from_opts(opts, &prop_data);
+	gpio_mockup_free_property_data(&prop_data);
+	return ret < 0 ? ret : size;
+}
+
+static const struct file_operations gpio_mockup_debugfs_new_device_ops = {
+	.owner = THIS_MODULE,
+	.open = gpio_mockup_debugfs_open,
+	.write = gpio_mockup_debugfs_new_device_write,
+	.llseek = no_llseek,
+	.release = single_release,
+};
+
 static ssize_t gpio_mockup_debugfs_delete_device_write(struct file *file,
 						const char __user *usr_buf,
 						size_t size, loff_t *ppos)
@@ -726,6 +926,13 @@ static int __init gpio_mockup_debugfs_init(void)
 	if (IS_ERR(gpio_mockup_dbg_dir))
 		return PTR_ERR(gpio_mockup_dbg_dir);
 
+	entry = debugfs_create_file("new_device", 0200, gpio_mockup_dbg_dir,
+				NULL, &gpio_mockup_debugfs_new_device_ops);
+	if (IS_ERR(entry)) {
+		debugfs_remove_recursive(gpio_mockup_dbg_dir);
+		return PTR_ERR(entry);
+	}
+
 	entry = debugfs_create_file("delete_device", 0200, gpio_mockup_dbg_dir,
 				NULL, &gpio_mockup_debugfs_delete_device_ops);
 	if (IS_ERR(entry)) {
@@ -751,12 +958,14 @@ static int __init gpio_mockup_init(void)
 		return ret;
 	}
 
-	ret = gpio_mockup_register_chips_from_params();
-	if (ret) {
-		pr_err("error registering device");
-		debugfs_remove_recursive(gpio_mockup_dbg_dir);
-		platform_driver_unregister(&gpio_mockup_driver);
-		return ret;
+	if (gpio_mockup_ranges > 0) {
+		ret = gpio_mockup_register_chips_from_params();
+		if (ret) {
+			pr_err("error registering device");
+			debugfs_remove_recursive(gpio_mockup_dbg_dir);
+			platform_driver_unregister(&gpio_mockup_driver);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.26.1

