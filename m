Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0834629E0D2
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 02:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJ1WDC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 18:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgJ1WBc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2020 18:01:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09BFC0613D1
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2020 15:01:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m20so902780ljj.5
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzxgzmFEKg3uyOYq0U+7u1Sr88Fa5cBf5J/ai9Bi9w4=;
        b=c8YXWXabra4sW5/XLNopgCr1Ey4kEIOYZ1bnz6+tWCnkIM88z4M2Q3I8N6B+DLSZt4
         cJzYWSgKqRYIP05RISLd1JWNSMYFkd9oJV/3pYM+4YbdbwwpPxZY4yZg7EkQpNCDvAMI
         gD29S7F17ZYzpny8Auzr9eQgNQUDt2NXaN1SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JzxgzmFEKg3uyOYq0U+7u1Sr88Fa5cBf5J/ai9Bi9w4=;
        b=lzqpEAX3SWM7sC6RCQZN3y/RXzEfVP6aaO3Kp3ASzhTOeSdc8etHJKgb4jBQ3UY48o
         vIXc3DdiXNXdWDWYgDtb+sfY2UeDLoPpbAn/tHJccne0aW1dN1DnSAd6e9/qJT4Pl2aA
         DpXTLtW00JTsZ1TKESoSND4xpub5thTJ521NfYpHGdwb5aUThVhkU8SJQuKtzT95Sd1A
         Td8nTy6wEBCVYZGrDh0/E6gRrrHXZ5YmXNMkiBk+jLZ/ja0W9cEEUpylk251Ss04Oftn
         wagTmT7GS+MuqUrz6PdRXBKs2SBZDKcnXbRhTQMg2OCdv0o9YsrV72xMnjvvIy3Y5tWR
         4aig==
X-Gm-Message-State: AOAM532D7J9KTg1x0Y4RQi33skbxIx1uvNz/Pe+FQigkl1ndg6JUaR3y
        qywyDjTj33lEezUNjrEkqtyJIJ/l6AQ7iMfwUwU=
X-Google-Smtp-Source: ABdhPJw9WvnFCFfe0bMtDkbOl61PKkk2WINL/17GJ+UJzZwPlfMZ2z28uuVsBREELq+J+ey2Z9mmqA==
X-Received: by 2002:adf:e685:: with SMTP id r5mr390473wrm.340.1603905483580;
        Wed, 28 Oct 2020 10:18:03 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id y4sm222505wrp.74.2020.10.28.10.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 10:18:02 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] gpiolib: acpi: Support GpioInt with active_low polarity
Date:   Wed, 28 Oct 2020 18:17:57 +0100
Message-Id: <20201028171757.765866-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On the current implementation we only support active_high polarity for
GpioInt.

There can be cases where a GPIO has active_low polarity and it is also a
IRQ source.

De-couple the irq_polarity and active_low fields instead of re-use it.

With this patch we support ACPI devices such as:

Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
{
        GpioInt (Edge, ActiveBoth, Exclusive, PullDefault, 0x0000,
        "\\_SB.PCI0.GPIO", 0x00, ResourceConsumer, ,
        )
        {   // Pin list
                0x0064
        }
})
Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
{
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
        Package (0x01)
        {
        Package (0x02)
        {
                "privacy-gpio",
                Package (0x04)
                {
                \_SB.PCI0.XHCI.RHUB.HS07,
                Zero,
                Zero,
                One
                }
        }
        }
})

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++----
 drivers/gpio/gpiolib-acpi.h | 6 ++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 834a12f3219e..bc33c1056391 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -624,7 +624,7 @@ int acpi_gpio_update_gpiod_lookup_flags(unsigned long *lookupflags,
 		break;
 	}
 
-	if (info->polarity == GPIO_ACTIVE_LOW)
+	if (info->active_low)
 		*lookupflags |= GPIO_ACTIVE_LOW;
 
 	return 0;
@@ -665,6 +665,7 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 					      agpio->pin_table[pin_index]);
 		lookup->info.pin_config = agpio->pin_config;
 		lookup->info.gpioint = gpioint;
+		lookup->info.active_low = !!lookup->active_low;
 
 		/*
 		 * Polarity and triggering are only specified for GpioInt
@@ -675,11 +676,10 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
 		 */
 		if (lookup->info.gpioint) {
 			lookup->info.flags = GPIOD_IN;
-			lookup->info.polarity = agpio->polarity;
+			lookup->info.irq_polarity = agpio->polarity;
 			lookup->info.triggering = agpio->triggering;
 		} else {
 			lookup->info.flags = acpi_gpio_to_gpiod_flags(agpio);
-			lookup->info.polarity = lookup->active_low;
 		}
 	}
 
@@ -958,7 +958,7 @@ int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 				return ret;
 
 			irq_flags = acpi_dev_get_irq_type(info.triggering,
-							  info.polarity);
+							  info.irq_polarity);
 
 			/* Set type if specified and different than the current one */
 			if (irq_flags != IRQ_TYPE_NONE &&
diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 1c6d65cf0629..816a2d7a21ed 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -16,7 +16,8 @@ struct acpi_device;
  * @flags: GPIO initialization flags
  * @gpioint: if %true this GPIO is of type GpioInt otherwise type is GpioIo
  * @pin_config: pin bias as provided by ACPI
- * @polarity: interrupt polarity as provided by ACPI
+ * @irq_polarity: interrupt polarity as provided by ACPI
+ * @active_low: pin polarity as provided by ACPI
  * @triggering: triggering type as provided by ACPI
  * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
  */
@@ -25,7 +26,8 @@ struct acpi_gpio_info {
 	enum gpiod_flags flags;
 	bool gpioint;
 	int pin_config;
-	int polarity;
+	int irq_polarity;
+	bool active_low;
 	int triggering;
 	unsigned int quirks;
 };
-- 
2.29.0.rc2.309.g374f81d7ae-goog

