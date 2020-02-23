Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2213A16985E
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Feb 2020 16:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgBWPSj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 10:18:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25601 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgBWPSj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 10:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582471117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Q8QbgyrMBPu767akEnCfZ2jpfW2ZYDI0yhuYQOQ73g=;
        b=HRqQLurJ3lNH5qb/ACUzXnrrdSweja1en3YdD8AusVfqEB4G9cu0bdR8+L8LZyRB0zuXQO
        M4+45HdlrKNvRkSjLSc0LhrLlkfpmRH9RZ3QvZXK1HkP4Am3p6ELVwaEdrujCSntxszA7t
        SdGwRtti4HED6UzGuRcXaRyl47a4okU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-i8sdVXy1P1WoFdezQrTBMg-1; Sun, 23 Feb 2020 10:18:36 -0500
X-MC-Unique: i8sdVXy1P1WoFdezQrTBMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4E6E107ACC4;
        Sun, 23 Feb 2020 15:18:34 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-116-120.ams2.redhat.com [10.36.116.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AA4E398;
        Sun, 23 Feb 2020 15:18:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] gpiolib: acpi: Rename honor_wakeup option to ignore_wake, add extra quirk
Date:   Sun, 23 Feb 2020 16:18:28 +0100
Message-Id: <20200223151828.311682-3-hdegoede@redhat.com>
In-Reply-To: <20200223151828.311682-1-hdegoede@redhat.com>
References: <20200223151828.311682-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
quirk mechanism") was added to deal with spurious wakeups on one specific
model of the HP x2 10 series. In the mean time I have learned that there
are at least 3 variants of the HP x2 10 models:

Bay Trail SoC + AXP288 PMIC
Cherry Trail SoC + AXP288 PMIC
Cherry Trail SoC + TI PMIC

It turns out that the need to ignore wakeup on *all* ACPI GPIO event
handlers is unique to the Cherry Trail SoC + TI PMIC variant for which
the first quirk was added.

The 2 variants with the AXP288 PMIC only need to have wakeup disabled on
the embedded-controller event handler. We want to e.g. keep wakeup on the
event handler connected to the GPIO for the lid open/closed sensor.

Since the honor_wakeup option was added to be able to ignore wake events,
the name was perhaps not the best, this commit renames it to ignore_wake,
this version of the option has te following possible values:

values >=3D 0: a pin number on which to ignore wakeups, the ACPI wake fla=
g
will still be honored on all other pins
value -1: auto: check for DMI quirk, otherwise honor the flag on all pins
value -2: all:  ignore the flag on all pins
value -3: none: honor wakeups on all pins

Note that it is possible for an ACPI table to request events on the same
pin-number on multiple GPIO controllers, in that case if such a pin-numbe=
r
is used as ignore_wake value then wakeups will be ignored for that pin on
all GPIO controllers.

The existing quirk for the Cherry Trail + TI PMIC models is changed to
IGNORE_WAKE_ALL, keeping the current behavior; and a new quirk is added
for the Bay Trail + AXP288 model, ignoring wakeups on the EC GPIO pin onl=
y.

I'm still waiting for testing feedback for the quirk for ignoring wakeups
on the EC GPIO pin only on the Cherry Trail + AXP288 model.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + qui=
rk mechanism")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 59 +++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index bc96f28d4807..83103efa5862 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -21,19 +21,27 @@
 #include "gpiolib.h"
 #include "gpiolib-acpi.h"
