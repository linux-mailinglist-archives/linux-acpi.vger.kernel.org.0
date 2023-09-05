Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D61E792E8C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 21:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbjIETNB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 15:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbjIETMk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 15:12:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FC91
        for <linux-acpi@vger.kernel.org>; Tue,  5 Sep 2023 12:12:08 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so37681366b.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 Sep 2023 12:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1693941071; x=1694545871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZhpZtSP2svZAFrzaQvlM9FAg/vPyJ7DXBzIjcVtHYA=;
        b=0pWO/WR20tRCacOxj30fLfH+1CliazrF5fmo2t9XFc6Zs7dKpbAGaMKDRlaj6fynhS
         HOgemG08P0v1XzU2SqVAHXCnxLr+JjvtMQGHXzbrjlv8XVRXLEiIUELaU0mwGupbwn0Z
         mvUiR7dTLOq5aEkuclbVm/vF6hXDtNHvHnqQp5y4NGYbI9AgC+61UEVqUSBH3BXmet74
         FE3ge4t4de1/Vyez0++J8tvBgz6tpgG1Poohvt+8lSEsPPYHVzp0kgrsUTeStVig9QCY
         0ks1mWV8uO+SoOJohUjchNy0mvFUaOFjyvcouO/73n+MWQGv44nPh2LkBrCng8IFjt+C
         IMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693941071; x=1694545871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZhpZtSP2svZAFrzaQvlM9FAg/vPyJ7DXBzIjcVtHYA=;
        b=JaSlCu6PaViEgHb1+cKQC02roLZ1iYKVrjI2pVZAMXVAfUIyU6qv/MotDDdWVYJB01
         FQsqyKMPtLJ1QAaeiiff5raErRfECcpyvRAE0PzqqJe0vJSL17Nel7WYm+VF4mqBjSux
         pGzU9g4S2iHOoI5TmDFXAyle5v8Xl2O412nf0D7ihLkIJbEESrIarZzPiTVK65HL/MwJ
         e9UlwlUECt5WcETg5M6cXNczXuIcTRPMgwEZkA7mUvEGUF+uzKRVm0XSW0fUP4ghD2Sn
         A7Ne2LD0vOT8d3p7b/pj2e5hVuBTNbrGVuKq297VVbbMw9tu7LhL2GgvGMvFlBfCJ6pw
         fanQ==
X-Gm-Message-State: AOJu0YwrGANC1cvmBdwHXA/PcParZ4mPKKztpdKgY3xEfWvEJ56SDcAn
        eLyOdkubgBAaEgmm8tZ1vk/+akA9+tr8N61SSzo=
X-Google-Smtp-Source: AGHT+IH6GCfGhH5bbknVyv1QFmzhhSWppXhliMEz+gshhPkUMADba7JqAHg0E1eXfiJxmPf9zlRrog==
X-Received: by 2002:a05:600c:3d0d:b0:402:b8:d022 with SMTP id bh13-20020a05600c3d0d00b0040200b8d022mr609236wmb.16.1693940029130;
        Tue, 05 Sep 2023 11:53:49 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7a54:5dbc:6d09:48b7])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c249100b003fbc30825fbsm17550010wms.39.2023.09.05.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:53:48 -0700 (PDT)
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
Subject: [PATCH 19/21] gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
Date:   Tue,  5 Sep 2023 20:53:07 +0200
Message-Id: <20230905185309.131295-20-brgl@bgdev.pl>
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

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the swnode GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index b5a6eaf3729b..56c8519be538 100644
--- a/drivers/gpio/gpiolib-swnode.c
+++ b/drivers/gpio/gpiolib-swnode.c
@@ -31,31 +31,26 @@ static void swnode_format_propname(const char *con_id, char *propname,
 		strscpy(propname, "gpios", max_size);
 }
 
-static int swnode_gpiochip_match_name(struct gpio_chip *chip, void *data)
+static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
 {
-	return !strcmp(chip->label, data);
-}
+	const struct software_node *gdev_node;
+	struct gpio_device *gdev;
 
-static struct gpio_chip *swnode_get_chip(struct fwnode_handle *fwnode)
-{
-	const struct software_node *chip_node;
-	struct gpio_chip *chip;
-
-	chip_node = to_software_node(fwnode);
-	if (!chip_node || !chip_node->name)
+	gdev_node = to_software_node(fwnode);
+	if (!gdev_node || !gdev_node->name)
 		return ERR_PTR(-EINVAL);
 
-	chip = gpiochip_find((void *)chip_node->name, swnode_gpiochip_match_name);
-	return chip ?: ERR_PTR(-EPROBE_DEFER);
+	gdev = gpio_device_find_by_label((void *)gdev_node->name);
+	return gdev ?: ERR_PTR(-EPROBE_DEFER);
 }
 
 struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 				   const char *con_id, unsigned int idx,
 				   unsigned long *flags)
 {
+	struct gpio_device *gdev __free(gpio_device_put) = NULL;
 	const struct software_node *swnode;
 	struct fwnode_reference_args args;
-	struct gpio_chip *chip;
 	struct gpio_desc *desc;
 	char propname[32]; /* 32 is max size of property name */
 	int error;
@@ -77,12 +72,12 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
 		return ERR_PTR(error);
 	}
 
-	chip = swnode_get_chip(args.fwnode);
+	gdev = swnode_get_gpio_device(args.fwnode);
 	fwnode_handle_put(args.fwnode);
-	if (IS_ERR(chip))
-		return ERR_CAST(chip);
+	if (IS_ERR(gdev))
+		return ERR_CAST(gdev);
 
-	desc = gpiochip_get_desc(chip, args.args[0]);
+	desc = gpiochip_get_desc(gdev->chip, args.args[0]);
 	*flags = args.args[1]; /* We expect native GPIO flags */
 
 	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
-- 
2.39.2

