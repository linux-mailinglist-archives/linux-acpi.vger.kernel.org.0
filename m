Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C465AF73B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2019 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfIKHwn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Sep 2019 03:52:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42695 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfIKHwd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Sep 2019 03:52:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so11098852pgb.9;
        Wed, 11 Sep 2019 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdTKaY3wA6DjyTzXunn2GDLjirzBeCjbyMCd9Q0RtXU=;
        b=kgtseBrKNduTLuDjbf+nnJfdWUe8R6hU2sBucrtHaER8AtaPZLffUBKQ7zr0QZJuqF
         oeoKniXWWDZK8gJzw9FSP/j5nBkubXBrI10oYeE9PVsotY487y5rDday1tQ328IofVUl
         uWk8sYrpOvYwH8lv+ejRqzLyqOwwf9AbKuGQxjPRq4ocGwj8vglWmt60hz/802ikWROk
         ZHwdjZR2Tm9qg9MzzgaIrR8fia5I0Cr/wazaDf5FAjoJz9/+HdUyeobTaW2DQMoHtqiD
         uD9Tqe+arzgxU8ab1jz9M8h0oa+UKpOpNdSZEQj7qWNIxKN7YMSOVqOHiqdmmAZdrItj
         mD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdTKaY3wA6DjyTzXunn2GDLjirzBeCjbyMCd9Q0RtXU=;
        b=G5bha0BY9oOWHVJ3FQYcmy3K3uZYknbUDF6CDkX+I2JKyVbaPU58RpaJ/3+MPs8/Jz
         I7MoCL8nF/4FFsxgbo9GBRd0MWk7/jiuXTsoqQQQ+HabDFeZDrNIz5PTbFRZc6XOoMV5
         QXYVwLHYx5ZpI/ycvMnI63ta2hMG+2uioj3jg4twIcmRpV7Lx6g8QouiC76YfFwHWE8S
         qpbdw6WBSA/zWMbWRdeR9/0FXCnu4h/KkOeZVkFLD8Rbr2LRAux6i3jw7/ouwye/qkbh
         q130/FF6S2yBCu6POZ5jt46jRIO+aaVfkbURzTytzlpB6dcfualV2fSVsrGzDRcdKsdP
         0IjA==
X-Gm-Message-State: APjAAAXEvZZCkhTG+4L8lYz6GGhTfPlL5gXIhRDhzZPdGcskWUoh772w
        4YhJGvKpfBm/4KxZknPQsFI=
X-Google-Smtp-Source: APXvYqxR5dIGPzXEbPMdcLUx9cMDAZtHeouY8WeRdC3/qhWi1953gvlbApVo01HjGtj0xBjIFP7bAw==
X-Received: by 2002:a17:90a:ac16:: with SMTP id o22mr4076730pjq.8.1568188351279;
        Wed, 11 Sep 2019 00:52:31 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u2sm8582445pgp.66.2019.09.11.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:52:30 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 10/11] gpiolib: consolidate fwnode GPIO lookups
Date:   Wed, 11 Sep 2019 00:52:14 -0700
Message-Id: <20190911075215.78047-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911075215.78047-1-dmitry.torokhov@gmail.com>
References: <20190911075215.78047-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ensure that all paths to obtain/look up GPIOD from generic
consumer-visible APIs go through the new fwnode_locate_gpiod(), so that
we can easily extend the support for new firmware mechanisms.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/gpio/gpiolib-acpi.c |  88 +++++++++++++++----------------
 drivers/gpio/gpiolib-acpi.h |  10 ----
 drivers/gpio/gpiolib.c      | 100 ++++++++++++------------------------
 3 files changed, 77 insertions(+), 121 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 8174db1bc02e..13907add5027 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -728,6 +728,50 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	return ret ? ERR_PTR(ret) : lookup.desc;
 }
 
