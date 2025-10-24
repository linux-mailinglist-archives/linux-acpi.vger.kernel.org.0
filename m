Return-Path: <linux-acpi+bounces-18211-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6066DC07C9F
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749913B8A84
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAD34C99D;
	Fri, 24 Oct 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hUwCGu2g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9834C821;
	Fri, 24 Oct 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331127; cv=none; b=IUaoX/VJyKhNumtddGJzhWVPaicSVpfCdY2Qz3WJC8Dr/5kxBWFd+4cCvTK8gMSYYEcZSL35iIlQ6EA8xDqRd2aYY9SgT77gCe8i2haGgIO0aKBrOD0xHS3GxZfGMoTZtddS+B7bG/cwWLWOVYMcML++uGPzgUdFBanZNENGV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331127; c=relaxed/simple;
	bh=VfuyrzGYcEicD1d9RUTdm+6Wif3rnUDFmF3gcDaE1f8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MawyFo6HPD43kJVHfs+HLKJAsrVRLZsSozJR1zeyefPiuCgnNoNScw4H8d0V0mSjPl/X+T23sJgD1/1Hj/Ibtu6lxKy+1odFfJY+pLtR9Y0ejWiN5nFPjhS9/rXDBVrRi66Up5fUUOipAF8x1/prNdkxXAGxhoaQsujQrHMjTx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hUwCGu2g; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761331119; x=1761935919; i=w_armin@gmx.de;
	bh=kI8zofgUNUgpbjLJnL4Sr/DLZs0GcHA0ckLMQDs0AsU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hUwCGu2gaNK9yJjrE3uTjwseXD4jYSCvaAGBlhlzEhCI6pimJKiPQxFFDQCgsUt7
	 N0QYf1oJXQ+6IJ6g3WCiAI4FHPBIUtv544jhAwAX2AdexvCYYuv/laVoPjuupigOW
	 NDNdk4h3TQafe4HE0wtQxskqrejQheVtSqruNgxBhns8s0NUK5DJ+Z4F9kSmpET4A
	 OREZCXes5mOq+n7rZKLqeUig4yWzjW3sjY/g7i8q/PRpUHi8cPGEQgaev+nQBy/jq
	 MJMdr7OqNqinu60vIzq51Dh4GtC8xNAp93FzU1hYNNdhES/P48AaEdXYx1GctpkSv
	 ypk4E9aD+6/rNJQAHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MqaxU-1uPsi647FI-00dOAF; Fri, 24 Oct 2025 20:38:39 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ACPI: fan: Add support for Microsoft fan extensions
Date: Fri, 24 Oct 2025 20:38:24 +0200
Message-Id: <20251024183824.5656-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251024183824.5656-1-W_Armin@gmx.de>
References: <20251024183824.5656-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cCUJa7O/fGLsQFcHfVnAILquOJ/RKBf2PTPl8SKA9NpZLrgWsuV
 zyuyNssMt4ylbGwlhQUTU89z445A8hbmXBTkvhlglwRPNhDuK0TaQIr3yzSGS1Wh3YFSJNg
 eRBBF/5cYukahFHX7JFnTTLkNaGP/i51N7zYNEkaaCjnRsJ+xnDXV2cH93eTFuj7GUq8ppV
 Vrgp8FSQTlPv2J3jPhVrA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2MK3trNCnIQ=;QzupsnEl5cH2mG1sih8VIECn8gc
 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
 ohWQP9UXeLFT3XxxU=

Microsoft has designed a set of extensions for the ACPI fan device
allowing the OS to specify a set of fan speed trip points. The
platform firmware will then notify the ACPI fan device when one
of the trip points is triggered.

Unfortunatly, some device manufacturers (like HP) blindly assume
that the OS will use said extensions and thus only update the values
returned by the _FST control method when receiving such a
notification. As a result the ACPI fan driver is currently unusable
on such machines, always reporting a constant value.

