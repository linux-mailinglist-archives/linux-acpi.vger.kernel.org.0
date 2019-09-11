Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE47AF734
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2019 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfIKHwc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Sep 2019 03:52:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46852 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfIKHwb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Sep 2019 03:52:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so13125535pfg.13;
        Wed, 11 Sep 2019 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d8sM5opJG43/oMJGd+vUXu/Jf8ktApOUdWkyRE4vC5g=;
        b=iUhv4bg3cE1uGHcMOYuOTmdVGsImmIkPPep1vYlZ4RhzFawuGGh9f6dWWYSS/53kGI
         zb8+VfBu65TDA3DAO3Wp7dT5Pn4nF+Lf8nj6VZ4kzoDEVXepQzoiqckC0sF3iT6erMn2
         +NaI4jVunVvszbv8q5QkoXwJH27QgGZKlF/fOI1tD7L44SLU7v7rEhPQb9niFVYZaFFI
         FM0SS1byvAMdEuIQCyazmpCmgEwRDCmV2h/qIlb05puVtmXU8+brjhW1tUGEJBCbD2m5
         A909GBidewWRna3xU/P+P9Rm3rwddIemGU2b8YCry45zGe1lMwRhjleC5A4Nwp16BMt/
         o4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d8sM5opJG43/oMJGd+vUXu/Jf8ktApOUdWkyRE4vC5g=;
        b=JA56flA8JLnMbhQOd8+YjCuiWhgDvn6yqz/SAz3DrqynpcvWaBlWA8rJhRTFNPyn0s
         U0Bjgdrj7tEuajHaKB1caP4wSuaebDfq/pbwGoocaG7sVh47Ak+ffJYMwaNYGcWhIcaK
         yZl/8I6s+TrArahD+iizvNAjOfrbd04M37Bz3sq9au+cSbQh+qt67aJt+SQZTTh6C8fl
         jO/evqT/OO+O8yKQb4Kry/Nc1S87/cN9jVfnn+vb/8+8p3DFJoKTQ8h9DlpmXb57A/fs
         10wJvFx0iHiLJbgccXJo/QClp8gS27/tI0SfICBlLNqAMlWvt1UApjYBhz+7TsmO6Uyw
         ajsA==
X-Gm-Message-State: APjAAAXIhHt6SoyQWlSnEqF4MJBKar4DnaLyGn9nRJ4fmd39yuoHrdEO
        O9R2orLLvjelZGpjUhPOXLg=
X-Google-Smtp-Source: APXvYqx4yStbx4hEG2ye41cPbuNrASmOr85tSU1M+GTgDe4ihmdbWBxnZX0I3Y6aNRnhBe8axC7v1Q==
X-Received: by 2002:a63:6f8f:: with SMTP id k137mr31567108pgc.90.1568188350163;
        Wed, 11 Sep 2019 00:52:30 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id u2sm8582445pgp.66.2019.09.11.00.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 00:52:29 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH 09/11] gpiolib: of: tease apart acpi_find_gpio()
Date:   Wed, 11 Sep 2019 00:52:13 -0700
Message-Id: <20190911075215.78047-10-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
In-Reply-To: <20190911075215.78047-1-dmitry.torokhov@gmail.com>
References: <20190911075215.78047-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tease apart acpi_find_gpio() into common function that works on the
firmware node, and a fallback handler that works on the ACPI device
structure, so that we can later use acpi_find_gpio() in
fwnode_gpiod_get_index().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 drivers/gpio/gpiolib-acpi.c | 77 +++++++++++++++++++++++++------------
 drivers/gpio/gpiolib-acpi.h | 17 +++++++-
 drivers/gpio/gpiolib.c      |  8 +++-
 3 files changed, 74 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2b6fdc9947f7..8174db1bc02e 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -728,29 +728,35 @@ static struct gpio_desc *acpi_get_gpiod_by_index(struct acpi_device *adev,
 	return ret ? ERR_PTR(ret) : lookup.desc;
 }
 
-static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
-				     const char *con_id)
+static int acpi_finalize_gpio_lookup(struct acpi_gpio_info *info,
+				     enum gpiod_flags *dflags,
+				     unsigned long *lookupflags)
 {
-	/* Never allow fallback if the device has properties */
-	if (acpi_dev_has_props(adev) || adev->driver_gpios)
-		return false;
+	if (info->gpioint &&
+	    (*dflags == GPIOD_OUT_LOW || *dflags == GPIOD_OUT_HIGH)) {
+		dev_dbg(&info->adev->dev,
+			"refusing GpioInt() entry when doing GPIOD_OUT_* lookup\n");
+		return -ENOENT;
+	}
 
-	return con_id == NULL;
+	acpi_gpio_update_gpiod_flags(dflags, info);
+	acpi_gpio_update_gpiod_lookup_flags(lookupflags, info);
+
+	return 0;
 }
 
