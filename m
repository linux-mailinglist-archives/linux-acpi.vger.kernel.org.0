Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F897A62A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2019 12:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfG3Knm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 06:43:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:59648 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfG3Knm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jul 2019 06:43:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 03:43:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="255573466"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2019 03:43:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BFA5AAD; Tue, 30 Jul 2019 13:43:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] gpiolib: of: Reshuffle contents of consumer.h for new library layout
Date:   Tue, 30 Jul 2019 13:43:35 +0300
Message-Id: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel build bot reported a compilation error after the commit

  f626d6dfb709 ("gpio: of: Break out OF-only code"):

drivers/gpio/gpiolib-devres.o: In function `devm_gpiod_get_from_of_node':
gpiolib-devres.c:(.text+0x19a): undefined reference to `gpiod_get_from_of_node'

This happens due to move the latter under umbrella of CONFIG_OF_GPIO while
customer.h contains staled data.

Fix it by reshuffling contents of consumer.h to satisfy build dependencies.

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: f626d6dfb709 ("gpio: of: Break out OF-only code"):
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no change
 include/linux/gpio/consumer.h | 78 +++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index a7f08fb0f865..b548a3fb5eee 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -170,18 +170,8 @@ struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
 
 /* Child properties interface */
-struct device_node;
 struct fwnode_handle;
 
-struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label);
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label);
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 					 const char *propname, int index,
 					 enum gpiod_flags dflags,
@@ -530,28 +520,8 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 }
 
 /* Child properties interface */
-struct device_node;
 struct fwnode_handle;
 
-static inline
-struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-static inline
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
 static inline
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 					 const char *propname, int index,
@@ -584,6 +554,54 @@ struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
 						      flags, label);
 }
 
+#if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_OF_GPIO)
+struct device_node;
+
+struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label);
+
+#else  /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
+
+struct device_node;
+
+static inline
+struct gpio_desc *gpiod_get_from_of_node(struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+#endif /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
+
+#ifdef CONFIG_GPIOLIB
+struct device_node;
+
+struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
+					      struct device_node *node,
+					      const char *propname, int index,
+					      enum gpiod_flags dflags,
+					      const char *label);
+
+#else  /* CONFIG_GPIOLIB */
+
+struct device_node;
+
+static inline
+struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
+					      struct device_node *node,
+					      const char *propname, int index,
+					      enum gpiod_flags dflags,
+					      const char *label)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+#endif /* CONFIG_GPIOLIB */
+
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_GPIO_SYSFS)
 
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change);
-- 
2.20.1

