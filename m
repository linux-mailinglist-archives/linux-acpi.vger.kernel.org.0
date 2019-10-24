Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6311E3E55
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfJXVio (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 17:38:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31175 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729642AbfJXVil (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 17:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571953119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zykJQTGo9Sw+cudoLilz9/caRhMxcv+zXgJyYE6PrMw=;
        b=A8sl2AYThF7S1tE7msbFX9hI8znUvdHHzyd46C89IivBfKx6OceEhAP2mdPHavjVndsz4x
        /7n8Va99rOOWnSe4uwsja2hgPWghjl2vzelOMb+nmEP8W6pXMx6SyotrbQ3qeY9AHxoY9j
        H2NIqt4ATxFdarJQGFMh+3hYpErx2GU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Wr0MtbKsOKqJaw6ejm1DOw-1; Thu, 24 Oct 2019 17:38:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 093CA476;
        Thu, 24 Oct 2019 21:38:35 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72EDE5C1B5;
        Thu, 24 Oct 2019 21:38:33 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ACPI / PMIC: Add byt prefix to Crystal Cove PMIC OpRegion driver
Date:   Thu, 24 Oct 2019 23:38:25 +0200
Message-Id: <20191024213827.144974-3-hdegoede@redhat.com>
In-Reply-To: <20191024213827.144974-1-hdegoede@redhat.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Wr0MtbKsOKqJaw6ejm1DOw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Our current Crystal Cove OpRegion driver is only valid for the
Crystal Cove PMIC variant found on Bay Trail (BYT) boards,
Cherry Trail (CHT) based boards use another variant.

At least the regulator registers are different on CHT and these registers
are one of the things controlled by the custom PMIC OpRegion.

Commit 4d9ed62ab142 ("mfd: intel_soc_pmic: Export separate mfd-cell
configs for BYT and CHT") has disabled the intel_pmic_crc.c code for CHT
devices by removing the "crystal_cove_pmic" MFD cell on CHT devices.

This commit renames the intel_pmic_crc.c driver and the cell to be
prefixed with "byt" to indicate that this code is for BYT devices only.

This is a preparation patch for adding a separate PMIC OpRegion
driver for the CHT variant of the Crystal Cove PMIC (sometimes called
Crystal Cove Plus in Android kernel sources).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/Kconfig                                       | 7 ++++---
 drivers/acpi/Makefile                                      | 2 +-
 .../acpi/pmic/{intel_pmic_crc.c =3D> intel_pmic_bytcrc.c}    | 4 ++--
 drivers/mfd/intel_soc_pmic_crc.c                           | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)
 rename drivers/acpi/pmic/{intel_pmic_crc.c =3D> intel_pmic_bytcrc.c} (98%)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ebe1e9e5fd81..089f7f8e1be7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -513,11 +513,12 @@ menuconfig PMIC_OPREGION
 =09  PMIC chip.
=20
 if PMIC_OPREGION
-config CRC_PMIC_OPREGION
-=09bool "ACPI operation region support for CrystalCove PMIC"
+config BYTCRC_PMIC_OPREGION
+=09bool "ACPI operation region support for Bay Trail Crystal Cove PMIC"
 =09depends on INTEL_SOC_PMIC
 =09help
-=09  This config adds ACPI operation region support for CrystalCove PMIC.
+=09  This config adds ACPI operation region support for the Bay Trail
+=09  version of the Crystal Cove PMIC.
=20
 config XPOWER_PMIC_OPREGION
 =09bool "ACPI operation region support for XPower AXP288 PMIC"
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5d361e4e3405..ee59b1db69a1 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -109,7 +109,7 @@ obj-$(CONFIG_ACPI_APEI)=09=09+=3D apei/
 obj-$(CONFIG_ACPI_EXTLOG)=09+=3D acpi_extlog.o
=20
 obj-$(CONFIG_PMIC_OPREGION)=09+=3D pmic/intel_pmic.o
-obj-$(CONFIG_CRC_PMIC_OPREGION) +=3D pmic/intel_pmic_crc.o
+obj-$(CONFIG_BYTCRC_PMIC_OPREGION) +=3D pmic/intel_pmic_bytcrc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) +=3D pmic/intel_pmic_xpower.o
 obj-$(CONFIG_BXT_WC_PMIC_OPREGION) +=3D pmic/intel_pmic_bxtwc.o
 obj-$(CONFIG_CHT_WC_PMIC_OPREGION) +=3D pmic/intel_pmic_chtwc.o
diff --git a/drivers/acpi/pmic/intel_pmic_crc.c b/drivers/acpi/pmic/intel_p=
mic_bytcrc.c
similarity index 98%
rename from drivers/acpi/pmic/intel_pmic_crc.c
rename to drivers/acpi/pmic/intel_pmic_bytcrc.c
index a0f411a6e5ac..2a692cc4b7ae 100644
--- a/drivers/acpi/pmic/intel_pmic_crc.c
+++ b/drivers/acpi/pmic/intel_pmic_bytcrc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Intel CrystalCove PMIC operation region driver
+ * Intel Bay Trail Crystal Cove PMIC operation region driver
  *
  * Copyright (C) 2014 Intel Corporation. All rights reserved.
  */
@@ -295,7 +295,7 @@ static int intel_crc_pmic_opregion_probe(struct platfor=
m_device *pdev)
 static struct platform_driver intel_crc_pmic_opregion_driver =3D {
 =09.probe =3D intel_crc_pmic_opregion_probe,
 =09.driver =3D {
-=09=09.name =3D "crystal_cove_pmic",
+=09=09.name =3D "byt_crystal_cove_pmic",
 =09},
 };
 builtin_platform_driver(intel_crc_pmic_opregion_driver);
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_=
crc.c
index b6ab72fa0569..ab09b8225b76 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -75,7 +75,7 @@ static struct mfd_cell crystal_cove_byt_dev[] =3D {
 =09=09.resources =3D gpio_resources,
 =09},
 =09{
-=09=09.name =3D "crystal_cove_pmic",
+=09=09.name =3D "byt_crystal_cove_pmic",
 =09},
 =09{
 =09=09.name =3D "crystal_cove_pwm",
--=20
2.23.0

