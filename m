Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5058E3E53
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 23:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfJXVij (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 17:38:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30344 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726386AbfJXVij (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 17:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571953117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLJiMYKydih2tsTxJkqfbqUmAZUH4J/oj98uXwv/pWM=;
        b=QpRn8UVkQUHHIelxvaenRMiHNGxAIc1NA+0ikJe3At+r03YJc2uXfrpg41Dk6QWyAscLBf
        jTNcRGrqZxgq3uB7Rz+JLpJBfb4TlqwvN0i9mvBYyduaHHlUJwX/QBpt4SnGEYhD8rv+6b
        V9TNf77aMP5FvnMY9tNuLeA1+mM3YcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-4l7dm4oUOmSWO2Ib8ehi_w-1; Thu, 24 Oct 2019 17:38:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D357800D49;
        Thu, 24 Oct 2019 21:38:33 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FF495C1D4;
        Thu, 24 Oct 2019 21:38:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ACPI / PMIC: Do not register handlers for unhandled OpRegions
Date:   Thu, 24 Oct 2019 23:38:24 +0200
Message-Id: <20191024213827.144974-2-hdegoede@redhat.com>
In-Reply-To: <20191024213827.144974-1-hdegoede@redhat.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4l7dm4oUOmSWO2Ib8ehi_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For some model PMIC's used on Intel boards we do not know how to
handle the power or thermal opregions because we have no documentation.

For example in the intel_pmic_chtwc.c driver thermal_table_count is 0,
which means that our PMIC_THERMAL_OPREGION_ID handler will always fail
with AE_BAD_PARAMETER, in this case it is better to simply not register
the handler at all.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/pmic/intel_pmic.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/pmic/intel_pmic.c b/drivers/acpi/pmic/intel_pmic.=
c
index 452041398b34..a371f273f99d 100644
--- a/drivers/acpi/pmic/intel_pmic.c
+++ b/drivers/acpi/pmic/intel_pmic.c
@@ -252,7 +252,7 @@ int intel_pmic_install_opregion_handler(struct device *=
dev, acpi_handle handle,
 =09=09=09=09=09struct regmap *regmap,
 =09=09=09=09=09struct intel_pmic_opregion_data *d)
 {
-=09acpi_status status;
+=09acpi_status status =3D AE_OK;
 =09struct intel_pmic_opregion *opregion;
 =09int ret;
=20
@@ -270,7 +270,8 @@ int intel_pmic_install_opregion_handler(struct device *=
dev, acpi_handle handle,
 =09opregion->regmap =3D regmap;
 =09opregion->lpat_table =3D acpi_lpat_get_conversion_table(handle);
=20
-=09status =3D acpi_install_address_space_handler(handle,
+=09if (d->power_table_count)
+=09=09status =3D acpi_install_address_space_handler(handle,
 =09=09=09=09=09=09    PMIC_POWER_OPREGION_ID,
 =09=09=09=09=09=09    intel_pmic_power_handler,
 =09=09=09=09=09=09    NULL, opregion);
@@ -279,7 +280,8 @@ int intel_pmic_install_opregion_handler(struct device *=
dev, acpi_handle handle,
 =09=09goto out_error;
 =09}
=20
-=09status =3D acpi_install_address_space_handler(handle,
+=09if (d->thermal_table_count)
+=09=09status =3D acpi_install_address_space_handler(handle,
 =09=09=09=09=09=09    PMIC_THERMAL_OPREGION_ID,
 =09=09=09=09=09=09    intel_pmic_thermal_handler,
 =09=09=09=09=09=09    NULL, opregion);
@@ -301,12 +303,16 @@ int intel_pmic_install_opregion_handler(struct device=
 *dev, acpi_handle handle,
 =09return 0;
=20
 out_remove_thermal_handler:
-=09acpi_remove_address_space_handler(handle, PMIC_THERMAL_OPREGION_ID,
-=09=09=09=09=09  intel_pmic_thermal_handler);
+=09if (d->thermal_table_count)
+=09=09acpi_remove_address_space_handler(handle,
+=09=09=09=09=09=09  PMIC_THERMAL_OPREGION_ID,
+=09=09=09=09=09=09  intel_pmic_thermal_handler);
=20
 out_remove_power_handler:
-=09acpi_remove_address_space_handler(handle, PMIC_POWER_OPREGION_ID,
-=09=09=09=09=09  intel_pmic_power_handler);
+=09if (d->power_table_count)
+=09=09acpi_remove_address_space_handler(handle,
+=09=09=09=09=09=09  PMIC_POWER_OPREGION_ID,
+=09=09=09=09=09=09  intel_pmic_power_handler);
=20
 out_error:
 =09acpi_lpat_free_conversion_table(opregion->lpat_table);
--=20
2.23.0

