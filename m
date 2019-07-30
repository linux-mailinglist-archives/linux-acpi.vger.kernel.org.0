Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47D117A629
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2019 12:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfG3Knl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 06:43:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:56040 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfG3Knl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jul 2019 06:43:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 03:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="200119611"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2019 03:43:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBE9E42; Tue, 30 Jul 2019 13:43:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] gpiolib: acpi: Split ACPI stuff to gpiolib-acpi.h
Date:   Tue, 30 Jul 2019 13:43:36 +0300
Message-Id: <20190730104337.21235-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com>
References: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a follow up to the commit

  f626d6dfb709 ("gpio: of: Break out OF-only code")

which broke down OF parts of GPIO library. Here we do the similar to ACPI.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: Cc to ACPI people
 drivers/gpio/gpio-dwapb.c    |   1 +
 drivers/gpio/gpio-mb86s7x.c  |   1 +
 drivers/gpio/gpio-xgene-sb.c |   1 +
 drivers/gpio/gpiolib-acpi.c  |   1 +
 drivers/gpio/gpiolib-acpi.h  | 104 +++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c       |   1 +
 drivers/gpio/gpiolib.h       |  93 -------------------------------
 7 files changed, 109 insertions(+), 93 deletions(-)
 create mode 100644 drivers/gpio/gpiolib-acpi.h

diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 3108be5e208c..92e127e74813 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 
 #include "gpiolib.h"
+#include "gpiolib-acpi.h"
 
 #define GPIO_SWPORTA_DR		0x00
 #define GPIO_SWPORTA_DDR	0x04
diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 8f466993cd24..501e89548f53 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 
 #include "gpiolib.h"
+#include "gpiolib-acpi.h"
 
 /*
  * Only first 8bits of a register correspond to each pin,
diff --git a/drivers/gpio/gpio-xgene-sb.c b/drivers/gpio/gpio-xgene-sb.c
index 38c01912c7b2..25d86441666e 100644
--- a/drivers/gpio/gpio-xgene-sb.c
+++ b/drivers/gpio/gpio-xgene-sb.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 
 #include "gpiolib.h"
+#include "gpiolib-acpi.h"
 
 /* Common property names */
 #define XGENE_NIRQ_PROPERTY		"apm,nr-irqs"
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 39f2f9035c11..d54fc6e7c8a9 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -18,6 +18,7 @@
 #include <linux/pinctrl/pinctrl.h>
 
 #include "gpiolib.h"
+#include "gpiolib-acpi.h"
 
 /**
  * struct acpi_gpio_event - ACPI GPIO event handler data
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
new file mode 100644
index 000000000000..d7241b432b8b
--- /dev/null
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ACPI helpers for GPIO API
+ *
+ * Copyright (C) 2012,2019 Intel Corporation
+ */
+
+#ifndef GPIOLIB_ACPI_H
+#define GPIOLIB_ACPI_H
+
+struct acpi_device;
+
+/**
+ * struct acpi_gpio_info - ACPI GPIO specific information
+ * @adev: reference to ACPI device which consumes GPIO resource
+ * @flags: GPIO initialization flags
+ * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
+ * @pin_config: pin bias as provided by ACPI
+ * @polarity: interrupt polarity as provided by ACPI
+ * @triggering: triggering type as provided by ACPI
+ * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
+ */
+struct acpi_gpio_info {
+	struct acpi_device *adev;
+	enum gpiod_flags flags;
+	bool gpioint;
+	int pin_config;
+	int polarity;
+	int triggering;
+	unsigned int quirks;
+};
+
+#ifdef CONFIG_ACPI
+void acpi_gpiochip_add(struct gpio_chip *chip);
+void acpi_gpiochip_remove(struct gpio_chip *chip);
+
+void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
+void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
+
+int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
+				 struct acpi_gpio_info *info);
+int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
+					struct acpi_gpio_info *info);
+
+struct gpio_desc *acpi_find_gpio(struct device *dev,
+				 const char *con_id,
+				 unsigned int idx,
+				 enum gpiod_flags *dflags,
+				 unsigned long *lookupflags);
+struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
+				      const char *propname, int index,
+				      struct acpi_gpio_info *info);
+
+int acpi_gpio_count(struct device *dev, const char *con_id);
+
+bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id);
+#else
+static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
+static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
+
+static inline void
+acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
+
+static inline void
+acpi_gpiochip_free_interrupts(struct gpio_chip *chip) { }
+
+static inline int
+acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *info)
+{
+	return 0;
+}
+static inline int
+acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
+				    struct acpi_gpio_info *info)
+{
+	return 0;
+}
+
+static inline struct gpio_desc *
+acpi_find_gpio(struct device *dev, const char *con_id,
+	       unsigned int idx, enum gpiod_flags *dflags,
+	       unsigned long *lookupflags)
+{
+	return ERR_PTR(-ENOENT);
+}
+static inline struct gpio_desc *
+acpi_node_get_gpiod(struct fwnode_handle *fwnode, const char *propname,
+		    int index, struct acpi_gpio_info *info)
+{
+	return ERR_PTR(-ENXIO);
+}
+static inline int acpi_gpio_count(struct device *dev, const char *con_id)
+{
+	return -ENODEV;
+}
+
+static inline bool acpi_can_fallback_to_crs(struct acpi_device *adev,
+					    const char *con_id)
+{
+	return false;
+}
+#endif
+
+#endif /* GPIOLIB_ACPI_H */
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d45c9a2285f0..b1085d069dcf 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -30,6 +30,7 @@
 
 #include "gpiolib.h"
 #include "gpiolib-of.h"
