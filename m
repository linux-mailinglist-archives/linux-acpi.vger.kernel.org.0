Return-Path: <linux-acpi+bounces-10796-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3651DA19BF2
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 01:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82D1188CC3F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869A68BF8;
	Thu, 23 Jan 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ab6EqD18"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01AF4C6D;
	Thu, 23 Jan 2025 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593410; cv=none; b=s+Lxw+0g/Lj9vgp/rRPGc3fR6NZULecK67hqeuJVMUaRONGevyoxz0jKJsWFaVVsA4DSxLKd9TMc+XcTCXApFclhtio3UrimVD2ebf8Rjqj2Kv4p/qS9F4YY4EN6+DN9FTecDDAE4CumDpkZtvifMhROf4qZxpbjibJOdag+I0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593410; c=relaxed/simple;
	bh=ABxt3fJMyYfFisGTVA0ANaJ8yVRgJiyxMDOBgpvtcx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S/6XN4w7V3KtrfzgSNgAbt/fuvvyqe53j+hX1fQ2snhtsIGPjJv/zLgO6YCCQnErR30P1dGjoEAKQ1SCZlcK5lInBtbu8zxCg+aTZ7Bi76e/+9mENQkCRQmNkfbllozishZ/d6OeJpgTbUPhuUBR5olfO5bth+Qqz5tFxsxyy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ab6EqD18; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737593390; x=1738198190; i=w_armin@gmx.de;
	bh=N0Jm8bDGwrnd6xuKyWuqwIWQVVEFJsNk3rEcCOj263s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ab6EqD18tINMQk+oN55RQeqCBcWgHd84PN3HSnq6V/i0raJer3Lq6QsfCwtuPfeI
	 /Kb/ffz21KwkEFrjZRDzoUR3PhpfHaODwMytZX7GIFlTfBg9ZA/CsO4M+vx3dqMcK
	 shqLCbz01wyYSOM5NGi5C+VafjbqFQ2enXWKM5Z2A3WPE/uxWjT6O8MoryB39oeM1
	 QE4+JP0zKYCDazrAoBZLX89VGPHSaSLDt3cdYwjpT2jIrQ86mJKmygHzEe7SzMCFJ
	 tSUYK5RmS3aTSwipjqgv1kVaKiYIwVPi5IBKuhHM0Mgvt6xIelsxz5k/0PfaW59BX
	 E9bCFhJgnci+3o0lww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.246.83]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mzyyk-1tGKeh4182-00wGtx; Thu, 23
 Jan 2025 01:49:50 +0100
Message-ID: <6c1dbd29-71fb-4714-a661-7539408874d3@gmx.de>
Date: Thu, 23 Jan 2025 01:49:49 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: fan: Add fan speed reporting for fans with only
 _FST
To: Joshua Grisham <josh@joshuagrisham.com>, rafael@kernel.org,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250114012150.156349-1-josh@joshuagrisham.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250114012150.156349-1-josh@joshuagrisham.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0R8G8rxSb9kDSexSrGTHCmT8g3lurRRq7h5Gd4lDSbHJIao3YnL
 +liYpNgHiJvGxrfNo6ayihDmj7hdvTVPz/NaBCiZFMMpkdjwCftM7RzCDKFGcYTkT4uqFzk
 uZEyFO3spgwJl0YPvHMF69N0d+iYIJE+5tco4bLXKT5Ss0T4Izn1FuZ3wRmwamphCeQJp1e
 zttI6N6KSzHrueMVplkgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fqMfM2mAsHQ=;8x13dz+WJI/C/cNRNeIJW9BTPut
 giPHkDBDCsc0rjcALSMkEZI40a+9DzYuZdYFA5SQSaPAxxF2JGUK09pUOeJWuShSdS73KE4hG
 MxD0dwHQDLTbPloV+7dNg8yXHGNvp55iVohV4L7be/x3Gou7gXSYucIo1gHVMsf24brzUTijU
 eXZviqACHNxv+uKHE1jxvTakOxm8X6VVwZrdeTDHCsOVHe3+lMV5bdb7UOF+y97cdSmVfenkd
 SYgs/oN6mRe+vmU2HUF7/9Lqr0H4WSKss2i8Bh9oniiU/1sf5aH1GhpiD8nWCujgFSYWm4exJ
 wD0yxPG1C9qQxA8NaMxuRmron/U9VFRQsn0BfwCPKJ4Jy3ERZF837c6jVs4joxLWyz83pTC94
 zmTxpnBJfLINYIyjRye7VdZmt9hE+VCpPgPXQuAZp/CZjq2zrTvZcmvRmT6+R61HuIzTt86ys
 M9FXlauulU909g2RpCxkE+bS5QZ0ZzxgoCSPK2vbkdaD+22hqxNH5qqwpQjuB5iqRCmYwQwnc
 2ZoVHQWY31+wmsK4aBy6yOjauSQUbwwYcKr3P9AZGB9Lqi6aa0KkTrSR+Ex2R8C+mVOPHhHdH
 juRZAI6zER0zqUfGBuV1Bz0uexXpL9n5p/pt341y3QnbHmHNVAOnJ5CYqOKT1vZP83OJ6MRKr
 y5qcCRAAkCz8mGu2g69Pd6sjFhqITiUCYeTBcTjDbKGlVDL4sO+Ev93Jdlyy51+Ux1h28Mb76
 qGjoQmcETalMo3HGDbMpXUA+IOYsQ/2asehbpdHR0BiuoW3kqQyimTOZ0h7hfPZnmJ4CI1o3T
 aqye/bzXOTT+wFCYcgWoNH9RV7KXa7LUonPAmgmW9fMPTb66UZhI+pSEflMf953m51t61G1v6
 9ceDwyjmPq7u4MYirwGtfVdYpaoxwlVcrvuLGTebZLyn+KwLzRRPWPT8ag2dOo/kKkEGq8uc4
 HznLWaKEU+bnIulpF/WNQNKJqQCg9rXmvFtoHemiv0ERH0CTutLgIrQjYCl4NAjkEuWB3n7NS
 kwhKv7hydO+xVzJHKdnfdEHW7njATfQoDawc3smpYDIGQD7v09kXFxwYAnhSYzNxWLU96Lc/H
 6tusJ4dF+zYYHd/ecPVEv4LYpoWf1982oAOqsHJOTzlOleewcV0laU+U2C/vpuCYjGiWc2Dh+
 96eF1cARgK1mMf7Z2jr5OBToHD41XPjDrshOG1TaZUs1O7qShbHccnx1JNZNP8TLjbxNVBk8S
 kCnyJbCLCgfx2IgKCO/j3WE7oa389mVgpzeNweNS4nNKYUnzPwm3I1EI+pldG8h9w0s4SnMka
 CpOxHyHd3/BPR0a0GgyCfGAL1sB7KkzxPR+w6KwCmraS/V0PCBNjNteQSJ2Lg6FDSQ1slDJCh
 19kQGmry8E2UBf1g==

