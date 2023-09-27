Return-Path: <linux-acpi+bounces-215-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709727B06FD
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2290A28251D
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6E450C1
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:34:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CF5C8D2
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 14:29:48 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B939F1B5
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-405621baba7so83776955e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695824985; x=1696429785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZXaGIIfZuiGEdZwV32Js1I7wu0xbFZLpMopu8S/63c=;
        b=LRr+WyT+pJrvtzeFl3/fK+ENRQ+D1e0hsD+RYczEWKCCDSfkFSRWt4FSYjeXCZD9Kp
         GyWvm2X6/1LKNL6TZAYKYS6ht5cszmolglAiC/8c4D6CgAjxPZUVvb4Ro7F7jIN+mJr9
         9QUrTlbND7s6NJlmOzLc404VWq8LDsLHYi2qsK1qIuybIH8JoBqrVW+voJmD1lTJVYQw
         pYeAx+hjxY8RSBKSOlL3x3lB8jAFSTB8w9OO3qTLr40WSgcZXQ8aNLNlpHYX33BtsNo2
         W12MVKhQ/RaB15Oij4eRJm/nbjabyZ3ifwQTuom524ifc/F+xiRgd124dftTVaLC2Uz1
         0nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824985; x=1696429785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZXaGIIfZuiGEdZwV32Js1I7wu0xbFZLpMopu8S/63c=;
        b=pa7VTSR4KZsatK6z/wrSYQQ21HnBGFgOvHqfT+St7qS9YKfNppXrXrLO57dwo8wIll
         BvDeGFDehSdopQ/U9gLdGQ0N5nMmHgJN8EZesF5y74g1HaI4KJoP512gFeNHiZVbO0eP
         D6URED/Sza+BJJsLbE+vThIwBHcd/bbtuefzUMARX+1Rja5mxLAsC8c2YeJ5C6HX6ova
         QrFs/fJZtSX7QNgCz/4bz41U5Q16NqL8Lkqel6+lDvqw17Z1CQfjMA/xKbyiftaIj8FB
         rY5+uWfgsbzR0hevPhp66GNeg1qxQvu48U0n/ZK5Vh2vspNDQsLw8LvV9RuT2ABSvtY1
         YZ/g==
X-Gm-Message-State: AOJu0YxZ6c6AZ6gtsCitdj6tZ4m8GBlu0imHYq0whI5oytIBgwNHb4/j
	pONtsujBKK8/JkKidF6ZYRsQ3Q==
X-Google-Smtp-Source: AGHT+IEXsLCf66wrsjqsyNP3LGPoGey7JEWXQQyftq4Pcl8llIG+MXA78yj2kb3tXjDQEhKuOHbqGg==
X-Received: by 2002:a7b:c3d1:0:b0:405:3d27:70e8 with SMTP id t17-20020a7bc3d1000000b004053d2770e8mr2265430wmj.36.1695824985281;
        Wed, 27 Sep 2023 07:29:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4bb6:1525:9e22:4a15])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b003feae747ff2sm20448303wmh.35.2023.09.27.07.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 07:29:44 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 11/11] gpio: sysfs: drop the mention of gpiochip_find() from sysfs code
Date: Wed, 27 Sep 2023 16:29:31 +0200
Message-Id: <20230927142931.19798-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927142931.19798-1-brgl@bgdev.pl>
References: <20230927142931.19798-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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


