Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52BD4550F9
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 00:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbhKQXTX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 18:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233853AbhKQXTX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 18:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637190984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsYM6rYou62x11x/LJq8mgm1ac1K9iDKo9U5tu3rccY=;
        b=FlhR3NeRcMMRE9jZmp1T/z9L4XoQp/O2Mo+9j+L030l/ZKYvbB2pXWPFMVZT1GRRAcrule
        HsX5Tdyu/XV6BEHkbBHXcLNWXl6D9/6i3KC5Wc/pYWIbrn4nqAUloy/y1Gg74ilgfJmrzN
        tGrDMYZRU65UnPnAHpJ9xzV35Bh2p5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-BwPyJABNOxCYHWHiEOnAfA-1; Wed, 17 Nov 2021 18:16:21 -0500
X-MC-Unique: BwPyJABNOxCYHWHiEOnAfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF8789F92C;
        Wed, 17 Nov 2021 23:16:19 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D668210016F4;
        Wed, 17 Nov 2021 23:16:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 2/3] pinctrl: cherryview: Do not allow the same intr-line to be used by 2 pins
Date:   Thu, 18 Nov 2021 00:16:13 +0100
Message-Id: <20211117231614.758362-2-hdegoede@redhat.com>
In-Reply-To: <20211117231614.758362-1-hdegoede@redhat.com>
References: <20211117231614.758362-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It is impossible to use the same intr-line for 2 pins, this will result
in the interrupts only being delivered to the irq-handler for the pin for
which chv_gpio_irq_type() was called last.

The pinctrl-cherryview.c code relies on the BIOS to correctly setup the
interrupt-line, but there is a BIOS bug on at least the Medion Akoya E1239T
and the GPD win models where both INT33FF:02 pin 8, used by the powerbutton
and INT33FF:02 pin 21 used as IRQ input for the accelerometer are mapped to
interrupt-line 0.

This causes 2 problems:
1. The accelerometer IRQ does not work, since the power-button is probed
later taking over the intr_lines[0] slot.

2. Since the accelerometer IRQ is not marked as wakeup, interrupt-line 0
gets masked on suspend, causing the power-button to not work to wake
the system from suspend.

Likewise on the Lenovo Yogabook which has a touchscreen as keyboard
and the keyboard half of the tablet also has a drawing tablet, the
BIOS by default assigns the same interrupt-line to the GPIOs used
for their interrupts.

Fix these problems by adding a check for this and assigning a new
interrupt-line to the 2nd pin for which chv_gpio_irq_type() gets called.

With this fix in place the following 2 messages show up in dmesg on
the Medion Akoya E1239T and the GPD win:

 cherryview-pinctrl INT33FF:02: [Firmware Bug]: interrupt-line 0 is used by both pin 21 and pin 8
 cherryview-pinctrl INT33FF:02: Changing the interrupt-line for pin 8 to 15

And the following gets logged on the Lenovo Yogabook:

 cherryview-pinctrl INT33FF:01: Interrupt-line 0 is used by both pin 49 and pin
 cherryview-pinctrl INT33FF:01: Changing the interrupt-line for pin 56 to 7

Note commit 9747070c11d6 ("Input: axp20x-pek - always register interrupt
handlers") was added as a work around for the power-button not being able
to wakeup the system. This relies on using the PMIC's connection to the
powerbutton but that only works on systems with the AXP288 PMIC.
Once this fix has been merged that workaround can be removed.

Cc: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 69 +++++++++++++++++++---
 1 file changed, 61 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index a46f9e5a4748..491b234812cd 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1323,6 +1323,8 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 
 		if (cctx->intr_lines[intsel] == INTR_LINE_UNUSED) {
 			irq_set_handler_locked(d, handler);
+			dev_dbg(pctrl->dev, "Using interrupt-line %u for IRQ_TYPE_NONE IRQ on pin %u\n",
+				intsel, pin);
 			cctx->intr_lines[intsel] = pin;
 		}
 		raw_spin_unlock_irqrestore(&chv_lock, flags);
@@ -1332,17 +1334,73 @@ static unsigned chv_gpio_irq_startup(struct irq_data *d)
 	return 0;
 }
 
