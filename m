Return-Path: <linux-acpi+bounces-7862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C26960474
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 10:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157C51F23A64
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B93F19752C;
	Tue, 27 Aug 2024 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liNvc+jh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6CB1714A3;
	Tue, 27 Aug 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747576; cv=none; b=cY7LILfwvHQ0wZCWN30T6X6QgU/dj4aph+ARbIc/8bWbKN+ChxMBz7GS8W8cemWwirX9gPABMvHVfkHF1wX3rlLDYrGS8E49g+qBa9yS3my78mKRY4aVftTF2MYd04I0+3t6gl6m+xv3+08mi3O7JBljPyquw/rWVclGcwx4kS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747576; c=relaxed/simple;
	bh=lBNWo5UGOPyq1FnJSSwRHNSdcpKfqzC9v6Enz0IOWIQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oClGWIzejhSRbsmhABFRTSfjhmltOzqwxFI3/CT+HzexlVElSJvwL5TPbkG5Sy4Ba4WcImnrKozsGsKiiGV4KM1NaaCSZ9/PoutuUjA4T2EW0L8U1n2JPWTtZYqYRt/goXCSfKa/y2h/AMy+uKaTIo/wlEaEWxngtj4hWIOlgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liNvc+jh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724747574; x=1756283574;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lBNWo5UGOPyq1FnJSSwRHNSdcpKfqzC9v6Enz0IOWIQ=;
  b=liNvc+jh1cT06LLlvwL742r9GvymVeRHi4FB52mB5cq+/N5dTkhclUww
   aSeABbAzHh64JUdVMREVUFOJ4eW4B5Qzo7+0cdXvfiFZtzxsx4ps5HeHj
   pR+9mZtpxXirbVmAMm9gKS8QKNneDd+0d4+iFT9avhaDnEJWI5BW+nE84
   kATH1fUjNW3BxcN968MVTJQ6v37cR9yBPH4qeNU3MBeZvk4rBrW3w47M4
   vWm3nZjwIQ7yZk6tKL+24VoD8bmUu5S4BfmZdAQngIchEpHtB95VkZm+Y
   ubDCpuMkv7pzKryf+vgu3sVYPy0cFHGEufRm0qiS8tddEBdAQEfGa80cc
   Q==;
X-CSE-ConnectionGUID: Q8DMmyVUSf66G2jcO2vz/Q==
X-CSE-MsgGUID: NpX3O9LhTC6eYnOzUNT0aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40713750"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40713750"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:32:38 -0700
X-CSE-ConnectionGUID: +fSbsqTtRAeW++uUPdNBIg==
X-CSE-MsgGUID: lsv7YrrRQaulDcmgZcnz7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62949735"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 01:32:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 11:32:29 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: james@equiv.tech, jlee@suse.com, corentin.chary@gmail.com, luke@ljones.dev, 
    matan@svgalib.org, coproscefalo@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] platform/x86: wmi: Pass event data directly to legacy
 notify handlers
In-Reply-To: <20240822173810.11090-2-W_Armin@gmx.de>
Message-ID: <42be5889-85d0-6bf2-d817-b86d8e593812@linux.intel.com>
References: <20240822173810.11090-1-W_Armin@gmx.de> <20240822173810.11090-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1770808421-1724747549=:1032"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1770808421-1724747549=:1032
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Aug 2024, Armin Wolf wrote:

