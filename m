Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B567999D2
	for <lists+linux-acpi@lfdr.de>; Sat,  9 Sep 2023 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjIIQZS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 Sep 2023 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346378AbjIIOUN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 9 Sep 2023 10:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E9E45
        for <linux-acpi@vger.kernel.org>; Sat,  9 Sep 2023 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694269114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnWosMnrT6Tj83USTGbuArWvmKIv0wvZD8gCMTfOryA=;
        b=CDEIMUtrQFna33yC3G8nv0g1PoOKy6yp9fNfB05+poFkts8C/ISu2b3SL16BnaRH6/8SBA
        1sLuOmW94Trv3SG6wCqlSwjgQTw6XZAEcliZJT/C5ndS0JItZBdE9oAjxEuDUdeO+zHmdw
        nEflb/E+7YErcw295b0c/UBcZV6bWYU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-UvLTnKirM7qqyzxeWCI1Ug-1; Sat, 09 Sep 2023 10:18:31 -0400
X-MC-Unique: UvLTnKirM7qqyzxeWCI1Ug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 327848001EA;
        Sat,  9 Sep 2023 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 195F7142B960;
        Sat,  9 Sep 2023 14:18:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib private APIs
Date:   Sat,  9 Sep 2023 16:18:14 +0200
Message-ID: <20230909141816.58358-7-hdegoede@redhat.com>
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

Refactor x86_android_tablet_get_gpiod() to no longer use
gpiolib private functions like gpiochip_find().

As a bonus this allows specifying that the GPIO is active-low,
like the /CE (charge enable) pin on the bq25892 charger on
the Lenovo Yoga Tablet 3.

Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.131295-12-brgl@bgdev.pl/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../platform/x86/x86-android-tablets/asus.c   |  1 +
 .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++--------
 .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
 .../platform/x86/x86-android-tablets/other.c  |  6 +++
 .../x86-android-tablets/x86-android-tablets.h |  6 ++-
 5 files changed, 55 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/platform/x86/x86-android-tablets/asus.c
index f9c4083be86d..227afbb51078 100644
--- a/drivers/platform/x86/x86-android-tablets/asus.c
+++ b/drivers/platform/x86/x86-android-tablets/asus.c
@@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_tf103c_i2c_clients[] __initconst =
 			.index = 28,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "atmel_mxt_ts_irq",
 		},
 	},
 };
diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 3d3101b2848f..673f3a14941b 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -12,7 +12,7 @@
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -21,35 +21,39 @@
 #include <linux/string.h>
 
 #include "x86-android-tablets.h"
-/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
-#include "../../../gpio/gpiolib.h"
-#include "../../../gpio/gpiolib-acpi.h"
 
 static struct platform_device *x86_android_tablet_device;
 
-static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
-{
-	return gc->label && !strcmp(gc->label, data);
-}
-
-int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio_desc **desc)
+int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
+				 bool active_low, enum gpiod_flags dflags,
+				 struct gpio_desc **desc)
 {
+	struct gpiod_lookup_table *lookup;
 	struct gpio_desc *gpiod;
-	struct gpio_chip *chip;
 
-	chip = gpiochip_find((void *)label, gpiochip_find_match_label);
-	if (!chip) {
-		pr_err("error cannot find GPIO chip %s\n", label);
-		return -ENODEV;
-	}
+	lookup = kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
+	lookup->dev_id = KBUILD_MODNAME;
+	lookup->table[0].key = chip;
+	lookup->table[0].chip_hwnum = pin;
+	lookup->table[0].con_id = con_id;
+	lookup->table[0].flags = active_low ? GPIO_ACTIVE_LOW : GPIO_ACTIVE_HIGH;
+
+	gpiod_add_lookup_table(lookup);
+	gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);
+	gpiod_remove_lookup_table(lookup);
+	kfree(lookup);
 
-	gpiod = gpiochip_get_desc(chip, pin);
 	if (IS_ERR(gpiod)) {
-		pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), label, pin);
+		pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), chip, pin);
 		return PTR_ERR(gpiod);
 	}
 
-	*desc = gpiod;
+	if (desc)
+		*desc = gpiod;
+
 	return 0;
 }
 
@@ -79,7 +83,8 @@ int x86_acpi_irq_helper_get(const struct x86_acpi_irq_data *data)
 		return irq;
 	case X86_ACPI_IRQ_TYPE_GPIOINT:
 		/* Like acpi_dev_gpio_irq_get(), but without parsing ACPI resources */
