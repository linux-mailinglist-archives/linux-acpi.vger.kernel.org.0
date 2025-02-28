Return-Path: <linux-acpi+bounces-11639-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC64A4A012
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 18:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8D93AA8D6
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC3A1F0993;
	Fri, 28 Feb 2025 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="y98c23vX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3ED1F4C89;
	Fri, 28 Feb 2025 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762949; cv=none; b=uZ2KF9zc76KpeRK8aDO6iLH6pANnrwIPyf6f4E0P07bHqx39+4xGcGkrtKrtAMJISjROoybomxqwH/K57goHDJh/dwjhqWE6ET59LlIag9PcWM8JyjAfyS+vYjMmyQt5axnw2RNgPJp7CIMb1bhOBXAkdsT1Q12svatTGcFeDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762949; c=relaxed/simple;
	bh=ZiztYP8bsTpFB8X72N5P0bW3ZsOX8ZuVEgP4olNm6nI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taC7IVh4hFSKdrrEMAiw3Xg9t6nkbTRBe415WXNmwmrTjaJb0nkQd8EoP5C9lppAUi3cVJ9+230/FI6Za8V062tzSxAj7C7g612oVTWNJSoPWQMhs34oK7PlUqetjW8VCv18iSuGMBzLvBseyHmFwaBpZBMPta7MvrOS7Lgz9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=y98c23vX; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 83F912E08E57;
	Fri, 28 Feb 2025 19:15:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740762935;
	bh=2b2EqF3JcoemetZAF/Ymx2Rl5XMFwIx+GyHRh+KG1hc=;
	h=Received:From:Subject:To;
	b=y98c23vXuK3aAP/S7c9V00c3glmWJv/v6W0aPHV9KqcM6LwX5U5cSxh3weez6SVhD
	 PhPu5iaJlw9A4U7Zhfls1nUCD3qGTaFje4OVobcPh41vH7fCj78Yoh0dSnu/slBUKp
	 OYLL3Sh11VE04urUnSGees5D2XXYpzDGmEVR3eps=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-307325f2436so25246131fa.0;
        Fri, 28 Feb 2025 09:15:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUdQhSBf/qh8xF9WZrKoc4NVrWg9CYD9LucUdP0/rUy1a5t7AyOgor19y/p1mlGyWPt755PBUk4Vd04@vger.kernel.org,
 AJvYcCVERVw7ltvjz8wtwHEUHDc5/fmpPj+xTq5DZKmmV7+xRKzYOfb6Cb1DTL9DVrlaIEI/BIdntwakyrtcUGw7@vger.kernel.org,
 AJvYcCWgl/Dloj10ezAWY034z+VWHTOa6g8QDH/XntAg42BHzQMe0OkcP6XlZa/SNgUJvFrs6jFUuVWps4vhsHJx9/s1Jzqndg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFyYSIvYIaja8afJmeDMuSV16rqg4OdpfX0zPQ73kGjbtHJde
	RgnJqJ9GHb6IrpMECiVCDYDMHzwc9tu4jycRM8zALhaHPeprF2lEWaf3Zkh6r4T3EJ500HeWLC0
	/ReVW06PEgXbk7Qxq2nr9QjqjBj0=
X-Google-Smtp-Source: 
 AGHT+IG319y4sJ0Wf4snos6bgIsBLMeDKrQDMygneAgNjZ48an8kOVa8nKwcDnvL9Uy73icOnrSOVv4ASkswCmRCY38=
X-Received: by 2002:a2e:bc09:0:b0:300:1de5:59e3 with SMTP id
 38308e7fff4ca-30b93216728mr14248621fa.2.1740762933693; Fri, 28 Feb 2025
 09:15:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
In-Reply-To: <20250228170155.2623386-2-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 28 Feb 2025 18:15:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHtCOm0tmnzkQOHY6doPzenXsg+LnO5MH4Q5DJPQRfB3w@mail.gmail.com>
X-Gm-Features: AQ5f1JpdnaYXZ4tAvf9SuQhfvgSgc4SZm-7887dotZrRn8oOMZp8qOmjL99koK8
Message-ID: 
 <CAGwozwHtCOm0tmnzkQOHY6doPzenXsg+LnO5MH4Q5DJPQRfB3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden
 choices
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174076293491.3947.16851476048369669821@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