> The current legacy WMI handlers are susceptible to picking up wrong
> WMI event data on systems where different WMI devices share some
> notification IDs.
>=20
> Prevent this by letting the WMI driver core taking care of retrieving
> the event data. This also simplifies the legacy WMI handlers and their
> implementation inside the WMI driver core.
>=20
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/hp-wmi-sensors.c           | 17 ++--------
>  drivers/platform/x86/acer-wmi.c          | 16 +--------
>  drivers/platform/x86/asus-wmi.c          | 19 ++---------
>  drivers/platform/x86/dell/dell-wmi-aio.c | 13 +------
>  drivers/platform/x86/hp/hp-wmi.c         | 16 +--------
>  drivers/platform/x86/huawei-wmi.c        | 14 +-------
>  drivers/platform/x86/lg-laptop.c         | 13 +------
>  drivers/platform/x86/msi-wmi.c           | 20 ++---------
>  drivers/platform/x86/toshiba-wmi.c       | 15 +--------
>  drivers/platform/x86/wmi.c               | 43 ++++++++++--------------
>  include/linux/acpi.h                     |  2 +-
>  11 files changed, 34 insertions(+), 154 deletions(-)
>=20
> diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensor=
s.c
> index b5325d0e72b9..6892518d537c 100644
> --- a/drivers/hwmon/hp-wmi-sensors.c
> +++ b/drivers/hwmon/hp-wmi-sensors.c
> @@ -1597,15 +1597,13 @@ static void hp_wmi_devm_notify_remove(void *ignor=
ed)
>  }
>=20
>  /* hp_wmi_notify - WMI event notification handler */
> -static void hp_wmi_notify(u32 value, void *context)
> +static void hp_wmi_notify(union acpi_object *wobj, void *context)
>  {
>  =09struct hp_wmi_info *temp_info[HP_WMI_MAX_INSTANCES] =3D {};
> -=09struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
>  =09struct hp_wmi_sensors *state =3D context;
>  =09struct device *dev =3D &state->wdev->dev;
>  =09struct hp_wmi_event event =3D {};
>  =09struct hp_wmi_info *fan_info;
> -=09union acpi_object *wobj;
>  =09acpi_status err;
>  =09int event_type;
>  =09u8 count;
> @@ -1632,16 +1630,10 @@ static void hp_wmi_notify(u32 value, void *contex=
t)
>=20
>  =09mutex_lock(&state->lock);
>=20
> -=09err =3D wmi_get_event_data(value, &out);
> -=09if (ACPI_FAILURE(err))
> -=09=09goto out_unlock;
> -
> -=09wobj =3D out.pointer;
> -
>  =09err =3D populate_event_from_wobj(dev, &event, wobj);
>  =09if (err) {
>  =09=09dev_warn(dev, "Bad event data (ACPI type %d)\n", wobj->type);
> -=09=09goto out_free_wobj;
> +=09=09goto out_free;
>  =09}
>=20
>  =09event_type =3D classify_event(event.name, event.category);
> @@ -1666,13 +1658,10 @@ static void hp_wmi_notify(u32 value, void *contex=
t)
>  =09=09break;
>  =09}
>=20
> -out_free_wobj:
> -=09kfree(wobj);
> -
> +out_free:
>  =09devm_kfree(dev, event.name);
>  =09devm_kfree(dev, event.description);

Totally unrelated to your patch, using devm_*() for the members of an
on-stack struct looks very very odd. :-/


Your change looks good and removes lots of code duplication. :-)

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

