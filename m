Return-Path: <linux-acpi+bounces-10906-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB8A2A264
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 08:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C3B164D6F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C05E20C032;
	Thu,  6 Feb 2025 07:38:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939B3B1A4;
	Thu,  6 Feb 2025 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827480; cv=none; b=fp2OSosP+/gbJPv20YTVgYYckTuGcRMyEJye0mIBbidIxs4ED2n1NvbrMSnC5Brd3nmjKVwRLE/8m8WdnMzszU3rDBq88p90FqV2vH9sBVpm7QycfO8xe4+nzR5Zxdz5lnnMzNEBZNAIcXepCdTk25nZONpO93IFvbAc2qQNERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827480; c=relaxed/simple;
	bh=H8d1sShhjT3uHIDp1TezpEAnMZqghybj848d8k4y1Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPPBnW5oWxjVlZFDEuegzq9EhG3NYyIRf+knwnA44VkAmtWDmdZa5Cn0X/D+6fIoIqGuOvuh1PvdIkvi8G/PzfnVw4iZLth9gYSk2qOBujMv/qeSXY9xsv+z3fJ1Qz4z2nXorp/DO8/cYxYMX0sQL4yd2zdZC76HlQccgOhNnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshuagrisham.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso1887955ab.1;
        Wed, 05 Feb 2025 23:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738827477; x=1739432277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8p0zMadSpTCU/jRUCuNi7OSGRjIwWhEj+KL8cTH/bo=;
        b=W9+Hzum85oSWAgOud9mGvvzAz0UOo/7TlObUx0XapXquaD5UPOPQ5rHbxNZ6Qo8/ut
         Qf0QYnm+QssosCSj5M9+/NnUNQZN3mjV+WCIH/5X4jzRDdMCcE7MYHFy2OidGj/ssFlj
         Ai2MeYU9YZcZk5rGWSbgtAgsTXdX9hDspcuio6drsZrOSQcEAMJe6R8r1lyQL9vS6xVK
         ct0xbHoUrEzCOqGwrq0cTr/Lb6djPoxtbBT4IV4Lxe52dUQgxy0we4+rRCQa2r0WaFkG
         LNI21fOhJlivm1QcqgYehlOnwvAYXRCshfr5gxFruQWkS42mnL9+AWtkTVtzyKdR3Oqr
         JZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCVrxof67N09cv89xmfIuzn9zCszSRi8BVoWO+V6Nx9e4myUFYP8QKPBm1vLfwlTfi0Z4RGw21M3gQdxCy8D@vger.kernel.org, AJvYcCX+9WU+SZptI8uh/fmhqVQTu72I2iW6vP04LL6Geru17xlGtAevYfakEbLCt5k6NMp/f+zwsHzGkH73@vger.kernel.org
X-Gm-Message-State: AOJu0YxfqkjJs5dWvUNg3GdWNquXZ+bm6MjTu/TlGC3FHvQwMtA5rx3f
	rn5LPT47JzOh0u/DHvZOtHOf2CkzxA56rvyRntlo6Dsw6VbTXG32XrBCTryD
X-Gm-Gg: ASbGnctAlVE/ID7lSg7qyj8cGpPLNGHE967PAJbpoURPGUJxfaOfw/94eBYfJLTa0GH
	x5U3sY7W9UaKGG68PxvB4W3BE4OAi1L5EaB7TKOJEn3LrHMxxJsxv32vOYR03viqZuvGhOano9C
	F/Gtjf0ILuxammbT7pqujnZlCd1YMcWuGziE3hHsS1gnx9iEZHJVL7eSx9uOUBNsBkzPJS9hcdX
	Kd5zOPd2+yAgzvf9PqwC24Lv3p+7vF0VsWV5xDkv1kciWq3n/YJ/tE/c2ERTfDZdpJsOvAqNbT6
	2CZRxqubD7MnoSI5QLNQxx5JKKW/rQDOZhdPerBCwAdPOjzl17MtQE3F
X-Google-Smtp-Source: AGHT+IHc8P36svqeoZqXL/4dz+s9z8OCfSc2PPPGAudeI6smflk5tW3s3lWm5St76dDMTnoTHntFng==
X-Received: by 2002:a05:6e02:1449:b0:3a7:820c:180a with SMTP id e9e14a558f8ab-3d04f92276bmr63375255ab.19.1738827477134;
        Wed, 05 Feb 2025 23:37:57 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccfb028e1sm152914173.126.2025.02.05.23.37.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 23:37:56 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844eb33827eso21008439f.2;
        Wed, 05 Feb 2025 23:37:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWUtbjY6xYuPVkYY7zkJEhTv0JhbVxUjQod/hxB0heqC7ymtMVlHOXwWwsNcCxr3Hjfe7DAu39bfbJ@vger.kernel.org, AJvYcCWGFUvuepa6jsBrn326VwaWN0WxDHk8sbW2mVYe2pcGtVEauxXqfp4fgXGGdKMU1Fd++fEhFqCXqinw3g/w@vger.kernel.org
