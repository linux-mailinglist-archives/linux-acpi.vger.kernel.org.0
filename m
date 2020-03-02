Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1156175946
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Mar 2020 12:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCBLMf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Mar 2020 06:12:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29944 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbgCBLMf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Mar 2020 06:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583147554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkPBRGr9wFUsYjrE5mSba+0JWK4lGHVPrjmEsVlopBA=;
        b=MwnfJA9kUoaAqgH11Xj5rQ80gBElGVpjVJyaw7VCAqYFxiHXNL3VrwAUlLXJlVKY1Bq0p5
        F7lfcNLN2QWwAbIp/RBalWJLdLC+7BNzno3+F+gzQUI2BoKhTndSpVtWB7KjcEJvaDHqYj
        ymj4cQrRbZ6FkFvphoqdyvw7NHsGDIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-e1yTO1oRMJG8AVagBaCcSw-1; Mon, 02 Mar 2020 06:12:32 -0500
X-MC-Unique: e1yTO1oRMJG8AVagBaCcSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EBE8800D50;
        Mon,  2 Mar 2020 11:12:31 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.36.118.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5174B5D9C9;
        Mon,  2 Mar 2020 11:12:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/4] gpiolib: acpi: Rework honor_wakeup option into an ignore_wake option
Date:   Mon,  2 Mar 2020 12:12:23 +0100
Message-Id: <20200302111225.6641-2-hdegoede@redhat.com>
In-Reply-To: <20200302111225.6641-1-hdegoede@redhat.com>
References: <20200302111225.6641-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
quirk mechanism") was added to deal with spurious wakeups on one specific
model of the HP x2 10 series.

The approach taken there was to add a bool controlling wakeup support for
all ACPI GPIO events. This was sufficient for the specific HP x2 10 model
the commit was trying to fix, but in the mean time other models have
turned up which need a similar workaround to avoid spurious wakeups from
suspend, but only for one of the pins on which the ACPI tables request
ACPI GPIO events.

Since the honor_wakeup option was added to be able to ignore wake events,
the name was perhaps not the best, this commit renames it to ignore_wake
and changes it to a string with the following format:
gpiolib_acpi.ignore_wake=3Dcontroller@pin[,controller@pin[,...]]

This allows working around spurious wakeup issues on a per pin basis.

This commit also reworks the existing quirk for the HP x2 10 so that
it functions as before.

Note:
-This removes the honor_wakeup parameter. This has only been upstream for
 a short time and to the best of my knowledge there are no users using
 this module parameter.

-The controller@pin[,controller@pin[,...]] syntax is based on an existing
 kernel module parameter using the same controller@pin format. That versi=
on
 uses ';' as separator, but in practice that is problematic because grub2
 cannot handle this without taking special care to escape the ';', so her=
e
 we are using a ',' as separator instead which does not have this issue.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + qui=
rk mechanism")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Rewrite to use a much more generic string based format to describe
 the controller@pin combination(s) on which to ignore wakeups
---
 drivers/gpio/gpiolib-acpi.c | 96 +++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index a77edd31dd60..87bb0d3c69da 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -21,18 +21,21 @@
 #include "gpiolib.h"
 #include "gpiolib-acpi.h"
=20
-#define QUIRK_NO_EDGE_EVENTS_ON_BOOT		0x01l
-#define QUIRK_NO_WAKEUP				0x02l
-
 static int run_edge_events_on_boot =3D -1;
 module_param(run_edge_events_on_boot, int, 0444);
 MODULE_PARM_DESC(run_edge_events_on_boot,
 		 "Run edge _AEI event-handlers at boot: 0=3Dno, 1=3Dyes, -1=3Dauto");
