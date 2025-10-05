Return-Path: <linux-acpi+bounces-17592-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACEBBCD5D
	for <lists+linux-acpi@lfdr.de>; Mon, 06 Oct 2025 00:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864F84E72A0
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Oct 2025 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DC0241CB6;
	Sun,  5 Oct 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ParNpCRo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7763FC7;
	Sun,  5 Oct 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759703130; cv=none; b=Wo7M0eMUJMm/m0Pfzjx8F1fbrtBndRJY6u5bsxxIUretaI350UxFnDMIQIEKtwCuuKVW/AawtN3/nAv14Tn+v1m4S6i+JEBA8jIXJ62UMe3Cz0IDexfhP1hvXm1yB9fPxAERvhDY2GjPRf0SH3z9c8L6sYI8MEpkk4uuAycrh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759703130; c=relaxed/simple;
	bh=0cjm2D15ABjPHSqREC4lOS7Gk+i7BOiRrm/etjbkjww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtQ0m7hjYrseVtR2Ts//6HMhFzEjumNppXmHCx7CLfphSNTNkCkF4N4WhJrVMF4agJyTOb2WyYl+FUGUOuPjhcNGeJ+gvJDAHrZ9uV5TVOvLYaEnDPNUQiFZsFEb7JxYPezydYa3619AdP8TEJ/JJwFI8xyabAI28KkSsJz9BG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ParNpCRo; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759703125; x=1760307925; i=w_armin@gmx.de;
	bh=G+EoSDUBugpUpUDI6rHVmIJFcQ1Dy/gJilxyTsnZntE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ParNpCRoEPqRKCY3+6gNsfD1EryWEqkmEr13V5RdlPit27qBpnOP+xjX+mDMGJf9
	 UmkjzFJ1Hq2/ITCQKHjxh/BQIlF3/Xm+HJ+rdvykr6iiqJHRNnLzbP8sfGTFZPFVH
	 sZoj/XkC0fc+05ThSUVKXnlxV2gHl1Iic0IT1ilQzuN2ONDQtMXHQz2hRQRItoBpe
	 Gw0M5L8YMG6f1WO59qka55+UeWDBltz+DE7hMheiNGEryyD3tlEcz1G4MaWfNCGpI
	 G2xG6vK0cwktOX0sh5UHxEJ75WqEGXTEH5uozzf1rsalgb01FDIscuPG/OkBGtNZm
	 l+p4cVwps8sNnQx0Ow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MSKy8-1uhEzt1nqK-00TFgr; Mon, 06 Oct 2025 00:25:25 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ACPI: fan: Use ACPI handle when retrieving _FST
Date: Mon,  6 Oct 2025 00:25:08 +0200
Message-Id: <20251005222513.7794-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:VLxRBd3HEpcr6TmoteKkuQsxzD6g3holmfouh36g2BpRZ1v4LXI
 7R1lIDqqbJOw2tVyZNtIpRA227wikPsoswmUnJieoK4yiGsG2Hrw2Sry0RbkRmnZAh7GDcc
 9/wy1BK5r9tTENBd+wBg+7nfLzWkjr7uQIV+ovFOTH/cV0fkLvew6nF9kq7WGyuaxz8YOMZ
 WmydQGU5Mdi6+HDqlvU3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P9sTpqmz6Xg=;vA+Zdfmdhfc9ZdKGj6pD3sEv8Q3
 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

Usage of the ACPI device should be phased out in the future, as
the driver itself is now using the platform bus. Replace any usage
of struct acpi_device in acpi_fan_get_fst() to allow users to drop
usage of struct acpi_device.

Also extend the integer check to all three package elements.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h       |  3 ++-
 drivers/acpi/fan_attr.c  |  2 +-
 drivers/acpi/fan_core.c  | 34 ++++++++++++++++++++++------------
 drivers/acpi/fan_hwmon.c |  3 +--
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 8a28a72a7c6a..d39bb6fd1326 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -49,6 +49,7 @@ struct acpi_fan_fst {
 };
