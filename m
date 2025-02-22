Return-Path: <linux-acpi+bounces-11381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6288DA4067B
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 09:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785221889D0C
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2025 08:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87702063FA;
	Sat, 22 Feb 2025 08:54:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D21EDA17;
	Sat, 22 Feb 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740214472; cv=none; b=ICLU/5ZTL2h0bKczQBrOup6uRcDS8NzniNlcRVDNOtK5yfw8tXbFsCGj2A5RpwwYKiKAAyA7ymz0PFj5QD6xHQrOjBv8JkrLhjKR5Wqx4Gr5HFnwaEGPB5qlTjvKmL0iiaw7S6Kxk7m0lYGP9iSrTKWVj+Z5mBxQqi4V9q3I9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740214472; c=relaxed/simple;
	bh=y03+8Amb55vyjakMJsan6unDUiExc0DmdYzj9NgCVoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGR2iF0BcKqBxPJxtzbxFW6B2GPkkc2LFeiF6ygUyRaIVgnkqsaHR/PiVJk+0aX5dfJkCRvNW0OzGT9lX5cYUtM0jXpie6UO2J1+0+6DaHe76Va1yPxHvKFoAZ+uViQUPPRhXb4qJT1upkbjM7UgRMWFtq+znCBSxm9S4WH7O0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso6497885ab.0;
        Sat, 22 Feb 2025 00:54:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740214470; x=1740819270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7Y7rtrUUJ3txbV45HQjYW+7UesPZ6YSFJYoB7i32SY=;
        b=GGmo26q/EYgvbmr7QQ3RHxXpghRW0UcFOCItsnjRdbiGD0vGibBe7hNcOfN5/AE0tD
         GonBFhoYN/D/AagWrayUq5f/LI/283E5Ip4p5p3WCReYE8JzErvD+4jZRuldNYbDSQOz
         FZ/vQi+dBnR1yAee7+M/EhrbtHw+3WQvVvwKuKbEsF64EVIq8Amf3xERby6Y852CGMYL
         /rnckk9XNAWHd7IEWeE7udCaCqWU/RrnaunYrI/tl7nLnHvSlFvAPan6yNlBDZ1ynx8L
         P06KeUzKNjj6SjJeTg741RM6Dpi1AxRdBH7K2fC14JxjDUtbxTKUpUGU9CN65398CHmn
         oK5w==
X-Forwarded-Encrypted: i=1; AJvYcCVXkDKDmCTr7jqSKAXbiC7A8yNnmvmdv9fQ2nrBagLsr/suq7HUyLYtHhNxtOCTjpLqeY95YgCuMyz9@vger.kernel.org, AJvYcCW39yt5I1WfPGIVAx6zAyReS089iGogMaDYcd7ii24/csdK3xICeq3A0nl+KT6dCu4Ff0ZFccFpUl06D/0U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1fNDbNREfTRkSmi31d+xg178KA1FnZ8K1qk2KnYrKcIGXdpQj
	pLcB7/caSr+tCC+Mi6QZ3yQ8yB5scXFCuK8cEH1BUymSjikHG72CM1pi2DaA
X-Gm-Gg: ASbGncuDeYJlzmAOvTwAnPXV8pTv+JCb4bu/H+YyW1PRHjcB9b+GrNalysDaC19sUvb
	+pIrpw4RtUy8a/WXuYVchQ5hqKAPd/Q7jzKXXrscLR/aqJkNx+yeub5GZ/qiIkJG88ln9N6Qzn+
	TMEl3pqNpeFVRf7dLY5joqugI/NDqFWaQAh3L2wmDwFLKGov0Yx88K26jLLGdXxwCjzE4lV355g
	UYuYg9OyVadyDPIVV+1XRXxuGEniMxLbF2ZXMJLrLCpW6xTpLzf2d8Rg8aBV+YBM0/HDwzLrqpq
	lKiyba9okR0O7iBT6KIa6GF8C2dwaiCYhdEv4ZSr2M39SiVyJVKZ3yMWwG+G9Q9ZzLE=
