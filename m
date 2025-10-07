Return-Path: <linux-acpi+bounces-17652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0DBC2F95
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 01:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29D254ED810
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 23:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D58C261B6C;
	Tue,  7 Oct 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SZUTfSFD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254E22579E;
	Tue,  7 Oct 2025 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880531; cv=none; b=QFOk8hPNDJBCWfRzGofIDE/mqISpzAltw3Qn1JdnHUpfg5CiB3DyiORQzzAgQisqdkO01wY49kGoz1l/St0Vt7ojStfM+9zhZ+IgFnhIjH4nbOPEDNiAv4KghwEtoCLU73J2jN+rb99gQsY31gb4sOYHNcc6Y/feOxtk6Va0jfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880531; c=relaxed/simple;
	bh=0RWOXnLR7FG9+TwshK3PGnYQaOOl5snD5H0QN+aIVXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=los5ZCjRIDAD702j8BYw8gnQi9xzj2V07BbJBE/jm13kCbK3ZlHOmjYfRndW1FCPKRC5IvdsjEYtxAqSmVW1PFnUaqEssZEzBQZf+hwyMq1CfXTeWzpG1ouNFSMuhyrl4CyRK/AOOI1UqQEp/ERdaJXg/aZf3/QXHeB3W56n0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SZUTfSFD; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759880523; x=1760485323; i=w_armin@gmx.de;
	bh=FivFU/5ysNNcOss1NqFYq2iX+hPjy6cOYfxHk161Nsw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SZUTfSFDTcDXdjWpuNbGFpkyayUHf4iY4jFN/ULLm3maP/yg5HQvhPRCeGRWvsTM
	 pNPL5FZDuWanpkuM7MVntFABlNZdOypcQqhcl3v+pjHls49i1FBzDkFEN+pojlMi/
	 BawG7hUFeXy2/BSQub8DsuMV2/ZycFzwRE10YRH5CsCYykZ3qLzeeM50Q5XgvHbp8
	 OdCPJ7+sQWJGKrR/wnyMzMcLFGi5bnWl/yfeRcHOFJu33Pqiy2Q8xAYoYUyYoTB8g
	 N2phgeoZVfhsfXNmkQgxf/OXTHGYWcCLTvFwBBFQMgAJX7bR+RWfC3WCDIher9u9A
	 K42dA6tdO3XImPdifw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MuUj2-1uFxua3Kle-00vVZV; Wed, 08 Oct 2025 01:42:03 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ACPI: fan: Workaround for 64-bit firmware bug
Date: Wed,  8 Oct 2025 01:41:45 +0200
Message-Id: <20251007234149.2769-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251007234149.2769-1-W_Armin@gmx.de>
References: <20251007234149.2769-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GiRGmZCgqACSKsM2p/LsRA/ipv5zvp/VO60t8kCqnJ50TKM1gkB
 BZCbL7lJ4osDP4aIXo6D9U5UYNDUDmRVtQhA+uLsqQzjyJLJGMiTXGQAhNPYNBKFEVPwEhB
 m820u3UQT6oRhFanJb/AV4KRI82pkjbOH//iSFPTxqixAMPj2AD8cWUVJCo4EbWhPPnCff9
 XTXOUplsHph1wMrNwnZVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BFdWFEgnbLc=;vFeVkWcy3a22V2TgAnEsYZlgr+p
 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
 D3RZpCT7crBdXsMJ8nFGREsrzU=

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


