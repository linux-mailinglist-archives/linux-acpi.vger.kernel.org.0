Return-Path: <linux-acpi+bounces-10821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73519A1C29D
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D93A72C2
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jan 2025 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5333B1DC9A8;
	Sat, 25 Jan 2025 10:07:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3681D95A9;
	Sat, 25 Jan 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737799623; cv=none; b=UGnyjTddCbuNWPCxoB1AE75QyflarpBSKjH/ezFvRSucFdmkaCf82hZNnwiySkfvhLoRvgtH4pqMC7I9jZVuszGS1Tv8B5V6xZ3Qppg1gDomxehdkN6TPyqX4fuVy5IuMqHua4JYZZbW3g758wS2colG90kxN+9giTKMrk8yeLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737799623; c=relaxed/simple;
	bh=4g2MROV5Xuzpu4hX2Tyw2cmfyU2cOOYPeAQ/0yJDVEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev+OSkBEFcYIlGn5NSQZ3dkfbeW+YW3EllWmGLvDwNOTO1/FL6vVRE0QAjI3hBRSE0PRkd1iSssvqxsUR87jZGb7G8+To8uJt4XthUufqnxW3Up2qXfqg0RLZ5eSadzBq9D7qGLs8szb30b8Jm9QcElDIUC3+mDj0o7cO0ol51o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso20864245ab.1;
        Sat, 25 Jan 2025 02:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737799620; x=1738404420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WZsXffZ8ZOVswbWqfx8b87izDHqWd/FYMNsAhPc4+s=;
        b=VAURK3av62Q8lEZsOZoxxpw5kihuxceUAJS6VDmQgGmMTKpMgQvQjwA0w3iWTEICyD
         wzznMH+jpoikPxHtcvo0tgpIH/vER0PtbqIY7G/fuoaQlQUpVajUhDQ0ITjlP7YJSqrG
         bjJ1bndG/QTGxAkXYniC2uzb2X7rgnG9Pb+EvSCisGxJsqVwXMBHfwsvBMcJZfcqFnYW
         q+Ug0SdU/AQXWeZMi/RJ+ZMHWk9qbp/n6IB2wYnJ2Mx1yYD/Rv0mMft43MbRhLV+HAvP
         M7GQfCsNLS1Y5BP3SDduZ8ZFI2eDPHmHzb/jh4zhsyiPgEv2DglqsqngssTlqwIC8cl1
         qbOw==
X-Forwarded-Encrypted: i=1; AJvYcCV3hkSVXUPfnajCfgTenuP/61fOS6dwOkis9KKI8f87aNTiYsuq4vc3z16l/QvGLz6yACeZIaJWUNcRtiDX@vger.kernel.org, AJvYcCVxyIP9ljhFoppl8vf4vCEEE0rYYelz+RYF0l2jO0yzroKhd5+aACzNGLDaCDJ4o8JiqDbtrhHygFTd@vger.kernel.org
X-Gm-Message-State: AOJu0YySHkxejz7wX/RvP8lU1BSGF1DJA+WAl+4rdj2EWbZNbtX8lX9H
	S8qk96UfSLCtPqlVsqGKrseppkKVAkoZze3mriholCheH7ZYlpbQ8JSwKA==
X-Gm-Gg: ASbGnctJHs+tN73Ii1bJ4lj9U2W0oP0Yv5P7bidFAQE3NLT+Z+p8NtJqmiWbt5LLqs2
	7b4oE+Hxrz81o8IRAik9kQadBtBYeenSMNazoE6dH8nInaG5ZMAPnCChHB1zOA1WNp5QY0PnnVd
	naIZPCMKx2SA+sbRuSgU0GKog7dx9X2uvhOnE6LsWk7SV6+u9SlzawH+bnZViEU55QL+hVoLabq
	SRDZDusW5bamUCLWWp3jgLHkXl5MwuVK0LEr5Miw0/TpQRO8m+9V3ALWMWIrN9k1zJreM4PPp5V
	nc3vBcEh+p4jU987Wubopw01jshXtyqVzJB0VNb+BqFpzxnA2w==
