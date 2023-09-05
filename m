Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8783792E6F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjIETLJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjIETLI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:11:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B3C133
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:10:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so4074531a12.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940985; x=1694545785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD8mhbYtSpsp4MugkXhi33yXQT05nfWNxdtLBId4RL8=;
        b=iYJa4ccsMFkLccExSYarjlCU635gXHBLrXHaEzGhRoTpdWJViQ9ySAJ/RRdo6TGIl1
         4zphzge3lDErveeWLXPp8v1BAbw5ZZyA9buUw5Prbh4DTyuzsjHJKq9+uNSUfEFnyRDH
         0Pd2lDR5nCFZ288a77lZHgX2mnUqZeUj78UD8PFzmCVYku0oYYyq85/BvrLas9rm0FXm
         Q68G0q3lQt3oi28E2t57m6HjPxC7vIEjGGI4mUYsWbpKLSNpa0EY9Fz4U6B1X71FO1LV
         gbu4eVZ3MsIuhQpfsVWbns25CHXMWcUdrZnUUd2Ksx54drv9jyXcm9760FXf/b16FlE4
         j44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940985; x=1694545785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD8mhbYtSpsp4MugkXhi33yXQT05nfWNxdtLBId4RL8=;
        b=TsuKT2CbHsMB+Qir5El62Q0l2zkHtJZclBIQGPP1vpckDBs7dCTDEVqlD45ONWuN/I
         IupoNzEYbybUoMvPuQyzsa4qV5+N3CQZ3pnD3mNJY5M7FFrLAR4NOdWsPObanJW5od5D
         G7REH3umwz4YHtp0lXpB5NSafyTkTpgRUw/SzLzkTrkQ2oMmR2KX8lwUHrC7a/uUvJ3M
         hvgezES6EgDAkcZkMC+70FIJrDy6+ujrf96E5sQ+dGsiF7p6UgyNnHfItr1gN/M/56mv
         pSZqnVGBMBTO3e5ysSXWUR4a1l6nJNtr4gioxUiOoYwaE/5aB3ulCV1AlsuwuVDbYMiY
         WGNg==
X-Gm-Message-State: AOJu0YzUU9axMTQEJIGvncmT7qsB/opVU4uQgYALGyfzm2KCOVlccjm3
        IQZOkJrriAo2drTlbm0ixtjVbbbrewhSC5C/aU0=
X-Google-Smtp-Source: AGHT+IFIMVvhNg464qJima4kezuYWuRmRs+hpxgOQnc+URZYC5BvtqpinR7GN44km7chTJtWGj8fDQ==
X-Received: by 2002:a7b:c390:0:b0:401:38dc:8918 with SMTP id s16-20020a7bc390000000b0040138dc8918mr481515wmj.24.1693940015869;
        Tue, 05 Sep 2023 11:53:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:35 -0700 (PDT)
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
Subject: [PATCH 08/21] gpio: acpi: provide acpi_gpio_device_free_interrupts()
Date:   Tue,  5 Sep 2023 20:52:56 +0200
Message-Id: <20230905185309.131295-9-brgl@bgdev.pl>
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

We're moving away from public functions that take struct gpio_chip as
argument as the chip - unlike struct gpio_device - is owned by its
provider and tied to its lifetime.

Provide an alternative to acpi_gpiochip_free_interrupts().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 29 +++++++++++++++++++++++------
 include/linux/gpio/driver.h | 12 ++++++++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index fbda452fb4d6..5633e39396bc 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -558,12 +558,9 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
 }
 EXPORT_SYMBOL_GPL(acpi_gpiochip_request_interrupts);
 
-/**
- * acpi_gpiochip_free_interrupts() - Free GPIO ACPI event interrupts.
- * @chip:      GPIO chip
- *
- * Free interrupts associated with GPIO ACPI event method for the given
- * GPIO chip.
+/*
+ * This function is deprecated, use acpi_gpio_device_free_interrupts()
+ * instead.
  */
 void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 {
@@ -604,6 +601,26 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
 }
 EXPORT_SYMBOL_GPL(acpi_gpiochip_free_interrupts);
 
+/**
+ * acpi_gpio_device_free_interrupts() - Free GPIO ACPI event interrupts.
+ * @chip	GPIO device
+ *
+ * Free interrupts associated with GPIO ACPI event method for the given
+ * GPIO device.
+ */
+void acpi_gpio_device_free_interrupts(struct gpio_device *gdev)
+{
+	struct gpio_chip *gc;
+
+	/* TODO: protect gdev->chip once SRCU is in place in GPIOLIB. */
+	gc = gdev->chip;
+	if (!gc)
+		return;
+
+	acpi_gpiochip_free_interrupts(gc);
+}
+EXPORT_SYMBOL_GPL(acpi_gpio_device_free_interrupts);
+
 int acpi_dev_add_driver_gpios(struct acpi_device *adev,
 			      const struct acpi_gpio_mapping *gpios)
 {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index b68b3493b29d..47906bc56b3d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -835,4 +835,16 @@ static inline struct fwnode_handle *gpiochip_node_get_first(struct device *dev)
 	return NULL;
 }
 
+/*
+ * FIXME: Remove this once the only driver that uses it - android tablets -
+ * becomes a good citizen and stops abusing GPIOLIB.
+ */
+#ifdef CONFIG_ACPI
+void acpi_gpio_device_free_interrupts(struct gpio_device *gdev);
+#else
+static inline void acpi_gpio_device_free_interrupts(struct gpio_device *gdev)
+{
+}
+#endif
+
 #endif /* __LINUX_GPIO_DRIVER_H */
-- 
2.39.2