=20
-#define QUIRK_NO_EDGE_EVENTS_ON_BOOT		0x01l
-#define QUIRK_NO_WAKEUP				0x02l
+#define QUIRK_IGNORE_WAKE_MASK			GENMASK(15, 0)
+#define QUIRK_IGNORE_WAKE_SET			BIT(16)
+#define QUIRK_NO_EDGE_EVENTS_ON_BOOT		BIT(17)
+
+#define QUIRK_IGNORE_WAKE(x) \
+	(((x) & QUIRK_IGNORE_WAKE_MASK) | QUIRK_IGNORE_WAKE_SET)
+
+#define IGNORE_WAKE_AUTO			-1
+#define IGNORE_WAKE_ALL				-2
+#define IGNORE_WAKE_NONE			-3
+
+static int ignore_wake =3D IGNORE_WAKE_AUTO;
+module_param(ignore_wake, int, 0444);
+MODULE_PARM_DESC(ignore_wake,
+	"Ignore ACPI wake flag: x=3Dignore-for-pin-x, -1=3Dauto, -2=3Dall, -3=3D=
none");
=20
 static int run_edge_events_on_boot =3D -1;
 module_param(run_edge_events_on_boot, int, 0444);
 MODULE_PARM_DESC(run_edge_events_on_boot,
 		 "Run edge _AEI event-handlers at boot: 0=3Dno, 1=3Dyes, -1=3Dauto");
=20
-static int honor_wakeup =3D -1;
-module_param(honor_wakeup, int, 0444);
-MODULE_PARM_DESC(honor_wakeup,
-		 "Honor the ACPI wake-capable flag: 0=3Dno, 1=3Dyes, -1=3Dauto");
-
 /**
  * struct acpi_gpio_event - ACPI GPIO event handler data
  *
@@ -214,6 +222,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct a=
cpi_resource *ares,
 	irq_handler_t handler =3D NULL;
 	struct gpio_desc *desc;
 	int ret, pin, irq;
+	bool honor_wakeup;
=20
 	if (!acpi_gpio_get_irq_resource(ares, &agpio))
 		return AE_OK;
@@ -286,6 +295,17 @@ static acpi_status acpi_gpiochip_alloc_event(struct =
acpi_resource *ares,
 		}
 	}
=20
+	switch (ignore_wake) {
+	case IGNORE_WAKE_ALL:
+		honor_wakeup =3D false;
+		break;
+	case IGNORE_WAKE_NONE:
+		honor_wakeup =3D true;
+		break;
+	default:
+		honor_wakeup =3D ignore_wake !=3D pin;
+	}
+
 	event->handle =3D evt_handle;
 	event->handler =3D handler;
 	event->irq =3D irq;
@@ -1363,7 +1383,22 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP x2 Detachable 10-p0XX"),
 		},
-		.driver_data =3D (void *)QUIRK_NO_WAKEUP,
+		.driver_data =3D (void *)QUIRK_IGNORE_WAKE(IGNORE_WAKE_ALL),
+	},
+	{
+		/*
+		 * HP X2 10 models with Bay Trail SoC + AXP288 PMIC use an
+		 * external embedded-controller connected via I2C + an ACPI
+		 * GPIO event handler for pin 0x1c, causing spurious wakeups.
+		 * Unlike the Cherry Trail + TI PMIC models, we do want to
+		 * honor the ACPI wake flag on the other GPIOs.
+		 */
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_MATCH(DMI_BOARD_NAME, "815D"),
+		},
+		.driver_data =3D (void *)QUIRK_IGNORE_WAKE(0x1c),
 	},
 	{} /* Terminating entry */
 };
@@ -1384,11 +1419,11 @@ static int acpi_gpio_setup_params(void)
 			run_edge_events_on_boot =3D 1;
 	}
=20
-	if (honor_wakeup < 0) {
-		if (quirks & QUIRK_NO_WAKEUP)
-			honor_wakeup =3D 0;
+	if (ignore_wake =3D=3D IGNORE_WAKE_AUTO) {
+		if (quirks & QUIRK_IGNORE_WAKE_SET)
+			ignore_wake =3D (s16)(quirks & QUIRK_IGNORE_WAKE_MASK);
 		else
-			honor_wakeup =3D 1;
+			ignore_wake =3D IGNORE_WAKE_NONE;
 	}
=20
 	return 0;
--=20
2.25.0

