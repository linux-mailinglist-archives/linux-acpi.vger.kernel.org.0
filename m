Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4667A21CD
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjIOPDy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjIOPDq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4D2120
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so24428625e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790220; x=1695395020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db5q27N7A/juU4c9VZA3v3TCPgc+fDf9UmP/eHtAN2w=;
        b=et9pcbrFnd5xJv8e0uCGGte2O7CAZG8AlvRizXbv3fRaqlkjFrz+1sbJmYOqcdZXRa
         QtCAIxXy3kJRvHH6zSpaCr1UJeirwpKXPqwEAOjb/J3jtB0ELII/4BwMbGqJYQy1v2Ja
         pNWcG62V9rlJthh1CLYO2eCH8kbHSFr8Dm7FIPtdPngkc09Q+u/pyOyb8FgjITiZT5TW
         Tl84R8tngfNMZfWwrnHiHnv9SdYQLjPRjO0QZwxJm6ZNKTPDBPEIuhsDnv4Lj6UbmSuA
         3V9mAFAXyWslcxW9pSH9kq4iuk6YeejPQDT9r8ue9sAy9OB0RbdvLiFw+eAsMvhwofd8
         EB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790220; x=1695395020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db5q27N7A/juU4c9VZA3v3TCPgc+fDf9UmP/eHtAN2w=;
        b=UTukZl9Lkwx/PbXb2zRy768th1DBCEjRosyGLI7NPpggk5lfC1DEdtvEoM+vtm7WkB
         bjz4KDJobtp1QcNupne94cBMeCpSO/Ny5qVvztPkDBQNlr2wGsjohGm4VAoDdK7YVwVH
         ub+OVdYZJDsIWu8ssuXbaHnRLBshy59pIbeuNn1QEg71VfNzB3D/dWHsoOXTRsC8Bpg6
         3wDZaFXFQ4CrRIo6RyzJiuWmLPF4sgOl/qq4VLeAwcrPwlK6gjG+a57+Uqp4sbxQSN0r
         SvHVW/x41GcEuUJwj8NvJSPMGPxxil1w3h8taTMbMHonvplTMwtkLB51nA9fXfk5SMB6
         2Png==
X-Gm-Message-State: AOJu0Yx5Yj3htbXTul39oZpTCsEeanWg5BNlfowcgmlehbuo9W0Vg3fS
        rg/P2DDNmui9hS3lRbmsi33Xug==
X-Google-Smtp-Source: AGHT+IGERElJ5ax2+UDdnf7bpjUXsQcoXTElrEEaABEPSoddT627hWGGCuoPfcaSMheoeEUTU/Xgew==
X-Received: by 2002:a1c:4c0c:0:b0:402:f557:2e46 with SMTP id z12-20020a1c4c0c000000b00402f5572e46mr1886650wmf.1.1694790219822;
        Fri, 15 Sep 2023 08:03:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 09/11] gpio: acpi: replace gpiochip_find() with gpio_device_find()
Date:   Fri, 15 Sep 2023 17:03:24 +0200
Message-Id: <20230915150327.81918-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
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
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 17a86bdd9609..2378e1e7e8b9 100644
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
 
@@ -151,11 +151,15 @@ static struct gpio_desc *acpi_get_gpiod(char *path, unsigned int pin)
 	if (ACPI_FAILURE(status))
 		return ERR_PTR(-ENODEV);
 
-	chip = gpiochip_find(handle, acpi_gpiochip_find);
-	if (!chip)
+	gdev = gpio_device_find(handle, acpi_gpiochip_find);
+	if (!gdev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	return gpiochip_get_desc(chip, pin);
+	/*
+	 * FIXME: keep track of the reference to the GPIO device somehow
+	 * instead of putting it here.
+	 */
+	return gpio_device_get_desc(gdev, pin);
 }
 
 /**
-- 
2.39.2