LGTM. Although patch is a bit more complicated.

I do not have time to test this today. I can try tomorrow.

On Fri, 28 Feb 2025 at 18:02, Mario Limonciello <superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When two drivers don't support all the same profiles the legacy interface
> only exports the common profiles.
>
> This causes problems for cases where one driver uses low-power but another
> uses quiet because the result is that neither is exported to sysfs.
>
> To allow two drivers to disagree, add support for "hidden choices".
> Hidden choices are platform profiles that a driver supports to be
> compatible with the platform profile of another driver.
>
> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: "Luke D. Jones" <luke@ljones.dev>
>  drivers/acpi/platform_profile.c  | 94 +++++++++++++++++++++++++-------
>  include/linux/platform_profile.h |  3 +
>  2 files changed, 76 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 2ad53cc6aae53..ef9444482db19 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -21,9 +21,15 @@ struct platform_profile_handler {
>         struct device dev;
>         int minor;
>         unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +       unsigned long hidden_choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>         const struct platform_profile_ops *ops;
>  };
>
> +struct aggregate_choices_data {
> +       unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +       int count;
> +};
> +
>  static const char * const profile_names[] = {
>         [PLATFORM_PROFILE_LOW_POWER] = "low-power",
>         [PLATFORM_PROFILE_COOL] = "cool",
> @@ -73,7 +79,7 @@ static int _store_class_profile(struct device *dev, void *data)
>
>         lockdep_assert_held(&profile_lock);
>         handler = to_pprof_handler(dev);
> -       if (!test_bit(*bit, handler->choices))
> +       if (!test_bit(*bit, handler->choices) && !test_bit(*bit, handler->hidden_choices))
>                 return -EOPNOTSUPP;
>
>         return handler->ops->profile_set(dev, *bit);
> @@ -239,21 +245,44 @@ static const struct class platform_profile_class = {
>  /**
>   * _aggregate_choices - Aggregate the available profile choices
>   * @dev: The device
> - * @data: The available profile choices
> + * @arg: struct aggregate_choices_data
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -static int _aggregate_choices(struct device *dev, void *data)
> +static int _aggregate_choices(struct device *dev, void *arg)
>  {
> +       unsigned long tmp[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +       struct aggregate_choices_data *data = arg;
>         struct platform_profile_handler *handler;
> -       unsigned long *aggregate = data;
>
>         lockdep_assert_held(&profile_lock);
>         handler = to_pprof_handler(dev);
> -       if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> -               bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> +       bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PROFILE_LAST);
> +       if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
> +               bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
>         else
> -               bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
> +               bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAST);
> +       data->count++;
> +
> +       return 0;
> +}
> +
> +/**
> + * _remove_hidden_choices - Remove hidden choices from aggregate data
> + * @dev: The device
> + * @arg: struct aggregate_choices_data
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +static int _remove_hidden_choices(struct device *dev, void *arg)
> +{
> +       struct aggregate_choices_data *data = arg;
> +       struct platform_profile_handler *handler;
> +
> +       lockdep_assert_held(&profile_lock);
> +       handler = to_pprof_handler(dev);
> +       bitmap_andnot(data->aggregate, handler->choices,
> +                     handler->hidden_choices, PLATFORM_PROFILE_LAST);
>
>         return 0;
>  }
> @@ -270,22 +299,31 @@ static ssize_t platform_profile_choices_show(struct device *dev,
>                                              struct device_attribute *attr,
>                                              char *buf)
>  {
> -       unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +       struct aggregate_choices_data data = {
> +               .aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
> +               .count = 0,
> +       };
>         int err;
>
> -       set_bit(PLATFORM_PROFILE_LAST, aggregate);
> +       set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>         scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>                 err = class_for_each_device(&platform_profile_class, NULL,
> -                                           aggregate, _aggregate_choices);
> +                                           &data, _aggregate_choices);
>                 if (err)
>                         return err;
> +               if (data.count == 1) {
> +                       err = class_for_each_device(&platform_profile_class, NULL,
> +                                                   &data, _remove_hidden_choices);
> +                       if (err)
> +                               return err;
> +               }
>         }
>
>         /* no profile handler registered any more */
> -       if (bitmap_empty(aggregate, PLATFORM_PROFILE_LAST))
> +       if (bitmap_empty(data.aggregate, PLATFORM_PROFILE_LAST))
>                 return -EINVAL;
>
> -       return _commmon_choices_show(aggregate, buf);
> +       return _commmon_choices_show(data.aggregate, buf);
>  }
>
>  /**
> @@ -373,7 +411,10 @@ static ssize_t platform_profile_store(struct device *dev,
>                                       struct device_attribute *attr,
>                                       const char *buf, size_t count)
>  {
> -       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> +       struct aggregate_choices_data data = {
> +               .aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
> +               .count = 0,
> +       };
>         int ret;
>         int i;
>
> @@ -381,13 +422,13 @@ static ssize_t platform_profile_store(struct device *dev,
>         i = sysfs_match_string(profile_names, buf);
>         if (i < 0 || i == PLATFORM_PROFILE_CUSTOM)
>                 return -EINVAL;
> -       set_bit(PLATFORM_PROFILE_LAST, choices);
> +       set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>         scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>                 ret = class_for_each_device(&platform_profile_class, NULL,
> -                                           choices, _aggregate_choices);
> +                                           &data, _aggregate_choices);
>                 if (ret)
>                         return ret;
> -               if (!test_bit(i, choices))
> +               if (!test_bit(i, data.aggregate))
>                         return -EOPNOTSUPP;
>
>                 ret = class_for_each_device(&platform_profile_class, NULL, &i,
> @@ -453,12 +494,15 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>   */
>  int platform_profile_cycle(void)
>  {
> +       struct aggregate_choices_data data = {
> +               .aggregate = { [0 ... BITS_TO_LONGS(PLATFORM_PROFILE_LAST) - 1] = ~0UL },
> +               .count = 0,
> +       };
>         enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>         enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
> -       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>         int err;
>
> -       set_bit(PLATFORM_PROFILE_LAST, choices);
> +       set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>         scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>                 err = class_for_each_device(&platform_profile_class, NULL,
>                                             &profile, _aggregate_profiles);
> @@ -470,14 +514,14 @@ int platform_profile_cycle(void)
>                         return -EINVAL;
>
>                 err = class_for_each_device(&platform_profile_class, NULL,
> -                                           choices, _aggregate_choices);
> +                                           &data, _aggregate_choices);
>                 if (err)
>                         return err;
>
>                 /* never iterate into a custom if all drivers supported it */
> -               clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
> +               clear_bit(PLATFORM_PROFILE_CUSTOM, data.aggregate);
>
> -               next = find_next_bit_wrap(choices,
> +               next = find_next_bit_wrap(data.aggregate,
>                                           PLATFORM_PROFILE_LAST,
>                                           profile + 1);
>
> @@ -532,6 +576,14 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       if (ops->hidden_choices) {
> +               err = ops->hidden_choices(drvdata, pprof->hidden_choices);
> +               if (err) {
> +                       dev_err(dev, "platform_profile hidden_choices failed\n");
> +                       return ERR_PTR(err);
> +               }
> +       }
> +
>         guard(mutex)(&profile_lock);
>
>         /* create class interface for individual handler */
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
> index 8ab5b0e8eb2c1..8c9df7dadd5d3 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -33,6 +33,8 @@ enum platform_profile_option {
>   * @probe: Callback to setup choices available to the new class device. These
>   *        choices will only be enforced when setting a new profile, not when
>   *        getting the current one.
> + * @hidden_choices: Callback to setup choices that are not visible to the user
> + *                 but can be set by the driver.
>   * @profile_get: Callback that will be called when showing the current platform
>   *              profile in sysfs.
>   * @profile_set: Callback that will be called when storing a new platform
> @@ -40,6 +42,7 @@ enum platform_profile_option {
>   */
>  struct platform_profile_ops {
>         int (*probe)(void *drvdata, unsigned long *choices);
> +       int (*hidden_choices)(void *drvdata, unsigned long *choices);
>         int (*profile_get)(struct device *dev, enum platform_profile_option *profile);
>         int (*profile_set)(struct device *dev, enum platform_profile_option profile);
>  };
> --
> 2.43.0
>

