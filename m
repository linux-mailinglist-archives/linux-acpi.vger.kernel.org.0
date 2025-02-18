Return-Path: <linux-acpi+bounces-11257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D233A3A327
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CCC167ED0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555A26E169;
	Tue, 18 Feb 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbF7bTxe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE07246348;
	Tue, 18 Feb 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897344; cv=none; b=gQ1IHiTek8OEXBbCmHWEj6VjRO+qgXYkgytNw4m2hUx7hHJhKZ4tK6lONaJY+UdLVaqHrBj8avuE8IX6yxizw9ioc7juqMn8KdxMmqmp5G7EnUo5rsICtPfRiCBdcwCEd9MYj6tnpgbk/zpWYCoitwKQ3d7SXJWSDT5dwWHtp4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897344; c=relaxed/simple;
	bh=70vk182ZryBKCdHzSaUze+kgPpHosvg75qd9B7Wp+P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMBiqVIbovnX/uIYRn5RBefrBxzqWE/odVwlIatLYhJwUD+1J77SKKumLRR1kCFy25w7wqevEKdvuACKqbk34MJDWkTO3lGsoEeZEay3kqKiUM9UGs8N+k8Gm26O+KnVptyC5kd1+lJDk/gg56/gWwK2fqGmFoyzXkq3tT07a14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbF7bTxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB57C4CEE2;
	Tue, 18 Feb 2025 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739897343;
	bh=70vk182ZryBKCdHzSaUze+kgPpHosvg75qd9B7Wp+P8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DbF7bTxezRJgnYmAfYwTiYJEP+r+cGOHeOC0kRO+7P85S36S71QBqlZ39akcgYuif
	 Dx2N+rvmNdG/Py4ubUx82GtqXZaEA468Gcbk75OJjhyYopxDQUuITkxgRhW/BjN2+i
	 r4N4LvXRdtfgCjR0d9BasmDDz4pirYq5D2EUXYJxOVpvGihyVfLNPIpqr9/6h0skYu
	 cUQ+hv6W2O7lvfBxPZEpl5EJ2HZpp0OnM+woJfXnemWbqZhdcbgCw7So+XOIB/jWhp
	 jJM3UIBpHPOPFqWLBZFFuQ3E5YAbiMe6X8YuUUBLjqf1SpvIdvmRbIptU7K2qsKqNm
	 RzGYHywd6563Q==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fa9778fa2cso2941209eaf.0;
        Tue, 18 Feb 2025 08:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSMBc4i8qmPty4RAod8h0GL7Dqt7xHeP/nmV34BHCwgbmE4orMPbZZjGHAiJ2zs1lmx8eDFSaXQLJYkDxq@vger.kernel.org, AJvYcCVqCxZVqEl8cf17M3BtD60DQskVm5y8ZTUdDXw3G84SlY0pPxZoFvuAYKZjnkXIdXyGjDJcQbqCzVid@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcCOuweCc3qkA7GenZP/bdjtkyZidlCCW7hk0I2mukZkiYhoZ
	uLC7LbaPAXo4IqaPWrcO5+hbwmfPtSG1tIuxSSXLLRWK6QbVYme5h2olvDj0oruoRT/fQg+XlQ4
	ojoMjETNTtBmQ505/V/XV8AT4TX4=
X-Google-Smtp-Source: AGHT+IGhTrJxqZyzgUpjJ3g+B+eV2El3RfrCy8z3+YxMae1hFsgpIP0MmbzKooMojC/YY9QwF0P6VIYT10rqR5qIPwE=
X-Received: by 2002:a05:6870:b623:b0:297:23cf:d3db with SMTP id
 586e51a60fabf-2bc99dcc23fmr9354558fac.37.1739897342870; Tue, 18 Feb 2025
 08:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114012150.156349-1-josh@joshuagrisham.com>
