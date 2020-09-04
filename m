Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF925E0A8
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 19:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIDRVt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 13:21:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39234 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725984AbgIDRVs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 13:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599240106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tEP7qkThO7ydzEyaSehPngXzv5x4Vil8nhBwwfph2fQ=;
        b=cuonf4Ewni/LXn2SnuGk1hSWPzfcvGNUcNXK7dIYQaOAv96luI63/eIJ1I+QsDpFJBjLqO
        RNXFYQ0cO5Q6WNSp/PxRh4OCW9oXJTikmz8NJebHbrffi3XLP+Y9L/c33CImNacpBRiqDk
        MWtym0LH2lE0ul18Wgm+FwTxDsoFPZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ETpTHIHsPpehBqdsYA8h0A-1; Fri, 04 Sep 2020 13:21:45 -0400
X-MC-Unique: ETpTHIHsPpehBqdsYA8h0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07DB185B686;
        Fri,  4 Sep 2020 17:21:44 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-35.ams2.redhat.com [10.36.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDE3A60BF1;
        Fri,  4 Sep 2020 17:21:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] pinctrl: cherryview: Preserve CHV_PADCTRL1_INVRXTX_TXDATA flag on GPIOs
Date:   Fri,  4 Sep 2020 19:21:41 +0200
Message-Id: <20200904172141.180363-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

One some devices the GPIO should output the inverted value from what
device-drivers / ACPI code expects. The reason for this is unknown,
perhaps these systems use an external buffer chip on the GPIO which
inverts the signal. The BIOS makes this work by setting the
CHV_PADCTRL1_INVRXTX_TXDATA flag.

Before this commit we would unconditionally clear all INVRXTX flags,
including the CHV_PADCTRL1_INVRXTX_TXDATA flag when a GPIO is requested
by a driver (from chv_gpio_request_enable()).

This breaks systems using this setup. Specifically it is causing
problems for systems with a goodix touchscreen, where the BIOS sets the
INVRXTX_TXDATA flag on the GPIO used for the touchscreen's reset pin.

The goodix touchscreen driver by defaults configures this pin as input
(relying on the pull-up to keep it high), but the clearing of the
INVRXTX_TXDATA flag done by chv_gpio_request_enable() causes it to be
driven low for a brief time before the GPIO gets set to input mode.

This causes the touchscreen controller to get reset. On most CHT devs
with this touchscreen this leads to:

[   31.596534] Goodix-TS i2c-GDIX1001:00: i2c test failed attempt 1: -121

The driver retries this though and then everything is fine. But during
reset the touchscreen uses its interrupt pin as bootstrap to determine
which i2c address to use and on the Acer One S1003 the spurious reset
caused by the clearing of the INVRXTX_TXDATA flag causes the controller
to come back up again on the wrong i2c address, breaking things.

This commit fixes both the -121 errors, as well as the total breakage
on the Acer One S1003, by making chv_gpio_clear_triggering() not clear
the INVRXTX_TXDATA flag if the pin is already configured as a GPIO.

Note that chv_pinmux_set_mux() does still unconditionally clear the
flag, so this only affects GPIO usage.

Fixes: a7d4b171660c ("Input: goodix - add support for getting IRQ + reset GPIOs on Cherry Trail devices")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 33862bb1e0e2..41ee77bf893e 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -64,6 +64,7 @@
 #define CHV_PADCTRL1_CFGLOCK		BIT(31)
 #define CHV_PADCTRL1_INVRXTX_SHIFT	4
 #define CHV_PADCTRL1_INVRXTX_MASK	GENMASK(7, 4)
+#define CHV_PADCTRL1_INVRXTX_TXDATA	BIT(7)
 #define CHV_PADCTRL1_INVRXTX_RXDATA	BIT(6)
 #define CHV_PADCTRL1_INVRXTX_TXENABLE	BIT(5)
 #define CHV_PADCTRL1_ODEN		BIT(3)
@@ -798,11 +799,22 @@ static int chv_pinmux_set_mux(struct pinctrl_dev *pctldev,
 static void chv_gpio_clear_triggering(struct chv_pinctrl *pctrl,
 				      unsigned int offset)
 {
+	u32 invrxtx_mask = CHV_PADCTRL1_INVRXTX_MASK;
 	u32 value;
 
+	/*
+	 * One some devices the GPIO should output the inverted value from what
+	 * device-drivers / ACPI code expects (inverted external buffer?). The
+	 * BIOS makes this work by setting the CHV_PADCTRL1_INVRXTX_TXDATA flag,
+	 * preserve this flag if the pin is already setup as GPIO.
+	 */
+	value = chv_readl(pctrl, offset, CHV_PADCTRL0);
+	if (value & CHV_PADCTRL0_GPIOEN)
+		invrxtx_mask &= ~CHV_PADCTRL1_INVRXTX_TXDATA;
+
 	value = chv_readl(pctrl, offset, CHV_PADCTRL1);
 	value &= ~CHV_PADCTRL1_INTWAKECFG_MASK;
-	value &= ~CHV_PADCTRL1_INVRXTX_MASK;
+	value &= ~invrxtx_mask;
 	chv_writel(pctrl, offset, CHV_PADCTRL1, value);
 }
 
-- 
2.28.0