-struct gpio_desc *acpi_find_gpio(struct device *dev,
-				 const char *con_id,
-				 unsigned int idx,
+struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
+				 const char *con_id, unsigned int idx,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags)
 {
-	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
 	char propname[32];
 	int i;
+	int error;
 
-	/* Try first from _DSD */
+	/* Try GPIOs from _DSD */
 	for (i = 0; i < ARRAY_SIZE(gpio_suffixes); i++) {
 		if (con_id) {
 			snprintf(propname, sizeof(propname), "%s-%s",
@@ -760,31 +766,52 @@ struct gpio_desc *acpi_find_gpio(struct device *dev,
 				 gpio_suffixes[i]);
 		}
 
-		desc = acpi_get_gpiod_by_index(adev, propname, idx, &info);
+		desc = acpi_node_get_gpiod(fwnode, propname, idx, &info);
 		if (!IS_ERR(desc))
 			break;
 		if (PTR_ERR(desc) == -EPROBE_DEFER)
 			return ERR_CAST(desc);
 	}
 
-	/* Then from plain _CRS GPIOs */
-	if (IS_ERR(desc)) {
-		if (!acpi_can_fallback_to_crs(adev, con_id))
-			return ERR_PTR(-ENOENT);
-
-		desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
-		if (IS_ERR(desc))
-			return desc;
+	if (!IS_ERR(desc)) {
+		error = acpi_finalize_gpio_lookup(&info, dflags, lookupflags);
+		if (error)
+			return ERR_PTR(error);
 	}
 
-	if (info.gpioint &&
-	    (*dflags == GPIOD_OUT_LOW || *dflags == GPIOD_OUT_HIGH)) {
-		dev_dbg(dev, "refusing GpioInt() entry when doing GPIOD_OUT_* lookup\n");
+	return desc;
+}
+
+static bool acpi_can_fallback_to_crs(struct acpi_device *adev,
+				     const char *con_id)
+{
+	/* Never allow fallback if the device has properties */
+	if (acpi_dev_has_props(adev) || adev->driver_gpios)
+		return false;
+
+	return con_id == NULL;
+}
+
+struct gpio_desc *acpi_find_gpio_fallback(struct acpi_device *adev,
+					  const char *con_id, unsigned int idx,
+					  enum gpiod_flags *dflags,
+					  unsigned long *lookupflags)
+{
+	struct acpi_gpio_info info;
+	struct gpio_desc *desc;
+	int error;
+
+	/* Then from plain _CRS GPIOs */
+	if (!acpi_can_fallback_to_crs(adev, con_id))
 		return ERR_PTR(-ENOENT);
+
+	desc = acpi_get_gpiod_by_index(adev, NULL, idx, &info);
+	if (!IS_ERR(desc)) {
+		error = acpi_finalize_gpio_lookup(&info, dflags, lookupflags);
+		if (error)
+			return ERR_PTR(error);
 	}
 
-	acpi_gpio_update_gpiod_flags(dflags, &info);
-	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
 	return desc;
 }
 
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 1c6d65cf0629..ea97a3822116 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -9,6 +9,7 @@
 #define GPIOLIB_ACPI_H
 
 struct acpi_device;
+struct fwnode_handle;
 
 /**
  * struct acpi_gpio_info - ACPI GPIO specific information
@@ -42,11 +43,16 @@ int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
 int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 					struct acpi_gpio_info *info);
 
-struct gpio_desc *acpi_find_gpio(struct device *dev,
+struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 				 const char *con_id,
 				 unsigned int idx,
 				 enum gpiod_flags *dflags,
 				 unsigned long *lookupflags);
+struct gpio_desc *acpi_find_gpio_fallback(struct acpi_device *adev,
+					  const char *con_id,
+					  unsigned int idx,
+					  enum gpiod_flags *dflags,
+					  unsigned long *lookupflags);
 struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 				      const char *propname, int index,
 				      struct acpi_gpio_info *info);
@@ -75,13 +81,20 @@ acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 }
 
 static inline struct gpio_desc *
-acpi_find_gpio(struct device *dev, const char *con_id,
+acpi_find_gpio(struct firmware_node *fwnode, const char *con_id,
 	       unsigned int idx, enum gpiod_flags *dflags,
 	       unsigned long *lookupflags)
 {
 	return ERR_PTR(-ENOENT);
 }
 static inline struct gpio_desc *
+acpi_find_gpio_fallback(struct acpi_device *adev, const char *con_id,
+			unsigned int idx, enum gpiod_flags *dflags,
+			unsigned long *lookupflags)
+{
+	return ERR_PTR(-ENOENT);
+}
+static inline struct gpio_desc *
 acpi_node_get_gpiod(struct fwnode_handle *fwnode, const char *propname,
 		    int index, struct acpi_gpio_info *info)
 {
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 1248e61f9a23..2d8dd67ab03d 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4570,7 +4570,13 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 
 		} else if (ACPI_COMPANION(dev)) {
 			dev_dbg(dev, "using ACPI for GPIO lookup\n");
-			desc = acpi_find_gpio(dev, con_id, idx, &flags, &lookupflags);
+			desc = acpi_find_gpio(dev_fwnode(dev), con_id, idx,
+					      &flags, &lookupflags);
+			if (desc == ERR_PTR(-ENOENT))
+				desc = acpi_find_gpio_fallback(
+						ACPI_COMPANION(dev),
+						con_id, idx,
+						&flags, &lookupflags);
 		}
 	}
 
-- 
2.23.0.162.g0b9fbb3734-goog

