Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6807A21CB
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjIOPDx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbjIOPDn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884E2717
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:38 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40078c4855fso24238645e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790217; x=1695395017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7cnFQaXE5hgNGVsFuhD31Dbn34C6HVkTSPK79EhhMo=;
        b=Ev5euDCkEcMyo0Vi4HTUYVTfW9nuMoInIT+a1zskafF66mHsZ0IliYQHDC/CbYvCHv
         SgIa37TovU2rkGI02FnKLad5qhkl8OUkK1AQL6Gr2/1zsSjyQINW+r/yaRKMaaNQUdk1
         NCCvfu2U2YdQXT4+QqX0uoRFEdcUqYaiKB9RyXDP670KYo5hA7GLgXZBzYKPCCULqkQX
         aGgzxcPj92fuZphAJyL5lRwpzkka1yEGmCVay1cjte1PCM561o74LNYhJkpsBE985je+
         wEeGy24lDjysXDfmGJ36yYCVi3VTTgtMi1Exb27xcTYDNbNi14i74owlbvYPX9UwIptD
         aP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790217; x=1695395017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7cnFQaXE5hgNGVsFuhD31Dbn34C6HVkTSPK79EhhMo=;
        b=FgKCNIwXX+NMy9Bbu52MchO2zDRFECN1QkO6kpd1eKJeTR2kAq4VB9sWuH41pevhP4
         0c6K7xQdBgV7KUhVwKOS+5n782y6Br+pTbpHkijpwgEHIKVeeVq9ui16iGSRuT/MspvH
         qokVZ2A7ea0GL+EXhfGKu6brZ6DcA6l7bscC7tVGecOVAWY/oEadJB8IctZ/Ylu4sA7x
         LngFsTFqDSsfnGAKs2/TEtP4hUmrJT96/L6cfjhuT49kyxC9BffrCEAaELVd2T0qABGc
         l79TToHLpPSQ2DLo6CrRcEMj2b/LwAudCpuX98idvSoFgsESVHgBiYyEMBonovGR1Dx2
         sqnQ==
X-Gm-Message-State: AOJu0YwSXcEKRRPolLaZlogse3x1dmqDVksn1Qq65nuQSXn0KVBEJcdi
        /cdTWmvbXPYbXKKFe/WHVPdeWA==
X-Google-Smtp-Source: AGHT+IEorh4sO+fT8YcWE2co/gViak4l34nxlE1iLrbUtDPxiVwO0HapW2pbE+TLh0BrG3WzweMY4g==
X-Received: by 2002:a05:600c:203:b0:3fe:3004:1ffd with SMTP id 3-20020a05600c020300b003fe30041ffdmr1735651wmi.4.1694790216912;
        Fri, 15 Sep 2023 08:03:36 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 06/11] gpiolib: reluctantly provide gpio_device_get_chip()
Date:   Fri, 15 Sep 2023 17:03:21 +0200
Message-Id: <20230915150327.81918-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150327.81918-1-brgl@bgdev.pl>
References: <20230915150327.81918-1-brgl@bgdev.pl>
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

The process of converting all unauthorized users of struct gpio_chip to
using dedicated struct gpio_device function will be long so in the
meantime we must provide a way of retrieving the pointer to struct
gpio_chip from a GPIO device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib.c      | 21 +++++++++++++++++++++
 include/linux/gpio/driver.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 7d2574b3dbe5..e26cbd10a246 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -220,6 +220,27 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_to_chip);
 
+/**
+ * gpio_device_get_chip() - Get the gpio_chip implementation of this GPIO device
+ * @gdev: GPIO device
+ *
+ * Returns:
+ * Address of the GPIO chip backing this device.
+ *
+ * Until we can get rid of all non-driver users of struct gpio_chip, we must
+ * provide a way of retrieving the pointer to it from struct gpio_device. This
+ * is *NOT* safe as the GPIO API is considered to be hot-unpluggable and the
+ * chip can dissapear at any moment (unlike reference-counted struct
+ * gpio_device).
+ *
+ * Use at your own risk.
+ */
+struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev)
+{
+	return gdev->chip;
+}
+EXPORT_SYMBOL_GPL(gpio_device_get_chip);
+
 /* dynamic allocation of GPIOs, e.g. on a hotplugged device */
 static int gpiochip_find_base(int ngpio)
 {
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 3fdf3f14bb13..f8ad7f40100c 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -773,6 +773,8 @@ struct gpio_desc *gpiochip_get_desc(struct gpio_chip *gc, unsigned int hwnum);
 struct gpio_desc *
 gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum);
 
+struct gpio_chip *gpio_device_get_chip(struct gpio_device *gdev);
+
 #ifdef CONFIG_GPIOLIB
 
 /* lock/unlock as IRQ */
-- 
2.39.2

