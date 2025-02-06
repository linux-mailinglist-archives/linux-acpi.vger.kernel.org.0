Return-Path: <linux-acpi+bounces-10905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D9A29FDA
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 06:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08F3161E85
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 05:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B491F9A8B;
	Thu,  6 Feb 2025 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CPXLWlzI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C01F9410;
	Thu,  6 Feb 2025 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738818334; cv=none; b=PVzHpKXYKm9+no0/7m2r0lPGmbmfz9TUriBAANos0MeEG0hbwMhtCOMAI/bYeucykZKS4IFlU3H9tiqyW+j8iT5uy2cY8Ty2unh04OFzRsy8+mn0NNzHs83ztUrHvFDL9P6H4hWcx/2MbQonVL4Hgp5z6IMFCbBC6/aaOw3D+3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738818334; c=relaxed/simple;
	bh=mJ+oQkttQU4lYx4He7hAeXUHiGX4yguSdmijjHmrbfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uAbemGwG3oTuHdpPUfKd8bPG5djaXAxmiV8tqVCaEqgAeMK5Tl1DXhW7ISOGwhjAvk8K1qXtflkj1OPGVDfT10svaMUKY6FEVjvv2xemz2sqbmqpaWa950AHQYfgRzircoQx1m4s8Ggg6xHX7JKs/7FoCZBjWYgc+b7qM6gyZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CPXLWlzI; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1738818316; x=1739423116; i=w_armin@gmx.de;
	bh=aveMVTFIWGiuNkWGizWBMa6mFY9A6nDWcg4mwkBA3q4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CPXLWlzI9ilMSCEROZev5XN2OvrPL41oSh+0wRSgLLBngBjD5z3N1WtJ0oK+EWwE
	 YV4OVrqHHEm/OEvtuxrxpzvyTDUeJiPOS9zC+uIIoVYYuVlfXeiSQK/91Ae9Fs8lC
	 Vmc+g3Jk1FMsNWbnF1vkRkA138OGCgF/ZOQstGCL2hMd6T9RL/7uDhcn4NMnAHnSf
	 eUdYMc93tKJY+yLaQQqPZCMonVlVc8CUHQz8GhxJO+nmabR1qvzIltAZXMNrTwb05
	 vN7ynetAiW/NuykYmzuo/6H1s2SvmlDxh35UYvXomQcdHEAxLWU8jTqsQCsYIIdyD
	 aa53IKKvdgMNFH2D2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([91.14.238.232]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1u2fl90HCd-00WTAp; Thu, 06
 Feb 2025 06:05:16 +0100
Message-ID: <77eb01a6-2905-4776-96ce-eb936c04956b@gmx.de>
Date: Thu, 6 Feb 2025 06:05:15 +0100
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
X-Provags-ID: V03:K1:SzDmCk7fs0Y6xe4GVtJLjeOg3kmATnuGWC461xyAqSqEbom9wI5
 y9UjuGWC0L3OGdMNS//qPN+dR/g2Gtlv+ElT7Baw/9SVOU9oPd7hlkt32EbV8InT5DWP8nR
 6aIQLG6Rf8/3eiemwBvnz0h2IkJP6JLw2LaApvnlvB8acuzvKJYyws85388y9cQmYHUrIwW
 MMmGAg5xBg2IYHuX7aiQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OT1V5dlL/fM=;RvBP5JpoJ6rntTP9/aKS2yHbzLj
 hQUeGAZuu9fHaz2badJhgRddQ77sJuEycqzRSq4z2Z+GUWftms9cRfl+rT4QOu9OtmGma13wC
 KQEk1B7beHDNilFduHA9tkFR8BAvCZgwNkgaPaVHVMdN+iKL05/nQoxFSDQVmILmnr9ukvyh0
 i+qrdjbsuxDZLdaKrPgR+sbCMHS66llZsJXh/humw+V+3s+RnKiD1WgHND46qrdZ7AJEOEYq8
 VBjdAy+Tg0+CMd9ZWiIW5L3uolbB79XoyrMcPdvvDQchX86u18pbf+14JiU7F3EQos06fHdfQ
 RcFuJmupwfj051li126hiRu7SJJH28+pQRoCj5hPZfocWjpuE5aglh1HTnYo5oUrNGOKX382G
 2cvEp80eDiPtQy6lAge05vxx6DDByIvy7HhagXwqfppRB6dsUZMXbR3cXkSrt9p2tvb4CMad1
 rqbD/udr7DsZFp8XN0nLyarPlzKs/6E7tR/OViUJEtsUmMLBVUPxYPx1scpKKkjhhZUhOGTlM
 yUuapKxQnVEUD5qOqBUqWdOD2vtdrriktN7oVzSSuyMGsFKmw/snnrH+K29wsLmoW3Q5U99++
 0XnW2GAdaXhKMIivyGjTK3YuMd5vywDACd3h2yvDpcDnLL1lrQc4CC/1lEJdT2HrevUoO8NEO
 McSa+Hb64Awd3fY2Dvw0pO+8+GXPgYjbfOrZ5Qrjkgp7nUbvP9qpejGTi4dfZNhJnu4fIvdz5
 Pxgowkel7vzLXNQISvpyRjqHYI9XbR+WpTAyBVjgPwgRqjtqsu95Ij34y3XVeijZZdwzvp16A
 2C7buuqPLbAo8QkwPpE9Kca0fj9uTk5R7EXVT6MhC6qu2NXSc0XV6EK6xtltEV2C+1DW9zAS0
 g91dcBjK4jlCfEowj6FBi/rBxq8fpoL28DC4KdORnxAv8DE7qq+XNl+fqgl4tb7hfkojlwjdM
 uri4DEczwc0iMQyMjoIaH+cW+u+6SpwePetsWJHwjU+KI2/n++vjGzjg01MosrKUgZCFyS6Ls
 +8UQlqkfFJwoByq+Hn7VCIBkiKlNgcFVyER8yRZXmym67QJ1MiXEojE/Euqbtprl+bb3xBmbZ
 FtANqd1Xue2jqec5BWhyEiT9dMAb4r3IKK+CJZq/GCHR9zm1al//mr5JJtfFdyQZf3GhDQc6n
 JAkQAKHRwPJM51bj1cLlEQzDsqz61xZmeHq7dGTR29LeB6sWfweTkIRO3bNlsSorp8R3XwjvH
 GRbZYYV8fUXErIudRiUm8HjTwwuKvtmGE2u0iCL7kA8+ODDpG+Bkg7+TdUpvXoDDrJe5Dm/Qg
 c17l5yH8KUdP8LemuSRuKhRnyNE1nkh00UvwrCicpH90mntU8QrhyKyxLqY4/QP9/QNAkDT8P
 WftEWl4wuNyunEvw==

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

Any updates on this patch? For me it seems ready for mainline.

Thanks,
Armin Wolf

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

