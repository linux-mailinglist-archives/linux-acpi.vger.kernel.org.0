Return-Path: <linux-acpi+bounces-7787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DCD95BD74
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 19:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21E21C21B1F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 17:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706D1CFEAF;
	Thu, 22 Aug 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="P2TzdK5h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818D1CF29F;
	Thu, 22 Aug 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348342; cv=none; b=J+DOVXD2Q5buPIvhqJgrd3X334GesLI5OenfTAqs+MrJii4ew4DJBVBulwVUDHeugyOArsKQWGyXTjH75DRHHi3NpcBfawmPD7bPaToXqeoGzDnDeAnYK8FE5SjCrt1cr6IrKWkY3kZulwZ3ge6u1ujf/odU85ioWyBkBGDCtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348342; c=relaxed/simple;
	bh=BbYO8qSnw2y/jBOvKNubFq7zoOkUJfc3ZcDANXSuRTU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jM9wICN2/UUyunj1wFz9+rMNBNBluiCAMmLEt8HaMz/Wg4VqXVydqTp/GHrpQiAgrsZscdI241HD+FPNhDNDAyGhfUiSpMFXLEyDJq3VinJIoG1W/fXYrO0rCHepjn4Afj/+sYCw1eL3Mbfp3VDwpS+4OWMyMHmFnp2RjPb0cwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=P2TzdK5h; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724348321; x=1724953121; i=w_armin@gmx.de;
	bh=kR7/6t3ny+HiH2HuN3BHgXTTTLW/wXcXOTfLz658PAE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P2TzdK5h5o7GPaX64So63DspSNYD6s8LGmtpT1HSNHsN6BUeFRzeiZtIysA7JClE
	 KKORJTODev0kX5uIl8BT9hMnlxSg2t3KV2SiPm7OCOF9JK+rKJdbfBxuLBYxV0cdn
	 K348rKW4ynb0GEcNed9O7N2aHC9lYNr0OeaDLN/Z+4v+RX0IfjZpcEBaEqwO1grHY
	 s7/zuViRLUnPg1e7OHgIjervcrLB1SdVP+9/rY0T15+fT9NEOsG3ghQFlw5o//mcH
	 F9ZRIvU/co1g8t20fdLIsaaxKhX8QNkHRgT2zuruaExoyQqn9Y+E+tOhQjmwqGEwk
	 xbMeCOTB1oKMz4oqYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MWRRZ-1se37S2eex-00RPrh; Thu, 22 Aug 2024 19:38:41 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] platform/x86: wmi: Pass event data directly to legacy notify handlers
Date: Thu, 22 Aug 2024 19:38:06 +0200
Message-Id: <20240822173810.11090-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822173810.11090-1-W_Armin@gmx.de>
References: <20240822173810.11090-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lX7/mYJwmEl9dVzp8qxpourSGK2xDBCjx49zuandty1zvX7vaI4
 LHbmCh0YMA/Vj2ciEV8qimzRMTclam5X2z1zi9qvkR3Pp+ClfJr/rEdfKJpGGMeufv4opu0
 JkBTzMjraixG311InFqe1hchSuyJFy4SGz/aVpekQ3tG/80OM0EN/Ejt7F9e63Zv3meRLtq
 4hF+DAzR63+lrfleC36HQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XrY7WgEjQbw=;IhMr11kHb4V1WfqLlw2PJST7Qi1
 jsZ5j7rnVwMj9b9s7rZop2oPIL4Yx/9WbhYljOwQtM6sUjOsOCdavnfqTBR//qLUVXAcDhq8n
 GM/snexcVWi4t3gOfqZ7h3ZuAAMmIoGP0bzcjX1BCpt9s1FAP2PvZrWnrfxCY/XbXiYST2HVf
 lZTgZkYkpQtjIlETFG5tB6xW4//+9rVahZQVRmHx460Q8bIXfOrQ4NycRIVffsheleKNBZql4
 WiITke10MChDrlb0Rr5yV+GyGlEFMZqFEEom9x/QE1JGPfsEjvjhNAm5Ixsg5fJAUUOC9ao4/
 VYXvWJeRddw7rHJdBd6z33OZ2LjjDxiJQnIJIAP1Y24YYCnpzVYvVPmM50Nd3uYVcxB67zd5c
 xdE7HxdftdOYJDRN5PjGd+XdlL75tbLZ0gkoWJLx4T5ZPK4Cqb/Si70KkKV5B8ZWuYS8fO/lo
 0guoDXpM00bE7nEc9RGIvgZFM3zz8OlYnV7zTs6KrY7aIQWYOJpWYifZPr0zaJDB+xeNhPwBh
 nfuYBKk7pRpiNwCxaM7KzKedqdkGEfsLhMnugBcN+XRRO5UD2/7eXYCrWVRro8sH3AWJqKc5f
 9WIqc8cG87xz0/efE3lJ1wMeNu0IXGP/sVKBiOAcBi2rbbIDRzcHFuxvRwuOaDpi2c97I4Hmh
 e4JfWIQ8PP6sIj9kHO/ERudljYoZZxMDGfc6hmR11rH/657ifjbQiMdteymeYbTxzEyuJJKe7
 MTOkhaAsVtzxCfJOt4+67zgGPuo4Tx8dv5hqC80uzBmg0+17I4uB5m2UfLdlsIJn/AOp9nnqy
 I2nGjxxbIM711ua15elxPT7BuieZuOT24bfzQAy9GYWFg=

