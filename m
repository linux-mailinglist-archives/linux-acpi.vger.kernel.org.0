Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734E9100852
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2019 16:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRPgL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 10:36:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56720 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbfKRPgK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Nov 2019 10:36:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574091370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fFo23KStxZEZFMUYITan3zWjwxcwxZWwrTSTfK3+ezc=;
        b=IwyOVmwRAiZ60fWf2JbGyqkS1WW+HeBEzTLiVMJRzUZLTl3xxmHSIv3t2GNJ8FNChtFN60
        xg9RmzQDPbyElnyiRDNfrddCWV7EVya4DCxKee63OIanTqii15o8veHWqFYhBNVZnqHSy9
        YPy0XsgqKUZ/b1vXdzLY1vgfClR+zYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-Dyt0Vd7EOjuSRmPXbDrCEg-1; Mon, 18 Nov 2019 10:36:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5612D8E36F6;
        Mon, 18 Nov 2019 15:35:59 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D66592B7C5;
        Mon, 18 Nov 2019 15:35:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI / button: Add DMI quirk for Acer Switch 10 SW5-032 lid-switch
Date:   Mon, 18 Nov 2019 16:35:56 +0100
Message-Id: <20191118153556.28751-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Dyt0Vd7EOjuSRmPXbDrCEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Acer Switch 10 SW5-032 _LID method is quite broken, it looks like this:

            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                If ((STAS & One))
                {
                    Local0 =3D One
                    PBCG |=3D 0x05000000
                    HMCG |=3D 0x05000000
                }
                Else
                {
                    Local0 =3D Zero
                    PBCG &=3D 0xF0FFFFFF
                    HMCG &=3D 0xF0FFFFFF
                }

                ^^PCI0.GFX0.CLID =3D Local0
                Return (Local0)
            }

The problem here is the accesses to the PBCG and HMCG, these are the
pinconf0 registers for the power, resp. the home button GPIO,
e.g. PBCG is declared as:

            OperationRegion (PWBT, SystemMemory, 0xFED0E080, 0x10)
            Field (PWBT, DWordAcc, NoLock, Preserve)
            {
                PBCG,   32,
                PBV1,   32,
                PBSA,   32,
                PBV2,   32
            }

Where 0xFED0E000 is the base address of the GPO2 device and 0x80 is
the offset for the pin used for the powerbutton.

The problem here is this line in _LID:
                    PBCG |=3D 0x05000000

This changes the trigger flags of the GPIO, changing when it generates
interrupts. Note it does not clear the original flags. Linux uses an
edge triggered interrupt on both positive and negative edges. This |=3D
adds the BYT_TRIG_LVL flag to this, so now it is turned into a level
interrupt which fires both when low and high, iow it simply always
fires leading to an interrupt storm, the tablet immediately waking up
from suspend again, etc.

There is nothing we can do to fix this, except for a DSDT override,
which the user needs to do manually. The only thing we can do is
never call _LID, which requires disabling the lid-switch functionality
altogether.

This commit adds a quirk for this, as no lid-switch function is better
then the interrupt storm. A user manually applying a DSDT override can
also override the quirk on the kernel cmdline.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index d27b01c0323d..b758b45737f5 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -77,6 +77,19 @@ MODULE_DEVICE_TABLE(acpi, button_device_ids);
=20
 /* Please keep this list sorted alphabetically by vendor and model */
 static const struct dmi_system_id dmi_lid_quirks[] =3D {
+=09{
+=09=09/*
+=09=09 * Acer Switch 10 SW5-012. _LID method messes with home and
+=09=09 * power button GPIO IRQ settings causing an interrupt storm on
+=09=09 * both GPIOs. This is unfixable without a DSDT override, so we
+=09=09 * have to disable the lid-switch functionality altogether :|
+=09=09 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+=09=09},
+=09=09.driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
+=09},
 =09{
 =09=09/*
 =09=09 * Asus T200TA, _LID keeps reporting closed after every second
--=20
2.23.0

