Return-Path: <linux-acpi+bounces-11751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F70A4D6AE
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 09:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C4B188D1A6
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521F1FC7F6;
	Tue,  4 Mar 2025 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="CI6jIsJI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855C1FC119;
	Tue,  4 Mar 2025 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077547; cv=none; b=asgoCZBrQcs9/6g7FD+J3fiyTQHWEkQqpUOfVyuNcqus4Qs7TtoNA54mJWQ068o5B/iuLpVsF9SnkcxtJ+Whjgnch/+dfergyHHkwO8dACgGbykQlJJSr8VGYtJ83u2o7YQHdBw8rVjpk8fX877JNXRHHzHNf/ZNCeutVN1snsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077547; c=relaxed/simple;
	bh=h2evhKBBxjn29DueOcEDPOacqSd9wIPMHXKg5fPSswY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXln6FfiboeP5k58HLggcshBGStAQC7Eemt9Av50wsMQCKW9ePk+TOWWmhbjLZK9uhTMS8HBth8MBpvSjRi0+cuVz6y7GpnzFLwKEdfCAexZr8/jHstVqp56G+Rda05SDUH/8oBEgjE9jz+b51iK8SmUl3eD4qjbr1J1F5+dHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=CI6jIsJI; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id AD0A02E03185;
	Tue,  4 Mar 2025 10:38:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741077539;
	bh=tw1Xg0vSW0uM4z3kwjo0svepqIAbcaVLmwIzD8LdsTY=;
	h=Received:From:Subject:To;
	b=CI6jIsJI4lZH32MRgJ3Vy2iWVxG/MfigbTioVcOQQWYzsIlx7IDt++r+M4La6+fzh
	 58YWjPiZUdL+RRBu8rGBvj4q51X0miUQY4szrRssWmoVMBiCBrLu8vgNC6Yg8IyGeE
	 BaIZCBMw+atHbMHUeFLJYMY4M/uSVPWEIYVXvuRQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-307c13298eeso63757921fa.0;
        Tue, 04 Mar 2025 00:38:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVgMraA7qwV508vlCa63nSY+umhn8wrhhcllRb/sijCqkTdeFq7ohHocBQhwiImqcszdVFMMiNmxngU@vger.kernel.org,
 AJvYcCWM8N3GEtW4XPHVuO/eHdinM1bKNlCBhglZskgXuT+Y1U8xBXXK2C+GV3TJtiyR63APhXwF66maFFLblvMB@vger.kernel.org,
 AJvYcCXwNvLsIj05tA13AS08IA8TeY/OKDZsmyfxokf/HapyppWUa61PHpae3730sl+MX6YXJTrpuoIsl+LpbVVOqn0J964AtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxW/fL7wA1gONM8RMMQZB26zl3zVcv7jfKiQ19weBKIakgbXpI7
	53AuXHRpXgbF4ijwHCwZ9lgo3BMgwoxdfqwfbs1kyoeuSlb2ZZBqMa+obZCEFRscCfv9+dL8mFS
	PTMD3alIhrtKwayan+98yOFiMviE=
X-Google-Smtp-Source: 
 AGHT+IF2MgXxvvN+gwuG1qwzlFiehyZOc+pjI8m5Lk4yWeOrM4a34parDJRG8p6Q2NRpNpb8Q5Z+RaFhhLH6LukitUQ=
X-Received: by 2002:a2e:b5b0:0:b0:30b:a3a5:1520 with SMTP id
 38308e7fff4ca-30bca994ac9mr7489481fa.4.1741077538022; Tue, 04 Mar 2025
 00:38:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304064745.1073770-1-superm1@kernel.org>
 <20250304064745.1073770-2-superm1@kernel.org>
In-Reply-To: <20250304064745.1073770-2-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 4 Mar 2025 09:38:46 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
X-Gm-Features: AQ5f1JpjAI-9gJOeNSlj2cu5yvz4Ha_JDUOUTRvXRi_5NSQwyhhl5U7V876IOU0
Message-ID: 
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
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
 <174107753918.9451.10614715536971566650@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When two drivers don't support all the same profiles the legacy interface
> only exports the common profiles.
>
> This causes problems for cases where one driver uses low-power but another
> uses quiet because the result is that neither is exported to sysfs.
>
> If one platform profile handler supports quiet and the other
> supports low power treat them as the same for the purpose of
> the sysfs interface.
>
> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index 2ad53cc6aae53..d9a7cc5891734 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, void *data)
>
>         lockdep_assert_held(&profile_lock);
>         handler = to_pprof_handler(dev);
> -       if (!test_bit(*bit, handler->choices))
> -               return -EOPNOTSUPP;
> +       if (!test_bit(*bit, handler->choices)) {
> +               switch (*bit) {
> +               case PLATFORM_PROFILE_QUIET:
> +                       *bit = PLATFORM_PROFILE_LOW_POWER;
> +                       break;
> +               case PLATFORM_PROFILE_LOW_POWER:
> +                       *bit = PLATFORM_PROFILE_QUIET;
> +                       break;
> +               default:
> +                       return -EOPNOTSUPP;
> +               }
> +               if (!test_bit(*bit, handler->choices))
> +                       return -EOPNOTSUPP;
> +       }
>
>         return handler->ops->profile_set(dev, *bit);
>  }
> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, void *data)
>         handler = to_pprof_handler(dev);
>         if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>                 bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> -       else
> +       else {
> +               /* treat quiet and low power the same for aggregation purposes */
> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
>                 bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
> +       }

So you end up showing both? If that's the case, isn't it equivalent to
just make amd-pmf show both quiet and low-power?

I guess it is not ideal for framework devices. But if asus devices end
up showing both, then it should be ok for framework devices to show
both.

I like the behavior of the V1 personally.

>         return 0;
>  }
> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev, void *data)
>         if (err)
>                 return err;
>
> +       /* treat low-power and quiet as the same */
> +       if ((*profile == PLATFORM_PROFILE_LOW_POWER &&
> +            val == PLATFORM_PROFILE_QUIET) ||
> +           (*profile == PLATFORM_PROFILE_QUIET &&
> +            val == PLATFORM_PROFILE_LOW_POWER))
> +               *profile = val;
> +
>         if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
>                 *profile = PLATFORM_PROFILE_CUSTOM;
>         else
> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struct device *dev, const char *name,
>                 dev_err(dev, "Failed to register platform_profile class device with empty choices\n");
>                 return ERR_PTR(-EINVAL);
>         }
> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
> +               dev_err(dev, "Failed to register platform_profile class device with both quiet and low-power\n");
> +               return ERR_PTR(-EINVAL);
> +       }

Can you avoid failing here? It caused a lot of issues in the past (the
WMI driver bails). a dev_err should be enough. Since you do not fail
maybe it can be increased to dev_crit.

There is at least one driver that implements both currently, and a fix
would have to precede this patch.

>
>         guard(mutex)(&profile_lock);
>
> --
> 2.43.0
>

