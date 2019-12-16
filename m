Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD42D121ADD
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 21:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfLPU3S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 15:29:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbfLPU3R (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 15:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576528156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlu9ktr7H31RWs1DVUPIInRRweo4N+0rLFR6yADAtyc=;
        b=hFGyOGiDL/5LY9s6F+XQrpbfdexx1nkpUmgQIgOQsmE9BEiFOp3HkKenvhD7pAa0KoSme5
        N9Mbiz5GnAIZd4IF0O5fGSk6ShuXhCA6Tb0OXCu+Dojn/pspAyyCM3lU7GQSrFubNT/3bk
        hNBWeVDXGsmDuHxkRsIum9pQ970ebVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-xE5eE4utO72SBaIrmz8lJw-1; Mon, 16 Dec 2019 15:29:14 -0500
X-MC-Unique: xE5eE4utO72SBaIrmz8lJw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8716800D48;
        Mon, 16 Dec 2019 20:29:12 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-96.ams2.redhat.com [10.36.116.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 523555C1D6;
        Mon, 16 Dec 2019 20:29:10 +0000 (UTC)
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [CI 1/3] ACPI / LPSS: Rename pwm_backlight pwm-lookup to pwm_soc_backlight
Date:   Mon, 16 Dec 2019 21:29:04 +0100
Message-Id: <20191216202906.1662893-2-hdegoede@redhat.com>
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

Since only the i915 driver has access to the VBT, this commit renames
the "pwm_backlight" lookup entries for the 1st BYT/CHT LPSS PWM controlle=
r
to "pwm_soc_backlight" so that the i915 driver can do a pwm_get() for
the right controller depending on the VBT bit, instead of the i915 driver
relying on a "pwm_backlight" lookup getting registered which magically
points to the right controller.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/acpi_lpss.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 70f740b09684..db18df6cb330 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -69,10 +69,6 @@ ACPI_MODULE_NAME("acpi_lpss");
 #define LPSS_SAVE_CTX			BIT(4)
 #define LPSS_NO_D3_DELAY		BIT(5)
=20
-/* Crystal Cove PMIC shares same ACPI ID between different platforms */
-#define BYT_CRC_HRV			2
-#define CHT_CRC_HRV			3
-
 struct lpss_private_data;
=20
 struct lpss_device_desc {
@@ -158,7 +154,7 @@ static void lpss_deassert_reset(struct lpss_private_d=
ata *pdata)
  */
 static struct pwm_lookup byt_pwm_lookup[] =3D {
 	PWM_LOOKUP_WITH_MODULE("80860F09:00", 0, "0000:00:02.0",
-			       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
+			       "pwm_soc_backlight", 0, PWM_POLARITY_NORMAL,
 			       "pwm-lpss-platform"),
 };
=20
@@ -170,8 +166,7 @@ static void byt_pwm_setup(struct lpss_private_data *p=
data)
 	if (!adev->pnp.unique_id || strcmp(adev->pnp.unique_id, "1"))
 		return;
=20
-	if (!acpi_dev_present("INT33FD", NULL, BYT_CRC_HRV))
-		pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
+	pwm_add_table(byt_pwm_lookup, ARRAY_SIZE(byt_pwm_lookup));
 }
=20
 #define LPSS_I2C_ENABLE			0x6c
@@ -204,7 +199,7 @@ static void byt_i2c_setup(struct lpss_private_data *p=
data)
 /* BSW PWM used for backlight control by the i915 driver */
 static struct pwm_lookup bsw_pwm_lookup[] =3D {
 	PWM_LOOKUP_WITH_MODULE("80862288:00", 0, "0000:00:02.0",
-			       "pwm_backlight", 0, PWM_POLARITY_NORMAL,
+			       "pwm_soc_backlight", 0, PWM_POLARITY_NORMAL,
 			       "pwm-lpss-platform"),
 };
=20
--=20
2.23.0

