Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459BC1027EC
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 16:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfKSPSl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 10:18:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727937AbfKSPSd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 10:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574176711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngJHwMLUICs8vaerYHR3sXbFbmXOicZXBRb/3hddGFY=;
        b=IfHVMljVfi6lvI0LcpWM6Z+Jb0fzjpaqyWeXvmtsXx45wcif/OpPT6QKLQvbO9SZAkSCIo
        0C2hQmp8o4ucAXFb6KHUL017ijSklaoxU/FSsZ2DYErrzwWMqGvU889Wl6VKH80XLcLxgo
        pzIdyDxKXkERlCPqxj/trSM0D3rHfzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-6Hi3OIQRPOWRacUrwh9Eiw-1; Tue, 19 Nov 2019 10:18:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06ECF8018A3;
        Tue, 19 Nov 2019 15:18:28 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-49.ams2.redhat.com [10.36.117.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D0EE1001925;
        Tue, 19 Nov 2019 15:18:25 +0000 (UTC)
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
Subject: [PATCH 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup to pwm_pmic_backlight
Date:   Tue, 19 Nov 2019 16:18:17 +0100
Message-Id: <20191119151818.67531-3-hdegoede@redhat.com>
In-Reply-To: <20191119151818.67531-1-hdegoede@redhat.com>
References: <20191119151818.67531-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6Hi3OIQRPOWRacUrwh9Eiw-1
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

Since only the i915 driver has access to the VBT, this commit renames
the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
controller to "pwm_pmic_backlight" so that the i915 driver can do a
pwm_get() for the right controller depending on the VBT bit, instead of
the i915 driver relying on a "pwm_backlight" lookup getting registered
which magically points to the right controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic=
_core.c
index c9f35378d391..47188df3080d 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -38,7 +38,7 @@ static struct gpiod_lookup_table panel_gpio_table =3D {
=20
 /* PWM consumed by the Intel GFX */
 static struct pwm_lookup crc_pwm_lookup[] =3D {
-=09PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_backlight", 0, P=
WM_POLARITY_NORMAL),
+=09PWM_LOOKUP("crystal_cove_pwm", 0, "0000:00:02.0", "pwm_pmic_backlight",=
 0, PWM_POLARITY_NORMAL),
 };
=20
 static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
--=20
2.23.0

