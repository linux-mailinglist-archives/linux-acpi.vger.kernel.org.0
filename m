Return-Path: <linux-acpi+bounces-10805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC7EA1AD13
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 00:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E4F7A236B
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 23:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBAD1BEF7C;
	Thu, 23 Jan 2025 23:02:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC31139CEF;
	Thu, 23 Jan 2025 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737673333; cv=none; b=TrAd+hL9r/fNEFyZiJ97TPwxs7g5MM3RQwA2EGqFhVOguylfazW1ARg4Xw2v6nVsopH3Syox7gTO2gDVrn/kw+Mrz2bonjY5zhibj6gMpkLEw5tBQx/vT/o3XE07NEKC8YM2iq7QQQe0snnd2M3N9Qzc2j2tS8tjn4jAiBqFxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737673333; c=relaxed/simple;
	bh=Tec1he0SKL6pcvcV9EfYfbp0/HV7BIXv6efB30pW/nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkIACbxzJJYVGhN69uElc8xh9Fen7n7IycVUFTwYxMIXPQ9pNTzzWp6Wb/GQWoICKkGGYZO+CvfdWflveA8wXOxaISMrQPgKdSRyb3sQLN/8qmSvX6rWLKNr4Mbb+r3AzgKtgdRu6UXCwDGOGUnNqOWycROugJaUp8wE1pWlt20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-844dfe4b136so37071439f.3;
        Thu, 23 Jan 2025 15:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737673329; x=1738278129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F11ft6L9OxKEI1cX1Dw7di8pe+u4iuFu+UyXOVcH028=;
        b=LkwIZfQPnmGzTQfgST0XJWp21J1mx9osd8s5hPvZHCe1heFY7awnxgAXvvgyrszvnQ
         1+B72YKKy29JsBkdpOAscpAlVmThr2ZrzQy5yZBDSzBT7HMS3pQYRaAayB6FyoXxKQMv
         imG5sTuxNxbJqVChNQNw6qGj4gz3C2gaFFhB8kwt3nAhNGXTNndHWaC+zav5DR+hJxNx
         y1N9bg7XhpgKemuB0FX4WUWh6Jl0B/NIUR+LKqFYiIsBvu7VLC9SN8oYM0p/FVYrLPvp
         ROa7xZgigkebcwBDRvECkfbjN40pE6Em5LJksk01C49u9Ag81DsCouOQtEZoAm2JVvgI
         QlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmdmc4906NcppsQXgADc6rSbR/X2LLQf+G0OXsU0kbBJdSgzLCfTQ5R6+WzMJq96qSCsvLP2iWsCxkiKvR@vger.kernel.org, AJvYcCWrEaHskj6MlFTAWC0ybyZ36qlRvVvnkii2HBkT4cYTNuEuIcRF8lSNCuD5Bj3+lCuBhrs5MkaLLIvf@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZyIlvZaLg1tEeiBS6uyr6U4dsdrk8sZQJajU7FCzwUhW8Moo
	WKZFiRuLx0icA1si2Hr9wgq7IgEpJUWloYrKAycJPjBqjoYfiHC8GyZIrQ==
X-Gm-Gg: ASbGncsx2T+bYW0NgbHXquRQ1BNn31QloLHSS1ji5vLDc/tqORVdouuaEdVpRSyQrDi
	2bUx+nMnRTaDrDJgC423dlIC1A7kV0brzC7oe+OX6Jb7TdamRfnZyluACLIg4hfQdo98Z+uzu66
	VijOOpaFTwgTBythu5T72hd/ALYyM6xiPknY3eVjIp5iiESWQBw8zRQe8vP9DkbrZTPAtrAZqW0
	2Uf8bJHBUVsGdG0bmr2AAORLgvmytJY07PvFWNiZ77RlFPHlgyRQI8AI4ziDcfwkyBBsMF2w1/I
	d6BEQzHv3mE+oLwxRfJIKXmiC5Yl3Y5F9ynGNTdZf1GZ28HVhQ==