X-Google-Smtp-Source: AGHT+IH6byGuTHH/i//bzVxUFmQ1Vv84cAknVMvl2qJf9W8PNv/13di8o81zLqva6vz1BuWCWMdxmQ==
X-Received: by 2002:a05:6e02:184a:b0:3d1:8d64:97fa with SMTP id e9e14a558f8ab-3d2cae69b17mr46219445ab.10.1740214469667;
        Sat, 22 Feb 2025 00:54:29 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee9e46dcd2sm2704415173.110.2025.02.22.00.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 00:54:28 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-851c4f1fb18so139155739f.2;
        Sat, 22 Feb 2025 00:54:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV80SkmrrhCX2YrOJByiRD8DYfspOhUMpmC5qcuHbzdWjRffUfrFfMAi665rQ71XL/evBajJKfNJYv+@vger.kernel.org, AJvYcCWRz01nvEvEZ7WnhlCewwVi/Avfc9xbEQzsHaBghdvrKE5GGcNK9DK57TFKRX48wQ2Cflc99NSJhBJLyP7O@vger.kernel.org
X-Received: by 2002:a92:c26c:0:b0:3d0:4700:db0f with SMTP id
 e9e14a558f8ab-3d2cae875cemr74607425ab.12.1740214468474; Sat, 22 Feb 2025
 00:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114012150.156349-1-josh@joshuagrisham.com> <CAJZ5v0jtL7jVOhtfvFgussKMH9iYPhQAM2sLopp_dMVa9umhUw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jtL7jVOhtfvFgussKMH9iYPhQAM2sLopp_dMVa9umhUw@mail.gmail.com>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Sat, 22 Feb 2025 09:54:17 +0100
X-Gmail-Original-Message-ID: <CAMF+Kea0g1W=P92mNUcimGHXfMbBq=dmpoQ50cheaSHFaZrirg@mail.gmail.com>
X-Gm-Features: AWEUYZkp5zcOOXozVxzELD1SC_NZd9RmvzzhVour4FONgnxrkizwcZmgHkYd6Ok
Message-ID: <CAMF+Kea0g1W=P92mNUcimGHXfMbBq=dmpoQ50cheaSHFaZrirg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Add fan speed reporting for fans with only _FST
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, W_Armin@gmx.de, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rafael, thanks for taking a look! Comments/questions inline below... :)