In-Reply-To: <20250114012150.156349-1-josh@joshuagrisham.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 17:48:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jtL7jVOhtfvFgussKMH9iYPhQAM2sLopp_dMVa9umhUw@mail.gmail.com>
X-Gm-Features: AWEUYZni0LuSVzAETxq4vOQ8o237nPN-NY5OeHLoltWrfzyiMcsQXdICzNPWAgk
Message-ID: <CAJZ5v0jtL7jVOhtfvFgussKMH9iYPhQAM2sLopp_dMVa9umhUw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Add fan speed reporting for fans with only _FST
To: Joshua Grisham <josh@joshuagrisham.com>
Cc: rafael@kernel.org, lenb@kernel.org, W_Armin@gmx.de, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:22=E2=80=AFAM Joshua Grisham <josh@joshuagrisham.=
com> wrote:
>
> Add support for ACPI fans with _FST to report their speed even if they do
> not support fan control.
>
> As suggested by Armin Wolf [1] and per the Windows Thermal Management
> Design Guide [2], Samsung Galaxy Book series devices (and possibly many
> more devices where the Windows guide was strictly followed) only implemen=
t
> the _FST method and do not support ACPI-based fan control.
>
> Currently, these fans are not supported by the kernel driver but this pat=
ch
> will make some very small adjustments to allow them to be supported.
>
> This patch is tested and working for me on a Samsung Galaxy Book2 Pro who=
se
> DSDT (and several other Samsung Galaxy Book series notebooks which
> currently have the same issue) can be found at [3].
>
> [1]: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-=
463912dd966d@gmx.de
> [2]: https://learn.microsoft.com/en-us/windows-hardware/design/device-exp=
eriences/design-guide
> [3]: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e30=
87a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt
>
> Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> ---
>  drivers/acpi/fan.h       |  1 +
>  drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
>  drivers/acpi/fan_core.c  | 24 ++++++++++++++++--------
>  drivers/acpi/fan_hwmon.c |  6 ++++++
>  4 files changed, 45 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index 488b51e2c..d0aad88a7 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -49,6 +49,7 @@ struct acpi_fan_fst {
>
>  struct acpi_fan {
>         bool acpi4;
> +       bool acpi4_only_fst;

I would use has_fst instead of this, that is

+       bool has_fst;

which would be true when acpi4 is true, but not necessarily the other
way around.

>         struct acpi_fan_fif fif;
>         struct acpi_fan_fps *fps;
>         int fps_count;
> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> index f4f6e2381..d83f88429 100644
> --- a/drivers/acpi/fan_attr.c
> +++ b/drivers/acpi/fan_attr.c
> @@ -75,15 +75,6 @@ int acpi_fan_create_attributes(struct acpi_device *dev=
ice)
>         struct acpi_fan *fan =3D acpi_driver_data(device);
>         int i, status;
>
> -       sysfs_attr_init(&fan->fine_grain_control.attr);
> -       fan->fine_grain_control.show =3D show_fine_grain_control;
> -       fan->fine_grain_control.store =3D NULL;
> -       fan->fine_grain_control.attr.name =3D "fine_grain_control";
> -       fan->fine_grain_control.attr.mode =3D 0444;
> -       status =3D sysfs_create_file(&device->dev.kobj, &fan->fine_grain_=
control.attr);
> -       if (status)
> -               return status;
> -
>         /* _FST is present if we are here */
>         sysfs_attr_init(&fan->fst_speed.attr);
>         fan->fst_speed.show =3D show_fan_speed;
> @@ -92,7 +83,19 @@ int acpi_fan_create_attributes(struct acpi_device *dev=
ice)
>         fan->fst_speed.attr.mode =3D 0444;
>         status =3D sysfs_create_file(&device->dev.kobj, &fan->fst_speed.a=
ttr);
>         if (status)
> -               goto rem_fine_grain_attr;
> +               return status;
> +
> +       if (fan->acpi4_only_fst)
> +               return 0;

So the above may become

if (!fan->acpi4)
    return 0;

> +
> +       sysfs_attr_init(&fan->fine_grain_control.attr);
> +       fan->fine_grain_control.show =3D show_fine_grain_control;
> +       fan->fine_grain_control.store =3D NULL;
> +       fan->fine_grain_control.attr.name =3D "fine_grain_control";
> +       fan->fine_grain_control.attr.mode =3D 0444;
> +       status =3D sysfs_create_file(&device->dev.kobj, &fan->fine_grain_=
control.attr);
> +       if (status)
> +               goto rem_fst_attr;
>
>         for (i =3D 0; i < fan->fps_count; ++i) {
>                 struct acpi_fan_fps *fps =3D &fan->fps[i];
> @@ -109,18 +112,18 @@ int acpi_fan_create_attributes(struct acpi_device *=
device)
>
>                         for (j =3D 0; j < i; ++j)
>                                 sysfs_remove_file(&device->dev.kobj, &fan=
->fps[j].dev_attr.attr);
> -                       goto rem_fst_attr;
> +                       goto rem_fine_grain_attr;
>                 }
>         }
>
>         return 0;
>
> -rem_fst_attr:
> -       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> -
>  rem_fine_grain_attr:
>         sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.att=
r);
>
> +rem_fst_attr:
> +       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> +
>         return status;
>  }
>
> @@ -129,9 +132,13 @@ void acpi_fan_delete_attributes(struct acpi_device *=
device)
>         struct acpi_fan *fan =3D acpi_driver_data(device);
>         int i;
>
> +       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> +
> +       if (fan->acpi4_only_fst)
> +               return;
> +
>         for (i =3D 0; i < fan->fps_count; ++i)
>                 sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_att=
r.attr);
>
> -       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
>         sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.att=
r);
>  }
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 10016f52f..b51b1481c 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -211,6 +211,11 @@ static bool acpi_fan_is_acpi4(struct acpi_device *de=
vice)
>                acpi_has_method(device->handle, "_FST");
>  }
>
> +static bool acpi_fan_has_fst(struct acpi_device *device)
> +{
> +       return acpi_has_method(device->handle, "_FST");
> +}
> +
>  static int acpi_fan_get_fif(struct acpi_device *device)
>  {
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -327,7 +332,12 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>         device->driver_data =3D fan;
>         platform_set_drvdata(pdev, fan);
>
> -       if (acpi_fan_is_acpi4(device)) {
> +       if (acpi_fan_is_acpi4(device))
> +               fan->acpi4 =3D true;
> +       else if (acpi_fan_has_fst(device))
> +               fan->acpi4_only_fst =3D true;

And here one could do

    if (acpi_fan_has_fst(device)) {
        fan->has_fst =3D true;
        fan->acpi4 =3D acpi_fan_is_acpi4(device);
    }

and if I'm not mistaken, the check for _FST presence could be dropped
from acpi_fan_is_acpi4().

> +
> +       if (fan->acpi4) {
>                 result =3D acpi_fan_get_fif(device);
>                 if (result)
>                         return result;
> @@ -335,7 +345,7 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
>                 result =3D acpi_fan_get_fps(device);
>                 if (result)
>                         return result;
> -
> +       } else if (fan->acpi4 || fan->acpi4_only_fst) {

Then, all of the checks like the above could be replaced with
fan->has_fst checks.

>                 result =3D devm_acpi_fan_create_hwmon(device);
>                 if (result)
>                         return result;
> @@ -343,8 +353,6 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
>                 result =3D acpi_fan_create_attributes(device);
>                 if (result)
>                         return result;
> -
> -               fan->acpi4 =3D true;
>         } else {
>                 result =3D acpi_device_update_power(device, NULL);
>                 if (result) {
> @@ -391,7 +399,7 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
>  err_unregister:
>         thermal_cooling_device_unregister(cdev);
>  err_end:
> -       if (fan->acpi4)
> +       if (fan->acpi4 || fan->acpi4_only_fst)
>                 acpi_fan_delete_attributes(device);
>
>         return result;
> @@ -401,7 +409,7 @@ static void acpi_fan_remove(struct platform_device *p=
dev)
>  {
>         struct acpi_fan *fan =3D platform_get_drvdata(pdev);
>
> -       if (fan->acpi4) {
> +       if (fan->acpi4 || fan->acpi4_only_fst) {
>                 struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev)=
;
>
>                 acpi_fan_delete_attributes(device);
> @@ -415,7 +423,7 @@ static void acpi_fan_remove(struct platform_device *p=
dev)
>  static int acpi_fan_suspend(struct device *dev)
>  {
>         struct acpi_fan *fan =3D dev_get_drvdata(dev);
> -       if (fan->acpi4)
> +       if (fan->acpi4 || fan->acpi4_only_fst)
>                 return 0;
>
>         acpi_device_set_power(ACPI_COMPANION(dev), ACPI_STATE_D0);
> @@ -428,7 +436,7 @@ static int acpi_fan_resume(struct device *dev)
>         int result;
>         struct acpi_fan *fan =3D dev_get_drvdata(dev);
>
> -       if (fan->acpi4)
> +       if (fan->acpi4 || fan->acpi4_only_fst)
>                 return 0;
>
>         result =3D acpi_device_update_power(ACPI_COMPANION(dev), NULL);
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> index bd0d31a39..87bee018c 100644
> --- a/drivers/acpi/fan_hwmon.c
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -43,6 +43,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *d=
rvdata, enum hwmon_sensor_
>                 case hwmon_fan_input:
>                         return 0444;
>                 case hwmon_fan_target:
> +                       /*
> +                        * Fans with only _FST do not support fan control=
.
> +                        */

Nit: One-line comment here, please.

> +                       if (fan->acpi4_only_fst)

And this would become

   if (!fan->acpi4)

> +                               return 0;
> +
>                         /*
>                          * When in fine grain control mode, not every fan=
 control value
>                          * has an associated fan performance state.
> --

