Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C19BE5F72
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2019 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJZUYq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Oct 2019 16:24:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21854 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbfJZUYq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Oct 2019 16:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572121484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BUbAJWH4DG1M3bzsMNmYdfepgpNg0kF5UxUfMq+EvHI=;
        b=ZFxM8XG1GcPFIaHfv1RAGlUNEoJE96FSwRPnBK23i0pAdTw+Nr75U8VK71b3jc+4udXcWx
        rILBOiJClyFknEUs4iMAXrSFiJXkbt/thv6XAbH9LNlSW6xNQcqbQIXwxmbttlyM3yd3ib
        3ddL1GnCDlLF2/8FAs55Xdltow+3KfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-8PPwwOXuOv-6kxwWDTLJig-1; Sat, 26 Oct 2019 16:24:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 507F2476;
        Sat, 26 Oct 2019 20:24:42 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13C275C1D4;
        Sat, 26 Oct 2019 20:24:40 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 3/6] ACPI / button: Turn lid_blacklst dmi table into a generic quirk table
Date:   Sat, 26 Oct 2019 22:24:33 +0200
Message-Id: <20191026202436.311894-3-hdegoede@redhat.com>
In-Reply-To: <20191026202436.311894-1-hdegoede@redhat.com>
References: <20191026202436.311894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8PPwwOXuOv-6kxwWDTLJig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit 3540c32a9ae4 ("ACPI / button: Add quirks for initial lid state
notification") added 3 different modes to the LID handling code to deal
with various buggy implementations.

Until now users which need one of the 2 non-default modes to get their
hw to work have to pass a kernel commandline option for this.

E.g. https://bugzilla.kernel.org/show_bug.cgi?id=3D106151 was closed with a
note that the user has to add "button.lid_init_state=3Dopen" to the kernel
commandline to get the LID code to not cause undesirable suspends on his
Samsung N210 Plus.

This commit modifies the existing lid_blacklst dmi table so that it can
be used not only to completely disable the LID code on devices where
the ACPI tables are broken beyond repair, but also to select one of the 2
non default LID handling modes on devices where this is necessary.

This will allow us to add quirks to make the LID work OOTB on broken
devices. Getting this working OOTB is esp. important because the typical
breakage is false LID closed reporting, causing undesirable suspends which
basically make the system unusable.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Change lid_init_state variable type to long
---
 drivers/acpi/button.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 7f69d8d1905b..d83b15bae515 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -75,18 +75,16 @@ static const struct acpi_device_id button_device_ids[] =
=3D {
 };
 MODULE_DEVICE_TABLE(acpi, button_device_ids);
=20
-/*
- * Some devices which don't even have a lid in anyway have a broken _LID
- * method (e.g. pointing to a floating gpio pin) causing spurious LID even=
ts.
- */
-static const struct dmi_system_id lid_blacklst[] =3D {
+/* Please keep this list sorted alphabetically by vendor and model */
+static const struct dmi_system_id dmi_lid_quirks[] =3D {
 =09{
-=09=09/* GP-electronic T701 */
+=09=09/* GP-electronic T701, _LID method points to a floating GPIO */
 =09=09.matches =3D {
 =09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
 =09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "T701"),
 =09=09=09DMI_MATCH(DMI_BIOS_VERSION, "BYT70A.YNCHENG.WIN.007"),
 =09=09},
+=09=09.driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 =09},
 =09{}
 };
@@ -128,7 +126,7 @@ struct acpi_button {
=20
 static BLOCKING_NOTIFIER_HEAD(acpi_lid_notifier);
 static struct acpi_device *lid_device;
-static u8 lid_init_state =3D ACPI_BUTTON_LID_INIT_METHOD;
+static long lid_init_state =3D -1;
=20
 static unsigned long lid_report_interval __read_mostly =3D 500;
 module_param(lid_report_interval, ulong, 0644);
@@ -483,8 +481,7 @@ static int acpi_button_add(struct acpi_device *device)
 =09int error;
=20
 =09if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
-=09    (dmi_check_system(lid_blacklst) ||
-=09     lid_init_state =3D=3D ACPI_BUTTON_LID_INIT_DISABLED))
+=09     lid_init_state =3D=3D ACPI_BUTTON_LID_INIT_DISABLED)
 =09=09return -ENODEV;
=20
 =09button =3D kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
@@ -623,6 +620,16 @@ MODULE_PARM_DESC(lid_init_state, "Behavior for reporti=
ng LID initial state");
=20
 static int acpi_button_register_driver(struct acpi_driver *driver)
 {
+=09const struct dmi_system_id *dmi_id;
+
+=09if (lid_init_state =3D=3D -1) {
+=09=09dmi_id =3D dmi_first_match(dmi_lid_quirks);
+=09=09if (dmi_id)
+=09=09=09lid_init_state =3D (long)dmi_id->driver_data;
+=09=09else
+=09=09=09lid_init_state =3D ACPI_BUTTON_LID_INIT_METHOD;
+=09}
+
 =09/*
 =09 * Modules such as nouveau.ko and i915.ko have a link time dependency
 =09 * on acpi_lid_open(), and would therefore not be loadable on ACPI
--=20
2.23.0

