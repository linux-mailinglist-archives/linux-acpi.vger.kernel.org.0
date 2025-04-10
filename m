Return-Path: <linux-acpi+bounces-12952-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BA6A84A84
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 18:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CE57AF8D8
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D671F0982;
	Thu, 10 Apr 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="hqUYci7p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD98204849;
	Thu, 10 Apr 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304127; cv=none; b=GV7X+ouBNkUD9WNXoeCneO14jVGFg/UTmjJSnDSvfLIPUvBN7wQyxH4qX1pHtq7DS7AUF0VxxizgWv2ghBvb4Vl7d/YX9wheAyoyg3JMNUa5UVgIUo8P/MaQSPa9Gxazuht6QeHHw1neMsh7xjngaW9Z9ylfb59aIBdrJ8JY9MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304127; c=relaxed/simple;
	bh=k5NAHRWJFGg2wPpNG8JKE3ddyudxpH7x8YRItmLNQwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSuA4xxbdM/6BItcy8YKjge5002g+/3o2XZ7GGfPnMNFAR1q1ezzlKdpCjoSTTLKWRE5r7yzY6j4noAquQsINI14JaHzjpMQbcnI4FdC+QeQlG9Crw7hVMc7omghNQb+fDdhSdfbQMnlbDcHP7/o8xCCo+k4z+uz6g/SzJ3PiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=hqUYci7p; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744304114; x=1744908914; i=w_armin@gmx.de;
	bh=2Z23hwRksRh4jNXp7ShpIARtlgUhtN5TEW1vLukI378=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hqUYci7pbL6DtmEcSyumtELhCbWfClA7MC7CwiMzsa3i6UeWpgRUHNGpUXVxvfZL
	 TK7uHHpHxWwWA1YdytDSUNtsnKi49I2qEvTPAZeoJxFs9YA1PWj0Pc8w2jaU/uWMk
	 2U9+7hLLzONNejM6HniO1KWNOuMcp2zIT5nKYZhf4M2VQ15SzrNqXVCaitdsR1Kpn
	 X9EliKkDaO/g6h/5PBwkZIxx4PQyThoHO6EbH4cblJRYZ/BOvonVZOpwQM4gN+T27
	 TtngG0/MEtynVBWBf1JQH8HxU0oNY+ZaqL+TzJpGJiceCIVCOEE7TBai1L+P6behF
	 WbC5ha4pqSFv3MAqOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M4b1y-1u1GUO1VIs-003tgq; Thu, 10 Apr 2025 18:55:14 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	rui.zhang@intel.com
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ACPI: thermal: Allow userspace applications to change the cooling mode
Date: Thu, 10 Apr 2025 18:54:56 +0200
Message-Id: <20250410165456.4173-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250410165456.4173-1-W_Armin@gmx.de>
References: <20250410165456.4173-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rpxCG6tethH5HoHA36GFmyJ57pywK57TN0LXpiTs5lcKXmxUihc
 /ar16DvsIkzufBqPbdb7pMi4W2RT9i+jydTOYWk8kdoE4cX/h7RgTeggD75ufkneDS/3uoW
 LTx0BkW4feuM7apxvYvSj8lshWzER1c7wjMVBwvPCrJAW8OXC1/Xx5ReAUTsMoO3Q194O/y
 rd2pjMCEqI/IaoaxVDcgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cL4DNgSJCTA=;7k0R8NpWTZST8b28beA3JQkzG/H
 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
 hASjuNYmdLyYaVy43FTOcDPntcZ2au6yik

Users might want to signal the ACPI firmware whether active or passive
cooling is preferred. This is already possible under Windows using the
Windows power settings.

Add a new "cooling_mode" sysfs attribute which can be used by users to
change the cooling mode of a given thermal zone. Only thermal zones
supporting the _SCP control method will expose this new attribute.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../ABI/testing/sysfs-driver-thermal          |  14 ++
 MAINTAINERS                                   |   1 +
 drivers/acpi/thermal.c                        | 129 ++++++++++++++++--
 3 files changed, 132 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-thermal

diff --git a/Documentation/ABI/testing/sysfs-driver-thermal b/Documentatio=
n/ABI/testing/sysfs-driver-thermal
new file mode 100644
index 000000000000..bf2349f31863
=2D-- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-thermal
@@ -0,0 +1,14 @@
+What:		/sys/bus/acpi/devices/LNXTHERM:*/cooling_mode
+Date:		April 2025
+KernelVersion:	6.16
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		A string representing the preferred cooling mode of the
+		associated ACPI thermal zone:
+
+		- "active" for preferring active cooling
+
+		- "passive" for preferring passive cooling
+
+		The exact characteristics of both cooling modes depend
+		on the underlying ACPI firmware implementation.
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..fd3102723518 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -382,6 +382,7 @@ R:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
 B:	https://bugzilla.kernel.org
