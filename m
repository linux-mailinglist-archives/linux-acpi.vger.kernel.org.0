Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62312A837
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Dec 2019 14:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLYN2T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Dec 2019 08:28:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56291 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726289AbfLYN2S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Dec 2019 08:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577280497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BLxiTJ10kXJAxHgsCQIVOiCm+kcYau2SMSoZjreP3vQ=;
        b=Gc3d+HaXKzGVtV6rEif0V3kI4IHesU55t+IpVB4XCxyLr54GmbOJJzvL/8FWvG1KQBxGUW
        BrgOFXOxVOtn3xflEjYv7Kr/AtKCF8cSfoj5L6MVChxG5T4h2Uh72ka5vG6GsVL3lyoX39
        2t5IH90HRNo8L57emVltIMlIkk2frKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-BXslORRZN1m7xyPLM9Ny5A-1; Wed, 25 Dec 2019 08:28:16 -0500
X-MC-Unique: BXslORRZN1m7xyPLM9Ny5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A01431005513;
        Wed, 25 Dec 2019 13:28:14 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-79.ams2.redhat.com [10.36.116.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BDDA101F6CF;
        Wed, 25 Dec 2019 13:28:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2] pinctrl: baytrail: Remove WARN when setting direct-irq pin to output
Date:   Wed, 25 Dec 2019 14:28:12 +0100
Message-Id: <20191225132812.90889-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Suspending Goodix touchscreens requires changing the interrupt pin to
output before sending them a power-down command. Followed by wiggling
the interrupt pin to wake the device up, after which it is put back
in input mode.

On Cherry Trail device the interrupt pin is listed as a GpioInt ACPI
resource so we can do this without problems as long as we release the
irq before changing the pin to output mode.

On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
in combination with listing the pin as a normal GpioIo resource. This
works fine, but this triggers the WARN in byt_gpio_set_direction-s output
path because direct-irq support is enabled on the pin.

This commit removes the WARN call, fixing a bunch of WARN splats in
dmesg on each suspend/resume cycle.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop now unused conf_ref local variable
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/i=
ntel/pinctrl-baytrail.c
index c6f53ed626c9..db55761c90cc 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -801,7 +801,6 @@ static int byt_gpio_set_direction(struct pinctrl_dev =
*pctl_dev,
 {
 	struct intel_pinctrl *vg =3D pinctrl_dev_get_drvdata(pctl_dev);
 	void __iomem *val_reg =3D byt_gpio_reg(vg, offset, BYT_VAL_REG);
-	void __iomem *conf_reg =3D byt_gpio_reg(vg, offset, BYT_CONF0_REG);
 	unsigned long flags;
 	u32 value;
=20
@@ -811,15 +810,7 @@ static int byt_gpio_set_direction(struct pinctrl_dev=
 *pctl_dev,
 	value &=3D ~BYT_DIR_MASK;
 	if (input)
 		value |=3D BYT_OUTPUT_EN;
-	else
-		/*
-		 * Before making any direction modifications, do a check if gpio
-		 * is set for direct IRQ.  On baytrail, setting GPIO to output
-		 * does not make sense, so let's at least warn the caller before
-		 * they shoot themselves in the foot.
-		 */
-		WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
-		     "Potential Error: Setting GPIO with direct_irq_en to output");
+
 	writel(value, val_reg);
=20
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
--=20
2.24.1

