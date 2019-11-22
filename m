Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74D1077F7
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2019 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKVTXr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Nov 2019 14:23:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbfKVTXr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Nov 2019 14:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574450626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0prvImqtBY2NgHE8spXeOl7Uw63z03nHrCNy0kOOwc=;
        b=cJcGCYclBHKqTXE9KXRxeoKr8mfwXhxjbdIa/RsLd1t4CMwqRarU9Tz9HUBvqYKUH3yN8f
        wizh+KHLNWodb4xASCtIkkzns6RZ6+cltbV68O+oB61dIBqZUg3i+3du4aFWwEDNPDoQpL
        WeGnEerixs87eJGSH/JY7+bPrcVcv+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-ufeGOtLnMp2eukxObRgeiw-1; Fri, 22 Nov 2019 14:23:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD95800054;
        Fri, 22 Nov 2019 19:23:44 +0000 (UTC)
Received: from dhcp-44-196.space.revspace.nl (unknown [10.36.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD3D1084192;
        Fri, 22 Nov 2019 19:23:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] gpiolib: acpi: Turn dmi_system_id table into a generic quirk table
Date:   Fri, 22 Nov 2019 20:23:33 +0100
Message-Id: <20191122192334.61490-2-hdegoede@redhat.com>
In-Reply-To: <20191122192334.61490-1-hdegoede@redhat.com>
References: <20191122192334.61490-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ufeGOtLnMp2eukxObRgeiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Turn the existing run_edge_events_on_boot_blacklist dmi_system_id table
into a generic quirk table, storing the quirks in the driver_data ptr.

This is a preparation patch for adding other types of (DMI based) quirks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpio/gpiolib-acpi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index d30e57dc755c..2b47d906d536 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -21,6 +21,8 @@
 #include "gpiolib.h"
 #include "gpiolib-acpi.h"
=20
+#define QUIRK_NO_EDGE_EVENTS_ON_BOOT=09=090x01l
+
 static int run_edge_events_on_boot =3D -1;
 module_param(run_edge_events_on_boot, int, 0444);
 MODULE_PARM_DESC(run_edge_events_on_boot,
@@ -1309,7 +1311,7 @@ static int acpi_gpio_handle_deferred_request_irqs(voi=
d)
 /* We must use _sync so that this runs after the first deferred_probe run =
*/
 late_initcall_sync(acpi_gpio_handle_deferred_request_irqs);
=20
-static const struct dmi_system_id run_edge_events_on_boot_blacklist[] =3D =
{
+static const struct dmi_system_id gpiolib_acpi_quirks[] =3D {
 =09{
 =09=09/*
 =09=09 * The Minix Neo Z83-4 has a micro-USB-B id-pin handler for
@@ -1319,7 +1321,8 @@ static const struct dmi_system_id run_edge_events_on_=
boot_blacklist[] =3D {
 =09=09.matches =3D {
 =09=09=09DMI_MATCH(DMI_SYS_VENDOR, "MINIX"),
 =09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
-=09=09}
+=09=09},
+=09=09.driver_data =3D (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
 =09},
 =09{
 =09=09/*
@@ -1331,15 +1334,23 @@ static const struct dmi_system_id run_edge_events_o=
n_boot_blacklist[] =3D {
 =09=09.matches =3D {
 =09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Wortmann_AG"),
 =09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "TERRA_PAD_1061"),
-=09=09}
+=09=09},
+=09=09.driver_data =3D (void *)QUIRK_NO_EDGE_EVENTS_ON_BOOT,
 =09},
 =09{} /* Terminating entry */
 };
=20
 static int acpi_gpio_setup_params(void)
 {
+=09const struct dmi_system_id *id;
+=09long quirks =3D 0;
+
+=09id =3D dmi_first_match(gpiolib_acpi_quirks);
+=09if (id)
+=09=09quirks =3D (long)id->driver_data;
+
 =09if (run_edge_events_on_boot < 0) {
-=09=09if (dmi_check_system(run_edge_events_on_boot_blacklist))
+=09=09if (quirks & QUIRK_NO_EDGE_EVENTS_ON_BOOT)
 =09=09=09run_edge_events_on_boot =3D 0;
 =09=09else
 =09=09=09run_edge_events_on_boot =3D 1;
--=20
2.23.0

