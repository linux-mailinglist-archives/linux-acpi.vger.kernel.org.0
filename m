Return-Path: <linux-acpi+bounces-10823-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D02A4A1C4F4
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 19:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50EA188880E
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EDF757EA;
	Sat, 25 Jan 2025 18:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lZgA3tZO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47480AD23;
	Sat, 25 Jan 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737830768; cv=none; b=LC8a9ASJg/dQbxfw+V3Pmh0XoP7twVL0F3P09CFd/Y1qKSyy8baTcPt5B8PhbLmAnn5z7Fe9jD1OBDAzOfU8Ivp9KLFM8VFQtz88tT/5iTq0h1047wk9wGR9MkM74Gb+xkdV0TZFekIHvy+4VgWsG1+eDBsa5ZQy8RLRT/70psM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737830768; c=relaxed/simple;
	bh=kCDQx6Rr0sz3v13KG5nmO+6dAkPhFCQb4bl6g9Bm1nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VTtEYWZ5XDafcqzC7TQ2yWI0x+7XcZ39K9yDbSh1EOJRYR0kwEjCmqX4MG1ExUsiI0Eh8V6DzFyNXYujpkOxmwCVkMlgL77UkEqP4SWA+Mos1ApM4ZoM9nxtecgTJp3onfEHAfpQFMQ22nRDquHXkx7MYJP17E1uXpg8aFwY1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lZgA3tZO; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737830758; x=1738435558; i=w_armin@gmx.de;
	bh=LdZwJOJarsCFvjeu86HjfhXkTiuv3/c0rkdipdD159M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lZgA3tZOQqtr01rcCzBQgriDkdKfQgO3jEupX/KhmGHpctd44kS7jJ49l3KgTRzh
	 8WOkiYIGWwDf3AhEQlFTVqD2EIyHP1JWvrZlt5PBy6MnCcVWkLL9IQl/kN4KXTbf9
	 g+6Kb6zDi6Wld4Pg077uqG2UD9jqh6tj3aog8AmcElvXKd31lKTHJ98Qd8z7SRbyL
	 Zv1x605vZJB27c3h8MNR6kbmfVAxZMJ4qciiMiJpkmMhAyn5l0YosaYrBouTY9SOf
	 MPUv+Jr6958c86PqGvER2FBBUfN6z7ctIXT4MtYmsikRx6f3SjWQnJ6Oej7nHbouU
	 9zZPzJNBmvWTKbTGhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.246.83]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1t3oSY0eGC-00poBk; Sat, 25
 Jan 2025 19:45:58 +0100
Message-ID: <8e2bfe0e-1023-40f6-9c5c-e21203ddc457@gmx.de>
Date: Sat, 25 Jan 2025 19:45:57 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ACPI: fan: Add fan speed reporting for fans with only
 _FST
To: Joshua Grisham <josh@joshuagrisham.com>, rafael@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250125100711.70977-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250125100711.70977-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LY1qw0g4ZdimvGHcF3L2N1n8clWybRkEO+nsR0/JdDt7qXYbBrw
 zHch6gKZxxVGGOPLARc1WBhFjxXILBUG96Qa5eO7S5CCGEzu6ZHMulW0qNyuQfvTSx8hHd1
 F2VZB0s/fss7EErsK/U1QzYpKAv1ABjx/wSFniK2gAKzHvpg/RhRrjw6XXpIIjrfYQDZA2q
 VnPjymzYV14/xJndk6JfQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wo6HNPXdiO4=;DINz2nHKViynyWx0MySl6drTxOJ
 yXhPpvh7zS1CCGWT7zb1eUiZRfh4y1p07AXIIN5k3UrWgorCdl+UZ9AUZmT20u5H4NOHfUQgl
 Y1chohJmfu6ieIfwoa2KQmC7lcuQx3XL87cA+Am6XgBzNdLmtfYb3dXRumxp+kGsJfAlX1eD8
 CrAWedZaVc4nfepxYXgEt+M/ipTg/0/KN69O7zN1HyVKxYGB0jIWri348PnCkLjfBP4hMSG9r
 AG/tzuopgH/0CvlxmJs32keL0jpenGDTQMEKM+ieRDYLxIuTRIvTmxsjPhg2cI2uMiB3l3UQo
 7ke7hXM2RQZZiJmVojn/ZBJkGx2U0aOA1ut6nTkarNxSBL+U6VKXrefCepKEQrnPJNicl/ep/
 CO/JqbkZSH7lBtH0Tg6XEoKblzKrtglxd7zrCrEf8m1e1n/Q5YBlj3PAoDboqcA8chHemZI72
 ro6l9J0l9O6n/cAaoDBeSPuE37MwX+p+ucAkCnO4D4vhBsU8RlOZoluewVIF+/vM516WXxrbd
 w8BGnWwzULMKte41+SNAR1YlEw/KCePoU3onGx1MkJkEArfd+1+/T1SJSXnNFRCoI97EjyWTk
 ZTq0TbklTDyj29gkixodqp3F5K89wUaa8EkQLiC+5BKp9IcPSZbXYSQxNqIR9wW2lFw5m+blx
 TC9J/rVwBQECS23riC0jCOaqO2Cm4zh2/kiWKPnQxj2UZLTUYzNWDd7L9iBSziDbkxMOIrnAJ
 oGkaIU2rnYmSYspekoPcrOyrZSOMSKgTCjRRDLxR9VBO9246Ih0S7F/tgAwu6zSaWig+BdD/n
 jYBCgPx+rXs7hvF5+UpghH8KLdIVoXOxlHSaAMG36x8hi+Go8XrfyTu4cYNI0lPB89lJQ04o4
 q9UhnilYFtVxQ5q+bVAfOMNOey8jUL85Odm4hNw+uBhB2i8tGBpUoeLdR+HdfYI3QH5UFdC1B
 AjtU7PiBCMWt+d6TvttRw50InlUPVeJB45OZg0gPTElUod3MDjaDAVgyJofiI3CjG9G4GcTiX
 mbyENh0wZ7+6JEZIQfcOPfoHq5FI/XEK0rsYL3daSn15bhSPcMougVgVzAWbdV0fHyDA8Ps2K
 /item71wX+1TeMYT9YVegxDZUQxw8q/8CU57fGjZOZ5Er0ZXcWL3PxjxUIg5A8CbrTgt0kadi
 HbQ5WSzGJKXVEhVsKFQlUFZ0hj+1o5xsr/FswANecAbtvwc4smqlIrQXq8i/HQsHLydXmiscv
 RjXrj/nc8ah1Hmov7TCXKgWXP61L6E0c7A==

