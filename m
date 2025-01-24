Return-Path: <linux-acpi+bounces-10820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB820A1BDC0
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9F03AACBA
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 21:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9B1DCB21;
	Fri, 24 Jan 2025 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="otiQjvWx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0B1BFE10;
	Fri, 24 Jan 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737753031; cv=none; b=jY2Kaq1zK8jphnVkKxkycXzReuiO6wf3Z/gQL2uRi0MHKwJAvtH3NAIneXqA1fmxJNw23TACfI/17ElRSyrR3GfvbGlAIzoVvZisr3sdaG3R+q6MeXNpm007ZHAbmghtIK1khwUK+asFdVC13grp/z+Vpe4wYh6VFT4uonw5ZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737753031; c=relaxed/simple;
	bh=99bNpAi1aNckhOYybYmuQ35Qk2cZsjlpDhYpkz71tQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kChOttJBpTlNzQEUcSjsSimJswPfGxqSiv2B1ZNmdQnVXCmil+P2qTB+aKdozmPLJm+QH/FUSIYOOj3nAeHxQ+WRwWDAejaAPLr3853Y6PzmCmH4NPV/Y9um5Zh65uGhVlTgIae4QM+Bv3To1C1TdmUFYtAH4F904nmaC4BQ7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=otiQjvWx; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737753026; x=1738357826; i=w_armin@gmx.de;
	bh=aus/sAC7Pjwrmgy+CINgb4XhgHKV4SEWvdiT26li7sM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=otiQjvWxLQ3ftatLtgjJVbrRtH7LyVQdYcQzj4ihX9qIbgqdLlAsaNwCuJfJPSDj
	 NMM3nOnPH+t6mmStoZajCLBFhafT2PlPxh4LzQW7lh/04ZlN0UpGrYUSXgzu4ZJ/r
	 de3d8gosd16VQrSd8mPupO6IKlMhKfnOeMbIoeH/GwN2el7xLhBTtXa7NMW/S0yEK
	 SXdc10PKkl6RdX3u5e6pakqGtl/WKuj3P820hU/FUlz6zgybhXyDtnC41FCl2tpOE
	 YeEaZIQIX/9OWy/L9XzDWmLyZMmssq0TfTmZl3XtBnQDLr3d3EgdS4O1SB5vdvyft
	 VEC6wdAFxdFOCBBydg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.246.83]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1tGD4K24eY-00zgzJ; Fri, 24
 Jan 2025 22:10:26 +0100
Message-ID: <c29c1e53-be8d-4628-84bf-2ec67618490d@gmx.de>
Date: Fri, 24 Jan 2025 22:10:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: fan: Add fan speed reporting for fans with only
 _FST
