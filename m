Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B750792F30
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjIETnU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjIETnR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:43:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F38B2
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:43:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5007abb15e9so4891962e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693942992; x=1694547792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyBIfAzUG/Tst2tDFyTRTa17LASZ2n9GApjCcuynorg=;
        b=XSmau/tusgtEvNm29N2Qw8s5tBcIr2HU06ya5/FpgZmhkiHZBspgg+6k9eYytkAHjS
         qGiFX43k7StQLx8DJxbC+nW3owaHi5UTfayomUxJqWNdm+7eCRdt6PZtCpXo1o0O2sRz
         +TfRY5dQTKnaH7ObF7pcEyt6Pu4e54Gm3BATuulWbp/RzthiOzdm3smTPiK52jkcflpr
         SRpRj3Uyq6MRt98KTgQ57exij1thieZRmuxiFk51c8LDWz4WA5lZDSQnVTQWQNvmrQoZ
         fndTczRoyOjH03zkPHOCRLl42JcffnOm2dGIl5tf2aklRyUgQb0AE8N3Z/OHhXAIFKmY
         18Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693942992; x=1694547792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyBIfAzUG/Tst2tDFyTRTa17LASZ2n9GApjCcuynorg=;
        b=DKWTh4MlYlggO+BRXWFsWWDiQGe/yAFFRclV4i8Mv1rznbsK5WBRtwuCc5+xYynFOt
         vfpsEwdX7QacLTHd73tFYhPg/cOtAXsI6gajZOPi4iFQ3ADB8zVHWJdAjyFaANeJqA0b
         Qku/mYuoZ3EkJk9vGJjIuqgfHN3Lge07DTk3yAm5JwIfHKQ5AKs0SBGXrg4vNnPwPsOM
         qOvp4G3SArlI5721VoR0pE6NpI2SF2HBQfrBIRDr3I95/UmUjN32vBATUQ0WoZASFjM/
         B6C6gCrQsBpgStclcCQEWAZuGG788WtZsWyPMlwuHmkpdR0FHdf4Mwu8u4PtHg6FS13U
         F2FQ==
X-Gm-Message-State: AOJu0YxxP4kiZxQ0rM2in/IQ/yfw3w/LEtXQDc0o/wFlvaYMDn8RgSOe
        lBO2jcoKi5xZe66BKZ7Rc4yqLgyz+r/jVzqxhks=
X-Google-Smtp-Source: AGHT+IG6EifQrYWqD0xKG3/BJghDnSpVupHCLvA51a9h0XWSNzRpKylYhH8S6fQzecUWzA90ZfjUyw==
X-Received: by 2002:a7b:c8ca:0:b0:3fe:f667:4e4c with SMTP id f10-20020a7bc8ca000000b003fef6674e4cmr457674wml.12.1693940019484;
        Tue, 05 Sep 2023 11:53:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFT PATCH 11/21] platform: x86: android-tablets: don't access GPIOLIB private members
Date:   Tue,  5 Sep 2023 20:52:59 +0200
Message-Id: <20230905185309.131295-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're slowly removing cases of abuse of the GPIOLIB public API. One of
the biggest issues is looking up and accessing struct gpio_chip whose
life-time is tied to the provider and which can disappear from under any
user at any given moment. We have provided new interfaces that use the
opaque struct gpio_device which is reference counted and will soon be
thorougly protected with appropriate locking.

Stop using old interfaces in this driver and switch to safer
alternatives.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../platform/x86/x86-android-tablets/core.c   | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 2fd6060a31bb..687f84cd193c 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -12,6 +12,7 @@
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/irq.h>
@@ -21,27 +22,28 @@
 #include <linux/string.h>
 
 #include "x86-android-tablets.h"
-/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
-#include "../../../gpio/gpiolib.h"
-#include "../../../gpio/gpiolib-acpi.h"
-
-static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
-{
-	return gc->label && !strcmp(gc->label, data);
-}
 
 int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio_desc **desc)
 {
+	struct gpio_device *gdev;
 	struct gpio_desc *gpiod;
-	struct gpio_chip *chip;
 
-	chip = gpiochip_find((void *)label, gpiochip_find_match_label);
-	if (!chip) {
-		pr_err("error cannot find GPIO chip %s\n", label);
+	/*
+	 * FIXME: handle GPIOs correctly! This driver should really use struct
+	 * device and GPIO lookup tables.
+	 *
+	 * WONTDO: We do leak this reference, but the whole approach to getting
+	 * GPIOs in this driver is such an abuse of the GPIOLIB API that it
+	 * doesn't make it much worse and it's the only way to keep the
+	 * interrupt requested later functional...
+	 */
+	gdev = gpio_device_find_by_label(label);
+	if (!gdev) {
+		pr_err("error cannot find GPIO device %s\n", label);
 		return -ENODEV;
 	}
 
-	gpiod = gpiochip_get_desc(chip, pin);
+	gpiod = gpio_device_get_desc(gdev, pin);
 	if (IS_ERR(gpiod)) {
 		pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), label, pin);
 		return PTR_ERR(gpiod);
@@ -257,9 +259,9 @@ static void x86_android_tablet_cleanup(void)
 
 static __init int x86_android_tablet_init(void)
 {
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	const struct x86_dev_info *dev_info;
 	const struct dmi_system_id *id;
-	struct gpio_chip *chip;
 	int i, ret = 0;
 
 	id = dmi_first_match(x86_android_tablet_ids);
@@ -273,13 +275,13 @@ static __init int x86_android_tablet_init(void)
 	 * _AEI (ACPI Event Interrupt) handlers, disable these.
 	 */
 	if (dev_info->invalid_aei_gpiochip) {
-		chip = gpiochip_find(dev_info->invalid_aei_gpiochip,
-				     gpiochip_find_match_label);
-		if (!chip) {
+		gdev = gpio_device_find_by_label(
+				dev_info->invalid_aei_gpiochip);
+		if (!gdev) {
 			pr_err("error cannot find GPIO chip %s\n", dev_info->invalid_aei_gpiochip);
 			return -ENODEV;
 		}
-		acpi_gpiochip_free_interrupts(chip);
+		acpi_gpio_device_free_interrupts(gdev);
 	}
 
 	/*
-- 
2.39.2