+F:	Documentation/ABI/testing/sysfs-driver-thermal
 F:	drivers/acpi/*thermal*

 ACPI VIOT DRIVER
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 5c2defe55898..52d0c777a93a 100644
=2D-- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -15,11 +15,14 @@

 #define pr_fmt(fmt) "ACPI: thermal: " fmt

+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/kmod.h>
@@ -40,7 +43,6 @@
 #define ACPI_THERMAL_NOTIFY_DEVICES	0x82
 #define ACPI_THERMAL_NOTIFY_CRITICAL	0xF0
 #define ACPI_THERMAL_NOTIFY_HOT		0xF1
-#define ACPI_THERMAL_MODE_ACTIVE	0x00

 #define ACPI_THERMAL_MAX_ACTIVE		10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
@@ -85,6 +87,16 @@ MODULE_PARM_DESC(psv, "Disable or override all passive =
trip points.");

 static struct workqueue_struct *acpi_thermal_pm_queue;

+enum acpi_thermal_cooling_mode {
+	ACPI_THERMAL_MODE_ACTIVE	=3D 0x00,
+	ACPI_THERMAL_MODE_PASSIVE	=3D 0x01,
+};
+
+static const char * const acpi_thermal_cooling_mode_strings[] =3D {
+	[ACPI_THERMAL_MODE_ACTIVE]	=3D "active",
+	[ACPI_THERMAL_MODE_PASSIVE]	=3D "passive",
+};
+
 struct acpi_thermal_trip {
 	unsigned long temp_dk;
 	struct acpi_handle_list devices;
@@ -119,6 +131,9 @@ struct acpi_thermal {
 	struct work_struct thermal_check_work;
 	struct mutex thermal_check_lock;
 	refcount_t thermal_check_count;
+	bool supports_cooling_mode;
+	struct mutex cooling_mode_lock;       /* Protects cooling mode updates *=
/
+	enum acpi_thermal_cooling_mode cooling_mode;
 };

 /* ----------------------------------------------------------------------=
----
@@ -328,7 +343,6 @@ static void acpi_queue_thermal_check(struct acpi_therm=
al *tz)
 static void acpi_thermal_trips_update(struct acpi_thermal *tz, u32 event)
 {
 	struct adjust_trip_data atd =3D { .tz =3D tz, .event =3D event };
-	struct acpi_device *adev =3D tz->device;

 	/*
 	 * Use thermal_zone_for_each_trip() to carry out the trip points
@@ -340,8 +354,6 @@ static void acpi_thermal_trips_update(struct acpi_ther=
mal *tz, u32 event)
 	thermal_zone_for_each_trip(tz->thermal_zone,
 				   acpi_thermal_adjust_trip, &atd);
 	acpi_queue_thermal_check(tz);
-	acpi_bus_generate_netlink_event(adev->pnp.device_class,
-					dev_name(&adev->dev), event, 0);
 }

 static int acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
@@ -473,6 +485,18 @@ static void acpi_thermal_get_trip_points(struct acpi_=
thermal *tz)
 		tz->trips.active[i].trip.temp_dk =3D THERMAL_TEMP_INVALID;
 }

+static int acpi_thermal_set_cooling_mode(struct acpi_thermal *tz,
+					 enum acpi_thermal_cooling_mode mode)
+{
+	acpi_status status;
+
+	status =3D acpi_execute_simple_method(tz->device->handle, "_SCP", mode);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
 /* sys I/F for generic thermal sysfs support */

 static int thermal_get_temp(struct thermal_zone_device *thermal, int *tem=
p)
@@ -683,6 +707,8 @@ static void acpi_thermal_notify(acpi_handle handle, u3=
2 event, void *data)
 	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
 	case ACPI_THERMAL_NOTIFY_DEVICES:
 		acpi_thermal_trips_update(tz, event);
+		acpi_bus_generate_netlink_event(device->pnp.device_class, dev_name(&dev=
ice->dev),
+						event, 0);
 		break;
 	default:
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
@@ -777,6 +803,65 @@ static void acpi_thermal_free_thermal_zone(struct acp=
i_thermal *tz)
 	kfree(tz);
 }

