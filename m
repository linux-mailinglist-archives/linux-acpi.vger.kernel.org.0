Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC759FC416
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 11:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKNK0J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 05:26:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726655AbfKNK0J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 05:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573727168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aGAID/+da5Ux36hJtomZOGJxRYu/UiZIOckzXlQYhlk=;
        b=YXQtqyW3eR6FonIwZjs0tY3y1HfEXgD+caLm/aFfJQh1DXEnd53VKODL84P9Q1E41WeaO6
        9+eDIMsgRoAh0t9eslKf8nMDSwJ7C/xo1v86Z+Cc4XTebX7buzE6TlcpiUelgr2oPlPtww
        DdqjAtteTi9asfzegIK7Ol1La8NafQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-dwPZsXT0PuqGpy-q71cmMg-1; Thu, 14 Nov 2019 05:26:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AABD11050905;
        Thu, 14 Nov 2019 10:26:02 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48D2853C28;
        Thu, 14 Nov 2019 10:26:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/2] gpiolib: acpi: Print pin number on acpi_gpiochip_alloc_event errors
Date:   Thu, 14 Nov 2019 11:25:59 +0100
Message-Id: <20191114102600.34558-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: dwPZsXT0PuqGpy-q71cmMg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Print pin number and error-code on acpi_gpiochip_alloc_event errors,
to help debugging these.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Take into account that pin-number may be 16 bits
-Also log the error-code
---
 drivers/gpio/gpiolib-acpi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 59ccfd24627d..473c3b7508af 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -230,19 +230,25 @@ static acpi_status acpi_gpiochip_alloc_event(struct a=
cpi_resource *ares,
 =09desc =3D gpiochip_request_own_desc(chip, pin, "ACPI:Event",
 =09=09=09=09=09 GPIO_ACTIVE_HIGH, GPIOD_IN);
 =09if (IS_ERR(desc)) {
-=09=09dev_err(chip->parent, "Failed to request GPIO\n");
+=09=09dev_err(chip->parent,
+=09=09=09"Failed to request GPIO for pin 0x%04X, err %ld\n",
+=09=09=09pin, PTR_ERR(desc));
 =09=09return AE_ERROR;
 =09}
=20
 =09ret =3D gpiochip_lock_as_irq(chip, pin);
 =09if (ret) {
-=09=09dev_err(chip->parent, "Failed to lock GPIO as interrupt\n");
+=09=09dev_err(chip->parent,
+=09=09=09"Failed to lock GPIO pin 0x%04X as interrupt, err %d\n",
+=09=09=09pin, ret);
 =09=09goto fail_free_desc;
 =09}
=20
 =09irq =3D gpiod_to_irq(desc);
 =09if (irq < 0) {
-=09=09dev_err(chip->parent, "Failed to translate GPIO to IRQ\n");
+=09=09dev_err(chip->parent,
+=09=09=09"Failed to translate GPIO pin 0x%04X to IRQ, err %d\n",
+=09=09=09pin, irq);
 =09=09goto fail_unlock_irq;
 =09}
=20
--=20
2.23.0

