Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEC792E92
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbjIETNT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242071AbjIETNR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:13:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EA1B7
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:12:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52e5900cf77so2171197a12.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693941100; x=1694545900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+MC7OlTYjYmYcid9pUzzxXRyDGKxkUAmb4nz8uCexs=;
        b=q1/CkWNfqGPyyZAKmTsgH1hQ2aSVo6BfXklBsFVchM3IoLwJ7SI89Zia9tQkQPNSAh
         25+tN1hp5O5FDGbawrB5LcAUTPC7sSclTkjWaY3iE7qnwIxY74629ov0KogQc496J1oG
         96nFvvTJDvNHzTugtfSMKDa/lsuWd3O6DLoMLqjOE4PspGVsCIEZfxrUZN/7Qu4YOzVL
         yMUkWUXn7SMeYizlM5ZP6mq/kYiMpsM2qH9tgDgrFUvFYkT7downIT4ybSQCbT2JkzU4
         HGq7jcUpF88EMe2rDF+Am0LE68rISFD3jsYLGYucwOezkfAZVeo6a4I2HMy8E0K7FIGh
         z1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693941100; x=1694545900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+MC7OlTYjYmYcid9pUzzxXRyDGKxkUAmb4nz8uCexs=;
        b=TVsOjUC4POnmJNsEnDerreOAoiowmK1pIPtHo/Qff57PpqoDVfv6/QoNm2KBkATH73
         ZhuM8IGG/bQfkPTonFWXKyOgev1psKmsXCDJbrKp+bUFCxegIBv101D5SmeTPg8DAVUi
         AJuGoz2NDID9aHGfl5Rry6+ku8y0B1voZj70stOUBueFtzQ2a0SyWlNPIsjFjkWAP7Ly
         dQCoxXMy7XGz6sYaOHfJrkf2pMvfCtXSnhCSj+K6G/MTAjGVxMjlOlUO5+5D4JFP4EyS
         CohEuJ5t9NB2kwYl1TJ7HSOIc/kcG7BRabbbuFQrYcgQwuXwIndKSg+BT+wh+Mn4Ti04
         euhw==
X-Gm-Message-State: AOJu0YykruJ4ZnaCsTZYmYT1jcz0sjgc12usVdtaT9KnkAKbMTDeplBD
        FJduSrZFJxBUh+oObbSLduqtoYRkIkHqZ3oTLW0=
X-Google-Smtp-Source: AGHT+IGj2EuAvHtXRXD8rdSvHdyQNmCzp7/4dD7j6aPqgw+n/kXSu9aLQQjPpRIFRE646UdFzsOLag==
X-Received: by 2002:adf:e0c5:0:b0:319:6b6c:dd01 with SMTP id m5-20020adfe0c5000000b003196b6cdd01mr477303wri.17.1693940014702;
        Tue, 05 Sep 2023 11:53:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:34 -0700 (PDT)
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
Subject: [PATCH 07/21] gpiolib: provide gpio_device_get_base()
Date:   Tue,  5 Sep 2023 20:52:55 +0200
Message-Id: <20230905185309.131295-8-brgl@bgdev.pl>
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

Let's start adding getters for the opaque struct gpio_device. Start with
a function allowing to retrieve the base GPIO number.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c      | 13 +++++++++++++
 include/linux/gpio/driver.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9637a79a9a60..9715bbc698e9 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -233,6 +233,19 @@ struct gpio_device *gpiod_to_device(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_to_device);
 
+/**
+ * gpio_device_get_base() - Get the base GPIO number allocated by this device
+ * @gdev: GPIO device
+ *
+ * Returns:
+ * First GPIO number in the global GPIO numberspace for this device.
+ */
+int gpio_device_get_base(struct gpio_device *gdev)
+{
+	return gdev->base;
+}
+EXPORT_SYMBOL_GPL(gpio_device_get_base);
+
 /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
 static int gpiochip_find_base(int ngpio)
 {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index e3747e730ed1..b68b3493b29d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -780,6 +780,9 @@ void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
 struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
 struct gpio_device *gpiod_to_device(struct gpio_desc *desc);
 
+/* struct gpio_device getters */
+int gpio_device_get_base(struct gpio_device *gdev);
+
 #else /* CONFIG_GPIOLIB */
 
 #include <linux/err.h>
-- 
2.39.2