Den tis 18 feb. 2025 kl 17:49 skrev Rafael J. Wysocki <rafael@kernel.org>:
>
> On Tue, Jan 14, 2025 at 2:22=E2=80=AFAM Joshua Grisham <josh@joshuagrisha=
m.com> wrote:
> >
> > Add support for ACPI fans with _FST to report their speed even if they =
do
> > not support fan control.
> >
> > As suggested by Armin Wolf [1] and per the Windows Thermal Management
> > Design Guide [2], Samsung Galaxy Book series devices (and possibly many
> > more devices where the Windows guide was strictly followed) only implem=
ent
> > the _FST method and do not support ACPI-based fan control.
> >
> > Currently, these fans are not supported by the kernel driver but this p=
atch
> > will make some very small adjustments to allow them to be supported.
> >
> > This patch is tested and working for me on a Samsung Galaxy Book2 Pro w=
hose
> > DSDT (and several other Samsung Galaxy Book series notebooks which
> > currently have the same issue) can be found at [3].
> >
> > [1]: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937=
f-463912dd966d@gmx.de
> > [2]: https://learn.microsoft.com/en-us/windows-hardware/design/device-e=
xperiences/design-guide
> > [3]: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e=
3087a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt
> >
> > Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> > ---
> >  drivers/acpi/fan.h       |  1 +
> >  drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
> >  drivers/acpi/fan_core.c  | 24 ++++++++++++++++--------
> >  drivers/acpi/fan_hwmon.c |  6 ++++++
> >  4 files changed, 45 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> > index 488b51e2c..d0aad88a7 100644
> > --- a/drivers/acpi/fan.h
> > +++ b/drivers/acpi/fan.h
> > @@ -49,6 +49,7 @@ struct acpi_fan_fst {
> >
> >  struct acpi_fan {
> >         bool acpi4;
> > +       bool acpi4_only_fst;
>
> I would use has_fst instead of this, that is
>
> +       bool has_fst;
>
> which would be true when acpi4 is true, but not necessarily the other
> way around.
>

No problem at all with this, I actually struggled a lot with what to
call this (or to change the flag to use different bits instead even
but did not want to rock the boat tooooo much ;) ) .. I still think
naming is probably one of the hardest things in software!

> >         struct acpi_fan_fif fif;
> >         struct acpi_fan_fps *fps;
> >         int fps_count;
> > diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> > index f4f6e2381..d83f88429 100644
> > --- a/drivers/acpi/fan_attr.c
> > +++ b/drivers/acpi/fan_attr.c
> > @@ -75,15 +75,6 @@ int acpi_fan_create_attributes(struct acpi_device *d=
evice)
> >         struct acpi_fan *fan =3D acpi_driver_data(device);
> >         int i, status;
> >
> > -       sysfs_attr_init(&fan->fine_grain_control.attr);
> > -       fan->fine_grain_control.show =3D show_fine_grain_control;
> > -       fan->fine_grain_control.store =3D NULL;
> > -       fan->fine_grain_control.attr.name =3D "fine_grain_control";
> > -       fan->fine_grain_control.attr.mode =3D 0444;
> > -       status =3D sysfs_create_file(&device->dev.kobj, &fan->fine_grai=
n_control.attr);
> > -       if (status)
> > -               return status;
> > -
> >         /* _FST is present if we are here */
> >         sysfs_attr_init(&fan->fst_speed.attr);
> >         fan->fst_speed.show =3D show_fan_speed;
> > @@ -92,7 +83,19 @@ int acpi_fan_create_attributes(struct acpi_device *d=
evice)
> >         fan->fst_speed.attr.mode =3D 0444;
> >         status =3D sysfs_create_file(&device->dev.kobj, &fan->fst_speed=
.attr);
> >         if (status)
> > -               goto rem_fine_grain_attr;
> > +               return status;
> > +
> > +       if (fan->acpi4_only_fst)
> > +               return 0;
>
> So the above may become
>
> if (!fan->acpi4)
>     return 0;
>

Yes I think this is also better and feels more "self-documenting."

> > +
> > +       sysfs_attr_init(&fan->fine_grain_control.attr);
> > +       fan->fine_grain_control.show =3D show_fine_grain_control;
> > +       fan->fine_grain_control.store =3D NULL;
> > +       fan->fine_grain_control.attr.name =3D "fine_grain_control";
> > +       fan->fine_grain_control.attr.mode =3D 0444;
> > +       status =3D sysfs_create_file(&device->dev.kobj, &fan->fine_grai=
n_control.attr);
> > +       if (status)
> > +               goto rem_fst_attr;
> >
> >         for (i =3D 0; i < fan->fps_count; ++i) {
> >                 struct acpi_fan_fps *fps =3D &fan->fps[i];
> > @@ -109,18 +112,18 @@ int acpi_fan_create_attributes(struct acpi_device=
 *device)
> >
> >                         for (j =3D 0; j < i; ++j)
> >                                 sysfs_remove_file(&device->dev.kobj, &f=
an->fps[j].dev_attr.attr);
> > -                       goto rem_fst_attr;
> > +                       goto rem_fine_grain_attr;
> >                 }
> >         }
> >
> >         return 0;
> >
> > -rem_fst_attr:
> > -       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > -
> >  rem_fine_grain_attr:
> >         sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.a=
ttr);
> >
> > +rem_fst_attr:
> > +       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > +
> >         return status;
> >  }
> >
> > @@ -129,9 +132,13 @@ void acpi_fan_delete_attributes(struct acpi_device=
 *device)