+#include "gpiolib-acpi.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/gpio.h>
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 75d2e909d8c6..b8b10a409c7b 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -16,8 +16,6 @@
 #include <linux/module.h>
 #include <linux/cdev.h>
 
-struct acpi_device;
-
 /**
  * struct gpio_device - internal state container for GPIO devices
  * @id: numerical ID number for the GPIO chip
@@ -68,100 +66,9 @@ struct gpio_device {
 #endif
 };
 
-/**
- * struct acpi_gpio_info - ACPI GPIO specific information
- * @adev: reference to ACPI device which consumes GPIO resource
- * @flags: GPIO initialization flags
- * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
- * @pin_config: pin bias as provided by ACPI
- * @polarity: interrupt polarity as provided by ACPI
- * @triggering: triggering type as provided by ACPI
- * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
- */
-struct acpi_gpio_info {
-	struct acpi_device *adev;
-	enum gpiod_flags flags;
-	bool gpioint;
-	int pin_config;
-	int polarity;
-	int triggering;
-	unsigned int quirks;
-};
-
 /* gpio suffixes used for ACPI and device tree lookup */
 static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
 
-#ifdef CONFIG_ACPI
-void acpi_gpiochip_add(struct gpio_chip *chip);
-void acpi_gpiochip_remove(struct gpio_chip *chip);
-
-void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
-void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
-
-int acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags,
-				 struct acpi_gpio_info *info);
-int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
-					struct acpi_gpio_info *info);
-
-struct gpio_desc *acpi_find_gpio(struct device *dev,
-				 const char *con_id,
-				 unsigned int idx,
-				 enum gpiod_flags *dflags,
-				 unsigned long *lookupflags);
-struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
-				      const char *propname, int index,
-				      struct acpi_gpio_info *info);
-
-int acpi_gpio_count(struct device *dev, const char *con_id);
-
-bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id);
-#else
-static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
-static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
-
-static inline void
-acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
-
-static inline void
-acpi_gpiochip_free_interrupts(struct gpio_chip *chip) { }
-
-static inline int
-acpi_gpio_update_gpiod_flags(enum gpiod_flags *flags, struct acpi_gpio_info *info)
-{
-	return 0;
-}
-static inline int
-acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
-				    struct acpi_gpio_info *info)
-{
-	return 0;
-}
-
-static inline struct gpio_desc *
-acpi_find_gpio(struct device *dev, const char *con_id,
-	       unsigned int idx, enum gpiod_flags *dflags,
-	       unsigned long *lookupflags)
-{
-	return ERR_PTR(-ENOENT);
-}
-static inline struct gpio_desc *
-acpi_node_get_gpiod(struct fwnode_handle *fwnode, const char *propname,
-		    int index, struct acpi_gpio_info *info)
-{
-	return ERR_PTR(-ENXIO);
-}
-static inline int acpi_gpio_count(struct device *dev, const char *con_id)
-{
-	return -ENODEV;
-}
-
-static inline bool acpi_can_fallback_to_crs(struct acpi_device *adev,
-					    const char *con_id)
-{
-	return false;
-}
-#endif
-
 struct gpio_array {
 	struct gpio_desc	**desc;
 	unsigned int		size;
-- 
2.20.1

