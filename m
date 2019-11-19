Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626261027E8
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 16:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfKSPSg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 10:18:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57160 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728171AbfKSPSf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 10:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574176715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1xgbYHwGV/X4qOujvrB+x8YaMZaSCqcczgDWtCSP8s=;
        b=PMKsychZszZ405ZmwQTZmcxi/yhKG83GvCC3JGbP95uGd1M6+2LkZMdmbblpR0UVaZLIUz
        lsqUmyVxp/SIpd1xvbNVmQhX39g/q9YUPUWjJ9yqyY7XL6qgGTGCnYPVSuAa9hgxx7Vavg
        jQlFoM7slHAJjknrqxcH+DdAbqPj9HA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-WfxXZp1-MWuD2QExxvJkuA-1; Tue, 19 Nov 2019 10:18:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C03541804975;
        Tue, 19 Nov 2019 15:18:30 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-49.ams2.redhat.com [10.36.117.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B0A81001B35;
        Tue, 19 Nov 2019 15:18:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/i915: DSI: select correct PWM controller to use based on the VBT
Date:   Tue, 19 Nov 2019 16:18:18 +0100
Message-Id: <20191119151818.67531-4-hdegoede@redhat.com>
In-Reply-To: <20191119151818.67531-1-hdegoede@redhat.com>
References: <20191119151818.67531-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: WfxXZp1-MWuD2QExxvJkuA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

Note this is part of a series which contains 2 other patches which renames
the PWM lookup for the 1st SoC/LPSS PWM from "pwm_backlight" to
"pwm_pmic_backlight" and the PWM lookup for the Crystal Cove PMIC PWM
from "pwm_backlight" to "pwm_pmic_backlight".

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i=
915/display/intel_panel.c
index bc14e9c0285a..ddcf311d1114 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1840,13 +1840,22 @@ static int pwm_setup_backlight(struct intel_connect=
or *connector,
 =09=09=09       enum pipe pipe)
 {
 =09struct drm_device *dev =3D connector->base.dev;
+=09struct drm_i915_private *dev_priv =3D to_i915(dev);
 =09struct intel_panel *panel =3D &connector->panel;
+=09const char *desc;
 =09int retval;
=20
-=09/* Get the PWM chip for backlight control */
-=09panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_backlight");
+=09/* Get the right PWM chip for DSI backlight according to VBT */
+=09if (dev_priv->vbt.dsi.config->pwm_blc =3D=3D PPS_BLC_PMIC) {
+=09=09panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_pmic_backlight");
+=09=09desc =3D "PMIC";
+=09} else {
+=09=09panel->backlight.pwm =3D pwm_get(dev->dev, "pwm_soc_backlight");
+=09=09desc =3D "SoC";
+=09}
+
 =09if (IS_ERR(panel->backlight.pwm)) {
-=09=09DRM_ERROR("Failed to own the pwm chip\n");
+=09=09DRM_ERROR("Failed to get the %s PWM chip\n", desc);
 =09=09panel->backlight.pwm =3D NULL;
 =09=09return -ENODEV;
 =09}
@@ -1873,6 +1882,7 @@ static int pwm_setup_backlight(struct intel_connector=
 *connector,
 =09=09=09=09 CRC_PMIC_PWM_PERIOD_NS);
 =09panel->backlight.enabled =3D panel->backlight.level !=3D 0;
=20
+=09DRM_INFO("Using %s PWM for LCD backlight control\n", desc);
 =09return 0;
 }
=20
--=20
2.23.0

