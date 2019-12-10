Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50E511843B
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLJJ6C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 04:58:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52992 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJJ6B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 04:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575971880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59qImdYxkwXetKcka7tDEquwBseQJzaDQAHCxQyRzMo=;
        b=W0MbXXIs2Qay3B+BrLAYWXfn4umVDdrfxe25sGcVVCFsoBydlCiBhdrKk6MvpcMruKyBvC
        IX/jjqX/cSz9+0BxPbsohVGZFjJxDxcefM1r0heVoj40fm36MaTKm59gcz2iSmCmLZ4h7z
        8eZR0N3it+9K2aftxinv7tN8YUja0ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-uMMiu1UGMPejSsI7rTY3Og-1; Tue, 10 Dec 2019 04:57:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D00107ACE3;
        Tue, 10 Dec 2019 09:57:55 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F29EC60BE1;
        Tue, 10 Dec 2019 09:57:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] ACPI / battery: Use design-cap for capacity calculations if full-cap is not available
Date:   Tue, 10 Dec 2019 10:57:51 +0100
Message-Id: <20191210095752.4211-2-hdegoede@redhat.com>
In-Reply-To: <20191210095752.4211-1-hdegoede@redhat.com>
References: <20191210095752.4211-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uMMiu1UGMPejSsI7rTY3Og-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ThunderSoft TS178 tablet's _BIX implementation reports design_capacity
but not full_charge_capacity.

Before this commit this would cause us to return -ENODEV for the capacity
attribute, which userspace does not like. Specifically upower does this:

        if (sysfs_file_exists (native_path, "capacity")) {
                percentage =3D sysfs_get_double (native_path, "capacity");

Where the sysfs_get_double() helper returns 0 when we return -ENODEV,
so the battery always reads 0% if we return -ENODEV.

This commit fixes this by using the design-capacity instead of the
full-charge-capacity when the full-charge-capacity is not available.

Fixes: b41901a2cf06 ("ACPI / battery: Do not export energy_full[_design] on=
 devices without full_charge_capacity")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/battery.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9c0d7c577cb9..6132401f27d7 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -217,7 +217,7 @@ static int acpi_battery_get_property(struct power_suppl=
y *psy,
 =09=09=09=09     enum power_supply_property psp,
 =09=09=09=09     union power_supply_propval *val)
 {
-=09int ret =3D 0;
+=09int full_capacity =3D ACPI_BATTERY_VALUE_UNKNOWN, ret =3D 0;
 =09struct acpi_battery *battery =3D to_acpi_battery(psy);
=20
 =09if (acpi_battery_present(battery)) {
@@ -286,12 +286,17 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
 =09=09=09val->intval =3D battery->capacity_now * 1000;
 =09=09break;
 =09case POWER_SUPPLY_PROP_CAPACITY:
+=09=09if (ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity))
+=09=09=09full_capacity =3D battery->full_charge_capacity;
+=09=09else if (ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
+=09=09=09full_capacity =3D battery->design_capacity;
+
 =09=09if (battery->capacity_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN ||
-=09=09    !ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity))
+=09=09    full_capacity =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
 =09=09=09ret =3D -ENODEV;
 =09=09else
 =09=09=09val->intval =3D battery->capacity_now * 100/
-=09=09=09=09=09battery->full_charge_capacity;
+=09=09=09=09=09full_capacity;
 =09=09break;
 =09case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 =09=09if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
--=20
2.23.0

