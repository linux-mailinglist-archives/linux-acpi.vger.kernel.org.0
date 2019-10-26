Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC71E5F75
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Oct 2019 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfJZUYt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Oct 2019 16:24:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48595 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726442AbfJZUYt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Oct 2019 16:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572121488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Webff0ebFDGY939ndhN5UUSk2dJ3tUSm8wOgeTRsMZA=;
        b=A7zPkNPMDQuP6PFME3R8twb7WYglgvd3GaMms8VJiTVwBQB5+TejsHOmzkejsGwF7nhxkV
        rk08HCCykOR5ibuRVef9Y2zY8MMqQ0d0SLkGKGCjW5Gvb4JqTstudvWPdLt1rwH3isbX4V
        ktj5z1xga9JM3W2Lo/zAKG/Cgyr7rb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-2QQfaA58Nv-0AMf6wg62NQ-1; Sat, 26 Oct 2019 16:24:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D51F0107AD25;
        Sat, 26 Oct 2019 20:24:43 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-34.ams2.redhat.com [10.36.116.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96C075C1D4;
        Sat, 26 Oct 2019 20:24:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 4/6] ACPI / button: Add DMI quirk for Medion Akoya E2215T
Date:   Sat, 26 Oct 2019 22:24:34 +0200
Message-Id: <20191026202436.311894-4-hdegoede@redhat.com>
In-Reply-To: <20191026202436.311894-1-hdegoede@redhat.com>
References: <20191026202436.311894-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 2QQfaA58Nv-0AMf6wg62NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Medion Akoya E2215T's ACPI _LID implementation is quite broken:

1. For notifications it uses an ActiveLow Edge GpioInt, rather then
an ActiveBoth one, meaning that the device is only notified when the
lid is closed, not when it is opened.

2. Matching with this its _LID method simply always returns 0 (closed)

In order for the Linux LID code to work properly with this implementation,
the lid_init_state selection needs to be set to ACPI_BUTTON_LID_INIT_OPEN.

This commit adds a DMI quirk for this.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index d83b15bae515..e4b2aa43265b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -86,6 +86,17 @@ static const struct dmi_system_id dmi_lid_quirks[] =3D {
 =09=09},
 =09=09.driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_DISABLED,
 =09},
+=09{
+=09=09/*
+=09=09 * Medion Akoya E2215T, notification of the LID device only
+=09=09 * happens on close, not on open and _LID always returns closed.
+=09=09 */
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "E2215T MD60198"),
+=09=09},
+=09=09.driver_data =3D (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+=09},
 =09{}
 };
=20
--=20
2.23.0

