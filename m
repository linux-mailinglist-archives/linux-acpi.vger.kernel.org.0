Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE6325394
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBYQfZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 11:35:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:23422 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229722AbhBYQfY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Feb 2021 11:35:24 -0500
IronPort-SDR: d5hqSierWJ1+DTWlDzTCeeacZEKVwdYaCycxcPwdk/DqFrb8uzkHyQr3rQH/7Wyt7fMRphCj6v
 EcUo3ij3EFnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="183121956"
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="183121956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 08:33:38 -0800
IronPort-SDR: xXVjJUskamy71sRGeEZKpMsuI6mzkL6B/RcAiclFxoPzz3n/dZGVgHECNdttG63JQSW7J/ueh1
 NAdJyMFnrvwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,206,1610438400"; 
   d="scan'208";a="367457681"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 25 Feb 2021 08:33:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 04E1C450; Thu, 25 Feb 2021 18:33:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/3] gpiolib: acpi: Allow to find GpioInt() resource by name and index
Date:   Thu, 25 Feb 2021 18:33:19 +0200
Message-Id: <20210225163320.71267-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
References: <20210225163320.71267-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently only search by index is supported. However, in some cases
we might need to pass the quirks to the acpi_dev_gpio_irq_get().

For this, split out acpi_dev_gpio_irq_get_by() and replace
acpi_dev_gpio_irq_get() by calling above with NULL for name parameter.

Fixes: ba8c90c61847 ("gpio: pca953x: Override IRQ for one of the expanders on Galileo Gen 2")
Depends-on: 0ea683931adb ("gpio: dwapb: Convert driver to using the GPIO-lib-based IRQ-chip")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi.c | 12 ++++++++----
 include/linux/acpi.h        | 10 ++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 026ef258d4b9..495f779b2ab9 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -945,8 +945,9 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
 }
 
 /**
- * acpi_dev_gpio_irq_get() - Find GpioInt and translate it to Linux IRQ number
+ * acpi_dev_gpio_irq_get_by() - Find GpioInt and translate it to Linux IRQ number
  * @adev: pointer to a ACPI device to get IRQ from
+ * @name: optional name of GpioInt resource
  * @index: index of GpioInt resource (starting from %0)
  *
  * If the device has one or more GpioInt resources, this function can be
@@ -956,9 +957,12 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
  * The function is idempotent, though each time it runs it will configure GPIO
  * pin direction according to the flags in GpioInt resource.
  *
+ * The function takes optional @name parameter. If the resource has a property
+ * name, then only those will be taken into account.
+ *
  * Return: Linux IRQ number (> %0) on success, negative errno on failure.
  */
-int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
+int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index)
 {
 	int idx, i;
 	unsigned int irq_flags;
@@ -968,7 +972,7 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 		struct acpi_gpio_info info;
 		struct gpio_desc *desc;
 
-		desc = acpi_get_gpiod_by_index(adev, NULL, i, &info);
+		desc = acpi_get_gpiod_by_index(adev, name, i, &info);
 
 		/* Ignore -EPROBE_DEFER, it only matters if idx matches */
 		if (IS_ERR(desc) && PTR_ERR(desc) != -EPROBE_DEFER)
@@ -1013,7 +1017,7 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 	}
 	return -ENOENT;
 }
-EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_get);
+EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_get_by);
 
 static acpi_status
 acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 053bf05fb1f7..b20568c44001 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1072,19 +1072,25 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
 bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 				struct acpi_resource_gpio **agpio);
-int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index);
+int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index);
 #else
 static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 					      struct acpi_resource_gpio **agpio)
 {
 	return false;
 }
-static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
+static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
+					   const char *name, int index)
 {
 	return -ENXIO;
 }
 #endif
 
+static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
+{
+	return acpi_dev_gpio_irq_get_by(adev, NULL, index);
+}
+
 /* Device properties */
 
 #ifdef CONFIG_ACPI
-- 
2.30.0