+/**
+ * acpi_node_get_gpiod() - get a GPIO descriptor from ACPI resources
+ * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
+ * @propname: Property name of the GPIO
+ * @index: index of GpioIo/GpioInt resource (starting from %0)
+ * @info: info pointer to fill in (optional)
+ *
+ * If @fwnode is an ACPI device object, call acpi_get_gpiod_by_index() for it.
+ * Otherwise (i.e. it is a data-only non-device object), use the property-based
+ * GPIO lookup to get to the GPIO resource with the relevant information and use
+ * that to obtain the GPIO descriptor to return.
+ *
+ * If the GPIO cannot be translated or there is an error an ERR_PTR is
+ * returned.
+ */
+static struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
+					     const char *propname, int index,
+					     struct acpi_gpio_info *info)
+{
+	struct acpi_gpio_lookup lookup;
+	struct acpi_device *adev;
+	int ret;
+
+	adev = to_acpi_device_node(fwnode);
+	if (adev)
+		return acpi_get_gpiod_by_index(adev, propname, index, info);
+
+	if (!is_acpi_data_node(fwnode))
+		return ERR_PTR(-ENODEV);
+
+	if (!propname)
+		return ERR_PTR(-EINVAL);
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.index = index;
+
+	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = acpi_gpio_resource_lookup(&lookup, info);
+	return ret ? ERR_PTR(ret) : lookup.desc;
+}
+
 static int acpi_finalize_gpio_lookup(struct acpi_gpio_info *info,
 				     enum gpiod_flags *dflags,
 				     unsigned long *lookupflags)
@@ -815,50 +859,6 @@ struct gpio_desc *acpi_find_gpio_fallback(struct acpi_device *adev,
 	return desc;
 }
 
-/**
- * acpi_node_get_gpiod() - get a GPIO descriptor from ACPI resources
- * @fwnode: pointer to an ACPI firmware node to get the GPIO information from
- * @propname: Property name of the GPIO
- * @index: index of GpioIo/GpioInt resource (starting from %0)
- * @info: info pointer to fill in (optional)
- *
- * If @fwnode is an ACPI device object, call acpi_get_gpiod_by_index() for it.
- * Otherwise (i.e. it is a data-only non-device object), use the property-based
- * GPIO lookup to get to the GPIO resource with the relevant information and use
- * that to obtain the GPIO descriptor to return.
- *
- * If the GPIO cannot be translated or there is an error an ERR_PTR is
- * returned.
- */
-struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
-				      const char *propname, int index,
-				      struct acpi_gpio_info *info)
-{
-	struct acpi_gpio_lookup lookup;
-	struct acpi_device *adev;
-	int ret;
-
-	adev = to_acpi_device_node(fwnode);
-	if (adev)
-		return acpi_get_gpiod_by_index(adev, propname, index, info);
-
-	if (!is_acpi_data_node(fwnode))
-		return ERR_PTR(-ENODEV);
-
-	if (!propname)
-		return ERR_PTR(-EINVAL);
-
-	memset(&lookup, 0, sizeof(lookup));
-	lookup.index = index;
-
-	ret = acpi_gpio_property_lookup(fwnode, propname, index, &lookup);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = acpi_gpio_resource_lookup(&lookup, info);
-	return ret ? ERR_PTR(ret) : lookup.desc;
-}
-
 /**
  * acpi_dev_gpio_irq_get() - Find GpioInt and translate it to Linux IRQ number
  * @adev: pointer to a ACPI device to get IRQ from
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index ea97a3822116..047df1d5c7fa 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -53,10 +53,6 @@ struct gpio_desc *acpi_find_gpio_fallback(struct acpi_device *adev,
 					  unsigned int idx,
 					  enum gpiod_flags *dflags,
 					  unsigned long *lookupflags);
-struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
-				      const char *propname, int index,
-				      struct acpi_gpio_info *info);
-
 int acpi_gpio_count(struct device *dev, const char *con_id);
 #else
 static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
@@ -94,12 +90,6 @@ acpi_find_gpio_fallback(struct acpi_device *adev, const char *con_id,
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline struct gpio_desc *
-acpi_node_get_gpiod(struct fwnode_handle *fwnode, const char *propname,
-		    int index, struct acpi_gpio_info *info)
-{
-	return ERR_PTR(-ENXIO);
-}
 static inline int acpi_gpio_count(struct device *dev, const char *con_id)
 {
 	return -ENODEV;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 2d8dd67ab03d..6534dcd6e406 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4314,44 +4314,27 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 	return count;
 }
 
-static struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-						const char *propname, int index,
-						enum gpiod_flags dflags,
-						const char *label)
+static struct gpio_desc *fwnode_locate_gpiod(struct fwnode_handle *fwnode,
+					     struct device *dev,
+					     const char *con_id, int idx,
+					     enum gpiod_flags *flags,
+					     unsigned long *lookupflags)
 {
-	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
 	struct gpio_desc *desc = ERR_PTR(-ENODEV);
-	int ret;
-
-	if (!fwnode)
-		return ERR_PTR(-EINVAL);
 
 	if (is_of_node(fwnode)) {
-		desc = gpiod_get_from_of_node(to_of_node(fwnode),
-					      propname, index,
-					      dflags,
-					      label);
-		return desc;
+		dev_dbg(dev, "using device tree for GPIO lookup\n");
+		desc = of_find_gpio(fwnode, con_id, idx, lookupflags);
+		if (desc == ERR_PTR(-ENOENT) && dev)
+			desc = of_find_gpio_fallback(dev, con_id, idx,
+						     lookupflags);
 	} else if (is_acpi_node(fwnode)) {
-		struct acpi_gpio_info info;
-
-		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
-		if (IS_ERR(desc))
-			return desc;
-
-		acpi_gpio_update_gpiod_flags(&dflags, &info);
-		acpi_gpio_update_gpiod_lookup_flags(&lflags, &info);
-	}
-
-	/* Currently only ACPI takes this path */
-	ret = gpiod_request(desc, label);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
-	if (ret < 0) {
-		gpiod_put(desc);
-		return ERR_PTR(ret);
+		dev_dbg(dev, "using ACPI for GPIO lookup\n");
+		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
+		if (desc == ERR_PTR(-ENOENT) && dev)
+			desc = acpi_find_gpio_fallback(ACPI_COMPANION(dev),
+						       con_id, idx,
+						       flags, lookupflags);
 	}
 
 	return desc;
