Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB6E3EA6
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 23:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJXV5e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 17:57:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729763AbfJXV5c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 17:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571954251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wc2f957ihR4qVmijz8Bcsmg1DjiYTsCTZfFe1hx3SBs=;
        b=B/OUwWVft3hdf4unmnWECcHFTujZRNWqvRRI9s16FeVPyE+ox+SrQsLRbtXx6GICglUIaB
        tYqbnxdO2gNNXcAA76tFVFi3MxN5RBz3GB/0oxFqWBwTUZcb7uNYNTbngKhUbv8X5B3upd
        8wbKfhsNi2o5It545zQ8c+u1b7vLdcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-R30luP0GMFmUkJCnRAw7xg-1; Thu, 24 Oct 2019 17:57:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43CDB1800D6B;
        Thu, 24 Oct 2019 21:57:29 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2F4D608C1;
        Thu, 24 Oct 2019 21:57:27 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 3/3] ACPI / LPSS: Add dmi quirk for skipping _DEP check for some device-links
Date:   Thu, 24 Oct 2019 23:57:23 +0200
Message-Id: <20191024215723.145922-3-hdegoede@redhat.com>
In-Reply-To: <20191024215723.145922-1-hdegoede@redhat.com>
References: <20191024215723.145922-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: R30luP0GMFmUkJCnRAw7xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The iGPU / GFX0 device's _PS0 method on the ASUS T200TA depends on the
I2C1 controller (which is connected to the embedded controller). But unlike
in the T100TA/T100CHI this dependency is not listed in the _DEP of the GFX0
device.

This results in the dev_WARN_ONCE(..., "Transfer while suspended\n") call
in i2c-designware-master.c triggering and the AML code not working as it
should.

This commit fixes this by adding a dmi based quirk mechanism for devices
which miss a _DEP, and adding a quirk for the LNXVIDEO depending on the
I2C1 device on the Asus T200TA.

Cc: stable@vger.kernel.org
Fixes: 2d71ee0ce72f ("ACPI / LPSS: Add a device link from the GPU to the BY=
T I2C5 controller")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add Fixes: tag

Changes in v3:
-Point Fixes tag to a more apropriate commit
---
 drivers/acpi/acpi_lpss.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index cd8cf3333f04..751ed38f2a10 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/mutex.h>
@@ -463,6 +464,18 @@ struct lpss_device_links {
 =09const char *consumer_hid;
 =09const char *consumer_uid;
 =09u32 flags;
+=09const struct dmi_system_id *dep_missing_ids;
+};
+
+/* Please keep this list sorted alphabetically by vendor and model */
+static const struct dmi_system_id i2c1_dep_missing_dmi_ids[] =3D {
+=09{
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "T200TA"),
+=09=09},
+=09},
+=09{}
 };
=20
 /*
@@ -478,7 +491,8 @@ static const struct lpss_device_links lpss_device_links=
[] =3D {
 =09/* CHT iGPU depends on PMIC I2C controller */
 =09{"808622C1", "7", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
 =09/* BYT iGPU depends on the Embedded Controller I2C controller (UID 1) *=
/
-=09{"80860F41", "1", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
+=09{"80860F41", "1", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME,
+=09 i2c1_dep_missing_dmi_ids},
 =09/* BYT CR iGPU depends on PMIC I2C controller (UID 5 on CR) */
 =09{"80860F41", "5", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
 =09/* BYT iGPU depends on PMIC I2C controller (UID 7 on non CR) */
@@ -577,7 +591,8 @@ static void acpi_lpss_link_consumer(struct device *dev1=
,
 =09if (!dev2)
 =09=09return;
=20
-=09if (acpi_lpss_dep(ACPI_COMPANION(dev2), ACPI_HANDLE(dev1)))
+=09if ((link->dep_missing_ids && dmi_check_system(link->dep_missing_ids))
+=09    || acpi_lpss_dep(ACPI_COMPANION(dev2), ACPI_HANDLE(dev1)))
 =09=09device_link_add(dev2, dev1, link->flags);
=20
 =09put_device(dev2);
@@ -592,7 +607,8 @@ static void acpi_lpss_link_supplier(struct device *dev1=
,
 =09if (!dev2)
 =09=09return;
=20
-=09if (acpi_lpss_dep(ACPI_COMPANION(dev1), ACPI_HANDLE(dev2)))
+=09if ((link->dep_missing_ids && dmi_check_system(link->dep_missing_ids))
+=09    || acpi_lpss_dep(ACPI_COMPANION(dev1), ACPI_HANDLE(dev2)))
 =09=09device_link_add(dev1, dev2, link->flags);
=20
 =09put_device(dev2);
--=20
2.23.0

