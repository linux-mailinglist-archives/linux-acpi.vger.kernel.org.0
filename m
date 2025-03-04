Return-Path: <linux-acpi+bounces-11769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F4A4DF54
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B13189C119
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C32036F5;
	Tue,  4 Mar 2025 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="gLJy1ejd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910F20468B;
	Tue,  4 Mar 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095189; cv=none; b=Y3hP4UNMlOqxpUvB8yGNCzq/J/eijoEFFNpvMQyXTESwOcc9htYquaEtuNJpxQtuwi8Eq5tNxYcT7aLjMhQ3rZ7lmzQJ4fPSD9amyuq4X9TEQl3E5BeXyAByDGsK03d1lw1VdoWlkusuyNEbnRYqZ3sB1wXqcgfKIKxpKTUWAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095189; c=relaxed/simple;
	bh=YnYgnuFiJcvRbglnW4qeuD/xeoyxKWA7Hj2cyb/Cg9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epyXgn0IE75ukF9wDTad/fUNNH4rGNiQ+BtTNW/wawnz0JZQHoFAtcyk1XFCPvVypSduT/6WnnEq9HwvBEaVFeZnk5GY5jWaKdj2DxrwhaC0Ifrbk/3L3/4VHXpe+fPYfC3cegnUuVUgKWqUl1kZNp2USg4ioWRV70gHPyeR3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=gLJy1ejd; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id B6BA82E09309;
	Tue,  4 Mar 2025 15:33:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741095184;
	bh=vyn6r8Ef5vwPxEzywYuIAc025PJ3qE8Ywi5S8YGq4RE=;
	h=Received:From:Subject:To;
	b=gLJy1ejdaY1clY68Fgk6HPDRW2ntElMYUt/Iq1GvZ6F4adRY3EaHbjfOrIDT4Y270
	 sElTRwG1boz8PStE1tYuITUJHUkjCJ7oS7DtagelcW87XkMfRc7xbvD+FnOyj5JNIG
	 fGkpZXJ6LeHdYvg4gQIrEyZMLTVb6ysQCmHE+Ue4=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-30ba563a6d1so32433391fa.1;
        Tue, 04 Mar 2025 05:33:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUMW1be/N4V2007DqECPRzgN3pX2budbTV05wE8sKaRNlvHjiWt8zQD86iS2Ujwq54nGEwEvVqZ66Ev3VmsWeDkTlpbZw==@vger.kernel.org,
 AJvYcCUZxHd2O7GkoIUmF8zX+t06H31MgbyyFXCZFllIPE3Yo23zvPwgP8AYvyEF9zgqzBWvy8HCiDbdL6xY@vger.kernel.org,
 AJvYcCVPCHqI2Kfm+fGHtwluMLkSvTTce27VHBv1YUT8pnVSpOIbCtAc69Y0Fy2iXku1BNRfRoo7rsER1rozin5I@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZhNXXZ/oeFAqr1Y/76n4V0NNDM/9nmJ64it9NGpQcDoBuJbI
	lUusjvPI2iCCg9vUt8SYpJ3N3ZTt0HDSwkWdmhSj3Uee9NPoD9y6fSWqHe6h84OXNHit9y5bwv4
	fJV+zcAeQK0M9qiUxQ0j6UvTODJc=
X-Google-Smtp-Source: 
 AGHT+IFkn/kikKUraD/5XiwZdb9pte4mvhxOULdf+gv+yG4qtQxMxYIjAFaOExSFAsChnCEML1/gDU1f2N/qLKEG+qQ=
X-Received: by 2002:a05:651c:1504:b0:302:3356:35d7 with SMTP id
 38308e7fff4ca-30bcaa4414bmr10516361fa.18.1741095183050; Tue, 04 Mar 2025
 05:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304064745.1073770-1-superm1@kernel.org>
 <20250304064745.1073770-2-superm1@kernel.org>
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
 <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
 <D87ILMWSRUPG.3FHTWG38N2IFJ@gmail.com>
In-Reply-To: <D87ILMWSRUPG.3FHTWG38N2IFJ@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 4 Mar 2025 14:32:50 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHXd6frhGCOrm8_tg2=M4sHCu_JBmqodWdKUF+AuL2TNw@mail.gmail.com>
X-Gm-Features: AQ5f1JpKJ7cFMC3eaKL3idZCgdX7APstwLjl1Xk3sn_JA_FflegyLduPwFaORrY
Message-ID: 
 <CAGwozwHXd6frhGCOrm8_tg2=M4sHCu_JBmqodWdKUF+AuL2TNw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
To: Kurt Borja <kuurtb@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
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
 <174109518423.29827.8781867911203852704@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 4 Mar 2025 at 14:28, Kurt Borja <kuurtb@gmail.com> wrote:
>
> Hi all,
>
> On Tue Mar 4, 2025 at 7:49 AM -05, Mario Limonciello wrote:
> >
> >
> > On 3/4/25 02:38, Antheas Kapenekakis wrote:
> >> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wrote:
> >>>
> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> When two drivers don't support all the same profiles the legacy interface
> >>> only exports the common profiles.
> >>>
> >>> This causes problems for cases where one driver uses low-power but another
> >>> uses quiet because the result is that neither is exported to sysfs.
> >>>
> >>> If one platform profile handler supports quiet and the other
> >>> supports low power treat them as the same for the purpose of
> >>> the sysfs interface.
> >>>
> >>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
> >>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>> ---
> >>>   drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++---
> >>>   1 file changed, 35 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> >>> index 2ad53cc6aae53..d9a7cc5891734 100644
> >>> --- a/drivers/acpi/platform_profile.c
> >>> +++ b/drivers/acpi/platform_profile.c
> >>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, void *data)
> >>>
> >>>          lockdep_assert_held(&profile_lock);
> >>>          handler = to_pprof_handler(dev);
> >>> -       if (!test_bit(*bit, handler->choices))
> >>> -               return -EOPNOTSUPP;
> >>> +       if (!test_bit(*bit, handler->choices)) {
> >>> +               switch (*bit) {
> >>> +               case PLATFORM_PROFILE_QUIET:
> >>> +                       *bit = PLATFORM_PROFILE_LOW_POWER;
> >>> +                       break;
> >>> +               case PLATFORM_PROFILE_LOW_POWER:
> >>> +                       *bit = PLATFORM_PROFILE_QUIET;
> >>> +                       break;
> >>> +               default:
> >>> +                       return -EOPNOTSUPP;
> >>> +               }
> >>> +               if (!test_bit(*bit, handler->choices))
> >>> +                       return -EOPNOTSUPP;
> >>> +       }
> >>>
> >>>          return handler->ops->profile_set(dev, *bit);
> >>>   }
> >>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, void *data)
> >>>          handler = to_pprof_handler(dev);
> >>>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> >>>                  bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> >>> -       else
> >>> +       else {
> >>> +               /* treat quiet and low power the same for aggregation purposes */
> >>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
> >>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
> >>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
> >>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
> >>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
> >>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
> >>>                  bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
> >>> +       }
> >>
> >> So you end up showing both? If that's the case, isn't it equivalent to
> >> just make amd-pmf show both quiet and low-power?
> >>
> >> I guess it is not ideal for framework devices. But if asus devices end
> >> up showing both, then it should be ok for framework devices to show
> >> both.
> >>
> >> I like the behavior of the V1 personally.
> >
> > No; this doesn't cause it to show both.  It only causes one to show up.
> > I confirmed it with a contrived situation on my laptop that forced
> > multiple profile handlers that supported a mix.
> >
> >
> > # cat /sys/firmware/acpi/platform_profile*
> > low-power
> > low-power balanced performance
> >
> > # cat /sys/class/platform-profile/platform-profile-*/profile
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > quiet
> > low-power
> >
> >>
> >>>          return 0;
> >>>   }
> >>> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev, void *data)
> >>>          if (err)
> >>>                  return err;
> >>>
> >>> +       /* treat low-power and quiet as the same */
> >>> +       if ((*profile == PLATFORM_PROFILE_LOW_POWER &&
> >>> +            val == PLATFORM_PROFILE_QUIET) ||
> >>> +           (*profile == PLATFORM_PROFILE_QUIET &&
> >>> +            val == PLATFORM_PROFILE_LOW_POWER))
> >>> +               *profile = val;
> >>> +
> >>>          if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
> >>>                  *profile = PLATFORM_PROFILE_CUSTOM;
> >>>          else
> >>> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struct device *dev, const char *name,
> >>>                  dev_err(dev, "Failed to register platform_profile class device with empty choices\n");
> >>>                  return ERR_PTR(-EINVAL);
> >>>          }
> >>> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
> >>> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
> >>> +               dev_err(dev, "Failed to register platform_profile class device with both quiet and low-power\n");
> >>> +               return ERR_PTR(-EINVAL);
> >>> +       }
> >>
> >> Can you avoid failing here? It caused a lot of issues in the past (the
> >> WMI driver bails). a dev_err should be enough. Since you do not fail
> >> maybe it can be increased to dev_crit.
> >>
> >> There is at least one driver that implements both currently, and a fix
> >> would have to precede this patch.
> >
> > Oh, acer-wmi?  Kurt; can you please comment?  Are both simultaneous?
>
> There are a few laptops supported by alienware-wmi that definitely have
> both (including mine). The acer-wmi and the samsung-galaxybook drivers
> also probe for available choices dynamically, so some of those devices
> may be affected by this too.
>
> So yes, we shouldn't fail registration here.
>
> Anyway, I like this approach more than v1. What do you think about
> constraining this fix to the legacy interface?

AFAIK new interface is ok and should not be modified. None of the
previous solutions touched it (well, changing quiet to low-power did).
But I still expect the legacy interface to work the same way on 6.14.

What happens if there is one handler that does low-power and one that
does quiet? Is one choice preferred? And then are writes accepted in
both?

I cannot have the same device requiring low-power and quiet depending
on kernel version or boot. I do tdp controls per manufacturer.

> --
>  ~ Kurt
>
> >
> >>
> >>>
> >>>          guard(mutex)(&profile_lock);
> >>>
> >>> --
> >>> 2.43.0
> >>>
>