X-Google-Smtp-Source: AGHT+IH0AdCAmrnh+9CX9qk+LE/CEWWbSnith7N5Yi86Y5pIaJVgu85UKy7u1cEww/szS8x1Lfa4xA==
X-Received: by 2002:a05:6e02:450f:b0:3cf:c5a8:3b0c with SMTP id e9e14a558f8ab-3cfc5a83c34mr65183035ab.20.1737799620344;
        Sat, 25 Jan 2025 02:07:00 -0800 (PST)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc7449c2esm13109785ab.31.2025.01.25.02.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 02:06:59 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cf82bd380bso24019265ab.0;
        Sat, 25 Jan 2025 02:06:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN2bsvWPFMuufodPtm/TsoFJv4cQnqZga7tSS7STplWeWyYL6Gc2i5Mc20/7zXPfeoeuCuLrz6YrP0tLcr@vger.kernel.org, AJvYcCW18ib0XYWfhjCMW8Dv3EI5c+D3Kdr1ad0Sls4hjX0ioek5iXgoCQMfV0ANKYUT+1P663xjtvlWd3wZ@vger.kernel.org
X-Received: by 2002:a05:6e02:3183:b0:3cf:bc71:94dd with SMTP id
 e9e14a558f8ab-3cfbc71954dmr105750545ab.19.1737799619438; Sat, 25 Jan 2025
 02:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123231355.6456-1-josh@joshuagrisham.com> <c29c1e53-be8d-4628-84bf-2ec67618490d@gmx.de>
In-Reply-To: <c29c1e53-be8d-4628-84bf-2ec67618490d@gmx.de>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Sat, 25 Jan 2025 11:06:48 +0100
X-Gmail-Original-Message-ID: <CAMF+KebbB3xm4-xZRXYmvNgY0QcMvR8868UjJLUZQXGjZPH-FQ@mail.gmail.com>
X-Gm-Features: AWEUYZkYdecasbb7Wk-DIsRH3V7bg_EcibyUY3i3M3cyOTN2p5IJVCyd96HnRIg
Message-ID: <CAMF+KebbB3xm4-xZRXYmvNgY0QcMvR8868UjJLUZQXGjZPH-FQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: fan: Add fan speed reporting for fans with only _FST
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Den fre 24 jan. 2025 kl 22:10 skrev Armin Wolf <W_Armin@gmx.de>:
>
> Am 24.01.25 um 00:13 schrieb Joshua Grisham:
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
> >
> > ---
> >
> > v1->v2:
> > - Still allow acpi4_only_fst fans to update power state on
> >    suspend/resume
> > - Fix if / else if logic error
> > - Also hide hwmon_power_input for acpi4_only_fst fans
> > ---
> >   drivers/acpi/fan.h       |  1 +
> >   drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
> >   drivers/acpi/fan_core.c  | 20 +++++++++++++++-----
> >   drivers/acpi/fan_hwmon.c | 12 ++++++++++++
> >   4 files changed, 50 insertions(+), 20 deletions(-)
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
> > index 10016f52f..ca4785797 100644
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
> > @@ -335,7 +345,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >               result = acpi_fan_get_fps(device);
> >               if (result)
> >                       return result;
> > +     }
> >
> > +     if (fan->acpi4 || fan->acpi4_only_fst) {
> >               result = devm_acpi_fan_create_hwmon(device);
> >               if (result)
> >                       return result;
> > @@ -343,8 +355,6 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >               result = acpi_fan_create_attributes(device);
> >               if (result)
> >                       return result;
> > -
> > -             fan->acpi4 = true;
> >       } else {
>
> We still need to call acpi_device_update_power() if fan->acpi4_only_fst is true.
>
> I think you can do something like this:
>
>         if (!fan->acpi4) {
>                 result = acpi_device_update_power(device, NULL);
>                 if (result) {
>                         dev_err(&device->dev, "Failed to set initial power state\n");
>                         goto err_end;
>                 }
>         }
>
> With this issue being fixed:
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>

Thanks Armin, great catch! My focus initially was on getting the
attributes added and I admittedly neglected to look at the rest of the
picture, but with your comment here I think it definitely finally
"clicked" for me. What would we do without you? :)

Fixed now, tested, pushing a v3 with this change in just a moment.....

Best regards,
Joshua