+static ssize_t cooling_mode_show(struct device *dev, struct device_attrib=
ute *attr, char *buf)
+{
+	struct acpi_thermal *tz =3D acpi_driver_data(to_acpi_device(dev));
+
+	guard(mutex)(&tz->cooling_mode_lock);
+
+	return sysfs_emit(buf, "%s\n", acpi_thermal_cooling_mode_strings[tz->coo=
ling_mode]);
+}
+
+static ssize_t cooling_mode_store(struct device *dev, struct device_attri=
bute *attr,
+				  const char *buf, size_t count)
+{
+	struct acpi_thermal *tz =3D acpi_driver_data(to_acpi_device(dev));
+	int ret, mode;
+
+	mode =3D sysfs_match_string(acpi_thermal_cooling_mode_strings, buf);
+	if (mode < 0)
+		return mode;
+
+	guard(mutex)(&tz->cooling_mode_lock);
+
+	ret =3D acpi_thermal_set_cooling_mode(tz, mode);
+	if (ret < 0)
+		return ret;
+
+	tz->cooling_mode =3D mode;
+	acpi_thermal_trips_update(tz, ACPI_THERMAL_NOTIFY_THRESHOLDS);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(cooling_mode);
+
+static struct attribute *acpi_thermal_attrs[] =3D {
+	&dev_attr_cooling_mode.attr,
+	NULL
+};
+
+static umode_t acpi_thermal_group_is_visible(struct kobject *kobj, struct=
 attribute *attr, int idx)
+{
+	struct device *dev =3D kobj_to_dev(kobj);
+	struct acpi_thermal *tz =3D acpi_driver_data(to_acpi_device(dev));
+
+	if (tz->supports_cooling_mode)
+		return attr->mode;
+
+	return 0;
+}
+
+static const struct attribute_group acpi_thermal_group =3D {
+	.is_visible =3D acpi_thermal_group_is_visible,
+	.attrs =3D acpi_thermal_attrs,
+};
+
+static const struct attribute_group *acpi_thermal_groups[] =3D {
+	&acpi_thermal_group,
+	NULL
+};
+
 static int acpi_thermal_add(struct acpi_device *device)
 {
 	struct thermal_trip trip_table[ACPI_THERMAL_MAX_NR_TRIPS] =3D { 0 };
@@ -786,7 +871,7 @@ static int acpi_thermal_add(struct acpi_device *device=
)
 	int crit_temp, hot_temp;
 	int passive_delay =3D 0;
 	int result;
-	int i;
+	int ret, i;

 	if (!device)
 		return -EINVAL;
@@ -795,6 +880,10 @@ static int acpi_thermal_add(struct acpi_device *devic=
e)
 	if (!tz)
 		return -ENOMEM;

+	ret =3D devm_mutex_init(&device->dev, &tz->cooling_mode_lock);
+	if (ret < 0)
+		return ret;
+
 	tz->device =3D device;
 	strscpy(tz->name, device->pnp.bus_id);
 	strscpy(acpi_device_name(device), ACPI_THERMAL_DEVICE_NAME);
@@ -803,11 +892,18 @@ static int acpi_thermal_add(struct acpi_device *devi=
ce)

 	acpi_thermal_aml_dependency_fix(tz);

-	/*
-	 * Set the cooling mode [_SCP] to active cooling. This needs to happen b=
efore
-	 * we retrieve the trip point values.
-	 */
-	acpi_execute_simple_method(tz->device->handle, "_SCP", ACPI_THERMAL_MODE=
_ACTIVE);
+	tz->supports_cooling_mode =3D acpi_has_method(tz->device->handle, "_SCP"=
);
+	if (tz->supports_cooling_mode) {
+		/*
+		 * Set the initial cooling mode to active cooling. This needs to happen
+		 * before we retrieve the trip point values.
+		 */
+		ret =3D acpi_thermal_set_cooling_mode(tz, ACPI_THERMAL_MODE_ACTIVE);
+		if (ret < 0)
+			dev_err(&tz->device->dev, "Failed to set initial cooling mode\n");
+
+		tz->cooling_mode =3D ACPI_THERMAL_MODE_ACTIVE;
+	}

 	/* Get trip points [_ACi, _PSV, etc.] (required). */
 	acpi_thermal_get_trip_points(tz);
@@ -924,7 +1020,7 @@ static int acpi_thermal_suspend(struct device *dev)
 static int acpi_thermal_resume(struct device *dev)
 {
 	struct acpi_thermal *tz;
-	int i, j, power_state;
+	int ret, i, j, power_state;

 	if (!dev)
 		return -EINVAL;
@@ -933,6 +1029,12 @@ static int acpi_thermal_resume(struct device *dev)
 	if (!tz)
 		return -EINVAL;

+	if (tz->supports_cooling_mode) {
+		ret =3D acpi_thermal_set_cooling_mode(tz, tz->cooling_mode);
+		if (ret < 0)
+			dev_err(&tz->device->dev, "Failed to restore cooling mode\n");
+	}
+
 	for (i =3D 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		struct acpi_thermal_trip *acpi_trip =3D &tz->trips.active[i].trip;

@@ -969,7 +1071,10 @@ static struct acpi_driver acpi_thermal_driver =3D {
 		.add =3D acpi_thermal_add,
 		.remove =3D acpi_thermal_remove,
 		},
-	.drv.pm =3D &acpi_thermal_pm,
+	.drv =3D {
+		.dev_groups =3D acpi_thermal_groups,
+		.pm =3D &acpi_thermal_pm,
+	},
 };

 static int thermal_act(const struct dmi_system_id *d)
=2D-
2.39.5


