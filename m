Return-Path: <linux-acpi+bounces-11479-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C244A44E07
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 21:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46E4189A3B0
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 20:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4119DFA2;
	Tue, 25 Feb 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R67vw2gR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCBDF59;
	Tue, 25 Feb 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516629; cv=none; b=ONk9PvqTBKLD02N3OBu7PiKGDQlMLrkbFShyM6nDTFZUWhmKyUWEhZ8PPw7yW3Gcaexl889lAJFEWpSt6jIV7Py6f5nHHyB3i3nHgMVVaDbnI9ZETc/8yURax47AVG2td5840gkbY/CYMpTzU2GBpwUaYYRjzcFdTpPH7H/X4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516629; c=relaxed/simple;
	bh=vtRCJwqdp9zS4j+w0TlDmDonUlNsFwY9t2l0HStLyBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDA01VicwQQ8OTl71HcoE2YlwhorUo5YYG81wL62ZpUG/1SII1KsF4PC896b6zp1dKLT5Hj76y67h/jMDrEML7F1GgRk7A1cL4hl/kQYL/eziqo9QK47FAcwgkndSstmBlfAl+5aIuTapdeT8rMbU3PVt/awx1FvVsSsyUMYxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R67vw2gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E62C4CEDD;
	Tue, 25 Feb 2025 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740516629;
	bh=vtRCJwqdp9zS4j+w0TlDmDonUlNsFwY9t2l0HStLyBc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R67vw2gR8RF6sMS0aYtzL1yHIiUrz2/FVhQ0KXF82sI+DNe5BkY6ds9XOpmT2Lm1b
	 qYJnziZTGyX2rJgk3N3l7ZxxErC5+PiMpqh353ttD3yVX1RB3f9Y3X+Er73OShHskT
	 MHyIgK3S/kKINoHz0M4JBRbsJ0fTunLsKeLMPtrrOW3w1A+U6rEKtuE9RRymlB0nuY
	 ZtyoEthUV0SImdUpHuRV99VhU9m5ybAly42VgPsm8Utn4omR1pWJwuJIJrmyfOXHPJ
	 exCiDg2KcBQQDHrSFZL01dOiEHuAxqdJZBxM5EvVyzkXqBtBgXik9bPW7LBRp6ia9l
	 9N5imA4WPqUnw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso4595536fac.1;
        Tue, 25 Feb 2025 12:50:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVE9aXk+O6NoDj5IIbtJLkJ/vccw3+8WteQsZGIK3khgpquP9oyE7ZVc5sSD0rTeExauCsUDiBs26Lv@vger.kernel.org, AJvYcCWjSfhfzSNJeiDyaUOGmLCMOS3WODtfT9E4kn4ysqmgPHOOjNMtre8DPqmj3WcuanDKxGH6ESxXn6YPDAG8@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsYGs+But7Bo8hFqOvYojzMV1sIFrJ2UIGPa5qA/mYIZE0znM
	x2c3hET1vIdOF7892TqgOGVEZ+kkn98nsblxc1MJoF5apsSnfMiI6aJhVCvgzHTRwdVYnvvsrsN
	qixJf5wF0BFZYdGixt3eC0UIY3Pc=
X-Google-Smtp-Source: AGHT+IEvmG0ZZQwhTFGZXwlFsTdMtw+z3EfkWIbUnaNNokv5w1cDV9bjlSMx7t6QmiID7s2Hx95FqETLM09/GSpDGow=
X-Received: by 2002:a05:6871:7a85:b0:29f:b1d4:7710 with SMTP id
 586e51a60fabf-2bd517c4946mr12577487fac.24.1740516628374; Tue, 25 Feb 2025
 12:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222094407.9753-1-josh@joshuagrisham.com>