> >         struct acpi_fan *fan =3D acpi_driver_data(device);
> >         int i;
> >
> > +       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > +
> > +       if (fan->acpi4_only_fst)
> > +               return;
> > +
> >         for (i =3D 0; i < fan->fps_count; ++i)
> >                 sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_a=
ttr.attr);
> >
> > -       sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> >         sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.a=
ttr);
> >  }
> > diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> > index 10016f52f..b51b1481c 100644
> > --- a/drivers/acpi/fan_core.c
> > +++ b/drivers/acpi/fan_core.c
> > @@ -211,6 +211,11 @@ static bool acpi_fan_is_acpi4(struct acpi_device *=
device)
> >                acpi_has_method(device->handle, "_FST");
> >  }
> >
> > +static bool acpi_fan_has_fst(struct acpi_device *device)
> > +{
> > +       return acpi_has_method(device->handle, "_FST");
> > +}
> > +
> >  static int acpi_fan_get_fif(struct acpi_device *device)
> >  {
> >         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > @@ -327,7 +332,12 @@ static int acpi_fan_probe(struct platform_device *=
pdev)
> >         device->driver_data =3D fan;
> >         platform_set_drvdata(pdev, fan);
> >
> > -       if (acpi_fan_is_acpi4(device)) {
> > +       if (acpi_fan_is_acpi4(device))
> > +               fan->acpi4 =3D true;
> > +       else if (acpi_fan_has_fst(device))
> > +               fan->acpi4_only_fst =3D true;
>
> And here one could do
>
>     if (acpi_fan_has_fst(device)) {
>         fan->has_fst =3D true;
>         fan->acpi4 =3D acpi_fan_is_acpi4(device);
>     }
>
> and if I'm not mistaken, the check for _FST presence could be dropped
> from acpi_fan_is_acpi4().
>

Yes if you only call acpi_fan_is_acpi4() after you have already gotten
positive from acpi_fan_has_fst() then "has _FST" is already baked in.
Maybe a bit less obvious if you only look at the code within the
function acpi_fan_is_acpi4() but more efficient and less code will be
executed overall so if you are ok with this then I will change it like
this :)

> > +
> > +       if (fan->acpi4) {
> >                 result =3D acpi_fan_get_fif(device);
> >                 if (result)
> >                         return result;
> > @@ -335,7 +345,7 @@ static int acpi_fan_probe(struct platform_device *p=
dev)
> >                 result =3D acpi_fan_get_fps(device);
> >                 if (result)
> >                         return result;
> > -
> > +       } else if (fan->acpi4 || fan->acpi4_only_fst) {
>
> Then, all of the checks like the above could be replaced with
> fan->has_fst checks.
>

Yes and looks nicer!

> >                 result =3D devm_acpi_fan_create_hwmon(device);
> >                 if (result)
> >                         return result;
> > @@ -343,8 +353,6 @@ static int acpi_fan_probe(struct platform_device *p=
dev)
> >                 result =3D acpi_fan_create_attributes(device);
> >                 if (result)
> >                         return result;
> > -
> > -               fan->acpi4 =3D true;
> >         } else {
> >                 result =3D acpi_device_update_power(device, NULL);
> >                 if (result) {
> > @@ -391,7 +399,7 @@ static int acpi_fan_probe(struct platform_device *p=
dev)
> >  err_unregister:
> >         thermal_cooling_device_unregister(cdev);
> >  err_end:
> > -       if (fan->acpi4)
> > +       if (fan->acpi4 || fan->acpi4_only_fst)
> >                 acpi_fan_delete_attributes(device);
> >
> >         return result;
> > @@ -401,7 +409,7 @@ static void acpi_fan_remove(struct platform_device =
*pdev)
> >  {
> >         struct acpi_fan *fan =3D platform_get_drvdata(pdev);
> >
> > -       if (fan->acpi4) {
> > +       if (fan->acpi4 || fan->acpi4_only_fst) {
> >                 struct acpi_device *device =3D ACPI_COMPANION(&pdev->de=
v);
> >
> >                 acpi_fan_delete_attributes(device);
> > @@ -415,7 +423,7 @@ static void acpi_fan_remove(struct platform_device =
*pdev)
> >  static int acpi_fan_suspend(struct device *dev)
> >  {
> >         struct acpi_fan *fan =3D dev_get_drvdata(dev);
> > -       if (fan->acpi4)
> > +       if (fan->acpi4 || fan->acpi4_only_fst)
> >                 return 0;
> >
> >         acpi_device_set_power(ACPI_COMPANION(dev), ACPI_STATE_D0);
> > @@ -428,7 +436,7 @@ static int acpi_fan_resume(struct device *dev)
> >         int result;
> >         struct acpi_fan *fan =3D dev_get_drvdata(dev);
> >
> > -       if (fan->acpi4)
> > +       if (fan->acpi4 || fan->acpi4_only_fst)
> >                 return 0;
> >
> >         result =3D acpi_device_update_power(ACPI_COMPANION(dev), NULL);
> > diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> > index bd0d31a39..87bee018c 100644
> > --- a/drivers/acpi/fan_hwmon.c
> > +++ b/drivers/acpi/fan_hwmon.c
> > @@ -43,6 +43,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void =
*drvdata, enum hwmon_sensor_
> >                 case hwmon_fan_input:
> >                         return 0444;
> >                 case hwmon_fan_target:
> > +                       /*
> > +                        * Fans with only _FST do not support fan contr=
ol.
> > +                        */
>
> Nit: One-line comment here, please.
>

Yes this one is the easiest by far ;) I think it was more that I
copy-pasted from other comments within the switch and kept it the same
"style" but agree this new one is short enough to be one line. I will
probably anyway change the comment a bit to fit better with the change
to `(!fan->acpi4)` per your comment below but will see what I can do!

I will get these tweaks in as a v4 to this patch shortly.

Thanks again!

Regards,
Joshua

> > +                       if (fan->acpi4_only_fst)
>
> And this would become
>
>    if (!fan->acpi4)
>
> > +                               return 0;
> > +
> >                         /*
> >                          * When in fine grain control mode, not every f=
an control value
> >                          * has an associated fan performance state.
> > --