=20
 struct acpi_fan {
+	acpi_handle handle;
 	bool acpi4;
 	bool has_fst;
 	struct acpi_fan_fif fif;
@@ -59,7 +60,7 @@ struct acpi_fan {
 	struct device_attribute fine_grain_control;
 };
=20
-int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst=
);
+int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst);
 int acpi_fan_create_attributes(struct acpi_device *device);
 void acpi_fan_delete_attributes(struct acpi_device *device);
=20
diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
index c1afb7b5ed3d..9b7fa52f3c2a 100644
=2D-- a/drivers/acpi/fan_attr.c
+++ b/drivers/acpi/fan_attr.c
@@ -55,7 +55,7 @@ static ssize_t show_fan_speed(struct device *dev, struct=
 device_attribute *attr,
 	struct acpi_fan_fst fst;
 	int status;
=20
-	status =3D acpi_fan_get_fst(acpi_dev, &fst);
+	status =3D acpi_fan_get_fst(acpi_dev->handle, &fst);
 	if (status)
 		return status;
=20
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 04ff608f2ff0..ea2c646c470c 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -44,25 +44,30 @@ static int fan_get_max_state(struct thermal_cooling_de=
vice *cdev, unsigned long
 	return 0;
 }
=20
-int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fst=
)
+int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst)
 {
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	acpi_status status;
 	int ret =3D 0;
=20
-	status =3D acpi_evaluate_object(device->handle, "_FST", NULL, &buffer);
-	if (ACPI_FAILURE(status)) {
-		dev_err(&device->dev, "Get fan state failed\n");
-		return -ENODEV;
-	}
+	status =3D acpi_evaluate_object(handle, "_FST", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -EIO;
=20
 	obj =3D buffer.pointer;
-	if (!obj || obj->type !=3D ACPI_TYPE_PACKAGE ||
-	    obj->package.count !=3D 3 ||
-	    obj->package.elements[1].type !=3D ACPI_TYPE_INTEGER) {
-		dev_err(&device->dev, "Invalid _FST data\n");
-		ret =3D -EINVAL;
+	if (!obj)
+		return -ENODATA;
+
+	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3) {
+		ret =3D -EPROTO;
+		goto err;
+	}
+
+	if (obj->package.elements[0].type !=3D ACPI_TYPE_INTEGER ||
+	    obj->package.elements[1].type !=3D ACPI_TYPE_INTEGER ||
+	    obj->package.elements[2].type !=3D ACPI_TYPE_INTEGER) {
+		ret =3D -EPROTO;
 		goto err;
 	}
=20
@@ -81,7 +86,7 @@ static int fan_get_state_acpi4(struct acpi_device *devic=
e, unsigned long *state)
 	struct acpi_fan_fst fst;
 	int status, i;
=20
-	status =3D acpi_fan_get_fst(device, &fst);
+	status =3D acpi_fan_get_fst(device->handle, &fst);
 	if (status)
 		return status;
=20
@@ -311,11 +316,16 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
 	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
 	char *name;
=20
+	if (!device)
+		return -ENODEV;
+
 	fan =3D devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
 	if (!fan) {
 		dev_err(&device->dev, "No memory for fan\n");
 		return -ENOMEM;
 	}
+
+	fan->handle =3D device->handle;
 	device->driver_data =3D fan;
 	platform_set_drvdata(pdev, fan);
=20
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index e8d90605106e..4209a9923efc 100644
=2D-- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -93,13 +93,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *d=
rvdata, enum hwmon_sensor_
 static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type, u32 attr,
 			       int channel, long *val)
 {
-	struct acpi_device *adev =3D to_acpi_device(dev->parent);
 	struct acpi_fan *fan =3D dev_get_drvdata(dev);
 	struct acpi_fan_fps *fps;
 	struct acpi_fan_fst fst;
 	int ret;
=20
-	ret =3D acpi_fan_get_fst(adev, &fst);
+	ret =3D acpi_fan_get_fst(fan->handle, &fst);
 	if (ret < 0)
 		return ret;
=20
=2D-=20
2.39.5


