Return-Path: <linux-acpi+bounces-5761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2158C2AFE
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 22:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9EC1C228DD
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3944548EF;
	Fri, 10 May 2024 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fONErUSe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235AC51033;
	Fri, 10 May 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372009; cv=none; b=orDYLjNtRLN7dR9MiNdi+GxTYFV1WGX3GjjPbpYhPIWawP7BdHN9WEQywhxo7Nthj5rkpnASsir7TH46ZI4Y2bikoo3A2kvouWWiAksJxWQ4yZIOw6XSdI2dsdTQ+WhURNWm8gvw6u8RTk/LFNOcOn15dpB73YpYyC/ZVAfWbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372009; c=relaxed/simple;
	bh=per/hNm6gn5WUjubEO/onHyax8GqkdBxZdfWzn/XcMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cUlV1eVfcHA/gRCmVbKmF82uDfXkpWou/NlssClGg7mHAVBT2Q/Z401ZBhnsaQJds58QjdBzNvN6HxbFSb8e5DBtm3KCF1H8dGNUx5VbMGm7XyvBDv+fk+V9sZ4DPN+9ik9rAGaLK66aN3Pgs3dabH1Lv0k8dgV5cUnLJccqtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fONErUSe; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715371975; x=1715976775; i=w_armin@gmx.de;
	bh=bdSctG16A5GpTmd+xziuiqKPE75csr/F0cy3+TzO6hw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fONErUSepfAGKJcp5xcm7maWddj7V9uZX8xmtsDJePmorca7szH+ufv3ccZ8PHMw
	 NsEd0h+ko3C0S5mTUuWuyO0sqoYQWE6xDlMkALY1PX+mrVkzVeSO075hhfs6aBiNa
	 lJwWWyCHhxp7cadqQYcPuZVKlY71dx8LnLXeoDZMxLaAUG9USYwDQ70cPMjQtb30l
	 x1l3ip1gghdscZ83/99P1yDu1YcaZKmsCBuRObUzxspgwFoXHeu2HseHyXnceSMid
	 fHB7EHHkED81kIXY44Avhdc2dLQd+u4D8FPbIgcm+1aT1fOQZX9bTnPzJBZkV5rYV
	 hbQw38JXUpmuVc2IFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MDQeK-1rv2ED1O7S-00Bfsn; Fri, 10 May 2024 22:12:55 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mlj@danelec.com,
	rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: jdelvare@suse.com,
	andy.shevchenko@gmail.com,
	linux@roeck-us.net,
	linux@weissschuh.net,
	ilpo.jarvinen@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v8] ACPI: fan: Add hwmon support
Date: Fri, 10 May 2024 22:12:42 +0200
Message-Id: <20240510201242.3886-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l8rlY1dBp5vJ0zLYcF5ArJWdiZGfP9ykA8N9KprHsk7q2DaF3oN
 JZDHr+1CdnKM7XAzI7WnnovCmvN8OiaYPBxrU58wJAcKn5T7lA2kWRwD0+HcvRDduKJBEbR
 6D9jBEA1fAe4URhuR/uMywujWjNRZc0YkXj8+FoMu/WPH4zvW4i/zzKTuuwatHMcQYZBkgU
 h7Cu3PAuIUO3XXL0HlD2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bzmjde0DiCQ=;BrD2dFRJv5IBY4Zo/POIDwuDFs8
 Kaws7MYq7QRm1ByVzCLBeFH9j7NpSIbiI6LO8DQiyzZwpZduevUqZQencADyUgxhACA1xjg9C
 CbxVNqR60tpaJQqtMBy0GrxXWHDyUr+KIutCtE6A0bqHTV/1qdneNcsUOBHHX9HNTJC0tthL9
 Xw7V4YusZXjjGozWpt9Ts5rXf8jxRoTLVipblqt7PQ7MRF/bZWf1z7y4LCmt3TyrvLx4M6QOq
 tYgPw6/tsWxIHQfnx3xup4hbDfe9vjSG+daz4BdD96gUU0ObXLU7Pxg9wVcWKoA9H/UuLhN9Y
 1/E7litPperncDkpiCr8VgkmOfIofGO/CI5qSzY2gAMzgI2r7Jz1SCS0WB8Gg49Sn42EIzsIX
 wn3Jt1iYovbqQKCvhQYxOk6qHWqz0c1jelJUlFOgCCDx2ePEUs4QERYQo+SpTPKaCnXA/KTrk
 2JJyuXeAlMzgrIWNS/9rD0qPBqBIXxzfes6rv8qQ1kU4PeDKnNP2rd/81x/k+hg7zh/5sJ3EB
 Xaoj9kmGxIncREaFdK9clbF2be+ZqE15XRBerRl75cLDzC3JLrY0ygR01rbKPk7LUtQ8+7iDD
 4XW4iAv+se56x7qRx+vpXYGQwj41IORNNN72p0fJFpl15UfPk2x8/QuWv5zbNNuBJ5txg6V7N
 WSnmsOKjerrO7h/wW6znLwDP1EpR9u0no3p1Ez8ku7efmb93sLSm/tCmwjewMpZKbUPrirKv/
 zD6Yb4m+1m/MiRly8ZlRN9wVqGv0nwMCykXKBJkqVumL7S3qxVXZVuCa1gk9W81+1Rniowfvt
 6qyJP/4oG6MuG+iQ76AOWcQoyaz8VLAWsZxtB1t0/lLIU=

Currently, the driver does only support a custom sysfs
interface to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Tested witha custom ACPI SSDT, available here:
https://github.com/Wer-Wolf/acpi-fan-ssdt

Changes since v7:
- add Reviewed-by tag
- spelling fixes
- add missing types.h include

