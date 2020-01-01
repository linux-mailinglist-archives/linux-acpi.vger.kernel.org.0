Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57012DF35
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Jan 2020 15:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgAAOwv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Jan 2020 09:52:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbgAAOwv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jan 2020 09:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577890370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+WIBYQKmfgWPDIKqBy8YnivVDbGmqODUzJykzABmCSA=;
        b=fWSN2tT2p8QyzjBYuDj4bCBURdx21Lqm6zdvgyZi21mhzyI2LOj0+ZF/89LGUtyUjnE8PB
        qY5hfXvZuFPcmzRGSNyPH6GECXDSm6F3DwkAQLoPc0e+VuM6yuMg5QL6ZL6ELopD6cLYqf
        ysxv8mQxJsn4BCLYu9OcR277I3JvRYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-_ZXRW92xMTSDI3SGT91b_Q-1; Wed, 01 Jan 2020 09:52:48 -0500
X-MC-Unique: _ZXRW92xMTSDI3SGT91b_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24D8B1005516;
        Wed,  1 Jan 2020 14:52:47 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-55.ams2.redhat.com [10.36.116.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FF825C1B2;
        Wed,  1 Jan 2020 14:52:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3] pinctrl: baytrail: Replace WARN with dev_info_once when setting direct-irq pin to output
Date:   Wed,  1 Jan 2020 15:52:43 +0100
Message-Id: <20200101145243.15912-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

This commit replaces the WARN call with a dev_info_once call, fixing a
bunch of WARN splats in dmesg on each suspend/resume cycle.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Replace WARN with a dev_info_once call, instead of dropping it

Changes in v2:
- Drop now unused conf_ref local variable
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/i=
ntel/pinctrl-baytrail.c
index c6f53ed626c9..17e6740a36c5 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -811,15 +811,15 @@ static int byt_gpio_set_direction(struct pinctrl_de=
v *pctl_dev,
 	value &=3D ~BYT_DIR_MASK;
 	if (input)
 		value |=3D BYT_OUTPUT_EN;
-	else
+	else if (readl(conf_reg) & BYT_DIRECT_IRQ_EN)
 		/*
 		 * Before making any direction modifications, do a check if gpio
 		 * is set for direct IRQ.  On baytrail, setting GPIO to output
 		 * does not make sense, so let's at least warn the caller before
 		 * they shoot themselves in the foot.
 		 */
-		WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
-		     "Potential Error: Setting GPIO with direct_irq_en to output");
+		dev_info_once(vg->dev, "Potential Error: Setting GPIO with direct_irq_=
en to output");
+
 	writel(value, val_reg);
=20
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
--=20
2.24.1

