Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6DBFB85A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2019 20:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKMTF2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Nov 2019 14:05:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728355AbfKMTF2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Nov 2019 14:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573671927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pK/vDTHcF7cffC1B2k5lTx4jazBXkvA83XQJeDIM16o=;
        b=fxu7lzTSz4vr8s0FyXjxKnAuhjCpCqqNM1hjeJNj0uWK7au+ttnxnf3eMaCf7PCtnRR2db
        2OgoW399LKhXJSwJDsIiwVU1m4THVt1+dRa1K2TtSsiZaUYJitmfOcQWt9DG+Wwdw68Qo9
        w5kbf84CQoj8YNfeOo/wXbcO6wTDdMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-nKJgUtLsOmONDIfCu-MrsQ-1; Wed, 13 Nov 2019 14:05:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18A9F183B50A;
        Wed, 13 Nov 2019 19:05:23 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-143.ams2.redhat.com [10.36.116.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1497100EBCC;
        Wed, 13 Nov 2019 19:05:21 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 1/3] pinctrl: cherryview: Split out irq hw-init into a separate helper function
Date:   Wed, 13 Nov 2019 20:05:18 +0100
Message-Id: <20191113190520.305410-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nKJgUtLsOmONDIfCu-MrsQ-1
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
index dff2a81250b6..3c6c6d69d92d 100644
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

