Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 391A3121AE6
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 21:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfLPU3X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 15:29:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbfLPU3X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 15:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576528162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytI7tAhFpYO3hVy/irPOk9MEAFpxhjnylx77bRSl9P0=;
        b=OUZBb4uvbUmvVmuozNEdedUM88wvoNjvl17cSklh6U88es4cw8NiNVwKEh5aR8W5Nr4/3m
        Gr237xGAYdg1vK+6kIWsAoeNOjkOe3ra5BDB9FyqiPqwRQOpCe6YSZS4cY7lrWpxcpS6iy
        aiew+FiefF0iMn3UxD8nUwS9ICd3gVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-0pSV61xuNpiLrE_JYtsl6w-1; Mon, 16 Dec 2019 15:29:20 -0500
X-MC-Unique: 0pSV61xuNpiLrE_JYtsl6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D5B8800D48;
        Mon, 16 Dec 2019 20:29:18 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AEC095C1D6;
        Mon, 16 Dec 2019 20:29:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [CI 3/3] drm/i915: DSI: select correct PWM controller to use based on the VBT
Date:   Mon, 16 Dec 2019 21:29:06 +0100
Message-Id: <20191216202906.1662893-4-hdegoede@redhat.com>
In-Reply-To: <20191216202906.1662893-1-hdegoede@redhat.com>
References: <20191216202906.1662893-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
different PWM controllers for controlling the LCD's backlight brightness.
Either the one integrated into the PMIC or the one integrated into the
SoC (the 1st LPSS PWM controller).

So far in the LPSS code on BYT we have skipped registering the LPSS PWM
controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
present, assuming that in this case the PMIC PWM controller will be used.

On CHT we have been relying on only 1 of the 2 PWM controllers being
enabled in the DSDT at the same time; and always registered the lookup.

So far this has been working, but the correct way to determine which PWM
controller needs to be used is by checking a bit in the VBT table and
recently I've learned about 2 different BYT devices:
Point of View MOBII TAB-P800W
Acer Switch 10 SW5-012

Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
PWM controller (and the VBT correctly indicates this), so here our old
heuristics fail.

This commit fixes using the wrong PWM controller on these devices by
calling pwm_get() for the right PWM controller based on the
VBT dsi.config.pwm_blc bit.

Note this is part of a series which contains 2 other patches which rename=
s
the PWM lookup for the 1st SoC/LPSS PWM from "pwm_backlight" to
"pwm_pmic_backlight" and the PWM lookup for the Crystal Cove PMIC PWM
from "pwm_backlight" to "pwm_pmic_backlight".

Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm=
/i915/display/intel_panel.c
index bc14e9c0285a..ddcf311d1114 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1840,13 +1840,22 @@ static int pwm_setup_backlight(struct intel_conne=
ctor *connector,
 			       enum pipe pipe)
 {
 	struct drm_device *dev =3D connector->base.dev;
+	struct drm_i915_private *dev_priv =3D to_i915(dev);
 	struct intel_panel *panel =3D &connector->panel;
+	const char *desc;
 	int retval;
=20
-	/* Get the PWM chip for backlight control */
-	panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_backlight");
+	/* Get the right PWM chip for DSI backlight according to VBT */
+	if (dev_priv->vbt.dsi.config->pwm_blc =3D=3D PPS_BLC_PMIC) {
+		panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_pmic_backlight");
+		desc =3D "PMIC";
+	} else {
+		panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_soc_backlight");
+		desc =3D "SoC";
+	}
+
 	if (IS_ERR(panel->backlight.pwm)) {
-		DRM_ERROR("Failed to own the pwm chip\n");
+		DRM_ERROR("Failed to get the %s PWM chip\n", desc);
 		panel->backlight.pwm =3D NULL;
 		return -ENODEV;
 	}
@@ -1873,6 +1882,7 @@ static int pwm_setup_backlight(struct intel_connect=
or *connector,
 				 CRC_PMIC_PWM_PERIOD_NS);
 	panel->backlight.enabled =3D panel->backlight.level !=3D 0;
=20
+	DRM_INFO("Using %s PWM for LCD backlight control\n", desc);
 	return 0;
 }
=20
--=20
2.23.0

