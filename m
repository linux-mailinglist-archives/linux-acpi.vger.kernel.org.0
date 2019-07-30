Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471817A62C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2019 12:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfG3Knm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jul 2019 06:43:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:35851 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfG3Knm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Jul 2019 06:43:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 03:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,326,1559545200"; 
   d="scan'208";a="346949225"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Jul 2019 03:43:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC83F254; Tue, 30 Jul 2019 13:43:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH v2 3/3] gpiolib-acpi: Move acpi_dev_add_driver_gpios() et al to consumer.h
Date:   Tue, 30 Jul 2019 13:43:37 +0300
Message-Id: <20190730104337.21235-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com>
References: <20190730104337.21235-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The API, which belongs to GPIO library, is foreign to ACPI headers. Earlier
we moved out I²C out of the latter, and now it's time for
acpi_dev_add_driver_gpios() et al.

For time being the acpi_gpio_get_irq_resource() and acpi_dev_gpio_irq_get()
are left untouched as they need more thought about.

Note, it requires uninline acpi_dev_remove_driver_gpios() to keep purity of
consumer.h.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org (moderated list:INTEL ASoC DRIVERS)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 drivers/gpio/gpiolib-acpi.c                  |  7 +++
 include/linux/acpi.h                         | 51 ------------------
 include/linux/gpio/consumer.h                | 57 ++++++++++++++++++++
 sound/soc/intel/boards/bytcht_cx2072x.c      |  1 +
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  1 +
 sound/soc/intel/boards/cht_bsw_rt5672.c      |  1 +
 6 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d54fc6e7c8a9..fdee8afa5339 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -383,6 +383,13 @@ int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 }
 EXPORT_SYMBOL_GPL(acpi_dev_add_driver_gpios);
 
+void acpi_dev_remove_driver_gpios(struct acpi_device *adev)
+{
+	if (adev)
+		adev->driver_gpios = NULL;
+}
+EXPORT_SYMBOL_GPL(acpi_dev_remove_driver_gpios);
+
 static void devm_acpi_dev_release_driver_gpios(struct device *dev, void *res)
 {
 	acpi_dev_remove_driver_gpios(ACPI_COMPANION(dev));
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86..e40e1e27ed8e 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -994,62 +994,11 @@ void __acpi_handle_debug(struct _ddebug *descriptor, acpi_handle handle, const c
 #endif
 #endif
 
-struct acpi_gpio_params {
-	unsigned int crs_entry_index;
-	unsigned int line_index;
-	bool active_low;
-};
-
-struct acpi_gpio_mapping {
-	const char *name;
-	const struct acpi_gpio_params *data;
-	unsigned int size;
-
-/* Ignore IoRestriction field */
-#define ACPI_GPIO_QUIRK_NO_IO_RESTRICTION	BIT(0)
-/*
- * When ACPI GPIO mapping table is in use the index parameter inside it
- * refers to the GPIO resource in _CRS method. That index has no
- * distinction of actual type of the resource. When consumer wants to
- * get GpioIo type explicitly, this quirk may be used.
- */
-#define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
-
-	unsigned int quirks;
-};
-
 #if defined(CONFIG_ACPI) && defined(CONFIG_GPIOLIB)
-int acpi_dev_add_driver_gpios(struct acpi_device *adev,
-			      const struct acpi_gpio_mapping *gpios);
-
-static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev)
-{
-	if (adev)
-		adev->driver_gpios = NULL;
-}
-
-int devm_acpi_dev_add_driver_gpios(struct device *dev,
-				   const struct acpi_gpio_mapping *gpios);
-void devm_acpi_dev_remove_driver_gpios(struct device *dev);
-
 bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 				struct acpi_resource_gpio **agpio);
 int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index);
 #else
-static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
-			      const struct acpi_gpio_mapping *gpios)
-{
-	return -ENXIO;
-}
-static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
-
-static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
-			      const struct acpi_gpio_mapping *gpios)
-{
-	return -ENXIO;
-}
-static inline void devm_acpi_dev_remove_driver_gpios(struct device *dev) {}
-
 static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 					      struct acpi_resource_gpio **agpio)
 {
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index b548a3fb5eee..b70af921c614 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -602,6 +602,63 @@ struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
 
 #endif /* CONFIG_GPIOLIB */
 
+struct acpi_gpio_params {
+	unsigned int crs_entry_index;
+	unsigned int line_index;
+	bool active_low;
+};
+
+struct acpi_gpio_mapping {
+	const char *name;
+	const struct acpi_gpio_params *data;
+	unsigned int size;
+
+/* Ignore IoRestriction field */
+#define ACPI_GPIO_QUIRK_NO_IO_RESTRICTION	BIT(0)
+/*
+ * When ACPI GPIO mapping table is in use the index parameter inside it
+ * refers to the GPIO resource in _CRS method. That index has no
+ * distinction of actual type of the resource. When consumer wants to
+ * get GpioIo type explicitly, this quirk may be used.
+ */
+#define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
+
+	unsigned int quirks;
+};
+
+#if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_ACPI)
+
+struct acpi_device;
+
+int acpi_dev_add_driver_gpios(struct acpi_device *adev,
+			      const struct acpi_gpio_mapping *gpios);
+void acpi_dev_remove_driver_gpios(struct acpi_device *adev);
+
+int devm_acpi_dev_add_driver_gpios(struct device *dev,
+				   const struct acpi_gpio_mapping *gpios);
+void devm_acpi_dev_remove_driver_gpios(struct device *dev);
+
+#else  /* CONFIG_GPIOLIB && CONFIG_ACPI */
+
+struct acpi_device;
+
+static inline int acpi_dev_add_driver_gpios(struct acpi_device *adev,
+			      const struct acpi_gpio_mapping *gpios)
+{
+	return -ENXIO;
+}
+static inline void acpi_dev_remove_driver_gpios(struct acpi_device *adev) {}
+
+static inline int devm_acpi_dev_add_driver_gpios(struct device *dev,
+			      const struct acpi_gpio_mapping *gpios)
+{
+	return -ENXIO;
+}
+static inline void devm_acpi_dev_remove_driver_gpios(struct device *dev) {}
+
+#endif /* CONFIG_GPIOLIB && CONFIG_ACPI */
+
+
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_GPIO_SYSFS)
 
 int gpiod_export(struct gpio_desc *desc, bool direction_may_change);
diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index 54ac2fd41925..67f06c95eec5 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -6,6 +6,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 33eb72545be6..05db311b579e 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 4977b5a65eb8..9d657421730a 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -8,6 +8,7 @@
  *          Mengdong Lin <mengdong.lin@intel.com>
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-- 
2.20.1