>=20
> -out_unlock:
>  =09mutex_unlock(&state->lock);
>  }
>=20
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-=
wmi.c
> index 349169d050c5..7169b84ccdb6 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -2223,39 +2223,25 @@ static void acer_rfkill_exit(void)
>  =09}
>  }
>=20
> -static void acer_wmi_notify(u32 value, void *context)
> +static void acer_wmi_notify(union acpi_object *obj, void *context)
>  {
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -=09union acpi_object *obj;
>  =09struct event_return_value return_value;
> -=09acpi_status status;
>  =09u16 device_state;
>  =09const struct key_entry *key;
>  =09u32 scancode;
>=20
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (status !=3D AE_OK) {
> -=09=09pr_warn("bad event status 0x%x\n", status);
> -=09=09return;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
> -
>  =09if (!obj)
>  =09=09return;
>  =09if (obj->type !=3D ACPI_TYPE_BUFFER) {
>  =09=09pr_warn("Unknown response received %d\n", obj->type);
> -=09=09kfree(obj);
>  =09=09return;
>  =09}
>  =09if (obj->buffer.length !=3D 8) {
>  =09=09pr_warn("Unknown buffer length %d\n", obj->buffer.length);
> -=09=09kfree(obj);
>  =09=09return;
>  =09}
>=20
>  =09return_value =3D *((struct event_return_value *)obj->buffer.pointer);
> -=09kfree(obj);
>=20
>  =09switch (return_value.function) {
>  =09case WMID_HOTKEY_EVENT:
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 9c6b3937ac71..1eb6b39df604 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -4187,28 +4187,15 @@ static void asus_wmi_fnlock_update(struct asus_wm=
i *asus)
>=20
>  /* WMI events **********************************************************=
*******/
>=20
> -static int asus_wmi_get_event_code(u32 value)
> +static int asus_wmi_get_event_code(union acpi_object *obj)
>  {
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -=09union acpi_object *obj;
> -=09acpi_status status;
>  =09int code;
>=20
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (ACPI_FAILURE(status)) {
> -=09=09pr_warn("Failed to get WMI notify code: %s\n",
> -=09=09=09=09acpi_format_exception(status));
> -=09=09return -EIO;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
> -
>  =09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
>  =09=09code =3D (int)(obj->integer.value & WMI_EVENT_MASK);
>  =09else
>  =09=09code =3D -EIO;
>=20
> -=09kfree(obj);
>  =09return code;
>  }
>=20
> @@ -4274,10 +4261,10 @@ static void asus_wmi_handle_event_code(int code, =
struct asus_wmi *asus)
>  =09=09pr_info("Unknown key code 0x%x\n", code);
>  }
>=20
> -static void asus_wmi_notify(u32 value, void *context)
> +static void asus_wmi_notify(union acpi_object *obj, void *context)
>  {
>  =09struct asus_wmi *asus =3D context;
> -=09int code =3D asus_wmi_get_event_code(value);
> +=09int code =3D asus_wmi_get_event_code(obj);
>=20
>  =09if (code < 0) {
>  =09=09pr_warn("Failed to get notify code: %d\n", code);
> diff --git a/drivers/platform/x86/dell/dell-wmi-aio.c b/drivers/platform/=
x86/dell/dell-wmi-aio.c
> index c7b7f1e403fb..54096495719b 100644
> --- a/drivers/platform/x86/dell/dell-wmi-aio.c
> +++ b/drivers/platform/x86/dell/dell-wmi-aio.c
> @@ -70,20 +70,10 @@ static bool dell_wmi_aio_event_check(u8 *buffer, int =
length)
>  =09return false;
>  }
>=20
> -static void dell_wmi_aio_notify(u32 value, void *context)
> +static void dell_wmi_aio_notify(union acpi_object *obj, void *context)
>  {
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -=09union acpi_object *obj;
>  =09struct dell_wmi_event *event;
> -=09acpi_status status;
>=20
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (status !=3D AE_OK) {
> -=09=09pr_info("bad event status 0x%x\n", status);
> -=09=09return;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
>  =09if (obj) {
>  =09=09unsigned int scancode =3D 0;
>=20
> @@ -114,7 +104,6 @@ static void dell_wmi_aio_notify(u32 value, void *cont=
ext)
>  =09=09=09break;
>  =09=09}
>  =09}
> -=09kfree(obj);
>  }
>=20
>  static int __init dell_wmi_aio_input_setup(void)
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/h=
p-wmi.c
> index 876e0a97cee1..8c05e0dd2a21 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -834,28 +834,16 @@ static struct attribute *hp_wmi_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(hp_wmi);
>=20
> -static void hp_wmi_notify(u32 value, void *context)
> +static void hp_wmi_notify(union acpi_object *obj, void *context)
>  {
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
>  =09u32 event_id, event_data;
> -=09union acpi_object *obj;
> -=09acpi_status status;
>  =09u32 *location;
>  =09int key_code;
>=20
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (status !=3D AE_OK) {
> -=09=09pr_info("bad event status 0x%x\n", status);
> -=09=09return;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
> -
>  =09if (!obj)
>  =09=09return;
>  =09if (obj->type !=3D ACPI_TYPE_BUFFER) {
>  =09=09pr_info("Unknown response received %d\n", obj->type);
> -=09=09kfree(obj);
>  =09=09return;
>  =09}
>=20
> @@ -872,10 +860,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  =09=09event_data =3D *(location + 2);
>  =09} else {
>  =09=09pr_info("Unknown buffer length %d\n", obj->buffer.length);
> -=09=09kfree(obj);
>  =09=09return;
>  =09}
> -=09kfree(obj);
>=20
>  =09switch (event_id) {
>  =09case HPWMI_DOCK_EVENT:
> diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/hua=
wei-wmi.c
> index 09d476dd832e..d81fd5df4a00 100644
> --- a/drivers/platform/x86/huawei-wmi.c
> +++ b/drivers/platform/x86/huawei-wmi.c
> @@ -734,26 +734,14 @@ static void huawei_wmi_process_key(struct input_dev=
 *idev, int code)
>  =09sparse_keymap_report_entry(idev, key, 1, true);
>  }
>=20
> -static void huawei_wmi_input_notify(u32 value, void *context)
> +static void huawei_wmi_input_notify(union acpi_object *obj, void *contex=
t)
>  {
>  =09struct input_dev *idev =3D (struct input_dev *)context;
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -=09union acpi_object *obj;
> -=09acpi_status status;
>=20
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (ACPI_FAILURE(status)) {
> -=09=09dev_err(&idev->dev, "Unable to get event data\n");
> -=09=09return;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
>  =09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
>  =09=09huawei_wmi_process_key(idev, obj->integer.value);
>  =09else
>  =09=09dev_err(&idev->dev, "Bad response type\n");
> -
> -=09kfree(response.pointer);
>  }
>=20
>  static int huawei_wmi_input_setup(struct device *dev, const char *guid)
> diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-l=
aptop.c
> index 9c7857842caf..4d57cf803473 100644
> --- a/drivers/platform/x86/lg-laptop.c
> +++ b/drivers/platform/x86/lg-laptop.c
> @@ -182,21 +182,11 @@ static union acpi_object *lg_wmbb(struct device *de=
v, u32 method_id, u32 arg1, u
>  =09return (union acpi_object *)buffer.pointer;
>  }
>=20
> -static void wmi_notify(u32 value, void *context)
> +static void wmi_notify(union acpi_object *obj, void *context)
>  {
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -=09union acpi_object *obj;
> -=09acpi_status status;
>  =09long data =3D (long)context;
>=20
>  =09pr_debug("event guid %li\n", data);
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (ACPI_FAILURE(status)) {
> -=09=09pr_err("Bad event status 0x%x\n", status);
> -=09=09return;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
>  =09if (!obj)
>  =09=09return;
>=20
> @@ -218,7 +208,6 @@ static void wmi_notify(u32 value, void *context)
>=20
>  =09pr_debug("Type: %i    Eventcode: 0x%llx\n", obj->type,
>  =09=09 obj->integer.value);
> -=09kfree(response.pointer);
>  }
>=20
>  static void wmi_input_setup(void)
> diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wm=
i.c
> index fd318cdfe313..4a7ac85c4db4 100644
> --- a/drivers/platform/x86/msi-wmi.c
> +++ b/drivers/platform/x86/msi-wmi.c
> @@ -170,20 +170,9 @@ static const struct backlight_ops msi_backlight_ops =
=3D {
>  =09.update_status=09=3D bl_set_status,
>  };
>=20
> -static void msi_wmi_notify(u32 value, void *context)
> +static void msi_wmi_notify(union acpi_object *obj, void *context)
>  {
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
>  =09struct key_entry *key;
> -=09union acpi_object *obj;
> -=09acpi_status status;
> -
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (status !=3D AE_OK) {
> -=09=09pr_info("bad event status 0x%x\n", status);
> -=09=09return;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
>=20
>  =09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
>  =09=09int eventcode =3D obj->integer.value;
> @@ -192,7 +181,7 @@ static void msi_wmi_notify(u32 value, void *context)
>  =09=09=09=09eventcode);
>  =09=09if (!key) {
>  =09=09=09pr_info("Unknown key pressed - %x\n", eventcode);
> -=09=09=09goto msi_wmi_notify_exit;
> +=09=09=09return;
>  =09=09}
>=20
>  =09=09if (event_wmi->quirk_last_pressed) {
> @@ -204,7 +193,7 @@ static void msi_wmi_notify(u32 value, void *context)
>  =09=09=09=09pr_debug("Suppressed key event 0x%X - "
>  =09=09=09=09=09 "Last press was %lld us ago\n",
>  =09=09=09=09=09 key->code, ktime_to_us(diff));
> -=09=09=09=09goto msi_wmi_notify_exit;
> +=09=09=09=09return;
>  =09=09=09}
>  =09=09=09last_pressed =3D cur;
>  =09=09}
> @@ -221,9 +210,6 @@ static void msi_wmi_notify(u32 value, void *context)
>  =09=09}
>  =09} else
>  =09=09pr_info("Unknown event received\n");
> -
> -msi_wmi_notify_exit:
> -=09kfree(response.pointer);
>  }
>=20
>  static int __init msi_wmi_backlight_setup(void)
> diff --git a/drivers/platform/x86/toshiba-wmi.c b/drivers/platform/x86/to=
shiba-wmi.c
> index 77c35529ab6f..12c46455e8dc 100644
> --- a/drivers/platform/x86/toshiba-wmi.c
> +++ b/drivers/platform/x86/toshiba-wmi.c
> @@ -32,26 +32,13 @@ static const struct key_entry toshiba_wmi_keymap[] __=
initconst =3D {
>  =09{ KE_END, 0 }
>  };
>=20
> -static void toshiba_wmi_notify(u32 value, void *context)
> +static void toshiba_wmi_notify(union acpi_object *obj, void *context)
>  {
> -=09struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -=09union acpi_object *obj;
> -=09acpi_status status;
> -
> -=09status =3D wmi_get_event_data(value, &response);
> -=09if (ACPI_FAILURE(status)) {
> -=09=09pr_err("Bad event status 0x%x\n", status);
> -=09=09return;
> -=09}
> -
> -=09obj =3D (union acpi_object *)response.pointer;
>  =09if (!obj)
>  =09=09return;
>=20
>  =09/* TODO: Add proper checks once we have data */
>  =09pr_debug("Unknown event received, obj type %x\n", obj->type);
> -
> -=09kfree(response.pointer);
>  }
>=20
>  static const struct dmi_system_id toshiba_wmi_dmi_table[] __initconst =
=3D {
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 1d0b2d6040d1..6ab181dd94ab 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1227,40 +1227,33 @@ static int wmi_notify_device(struct device *dev, =
void *data)
>  =09if (!(wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_=
id =3D=3D *event))
>  =09=09return 0;
>=20
> +=09/* The ACPI WMI specification says that _WED should be
> +=09 * evaluated every time an notification is received, even
> +=09 * if no consumers are present.
> +=09 *
> +=09 * Some firmware implementations actually depend on this
> +=09 * by using a queue for events which will fill up if the
> +=09 * WMI driver core stops evaluating _WED due to missing
> +=09 * WMI event consumers.
> +=09 */
> +=09ret =3D wmi_get_notify_data(wblock, &obj);
> +=09if (ret < 0)
> +=09=09return -EIO;
> +
>  =09down_read(&wblock->notify_lock);
>  =09/* The WMI driver notify handler conflicts with the legacy WMI handle=
r.
>  =09 * Because of this the WMI driver notify handler takes precedence.
>  =09 */
>  =09if (wblock->dev.dev.driver && wblock->driver_ready) {
> -=09=09ret =3D wmi_get_notify_data(wblock, &obj);
> -=09=09if (ret >=3D 0) {
> -=09=09=09wmi_notify_driver(wblock, obj);
> -=09=09=09kfree(obj);
> -=09=09}
> +=09=09wmi_notify_driver(wblock, obj);
>  =09} else {
> -=09=09if (wblock->handler) {
> -=09=09=09wblock->handler(*event, wblock->handler_data);
> -=09=09} else {
> -=09=09=09/* The ACPI WMI specification says that _WED should be
> -=09=09=09 * evaluated every time an notification is received, even
> -=09=09=09 * if no consumers are present.
> -=09=09=09 *
> -=09=09=09 * Some firmware implementations actually depend on this
> -=09=09=09 * by using a queue for events which will fill up if the
> -=09=09=09 * WMI driver core stops evaluating _WED due to missing
> -=09=09=09 * WMI event consumers.
> -=09=09=09 *
> -=09=09=09 * Because of this we need this seemingly useless call to
> -=09=09=09 * wmi_get_notify_data() which in turn evaluates _WED.
> -=09=09=09 */
> -=09=09=09ret =3D wmi_get_notify_data(wblock, &obj);
> -=09=09=09if (ret >=3D 0)
> -=09=09=09=09kfree(obj);
> -=09=09}
> -
> +=09=09if (wblock->handler)
> +=09=09=09wblock->handler(obj, wblock->handler_data);
>  =09}
>  =09up_read(&wblock->notify_lock);
>=20
> +=09kfree(obj);
> +
>  =09acpi_bus_generate_netlink_event("wmi", acpi_dev_name(wblock->acpi_dev=
ice), *event, 0);
>=20
>  =09return -EBUSY;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0687a442fec7..eed105b1fbfb 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -386,7 +386,7 @@ extern bool acpi_is_pnp_device(struct acpi_device *);
>=20
>  #if defined(CONFIG_ACPI_WMI) || defined(CONFIG_ACPI_WMI_MODULE)
>=20
> -typedef void (*wmi_notify_handler) (u32 value, void *context);
> +typedef void (*wmi_notify_handler) (union acpi_object *data, void *conte=
xt);
>=20
>  int wmi_instance_count(const char *guid);
>=20
> --
> 2.39.2
>=20
--8323328-1770808421-1724747549=:1032--