X-Google-Smtp-Source: AGHT+IGT+Wz7zY+6IV1YVHu2x1+vhUIoBYgJjjuew0pW+MjFtR+hLOplhHrJxxOah8cmd9b0aT8XcA==
X-Received: by 2002:a05:6602:2d83:b0:847:22a7:2412 with SMTP id ca18e2360f4ac-851b623bb6cmr2773799339f.8.1737673329251;
        Thu, 23 Jan 2025 15:02:09 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8521dde9f65sm20322539f.5.2025.01.23.15.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 15:02:08 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so1166125ab.2;
        Thu, 23 Jan 2025 15:02:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGPqa80+S8hE4Tw9vRDtzG2Nqfgm1h/jt3JYPqBjJ8p9n2THp2c/ZHmNFjXixV8JOtCwcB+UFU6Awe@vger.kernel.org, AJvYcCXOA9g23M+vAtdLXXO58HifWJs4ERx3RDMCPQDt0ekR0Nw0Ha6CqTUPybSkgWEbxCmcAKWRumOlsNFr/cQt@vger.kernel.org
X-Received: by 2002:a05:6e02:20e7:b0:3ce:7fc3:9f76 with SMTP id
 e9e14a558f8ab-3cf743eae5amr216533015ab.6.1737673327924; Thu, 23 Jan 2025
 15:02:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114012150.156349-1-josh@joshuagrisham.com> <6c1dbd29-71fb-4714-a661-7539408874d3@gmx.de>
