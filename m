Return-Path: <linux-acpi+bounces-17597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE2BBCD78
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 00:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA4D1348687
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DD92580F9;
	Sun,  5 Oct 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LaF+AJWR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D4257437;
	Sun,  5 Oct 2025 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703141; cv=none; b=VENE3FoaFrXYScR847OimdbBc+emZTMv6V4gRi+0ar8wJGSiirE6DZcEgMZoNjJt0/QTQNDubFCFBCzZ/NP+kHmInBfubyil8d+lmcmpj7WBIcmZmsvTEUoJkZOkTAEK/ZsuQLAy8IWKZgGfGS266q2gbPGbIe0bv3miJ3M4lwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703141; c=relaxed/simple;
	bh=JmGoKzre6jzusEgmQMrgmGJhIFX0IjcQpWCLECVV4Sc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ny0fRW98Bux4REIEuXl8TuxEQtZOermLdzpXqM24YhhcWkt6whpeqTme5TsOBZ1G015gWhZzw/43wD36AOsRJjl4W9ZxpZCBqq96kHBV4XnSIzeVuS2/jLTxhF2mfSkRu6dzwCC0wV+lGSEDv7pl8kvp3CxpjFXdHV8Cij6VzbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LaF+AJWR; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759703133; x=1760307933; i=w_armin@gmx.de;
	bh=fC59uYsOztFbVFpJEgpmo6LZu0JgT49QtBOmgLhNzJU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LaF+AJWRYcHlnVeQ/C+H3egbDl6Xxoovrd8X/YL/fc1OoEKVzpxUXmxcU+fMZGTq
	 2oq4kNSsfXVXVF5gGpD2QFWgrF4UP1OmqU4UypAJn1mNStL7yb1HWbV7RkZyFL/K3
	 h3MRYQIZrJ/9JYbkO3dnqAZviCwFXpO3f746kWh+SMrtdXZq+rPHdtRYL/XQ/iciA
	 DlbXsbB0rJ+1aGlUhXf0lujal2WQxjQDjwmXcf+ZtwqCUZikItca1ZHcwWdwZeXhu
	 dwhDq1t7KoSyHcBMKkayqE0icp0i2jUVlqhNdy2zJH/SZOoyJMATV3oGuDt71Ryp+
	 Qozn9/SUnnxBmwnDrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Md6R1-1uVvZO0g7f-00oswS; Mon, 06 Oct 2025 00:25:33 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ACPI: fan: Add support for Microsoft fan extensions
Date: Mon,  6 Oct 2025 00:25:13 +0200
Message-Id: <20251005222513.7794-7-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:KtLN6kxp8cpMsndId500y6L4GBS9nD5H1RxOlI5+WPiGFVeYnci
 zaf0cp1R29abzGHRVWrbiZkybihpxKtl8dt/R8lMCUDBaRmzuJPGX8r0ZjnNo6Cp/NwD3hP
 0BQL2yikapaelsTIP7k8L52+oQZ2bHfUwJIpDIfjBdGS5BstjgZOvsFcfePt+Aqnz9UjgB1
 BuR/jZPvsfzmrSmEI7BSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kmrJ7VIy5Q0=;bCw7/MwXQw+yC85nhuBU9iI0SUU
 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

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
 drivers/acpi/fan_core.c | 176 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 176 insertions(+), 2 deletions(-)

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
index 3dbd22bc3a48..ca8c291ac8cc 100644
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
@@ -310,6 +329,138 @@ static int acpi_fan_get_fps(struct acpi_device *devi=
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
+	obj =3D acpi_evaluate_dsm(fan->handle, &acpi_fan_microsoft_guid, 0,
+				ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY, &dummy);
+	if (!obj)
+		return -EIO;
+
+	if (obj->type !=3D ACPI_TYPE_INTEGER) {
+		ret =3D -EPROTO;
+		goto out_free;
+	}
+
+	if (obj->integer.value > U32_MAX) {
+		ret =3D -EOVERFLOW;
+		goto out_free;
+	}
+
+	fan->fan_trip_granularity =3D obj->integer.value;
+
+out_free:
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
@@ -323,8 +474,13 @@ static void acpi_fan_notify_handler(acpi_handle handl=
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
 		break;
@@ -393,6 +549,10 @@ static int acpi_fan_probe(struct platform_device *pde=
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
@@ -401,6 +561,12 @@ static int acpi_fan_probe(struct platform_device *pde=
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
@@ -486,8 +652,14 @@ static int acpi_fan_suspend(struct device *dev)
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


