Return-Path: <linux-acpi+bounces-17651-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0313FBC2F8F
	for <lists+linux-acpi@lfdr.de>; Wed, 08 Oct 2025 01:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0A419A2C4B
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Oct 2025 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2704425DB1D;
	Tue,  7 Oct 2025 23:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="N/q4FpjX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC7C256C89;
	Tue,  7 Oct 2025 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880530; cv=none; b=lY42iMuxO+sYIZA3LFHY4dMNrCIZIwa48xIPHHe+KoO0OnOGPUFGMlh2FqNO5SEL1nmtWctwZjKZfRjRffwcfH6CpuW2sJTJyxwyRlqwbHLXjZTDXjZdN1HFm15zdiRZ1BUBB1CsF/gmUDdqxDkq0tjNED84xzsxZXju2H1ewIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880530; c=relaxed/simple;
	bh=0cjm2D15ABjPHSqREC4lOS7Gk+i7BOiRrm/etjbkjww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5Augc/9Pwv09oVxObP+h+6yZK6BZ/g6lOLizd8JlHNx6FgynMYbS7WZa3khqBu5eyKReC9OuvBTnlsbrmH9GQzcyP0IstMvBwopjqAxcWJzUaOqKQZye0zeNRIX79VPBhzNSYX8opuTMlM6JFtVlM+qbxNNNzxg8muN4YmXOMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=N/q4FpjX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759880521; x=1760485321; i=w_armin@gmx.de;
	bh=G+EoSDUBugpUpUDI6rHVmIJFcQ1Dy/gJilxyTsnZntE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=N/q4FpjXdIw27ZR/4ntQAX23HNSYfHRV8WaSx4bdCwzPRguL6coNlKc4JbeVAxfE
	 0bRb4NFQM2XVCU7qIX2pwWbfgAlucFJT8eCCCHQgfcuDWgzhtbt9huER+jE0nwP7u
	 ho9pYo6nRRqRxm/UEJWpYevL+3y3qLWH2ofaKcZbHAuRlh401Ln9CkNfzhO8Wza3X
	 hx2AsPYEgb1/2nYm6vl2awCI55tir/HFskM5T6v1QWMygrjJeqxRCeraA3zeMB9cX
	 9KgM7MQ4XcctDOVlrS+8eJB4etd7lOInsjDcgG76pGu+tX22pR65khGjyB9moRBGc
	 +5NqNGzjz73uxMvuGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MA7GS-1v0Cmi0MJu-00FtS8; Wed, 08 Oct 2025 01:42:01 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] ACPI: fan: Use ACPI handle when retrieving _FST
Date: Wed,  8 Oct 2025 01:41:44 +0200
Message-Id: <20251007234149.2769-2-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:uet48auZKPut5Gj77sq+cHzVuVOvBmioB26cNFEav0Z9bWGFtK5
 yFpjrsTNr6tDn8Nq+NHb0VZNVxZsvEhbxfDtu5u8d8aea+2//GzBBpSomzTpGSkbFjVoYx3
 2t5pG9Z6IU+Ik7/CYokG/UMJc5KV4hsn1ArAtXgNoONfM7SY8UCi/TeNozm/ZFZxyxKNH0L
 zR8EJXXhpth9drMz1SYdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pM6NVSlF45U=;rZdF+A0Mg1yBXXEm/7MARNuXp1u
 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
 4izkQ==

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