In-Reply-To: <6c1dbd29-71fb-4714-a661-7539408874d3@gmx.de>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Fri, 24 Jan 2025 00:01:56 +0100
X-Gmail-Original-Message-ID: <CAMF+KeZ86ixwpRhh2uP9PMTxaxh=t5QR22cVgNuRpZCKO5p1Jg@mail.gmail.com>
X-Gm-Features: AWEUYZnIAEAzq_k6x97gfRuh-OIHT8WRp-NAmE1JVVTqNvlK3MiSxOoZemccjX8
Message-ID: <CAMF+KeZ86ixwpRhh2uP9PMTxaxh=t5QR22cVgNuRpZCKO5p1Jg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: Add fan speed reporting for fans with only _FST
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Den tors 23 jan. 2025 kl 01:50 skrev Armin Wolf <W_Armin@gmx.de>:
>
> Am 14.01.25 um 02:21 schrieb Joshua Grisham:
>
> > Add support for ACPI fans with _FST to report their speed even if they do
> > not support fan control.
> >
> > As suggested by Armin Wolf [1] and per the Windows Thermal Management
> > Design Guide [2], Samsung Galaxy Book series devices (and possibly many
> > more devices where the Windows guide was strictly followed) only implement
> > the _FST method and do not support ACPI-based fan control.
> >
> > Currently, these fans are not supported by the kernel driver but this patch
> > will make some very small adjustments to allow them to be supported.
> >
> > This patch is tested and working for me on a Samsung Galaxy Book2 Pro whose
> > DSDT (and several other Samsung Galaxy Book series notebooks which
> > currently have the same issue) can be found at [3].
> >
> > [1]: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-463912dd966d@gmx.de
> > [2]: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/design-guide
> > [3]: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e3087a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt
> >
> > Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> > ---
> >   drivers/acpi/fan.h       |  1 +
> >   drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
> >   drivers/acpi/fan_core.c  | 24 ++++++++++++++++--------
> >   drivers/acpi/fan_hwmon.c |  6 ++++++
> >   4 files changed, 45 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> > index 488b51e2c..d0aad88a7 100644
> > --- a/drivers/acpi/fan.h
> > +++ b/drivers/acpi/fan.h
> > @@ -49,6 +49,7 @@ struct acpi_fan_fst {
> >
> >   struct acpi_fan {
> >       bool acpi4;
> > +     bool acpi4_only_fst;
> >       struct acpi_fan_fif fif;
> >       struct acpi_fan_fps *fps;
> >       int fps_count;
> > diff --git a/drivers/acpi/fan_attr.c b/drivers/acpi/fan_attr.c
> > index f4f6e2381..d83f88429 100644
> > --- a/drivers/acpi/fan_attr.c
> > +++ b/drivers/acpi/fan_attr.c
> > @@ -75,15 +75,6 @@ int acpi_fan_create_attributes(struct acpi_device *device)
> >       struct acpi_fan *fan = acpi_driver_data(device);
> >       int i, status;
> >
> > -     sysfs_attr_init(&fan->fine_grain_control.attr);
> > -     fan->fine_grain_control.show = show_fine_grain_control;
> > -     fan->fine_grain_control.store = NULL;
> > -     fan->fine_grain_control.attr.name = "fine_grain_control";
> > -     fan->fine_grain_control.attr.mode = 0444;
> > -     status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
> > -     if (status)
> > -             return status;
> > -
> >       /* _FST is present if we are here */
> >       sysfs_attr_init(&fan->fst_speed.attr);
> >       fan->fst_speed.show = show_fan_speed;
> > @@ -92,7 +83,19 @@ int acpi_fan_create_attributes(struct acpi_device *device)
> >       fan->fst_speed.attr.mode = 0444;
> >       status = sysfs_create_file(&device->dev.kobj, &fan->fst_speed.attr);
> >       if (status)
> > -             goto rem_fine_grain_attr;
> > +             return status;
> > +
> > +     if (fan->acpi4_only_fst)
> > +             return 0;
> > +
> > +     sysfs_attr_init(&fan->fine_grain_control.attr);
> > +     fan->fine_grain_control.show = show_fine_grain_control;
> > +     fan->fine_grain_control.store = NULL;
> > +     fan->fine_grain_control.attr.name = "fine_grain_control";
> > +     fan->fine_grain_control.attr.mode = 0444;
> > +     status = sysfs_create_file(&device->dev.kobj, &fan->fine_grain_control.attr);
> > +     if (status)
> > +             goto rem_fst_attr;
> >
> >       for (i = 0; i < fan->fps_count; ++i) {
> >               struct acpi_fan_fps *fps = &fan->fps[i];
> > @@ -109,18 +112,18 @@ int acpi_fan_create_attributes(struct acpi_device *device)
> >
> >                       for (j = 0; j < i; ++j)
> >                               sysfs_remove_file(&device->dev.kobj, &fan->fps[j].dev_attr.attr);
> > -                     goto rem_fst_attr;
> > +                     goto rem_fine_grain_attr;
> >               }
> >       }
> >
> >       return 0;
> >
> > -rem_fst_attr:
> > -     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > -
> >   rem_fine_grain_attr:
> >       sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
> >
> > +rem_fst_attr:
> > +     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > +
> >       return status;
> >   }
> >
> > @@ -129,9 +132,13 @@ void acpi_fan_delete_attributes(struct acpi_device *device)
> >       struct acpi_fan *fan = acpi_driver_data(device);
> >       int i;
> >
> > +     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> > +
> > +     if (fan->acpi4_only_fst)
> > +             return;
> > +
> >       for (i = 0; i < fan->fps_count; ++i)
> >               sysfs_remove_file(&device->dev.kobj, &fan->fps[i].dev_attr.attr);
> >
> > -     sysfs_remove_file(&device->dev.kobj, &fan->fst_speed.attr);
> >       sysfs_remove_file(&device->dev.kobj, &fan->fine_grain_control.attr);
> >   }
> > diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> > index 10016f52f..b51b1481c 100644
> > --- a/drivers/acpi/fan_core.c
> > +++ b/drivers/acpi/fan_core.c
> > @@ -211,6 +211,11 @@ static bool acpi_fan_is_acpi4(struct acpi_device *device)
> >              acpi_has_method(device->handle, "_FST");
> >   }
> >
> > +static bool acpi_fan_has_fst(struct acpi_device *device)
> > +{
> > +     return acpi_has_method(device->handle, "_FST");
> > +}
> > +
> >   static int acpi_fan_get_fif(struct acpi_device *device)
> >   {
> >       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > @@ -327,7 +332,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >       device->driver_data = fan;
> >       platform_set_drvdata(pdev, fan);
> >
> > -     if (acpi_fan_is_acpi4(device)) {
> > +     if (acpi_fan_is_acpi4(device))
> > +             fan->acpi4 = true;
> > +     else if (acpi_fan_has_fst(device))
> > +             fan->acpi4_only_fst = true;
> > +
> > +     if (fan->acpi4) {
> >               result = acpi_fan_get_fif(device);
> >               if (result)
> >                       return result;
> > @@ -335,7 +345,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >               result = acpi_fan_get_fps(device);
> >               if (result)
> >                       return result;
> > -
> > +     } else if (fan->acpi4 || fan->acpi4_only_fst) {
>
> Hi,
>
> this will not register any attributes or the hwmon interface if "fan->acpi4" is true.
>
> I think the "else" is misplaced here.
>
> >               result = devm_acpi_fan_create_hwmon(device);
> >               if (result)
> >                       return result;
> > @@ -343,8 +353,6 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >               result = acpi_fan_create_attributes(device);
> >               if (result)
> >                       return result;
> > -
> > -             fan->acpi4 = true;
> >       } else {
> >               result = acpi_device_update_power(device, NULL);
> >               if (result) {
> > @@ -391,7 +399,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >   err_unregister:
> >       thermal_cooling_device_unregister(cdev);
> >   err_end:
> > -     if (fan->acpi4)
> > +     if (fan->acpi4 || fan->acpi4_only_fst)
> >               acpi_fan_delete_attributes(device);
> >
> >       return result;
> > @@ -401,7 +409,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
> >   {
> >       struct acpi_fan *fan = platform_get_drvdata(pdev);
> >
> > -     if (fan->acpi4) {
> > +     if (fan->acpi4 || fan->acpi4_only_fst) {
> >               struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> >
> >               acpi_fan_delete_attributes(device);
> > @@ -415,7 +423,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
> >   static int acpi_fan_suspend(struct device *dev)
> >   {
> >       struct acpi_fan *fan = dev_get_drvdata(dev);
> > -     if (fan->acpi4)
> > +     if (fan->acpi4 || fan->acpi4_only_fst)
> >               return 0;
> >
> >       acpi_device_set_power(ACPI_COMPANION(dev), ACPI_STATE_D0);
> > @@ -428,7 +436,7 @@ static int acpi_fan_resume(struct device *dev)
> >       int result;
> >       struct acpi_fan *fan = dev_get_drvdata(dev);
> >
> > -     if (fan->acpi4)
> > +     if (fan->acpi4 || fan->acpi4_only_fst)
> >               return 0;
>
> The Windows design guide says:
>
>         "A fan that implements the _FST object is not required to be in a thermal
>         zone's _ALx device list, but it can, as an option, be in this list.
>         This option enables a hybrid solution in which a fan is typically
>         controlled by a third-party driver, but can be controlled by the OS
>         thermal zone if the third-party driver is not installed. If a fan is in
>         an _ALx device list and is engaged by the thermal zone (placed in D0),
>         the _FST object is required to indicate a nonzero Control value."
>
> Because this i think the suspend/resume path should still change the power state of the fan device.
>
> >
> >       result = acpi_device_update_power(ACPI_COMPANION(dev), NULL);
> > diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> > index bd0d31a39..87bee018c 100644
> > --- a/drivers/acpi/fan_hwmon.c
> > +++ b/drivers/acpi/fan_hwmon.c
> > @@ -43,6 +43,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
> >               case hwmon_fan_input:
> >                       return 0444;
> >               case hwmon_fan_target:
> > +                     /*
> > +                      * Fans with only _FST do not support fan control.
> > +                      */
> > +                     if (fan->acpi4_only_fst)
> > +                             return 0;
>
> The same needs to be done for hwmon_power_input, since currently the code assumes that the _FIF
> ACPI control method is always present.
>
> Other than that the patch looks promising.
>
> Thanks,
> Armin Wolf
>

Hi Armin! I looked at this and you are 100% right on all counts, thank
you for checking into this! For the really silly stuff, I can only
blame that it was apparently very late when I sent this patch in :) I
will update these now, do a quick test to make sure things are looking
ok still, and send a v2 of the patch.

Thank you again!

Best regards,
Joshua

