Return-Path: <linux-acpi+bounces-17654-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E51BC2FA1
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 01:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B20B4F3720
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 23:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0454C263F44;
	Tue,  7 Oct 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="s8nEu0TS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2525F98A;
	Tue,  7 Oct 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880532; cv=none; b=WkCs2AdPSrcGrnnu1oPDUX40wD871jcMFRTAH8IKTJMvPoKbqMFaO366iRuQ1+uRrmrnHW2HrJHHaTvdIKQ90k0sEQYOsB/8nn1+6MzJPMdywSdTGh4xBmbNi3Z7x6Z1P8Ct7MKJ4vXgNsf1zZrxU3D3SN4qSaze2Orp+telvAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880532; c=relaxed/simple;
	bh=1gewzFUeozQRrp9by7G5vfkOX4mluF03Eza2u5ZlQGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsPhcCh1+FLO0FxQDDnGRyEaO5pKRgTR+ZS9fqmrxmSGZr1toAv/bi/rMJtaBfk4Lre7XJVdef5BNiwE55A9xF4vHvUKAHTnYZwmusmLx3lLvo7OV+/SJDmKjcgyTOhSZLPkp6zAPuImfLUtjuGtBrZowDFdWjvazEV1T08dpew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=s8nEu0TS; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759880528; x=1760485328; i=w_armin@gmx.de;
	bh=S4K9stc6lMr6tgMnCdQOnOEui0CIPld+7r+U6B5DDKc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s8nEu0TSRQmJK95piBK1sp6uGtjq1EcmBmaIXljhR9+YmNwhZIXqNgBZrmgTaplN
	 KHaKai4b2R5gq/aBL7NfA67p4/aqrm0bfbpsXEOsDPkr2tjnf8pYdWxSN5je8XG4o
	 8jmDPqr5WWLjZUzi2d9xRD0ITeHvwGd8bUguE5+/Dz+S7znkWRQrowYJ0qwYPSqvQ
	 h7DkS7GyMT+MgqO0sd0eNnBRB30E43yKQTc23SiAvufl2gqLtH9a0MKTQ4ZKLLdaN
	 m7Pxwh2sCQ0BjWpPCFUWKdQ0uxvTpVCJ7a2MLtNGo5ueVkLaQtwuSfM/NKI7DKshb
	 htrd2Uyq/4VildojMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N7QxL-1uBpBl1Mi5-012u8G; Wed, 08 Oct 2025 01:42:08 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ACPI: fan: Add support for Microsoft fan extensions
Date: Wed,  8 Oct 2025 01:41:49 +0200
Message-Id: <20251007234149.2769-7-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:rZ3nuObzQogc3HGq50lw3jpGqknp51OCxMaXV1WFQx/PgYv3y/8
 TDMxoOXfrUr7k7v2d2RIXzNM9l08vQ3SU26sAbXBrQ5JSYEwZGdeQvDg2pkUyG7ap5Dkopl
 eacr2EL1zhnVvZoddyNuI//dkBf/vjJWAhX9lwVrniP71Wj0SL8ynXBToOo+T1KKLreIxS3
 4oQiBoZ5qQ5qCbUiRPpaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g25Ag4wUxjA=;neuTPSj7pbWFVJYHnvCyfZ2iTho
 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
 HKNmU+qz1ETgPwHEc=

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

Closes: https://github.com/lm-sensors/lm-sensors/issues/506
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h      |   2 +
 drivers/acpi/fan_core.c | 169 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 169 insertions(+), 2 deletions(-)

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
index 7be22c52670c..cfef767d3459 100644
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
@@ -21,6 +26,20 @@
=20
 #define ACPI_FAN_NOTIFY_STATE_CHANGED	0x80
=20
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
@@ -310,6 +329,131 @@ static int acpi_fan_get_fps(struct acpi_device *devi=
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
@@ -323,8 +467,13 @@ static void acpi_fan_notify_handler(acpi_handle handl=
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
@@ -394,6 +543,10 @@ static int acpi_fan_probe(struct platform_device *pde=
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
@@ -402,6 +555,12 @@ static int acpi_fan_probe(struct platform_device *pde=
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
@@ -487,8 +646,14 @@ static int acpi_fan_suspend(struct device *dev)
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