-		ret = x86_android_tablet_get_gpiod(data->chip, data->index, &gpiod);
+		ret = x86_android_tablet_get_gpiod(data->chip, data->index, data->con_id,
+						   false, GPIOD_ASIS, &gpiod);
 		if (ret)
 			return ret;
 
@@ -356,7 +361,9 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 
 		for (i = 0; i < dev_info->gpio_button_count; i++) {
 			ret = x86_android_tablet_get_gpiod(dev_info->gpio_button[i].chip,
-							   dev_info->gpio_button[i].pin, &gpiod);
+							   dev_info->gpio_button[i].pin,
+							   dev_info->gpio_button[i].button.desc,
+							   false, GPIOD_IN, &gpiod);
 			if (ret < 0) {
 				x86_android_tablet_remove(pdev);
 				return ret;
@@ -364,6 +371,8 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 
 			buttons[i] = dev_info->gpio_button[i].button;
 			buttons[i].gpio = desc_to_gpio(gpiod);
+			/* Release gpiod so that gpio-keys can request it */
+			devm_gpiod_put(&x86_android_tablet_device->dev, gpiod);
 		}
 
 		pdata.buttons = buttons;
diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 26a4ef670ad7..35aa2968d726 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -95,6 +95,7 @@ static const struct x86_i2c_client_info lenovo_yb1_x90_i2c_clients[] __initconst
 			.index = 56,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "goodix_ts_irq",
 		},
 	}, {
 		/* Wacom Digitizer in keyboard half */
@@ -111,6 +112,7 @@ static const struct x86_i2c_client_info lenovo_yb1_x90_i2c_clients[] __initconst
 			.index = 49,
 			.trigger = ACPI_LEVEL_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "wacom_irq",
 		},
 	}, {
 		/* LP8557 Backlight controller */
@@ -136,6 +138,7 @@ static const struct x86_i2c_client_info lenovo_yb1_x90_i2c_clients[] __initconst
 			.index = 77,
 			.trigger = ACPI_LEVEL_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "hideep_ts_irq",
 		},
 	},
 };
@@ -321,6 +324,7 @@ static struct x86_i2c_client_info lenovo_yoga_tab2_830_1050_i2c_clients[] __init
 			.index = 2,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_HIGH,
+			.con_id = "bq24292i_irq",
 		},
 	}, {
 		/* BQ27541 fuel-gauge */
@@ -431,7 +435,8 @@ static int __init lenovo_yoga_tab2_830_1050_init_touchscreen(void)
 	int ret;
 
 	/* Use PMIC GPIO 10 bootstrap pin to differentiate 830 vs 1050 */
-	ret = x86_android_tablet_get_gpiod("gpio_crystalcove", 10, &gpiod);
+	ret = x86_android_tablet_get_gpiod("gpio_crystalcove", 10, "yoga_bootstrap",
+					   false, GPIOD_IN, &gpiod);
 	if (ret)
 		return ret;
 
@@ -615,6 +620,7 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 			.index = 5,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "bq25892_0_irq",
 		},
 	}, {
 		/* bq27500 fuel-gauge for the round li-ion cells in the hinge */
@@ -640,6 +646,7 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 			.index = 77,
 			.trigger = ACPI_LEVEL_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "hideep_ts_irq",
 		},
 	}, {
 		/* LP8557 Backlight controller */
@@ -655,7 +662,6 @@ static const struct x86_i2c_client_info lenovo_yt3_i2c_clients[] __initconst = {
 
 static int __init lenovo_yt3_init(void)
 {
-	struct gpio_desc *gpiod;
 	int ret;
 
 	/*
@@ -665,31 +671,23 @@ static int __init lenovo_yt3_init(void)
 	 *
 	 * The bq25890_charger driver controls these through I2C, but this only
 	 * works if not overridden by the pins. Set these pins here:
-	 * 1. Set /CE to 0 to allow charging.
+	 * 1. Set /CE to 1 to allow charging.
 	 * 2. Set OTG to 0 disable V5 boost output since the 5V boost output of
 	 *    the main "bq25892_1" charger is used when necessary.
 	 */
 
 	/* /CE pin */
-	ret = x86_android_tablet_get_gpiod("INT33FF:02", 22, &gpiod);
+	ret = x86_android_tablet_get_gpiod("INT33FF:02", 22, "bq25892_0_ce",
+					   true, GPIOD_OUT_HIGH, NULL);
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * The gpio_desc returned by x86_android_tablet_get_gpiod() is a "raw"
-	 * gpio_desc, that is there is no way to pass lookup-flags like
-	 * GPIO_ACTIVE_LOW. Set the GPIO to 0 here to enable charging since
-	 * the /CE pin is active-low, but not marked as such in the gpio_desc.
-	 */
-	gpiod_set_value(gpiod, 0);
-
 	/* OTG pin */
-	ret = x86_android_tablet_get_gpiod("INT33FF:03", 19, &gpiod);
+	ret = x86_android_tablet_get_gpiod("INT33FF:03", 19, "bq25892_0_otg",
+					   false, GPIOD_OUT_LOW, NULL);
 	if (ret < 0)
 		return ret;
 
-	gpiod_set_value(gpiod, 0);
-
 	/* Enable the regulators used by the touchscreen */
 	intel_soc_pmic_exec_mipi_pmic_seq_element(0x6e, 0x9b, 0x02, 0xff);
 	intel_soc_pmic_exec_mipi_pmic_seq_element(0x6e, 0xa0, 0x02, 0xff);
diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index 621ca1e54d1f..bc6bbf7ec6ea 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -47,6 +47,7 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
 			.index = 3,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "NVT-ts_irq",
 		},
 	}, {
 		/* BMA250E accelerometer */
@@ -62,6 +63,7 @@ static const struct x86_i2c_client_info acer_b1_750_i2c_clients[] __initconst =
 			.index = 25,
 			.trigger = ACPI_LEVEL_SENSITIVE,
 			.polarity = ACPI_ACTIVE_HIGH,
+			.con_id = "bma250e_irq",
 		},
 	},
 };
