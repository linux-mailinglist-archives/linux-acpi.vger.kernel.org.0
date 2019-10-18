Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D2BDCF9E
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Oct 2019 21:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443368AbfJRTwN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Oct 2019 15:52:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443367AbfJRTwM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Oct 2019 15:52:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFA8088FFFC;
        Fri, 18 Oct 2019 19:52:12 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-168.ams2.redhat.com [10.36.117.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61D535C1B5;
        Fri, 18 Oct 2019 19:52:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Print pin number on acpi_gpiochip_alloc_event errors
Date:   Fri, 18 Oct 2019 21:52:08 +0200
Message-Id: <20191018195208.94405-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Fri, 18 Oct 2019 19:52:12 +0000 (UTC)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Print pin number on acpi_gpiochip_alloc_event errors, to help debugging
these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 609ed16ae933..2911dd6f2625 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -230,19 +230,22 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 	desc = gpiochip_request_own_desc(chip, pin, "ACPI:Event",
 					 GPIO_ACTIVE_HIGH, GPIOD_IN);
 	if (IS_ERR(desc)) {
-		dev_err(chip->parent, "Failed to request GPIO\n");
+		dev_err(chip->parent,
+			"Failed to request GPIO for pin 0x%02X\n", pin);
 		return AE_ERROR;
 	}
 
 	ret = gpiochip_lock_as_irq(chip, pin);
 	if (ret) {
-		dev_err(chip->parent, "Failed to lock GPIO as interrupt\n");
+		dev_err(chip->parent,
+			"Failed to lock GPIO pin 0x%02X as interrupt\n", pin);
 		goto fail_free_desc;
 	}
 
 	irq = gpiod_to_irq(desc);
 	if (irq < 0) {
-		dev_err(chip->parent, "Failed to translate GPIO to IRQ\n");
+		dev_err(chip->parent,
+			"Failed to translate GPIO pin 0x%02X to IRQ\n", pin);
 		goto fail_unlock_irq;
 	}
 
-- 
2.23.0