X-Received: by 2002:a05:6e02:12eb:b0:3d0:124d:99e8 with SMTP id
 e9e14a558f8ab-3d04f47c699mr45839305ab.13.1738827476180; Wed, 05 Feb 2025
 23:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125100711.70977-1-josh@joshuagrisham.com> <77eb01a6-2905-4776-96ce-eb936c04956b@gmx.de>
In-Reply-To: <77eb01a6-2905-4776-96ce-eb936c04956b@gmx.de>
From: Joshua Grisham <josh@joshuagrisham.com>
Date: Thu, 6 Feb 2025 08:37:44 +0100
X-Gmail-Original-Message-ID: <CAMF+KeZrdkfwoab4zvBYJMuYaScCDFPbvijo9o6d-9CS96238g@mail.gmail.com>
X-Gm-Features: AWEUYZm_TKLxriR3n9ajCDKvtvtR72txr1G8ZmRcQ8Mfk-CVFMqUgjGSrO1I34w
Message-ID: <CAMF+KeZrdkfwoab4zvBYJMuYaScCDFPbvijo9o6d-9CS96238g@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: fan: Add fan speed reporting for fans with only _FST
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Den tors 6 feb. 2025 kl 06:05 skrev Armin Wolf <W_Armin@gmx.de>:
>
> Am 25.01.25 um 11:07 schrieb Joshua Grisham:
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
>
> Any updates on this patch? For me it seems ready for mainline.
>
> Thanks,
> Armin Wolf
>

Hi Armin, thanks for checking in on this!

For me I have no further updates that I planned or intended to send.
If it looks good to Rafael or anyone else who wants or needs to review
then I would be glad to see it applied.

If needed then I can re-send with Armin's Reviewed-by tag inline in
the commit message but otherwise everything is as I would have wished
it to be, for what that is worth :)

Thanks again!

Best regards,
Joshua


> >
> > [1]: https://lore.kernel.org/platform-driver-x86/53c5075b-1967-45d0-937f-463912dd966d@gmx.de
> > [2]: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/design-guide
> > [3]: https://github.com/joshuagrisham/samsung-galaxybook-extras/tree/8e3087a06b8bdcdfdd081367af4b744a56cc4ee9/dsdt
> >
> > Signed-off-by: Joshua Grisham <josh@joshuagrisham.com>
> > ---
> >
> > v1->v2:
> > - Still allow acpi4_only_fst fans to update power state on
> >    suspend/resume
> > - Fix if / else if logic error
> > - Also hide hwmon_power_input for acpi4_only_fst fans
> >
> > v2->v3:
> > - Still allow acpi4_only_fst fans to set initial power state on probe
> > ---
> >   drivers/acpi/fan.h       |  1 +
> >   drivers/acpi/fan_attr.c  | 37 ++++++++++++++++++++++---------------
> >   drivers/acpi/fan_core.c  | 22 +++++++++++++++++-----
> >   drivers/acpi/fan_hwmon.c | 12 ++++++++++++
> >   4 files changed, 52 insertions(+), 20 deletions(-)
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
> > index 10016f52f..66aa1be64 100644
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
> > @@ -343,9 +355,9 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >               result = acpi_fan_create_attributes(device);
> >               if (result)
> >                       return result;
> > +     }
> >
> > -             fan->acpi4 = true;
> > -     } else {
> > +     if (!fan->acpi4) {
> >               result = acpi_device_update_power(device, NULL);
> >               if (result) {
> >                       dev_err(&device->dev, "Failed to set initial power state\n");
> > @@ -391,7 +403,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >   err_unregister:
> >       thermal_cooling_device_unregister(cdev);
> >   err_end:
> > -     if (fan->acpi4)
> > +     if (fan->acpi4 || fan->acpi4_only_fst)
> >               acpi_fan_delete_attributes(device);
> >
> >       return result;
> > @@ -401,7 +413,7 @@ static void acpi_fan_remove(struct platform_device *pdev)
> >   {
> >       struct acpi_fan *fan = platform_get_drvdata(pdev);
> >
> > -     if (fan->acpi4) {
> > +     if (fan->acpi4 || fan->acpi4_only_fst) {
> >               struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> >
> >               acpi_fan_delete_attributes(device);
> > diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> > index bd0d31a39..d0668ecc2 100644
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
> > +
> >                       /*
> >                        * When in fine grain control mode, not every fan control value
> >                        * has an associated fan performance state.
> > @@ -57,6 +63,12 @@ static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_
> >       case hwmon_power:
> >               switch (attr) {
> >               case hwmon_power_input:
> > +                     /*
> > +                      * Fans with only _FST do not support fan control.
> > +                      */
> > +                     if (fan->acpi4_only_fst)
> > +                             return 0;
> > +
> >                       /*
> >                        * When in fine grain control mode, not every fan control value
> >                        * has an associated fan performance state.

