Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2710D9D4
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Nov 2019 19:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfK2S6w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Nov 2019 13:58:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53568 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727043AbfK2S6v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Nov 2019 13:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575053929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iHdIf5DEwqZ4oiu8pXmkbl8bWQDgyW+26r2hQisPZ+8=;
        b=ba1VxS3x6f9vI0s1afNBbTEaJd2axCWTsEM5E1xrKlomlVDgP1TaEah39X39hAcJ42pFcO
        WcZ22Zj/+6SapgrCkFLA9JOY4v99HUJJ5wnVk9WBw0G7BCojjdQLubyU3yWaFJuwhbscJ3
        qbkQIx5oagdk9P2RRx1VHlVucYkrXj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-Y4E04LTsPaS5tNrYWn6P7w-1; Fri, 29 Nov 2019 13:58:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0519F107ACC5;
        Fri, 29 Nov 2019 18:58:46 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B17CC10013D9;
        Fri, 29 Nov 2019 18:58:43 +0000 (UTC)
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
Subject: [PATCH 2/2] drm/i915/vlv_dsi: Control panel and backlight enable GPIOs on BYT
Date:   Fri, 29 Nov 2019 19:58:36 +0100
Message-Id: <20191129185836.2789-3-hdegoede@redhat.com>
In-Reply-To: <20191129185836.2789-1-hdegoede@redhat.com>
References: <20191129185836.2789-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Y4E04LTsPaS5tNrYWn6P7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Bay Trail devices the MIPI power on/off sequences for DSI LCD panels
do not control the LCD panel- and backlight-enable GPIOs. So far, when
the VBT indicates we should use the SoC for backlight control, we have
been relying on these GPIOs being configured as output and driven high by
the Video BIOS (GOP) when it initializes the panel.

This does not work when the device is booted with a HDMI monitor connected
as then the GOP will initialize the HDMI instead of the panel, leaving the
panel black, even though the i915 driver tries to output an image to it.

Likewise on some device-models when the GOP does not initialize the DSI
panel it also leaves the mux of the PWM0 pin in generic GPIO mode instead
of muxing it to the PWM controller.

This commit makes the DSI code control the SoC GPIOs for panel- and
backlight-enable on BYT, when the VBT indicates the SoC should be used
for backlight control. It also ensures that the PWM0 pin is muxed to the
PWM controller in this case.

This fixes the LCD panel not lighting up on various devices when booted
with a HDMI monitor connected. This has been tested to fix this on the
following devices:

Peaq C1010
Point of View MOBII TAB-P800W
Point of View MOBII TAB-P1005W
Terra Pad 1061
Yours Y8W81

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_dsi.h |  3 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c   | 44 ++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi.h b/drivers/gpu/drm/i91=
5/display/intel_dsi.h
index b15be5814599..6ff1b59b0f6f 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi.h
+++ b/drivers/gpu/drm/i915/display/intel_dsi.h
@@ -45,8 +45,9 @@ struct intel_dsi {
 =09struct intel_dsi_host *dsi_hosts[I915_MAX_PORTS];
 =09intel_wakeref_t io_wakeref[I915_MAX_PORTS];
=20
-=09/* GPIO Desc for CRC based Panel control */
+=09/* GPIO Desc for panel and backlight control */
 =09struct gpio_desc *gpio_panel;
+=09struct gpio_desc *gpio_backlight;
=20
 =09struct intel_connector *attached_connector;
=20
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/=
display/vlv_dsi.c
index fc63e2f6a511..bd081a3bb54b 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -24,6 +24,7 @@
  */
=20
 #include <linux/gpio/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/slab.h>
=20
 #include <drm/drm_atomic_helper.h>
@@ -797,7 +798,7 @@ static void intel_dsi_pre_enable(struct intel_encoder *=
encoder,
 =09if (!IS_GEMINILAKE(dev_priv))
 =09=09intel_dsi_prepare(encoder, pipe_config);
=20
-=09/* Power on, try both CRC pmic gpio and VBT */
+=09/* Power on, try both the panel-enable GPIO and the MIPI seq. */
 =09if (intel_dsi->gpio_panel)
 =09=09gpiod_set_value_cansleep(intel_dsi->gpio_panel, 1);
 =09intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_ON);
@@ -843,6 +844,9 @@ static void intel_dsi_pre_enable(struct intel_encoder *=
encoder,
 =09}
=20
 =09intel_panel_enable_backlight(pipe_config, conn_state);
+=09/* Backlight on, try both the backlight-enable GPIO and the MIPI seq. *=
/
+=09if (intel_dsi->gpio_backlight)
+=09=09gpiod_set_value_cansleep(intel_dsi->gpio_backlight, 1);
 =09intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_ON);
 }
=20
@@ -859,7 +863,10 @@ static void intel_dsi_disable(struct intel_encoder *en=
coder,
=20
 =09DRM_DEBUG_KMS("\n");
=20
+=09/* Backlight off, try both the enable GPIO and the MIPI seq. */
 =09intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_BACKLIGHT_OFF);