The current legacy WMI handlers are susceptible to picking up wrong
WMI event data on systems where different WMI devices share some
notification IDs.

Prevent this by letting the WMI driver core taking care of retrieving
the event data. This also simplifies the legacy WMI handlers and their
implementation inside the WMI driver core.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/hp-wmi-sensors.c           | 17 ++--------
 drivers/platform/x86/acer-wmi.c          | 16 +--------
 drivers/platform/x86/asus-wmi.c          | 19 ++---------
 drivers/platform/x86/dell/dell-wmi-aio.c | 13 +------
 drivers/platform/x86/hp/hp-wmi.c         | 16 +--------
 drivers/platform/x86/huawei-wmi.c        | 14 +-------
 drivers/platform/x86/lg-laptop.c         | 13 +------
 drivers/platform/x86/msi-wmi.c           | 20 ++---------
 drivers/platform/x86/toshiba-wmi.c       | 15 +--------
 drivers/platform/x86/wmi.c               | 43 ++++++++++--------------
 include/linux/acpi.h                     |  2 +-
 11 files changed, 34 insertions(+), 154 deletions(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors=
.c
index b5325d0e72b9..6892518d537c 100644
=2D-- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1597,15 +1597,13 @@ static void hp_wmi_devm_notify_remove(void *ignore=
d)
 }

 /* hp_wmi_notify - WMI event notification handler */
-static void hp_wmi_notify(u32 value, void *context)
+static void hp_wmi_notify(union acpi_object *wobj, void *context)
 {
 	struct hp_wmi_info *temp_info[HP_WMI_MAX_INSTANCES] =3D {};
-	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	struct hp_wmi_sensors *state =3D context;
 	struct device *dev =3D &state->wdev->dev;
 	struct hp_wmi_event event =3D {};
 	struct hp_wmi_info *fan_info;
-	union acpi_object *wobj;
 	acpi_status err;
 	int event_type;
 	u8 count;
@@ -1632,16 +1630,10 @@ static void hp_wmi_notify(u32 value, void *context=
)

 	mutex_lock(&state->lock);

-	err =3D wmi_get_event_data(value, &out);
-	if (ACPI_FAILURE(err))
-		goto out_unlock;
-
-	wobj =3D out.pointer;
-
 	err =3D populate_event_from_wobj(dev, &event, wobj);
 	if (err) {
 		dev_warn(dev, "Bad event data (ACPI type %d)\n", wobj->type);
-		goto out_free_wobj;
+		goto out_free;
 	}

 	event_type =3D classify_event(event.name, event.category);
@@ -1666,13 +1658,10 @@ static void hp_wmi_notify(u32 value, void *context=
)
 		break;
 	}

-out_free_wobj:
-	kfree(wobj);
-
+out_free:
 	devm_kfree(dev, event.name);
 	devm_kfree(dev, event.description);

