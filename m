Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC12BB2C3
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgKTSZL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 13:25:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgKTSZL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 13:25:11 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35612408E;
        Fri, 20 Nov 2020 18:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605896710;
        bh=7u1C77ezA+NldUIOp1VCjNRSbVSP/2dtK2a5CfdVtMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVGhcZZLoE1zznYtKgVaK1cWLAu9tRTnQDm4cVosWoWkb/4ecbahzEyay8IVuFQJB
         h3+AyK0tOcnHohLi4WblbxN8gfz0cXgyB+lt4Vtd+zbgoLIMmpRQx1fYCZtpKccToM
         T686bG0L6yjxR18SEP2MLuKLsHnRKnoSGRpki54o=
Date:   Fri, 20 Nov 2020 12:25:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alban Bedel <albeu@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 007/141] gpio: Fix fall-through warnings for Clang
Message-ID: <9611e213448b27f3f08a010c683d566c712bdbbb.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
warnings by explicitly adding a break and a fallthrough statements
instead of just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpio/gpio-ath79.c   | 1 +
 drivers/gpio/gpiolib-acpi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index d5359341cc6b..678ddd375891 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -123,6 +123,7 @@ static int ath79_gpio_irq_set_type(struct irq_data *data,
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_RISING:
 		polarity |= mask;
+		fallthrough;
 	case IRQ_TYPE_EDGE_FALLING:
 	case IRQ_TYPE_EDGE_BOTH:
 		break;
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 834a12f3219e..23fa9df8241d 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -548,6 +548,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio)
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