+=09if (intel_dsi->gpio_backlight)
+=09=09gpiod_set_value_cansleep(intel_dsi->gpio_backlight, 0);
 =09intel_panel_disable_backlight(old_conn_state);
=20
 =09/*
@@ -943,7 +950,7 @@ static void intel_dsi_post_disable(struct intel_encoder=
 *encoder,
 =09/* Assert reset */
 =09intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_ASSERT_RESET);
=20
-=09/* Power off, try both CRC pmic gpio and VBT */
+=09/* Power off, try both the panel-enable GPIO and the MIPI seq. */
 =09intel_dsi_msleep(intel_dsi, intel_dsi->panel_off_delay);
 =09intel_dsi_vbt_exec_sequence(intel_dsi, MIPI_SEQ_POWER_OFF);
 =09if (intel_dsi->gpio_panel)
@@ -1542,6 +1549,8 @@ static void intel_dsi_encoder_destroy(struct drm_enco=
der *encoder)
 =09/* dispose of the gpios */
 =09if (intel_dsi->gpio_panel)
 =09=09gpiod_put(intel_dsi->gpio_panel);
+=09if (intel_dsi->gpio_backlight)
+=09=09gpiod_put(intel_dsi->gpio_backlight);
=20
 =09intel_encoder_destroy(encoder);
 }
@@ -1821,6 +1830,7 @@ void vlv_dsi_init(struct drm_i915_private *dev_priv)
 =09struct intel_connector *intel_connector;
 =09struct drm_connector *connector;
 =09struct drm_display_mode *current_mode, *fixed_mode;
+=09struct pinctrl *pinctrl;
 =09enum port port;
=20
 =09DRM_DEBUG_KMS("\n");
@@ -1921,7 +1931,7 @@ void vlv_dsi_init(struct drm_i915_private *dev_priv)
 =09vlv_dphy_param_init(intel_dsi);
=20
 =09/*
-=09 * In case of BYT with CRC PMIC, we need to use GPIO for
+=09 * In case of BYT or CHT with CRC PMIC, we need to use GPIO for
 =09 * Panel control.
 =09 */
 =09if ((IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv)) &&
@@ -1934,6 +1944,34 @@ void vlv_dsi_init(struct drm_i915_private *dev_priv)
 =09=09=09intel_dsi->gpio_panel =3D NULL;
 =09=09}
 =09}
+=09/*
+=09 * In case of BYT (and only BYT) and using the SoC for PWM, we need
+=09 * to use the SoC's GPIOs for panel and backlight enable. When the
+=09 * GOP did not initialize the panel (HDMI inserted) we may need to
+=09 * also change the pinmux for the SoC's PWM0 pin from GPIO to PWM.
+=09 */
+=09if (IS_VALLEYVIEW(dev_priv) &&
+=09    dev_priv->vbt.dsi.config->pwm_blc =3D=3D PPS_BLC_SOC) {
+=09=09intel_dsi->gpio_panel =3D gpiod_get(dev->dev,
+=09=09=09=09=09=09  "soc_panel_enable",
+=09=09=09=09=09=09  GPIOD_OUT_HIGH);
+=09=09if (IS_ERR(intel_dsi->gpio_panel)) {
+=09=09=09DRM_ERROR("Failed to own gpio for panel control\n");
+=09=09=09intel_dsi->gpio_panel =3D NULL;
+=09=09}
+
+=09=09intel_dsi->gpio_backlight =3D gpiod_get(dev->dev,
+=09=09=09=09=09=09      "soc_backlight_enable",
+=09=09=09=09=09=09      GPIOD_OUT_HIGH);
+=09=09if (IS_ERR(intel_dsi->gpio_backlight)) {
+=09=09=09DRM_ERROR("Failed to own gpio for backlight control\n");
+=09=09=09intel_dsi->gpio_backlight =3D NULL;
+=09=09}
+
+=09=09pinctrl =3D devm_pinctrl_get_select(dev->dev, "soc_pwm0");
+=09=09if (IS_ERR(pinctrl))
+=09=09=09DRM_ERROR("Failed to set pinmux to PWM\n");
+=09}
=20
 =09drm_connector_init(dev, connector, &intel_dsi_connector_funcs,
 =09=09=09   DRM_MODE_CONNECTOR_DSI);
--=20
2.23.0

