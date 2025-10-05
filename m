Return-Path: <linux-acpi+bounces-17594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D1BBCD69
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 00:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91751895D82
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 22:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B724DCE3;
	Sun,  5 Oct 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kXi/zDXm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1A248F58;
	Sun,  5 Oct 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703135; cv=none; b=P/GV1fHBp9pnOHBxUp83xM6v4lPt5kKwYR9XrJFC7ewQ1cOEqhBC9kn6vnc8JH30aJMin6ORaFpk0yXXPh0ONZhpE+EDU7/BW5KI6Zo25ic3+QKn5Lwe5rpmpw6pJvCUmhdgGuJtah0dfXoWnSUNNSruy/vld4gXnm6PIJHVoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703135; c=relaxed/simple;
	bh=0RWOXnLR7FG9+TwshK3PGnYQaOOl5snD5H0QN+aIVXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rdXaCsyS2sBtWhavwLg/2QoMXzsVVTYA6cQwgbZkVve0Mr9fxX1Y2zqa0P0tRseKXcW2zkLhJYZ9khAdXlaNBXyCWsijyifRiRKT1yw7UEc4h3rPGGWPQuhgCLsg7zz4iogtHfJJ07vkkgtU27+gnoM0npx/t1MnTgWAA448ack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kXi/zDXm; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759703127; x=1760307927; i=w_armin@gmx.de;
	bh=FivFU/5ysNNcOss1NqFYq2iX+hPjy6cOYfxHk161Nsw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kXi/zDXmXJRy0tPkpsno+uaJc0A4ut51r2yuvvy4Ez+4YIZekeEHO9NM0jDl4W/Q
	 qER2ZO39K03Zle1AztuoCzIGAiRnjeY/ncZEnyEovyBdI28+aY5horGuyYXxLB3xJ
	 pcIeNVoi0IYM3KiNdR2MjP9Cvi/soMB1bZepJzVacCAiFQZAnNysQcAX/5Swbk9vG
	 nfIc2ongHRpkRikMNHCXa4kSCGDLG68hFBdvxF9cSb04bwRWhkIOLG0gifq83OAJ1
	 nIrCkADZdPbiQZl6QVDIQhCa2pZP+iq673r1AxAE/CTNa0kzURukk66nkNQnkrAlU
	 RMYfUrStIEnEUFTo1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mz9Ux-1uIds40VDn-00vh53; Mon, 06 Oct 2025 00:25:27 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] ACPI: fan: Workaround for 64-bit firmware bug
Date: Mon,  6 Oct 2025 00:25:09 +0200
Message-Id: <20251005222513.7794-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251005222513.7794-1-W_Armin@gmx.de>
References: <20251005222513.7794-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YPEtLeJVjS8+ZAHGX8/1zT2v2z/GeFqGfuZjBYNjLUeQ0HR//RK
 /BtUoRuJdRbBtJhJ8KkS2oh2O+k/ST08D8wYize99X63LilqHxpuOmDQFE0+LcTevC5Cn90
 qDde6b3PpDBBAw7+dFW32r3nQv2CkcEnvwrkgLFeV6jHdRshCMSHHNILeUH8Wa/SOUVFyQE
 YeueO1t1LYGyUYEeWrVjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rdoEA7aJETo=;fobz2ZB9V4r7pWIPvvVsdo3LG0o
 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
 vPZBikAFlNJorzV5C/KwTLW8RJomfo/uGODemN

Some firmware implementations use the "Ones" ASL opcode to produce
an integer with all bits set in order to indicate missing speed or
power readings. This however only works when using 32-bit intgers,
as the ACPI spec requires a 32-bit integer (0xFFFFFFFF) to be
returned for missing speed/power readings. With 64-bit integers the
"Ones" opcode produces a 64-bit integer with all bits set, violating
the ACPI spec regarding the placeholder value for missing readings.

Work around such buggy firmware implementation by also checking for
64-bit integers with all bits set when reading _FST.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h       | 33 +++++++++++++++++++++++++++++++++
 drivers/acpi/fan_hwmon.c | 10 +++-------
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index d39bb6fd1326..022bc215cdbc 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -11,6 +11,7 @@
 #define _ACPI_FAN_H_
=20
 #include <linux/kconfig.h>
+#include <linux/limits.h>
=20
 #define ACPI_FAN_DEVICE_IDS	\
 	{"INT3404", }, /* Fan */ \
@@ -60,6 +61,38 @@ struct acpi_fan {
 	struct device_attribute fine_grain_control;
 };
=20
+/**
+ * acpi_fan_speed_valid - Check if fan speed value is valid
+ * @speeed: Speed value returned by the ACPI firmware
+ *
+ * Check if the fan speed value returned by the ACPI firmware is valid. T=
his function is
+ * necessary as ACPI firmware implementations can return 0xFFFFFFFF to si=
gnal that the
+ * ACPI fan does not support speed reporting. Additionally, some buggy AC=
PI firmware
+ * implementations return a value larger than the 32-bit integer value de=
fined by
+ * the ACPI specification when using placeholder values. Such invalid val=
ues are also
+ * detected by this function.
+ *
+ * Returns: True if the fan speed value is valid, false otherwise.
+ */
+static inline bool acpi_fan_speed_valid(u64 speed)
+{
+	return speed < U32_MAX;
+}
+
+/**
+ * acpi_fan_power_valid - Check if fan power value is valid
+ * @power: Power value returned by the ACPI firmware
+ *
+ * Check if the fan power value returned by the ACPI firmware is valid.
+ * See acpi_fan_speed_valid() for details.
+ *
+ * Returns: True if the fan power value is valid, false otherwise.
+ */
+static inline bool acpi_fan_power_valid(u64 power)
+{
+	return power < U32_MAX;
+}
+
 int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index 4209a9923efc..5581aa6fdfa0 100644
=2D-- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -15,10 +15,6 @@
=20
 #include "fan.h"
=20
-/* Returned when the ACPI fan does not support speed reporting */
-#define FAN_SPEED_UNAVAILABLE	U32_MAX
-#define FAN_POWER_UNAVAILABLE	U32_MAX
-
 static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fan=
, u64 control)
 {
 	unsigned int i;
@@ -77,7 +73,7 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drv=
data, enum hwmon_sensor_
 			 * when the associated attribute should not be created.
 			 */
 			for (i =3D 0; i < fan->fps_count; i++) {
-				if (fan->fps[i].power !=3D FAN_POWER_UNAVAILABLE)
+				if (acpi_fan_power_valid(fan->fps[i].power))
 					return 0444;
 			}
=20
@@ -106,7 +102,7 @@ static int acpi_fan_hwmon_read(struct device *dev, enu=
m hwmon_sensor_types type,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
-			if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
+			if (!acpi_fan_speed_valid(fst.speed))
 				return -ENODEV;
=20
 			if (fst.speed > LONG_MAX)
@@ -134,7 +130,7 @@ static int acpi_fan_hwmon_read(struct device *dev, enu=
m hwmon_sensor_types type,
 			if (!fps)
 				return -EIO;
=20
-			if (fps->power =3D=3D FAN_POWER_UNAVAILABLE)
+			if (!acpi_fan_power_valid(fps->power))
 				return -ENODEV;
=20
 			if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWATT)
=2D-=20
2.39.5


