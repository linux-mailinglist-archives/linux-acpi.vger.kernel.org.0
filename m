Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5726D792E15
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbjIETAY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239744AbjIETAO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:00:14 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BC9173B
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 11:59:44 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-401b0d97850so30051955e9.2
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693940012; x=1694544812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ESplXfwHuP68mF4bwcKzJlFkniMRPzx/b85/cMF6oE=;
        b=t6vnKqg+T54zB4Fkaa6Gy9AZAwhWlkIbFZZHoCfpms+RuRj6YJyXvIX1Wypx53fBqS
         ttS+voJEq+UucTCkf4/EU9pxZml9x38cspPMCu3FrX66N5Yg28F5N8FMEieVxRwRb+ZF
         E2NY8v6ju8+Y27OxjHyVsJzdrAMRomc2mT2SSXGTDokhY7gQgTbmaT6N8tXraLbt5NJp
         3jEmVCJiEdw8wth1e6Y+QlwteQHt2OAmZI7Tz+7qUAOeJnTSkeRVizE+H5JU9idv0ygH
         kq/U3oYVdaOinSqHyWCHvHr0DTlem8c5OxqzxwQTPK3ozuPMt2RKw9s2UQ0kjTKZmp1+
         1pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693940012; x=1694544812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ESplXfwHuP68mF4bwcKzJlFkniMRPzx/b85/cMF6oE=;
        b=ZSYve2CG8pjUNNhrn3oC2t6sfuazd+iUtutVy5H1+TVTNJsNqV0EFQtih9rFbN2GPj
         OMeqHYST7irw5aLirxGpMr76ZKqCfbSbL7ZuLkmwQFsEgrwb7gmtWPlLPUbAV9l45RQh
         omBkMpXWqSrtlY8CwrEZ/E9bBBbHXhYhVb4UtsCBo3q6CDvpCAyh7mj5TI30bztWSaM1
         rajhVoLnROPvnLl+B3Lmc5VbnWOuF7KjYnM1VvzMo+r8ajFFJ5ePGtJsR5MEexHP8gYZ
         apHwTH6/MTKtfd466rZJhcLryhZTH54iz0Fr+uRyjjpDRbZOcTu3NiICk4WbdDWudiO6
         9jVw==
X-Gm-Message-State: AOJu0Yy18fbGWDIl33+014ZrZktCNgrNj3WX3Q0X/llWon/4mg16Li/8
        njsIISf8Bb8/BvKkMe6uVviaWw==
X-Google-Smtp-Source: AGHT+IH/VUJWjUGeUiwbD9fUfZeGiUcxVuhg9dWO0f7MJ889A/l01WqAkHMkYlgWTOb/EzfuaH05Kg==
X-Received: by 2002:a7b:c411:0:b0:3fe:f45:772d with SMTP id k17-20020a7bc411000000b003fe0f45772dmr436878wmi.28.1693940012315;
        Tue, 05 Sep 2023 11:53:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:31 -0700 (PDT)
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
Subject: [PATCH 05/21] gpiolib: add support for scope-based management to gpio_device
Date:   Tue,  5 Sep 2023 20:52:53 +0200
Message-Id: <20230905185309.131295-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230905185309.131295-1-brgl@bgdev.pl>
References: <20230905185309.131295-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the few users that need to get the reference to the GPIO device often
release it right after inspecting its properties, let's add support for
the automatic reference release to struct gpio_device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/gpio/driver.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a769baf3d731..b2572b26c8e3 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -614,6 +614,8 @@ struct gpio_device *gpio_device_find_by_label(const char *label);
 struct gpio_device *gpio_device_get(struct gpio_device *gdev);
 void gpio_device_put(struct gpio_device *gdev);
 
+DEFINE_FREE(gpio_device_put, struct gpio_device *, if (_T) gpio_device_put(_T));
+
 bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
 int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
 void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
-- 
2.39.2

