Return-Path: <linux-acpi+bounces-8032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5914C96744C
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 05:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6941F21F92
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C671539AF4;
	Sun,  1 Sep 2024 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lejYik+A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC312BD05;
	Sun,  1 Sep 2024 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160314; cv=none; b=CJ6fZY3A3s5Dj8ij+u6+MvgjSuMd1xuanKwNg2onCWDxYkZnF2bfpGIVy8s4SthpYmeqcaGOdj0e0cGJlzsN5V2nLpTGceR8ARMmZvjN7qfZVYxGmU88mT2jVBQHukhOCD9hhuUT6KBsS+gaZ3NexFuOf+xFIc3e6ajAM+LkyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160314; c=relaxed/simple;
	bh=rv9OBi71fbe/a7CPMJebya9FJGV4VBsECfVRwAuuxh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfXjPA7/tXSKfHB2luiXY1b1T62JvEfmXmT2Jm8HMzgSRr/C7DQ7SS2DantpI34e6CSTScNDaQsURs/2wNrVxMlefrIXUNTGIYItV3uUGb/kar62B4cQkqP3Jf7GgE/iVJeXTavhT+1QF4SFAZu8rIKCGI2d563+n9n4+dEgrzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lejYik+A; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725160280; x=1725765080; i=w_armin@gmx.de;
	bh=fZnSJulc4dtFhoUS7lxxs7JDhRJ31cX6J//rA3Enl/U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lejYik+AgeK+kgtco06N4Mcckye53c3oeqeY1v+Xzt+wN+S+02iovzbUY3WjKnlG
	 hpzYZaLTw8+18owjUM7hbHNtr/KoByLj/EogoCJh4dr7ZzNoJPhF5JjvWRtVG3Cay
	 GSy0SjJawXu7md0vCMDJDjaS2S25m8QxIsyvmfl0N9AIEl4NsJ6ahJKRnLTUi4VPc
	 2m194K3mYqDqpOWPUc76XFGhNENq3cV3eOrNA/T/i5tMiy3LlQ9/ulOoVe5sFxVMS
	 PapoaefD42bx7eF0Zi7Zr5zRfTbU0dT9ld7Rz5drQQjnBukIFsjO9HalJ/AKbw5W7
	 /K9+7k6ODv17K7ukgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIdiZ-1spqCD1BXJ-00E2Vu; Sun, 01 Sep 2024 05:11:20 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux@roeck-us.net,
	jdelvare@suse.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] platform/x86: wmi: Pass event data directly to legacy notify handlers
Date: Sun,  1 Sep 2024 05:10:52 +0200
Message-Id: <20240901031055.3030-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901031055.3030-1-W_Armin@gmx.de>
References: <20240901031055.3030-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gwEXzSHF8k3I9oI9LgInWMWthgZ8VvIoF+VpgBxno+d48uo8SRW
 3YnbUuJ87ceJYMV7IlJ7e+bp2ZC0n1N9FegUd1pyJhlnjC4aliVGvQP7kC9+KFnjJE+M0iY
 1stPsGV66D0dnyoD1ymQ2J+oaE++gclJBlwrTeUbhaBkNyKOfNsmHcX2WdmILzmDJbZgAHZ
 4AQkizRoQGdAHdMqPC1Qw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PhfRo9c8K6Y=;z0xzp5bNCdyrhLSUYmoUr09Vv9p
 O5xfcFuVTT+5KHgBx6JKRrmIeuckAB7OtsRx7gUxyRpKsZGPGr0dEJWfA2t1y+ca2MAUoyki1
 ntUkWyp4brNBEDYeKjnBxYEoYkunk11AejqLuXNepYPtseJDdR5hI17h3NgpmgUD9gxMnUMXb
 elOsyKh/2jGrvHIwsr03umHz0RXAYzBT/LUzSqn+JOKRpxPfXxpiC4ApsFQH4nJO5No+hRPsT
 DrQ6LbqDgwhqgOO588yXjI9TYp2wS4KRw1SAsP0Z5OBRyMLyE+0sitfD6ELKKpqRmWAirjhuG
 8aqs2kGB601LNKh3e5zCqZftaKI9ElBUXX9z8DmP3p58SjpqtPgNpfCRhTSl6aPJgI16RgL9z
 TPVS00jchI+gqP4R8zzX6tFUhb09VHhrELtij9fAvBnQkA9ueY7qFZlbFL9pFTAvAb3RMym1u
 ZgFA8tPtOgTsI/pcZmBc2SDXto0d1UL7xSKYN8LIy9XkHvtLpRlqJm0KEZBebYLdoXIEjnbok
 PwY/flLdYFY7uI4TzCROgVlj7wcPGmNjvV1SY9ekQPnmeFgDQPp03sd0fMTNAwHG+9nOl3YWT
 NLbTj8/ZlZfGesE1NwIe/+5zAs5NjQa1auaQ96OK6RHcxMVF6z3JYSV6Uwd5W7v0zMI3jMaZM
 WRNiRBE691JY97LNt6g9ZbuJvymJZ0tsh5pg1KTRhBhRq4g23nJ2IQ3GGoVFug5Inl7yA2+h6
 Q23vXzYczo/o2p61Nym9cLniqrnwIkDHfBxoafv+61s7wEQq5lePHi+J8xOHEnTdVmjmuCOj9
 1uI2ye4ZtuWSW2oOHL8VQR8A==

The current legacy WMI handlers are susceptible to picking up wrong
WMI event data on systems where different WMI devices share some
notification IDs.

Prevent this by letting the WMI driver core taking care of retrieving
the event data. This also simplifies the legacy WMI handlers and their
implementation inside the WMI driver core.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/hp-wmi-sensors.c           | 22 ++++--------
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
 11 files changed, 37 insertions(+), 156 deletions(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors=
.c
index dfa1d6926dea..d6bdad26feb1 100644
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
@@ -1630,20 +1628,15 @@ static void hp_wmi_notify(u32 value, void *context=
)
 	 * HPBIOS_BIOSEvent instance.
 	 */

-	mutex_lock(&state->lock);
-
-	err =3D wmi_get_event_data(value, &out);
-	if (ACPI_FAILURE(err))
-		goto out_unlock;
-
-	wobj =3D out.pointer;
 	if (!wobj)
-		goto out_unlock;
+		return;
+
+	mutex_lock(&state->lock);

 	err =3D populate_event_from_wobj(dev, &event, wobj);
 	if (err) {
 		dev_warn(dev, "Bad event data (ACPI type %d)\n", wobj->type);
-		goto out_free_wobj;
+		goto out_free;
 	}

 	event_type =3D classify_event(event.name, event.category);
@@ -1668,13 +1661,10 @@ static void hp_wmi_notify(u32 value, void *context=
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
index 55d31d4fefd6..4b57102c7f62 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -205,21 +205,11 @@ static union acpi_object *lg_wmbb(struct device *dev=
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

@@ -241,7 +231,6 @@ static void wmi_notify(u32 value, void *context)

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