Am 25.01.25 um 11:07 schrieb Joshua Grisham:

> Add support for ACPI fans with _FST to report their speed even if they d=
o
> not support fan control.
>
> As suggested by Armin Wolf [1] and per the Windows Thermal Management
> Design Guide [2], Samsung Galaxy Book series devices (and possibly many
> more devices where the Windows guide was strictly followed) only impleme=
nt
> the _FST method and do not support ACPI-based fan control.
>
> Currently, these fans are not supported by the kernel driver but this pa=
tch
> will make some very small adjustments to allow them to be supported.
>
> This patch is tested and working for me on a Samsung Galaxy Book2 Pro wh=
ose
> DSDT (and several other Samsung Galaxy Book series notebooks which
> currently have the same issue) can be found at [3].
>
> [1]: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f=
-463912dd966d@gmx.de
> [2]: https://learn.microsoft.com/en-us/windows-hardware/design/device-ex=
periences/design-guide
> [3]: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e3=
087a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> ---
>
> v1->v2:
> - Still allow acpi4_only_fst fans to update power state on
>    suspend/resume
> - Fix if / else if logic error
> - Also hide hwmon_power_input for acpi4_only_fst fans
>
> v2->v3:
> - Still allow acpi4_only_fst fans to set initial power state on probe
> ---
>   drivers/acpi/fan.h       |  1 +
>   drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
>   drivers/acpi/fan_core.c  | 22 +++++++++++++++++-----
>   drivers/acpi/fan_hwmon.c | 12 ++++++++++++
>   4 files changed, 52 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index 488b51e2c..d0aad88a7 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -49,6 +49,7 @@ struct acpi_fan_fst {
>
>   struct acpi_fan {
>   	bool acpi4;
> +	bool acpi4_only_fst;
>   	struct acpi_fan_fif fif;
>   	struct acpi_fan_fps *fps;
>   	int fps_count;
> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> index f4f6e2381..d83f88429 100644
> --- a/drivers/acpi/fan_attr.c
> +++ b/drivers/acpi/fan_attr.c
> @@ -75,15 +75,6 @@ int acpi_fan_create_attributes(struct acpi_device *de=
vice)
>   	struct acpi_fan *fan =3D acpi_driver_data(device);
>   	int i, status;
>
> -	sysfs_attr_init(&fan->fine_grain_control.attr);
> -	fan->fine_grain_control.show =3D show_fine_grain_control;
> -	fan->fine_grain_control.store =3D NULL;
> -	fan->fine_grain_control.attr.name =3D "fine_grain_control";
> -	fan->fine_grain_control.attr.mode =3D 0444;
> -	status =3D sysfs_create_file(&device->dev.kobj, &fan->fine_grain_contr=
ol.attr);
> -	if (status)
> -		return status;
> -
>   	/* _FST is present if we are here */
>   	sysfs_attr_init(&fan->fst_speed.attr);
>   	fan->fst_speed.show =3D show_fan_speed;
> @@ -92,7 +83,19 @@ int acpi_fan_create_attributes(struct acpi_device *de=
vice)
>   	fan->fst_speed.attr.mode =3D 0444;
>   	status =3D sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr)=
;
>   	if (status)
> -		goto rem_fine_grain_attr;
> +		return status;
> +
> +	if (fan->acpi4_only_fst)
> +		return 0;
> +
> +	sysfs_attr_init(&fan->fine_grain_control.attr);
> +	fan->fine_grain_control.show =3D show_fine_grain_control;
> +	fan->fine_grain_control.store =3D NULL;
> +	fan->fine_grain_control.attr.name =3D "fine_grain_control";
> +	fan->fine_grain_control.attr.mode =3D 0444;
> +	status =3D sysfs_create_file(&device->dev.kobj, &fan->fine_grain_contr=
ol.attr);
> +	if (status)
> +		goto rem_fst_attr;
>
>   	for (i =3D 0; i < fan->fps_count; ++i) {
>   		struct acpi_fan_fps *fps =3D &fan->fps[i];
> @@ -109,18 +112,18 @@ int acpi_fan_create_attributes(struct acpi_device =
*device)
>
>   			for (j =3D 0; j < i; ++j)
>   				sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
> -			goto rem_fst_attr;
> +			goto rem_fine_grain_attr;
>   		}
>   	}
>
>   	return 0;
>
> -rem_fst_attr:
> -	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> -
>   rem_fine_grain_attr:
>   	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
>
> +rem_fst_attr:
> +	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> +
>   	return status;
>   }
>
> @@ -129,9 +132,13 @@ void acpi_fan_delete_attributes(struct acpi_device =
*device)
>   	struct acpi_fan *fan =3D acpi_driver_data(device);
>   	int i;
>
> +	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> +
> +	if (fan->acpi4_only_fst)
> +		return;
> +
>   	for (i =3D 0; i < fan->fps_count; ++i)
>   		sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
>
> -	sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
>   	sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
>   }
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 10016f52f..66aa1be64 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -211,6 +211,11 @@ static bool acpi_fan_is_acpi4(struct acpi_device *d=
evice)
>   	       acpi_has_method(device->handle, "_FST");
>   }
>
> +static bool acpi_fan_has_fst(struct acpi_device *device)
> +{
> +	return acpi_has_method(device->handle, "_FST");
> +}
> +
>   static int acpi_fan_get_fif(struct acpi_device *device)
>   {
>   	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -327,7 +332,12 @@ static int acpi_fan_probe(struct platform_device *p=
dev)
>   	device->driver_data =3D fan;
>   	platform_set_drvdata(pdev, fan);
>
> -	if (acpi_fan_is_acpi4(device)) {
> +	if (acpi_fan_is_acpi4(device))
> +		fan->acpi4 =3D true;
> +	else if (acpi_fan_has_fst(device))
> +		fan->acpi4_only_fst =3D true;
> +
> +	if (fan->acpi4) {
>   		result =3D acpi_fan_get_fif(device);
>   		if (result)
>   			return result;
> @@ -335,7 +345,9 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   		result =3D acpi_fan_get_fps(device);
>   		if (result)
>   			return result;
> +	}
>
> +	if (fan->acpi4 || fan->acpi4_only_fst) {
>   		result =3D devm_acpi_fan_create_hwmon(device);
>   		if (result)
>   			return result;
> @@ -343,9 +355,9 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   		result =3D acpi_fan_create_attributes(device);
>   		if (result)
>   			return result;
> +	}
>
> -		fan->acpi4 =3D true;
> -	} else {
> +	if (!fan->acpi4) {
>   		result =3D acpi_device_update_power(device, NULL);
>   		if (result) {
>   			dev_err(&device->dev, "Failed to set initial power state\n");
> @@ -391,7 +403,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   err_unregister:
>   	thermal_cooling_device_unregister(cdev);
>   err_end:
> -	if (fan->acpi4)
> +	if (fan->acpi4 || fan->acpi4_only_fst)
>   		acpi_fan_delete_attributes(device);
>
>   	return result;
> @@ -401,7 +413,7 @@ static void acpi_fan_remove(struct platform_device *=
pdev)
>   {
>   	struct acpi_fan *fan =3D platform_get_drvdata(pdev);
>
> -	if (fan->acpi4) {
> +	if (fan->acpi4 || fan->acpi4_only_fst) {
>   		struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>
>   		acpi_fan_delete_attributes(device);
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> index bd0d31a39..d0668ecc2 100644
> --- a/drivers/acpi/fan_hwmon.c
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -43,6 +43,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *=
drvdata, enum hwmon_sensor_
>   		case hwmon_fan_input:
>   			return 0444;
>   		case hwmon_fan_target:
> +			/*
> +			 * Fans with only _FST do not support fan control.
> +			 */
> +			if (fan->acpi4_only_fst)
> +				return 0;
> +
>   			/*
>   			 * When in fine grain control mode, not every fan control value
>   			 * has an associated fan performance state.
> @@ -57,6 +63,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *=
drvdata, enum hwmon_sensor_
>   	case hwmon_power:
>   		switch (attr) {
>   		case hwmon_power_input:
> +			/*
> +			 * Fans with only _FST do not support fan control.
> +			 */
> +			if (fan->acpi4_only_fst)
> +				return 0;
> +
>   			/*
>   			 * When in fine grain control mode, not every fan control value
>   			 * has an associated fan performance state.

