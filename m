Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6082B339
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2019 13:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfE0L1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 May 2019 07:27:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45576 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfE0L1d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 May 2019 07:27:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so16547512wrq.12
        for <linux-acpi@vger.kernel.org>; Mon, 27 May 2019 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9zX2z3pSYijNeNpg5u5hKyLCBvOSleyi01zr0ij8D4=;
        b=o+5ppKL9dNkBIcyZZcUftTzeWppQdogCl1qYHsBuVV/XyuGMt/AlB5fOZri5jHhd34
         qFz6Ux0nSgvLtFsGO9gPPLnZtwzPJi02TaZfT7BetkEDPrm24fJgBtnk7Q/rU/IPwrms
         NWJHi8PAibeQnNHhruEHAONTPvPr3xwJIZmNYnoBoAzc045kPA3Y/Uoa0jMQaWuOUicz
         uJCS9Z0f3A5YvhTO5sEdJPwJspoSpk3aiG9KRhSv2O0LzRERXUQfPKlXwyGXnL0NrgeY
         eBrlw7/VCwwCND+dGC4gbezqpoq43aAIvTmn+HgKUgppwm0m3h/rid57HNCUPf4eoT1/
         O/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9zX2z3pSYijNeNpg5u5hKyLCBvOSleyi01zr0ij8D4=;
        b=UXBefbOIkcwlPF1odTDCoiV9A9WpBAhIF1eMgR9zSo0rnJocgziL+7T6F+QTxJVPNQ
         OPwCHp2h19gAnGoTz3l8f2lf5oJJPUUqQ2nPdDNzl5kOpFCeVE/4DFVS+vE/2T9TeE9q
         Vgn+4zs7pxHDUG01OkjgXSlje4zy4CXCls1spE8YsLQX+1hyoFfGCeGkW9Nknccl7CPM
         VZT43qJ6HqwiZ96YK5ZeeCB+l5SZXbUnwodd7pOlVN5y5oWorRyQy14qNOGYGkjvrFs2
         Eqep2R9R+EsOJ/T0RpFgtW9GNsCLm9c3PDIjh3Kn5Zmr2kGi+bzWMFiqGAdKicZZGW8a
         ohIQ==
X-Gm-Message-State: APjAAAUYLHpY4Y3lbNR5T99qdaz6eQaaE1lwArytSII2oZx6LoD+lO5u
        rkZPiQK/1YZENQMwXEtz8inCHw==
X-Google-Smtp-Source: APXvYqxN/Jdd3x8rG3kSzj6Bl44tI1FDNTwzVb4CqQXtbJioOQeKqfOdDM37wYuzii6qz6ltvOtbXA==
X-Received: by 2002:adf:e544:: with SMTP id z4mr5023149wrm.295.1558956450699;
        Mon, 27 May 2019 04:27:30 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:ccdd:dadc:1517:f416])
        by smtp.gmail.com with ESMTPSA id l6sm9677747wmi.24.2019.05.27.04.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 04:27:29 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v3 4/4] gpio: mb86s7x: enable ACPI support
Date:   Mon, 27 May 2019 13:27:20 +0200
Message-Id: <20190527112720.2266-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
References: <20190527112720.2266-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Make the mb86s7x GPIO block discoverable via ACPI. In addition, add
support for ACPI GPIO interrupts routed via platform interrupts, by
wiring the two together via the to_irq() gpiochip callback.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/gpio/gpio-mb86s7x.c | 51 +++++++++++++++++---
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 9308081e0a4a..64027f57a8aa 100644
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
@@ -158,13 +175,15 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 	if (IS_ERR(gchip->base))
 		return PTR_ERR(gchip->base);
 
-	gchip->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(gchip->clk))
-		return PTR_ERR(gchip->clk);
+	if (!has_acpi_companion(&pdev->dev)) {
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
 
@@ -180,19 +199,28 @@ static int mb86s70_gpio_probe(struct platform_device *pdev)
 	gchip->gc.parent = &pdev->dev;
 	gchip->gc.base = -1;
 
+	if (has_acpi_companion(&pdev->dev))
+		gchip->gc.to_irq = mb86s70_gpio_to_irq;
+
 	ret = gpiochip_add_data(&gchip->gc, gchip);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't register gpio driver\n");
 		clk_disable_unprepare(gchip->clk);
+		return ret;
 	}
 
-	return ret;
+	if (has_acpi_companion(&pdev->dev))
+		acpi_gpiochip_request_interrupts(&gchip->gc);
+
+	return 0;
 }
 
 static int mb86s70_gpio_remove(struct platform_device *pdev)
 {
 	struct mb86s70_gpio_chip *gchip = platform_get_drvdata(pdev);
 
+	if (has_acpi_companion(&pdev->dev))
+		acpi_gpiochip_free_interrupts(&gchip->gc);
 	gpiochip_remove(&gchip->gc);
 	clk_disable_unprepare(gchip->clk);
 
@@ -205,10 +233,19 @@ static const struct of_device_id mb86s70_gpio_dt_ids[] = {
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