In-Reply-To: <20250222094407.9753-1-josh@joshuagrisham.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Feb 2025 21:50:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iRzTuZ9x=biw1UtcrOdTwFhbH1kakHz6SKtksQfn-jOw@mail.gmail.com>
X-Gm-Features: AWEUYZm-9OaKhtwR12EAT9QLzKQzUPdTgZOXzF_EsrDOFkXUwM0G2XO1VtXbKWI
Message-ID: <CAJZ5v0iRzTuZ9x=biw1UtcrOdTwFhbH1kakHz6SKtksQfn-jOw@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI: fan: Add fan speed reporting for fans with only _FST
To: Joshua Grisham <josh@joshuagrisham.com>
Cc: rafael@kernel.org, lenb@kernel.org, W_Armin@gmx.de, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 10:44=E2=80=AFAM Joshua Grisham <josh@joshuagrisham=
.com> wrote:
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
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
> ---
>
> v1->v2:
> - Still allow acpi4_only_fst fans to update power state on
>   suspend/resume
> - Fix if / else if logic error
> - Also hide hwmon_power_input for acpi4_only_fst fans
>
> v2->v3:
> - Still allow acpi4_only_fst fans to set initial power state on probe
>
> v3->v4:
> - Small tweaks to naming (acpi4_only_fst became has_fst) and logic flow
>   based on feedback from Rafael
> - Built against next and tested working on Samsung Galaxy Book2 Pro
> ---
>  drivers/acpi/fan.h       |  1 +
>  drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
>  drivers/acpi/fan_core.c  | 25 ++++++++++++++++++-------
>  drivers/acpi/fan_hwmon.c |  8 ++++++++
>  4 files changed, 49 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index 488b51e2c..15eba1c70 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -49,6 +49,7 @@ struct acpi_fan_fst {
>
>  struct acpi_fan {
>         bool acpi4;
> +       bool has_fst;
>         struct acpi_fan_fif fif;
>         struct acpi_fan_fps *fps;
>         int fps_count;
> diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> index f4f6e2381..22d29ac24 100644
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
> +       if (!fan->acpi4)
> +               return 0;
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
> +       if (!fan->acpi4)
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
> index 10016f52f..8ad12ad3a 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -203,12 +203,16 @@ static const struct thermal_cooling_device_ops fan_=
cooling_ops =3D {
>   * ---------------------------------------------------------------------=
-----
>  */
>
> +static bool acpi_fan_has_fst(struct acpi_device *device)
> +{
> +       return acpi_has_method(device->handle, "_FST");
> +}
> +
>  static bool acpi_fan_is_acpi4(struct acpi_device *device)
>  {
>         return acpi_has_method(device->handle, "_FIF") &&
>                acpi_has_method(device->handle, "_FPS") &&
> -              acpi_has_method(device->handle, "_FSL") &&
> -              acpi_has_method(device->handle, "_FST");
> +              acpi_has_method(device->handle, "_FSL");
>  }
>
>  static int acpi_fan_get_fif(struct acpi_device *device)
> @@ -327,7 +331,12 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>         device->driver_data =3D fan;
>         platform_set_drvdata(pdev, fan);
>
> -       if (acpi_fan_is_acpi4(device)) {
> +       if (acpi_fan_has_fst(device)) {
> +               fan->has_fst =3D true;
> +               fan->acpi4 =3D acpi_fan_is_acpi4(device);
> +       }
> +
> +       if (fan->acpi4) {
>                 result =3D acpi_fan_get_fif(device);
>                 if (result)
>                         return result;
> @@ -335,7 +344,9 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
>                 result =3D acpi_fan_get_fps(device);
>                 if (result)
>                         return result;
> +       }
>
> +       if (fan->has_fst) {
>                 result =3D devm_acpi_fan_create_hwmon(device);
>                 if (result)
>                         return result;
> @@ -343,9 +354,9 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
>                 result =3D acpi_fan_create_attributes(device);
>                 if (result)
>                         return result;
> +       }
>
> -               fan->acpi4 =3D true;
> -       } else {
> +       if (!fan->acpi4) {
>                 result =3D acpi_device_update_power(device, NULL);
>                 if (result) {
>                         dev_err(&device->dev, "Failed to set initial powe=
r state\n");
> @@ -391,7 +402,7 @@ static int acpi_fan_probe(struct platform_device *pde=
v)
>  err_unregister:
>         thermal_cooling_device_unregister(cdev);
>  err_end:
> -       if (fan->acpi4)
> +       if (fan->has_fst)
>                 acpi_fan_delete_attributes(device);
>
>         return result;
> @@ -401,7 +412,7 @@ static void acpi_fan_remove(struct platform_device *p=
dev)
>  {
>         struct acpi_fan *fan =3D platform_get_drvdata(pdev);
>
> -       if (fan->acpi4) {
> +       if (fan->has_fst) {
>                 struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev)=
;
>
>                 acpi_fan_delete_attributes(device);
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> index bd0d31a39..e8d906051 100644
> --- a/drivers/acpi/fan_hwmon.c
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -43,6 +43,10 @@ static umode_t acpi_fan_hwmon_is_visible(const void *d=
rvdata, enum hwmon_sensor_
>                 case hwmon_fan_input:
>                         return 0444;
>                 case hwmon_fan_target:
> +                       /* Only acpi4 fans support fan control. */
> +                       if (!fan->acpi4)
> +                               return 0;
> +
>                         /*
>                          * When in fine grain control mode, not every fan=
 control value
>                          * has an associated fan performance state.
> @@ -57,6 +61,10 @@ static umode_t acpi_fan_hwmon_is_visible(const void *d=
rvdata, enum hwmon_sensor_
>         case hwmon_power:
>                 switch (attr) {
>                 case hwmon_power_input:
> +                       /* Only acpi4 fans support fan control. */
> +                       if (!fan->acpi4)
> +                               return 0;
> +
>                         /*
>                          * When in fine grain control mode, not every fan=
 control value
>                          * has an associated fan performance state.
> --

Applied as 6.15 material, thanks!

