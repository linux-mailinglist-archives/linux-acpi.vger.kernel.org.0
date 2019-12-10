Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5611843A
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 10:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfLJJ56 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 04:57:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJJ56 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 04:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575971876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=P/sE2lt0inUQqf8c5LCscAIyMOGYq6hxvcNv5XzwUCE=;
        b=ivkYllYlcUDM3hqPDukDmRTDaQ7GDwmQtGuDotJXQNtwwTpiQ1nJRbWB6g5kzlRlq66Xvl
        5M3XkChQQxDRuSiJKuiFrbp/YY0A85AxU1AmfaFQLyKYhS/BRm/XeJmt9Jb8ZI/WXdoe6y
        0P19QGUTnjt7X9vJwGsnTFDg7uCyLwY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-KZSxspvqNwWc8-f48Uu4iw-1; Tue, 10 Dec 2019 04:57:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC0061005513;
        Tue, 10 Dec 2019 09:57:54 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA55B60BE1;
        Tue, 10 Dec 2019 09:57:53 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] ACPI / battery: Deal with design or full capacity being reported as -1
Date:   Tue, 10 Dec 2019 10:57:50 +0100
Message-Id: <20191210095752.4211-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: KZSxspvqNwWc8-f48Uu4iw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit b41901a2cf06 ("ACPI / battery: Do not export energy_full[_design] on
devices without full_charge_capacity") added support for some (broken)
devices which always report 0 for both design- and full_charge-capacity.

This assumes that if the capacity is not being reported it is 0. The
ThunderSoft TS178 tablet's _BIX implementation falsifies this assumption.
It reports ACPI_BATTERY_VALUE_UNKNOWN (-1) as full_charge_capacity, which
we treat as a valid value which causes several problems.

This commit fixes this by adding a new ACPI_BATTERY_CAPACITY_VALID() helper
which checks that the value is not 0 and not -1; and using this whenever we
need to test if either design_capacity or full_charge_capacity is valid.

Fixes: b41901a2cf06 ("ACPI / battery: Do not export energy_full[_design] on=
 devices without full_charge_capacity")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/battery.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 558fedf8a7a1..9c0d7c577cb9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -38,6 +38,8 @@
 #define PREFIX "ACPI: "
=20
 #define ACPI_BATTERY_VALUE_UNKNOWN 0xFFFFFFFF
+#define ACPI_BATTERY_CAPACITY_VALID(capacity) \
+=09((capacity) !=3D 0 && (capacity) !=3D ACPI_BATTERY_VALUE_UNKNOWN)
=20
 #define ACPI_BATTERY_DEVICE_NAME=09"Battery"
=20
@@ -192,7 +194,8 @@ static int acpi_battery_is_charged(struct acpi_battery =
*battery)
=20
 static bool acpi_battery_is_degraded(struct acpi_battery *battery)
 {
-=09return battery->full_charge_capacity && battery->design_capacity &&
+=09return ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
+=09=09ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity) &&
 =09=09battery->full_charge_capacity < battery->design_capacity;
 }
=20
@@ -263,14 +266,14 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
 =09=09break;
 =09case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 =09case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
-=09=09if (battery->design_capacity =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
+=09=09if (!ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
 =09=09=09ret =3D -ENODEV;
 =09=09else
 =09=09=09val->intval =3D battery->design_capacity * 1000;
 =09=09break;
 =09case POWER_SUPPLY_PROP_CHARGE_FULL:
 =09case POWER_SUPPLY_PROP_ENERGY_FULL:
-=09=09if (battery->full_charge_capacity =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
+=09=09if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity))
 =09=09=09ret =3D -ENODEV;
 =09=09else
 =09=09=09val->intval =3D battery->full_charge_capacity * 1000;
@@ -283,11 +286,12 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
 =09=09=09val->intval =3D battery->capacity_now * 1000;
 =09=09break;
 =09case POWER_SUPPLY_PROP_CAPACITY:
-=09=09if (battery->capacity_now && battery->full_charge_capacity)
+=09=09if (battery->capacity_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN ||
+=09=09    !ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity))
+=09=09=09ret =3D -ENODEV;
+=09=09else
 =09=09=09val->intval =3D battery->capacity_now * 100/
 =09=09=09=09=09battery->full_charge_capacity;
-=09=09else
-=09=09=09val->intval =3D 0;
 =09=09break;
 =09case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 =09=09if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
@@ -799,7 +803,8 @@ static int sysfs_add_battery(struct acpi_battery *batte=
ry)
 =09=09battery->bat_desc.properties =3D charge_battery_props;
 =09=09battery->bat_desc.num_properties =3D
 =09=09=09ARRAY_SIZE(charge_battery_props);
-=09} else if (battery->full_charge_capacity =3D=3D 0) {
+=09} else if (!ACPI_BATTERY_CAPACITY_VALID(
+=09=09=09=09=09battery->full_charge_capacity)) {
 =09=09battery->bat_desc.properties =3D
 =09=09=09energy_battery_full_cap_broken_props;
 =09=09battery->bat_desc.num_properties =3D
--=20
2.23.0

