Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4247A21D3
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Sep 2023 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjIOPD4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Sep 2023 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjIOPDt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Sep 2023 11:03:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE82120
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40472c3faadso19937695e9.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 Sep 2023 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694790222; x=1695395022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZXaGIIfZuiGEdZwV32Js1I7wu0xbFZLpMopu8S/63c=;
        b=j2pacwyiuGqTLgRQPiPev31PTbwYrLft7UMISs+FzqeTwAHLotWLe9L6I7Lqlrmz78
         M5HV2tZf+TZSSsMfSly/0lSta9ckePIJB/rtu84rsvU5bmMNFr8G08ic1NMs6YH9btCU
         w+NFXzByRrfe7SL9soj+SlQvt5Wbd1zBnUa0wmKQtWA2MbrFbFNrh5E1XVDmkk6w4BXK
         1Z56/oXQSKcoGX0jN1pfMaqDEAICy+tShrY4WO8gH2SRL1Jo5aQcKyYED4b0uVoiIy/1
         5ETSt1a5nAp40btPNN1cp+5z9XXgYCC0IkjCAFozHzPPuvebJvYGbWB9jitiQPYiCcB3
         8PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790222; x=1695395022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZXaGIIfZuiGEdZwV32Js1I7wu0xbFZLpMopu8S/63c=;
        b=Vg+fA25OWDozH6uv4felcHUWszgHUCC0DOBMmEw+0emZeyoVpv6BPZXqxQbdQkUD8p
         1o/owRbkoQGbKVkUiBOm5ZkrVOwo/WSU+DaTXm3a4F1a1DQolP1pxC8t7RrVDSoWV+1Z
         uPF53EP+kAkaGSf4K13HE0N2yMe2Op7TYwBJ0h843Iuto78BksMkds9V7wshLyPq9s9T
         kjMaSwbZNZLp3USNJP2gmc18P4ftTYZrOWp3sEMTt3NDTjIlFf5glms4AimzudjgRvz3
         J/vuPPOnNvj2dBqhbXoP2ysH7MmCrnzlDk6LoMCz71Ueq82kJhvgbmfsznq8Xd5EvqLM
         XfuA==
X-Gm-Message-State: AOJu0YztgWlbsM9Fps2z31B9VHthEVYKp7whSRpqiVU8xWgsW4Qjib0h
        IZm+50LzLBWftIcL+/6+DBOD6Q==
X-Google-Smtp-Source: AGHT+IFsSQMOEeoA9BMaHmpw2qAAQ1eXHoD6wcfgKGxbaoXoy4QfUJYUrirtRB5CXrqE7WkQALKXVA==
X-Received: by 2002:a05:600c:221a:b0:3fa:97ad:2ba5 with SMTP id z26-20020a05600c221a00b003fa97ad2ba5mr1881686wml.31.1694790221828;
        Fri, 15 Sep 2023 08:03:41 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:aa19:4569:aeeb:c0d3])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fef19bb55csm4853369wmb.34.2023.09.15.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 08:03:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 11/11] gpio: sysfs: drop the mention of gpiochip_find() from sysfs code
Date:   Fri, 15 Sep 2023 17:03:26 +0200
Message-Id: <20230915150327.81918-12-brgl@bgdev.pl>
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

We have removed all callers of gpiochip_find() so don't mention it in
gpiolib-sysfs.c.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 50503a4525eb..6f309a3b2d9a 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -814,7 +814,7 @@ static int __init gpiolib_sysfs_init(void)
 		 * gpiochip_sysfs_register() acquires a mutex. This is unsafe
 		 * and needs to be fixed.
 		 *
-		 * Also it would be nice to use gpiochip_find() here so we
+		 * Also it would be nice to use gpio_device_find() here so we
 		 * can keep gpio_chips local to gpiolib.c, but the yield of
 		 * gpio_lock prevents us from doing this.
 		 */
-- 
2.39.2

