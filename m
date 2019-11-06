Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB1F15D6
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfKFMKO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 07:10:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729286AbfKFMKO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2019 07:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573042213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5G1asKsUNUKJB03arX4WU6tZHsp+n4Hx8Y8KjnqvdSU=;
        b=DIpr2lyILmK+js/b7UMb0WfVHfBN5L2uHRRrflMm2i5vLoaSi4NDjWJr/QBd/X7qYkHxGg
        5AuJ9l+CnL3nQbetVmphx7HcmF/F4WVEepv8mhnuxs1Pu7DY9FFun8GDXL+VgCXfxRsPdD
        AB1MrRCi558i1jlsAzqG/s5WCKniF8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-UOnf0gPlP9qCfCgcPB8j_A-1; Wed, 06 Nov 2019 07:10:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076F61005500;
        Wed,  6 Nov 2019 12:10:09 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-167.ams2.redhat.com [10.36.116.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D31D60852;
        Wed,  6 Nov 2019 12:10:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] pinctrl: cherryview: Pass irqchip when adding gpiochip
Date:   Wed,  6 Nov 2019 13:09:56 +0100
Message-Id: <20191106120956.119958-4-hdegoede@redhat.com>
In-Reply-To: <20191106120956.119958-1-hdegoede@redhat.com>
References: <20191106120956.119958-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: UOnf0gPlP9qCfCgcPB8j_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We need to convert all old gpio irqchips to pass the irqchip
setup along when adding the gpio_chip. For more info see
drivers/gpio/TODO.

For chained irqchips this is a pretty straight-forward conversion.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 41 +++++++++++-----------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/i=
ntel/pinctrl-cherryview.c
index 38b359db6013..1f9751ae0ed0 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -166,6 +166,7 @@ struct chv_pinctrl {
 =09struct irq_chip irqchip;
 =09void __iomem *regs;
 =09bool need_valid_mask;
+=09unsigned int irq;
 =09unsigned intr_lines[16];
 =09const struct chv_community *community;
 =09u32 saved_intmask;
@@ -1619,16 +1620,25 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl=
, int irq)
 =09chip->add_pin_ranges =3D chv_gpio_add_pin_ranges;
 =09chip->parent =3D pctrl->dev;
 =09chip->base =3D -1;
-=09if (pctrl->need_valid_mask)
-=09=09chip->irq.init_valid_mask =3D chv_init_irq_valid_mask;
=20
-=09ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
-=09if (ret) {
-=09=09dev_err(pctrl->dev, "Failed to register gpiochip\n");
-=09=09return ret;
-=09}
+=09pctrl->irq =3D irq;
+=09pctrl->irqchip.name =3D "chv-gpio";
+=09pctrl->irqchip.irq_startup =3D chv_gpio_irq_startup;
+=09pctrl->irqchip.irq_ack =3D chv_gpio_irq_ack;
+=09pctrl->irqchip.irq_mask =3D chv_gpio_irq_mask;
+=09pctrl->irqchip.irq_unmask =3D chv_gpio_irq_unmask;
+=09pctrl->irqchip.irq_set_type =3D chv_gpio_irq_type;
+=09pctrl->irqchip.flags =3D IRQCHIP_SKIP_SET_WAKE;
=20
-=09chv_gpio_irq_init_hw(chip);
+=09chip->irq.chip =3D &pctrl->irqchip;
+=09if (pctrl->need_valid_mask)
+=09=09chip->irq.init_valid_mask =3D chv_init_irq_valid_mask;
+=09chip->irq.init_hw =3D chv_gpio_irq_init_hw;
+=09chip->irq.parent_handler =3D chv_gpio_irq_handler;
+=09chip->irq.num_parents =3D 1;
+=09chip->irq.parents =3D &pctrl->irq;
+=09chip->irq.default_type =3D IRQ_TYPE_NONE;
+=09chip->irq.handler =3D handle_bad_irq;
=20
 =09if (!pctrl->need_valid_mask) {
 =09=09irq_base =3D devm_irq_alloc_descs(pctrl->dev, -1, 0,
@@ -1639,18 +1649,9 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl,=
 int irq)
 =09=09}
 =09}
=20
-=09pctrl->irqchip.name =3D "chv-gpio";
-=09pctrl->irqchip.irq_startup =3D chv_gpio_irq_startup;
-=09pctrl->irqchip.irq_ack =3D chv_gpio_irq_ack;
-=09pctrl->irqchip.irq_mask =3D chv_gpio_irq_mask;
-=09pctrl->irqchip.irq_unmask =3D chv_gpio_irq_unmask;
-=09pctrl->irqchip.irq_set_type =3D chv_gpio_irq_type;
-=09pctrl->irqchip.flags =3D IRQCHIP_SKIP_SET_WAKE;
-
-=09ret =3D gpiochip_irqchip_add(chip, &pctrl->irqchip, 0,
-=09=09=09=09   handle_bad_irq, IRQ_TYPE_NONE);
+=09ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
 =09if (ret) {
-=09=09dev_err(pctrl->dev, "failed to add IRQ chip\n");
+=09=09dev_err(pctrl->dev, "Failed to register gpiochip\n");
 =09=09return ret;
 =09}
=20
@@ -1664,8 +1665,6 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, =
int irq)
 =09=09}
 =09}
=20
-=09gpiochip_set_chained_irqchip(chip, &pctrl->irqchip, irq,
-=09=09=09=09     chv_gpio_irq_handler);
 =09return 0;
 }
=20
--=20
2.23.0

