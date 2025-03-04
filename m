Return-Path: <linux-acpi+bounces-11767-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB0A4DEAD
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1258D7ABBA8
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7054202C5D;
	Tue,  4 Mar 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="sblV3Ovx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C40442C;
	Tue,  4 Mar 2025 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093604; cv=none; b=lfPoVC4KbgPcmF8xq5ge/czp1W7+q8jpi9eK2YUhG5JPKjj9C0UsMxSRssS1Zlutvu/FkaU2OUWxzncuyI+DBMcxbOHbu3HjBoHI3R5UMyPPQgr/aG8dmmr1ueN57pP2vX90pXJee8nWbt32/zg3nwzt3sdkL3zhvJoWlwWxN3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093604; c=relaxed/simple;
	bh=2qFKPgKeSpXTxp5Z7iZJSjbB0aua6k7j3YFcJG4fNvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQXZaTP0lgUhpRLJHSyqcR4bonqyLD7o2IxpWmZ5WzEzNgWUJrYMKr7frzorrRDGUjW3nIeqXDnrRcsdpFPXgRtBMRdU5jVAPjIEaooaHbP2+e23JW7+Pp5ITiUUy2pLY/sqGCF2LXW3/ED7AkorR6lH4o6+N0GsnkMNLFFvFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=sblV3Ovx; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 602E12E09248;
	Tue,  4 Mar 2025 15:06:33 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741093597;
	bh=XyB/DGaQkImLkGe99KO54A695D+1O0zvTZx7KK1o7qc=;
	h=Received:From:Subject:To;
	b=sblV3OvxcufcZeJwjUtftOq7C+F+2uY3VHKmUARnHm0cFo1jAzriIHTeL7krwhs43
	 HE4vnLvcOj16PFGkpA8ba98+BqAbSA0UGr1tChhoYAQoEcP3PpHsUW2HN1vTTrxgc5
	 h90uNi+sTVLmBPQpgQB6X9nEUmY/xY7x6alhysnw=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.42) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f42.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-547bcef2f96so6340823e87.1;
        Tue, 04 Mar 2025 05:06:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVyVqUzGOszSzqD1klHi8pMc1fbUEwBvni9U6KpmiJlUU5E94kzqvH2AtFfUqxV73+TywHL61rPzoBIpnma2P/lVzMRgA==@vger.kernel.org,
 AJvYcCWrHwy59lJBi0hqGoTJ8FWP7q2DVCsy4FQGd4gF5tQJXnsQDGR9Xuvkc1iwpvE1NWJgAqTl3j8g9nL9SFRQ@vger.kernel.org,
 AJvYcCX419kcpZAvLLy6LNsfJHnfoHbQQ0u3GYaOcYyvK0fKYiOiJ+84bwOdhI46n/MstDd4vqNOL9NEvmrH@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKs3qsBZof7xMtt53oBHS+B9HmpDO+ehxpSGRWT7J+9zaopok
	OGLSuVOXhxwdKuKJ3nIoKju6LMCSHnkUUma3xjr2GGYeP5nq52+lQoaMw+bSo2fuvVEpXOwgG3e
	oHsGeMwrfcVuk+zstoCLFDt4Ri8c=
X-Google-Smtp-Source: 
 AGHT+IFJsSNNyRwEAefYPtBzSpVROivz24nz3zetzkFWa1k9sdlp2Tv3EG40u6Jg9A2pWi68fJtr3aIhUNxR4yK51pI=
X-Received: by 2002:a05:6512:1103:b0:545:d54:2ebe with SMTP id
 2adb3069b0e04-5494c36c16dmr6539057e87.43.1741093592629; Tue, 04 Mar 2025
 05:06:32 -0800 (PST)
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
In-Reply-To: <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 4 Mar 2025 14:06:21 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE0qn_vypYHpfJY8muo=e6XuLRJ6d9Fy_LSAa5VG=sEgg@mail.gmail.com>
X-Gm-Features: AQ5f1Jq8Nt82M34pyIU1pZ1pM_EAc5ddAiY26i3J3wjOWWxvYJzHwrbkXyW9qw8
Message-ID: 
 <CAGwozwE0qn_vypYHpfJY8muo=e6XuLRJ6d9Fy_LSAa5VG=sEgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
To: Mario Limonciello <superm1@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>,
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
 <174109359388.10457.17049499079140763422@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 4 Mar 2025 at 13:49, Mario Limonciello <superm1@kernel.org> wrote:
>
>
>
> On 3/4/25 02:38, Antheas Kapenekakis wrote:
> > On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When two drivers don't support all the same profiles the legacy interface
> >> only exports the common profiles.
> >>
> >> This causes problems for cases where one driver uses low-power but another
> >> uses quiet because the result is that neither is exported to sysfs.
> >>
> >> If one platform profile handler supports quiet and the other
> >> supports low power treat them as the same for the purpose of
> >> the sysfs interface.
> >>
> >> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
> >> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++---
> >>   1 file changed, 35 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> >> index 2ad53cc6aae53..d9a7cc5891734 100644
> >> --- a/drivers/acpi/platform_profile.c
> >> +++ b/drivers/acpi/platform_profile.c
> >> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, void *data)
> >>
> >>          lockdep_assert_held(&profile_lock);
> >>          handler = to_pprof_handler(dev);
> >> -       if (!test_bit(*bit, handler->choices))
> >> -               return -EOPNOTSUPP;
> >> +       if (!test_bit(*bit, handler->choices)) {
> >> +               switch (*bit) {
> >> +               case PLATFORM_PROFILE_QUIET:
> >> +                       *bit = PLATFORM_PROFILE_LOW_POWER;
> >> +                       break;
> >> +               case PLATFORM_PROFILE_LOW_POWER:
> >> +                       *bit = PLATFORM_PROFILE_QUIET;
> >> +                       break;
> >> +               default:
> >> +                       return -EOPNOTSUPP;
> >> +               }
> >> +               if (!test_bit(*bit, handler->choices))
> >> +                       return -EOPNOTSUPP;
> >> +       }
> >>
> >>          return handler->ops->profile_set(dev, *bit);
> >>   }
> >> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, void *data)
> >>          handler = to_pprof_handler(dev);
> >>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> >>                  bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> >> -       else
> >> +       else {
> >> +               /* treat quiet and low power the same for aggregation purposes */
> >> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
> >> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
> >> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
> >> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
> >> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
> >> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
> >>                  bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
> >> +       }
> >
> > So you end up showing both? If that's the case, isn't it equivalent to
> > just make amd-pmf show both quiet and low-power?
> >
> > I guess it is not ideal for framework devices. But if asus devices end
> > up showing both, then it should be ok for framework devices to show
> > both.
> >
> > I like the behavior of the V1 personally.
>
> No; this doesn't cause it to show both.  It only causes one to show up.
> I confirmed it with a contrived situation on my laptop that forced
> multiple profile handlers that supported a mix.

If you can somehow force it to show the same option every time with a
tie breaker against amd-pmf it should be good enough. Still does not
solve balanced-power so unlike V1 it is not a permanent fix. Hidden
options was a nice tiebreaker imo.

>
> # cat /sys/firmware/acpi/platform_profile*
> low-power
> low-power balanced performance
>
> # cat /sys/class/platform-profile/platform-profile-*/profile
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> quiet
> low-power
>
> >
> >>          return 0;
> >>   }
> >> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev, void *data)
> >>          if (err)
> >>                  return err;
> >>
> >> +       /* treat low-power and quiet as the same */
> >> +       if ((*profile == PLATFORM_PROFILE_LOW_POWER &&
> >> +            val == PLATFORM_PROFILE_QUIET) ||
> >> +           (*profile == PLATFORM_PROFILE_QUIET &&
> >> +            val == PLATFORM_PROFILE_LOW_POWER))
> >> +               *profile = val;
> >> +
> >>          if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
> >>                  *profile = PLATFORM_PROFILE_CUSTOM;
> >>          else
> >> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struct device *dev, const char *name,
> >>                  dev_err(dev, "Failed to register platform_profile class device with empty choices\n");
> >>                  return ERR_PTR(-EINVAL);
> >>          }
> >> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
> >> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
> >> +               dev_err(dev, "Failed to register platform_profile class device with both quiet and low-power\n");
> >> +               return ERR_PTR(-EINVAL);
> >> +       }
> >
> > Can you avoid failing here? It caused a lot of issues in the past (the
> > WMI driver bails). a dev_err should be enough. Since you do not fail
> > maybe it can be increased to dev_crit.
> >
> > There is at least one driver that implements both currently, and a fix
> > would have to precede this patch.
>
> Oh, acer-wmi?  Kurt; can you please comment?  Are both simultaneous?

I do not have access to my kernel tree but when looking at it I
remember an if block that did a set_bit on both for certain laptops in
one of the drivers. Unsure if it was acer. But it was not ambiguous.

> >
> >>
> >>          guard(mutex)(&profile_lock);
> >>
> >> --
> >> 2.43.0
> >>
>

