Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439A310D9D0
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 19:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK2S6s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 13:58:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22333 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726926AbfK2S6s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Nov 2019 13:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575053926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TGDeVcjgB0jD0i7RDHcQvIara3Obmqdvjz50j+xXoY=;
        b=YI4p8rTOc+aMhPJSw+Hn2d6k8VddyIT0eIDx6yu//G5YY8kiUHNJ4HdeiUNF8xQYLwiru3
        rUj3CxoeAZvR6P2NYU76C6DZubn+UQyH/vNiur8wRqz5ixpBGAu20IuwePruHzvDJ/4u8T
        05UbAOb9+O/qqFSIiINsWRgiCeplfL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-R_ldR-rsOay3ow_ImDfeHg-1; Fri, 29 Nov 2019 13:58:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B84ADB20;
        Fri, 29 Nov 2019 18:58:43 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18A6110013D9;
        Fri, 29 Nov 2019 18:58:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: baytrail: Add GPIO lookup and pinctrl-map for i915 DSI panel ctrl
Date:   Fri, 29 Nov 2019 19:58:35 +0100
Message-Id: <20191129185836.2789-2-hdegoede@redhat.com>
In-Reply-To: <20191129185836.2789-1-hdegoede@redhat.com>
References: <20191129185836.2789-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: R_ldR-rsOay3ow_ImDfeHg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Bay Trail devices the MIPI power on/off sequences for DSI LCD panels
do not control the LCD panel and backlight GPIOs. So far we have been
relying on these GPIOs being configured as output and driven high by
the Video BIOS (GOP) when it initializes the panel.

This does not work when the device is booted with a HDMI monitor connected
as then the GOP will initialize the HDMI instead of the panel, leaving the
panel black, even though the i915 driver tries to output an image to it.

Likewise on some device-models when the GOP does not initialize the DSI
panel it also leaves the mux of the PWM0 pin in generic GPIO mode instead
of muxing it to the PWM controller.

This commit adds GPIO lookups and a pinctrl-map which the i915 driver can
use to get the panel- and backlight-enable GPIOs and to mux the PWM0 pin
to the PWM controller.

Note it may seem a bit weird to add a pinctrl-map for the i915 driver,
so that it can set the PWM0 pinmux. Doing this from the LPSS PWM driver
would be more logical. But the only thing telling us that the pin should
definitely be muxed to the PWM controller is the VBT to which the PWM
driver does not have access.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/int=
el/pinctrl-baytrail.c
index 3a6404b6fd7e..a13ca7c672fa 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1601,6 +1602,39 @@ static const struct acpi_device_id byt_gpio_acpi_mat=
ch[] =3D {
 =09{ }
 };
=20
+/*
+ * On Bay Trail devices with a DSI LCD panel and using the SoC (LPSS) pwm =
for
+ * backlight control, the i915 driver needs to control the backlight and L=
CD
+ * enable GPIOs, which are always pin 10 and 11 on the NCORE. Without this
+ * the LCD panel will not light-up when the system is booted with a HDMI c=
able
+ * inserted and the video BIOS / GOP did not init the LCD because of this.
+ *
+ * Likewise in some cases when a HDMI cable is inserted the firmware does =
not
+ * even properly mux the PWM0 pin. We add a pinctrl-map for this so that t=
he
+ * i915 driver can fix this. Note that the map is for the i915 device not =
for
+ * the PWM device. This is a bit weird, but the only thing telling us that
+ * the pin should definitely be muxed to the PWM controller is the VBT bit
+ * which tells the i915 driver to use the SoC's PWM for backlight control.
+ */
+
+static char score_name[32];
+static char ncore_name[32];
+
+static const struct pinctrl_map byt_panel_pwm_pinctrl_map[] =3D {
+=09PIN_MAP_MUX_GROUP("0000:00:02.0", "soc_pwm0", score_name,
+=09=09=09  "pwm0_grp", "pwm"),
+};
+
+static struct gpiod_lookup_table byt_panel_gpio_table =3D {
+=09.dev_id =3D "0000:00:02.0",
+=09.table =3D {
+=09  /* "soc_" prefix to distuingish these from those on the PMIC */
+=09  GPIO_LOOKUP(ncore_name, 10, "soc_backlight_enable", GPIO_ACTIVE_HIGH)=
,
+=09  GPIO_LOOKUP(ncore_name, 11, "soc_panel_enable", GPIO_ACTIVE_HIGH),
+=09  { },
+=09},
+};
+
 static int byt_pinctrl_probe(struct platform_device *pdev)
 {
 =09const struct intel_pinctrl_soc_data *soc_data =3D NULL;
@@ -1651,6 +1685,16 @@ static int byt_pinctrl_probe(struct platform_device =
*pdev)
 =09if (ret)
 =09=09return ret;
=20
+=09if (soc_data =3D=3D &byt_score_soc_data) {
+=09=09strscpy(score_name, dev_name(&pdev->dev), sizeof(score_name));
+=09=09ret =3D pinctrl_register_mappings(byt_panel_pwm_pinctrl_map, 1);
+=09=09if (ret)
+=09=09=09dev_err(&pdev->dev, "failed to register pinctrl-map\n");
+=09} else if (soc_data =3D=3D &byt_ncore_soc_data) {
+=09=09strscpy(ncore_name, dev_name(&pdev->dev), sizeof(ncore_name));
+=09=09gpiod_add_lookup_table(&byt_panel_gpio_table);
+=09}
+
 =09platform_set_drvdata(pdev, vg);
 =09pm_runtime_enable(&pdev->dev);
=20
--=20
2.23.0

