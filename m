Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B67979CD5C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 12:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjILKIy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Sep 2023 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjILKHw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Sep 2023 06:07:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874811710
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31fa666000dso1982991f8f.2
        for <linux-acpi@vger.kernel.org>; Tue, 12 Sep 2023 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694513265; x=1695118065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZXaGIIfZuiGEdZwV32Js1I7wu0xbFZLpMopu8S/63c=;
        b=CBcLKpVmpJjHh2XVmijaPTM/EXPaXhgsBZpC8keybf9lw22n79aDUGIEcVTYDPSAak
         IrChIbIqM2FYT1SzMUao7fDqX0feTaXnihtECI1rcBhcYqcak25R+u6uLcfcyVQsvRBG
         7ivY1TP1nAl9Zjv1uybaFM5n0dtkl7S2U7L5G8XDI08kn3P8h6QtAZwKsoULMG1FY53u
         0Rzjnb0beQH4vF7dKbxC9yXNb8iWqdFhGz+lbrcE7DhnDSPVDRq9xGLFmhSj5CuNPFie
         VR9BGsii67PjsNhwDqcpsffeCfoRo9BpBjfafK+cSg3e2ozTywwrjUzkFdspOgkpEe40
         Hl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694513265; x=1695118065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZXaGIIfZuiGEdZwV32Js1I7wu0xbFZLpMopu8S/63c=;
        b=sDkzjX2WMPrjTnEY1qTiQb6PCdka50jsr5JD2Jmau5REElHdl3wR3OeAQgzDcEeZYY
         okRcc8NLPCGfJMb91NHjBXozqOgGETSnINdXmFq2wHPzKOhQeOQ5RZVGR7qXDAKSKsC/
         Y98623uqW/ESWOzgNNUTsTgUj0Slz/Ajk3Ohi1G9ZxYVpX7XrFj6gKlUbCnUnYOy8P0P
         usKtKxa4bC50xMah9uMvaKReTcB2ils7PWpxfjUH+5LKkIgNG/Vh1I19hZdGWKhcNxdo
         ajLw50G8qR7TlcgbimCIj82LyukIUXtxy9+9491VtfJR7IpLAjjc0S/rXo1p3yYTNmrw
         pvGQ==
X-Gm-Message-State: AOJu0Ywg6FDUff5rkK4nunKOxd6irc1UN5X2IXwk4bjlp8lYccsNI6Ba
        EyEDXmyWVnCaX+bFctYhVityYMty4ZW0pySYcQM=
X-Google-Smtp-Source: AGHT+IGZflhMvOl/dEeCICiYZ6lX6s/c7XUmqeokfy0VRtRYkBJuPqHSImz1gPZLf27bK6JsQEwdmg==
X-Received: by 2002:adf:e485:0:b0:319:6c90:5274 with SMTP id i5-20020adfe485000000b003196c905274mr9384628wrm.30.1694513265100;
        Tue, 12 Sep 2023 03:07:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id h5-20020adfe985000000b0031ae8d86af4sm12351417wrm.103.2023.09.12.03.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 03:07:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 11/11] gpio: sysfs: drop the mention of gpiochip_find() from sysfs code
Date:   Tue, 12 Sep 2023 12:07:27 +0200
Message-Id: <20230912100727.23197-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912100727.23197-1-brgl@bgdev.pl>
References: <20230912100727.23197-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