Am 14.01.25 um 02:21 schrieb Joshua Grisham:

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
> ---
>   drivers/acpi/fan.h       |  1 +
>   drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
>   drivers/acpi/fan_core.c  | 24 ++++++++++++++++--------
>   drivers/acpi/fan_hwmon.c |  6 ++++++
>   4 files changed, 45 insertions(+), 23 deletions(-)
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
> index 10016f52f..b51b1481c 100644
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
> @@ -335,7 +345,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   		result =3D acpi_fan_get_fps(device);
>   		if (result)
>   			return result;
> -
> +	} else if (fan->acpi4 || fan->acpi4_only_fst) {

Hi,

this will not register any attributes or the hwmon interface if "fan->acpi=
4" is true.

I think the "else" is misplaced here.

>   		result =3D devm_acpi_fan_create_hwmon(device);
>   		if (result)
>   			return result;
> @@ -343,8 +353,6 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   		result =3D acpi_fan_create_attributes(device);
>   		if (result)
>   			return result;
> -
> -		fan->acpi4 =3D true;
>   	} else {
>   		result =3D acpi_device_update_power(device, NULL);
>   		if (result) {
> @@ -391,7 +399,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   err_unregister:
>   	thermal_cooling_device_unregister(cdev);
>   err_end:
> -	if (fan->acpi4)
> +	if (fan->acpi4 || fan->acpi4_only_fst)
>   		acpi_fan_delete_attributes(device);
>
>   	return result;
> @@ -401,7 +409,7 @@ static void acpi_fan_remove(struct platform_device *=
pdev)
>   {
>   	struct acpi_fan *fan =3D platform_get_drvdata(pdev);
>
> -	if (fan->acpi4) {
> +	if (fan->acpi4 || fan->acpi4_only_fst) {
>   		struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
>
>   		acpi_fan_delete_attributes(device);
> @@ -415,7 +423,7 @@ static void acpi_fan_remove(struct platform_device *=
pdev)
>   static int acpi_fan_suspend(struct device *dev)
>   {
>   	struct acpi_fan *fan =3D dev_get_drvdata(dev);
> -	if (fan->acpi4)
> +	if (fan->acpi4 || fan->acpi4_only_fst)
>   		return 0;
>
>   	acpi_device_set_power(ACPI_COMPANION(dev), ACPI_STATE_D0);
> @@ -428,7 +436,7 @@ static int acpi_fan_resume(struct device *dev)
>   	int result;
>   	struct acpi_fan *fan =3D dev_get_drvdata(dev);
>
> -	if (fan->acpi4)
> +	if (fan->acpi4 || fan->acpi4_only_fst)
>   		return 0;

The Windows design guide says:

	"A fan that implements the _FST object is not required to be in a thermal
	zone's _ALx device list, but it can, as an option, be in this list.
	This option enables a hybrid solution in which a fan is typically
	controlled by a third-party driver, but can be controlled by the OS
	thermal zone if the third-party driver is not installed. If a fan is in
	an _ALx device list and is engaged by the thermal zone (placed in D0),
	the _FST object is required to indicate a nonzero Control value."

Because this i think the suspend/resume path should still change the power=
 state of the fan device.

>
>   	result =3D acpi_device_update_power(ACPI_COMPANION(dev), NULL);
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> index bd0d31a39..87bee018c 100644
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

The same needs to be done for hwmon_power_input, since currently the code =
assumes that the _FIF
ACPI control method is always present.

Other than that the patch looks promising.

Thanks,
Armin Wolf

> +
>   			/*
>   			 * When in fine grain control mode, not every fan control value
>   			 * has an associated fan performance state.

