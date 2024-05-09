Return-Path: <linux-acpi+bounces-5704-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC3F8C194E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BD81C2220D
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58B6129A78;
	Thu,  9 May 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZT70aRlT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7905770E0;
	Thu,  9 May 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293227; cv=none; b=dr6Mjfd6UO2m/ZMnOCgnPb5PRvM6wURqaUvl2vL63DqBKeG6VszQQU9MpfxudFnAl/ew0iqwKxWCdGP6TO/lRW44joP2EnpFK+suQJcO07uk6Bj+YgnPs0AjYV8nES41LP0l9R3GSKzLh8SauQaqgDHLN5YNq4YWUncdbG2vqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293227; c=relaxed/simple;
	bh=eqJK/Rn6qanxxe4EBE/Fk3aejoZgpfMEjXIWxfjWGtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KuXV0RzdWrQ/QeAN9eGZliKsEL2cnEuY3Qeid13RBLYSrLqf46j0LEBIkje2mcz+s/czNwjaChG7BGDtEAjFW4uAS8ZD7oRKW/kPk9ri1C5jp25sv2lBCMuakCjRBAvo4Zf1dmmwEtXQNgzdLAWz+og8Fx5zYM+MIMbPRpSmJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZT70aRlT; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715293195; x=1715897995; i=w_armin@gmx.de;
	bh=MHd8t9IlX0+WAwv1hPyqVWDeN40kQ7ZcdSmxKIuiwjE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZT70aRlT959ikcadIH3YSLnmGh+qVVZ1cgqPyquw/PIZK46IH1pSz8Uzi1FlM3v3
	 nC4Dep0Lf8s97QJYFIM4fFIiDwRiewznMT5BZR7zm8aM6QGuf8xvT03Wymqt1xjLw
	 SNUxLGoCWjc/Fg3i+emfglbA9bQ4aGxa6UwQF0AdurSNuzelY0NpqXNlpiebBHJvk
	 7I63xoBIbla+24QkQozRGtQ2ygjA+fu8FiwsKPHc+e2Ixnl49sQAPJKoDPi1BlCm2
	 pokbkq0DhY5GXxFOqUvsTIjAD1GN40bkJof0UsHszgANJzJEVPxZkon7RR1BXu/1k
	 bdg+5eG+gC+S08WVTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N63Ra-1sghko3FFo-015HJm; Fri, 10 May 2024 00:19:54 +0200
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
Subject: [PATCH v7] ACPI: fan: Add hwmon support
Date: Fri, 10 May 2024 00:19:47 +0200
Message-Id: <20240509221947.3118-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kGWr9AYivua3WIlxOqZJzKhqZuKoLmNEOFjE1HzE+YCKZwAr/zW
 hH8g3uN5zNpTE1R+yWnOAI2pue3u9mauL63PpvxnkzcUo/wXC+vu0fHSdqSMvr7VEm9uRKL
 8Rh9HxEQU77s3WjhrIeConyJCO0KhOqVfXyJi5LBYxdMIBe6Uk3DgV0kS1fctpj4wV/bit/
 rhWx5sm3bezvnf30CvpIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zMXrHW4MwJM=;qZdCLMrpKgQ8AWWP5d925ZZunsw
 rgQNZfWBe/9+/KCTlKjPzZnCIicukNqsJ+hoQlAlrL8d6p3yENF7YWkqUdc0k+haEyaQ0rS5i
 dBnTpK3EtCYD195NmPuu4CgjxN8ZSqsAt6fICtiLJkRrkn8jEGzzdYCQVqH/n6PO8JdqyOl/y
 yxUR4aeiFfxEwPW9ZzJBPSaJ6S8V0VRuIVaYDHDUjHrtr+zJpjL6LG/E3BYVgvYjlb+g76iYl
 YMXEbDp3/XHtHi8Ft0QE1XMr+g8WC38p3rRPcCMDT4r1razZkoDX/8SfJLlVreIVbkrBScPM9
 VXPAN7Me/Z51xEcQPd+LzUqe3dZpBUywbnywYhWO47MCogHv2+YO2o2ZVj7jnxAPjcdA5X51C
 NhM/QxXqvowIa2SFRaKbnIeivOSZzvsLNWrkahz1o0132rKyAkuY30/tY3CppjpVO7zwD0b9s
 vixN0QD6Oao2LFTsJ0sNOoh7zyoXSvIVt3Oz2QSydDMsHcsn2oYd6ba92m5WSB1Gwf9BANogh
 r6GOVOwGX5juM/npVmtEBxJZWmlyGjXKerkV58BxMOAPFB882a7oPP/K2wiQHEK2luP8UjQ3C
 Y81NYMMbaduNEQWK4OhQwQRQyQ3yFjIFZASRQBCCqCim3Xbwo9QqvjQGd1tQuj+wDcyvPvOai
 pQZOLkf8pRcHMdAeyTcWsymtApQsdMuZM4Dk0UbXB2K3ep+PsFo4+5q5ocsSEHTSIdeg+nJZD
 eAzJJiNu9FjNJCWxvugLXwTshN9d8dlXGFV1dTXMD2+Qhrryk0SOg33ICShLBbyKwfD285Omx
 hmY0QNab80m7J9xr8bg8kJ6nJ8/2RgJDKdLoZqQ9LvLaY=

Currently, the driver does only support a custom sysfs
interface to allow userspace to read the fan speed.
Add support for the standard hwmon interface so users
can read the fan speed with standard tools like "sensors".

Tested with a custom ACPI SSDT.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
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
 drivers/acpi/fan_hwmon.c | 169 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
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
index 000000000000..af6365f1591a
=2D-- /dev/null
+++ b/drivers/acpi/fan_hwmon.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Hwmon interface for the ACPI Fan driver.
+ *
+ * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/limits.h>
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