+static int chv_gpio_set_intr_line(struct intel_pinctrl *pctrl, unsigned int pin)
+{
+	struct intel_community_context *cctx = &pctrl->context.communities[0];
+	const struct intel_community *community = &pctrl->communities[0];
+	u32 value, intsel;
+	int i;
+
+	value = chv_readl(pctrl, pin, CHV_PADCTRL0);
+	intsel = (value & CHV_PADCTRL0_INTSEL_MASK) >> CHV_PADCTRL0_INTSEL_SHIFT;
+
+	if (cctx->intr_lines[intsel] == pin)
+		return 0;
+
+	if (cctx->intr_lines[intsel] == INTR_LINE_UNUSED) {
+		dev_dbg(pctrl->dev, "Using interrupt-line %u for pin %u\n", intsel, pin);
+		cctx->intr_lines[intsel] = pin;
+		return 0;
+	}
+
+	/*
+	 * The interrupt-line selected by the BIOS is already in use by
+	 * another pin, this is a known BIOS bug found on several models.
+	 * But this may also be caused by Linux deciding to use a pin as
+	 * IRQ which was not expected to be used as such by the BIOS authors,
+	 * so log this at info level only.
+	 */
+	dev_info(pctrl->dev, "Interrupt-line %u is used by both pin %u and pin %u\n",
+		 intsel, cctx->intr_lines[intsel], pin);
+
+	if (chv_pad_locked(pctrl, pin))
+		return -EBUSY;
+
+	/*
+	 * The BIOS fills the interrupt lines from 0 counting up, start at
+	 * the other end to find a free interrupt-line to workaround this.
+	 */
+	for (i = community->nirqs - 1; i >= 0; i--) {
+		if (cctx->intr_lines[i] == INTR_LINE_UNUSED)
+			break;
+	}
+	if (i < 0)
+		return -EBUSY;
+
+	dev_info(pctrl->dev, "Changing the interrupt-line for pin %u to %d\n", pin, i);
+
+	value = (value & ~CHV_PADCTRL0_INTSEL_MASK) | (i << CHV_PADCTRL0_INTSEL_SHIFT);
+	chv_writel(pctrl, pin, CHV_PADCTRL0, value);
+	cctx->intr_lines[i] = pin;
+
+	return 0;
+}
+
 static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct intel_pinctrl *pctrl = gpiochip_get_data(gc);
-	struct intel_community_context *cctx = &pctrl->context.communities[0];
 	unsigned int pin = irqd_to_hwirq(d);
 	unsigned long flags;
 	u32 value;
+	int ret;
 
 	raw_spin_lock_irqsave(&chv_lock, flags);
 
+	ret = chv_gpio_set_intr_line(pctrl, pin);
+	if (ret)
+		goto out_unlock;
+
 	/*
 	 * Pins which can be used as shared interrupt are configured in
 	 * BIOS. Driver trusts BIOS configurations and assigns different
@@ -1377,20 +1435,15 @@ static int chv_gpio_irq_type(struct irq_data *d, unsigned int type)
 		chv_writel(pctrl, pin, CHV_PADCTRL1, value);
 	}
 
-	value = chv_readl(pctrl, pin, CHV_PADCTRL0);
-	value &= CHV_PADCTRL0_INTSEL_MASK;
-	value >>= CHV_PADCTRL0_INTSEL_SHIFT;
-
-	cctx->intr_lines[value] = pin;
-
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		irq_set_handler_locked(d, handle_edge_irq);
 	else if (type & IRQ_TYPE_LEVEL_MASK)
 		irq_set_handler_locked(d, handle_level_irq);
 
+out_unlock:
 	raw_spin_unlock_irqrestore(&chv_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static void chv_gpio_irq_handler(struct irq_desc *desc)
-- 
2.31.1

