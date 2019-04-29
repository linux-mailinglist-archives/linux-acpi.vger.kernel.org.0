Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C216E365
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2019 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfD2NMV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Apr 2019 09:12:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40503 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfD2NMV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Apr 2019 09:12:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so15698034wmb.5
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2019 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EWtkEswA/ppJKsau0ucZOXQ0FjybdP/7oMBp2mQhOUw=;
        b=avQNkrkDuUX/SIDLB2Sk61f/7WpPyXBxDA6gZqFxCDXCdzxT6U+W+gX9DxRmUClSwO
         sFUfh3j/XDAXHED0K0TkLdlz5zpmUr+MQtD4d73Q7NmxxUGAGPzu6wmYbItwxaELDhGI
         OChUm+KddPrwSKDBRDn2jP9Cmz8sMGNiRrM7TwxiRFa698s7flVazpEeC+9soz5p6eQZ
         VPyCTtMGWyHurppOIuI6fVfW5s3dN63XNlBUbJ+CBR2eLVlMDI8qaGUBJDPICuQyb9xf
         fwqFaWw4548vRi704SVGxALKRQtt5TRkeXVzVc98B2g7s3MjZ9Cm3eMWQ8nlT+5+uYil
         TRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EWtkEswA/ppJKsau0ucZOXQ0FjybdP/7oMBp2mQhOUw=;
        b=t6ogQ+arA6AHq8qn/DsMpeK4aerrtrRaKgQTOxhjUR8Q3uRLGsLw4ARrR3Yk+bi1tl
         zrA9NOd4xmfRJnjZT1bUoELe6XcW0eupdDl+B1sfIF7h8U3vcvtiIvILMBYbM06NEzhz
         HPwpVMKRyKuwVzzQoPL9bee8Eu8jQyiCN7AsN+2YDdzGKjrVxwG2N9HVfW0hYbYUjpJM
         cAwkR6U9SzP03RvU9g0YnvVVE7zAqkSFN1EaheQnR1SKLTUxfRqnwrfySLlt6HrIbNA+
         Z98AA8Wor3xSekNkOke3Ta5rgOGHUxDuu5HIH0WLYE04RIgjsXPb6Q6IhVZvcbp6wbS+
         8esA==
X-Gm-Message-State: APjAAAWkSB8rwztIK2LkvTUeQICVQwQ4aOVhjV3OpACFQiyjURS726NU
        9WDkzBzyGk5tZDG3PesFTHqMDA==
X-Google-Smtp-Source: APXvYqxXPvbmkZ/JeMcYsFo0xhtMoTpufPAZlIYKJ5y98iS14sch/g7gCjShBgCuduCIqa37iD48fQ==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr17354279wmt.33.1556543539028;
        Mon, 29 Apr 2019 06:12:19 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f9fc:88:6502:8fa7])
        by smtp.gmail.com with ESMTPSA id s16sm5410282wrg.71.2019.04.29.06.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 06:12:18 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-gpio@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 4/4] gpio: mb86s7x: enable ACPI support
Date:   Mon, 29 Apr 2019 15:12:08 +0200
Message-Id: <20190429131208.3620-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
References: <20190429131208.3620-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
support for ACPI GPIO interrupts routed via platform interrupts, by
wiring the two together via the to_irq() gpiochip callback.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/gpio/gpio-mb86s7x.c | 57 ++++++++++++++++----
 1 file changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 3134c0d2bfe4..61ad95c3e3d2 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -14,6 +14,7 @@
  *  GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/clk.h>
@@ -27,6 +28,8 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
+#include "gpiolib.h"
+
 /*
  * Only first 8bits of a register correspond to each pin,
  * so there are 4 registers for 32 pins.
@@ -143,6 +146,20 @@ static void mb86s70_gpio_set(struct gpio_chip *gc, unsigned gpio, int value)
 	spin_unlock_irqrestore(&gchip->lock, flags);
 }
 
+static int mb86s70_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	int irq, index;
+
+	for (index = 0;; index++) {
+		irq = platform_get_irq(to_platform_device(gc->parent), index);
+		if (irq <= 0)
+			break;
+		if (irq_get_irq_data(irq)->hwirq == offset)
+			return irq;
+	}
+	return -EINVAL;
+}
+
 static int mb86s70_gpio_probe(struct platform_device *pdev)
 {
 	struct mb86s70_gpio_chip *gchip;
@@ -160,13 +177,15 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gchip->base))
 		return PTR_ERR(gchip->base);
 
-	gchip->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(gchip->clk))
-		return PTR_ERR(gchip->clk);
+	if (!ACPI_COMPANION(&pdev->dev)) {
+		gchip->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(gchip->clk))
+			return PTR_ERR(gchip->clk);
 
-	ret = clk_prepare_enable(gchip->clk);
-	if (ret)
-		return ret;
+		ret = clk_prepare_enable(gchip->clk);
+		if (ret)
+			return ret;
+	}
 
 	spin_lock_init(&gchip->lock);
 
@@ -182,21 +201,32 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 	gchip->gc.parent = &pdev->dev;
 	gchip->gc.base = -1;
 
+	if (ACPI_COMPANION(&pdev->dev))
+		gchip->gc.to_irq = mb86s70_gpio_to_irq;
+
 	ret = gpiochip_add_data(&gchip->gc, gchip);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't register gpio driver\n");
-		clk_disable_unprepare(gchip->clk);
+		if (gchip->clk)
+			clk_disable_unprepare(gchip->clk);
+		return ret;
 	}
 
-	return ret;
+	if (ACPI_COMPANION(&pdev->dev))
+		acpi_gpiochip_request_interrupts(&gchip->gc);
+
+	return 0;
 }
 
 static int mb86s70_gpio_remove(struct platform_device *pdev)
 {
 	struct mb86s70_gpio_chip *gchip = platform_get_drvdata(pdev);
 
+	if (ACPI_COMPANION(&pdev->dev))
+		acpi_gpiochip_free_interrupts(&gchip->gc);
 	gpiochip_remove(&gchip->gc);
-	clk_disable_unprepare(gchip->clk);
+	if (gchip->clk)
+		clk_disable_unprepare(gchip->clk);
 
 	return 0;
 }
@@ -207,10 +237,19 @@ static const struct of_device_id mb86s70_gpio_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mb86s70_gpio_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id mb86s70_gpio_acpi_ids[] = {
+	{ "SCX0007" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, mb86s70_gpio_acpi_ids);
+#endif
+
 static struct platform_driver mb86s70_gpio_driver = {
 	.driver = {
 		.name = "mb86s70-gpio",
 		.of_match_table = mb86s70_gpio_dt_ids,
+		.acpi_match_table = ACPI_PTR(mb86s70_gpio_acpi_ids),
 	},
 	.probe = mb86s70_gpio_probe,
 	.remove = mb86s70_gpio_remove,
-- 
2.20.1

