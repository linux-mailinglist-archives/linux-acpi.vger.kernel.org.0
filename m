Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9384AFC39C
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 11:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKNKIQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 05:08:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37774 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbfKNKIQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 05:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573726094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hq8legSVbWOSN0Rs4xdroBNv977Ui+CJx0jtbsCWyUM=;
        b=ca+P/GPntuGaO9hFrdAJWEYV6uaeHWMvzO2z7HKcXArOXDu7dWdtkDjClw8RaeBw8mXboh
        SbUs1QiaJWqbafVgJaAl6FTx/RrS+N1fDj07Srj8VMT0dDkt7/r6W4E1hd+lkaReGv64cH
        TAec6fBR2bo0M+ihfKkdy/bFJWzJN0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-yYWDDNVVMnCzswWoUaXpDw-1; Thu, 14 Nov 2019 05:08:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBFEA100550E;
        Thu, 14 Nov 2019 10:08:11 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F87E5F798;
        Thu, 14 Nov 2019 10:08:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v4 1/3] pinctrl: cherryview: Split out irq hw-init into a separate helper function
Date:   Thu, 14 Nov 2019 11:08:02 +0100
Message-Id: <20191114100804.15148-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: yYWDDNVVMnCzswWoUaXpDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Split out irq hw-init into a separate chv_gpio_irq_init_hw() function.
This is a preparation patch for passing the irqchip when adding the
gpiochip.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add kerneldoc for chv_pinctrl.need_valid_mask struct member

Changes in v3:
- Check for pctrl->chip.irq.init_valid_mask instead of storing the result
  of the dmi check in a new need_valid_mask pctrl struct member
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 45 +++++++++++++---------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/i=
ntel/pinctrl-cherryview.c
index 582fa8a75559..7a4e2af5153c 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1555,6 +1555,32 @@ static void chv_init_irq_valid_mask(struct gpio_chip=
 *chip,
 =09}
 }
=20
+static int chv_gpio_irq_init_hw(struct gpio_chip *chip)
+{
+=09struct chv_pinctrl *pctrl =3D gpiochip_get_data(chip);
+
+=09/*
+=09 * The same set of machines in chv_no_valid_mask[] have incorrectly
+=09 * configured GPIOs that generate spurious interrupts so we use
+=09 * this same list to apply another quirk for them.
+=09 *
+=09 * See also https://bugzilla.kernel.org/show_bug.cgi?id=3D197953.
+=09 */
+=09if (!pctrl->chip.irq.init_valid_mask) {
+=09=09/*
+=09=09 * Mask all interrupts the community is able to generate
+=09=09 * but leave the ones that can only generate GPEs unmasked.
+=09=09 */
+=09=09chv_writel(GENMASK(31, pctrl->community->nirqs),
+=09=09=09   pctrl->regs + CHV_INTMASK);
+=09}
+
+=09/* Clear all interrupts */
+=09chv_writel(0xffff, pctrl->regs + CHV_INTSTAT);
+
+=09return 0;
+}
+
 static int chv_gpio_probe(struct chv_pinctrl *pctrl, int irq)
 {
 =09const struct chv_gpio_pinrange *range;
@@ -1589,24 +1615,7 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl,=
 int irq)
 =09=09}
 =09}
=20
-=09/*
-=09 * The same set of machines in chv_no_valid_mask[] have incorrectly
-=09 * configured GPIOs that generate spurious interrupts so we use
-=09 * this same list to apply another quirk for them.
-=09 *
-=09 * See also https://bugzilla.kernel.org/show_bug.cgi?id=3D197953.
-=09 */
-=09if (!need_valid_mask) {
-=09=09/*
-=09=09 * Mask all interrupts the community is able to generate
-=09=09 * but leave the ones that can only generate GPEs unmasked.
-=09=09 */
-=09=09chv_writel(GENMASK(31, pctrl->community->nirqs),
-=09=09=09   pctrl->regs + CHV_INTMASK);
-=09}
-
-=09/* Clear all interrupts */
-=09chv_writel(0xffff, pctrl->regs + CHV_INTSTAT);
+=09chv_gpio_irq_init_hw(chip);
=20
 =09if (!need_valid_mask) {
 =09=09irq_base =3D devm_irq_alloc_descs(pctrl->dev, -1, 0,
--=20
2.23.0