Fix this by adding support for the Microsoft extensions. During probe
and when resuming from suspend the driver will attempt to trigger an
initial notification that will update the values returned by _FST.
Said trip points will be updated each time a notification is received
from the platform firmware to ensure that the values returned by
the _FST control method are updated.

Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-exp=
eriences/design-guide
Closes: https://github.com/lm-sensors/lm-sensors/issues/506
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h      |   2 +
 drivers/acpi/fan_core.c | 173 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 173 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index dcc1ad3118ff..f85f9a0fbfcd 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -56,6 +56,8 @@ struct acpi_fan {
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
+	/* A value of 0 means that trippoint-related functions are not supported=
 */
+	u32 fan_trip_granularity;
 #if IS_REACHABLE(CONFIG_HWMON)
 	struct device *hdev;
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 7be22c52670c..1ec213afcdfd 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -7,11 +7,16 @@
  *  Copyright (C) 2022 Intel Corporation. All rights reserved.
  */
=20
+#include <linux/bits.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/uuid.h>
 #include <linux/thermal.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
@@ -21,6 +26,24 @@
=20
 #define ACPI_FAN_NOTIFY_STATE_CHANGED	0x80
=20
+/*
+ * Defined inside the "Fan Noise Signal" section at
+ * https://learn.microsoft.com/en-us/windows-hardware/design/device-exper=
iences/design-guide.
+ */
+static const guid_t acpi_fan_microsoft_guid =3D GUID_INIT(0xA7611840, 0x9=
9FE, 0x41AE, 0xA4, 0x88,
+							0x35, 0xC7, 0x59, 0x26, 0xC8, 0xEB);
+#define ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY 1
+#define ACPI_FAN_DSM_SET_TRIP_POINTS		2
+#define ACPI_FAN_DSM_GET_OPERATING_RANGES	3
+
+/*
+ * Ensures that fans with a very low trip point granularity
+ * do not send too many notifications.
+ */
+static uint min_trip_distance =3D 100;
+module_param(min_trip_distance, uint, 0);
+MODULE_PARM_DESC(min_trip_distance, "Minimum distance between fan speed t=
rip points in RPM");
+
 static const struct acpi_device_id fan_device_ids[] =3D {
 	ACPI_FAN_DEVICE_IDS,
 	{"", 0},
@@ -310,6 +333,131 @@ static int acpi_fan_get_fps(struct acpi_device *devi=
ce)
 	return status;
 }
=20
+static int acpi_fan_dsm_init(struct device *dev)
+{
+	union acpi_object dummy =3D {
+		.package =3D {
+			.type =3D ACPI_TYPE_PACKAGE,
+			.count =3D 0,
+			.elements =3D NULL,
+		},
+	};
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	union acpi_object *obj;
+	int ret =3D 0;
+
+	if (!acpi_check_dsm(fan->handle, &acpi_fan_microsoft_guid, 0,
+			    BIT(ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY) |
+			    BIT(ACPI_FAN_DSM_SET_TRIP_POINTS)))
+		return 0;
+
+	dev_info(dev, "Using Microsoft fan extensions\n");
+
+	obj =3D acpi_evaluate_dsm_typed(fan->handle, &acpi_fan_microsoft_guid, 0=
,
+				      ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY, &dummy,
+				      ACPI_TYPE_INTEGER);
+	if (!obj)
+		return -EIO;
+
+	if (obj->integer.value > U32_MAX)
+		ret =3D -EOVERFLOW;
+	else
+		fan->fan_trip_granularity =3D obj->integer.value;
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int acpi_fan_dsm_set_trip_points(struct device *dev, u64 upper, u6=
4 lower)
+{
+	union acpi_object args[2] =3D {
+		{
+			.integer =3D {
+				.type =3D ACPI_TYPE_INTEGER,
+				.value =3D lower,
+			},
+		},
+		{
+			.integer =3D {
+				.type =3D ACPI_TYPE_INTEGER,
+				.value =3D upper,
+			},
+		},
+	};
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	union acpi_object in =3D {
+		.package =3D {
+			.type =3D ACPI_TYPE_PACKAGE,
+			.count =3D ARRAY_SIZE(args),
+			.elements =3D args,
+		},
+	};
+	union acpi_object *obj;
+
+	obj =3D acpi_evaluate_dsm(fan->handle, &acpi_fan_microsoft_guid, 0,
+				ACPI_FAN_DSM_SET_TRIP_POINTS, &in);
+	kfree(obj);
+
+	return 0;
+}
+
+static int acpi_fan_dsm_start(struct device *dev)
+{
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	int ret;
+
+	if (!fan->fan_trip_granularity)
+		return 0;
+
+	/*
+	 * Some firmware implementations only update the values returned by the
+	 * _FST control method when a notification is received. This usually wor=
ks
+	 * with Microsoft Windows as setting up trip points will keep triggering
+	 * said notifications, but will cause issues when using _FST without the
+	 * Microsoft-specific trip point extension.
+	 *
+	 * Because of this we have to ensure that an initial notification is tri=
ggered
+	 * to start the cycle of trip points updates. We achive this by setting =
the trip
+	 * points sequencially to two separate ranges. As by the Microsoft speci=
fication
+	 * the firmware should trigger a notification immediately if the fan spe=
ed is outside
+	 * of the trip point range. This _should_ result in at least one notific=
ation as both
+	 * ranges do not overlap, meaning that the current fan speed needs to be=
 outside of
+	 * at least one range.
+	 */
+	ret =3D acpi_fan_dsm_set_trip_points(dev, fan->fan_trip_granularity, 0);
+	if (ret < 0)
+		return ret;
+
+	return acpi_fan_dsm_set_trip_points(dev, fan->fan_trip_granularity * 3,
+					    fan->fan_trip_granularity * 2);
+}
+
+static int acpi_fan_dsm_update_trips_points(struct device *dev, struct ac=
pi_fan_fst *fst)
+{
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	u64 upper, lower;
+
+	if (!fan->fan_trip_granularity)
+		return 0;
+
+	if (!acpi_fan_speed_valid(fst->speed))
+		return -EINVAL;
+
+	upper =3D roundup_u64(fst->speed + min_trip_distance, fan->fan_trip_gran=
ularity);
+	if (fst->speed <=3D min_trip_distance) {
+		lower =3D 0;
+	} else {
+		/*
+		 * Valid fan speed values cannot be larger than 32 bit, so
+		 * we can safely assume that no overflow will happen here.
+		 */
+		lower =3D rounddown((u32)fst->speed - min_trip_distance, fan->fan_trip_=
granularity);
+	}
+
+	return acpi_fan_dsm_set_trip_points(dev, upper, lower);
+}
+
 static void acpi_fan_notify_handler(acpi_handle handle, u32 event, void *=
context)
 {
 	struct device *dev =3D context;
@@ -323,8 +471,13 @@ static void acpi_fan_notify_handler(acpi_handle handl=
e, u32 event, void *context
 		 * receive an ACPI event indicating that the fan state has changed.
 		 */
 		ret =3D acpi_fan_get_fst(handle, &fst);
-		if (ret < 0)
+		if (ret < 0) {
 			dev_err(dev, "Error retrieving current fan status: %d\n", ret);
+		} else {
+			ret =3D acpi_fan_dsm_update_trips_points(dev, &fst);
+			if (ret < 0)
+				dev_err(dev, "Failed to update trip points: %d\n", ret);
+		}
=20
 		acpi_fan_notify_hwmon(dev);
 		acpi_bus_generate_netlink_event("fan", dev_name(dev), event, 0);
@@ -394,6 +547,10 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 	}
=20
 	if (fan->has_fst) {
+		result =3D acpi_fan_dsm_init(&pdev->dev);
+		if (result)
+			return result;
+
 		result =3D devm_acpi_fan_create_hwmon(&pdev->dev);
 		if (result)
 			return result;
@@ -402,6 +559,12 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
 		if (result)
 			return result;
=20
+		result =3D acpi_fan_dsm_start(&pdev->dev);
+		if (result) {
+			dev_err(&pdev->dev, "Failed to start Microsoft fan extensions\n");
+			return result;
+		}
+
 		result =3D acpi_fan_create_attributes(device);
 		if (result)
 			return result;
@@ -487,8 +650,14 @@ static int acpi_fan_suspend(struct device *dev)
=20
 static int acpi_fan_resume(struct device *dev)
 {
-	int result;
 	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+	int result;
+
+	if (fan->has_fst) {
+		result =3D acpi_fan_dsm_start(dev);
+		if (result)
+			dev_err(dev, "Failed to start Microsoft fan extensions: %d\n", result)=
;
+	}
=20
 	if (fan->acpi4)
 		return 0;
=2D-=20
2.39.5