Changes since v6:
- add "hwmon" to the names of functions and variables
related to hwmon
- replace -ENODATA with -EIO/-ENODEV

Changes since v5:
- fix coding style issues
- replace double break with return
- add missing includes

Changes since v4:
- fix spelling issues
- check power values for overflow condition too

Changes since v3:
- drop fault attrs
- rework initialization

Changes since v2:
- add support for fanX_target and power attrs

Changes since v1:
- fix undefined reference error
- fix fan speed validation
- coding style fixes
- clarify that the changes are compile-tested only
- add hwmon maintainers to cc list
=2D--
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/fan.h       |   9 +++
 drivers/acpi/fan_core.c  |   4 +
 drivers/acpi/fan_hwmon.c | 170 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/acpi/fan_hwmon.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 39ea5cfa8326..61ca4afe83dc 100644
=2D-- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)	+=3D tiny-power-but=
ton.o
 obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
 fan-objs			:=3D fan_core.o
 fan-objs			+=3D fan_attr.o
+fan-$(CONFIG_HWMON)		+=3D fan_hwmon.o

 obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
 obj-$(CONFIG_ACPI_TAD)		+=3D acpi_tad.o
diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index f89d19c922dc..db25a3898af7 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -10,6 +10,8 @@
 #ifndef _ACPI_FAN_H_
 #define _ACPI_FAN_H_

+#include <linux/kconfig.h>
+
 #define ACPI_FAN_DEVICE_IDS	\
 	{"INT3404", }, /* Fan */ \
 	{"INTC1044", }, /* Fan for Tiger Lake generation */ \
@@ -57,4 +59,11 @@ struct acpi_fan {
 int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst=
);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
+
+#if IS_REACHABLE(CONFIG_HWMON)
+int devm_acpi_fan_create_hwmon(struct acpi_device *device);
+#else
+static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device) =
{ return 0; };
+#endif
+
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index ff72e4ef8738..7cea4495f19b 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 		if (result)
 			return result;

+		result =3D devm_acpi_fan_create_hwmon(device);
+		if (result)
+			return result;
+
 		result =3D acpi_fan_create_attributes(device);
 		if (result)
 			return result;
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
new file mode 100644
index 000000000000..bd0d31a398fa
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * hwmon interface for the ACPI Fan driver.
+ *
+ * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/limits.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include "fan.h"
+
+/* Returned when the ACPI fan does not support speed reporting */
+#define FAN_SPEED_UNAVAILABLE	U32_MAX
+#define FAN_POWER_UNAVAILABLE	U32_MAX
+
+static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan=
, u64 control)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < fan->fps_count; i++) {
+		if (fan->fps[i].control =3D=3D control)
+			return &fan->fps[i];
+	}
+
+	return NULL;
+}
+
+static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_=
sensor_types type,
+					 u32 attr, int channel)
+{
+	const struct acpi_fan *fan =3D drvdata;
+	unsigned int i;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			return 0444;
+		case hwmon_fan_target:
+			/*
+			 * When in fine grain control mode, not every fan control value
+			 * has an associated fan performance state.
+			 */
+			if (fan->fif.fine_grain_ctrl)
+				return 0;
+
+			return 0444;
+		default:
+			return 0;
+		}
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			/*
+			 * When in fine grain control mode, not every fan control value
+			 * has an associated fan performance state.
+			 */
+			if (fan->fif.fine_grain_ctrl)
+				return 0;
+
+			/*
+			 * When all fan performance states contain no valid power data,
+			 * when the associated attribute should not be created.
+			 */
+			for (i =3D 0; i < fan->fps_count; i++) {
+				if (fan->fps[i].power !=3D FAN_POWER_UNAVAILABLE)
+					return 0444;
+			}
+
+			return 0;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
+}
+
+static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type, u32 attr,
+			       int channel, long *val)
+{
+	struct acpi_device *adev =3D to_acpi_device(dev->parent);
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	struct acpi_fan_fps *fps;
+	struct acpi_fan_fst fst;
+	int ret;
+
+	ret =3D acpi_fan_get_fst(adev, &fst);
+	if (ret < 0)
+		return ret;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
+				return -ENODEV;
+
+			if (fst.speed > LONG_MAX)
+				return -EOVERFLOW;
+
+			*val =3D fst.speed;
+			return 0;
+		case hwmon_fan_target:
+			fps =3D acpi_fan_get_current_fps(fan, fst.control);
+			if (!fps)
+				return -EIO;
+
+			if (fps->speed > LONG_MAX)
+				return -EOVERFLOW;
+
+			*val =3D fps->speed;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			fps =3D acpi_fan_get_current_fps(fan, fst.control);
+			if (!fps)
+				return -EIO;
+
+			if (fps->power =3D=3D FAN_POWER_UNAVAILABLE)
+				return -ENODEV;
+
+			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
+				return -EOVERFLOW;
+
+			*val =3D fps->power * MICROWATT_PER_MILLIWATT;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static const struct hwmon_ops acpi_fan_hwmon_ops =3D {
+	.is_visible =3D acpi_fan_hwmon_is_visible,
+	.read =3D acpi_fan_hwmon_read,
+};
+
+static const struct hwmon_channel_info * const acpi_fan_hwmon_info[] =3D =
{
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
+	NULL
+};
+
+static const struct hwmon_chip_info acpi_fan_hwmon_chip_info =3D {
+	.ops =3D &acpi_fan_hwmon_ops,
+	.info =3D acpi_fan_hwmon_info,
+};
+
+int devm_acpi_fan_create_hwmon(struct acpi_device *device)
+{
+	struct acpi_fan *fan =3D acpi_driver_data(device);
+	struct device *hdev;
+
+	hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", =
fan,
+						    &acpi_fan_hwmon_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hdev);
+}
=2D-
2.39.2