@@ -4383,22 +4366,23 @@ struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 enum gpiod_flags flags,
 					 const char *label)
 {
+	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
 	struct gpio_desc *desc;
-	char prop_name[32]; /* 32 is max size of property name */
-	unsigned int i;
+	int error;
 
-	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
-		if (con_id)
-			snprintf(prop_name, sizeof(prop_name), "%s-%s",
-					    con_id, gpio_suffixes[i]);
-		else
-			snprintf(prop_name, sizeof(prop_name), "%s",
-					    gpio_suffixes[i]);
+	desc = fwnode_locate_gpiod(fwnode, NULL, con_id, index,
+				   &flags, &lookupflags);
+	if (IS_ERR(desc))
+		return desc;
 
-		desc = fwnode_get_named_gpiod(fwnode, prop_name, index, flags,
-					      label);
-		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
-			break;
+	error = gpiod_request(desc, label);
+	if (error)
+		return ERR_PTR(error);
+
+	error = gpiod_configure_flags(desc, con_id, lookupflags, flags);
+	if (error < 0) {
+		gpiod_put(desc);
+		return ERR_PTR(error);
 	}
 
 	return desc;
@@ -4558,27 +4542,9 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 
 	dev_dbg(dev, "GPIO lookup for consumer %s\n", con_id);
 
-	if (dev) {
-		/* Using device tree? */
-		if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
-			dev_dbg(dev, "using device tree for GPIO lookup\n");
-			desc = of_find_gpio(dev_fwnode(dev),
-					    con_id, idx, &lookupflags);
-			if (desc == ERR_PTR(-ENOENT))
-				desc = of_find_gpio_fallback(dev, con_id, idx,
-							     &lookupflags);
-
-		} else if (ACPI_COMPANION(dev)) {
-			dev_dbg(dev, "using ACPI for GPIO lookup\n");
-			desc = acpi_find_gpio(dev_fwnode(dev), con_id, idx,
-					      &flags, &lookupflags);
-			if (desc == ERR_PTR(-ENOENT))
-				desc = acpi_find_gpio_fallback(
-						ACPI_COMPANION(dev),
-						con_id, idx,
-						&flags, &lookupflags);
-		}
-	}
+	if (dev)
+		desc = fwnode_locate_gpiod(dev_fwnode(dev), dev, con_id, idx,
+					   &flags, &lookupflags);
 
 	/*
 	 * Either we are not using DT or ACPI, or their lookup did not return
-- 
2.23.0.162.g0b9fbb3734-goog

