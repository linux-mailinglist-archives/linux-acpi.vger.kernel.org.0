Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6B112BBBE
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Dec 2019 00:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfL0XEz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Dec 2019 18:04:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24923 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbfL0XEz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Dec 2019 18:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577487894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l0SdVAhVPQ42qaTt6y2m+vLP6dr1tqwtZ8loUPh9QNk=;
        b=g7WZx8CsKTEeXwTt1/jHOmhwgZmvYQws2cNvxpAR6nMOm9giQtD3o7NdeWhxFp2ll+oaPg
        P9JLOQvaw9QlmQ/vIZzr+0EkSksLckl/xmTc1cPHtK1cwgyWy6CifYO2I+LyAYXOw4rRyu
        BQSwYxG+ZNBKhf4dq6KggM9G975mZXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-fyTQpu2XNea_2--TEDhbOg-1; Fri, 27 Dec 2019 18:04:53 -0500
X-MC-Unique: fyTQpu2XNea_2--TEDhbOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD381005502;
        Fri, 27 Dec 2019 23:04:51 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-21.ams2.redhat.com [10.36.116.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 341BE107A44F;
        Fri, 27 Dec 2019 23:04:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Dmitry Mastykin <mastichi@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH] pinctrl: baytrail: Do not clear IRQ flags on direct-irq enabled pins
Date:   Sat, 28 Dec 2019 00:04:47 +0100
Message-Id: <20191227230447.32458-1-hdegoede@redhat.com>
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

On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
in combination with listing the pin as a normal GpioIo resource.

This works fine, until the goodix driver gets rmmod-ed and then insmod-ed
again. In this case byt_gpio_disable_free() calls
byt_gpio_clear_triggering() which clears the IRQ flags and after that the
(direct) IRQ no longer triggers.

This commit fixes this by adding a check for the BYT_DIRECT_IRQ_EN flag
to byt_gpio_clear_triggering().

Note that byt_gpio_clear_triggering() only gets called from
byt_gpio_disable_free() for direct-irq enabled pins, as these are exclude=
d
from the irq_valid mask by byt_init_irq_valid_mask().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/i=
ntel/pinctrl-baytrail.c
index db55761c90cc..844b89f230d7 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -742,8 +742,13 @@ static void byt_gpio_clear_triggering(struct intel_p=
inctrl *vg, unsigned int off
=20
 	raw_spin_lock_irqsave(&byt_lock, flags);
 	value =3D readl(reg);
+	/* Do not clear direct-irq enabled irqs (from gpio_disable_free) */
+	if (value & BYT_DIRECT_IRQ_EN)
+		goto out;
+
 	value &=3D ~(BYT_TRIG_POS | BYT_TRIG_NEG | BYT_TRIG_LVL);
 	writel(value, reg);
+out:
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
 }
=20
--=20
2.24.1