-out_unlock:
 	mutex_unlock(&state->lock);
 }

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 349169d050c5..7169b84ccdb6 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -2223,39 +2223,25 @@ static void acer_rfkill_exit(void)
 	}
 }

-static void acer_wmi_notify(u32 value, void *context)
+static void acer_wmi_notify(union acpi_object *obj, void *context)
 {
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
 	struct event_return_value return_value;
-	acpi_status status;
 	u16 device_state;
 	const struct key_entry *key;
 	u32 scancode;

-	status =3D wmi_get_event_data(value, &response);
-	if (status !=3D AE_OK) {
-		pr_warn("bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;
-
 	if (!obj)
 		return;
 	if (obj->type !=3D ACPI_TYPE_BUFFER) {
 		pr_warn("Unknown response received %d\n", obj->type);
-		kfree(obj);
 		return;
 	}
 	if (obj->buffer.length !=3D 8) {
 		pr_warn("Unknown buffer length %d\n", obj->buffer.length);
-		kfree(obj);
 		return;
 	}

 	return_value =3D *((struct event_return_value *)obj->buffer.pointer);
-	kfree(obj);

 	switch (return_value.function) {
 	case WMID_HOTKEY_EVENT:
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index 9c6b3937ac71..1eb6b39df604 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -4187,28 +4187,15 @@ static void asus_wmi_fnlock_update(struct asus_wmi=
 *asus)

 /* WMI events ***********************************************************=
******/

-static int asus_wmi_get_event_code(u32 value)
+static int asus_wmi_get_event_code(union acpi_object *obj)
 {
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	acpi_status status;
 	int code;

-	status =3D wmi_get_event_data(value, &response);
-	if (ACPI_FAILURE(status)) {
-		pr_warn("Failed to get WMI notify code: %s\n",
-				acpi_format_exception(status));
-		return -EIO;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;
-
 	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
 		code =3D (int)(obj->integer.value & WMI_EVENT_MASK);
 	else
 		code =3D -EIO;

-	kfree(obj);
 	return code;
 }

@@ -4274,10 +4261,10 @@ static void asus_wmi_handle_event_code(int code, s=
truct asus_wmi *asus)
 		pr_info("Unknown key code 0x%x\n", code);
 }

-static void asus_wmi_notify(u32 value, void *context)
+static void asus_wmi_notify(union acpi_object *obj, void *context)
 {
 	struct asus_wmi *asus =3D context;
-	int code =3D asus_wmi_get_event_code(value);
+	int code =3D asus_wmi_get_event_code(obj);

 	if (code < 0) {
 		pr_warn("Failed to get notify code: %d\n", code);
diff --git a/drivers/platform/x86/dell/dell-wmi-aio.c b/drivers/platform/x=
86/dell/dell-wmi-aio.c
index c7b7f1e403fb..54096495719b 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-aio.c
+++ b/drivers/platform/x86/dell/dell-wmi-aio.c
@@ -70,20 +70,10 @@ static bool dell_wmi_aio_event_check(u8 *buffer, int l=
ength)
 	return false;
 }

-static void dell_wmi_aio_notify(u32 value, void *context)
+static void dell_wmi_aio_notify(union acpi_object *obj, void *context)
 {
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
 	struct dell_wmi_event *event;
-	acpi_status status;

-	status =3D wmi_get_event_data(value, &response);
-	if (status !=3D AE_OK) {
-		pr_info("bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;
 	if (obj) {
 		unsigned int scancode =3D 0;

@@ -114,7 +104,6 @@ static void dell_wmi_aio_notify(u32 value, void *conte=
xt)
 			break;
 		}
 	}
-	kfree(obj);
 }

 static int __init dell_wmi_aio_input_setup(void)
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp=
-wmi.c
index 876e0a97cee1..8c05e0dd2a21 100644
=2D-- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -834,28 +834,16 @@ static struct attribute *hp_wmi_attrs[] =3D {
 };
 ATTRIBUTE_GROUPS(hp_wmi);

-static void hp_wmi_notify(u32 value, void *context)
+static void hp_wmi_notify(union acpi_object *obj, void *context)
 {
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	u32 event_id, event_data;
-	union acpi_object *obj;
-	acpi_status status;
 	u32 *location;
 	int key_code;

-	status =3D wmi_get_event_data(value, &response);
-	if (status !=3D AE_OK) {
-		pr_info("bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;
-
 	if (!obj)
 		return;
 	if (obj->type !=3D ACPI_TYPE_BUFFER) {
 		pr_info("Unknown response received %d\n", obj->type);
-		kfree(obj);
 		return;
 	}

@@ -872,10 +860,8 @@ static void hp_wmi_notify(u32 value, void *context)
 		event_data =3D *(location + 2);
 	} else {
 		pr_info("Unknown buffer length %d\n", obj->buffer.length);
-		kfree(obj);
 		return;
 	}
-	kfree(obj);

 	switch (event_id) {
 	case HPWMI_DOCK_EVENT:
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huaw=
ei-wmi.c
index 09d476dd832e..d81fd5df4a00 100644
=2D-- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -734,26 +734,14 @@ static void huawei_wmi_process_key(struct input_dev =
*idev, int code)
 	sparse_keymap_report_entry(idev, key, 1, true);
 }

-static void huawei_wmi_input_notify(u32 value, void *context)
+static void huawei_wmi_input_notify(union acpi_object *obj, void *context=
)
 {
 	struct input_dev *idev =3D (struct input_dev *)context;
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	acpi_status status;

-	status =3D wmi_get_event_data(value, &response);
-	if (ACPI_FAILURE(status)) {
-		dev_err(&idev->dev, "Unable to get event data\n");
-		return;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;
 	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
 		huawei_wmi_process_key(idev, obj->integer.value);
 	else
 		dev_err(&idev->dev, "Bad response type\n");
-
-	kfree(response.pointer);
 }

 static int huawei_wmi_input_setup(struct device *dev, const char *guid)
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index 9c7857842caf..4d57cf803473 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -182,21 +182,11 @@ static union acpi_object *lg_wmbb(struct device *dev=
, u32 method_id, u32 arg1, u
 	return (union acpi_object *)buffer.pointer;
 }

-static void wmi_notify(u32 value, void *context)
+static void wmi_notify(union acpi_object *obj, void *context)
 {
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	acpi_status status;
 	long data =3D (long)context;

 	pr_debug("event guid %li\n", data);
-	status =3D wmi_get_event_data(value, &response);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;
 	if (!obj)
 		return;

@@ -218,7 +208,6 @@ static void wmi_notify(u32 value, void *context)

 	pr_debug("Type: %i    Eventcode: 0x%llx\n", obj->type,
 		 obj->integer.value);
-	kfree(response.pointer);
 }

 static void wmi_input_setup(void)
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi=
.c
index fd318cdfe313..4a7ac85c4db4 100644
=2D-- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -170,20 +170,9 @@ static const struct backlight_ops msi_backlight_ops =
=3D {
 	.update_status	=3D bl_set_status,
 };

-static void msi_wmi_notify(u32 value, void *context)
+static void msi_wmi_notify(union acpi_object *obj, void *context)
 {
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
 	struct key_entry *key;
-	union acpi_object *obj;
-	acpi_status status;
-
-	status =3D wmi_get_event_data(value, &response);
-	if (status !=3D AE_OK) {
-		pr_info("bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;

 	if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
 		int eventcode =3D obj->integer.value;
@@ -192,7 +181,7 @@ static void msi_wmi_notify(u32 value, void *context)
 				eventcode);
 		if (!key) {
 			pr_info("Unknown key pressed - %x\n", eventcode);
-			goto msi_wmi_notify_exit;
+			return;
 		}

 		if (event_wmi->quirk_last_pressed) {
@@ -204,7 +193,7 @@ static void msi_wmi_notify(u32 value, void *context)
 				pr_debug("Suppressed key event 0x%X - "
 					 "Last press was %lld us ago\n",
 					 key->code, ktime_to_us(diff));
-				goto msi_wmi_notify_exit;
+				return;
 			}
 			last_pressed =3D cur;
 		}
@@ -221,9 +210,6 @@ static void msi_wmi_notify(u32 value, void *context)
 		}
 	} else
 		pr_info("Unknown event received\n");
-
-msi_wmi_notify_exit:
-	kfree(response.pointer);
 }

 static int __init msi_wmi_backlight_setup(void)
diff --git a/drivers/platform/x86/toshiba-wmi.c b/drivers/platform/x86/tos=
hiba-wmi.c
index 77c35529ab6f..12c46455e8dc 100644
=2D-- a/drivers/platform/x86/toshiba-wmi.c
+++ b/drivers/platform/x86/toshiba-wmi.c
@@ -32,26 +32,13 @@ static const struct key_entry toshiba_wmi_keymap[] __i=
nitconst =3D {
 	{ KE_END, 0 }
 };

-static void toshiba_wmi_notify(u32 value, void *context)
+static void toshiba_wmi_notify(union acpi_object *obj, void *context)
 {
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	acpi_status status;
-
-	status =3D wmi_get_event_data(value, &response);
-	if (ACPI_FAILURE(status)) {
-		pr_err("Bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj =3D (union acpi_object *)response.pointer;
 	if (!obj)
 		return;

 	/* TODO: Add proper checks once we have data */
 	pr_debug("Unknown event received, obj type %x\n", obj->type);
-
-	kfree(response.pointer);
 }

 static const struct dmi_system_id toshiba_wmi_dmi_table[] __initconst =3D=
 {
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 1d0b2d6040d1..6ab181dd94ab 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1227,40 +1227,33 @@ static int wmi_notify_device(struct device *dev, v=
oid *data)
 	if (!(wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *event))
 		return 0;

+	/* The ACPI WMI specification says that _WED should be
+	 * evaluated every time an notification is received, even
+	 * if no consumers are present.
+	 *
+	 * Some firmware implementations actually depend on this
+	 * by using a queue for events which will fill up if the
+	 * WMI driver core stops evaluating _WED due to missing
+	 * WMI event consumers.
+	 */
+	ret =3D wmi_get_notify_data(wblock, &obj);
+	if (ret < 0)
+		return -EIO;
+
 	down_read(&wblock->notify_lock);
 	/* The WMI driver notify handler conflicts with the legacy WMI handler.
 	 * Because of this the WMI driver notify handler takes precedence.
 	 */
 	if (wblock->dev.dev.driver && wblock->driver_ready) {
-		ret =3D wmi_get_notify_data(wblock, &obj);
-		if (ret >=3D 0) {
-			wmi_notify_driver(wblock, obj);
-			kfree(obj);
-		}
+		wmi_notify_driver(wblock, obj);
 	} else {
-		if (wblock->handler) {
-			wblock->handler(*event, wblock->handler_data);
-		} else {
-			/* The ACPI WMI specification says that _WED should be
-			 * evaluated every time an notification is received, even
-			 * if no consumers are present.
-			 *
-			 * Some firmware implementations actually depend on this
-			 * by using a queue for events which will fill up if the
-			 * WMI driver core stops evaluating _WED due to missing
-			 * WMI event consumers.
-			 *
-			 * Because of this we need this seemingly useless call to
-			 * wmi_get_notify_data() which in turn evaluates _WED.
-			 */
-			ret =3D wmi_get_notify_data(wblock, &obj);
-			if (ret >=3D 0)
-				kfree(obj);
-		}
-
+		if (wblock->handler)
+			wblock->handler(obj, wblock->handler_data);
 	}
 	up_read(&wblock->notify_lock);

+	kfree(obj);
+
 	acpi_bus_generate_netlink_event("wmi", acpi_dev_name(wblock->acpi_device=
), *event, 0);

 	return -EBUSY;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0687a442fec7..eed105b1fbfb 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -386,7 +386,7 @@ extern bool acpi_is_pnp_device(struct acpi_device *);

 #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)

-typedef void (*wmi_notify_handler) (u32 value, void *context);
+typedef void (*wmi_notify_handler) (union acpi_object *data, void *contex=
t);

 int wmi_instance_count(const char *guid);

=2D-
2.39.2


