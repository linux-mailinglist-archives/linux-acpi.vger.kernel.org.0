Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3537792DF1
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 20:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbjIESzp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 14:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240735AbjIESzX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 14:55:23 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9161730
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 11:55:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-402d499580dso12714095e9.1
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940028; x=1694544828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8EoAIqFLJCxUpfLhsvBV4jgy9F1vQzmq/NZ2XWmhPM=;
        b=irz10VKbMLeng4ZixyOOnJHEJAzNeWz1hov/KxB8mF+k6rj/LQ4LAwTJXFhhjVRS+v
         itGQh4ai1wChP2p+/8C9JtUg02LiGYOfDxcdW5O3LioyfITZUYuSuAM4wGSdy+m9aHWe
         OJ0DMDGxzizoIA3TQmIH8RPQJbNYAe07CptoIisJrARNxlWdRSmlWDiIQKqCXv4ki4TX
         UizmzI3ALpp0DyF2NBMebnW73rdXk+BLG+JhHrDFs6YUrUgvQfj/MHaN8T0IAKv2NCHS
         mloZENvz5tLe34I78lRzZwlzbxe6zzsBL9TBGG05EkDn+iuybKcqTwTqhnhLRUTWjxdC
         m0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940028; x=1694544828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8EoAIqFLJCxUpfLhsvBV4jgy9F1vQzmq/NZ2XWmhPM=;
        b=fIZeGjGiP6pAeuQ4kOxrrOFrMQiWIjSwsVxtdc1EvhRWVSrAI7GeNFB0GMYo9hK2LO
         +MMWqmMNWxtBK5mUzZ9nmFG3DQqzezXGV6OmwhtmOWfuEAbWwGwQJ+pWMJcsYGQS8ZaF
         yFnRnMP2fBBeyANuB7PBna7sMj+1J7vBxdaHK3mSe9C6LdUjc4p/YKAuuh+/KEL9E98/
         PsnOE9CQlqWxjyTx9T3a7uq1PwNBgf9JrovaOPUUi8A0J0Mwxk0nRUNeAzI57UOtpP2F
         iubyfkFgi989ByeKO8bzlzobCAb6q896Hh1SvbUSXA8MGa2W1A/SAynbKfA+zgKhZVyh
         pz9w==
X-Gm-Message-State: AOJu0YxpcMFvQSY/vTTHgbLOz31tNZwcnPIGYaS6hF1HYg2hZ0bWEex6
        dJkHmTakP3+IdeF/XtRVwCvZVQ==
X-Google-Smtp-Source: AGHT+IGdmweLsvxMkviAD6X4Rb7LNMdeCjqz2Ypd3y+SG6ZL6d4+T9L7pYZxfgxQTgv+RGIUJmtJEw==
X-Received: by 2002:a05:600c:2809:b0:3fe:dcd0:2e10 with SMTP id m9-20020a05600c280900b003fedcd02e10mr472155wmb.17.1693940027944;
        Tue, 05 Sep 2023 11:53:47 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:47 -0700 (PDT)
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
Subject: [PATCH 18/21] gpio: acpi: replace gpiochip_find() with gpio_device_find()
Date:   Tue,  5 Sep 2023 20:53:06 +0200
Message-Id: <20230905185309.131295-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the ACPI GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 5633e39396bc..15d3350123d9 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -143,7 +143,7 @@ static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
  */
 static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 {
-	struct gpio_chip *chip;
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	acpi_handle handle;
 	acpi_status status;
 
@@ -151,11 +151,11 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 	if (ACPI_FAILURE(status))
 		return ERR_PTR(-ENODEV);
 
-	chip = gpiochip_find(handle, acpi_gpiochip_find);
-	if (!chip)
+	gdev = gpio_device_find(handle, acpi_gpiochip_find);
+	if (!gdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return gpiochip_get_desc(chip, pin);
+	return gpiochip_get_desc(gdev->chip, pin);
 }
 
 /**
-- 
2.39.2

