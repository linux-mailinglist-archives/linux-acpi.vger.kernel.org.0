Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE48A2B3A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2019 02:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfH3ABy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 20:01:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39124 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH3ABy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Aug 2019 20:01:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id y200so3241928pfb.6
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2019 17:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=typeblog-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4FdmecES1mXuhQRWO8rMFn+Nx420CRXp9hbw5E4DeY=;
        b=C+rwRawAYjEQMmq1XlJqg/oPcrd9+huDhBB/ffgbwV2euRm53zIQKEzHOR/2TGOJgM
         nKzl3Z6sSCW9v4ByjBtXDP49ANg3dw8ayKkt3IUigIB9aT6LV3nd2GzEzE3rPEHYljfB
         G6JF1BsruhNFBDg4UiAiSlMS5ip7KyygC3mi2v2BA0gj8gh0/GRqgAaaZfvDovCpsL4j
         55uEAummxO8+6zhQKMmUH17J2FFfXWiN+7ifJaBaQ4WGuNd08im5K56a9drKA8GdYr8b
         fFpZDpz7NRdcKw3Th+tSyYgctrqBYF3pHK8l3x38pGo3t7RNIJFGjdj7LwUUFiLVvdug
         Pwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4FdmecES1mXuhQRWO8rMFn+Nx420CRXp9hbw5E4DeY=;
        b=WL4c1f09DxUPPkm9Xqne+jRa2FtHsoK7HjJWqufJCjzcMMP/oNhbZVmPhnYJdp2NCT
         GOmohc+/UKxM6/fsp9VCsztY3prWQtoPLbdI5HJujq7NuVI8JMjOOzxHRrZYjCq5PU6j
         fZV8EEH9Wbd7WCn0Nu9LzhET8N62ZJQQzDKtEkUrEaPUsuf6LKFwVU9ZnZT0h7aS/8fM
         QiMxR1/YlJbdRAi01jCA9LihQlpg7ji0d4K0QNnJmcOSvRVqpbKel+EJ2y6YmB+kFDLB
         BooZF/tbJ9T62EUQsVzypi+EEnVpcc1b+PoeP4zSs794g0Wctw9LxADxGAqDDWFQ1RUL
         DOQQ==
X-Gm-Message-State: APjAAAX6nsmHhzfCnPdvBNBw8WX7nI74N8QxQ238NAiYcqeyz+g+u3y9
        JolcE9ueHLspqHVEjbEbCBlyRw==
X-Google-Smtp-Source: APXvYqzqeat554HkNrmzQW+v4uxeKH2ucYkRnvGkc20nQ9CzJSLXTHeAVgx+oRGALg9emAc734pNzA==
X-Received: by 2002:a17:90a:e505:: with SMTP id t5mr359288pjy.68.1567123313781;
        Thu, 29 Aug 2019 17:01:53 -0700 (PDT)
Received: from peter-pc.home ([91.207.174.229])
        by smtp.gmail.com with ESMTPSA id g2sm4369819pfm.32.2019.08.29.17.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:01:52 -0700 (PDT)
From:   Peter Cai <peter@typeblog.net>
Cc:     Peter Cai <peter@typeblog.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH 1/2] gpio: acpi: add quirk to override GpioInt polarity
Date:   Fri, 30 Aug 2019 08:00:23 +0800
Message-Id: <20190830000024.20384-1-peter@typeblog.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On GPD P2 Max, the firmware could not reset the touch panel correctly.
The kernel needs to take on the job instead, but the GpioInt definition
in DSDT specifies ActiveHigh while the GPIO pin should actually be
ActiveLow.

We need to override the polarity defined by DSDT. The GPIO driver
already allows defining polarity in acpi_gpio_params, but the option is
not applied to GpioInt.

This patch adds a new quirk that enables the polarity specified in
acpi_gpio_params to also be applied to GpioInt.

Signed-off-by: Peter Cai <peter@typeblog.net>
---
 drivers/gpio/gpiolib-acpi.c | 10 +++++++++-
 include/linux/acpi.h        |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 39f2f9035c11..1a07c79ca2de 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -583,13 +583,21 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		/*
 		 * Polarity and triggering are only specified for GpioInt
 		 * resource.
+		 * Polarity specified by GpioInt may be ignored if
+		 * ACPI_GPIO_QUIRK_OVERRIDE_POLARITY is set.
 		 * Note: we expect here:
 		 * - ACPI_ACTIVE_LOW == GPIO_ACTIVE_LOW
 		 * - ACPI_ACTIVE_HIGH == GPIO_ACTIVE_HIGH
 		 */
 		if (lookup->info.gpioint) {
 			lookup->info.flags = GPIOD_IN;
-			lookup->info.polarity = agpio->polarity;
+			if (lookup->info.quirks &
+					ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) {
+				dev_warn(&lookup->info.adev->dev, FW_BUG "Incorrect polarity specified by GpioInt, overriding.\n");
+				lookup->info.polarity = lookup->active_low;
+			} else {
+				lookup->info.polarity = agpio->polarity;
+			}
 			lookup->info.triggering = agpio->triggering;
 		} else {
 			lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9426b9aaed86..6569773ceffd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1014,6 +1014,12 @@ struct acpi_gpio_mapping {
  * get GpioIo type explicitly, this quirk may be used.
  */
 #define ACPI_GPIO_QUIRK_ONLY_GPIOIO		BIT(1)
+/*
+ * Use the GPIO polarity (ActiveHigh / ActiveLow) from acpi_gpio_params
+ * for GpioInt as well. The default behavior is to use the one specified
+ * by GpioInt, which can be incorrect on some devices.
+ */
+#define ACPI_GPIO_QUIRK_OVERRIDE_POLARITY	BIT(2)
 
 	unsigned int quirks;
 };
-- 
2.23.0

