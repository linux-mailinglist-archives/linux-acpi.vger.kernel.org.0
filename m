Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39EE3E54
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Oct 2019 23:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfJXVio (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Oct 2019 17:38:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32868 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729624AbfJXVim (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Oct 2019 17:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571953121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2lXcvf3NGx9wufR1ebxunRcF0UYoKhiuH8ZoVdeRXA=;
        b=A6XNn9E+nLLxToSIlxa8556iGw23G5rVhlpm5AQqF5s2Y5jBzbBlj1m9AtyADC1fBE7d8t
        Z8TE3czQkfobpQV/jzUaCLhKxcNSiSzO46T+e14iiFKIP60m7GPvKyf7TMJsQi5ExMerop
        eHH5nGB1Fyj/VjJ4Lai8uGqT/yE/faY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-1AsDRJMHO8qigRg4GtuJ6Q-1; Thu, 24 Oct 2019 17:38:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5136107AD31;
        Thu, 24 Oct 2019 21:38:36 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DDAF5C1B5;
        Thu, 24 Oct 2019 21:38:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ACPI / PMIC: Add Cherry Trail Crystal Cove PMIC OpRegion driver
Date:   Thu, 24 Oct 2019 23:38:26 +0200
Message-Id: <20191024213827.144974-4-hdegoede@redhat.com>
In-Reply-To: <20191024213827.144974-1-hdegoede@redhat.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1AsDRJMHO8qigRg4GtuJ6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We have no docs for the CHT Crystal Cove PMIC. The Asus Zenfone-2 kernel
code has 2 Crystal Cove regulator drivers, one calls the PMIC a "Crystal
Cove Plus" PMIC and talks about Cherry Trail, so presuambly that one
could be used to get register info for the regulators if we need to
implement regulator support in the future.

For now the sole purpose of this driver is to make
intel_soc_pmic_exec_mipi_pmic_seq_element work on devices with a
CHT Crystal Cove PMIC.

Specifically this fixes the following MIPI PMIC sequence related errors
on e.g. an Asus T100HA:

[  178.211801] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registere=
d
[  178.211897] [drm:intel_dsi_dcs_init_backlight_funcs [i915]] *ERROR* mipi=
_exec_pmic failed, error: -6

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/Kconfig                  |  7 +++++
 drivers/acpi/Makefile                 |  1 +
 drivers/acpi/pmic/intel_pmic_chtcrc.c | 44 +++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 drivers/acpi/pmic/intel_pmic_chtcrc.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 089f7f8e1be7..0f23d8b22c42 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -520,6 +520,13 @@ config BYTCRC_PMIC_OPREGION
 =09  This config adds ACPI operation region support for the Bay Trail
 =09  version of the Crystal Cove PMIC.
=20
+config CHTCRC_PMIC_OPREGION
+=09bool "ACPI operation region support for Cherry Trail Crystal Cove PMIC"
+=09depends on INTEL_SOC_PMIC
+=09help
+=09  This config adds ACPI operation region support for the Cherry Trail
+=09  version of the Crystal Cove PMIC.
+
 config XPOWER_PMIC_OPREGION
 =09bool "ACPI operation region support for XPower AXP288 PMIC"
 =09depends on MFD_AXP20X_I2C && IOSF_MBI=3Dy
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index ee59b1db69a1..68853f23e901 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_ACPI_EXTLOG)=09+=3D acpi_extlog.o
=20
 obj-$(CONFIG_PMIC_OPREGION)=09+=3D pmic/intel_pmic.o
 obj-$(CONFIG_BYTCRC_PMIC_OPREGION) +=3D pmic/intel_pmic_bytcrc.o
+obj-$(CONFIG_CHTCRC_PMIC_OPREGION) +=3D pmic/intel_pmic_chtcrc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) +=3D pmic/intel_pmic_xpower.o
 obj-$(CONFIG_BXT_WC_PMIC_OPREGION) +=3D pmic/intel_pmic_bxtwc.o
 obj-$(CONFIG_CHT_WC_PMIC_OPREGION) +=3D pmic/intel_pmic_chtwc.o
diff --git a/drivers/acpi/pmic/intel_pmic_chtcrc.c b/drivers/acpi/pmic/inte=
l_pmic_chtcrc.c
new file mode 100644
index 000000000000..ebf8d3187df1
--- /dev/null
+++ b/drivers/acpi/pmic/intel_pmic_chtcrc.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Cherry Trail Crystal Cove PMIC operation region driver
+ *
+ * Copyright (C) 2019 Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/mfd/intel_soc_pmic.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include "intel_pmic.h"
+
+/*
+ * We have no docs for the CHT Crystal Cove PMIC. The Asus Zenfone-2 kerne=
l
+ * code has 2 Crystal Cove regulator drivers, one calls the PMIC a "Crysta=
l
+ * Cove Plus" PMIC and talks about Cherry Trail, so presuambly that one
+ * could be used to get register info for the regulators if we need to
+ * implement regulator support in the future.
+ *
+ * For now the sole purpose of this driver is to make
+ * intel_soc_pmic_exec_mipi_pmic_seq_element work on devices with a
+ * CHT Crystal Cove PMIC.
+ */
+static struct intel_pmic_opregion_data intel_chtcrc_pmic_opregion_data =3D=
 {
+=09.pmic_i2c_address =3D 0x6e,
+};
+
+static int intel_chtcrc_pmic_opregion_probe(struct platform_device *pdev)
+{
+=09struct intel_soc_pmic *pmic =3D dev_get_drvdata(pdev->dev.parent);
+=09return intel_pmic_install_opregion_handler(&pdev->dev,
+=09=09=09ACPI_HANDLE(pdev->dev.parent), pmic->regmap,
+=09=09=09&intel_chtcrc_pmic_opregion_data);
+}
+
+static struct platform_driver intel_chtcrc_pmic_opregion_driver =3D {
+=09.probe =3D intel_chtcrc_pmic_opregion_probe,
+=09.driver =3D {
+=09=09.name =3D "cht_crystal_cove_pmic",
+=09},
+};
+builtin_platform_driver(intel_chtcrc_pmic_opregion_driver);
--=20
2.23.0