To: Joshua Grisham <josh@joshuagrisham.com>, rafael@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250123231355.6456-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250123231355.6456-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wstMUtJ1dnWiVCG/WMTZNs31O7fDXHLnsNIdwdsGCIJlIO4zAuk
 gqc0x9z6Gtz8Q9jMW0h54sxM0Yn9sifU9R5n2KsX75cvaJQKkZIEqrJ1BEbs6P1g4fOE6uA
 jvEvL98KTJwuPOg5tH6p569xO/dvXk5isvRoOoJFaP7+23rrE1SHaVaHn+x2E2S9+pC0kzV
 30p55+v/xT7phAkmYQX0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qv3Eq1q2tJU=;PnaMbK+zzd6xUpJkIwcmVlvTa9F
 Kl6Uwz98hvyICXJQOY1DglQDEAZwhe5u5cluCv/MMo75HyDA0xL+5S13Tv+7F08jzSgPlJuIh
 tkibXlC1n5msRN/mW3hprUI3iS2O6mDl8LCtFirIpsUMzPdocCzUFSfKlznS0KetPmQ5vB+VP
 6Sx/nBLYVQemHbchAxXz+hnSae3BygPXYDOenrwBEOJdF0fncmFadX18x/N13JxlfHD+kMNLm
 yXjLQlW1N3FmaBCPkyhyVL3jnFzXkZoAMJWeJqGOEgmBJ3l1DMfl+aS1b1u0o953Mwh1Vztek
 7DG8zjnA5O4qi+YDCxwKuhs6Nv4C2V6bdMif47WVuJT4KAZeBUuxVdTTp5ate7YWVabBHvnBp
 u/W3CGx1ueaHgP+aX+XtEqsYM1mKf/XJk4zhgpMtQ7AXd35/SkmmpP6IJiQ++8UnP8DSk4k7X
 HWc2oVmqzVcgPGryJ4JMWYvK8aLNfBNIANGIY//E9FJ/W3P2ISmezpANlZZz+oRxxUhWXkzW8
 b7UQObJ9FTEljN9m+JlhrZ0Op5Q5IWZshd26fQOFB6JrEK3sztA+0e+cPa5lB6jExEMdmVKXp
 AIx6hpQ11wSWBBy52WY96UWQcy5d6XyJMS6CF4EsSfOXPoCcUfqf5PFU9WbXufQm9HG6KeYa+
 SoOLAngFV6APd7WTeQuqLjTGr6m4pgxdpz/BfplSJII+oGo9kV4QaXftg4+lnv612/c6pn2m6
 9G04ajROePtzeXUPKRa68v6x40NPgEeuAgMWp086fBHYOYimT2kZwDov5qdwokY307zE6n7Vd
 QP1tntlwQeu1cRh0bpLw1YLWYrjEb397d2JB1QEd4yTJ6PCwT6TvUDFQd0tTfGBAZWaw6Dc77
 xSmfb7Nzdj/BSAToWcLppSPxEM8XvTbIRC3UMx4EH+gTkhhPtu8OB5iPFjUzpimKT8sStmcyA
 RExMUL9L2V0DQvPuHNSiFyMJgJX5mwwtgVsmrnGT+VSY1ABDp6adM4gLAaY4vJH8fdVA/tFU5
 oE+gfvbNmOQGHZJQdUuWCb5Cg3+Req05u3ExmEAPXQtkSTysobkaXNN2mwu3UUrRqCvFt/ur2
 zVMJgxdL7q+qEeLWtpJZj6fs7uHbvokT8klHrZRazsrJ/78JYEvNIVNwa7TfZ7YbokRB0zCI9
 78OEaYHn0t1KpwF6kqPgLq+m8xH1ELf/HjAOQyklXzHiARLgAatwq3KCLOqy0nhzAznbqCrww
 CEW866jN/K9i/0yTc30VtdDZioyTac49IA==

Am 24.01.25 um 00:13 schrieb Joshua Grisham:

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
>
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
>
> ---
>
> v1->v2:
> - Still allow acpi4_only_fst fans to update power state on
>    suspend/resume
> - Fix if / else if logic error
> - Also hide hwmon_power_input for acpi4_only_fst fans
> ---
>   drivers/acpi/fan.h       |  1 +
>   drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
>   drivers/acpi/fan_core.c  | 20 +++++++++++++++-----
>   drivers/acpi/fan_hwmon.c | 12 ++++++++++++
>   4 files changed, 50 insertions(+), 20 deletions(-)
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
> index 10016f52f..ca4785797 100644
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
> @@ -343,8 +355,6 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   		result =3D acpi_fan_create_attributes(device);
>   		if (result)
>   			return result;
> -
> -		fan->acpi4 =3D true;
>   	} else {

We still need to call acpi_device_update_power() if fan->acpi4_only_fst is=
 true.

I think you can do something like this:

	if (!fan->acpi4) {
		result =3D acpi_device_update_power(device, NULL);
	        if (result) {
	                dev_err(&device->dev, "Failed to set initial power state\=
n");
	                goto err_end;
	        }
	}

With this issue being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>   		result =3D acpi_device_update_power(device, NULL);
>   		if (result) {
> @@ -391,7 +401,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   err_unregister:
>   	thermal_cooling_device_unregister(cdev);
>   err_end:
> -	if (fan->acpi4)
> +	if (fan->acpi4 || fan->acpi4_only_fst)
>   		acpi_fan_delete_attributes(device);
>
>   	return result;
> @@ -401,7 +411,7 @@ static void acpi_fan_remove(struct platform_device *=
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

