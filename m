Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06987A21D1
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjIOPDz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbjIOPDs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F792130
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso21087375e9.1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790221; x=1695395021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MflPL+QKb28SLjr67nvfLFxWVRN50mSzldVQJo+IR1w=;
        b=encZS12jQ1cC0ojsy04xKusqHk6btwsxQ2hEzufqDORTkaBdHRvgWU1Q/wQ9Q95DKG
         ae8KsmwjRMVn3YtC0DCf2M2N3iZsakSTdI0eipA54PV/GPojrZ2LZ/ANiYbrUjZCQYY/
         gTnY3jcBigmA4nBv06hNYLOxpXorK+AbSDTyaomQlnrhNO33Tptn57kA1/lUgXLfcs76
         Ffn78A4I6gLC+kcjbDCje+yCrwui+AUQhNUXI+gzenHGKzu5XhRIPfVgpxS5Cyib8Sig
         KVvtxPMyBQrq/+0JfcqPZRlHu7jnd6R+UYji1jOWNyBSkWGQA0v4dYQ4xEjthbDKLCWB
         jdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790221; x=1695395021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MflPL+QKb28SLjr67nvfLFxWVRN50mSzldVQJo+IR1w=;
        b=OHIYBBSiI9y7TjsMISFjbNDPsGAa+LgpikqC01TSK2woE56xla0BiP7bN2+X3OieGG
         5pc3FrGx2wQWtamppFOK4zVdCxj0OvGTcw0xtfDDwj4xQJsXroGLmwy04JRYAF4EjgHu
         ta4qfm4jIlDwK47Ay78Hwx2j/ozzYIYvnncb/YDKVHWEPv3k3lKcnsyPiVgWM5krE2/0
         srOFU4Tsxi5oDk0dljQL4z7p6wh+23bBTlYSG3d4/zx62xOUkAIz9HCJXHLeWB0FPkT6
         hQaHmyLJoQRz95aNBBZJqzvTh9pUdEsj26QRC/W8fR5yxbF4Hl1+Xh6hQdwGMBWDag3+
         iNAA==
X-Gm-Message-State: AOJu0YxArgXEcIIq41kDS6FqonL4ZLAx6RzZsDABDZ6MZMcYEecEvAr+
        kf8JjH3fix7MXOtzLa0cTttVWw==
X-Google-Smtp-Source: AGHT+IEKyYIrqckgcNgCNpRrNcCOY404saMM9pRyUHnyyBwWyqo+egV/Ccr/VlfwOLClomvrOLLT2g==
X-Received: by 2002:a05:600c:b59:b0:3fc:dd9:91fd with SMTP id k25-20020a05600c0b5900b003fc0dd991fdmr1616601wmr.40.1694790220840;
        Fri, 15 Sep 2023 08:03:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 10/11] gpio: swnode: replace gpiochip_find() with gpio_device_find_by_label()
Date:   Fri, 15 Sep 2023 17:03:25 +0200
Message-Id: <20230915150327.81918-11-brgl@bgdev.pl>
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

We're porting all users of gpiochip_find() to using gpio_device_find().
Update the swnode GPIO code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-swnode.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
index b5a6eaf3729b..33c4b1a6c3c1 100644
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
@@ -77,12 +72,16 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
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
+	/*
+	 * FIXME: The GPIO device reference is put at return but the descriptor
+	 * is passed on. Find a proper solution.
+	 */
+	desc = gpio_device_get_desc(gdev, args.args[0]);
 	*flags = args.args[1]; /* We expect native GPIO flags */
 
 	pr_debug("%s: parsed '%s' property of node '%pfwP[%d]' - status (%d)\n",
-- 
2.39.2

