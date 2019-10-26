Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF073E5F73
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2019 22:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfJZUYr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Oct 2019 16:24:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726422AbfJZUYq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Oct 2019 16:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572121485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0csuL53ZzW5FgXWdC4mrT0WYOr8NPyJjriMteDW9hi0=;
        b=N+QzntM/sq+zpSXG2PBpBKCXsVnhMpftfJwGg59cWlK0gJwzNZLwkhQzZ6yzkSY6+rCvxQ
        e2zcE3JufPcQ3x+tGh0unGGlBYCDCuus/WHjz0xUGLcoBoqmcWjy5IT8ME3AVQdJ+8Q5gT
        WRyVJFXqHbwkoGix5on/iS1PEozwfUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-qdmxlaudPEKC6ZxD27Rr6Q-1; Sat, 26 Oct 2019 16:24:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEADD1800DD6;
        Sat, 26 Oct 2019 20:24:40 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80BB75C1D4;
        Sat, 26 Oct 2019 20:24:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/6] ACPI / button: Allow disabling LID support with the lid_init_state module option
Date:   Sat, 26 Oct 2019 22:24:32 +0200
Message-Id: <20191026202436.311894-2-hdegoede@redhat.com>
In-Reply-To: <20191026202436.311894-1-hdegoede@redhat.com>
References: <20191026202436.311894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qdmxlaudPEKC6ZxD27Rr6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a new "disabled" value for the lid_init_state module option, which can
be used to disable LID support on devices where it is completely broken.

Sometimes devices seem to spontaneously suspend and the cause for this is
not clear. The LID switch is known to be one possible cause for this,
this commit allows easily disabling the LID switch for testing if it
is the cause.

For example some devices which do not even have a lid, still have a LID
device in their ACPI tables, pointing to a floating GPIO.

This is not really related to the initial LID state, but re-using the
existing option keeps things simple and it will make it much easier to
add DMI quirks which can either disable the LID completely or set another
non-default lid_init_state value, both of which are necessary on some
devices.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 121d747a840c..7f69d8d1905b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -48,12 +48,14 @@ enum {
 =09ACPI_BUTTON_LID_INIT_IGNORE,
 =09ACPI_BUTTON_LID_INIT_OPEN,
 =09ACPI_BUTTON_LID_INIT_METHOD,
+=09ACPI_BUTTON_LID_INIT_DISABLED,
 };
=20
 static const char * const lid_init_state_str[] =3D {
 =09[ACPI_BUTTON_LID_INIT_IGNORE]=09=09=3D "ignore",
 =09[ACPI_BUTTON_LID_INIT_OPEN]=09=09=3D "open",
 =09[ACPI_BUTTON_LID_INIT_METHOD]=09=09=3D "method",
+=09[ACPI_BUTTON_LID_INIT_DISABLED]=09=09=3D "disabled",
 };
=20
 #define _COMPONENT=09=09ACPI_BUTTON_COMPONENT
@@ -480,7 +482,9 @@ static int acpi_button_add(struct acpi_device *device)
 =09char *name, *class;
 =09int error;
=20
-=09if (!strcmp(hid, ACPI_BUTTON_HID_LID) && dmi_check_system(lid_blacklst)=
)
+=09if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
+=09    (dmi_check_system(lid_blacklst) ||
+=09     lid_init_state =3D=3D ACPI_BUTTON_LID_INIT_DISABLED))
 =09=09return -ENODEV;
=20
 =09button =3D kzalloc(sizeof(struct acpi_button), GFP_KERNEL);
--=20
2.23.0