@@ -174,6 +176,7 @@ static const struct x86_i2c_client_info chuwi_hi8_i2c_clients[] __initconst = {
 			.index = 23,
 			.trigger = ACPI_LEVEL_SENSITIVE,
 			.polarity = ACPI_ACTIVE_HIGH,
+			.con_id = "bma250e_irq",
 		},
 	},
 };
@@ -312,6 +315,7 @@ static const struct x86_i2c_client_info medion_lifetab_s10346_i2c_clients[] __in
 			.index = 23,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_HIGH,
+			.con_id = "kxtj21009_irq",
 		},
 	}, {
 		/* goodix touchscreen */
@@ -402,6 +406,7 @@ static const struct x86_i2c_client_info nextbook_ares8_i2c_clients[] __initconst
 			.index = 3,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "ft5416_irq",
 		},
 	},
 };
@@ -460,6 +465,7 @@ static const struct x86_i2c_client_info nextbook_ares8a_i2c_clients[] __initcons
 			.index = 17,
 			.trigger = ACPI_EDGE_SENSITIVE,
 			.polarity = ACPI_ACTIVE_LOW,
+			.con_id = "ft5416_irq",
 		},
 	},
 };
diff --git a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
index bf97fb84c0d4..9d2fb7fded6d 100644
--- a/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
+++ b/drivers/platform/x86/x86-android-tablets/x86-android-tablets.h
@@ -10,6 +10,7 @@
 #ifndef __PDX86_X86_ANDROID_TABLETS_H
 #define __PDX86_X86_ANDROID_TABLETS_H
 
+#include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
 #include <linux/irqdomain_defs.h>
@@ -37,6 +38,7 @@ struct x86_acpi_irq_data {
 	int index;
 	int trigger;  /* ACPI_EDGE_SENSITIVE / ACPI_LEVEL_SENSITIVE */
 	int polarity; /* ACPI_ACTIVE_HIGH / ACPI_ACTIVE_LOW / ACPI_ACTIVE_BOTH */
+	const char *con_id;
 };
 
 /* Structs to describe devices to instantiate */
@@ -81,7 +83,9 @@ struct x86_dev_info {
 	void (*exit)(void);
 };
 
-int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio_desc **desc);
+int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *con_id,
+				 bool active_low, enum gpiod_flags dflags,
+				 struct gpio_desc **desc);
 int x86_acpi_irq_helper_get(const struct x86_acpi_irq_data *data);
 
 /*
-- 
2.41.0

