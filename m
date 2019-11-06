Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CDFF1A52
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2019 16:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfKFPr1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Nov 2019 10:47:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728162AbfKFPr1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Nov 2019 10:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573055246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxhyDhfQJ/8+yhPq5WmuqdtXgZROhNjk+8JjXAXTbE8=;
        b=X+eZAzjHJ5Aycrc10CG9VOfWNZF9JajDtlYVqvXa9LXvevro1Z46ZemhIaFd5v9f7lhCbx
        vW/bdcacoNYPU0hnmNPKLW+RWQTIG7O1bKqwiAyC1Av/ThpZOl3gg426Psnn0emfZ8aQ0f
        bX9qTz8zxi6DTrz0KObdcuPlEJDpxQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-a77-zDkFNoyUvRy4BK6OWA-1; Wed, 06 Nov 2019 10:47:23 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFAB4107ACC4;
        Wed,  6 Nov 2019 15:47:21 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-167.ams2.redhat.com [10.36.116.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4FF25D70E;
        Wed,  6 Nov 2019 15:47:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/3] pinctrl: cherryview: Split out irq hw-init into a separate helper function
Date:   Wed,  6 Nov 2019 16:47:13 +0100
Message-Id: <20191106154715.155596-2-hdegoede@redhat.com>
In-Reply-To: <20191106154715.155596-1-hdegoede@redhat.com>
References: <20191106154715.155596-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: a77-zDkFNoyUvRy4BK6OWA-1
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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add kerneldoc for chv_pinctrl.need_valid_mask struct member
---
 drivers/pinctrl/intel/pinctrl-cherryview.c | 58 +++++++++++++---------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/i=
ntel/pinctrl-cherryview.c
index dff2a81250b6..3ae0d398368d 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -149,6 +149,7 @@ struct chv_pin_context {
  * @chip: GPIO chip in this pin controller
  * @irqchip: IRQ chip in this pin controller
  * @regs: MMIO registers
+ * @need_valid_mask: Use chip.irq.init_valid_mask ?
  * @intr_lines: Stores mapping between 16 HW interrupt wires and GPIO
  *=09=09offset (in GPIO number space)
  * @community: Community this pinctrl instance represents
@@ -165,6 +166,7 @@ struct chv_pinctrl {
 =09struct gpio_chip chip;
 =09struct irq_chip irqchip;
 =09void __iomem *regs;
+=09bool need_valid_mask;
 =09unsigned intr_lines[16];
 =09const struct chv_community *community;
 =09u32 saved_intmask;
@@ -1555,13 +1557,40 @@ static void chv_init_irq_valid_mask(struct gpio_chi=
p *chip,
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
+=09if (!pctrl->need_valid_mask) {
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
 =09struct gpio_chip *chip =3D &pctrl->chip;
-=09bool need_valid_mask =3D !dmi_check_system(chv_no_valid_mask);
 =09const struct chv_community *community =3D pctrl->community;
-=09int ret, i, irq_base;
+=09int ret, i, irq_base =3D 0;
+
+=09pctrl->need_valid_mask =3D !dmi_check_system(chv_no_valid_mask);
=20
 =09*chip =3D chv_gpio_chip;
=20
@@ -1569,7 +1598,7 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, =
int irq)
 =09chip->label =3D dev_name(pctrl->dev);
 =09chip->parent =3D pctrl->dev;
 =09chip->base =3D -1;
-=09if (need_valid_mask)
+=09if (pctrl->need_valid_mask)
 =09=09chip->irq.init_valid_mask =3D chv_init_irq_valid_mask;
=20
 =09ret =3D devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
@@ -1589,26 +1618,9 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl,=
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
-=09if (!need_valid_mask) {
+=09if (!pctrl->need_valid_mask) {
 =09=09irq_base =3D devm_irq_alloc_descs(pctrl->dev, -1, 0,
 =09=09=09=09=09=09community->npins, NUMA_NO_NODE);
 =09=09if (irq_base < 0) {
@@ -1632,7 +1644,7 @@ static int chv_gpio_probe(struct chv_pinctrl *pctrl, =
int irq)
 =09=09return ret;
 =09}
=20
-=09if (!need_valid_mask) {
+=09if (!pctrl->need_valid_mask) {
 =09=09for (i =3D 0; i < community->ngpio_ranges; i++) {
 =09=09=09range =3D &community->gpio_ranges[i];
=20
--=20
2.23.0

