Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39F81077F9
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 20:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfKVTXu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 14:23:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29533 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726833AbfKVTXu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 14:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574450629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xv1dgZzh0Q37zacmXJMV+6rn9NNKoPQkTuP/wAhybg4=;
        b=Cpr3VMOrg/eBOOf987pGsis/b6YukOmMroW1mitWu/svjeNuL5ElT3Mb3iwe6wTu9NrCri
        /M11DSirtbeFXyyRDxWPAVEcpyVXp6tOUNBxcFeYw1CPs5u6HOBYu4e34Fzv1pzKPOIAVX
        eIuG99ZXT1MouH/M/1tYbPFn+qvZiUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-RKwSq9c5MO2OUfbba2EwSg-1; Fri, 22 Nov 2019 14:23:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93402800054;
        Fri, 22 Nov 2019 19:23:46 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (unknown [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55B101036C64;
        Fri, 22 Nov 2019 19:23:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism
Date:   Fri, 22 Nov 2019 20:23:34 +0100
Message-Id: <20191122192334.61490-3-hdegoede@redhat.com>
In-Reply-To: <20191122192334.61490-1-hdegoede@redhat.com>
References: <20191122192334.61490-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: RKwSq9c5MO2OUfbba2EwSg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On some laptops enabling wakeup on the GPIO interrupts used for ACPI _AEI
event handling causes spurious wakeups.

This commit adds a new honor_wakeup option, defaulting to true (our current
behavior), which can be used to disable wakeup on troublesome hardware
to avoid these spurious wakeups.

This is a workaround for an architectural problem with s2idle under Linux
where we do not have any mechanism to immediately go back to sleep after
wakeup events, other then for embedded-controller events using the standard
ACPI EC interface, for details see:
https://lore.kernel.org/linux-acpi/61450f9b-cbc6-0c09-8b3a-aff6bf9a0b3c@red=
hat.com/

One series of laptops which is not able to suspend without this workaround
is the HP x2 10 Cherry Trail models, this commit adds a DMI based quirk
which makes sets honor_wakeup to false on these models.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 2b47d906d536..9ce9b449ac4b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -22,12 +22,18 @@
 #include "gpiolib-acpi.h"
=20
 #define QUIRK_NO_EDGE_EVENTS_ON_BOOT=09=090x01l
+#define QUIRK_NO_WAKEUP=09=09=09=090x02l
=20
 static int run_edge_events_on_boot =3D -1;
 module_param(run_edge_events_on_boot, int, 0444);
 MODULE_PARM_DESC(run_edge_events_on_boot,
 =09=09 "Run edge _AEI event-handlers at boot: 0=3Dno, 1=3Dyes, -1=3Dauto")=
;
=20
+static int honor_wakeup =3D -1;
+module_param(honor_wakeup, int, 0444);
+MODULE_PARM_DESC(honor_wakeup,
+=09=09 "Honor the ACPI wake-capable flag: 0=3Dno, 1=3Dyes, -1=3Dauto");
+
 /**
  * struct acpi_gpio_event - ACPI GPIO event handler data
  *
@@ -283,7 +289,8 @@ static acpi_status acpi_gpiochip_alloc_event(struct acp=
i_resource *ares,
 =09event->handle =3D evt_handle;
 =09event->handler =3D handler;
 =09event->irq =3D irq;
-=09event->irq_is_wake =3D agpio->wake_capable =3D=3D ACPI_WAKE_CAPABLE;
+=09if (honor_wakeup)
+=09=09event->irq_is_wake =3D agpio->wake_capable =3D=3D ACPI_WAKE_CAPABLE;
 =09event->pin =3D pin;
 =09event->desc =3D desc;
=20
@@ -1337,6 +1344,23 @@ static const struct dmi_system_id gpiolib_acpi_quirk=
s[] =3D {
 =09=09},
 =09=09.driver_data =3D (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
 =09},
+=09{
+=09=09/*
+=09=09 * Various HP X2 10 Cherry Trail models use external
+=09=09 * embedded-controller connected via I2C + a ACPI GPIO
+=09=09 * event handler. The embedded controller generates various
+=09=09 * spurious wakeup events when suspended. So disable wakeup
+=09=09 * for its handler (it used the only ACPI GPIO event handler).
+=09=09 * This breaks wakeup when opening the lid, the user needs
+=09=09 * to press the power-button to wakeup the system. The
+=09=09 * alternative is suspend simply not working, which is worse.
+=09=09 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "HP x2 Detachable 10-p0XX"),
+=09=09},
+=09=09.driver_data =3D (void *)QUIRK_NO_WAKEUP,
+=09},
 =09{} /* Terminating entry */
 };
=20
@@ -1356,6 +1380,13 @@ static int acpi_gpio_setup_params(void)
 =09=09=09run_edge_events_on_boot =3D 1;
 =09}
=20
+=09if (honor_wakeup < 0) {
+=09=09if (quirks & QUIRK_NO_WAKEUP)
+=09=09=09honor_wakeup =3D 0;
+=09=09else
+=09=09=09honor_wakeup =3D 1;
+=09}
+
 =09return 0;
 }
=20
--=20
2.23.0