=20
-static int honor_wakeup =3D -1;
-module_param(honor_wakeup, int, 0444);
-MODULE_PARM_DESC(honor_wakeup,
-		 "Honor the ACPI wake-capable flag: 0=3Dno, 1=3Dyes, -1=3Dauto");
+static char *ignore_wake;
+module_param(ignore_wake, charp, 0444);
+MODULE_PARM_DESC(ignore_wake,
+		 "controller@pin combos on which to ignore the ACPI wake flag "
+		 "ignore_wake=3Dcontroller@pin[,controller@pin[,...]]");
+
+struct acpi_gpiolib_dmi_quirk {
+	bool no_edge_events_on_boot;
+	char *ignore_wake;
+};
=20
 /**
  * struct acpi_gpio_event - ACPI GPIO event handler data
@@ -202,6 +205,57 @@ static void acpi_gpiochip_request_irqs(struct acpi_g=
pio_chip *acpi_gpio)
 		acpi_gpiochip_request_irq(acpi_gpio, event);
 }
=20
+static bool acpi_gpio_in_ignore_list(const char *controller_in, int pin_=
in)
+{
+	const char *controller, *pin_str;
+	int len, pin;
+	char *endp;
+
+	controller =3D ignore_wake;
+	while (controller) {
+		pin_str =3D strchr(controller, '@');
+		if (!pin_str)
+			goto err;
+
+		len =3D pin_str - controller;
+		if (len =3D=3D strlen(controller_in) &&
+		    strncmp(controller, controller_in, len) =3D=3D 0) {
+			pin =3D simple_strtoul(pin_str + 1, &endp, 10);
+			if (*endp !=3D 0 && *endp !=3D ',')
+				goto err;
+
+			if (pin =3D=3D pin_in)
+				return true;
+		}
+
+		controller =3D strchr(controller, ',');
+		if (controller)
+			controller++;
+	}
+
+	return false;
+err:
+	pr_err_once("Error invalid value for gpiolib_acpi.ignore_wake: %s\n",
+		    ignore_wake);
+	return false;
+}
+
+static bool acpi_gpio_irq_is_wake(struct device *parent,
+				  struct acpi_resource_gpio *agpio)
+{
+	int pin =3D agpio->pin_table[0];
+
+	if (agpio->wake_capable !=3D ACPI_WAKE_CAPABLE)
+		return false;
+
+	if (acpi_gpio_in_ignore_list(dev_name(parent), pin)) {
+		dev_info(parent, "Ignoring wakeup on pin %d\n", pin);
+		return false;
+	}
+
+	return true;
+}
+
 /* Always returns AE_OK so that we keep looping over the resources */
 static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
 					     void *context)
@@ -289,7 +343,7 @@ static acpi_status acpi_gpiochip_alloc_event(struct a=
cpi_resource *ares,
 	event->handle =3D evt_handle;
 	event->handler =3D handler;
 	event->irq =3D irq;
-	event->irq_is_wake =3D honor_wakeup && agpio->wake_capable =3D=3D ACPI_=
WAKE_CAPABLE;
+	event->irq_is_wake =3D acpi_gpio_irq_is_wake(chip->parent, agpio);
 	event->pin =3D pin;
 	event->desc =3D desc;
=20
@@ -1328,7 +1382,9 @@ static const struct dmi_system_id gpiolib_acpi_quir=
ks[] =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
 		},
-		.driver_data =3D (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
+		.driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
+			.no_edge_events_on_boot =3D true,
+		},
 	},
 	{
 		/*
@@ -1341,7 +1397,9 @@ static const struct dmi_system_id gpiolib_acpi_quir=
ks[] =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "Wortmann_AG"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "TERRA_PAD_1061"),
 		},
-		.driver_data =3D (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
+		.driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
+			.no_edge_events_on_boot =3D true,
+		},
 	},
 	{
 		/*
@@ -1360,33 +1418,31 @@ static const struct dmi_system_id gpiolib_acpi_qu=
irks[] =3D {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP x2 Detachable 10-p0XX"),
 		},
-		.driver_data =3D (void *)QUIRK_NO_WAKEUP,
+		.driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake =3D "INT33FF:01@0,INT0002:00@2",
+		},
 	},
 	{} /* Terminating entry */
 };
=20
 static int acpi_gpio_setup_params(void)
 {
+	const struct acpi_gpiolib_dmi_quirk *quirk =3D NULL;
 	const struct dmi_system_id *id;
-	long quirks =3D 0;
=20
 	id =3D dmi_first_match(gpiolib_acpi_quirks);
 	if (id)
-		quirks =3D (long)id->driver_data;
+		quirk =3D id->driver_data;
=20
 	if (run_edge_events_on_boot < 0) {
-		if (quirks & QUIRK_NO_EDGE_EVENTS_ON_BOOT)
+		if (quirk && quirk->no_edge_events_on_boot)
 			run_edge_events_on_boot =3D 0;
 		else
 			run_edge_events_on_boot =3D 1;
 	}
=20
-	if (honor_wakeup < 0) {
-		if (quirks & QUIRK_NO_WAKEUP)
-			honor_wakeup =3D 0;
-		else
-			honor_wakeup =3D 1;
-	}
+	if (ignore_wake =3D=3D NULL && quirk && quirk->ignore_wake)
+		ignore_wake =3D quirk->ignore_wake;
=20
 	return 0;
 }
--=20
2.25.1

