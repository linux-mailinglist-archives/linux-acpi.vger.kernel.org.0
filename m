Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6845511843C
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 10:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfLJJ6L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 04:58:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726574AbfLJJ6L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 04:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575971890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xB17iNLfwbfCgp3EG3xLEd3Xgx6FryMGiq/bbDv8BI=;
        b=Y5Pre0/7J4CdELrfw2uP2c7ix7F0mT0NvnDBqlP64SLVUhUdvicGSD6c03xahV5GvDe/+L
        Rkq8zbFZCekV7Nk6gsgFquF5OwtRzLGjcYoOsEJd9dC+K4wMRtdPGh22InE7Bwr/SC+Pp8
        oihVoNq3R4tkPBn6JDVQ2oFgHHx991A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-38NzwQDCOEaYlCjamRMFBw-1; Tue, 10 Dec 2019 04:57:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 357A3800EC0;
        Tue, 10 Dec 2019 09:57:57 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3553860BE1;
        Tue, 10 Dec 2019 09:57:56 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] ACPI / battery: Deal better with neither design nor full capacity not being reported
Date:   Tue, 10 Dec 2019 10:57:52 +0100
Message-Id: <20191210095752.4211-3-hdegoede@redhat.com>
In-Reply-To: <20191210095752.4211-1-hdegoede@redhat.com>
References: <20191210095752.4211-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 38NzwQDCOEaYlCjamRMFBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Commit b41901a2cf06 ("ACPI / battery: Do not export energy_full[_design] on
devices without full_charge_capacity") added support for some (broken)
devices which always report 0 for both design_capacity and
full_charge_capacity.

Since the device that commit was written as a fix for is not reporting any
form of "full" capacity we cannot calculate the value for the
POWER_SUPPLY_PROP_CAPACITY, this is worked around by using an alternative
array of available properties which does not contain this property.

This is necessary because userspace (upower) treats us returning -ENODEV
as 0 and then typically will trigger an emergency shutdown because of that.
Userspace does not do this if the capacity sysfs attribute is not present
at all.

There are two potential problems with that commit:
1) It assumes that both full_charge- and design-capacity are broken at the
same time and only checks if full_charge- is broken.
2) It assumes that this only ever happens for devices which report energy
units rather then charge units.

This commit fixes both issues by only using the alternative
array of available properties if both full_charge- and design-capacity are
broken and by also adding an alternative array of available properties for
devices using mA units.

Fixes: b41901a2cf06 ("ACPI / battery: Do not export energy_full[_design] on=
 devices without full_charge_capacity")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/battery.c | 51 ++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 6132401f27d7..254a7d98b9d4 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -342,6 +342,20 @@ static enum power_supply_property charge_battery_props=
[] =3D {
 =09POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
=20
+static enum power_supply_property charge_battery_full_cap_broken_props[] =
=3D {
+=09POWER_SUPPLY_PROP_STATUS,
+=09POWER_SUPPLY_PROP_PRESENT,
+=09POWER_SUPPLY_PROP_TECHNOLOGY,
+=09POWER_SUPPLY_PROP_CYCLE_COUNT,
+=09POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
+=09POWER_SUPPLY_PROP_VOLTAGE_NOW,
+=09POWER_SUPPLY_PROP_CURRENT_NOW,
+=09POWER_SUPPLY_PROP_CHARGE_NOW,
+=09POWER_SUPPLY_PROP_MODEL_NAME,
+=09POWER_SUPPLY_PROP_MANUFACTURER,
+=09POWER_SUPPLY_PROP_SERIAL_NUMBER,
+};
+
 static enum power_supply_property energy_battery_props[] =3D {
 =09POWER_SUPPLY_PROP_STATUS,
 =09POWER_SUPPLY_PROP_PRESENT,
@@ -803,21 +817,34 @@ static void __exit battery_hook_exit(void)
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
 =09struct power_supply_config psy_cfg =3D { .drv_data =3D battery, };
+=09bool full_cap_broken =3D false;
+
+=09if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
+=09    !ACPI_BATTERY_CAPACITY_VALID(battery->design_capacity))
+=09=09full_cap_broken =3D true;
=20
 =09if (battery->power_unit =3D=3D ACPI_BATTERY_POWER_UNIT_MA) {
-=09=09battery->bat_desc.properties =3D charge_battery_props;
-=09=09battery->bat_desc.num_properties =3D
-=09=09=09ARRAY_SIZE(charge_battery_props);
-=09} else if (!ACPI_BATTERY_CAPACITY_VALID(
-=09=09=09=09=09battery->full_charge_capacity)) {
-=09=09battery->bat_desc.properties =3D
-=09=09=09energy_battery_full_cap_broken_props;
-=09=09battery->bat_desc.num_properties =3D
-=09=09=09ARRAY_SIZE(energy_battery_full_cap_broken_props);
+=09=09if (full_cap_broken) {
+=09=09=09battery->bat_desc.properties =3D
+=09=09=09    charge_battery_full_cap_broken_props;
+=09=09=09battery->bat_desc.num_properties =3D
+=09=09=09    ARRAY_SIZE(charge_battery_full_cap_broken_props);
+=09=09} else {
+=09=09=09battery->bat_desc.properties =3D charge_battery_props;
+=09=09=09battery->bat_desc.num_properties =3D
+=09=09=09    ARRAY_SIZE(charge_battery_props);
+=09=09}
 =09} else {
-=09=09battery->bat_desc.properties =3D energy_battery_props;
-=09=09battery->bat_desc.num_properties =3D
-=09=09=09ARRAY_SIZE(energy_battery_props);
+=09=09if (full_cap_broken) {
+=09=09=09battery->bat_desc.properties =3D
+=09=09=09    energy_battery_full_cap_broken_props;
+=09=09=09battery->bat_desc.num_properties =3D
+=09=09=09    ARRAY_SIZE(energy_battery_full_cap_broken_props);
+=09=09} else {
+=09=09=09battery->bat_desc.properties =3D energy_battery_props;
+=09=09=09battery->bat_desc.num_properties =3D
+=09=09=09    ARRAY_SIZE(energy_battery_props);
+=09=09}
 =09}
=20
 =09battery->bat_desc.name =3D acpi_device_bid(battery->device);
--=20
2.23.0

