Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9767D1027E4
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 16:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfKSPSb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 10:18:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25165 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727509AbfKSPSa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 10:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574176709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypeIeOv6cE6tGzjRHIvuCn9lxejh6U9cIMlMauvaS+4=;
        b=Hw355rYs/vJR9Kmq3I4esPXoaCj6ereO1Be8/FSe281A0ahIE1IwQcq8qnufjvv6oh5Ojo
        PEMlkpkhZm2X0k8+LB9tzOyCNHexa83Er8oYQVMoZkDRtrIadfHeQAAONtkYpgolPrajYs
        3AG0x4kkGY+6c7E22SpMEHb7x8AATrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-27YsXFnCPoCbOuIEVMyaJQ-1; Tue, 19 Nov 2019 10:18:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A893477;
        Tue, 19 Nov 2019 15:18:25 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-49.ams2.redhat.com [10.36.117.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A540D1001B35;
        Tue, 19 Nov 2019 15:18:22 +0000 (UTC)
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
Subject: [PATCH 1/3] ACPI / LPSS: Rename pwm_backlight pwm-lookup to pwm_soc_backlight
Date:   Tue, 19 Nov 2019 16:18:16 +0100
Message-Id: <20191119151818.67531-2-hdegoede@redhat.com>
In-Reply-To: <20191119151818.67531-1-hdegoede@redhat.com>
References: <20191119151818.67531-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 27YsXFnCPoCbOuIEVMyaJQ-1
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
the "pwm_backlight" lookup entries for the 1st BYT/CHT LPSS PWM controller
to "pwm_soc_backlight" so that the i915 driver can do a pwm_get() for
the right controller depending on the VBT bit, instead of the i915 driver
relying on a "pwm_backlight" lookup getting registered which magically
points to the right controller.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 751ed38f2a10..63e81d8e675b 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -69,10 +69,6 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_SAVE_CTX=09=09=09BIT(4)
 #define LPSS_NO_D3_DELAY=09=09BIT(5)
=20
-/* Crystal Cove PMIC shares same ACPI ID between different platforms */
-#define BYT_CRC_HRV=09=09=092
-#define CHT_CRC_HRV=09=09=093
-
 struct lpss_private_data;
=20
 struct lpss_device_desc {
@@ -158,7 +154,7 @@ static void lpss_deassert_reset(struct lpss_private_dat=
a *pdata)
  */
 static struct pwm_lookup byt_pwm_lookup[] =3D {
 =09PWM_LOOKUP_WITH_MODULE("80860F09:00", 0, "0000:00:02.0",
-=09=09=09       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
+=09=09=09       "pwm_soc_backlight", 0, PWM_POLARITY_NORMAL,
 =09=09=09       "pwm-lpss-platform"),
 };
=20
@@ -170,8 +166,7 @@ static void byt_pwm_setup(struct lpss_private_data *pda=
ta)
 =09if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
 =09=09return;
=20
-=09if (!acpi_dev_present("INT33FD", NULL, BYT_CRC_HRV))
-=09=09pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
+=09pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
 }
=20
 #define LPSS_I2C_ENABLE=09=09=090x6c
@@ -204,7 +199,7 @@ static void byt_i2c_setup(struct lpss_private_data *pda=
ta)
 /* BSW PWM used for backlight control by the i915 driver */
 static struct pwm_lookup bsw_pwm_lookup[] =3D {
 =09PWM_LOOKUP_WITH_MODULE("80862288:00", 0, "0000:00:02.0",
-=09=09=09       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
+=09=09=09       "pwm_soc_backlight", 0, PWM_POLARITY_NORMAL,
 =09=09=09       "pwm-lpss-platform"),
 };
=20
--=20
2.23.0

