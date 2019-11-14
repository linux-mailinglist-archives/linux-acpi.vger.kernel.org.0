Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51A3FC39D
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 11:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfKNKIQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 05:08:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29628 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbfKNKIQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 05:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573726096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/4hjOnSYaEmffDvR9CwNKE0lewobkPmWt6b5FzStPg=;
        b=PL4z+DbeXl4S4gjV4R77r1zSCW7FgcUL/CuID4bFn7eg2GormOAulxn5D46U2526jOl97I
        A2zASGrTI+1tXtLix5CUosC+RNk+gEL5SQvucq06zFxJSmZuU8Ji/hyIp4AQZndR/N8/Eg
        fcf0hbTWD6lMX/JL+tTjy7vzOVeGDcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-Tu0zJxebON-zVFkulUrqHg-1; Thu, 14 Nov 2019 05:08:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93934107ACC5;
        Thu, 14 Nov 2019 10:08:13 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FB1C5F795;
        Thu, 14 Nov 2019 10:08:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 2/3] pinctrl: cherryview: Add GPIO <-> pin mapping ranges via callback
Date:   Thu, 14 Nov 2019 11:08:03 +0100
Message-Id: <20191114100804.15148-2-hdegoede@redhat.com>
In-Reply-To: <20191114100804.15148-1-hdegoede@redhat.com>
References: <20191114100804.15148-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Tu0zJxebON-zVFkulUrqHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When IRQ chip is instantiated via GPIO library flow, the few functions,
in particular the ACPI event registration mechanism, on some of ACPI based
platforms expect that the pin ranges are initialized to that point.

Add GPIO <-> pin mapping ranges via callback in the GPIO library flow.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 33 ++++++++++++++--------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/i=
ntel/pinctrl-cherryview.c
index 7a4e2af5153c..b3f6f7726b04 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1581,6 +1581,27 @@ static int chv_gpio_irq_init_hw(struct gpio_chip *ch=
ip)
 =09return 0;
 }
=20
+static int chv_gpio_add_pin_ranges(struct gpio_chip *chip)
+{
+=09struct chv_pinctrl *pctrl =3D gpiochip_get_data(chip);
+=09const struct chv_community *community =3D pctrl->community;
+=09const struct chv_gpio_pinrange *range;
+=09int ret, i;
+
+=09for (i =3D 0; i < community->ngpio_ranges; i++) {
+=09=09range =3D &community->gpio_ranges[i];
+=09=09ret =3D gpiochip_add_pin_range(chip, dev_name(pctrl->dev),
+=09=09=09=09=09     range->base, range->base,
+=09=09=09=09=09     range->npins);
+=09=09if (ret) {
+=09=09=09dev_err(pctrl->dev, "failed to add GPIO pin range\n");
+=09=09=09return ret;
+=09=09}
+=09}
+
+=09return 0;
+}
+
 static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
 {
 =09const struct chv_gpio_pinrange *range;
@@ -1593,6 +1614,7 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, =
int irq)
=20
 =09chip->ngpio =3D community->pins[community->npins - 1].number + 1;
 =09chip->label =3D dev_name(pctrl->dev);
+=09chip->add_pin_ranges =3D chv_gpio_add_pin_ranges;
 =09chip->parent =3D pctrl->dev;
 =09chip->base =3D -1;
 =09if (need_valid_mask)
@@ -1604,17 +1626,6 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl,=
 int irq)
 =09=09return ret;
 =09}
=20
-=09for (i =3D 0; i < community->ngpio_ranges; i++) {
-=09=09range =3D &community->gpio_ranges[i];
-=09=09ret =3D gpiochip_add_pin_range(chip, dev_name(pctrl->dev),
-=09=09=09=09=09     range->base, range->base,
-=09=09=09=09=09     range->npins);
-=09=09if (ret) {
-=09=09=09dev_err(pctrl->dev, "failed to add GPIO pin range\n");
-=09=09=09return ret;
-=09=09}
-=09}
-
 =09chv_gpio_irq_init_hw(chip);
=20
 =09if (!need_valid_mask) {
--=20
2.23.0

