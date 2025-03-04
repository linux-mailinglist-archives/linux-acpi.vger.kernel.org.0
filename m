Return-Path: <linux-acpi+bounces-11775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C0A4E02F
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E133A7B73
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B862046BD;
	Tue,  4 Mar 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="JNK14N1h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232111487DD;
	Tue,  4 Mar 2025 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097032; cv=none; b=tlTI4Y5jRWq77LVZdVYZyeislrhdphRSmETaqZe90Hgy/vqYxnzvwHTWC7sbGIIMPqUVA5Y/VlV8D9La4mQ3tigQlmqTpwmZMDVHSTZInaJPY9IYR031YcYi04Y2Lw7zGctqnm2E1yh2qWuILT94ffuEx+MeSPPjw+ifiymMrEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097032; c=relaxed/simple;
	bh=pZESa4CjxHsC+dz7wb9xWFbnt78VKNjbd/+7TfaN+jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dj4YdcpkbU7U/81+IpBx4wDoz/q4l+HmgKID2mxodPbpLcxzz72BhXRJEI9BCg8M9S8wUQFiwmK4V3HYupjG02RCP+3EvwFOnvj6iC89870xo3m9rnHzHSDC35wNtjdALlc4FbJTk/mhOqQcfYzhia9zrdScan1+gfP7heYgRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=JNK14N1h; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id AEEE62E091BB;
	Tue,  4 Mar 2025 16:03:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1741097026;
	bh=krB1PFzlQRAKO+BGJRaPoN+R8wkZbKXjeW3k6hEY2A0=;
	h=Received:From:Subject:To;
	b=JNK14N1h/w2E1NcKhhaxquvg78Yh4y6eZBM4DZBzdYVKMnU59U6c/zdeW5fEfKpQg
	 Nc7e9SyCX6AfOSND/PgJrwHa/aV2/UqJHZq4ws6v6tw2FAJ1JmGoaC/xplVgo0SDFa
	 DB5px30x0BXgUyPepjfNfsEEFRpgQD2dcgm6uLX8=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 2a00:1450:4864:20::236) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-x236.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-30613802a04so57921861fa.2;
        Tue, 04 Mar 2025 06:03:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUmLQlNBWGKku9aLQPnvk/4g166M4WjnCEANtBKNlcDnB8C+d42dZFpJAaSz4opP1W17bpW8RoHWF44a7LH@vger.kernel.org,
 AJvYcCW84dxfsg0imweRDB9sea1PizfWZdsQLRZGDq3kSGtgz2HadC4yiMBYpWkUsvsMm93MFOQDTn52fVnaATzba9aPpzx5dw==@vger.kernel.org,
 AJvYcCWd7S9KQ3hM+DFEIRzxjW0whrXhZUL2jWrCy3tKHBZIsdGgyk12yhCwtPOUmozaRdjgWCrGNDTT/Ryz@vger.kernel.org
X-Gm-Message-State: AOJu0YyArBleOsfxnl26VH1sUOlSSKxNqQrhIaOvH7mLSd8aCUZCYXTp
	Kgv1ftkmP+IvU0swz3Ew4/4koM5aGYk5FEUoSEy3V3Za+yyalEvO3e0oCGjjPIjjX1YPhMG7iet
	a2Dhv2K6YRSmMrhG5CpukZeUvsqQ=
X-Google-Smtp-Source: 
 AGHT+IGgboVaEvW8py0+1iQcd/n/cx7v4bFAQdoogvs/IXQpC5FU6SygXcZQba2f1wz/0S8fnmc8McT1c4ozDpIySCc=
X-Received: by 2002:a2e:bc0f:0:b0:30b:b987:b676 with SMTP id
 38308e7fff4ca-30bb987b8b0mr27757821fa.2.1741096965107; Tue, 04 Mar 2025
 06:02:45 -0800 (PST)
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
 <CAGwozwHXd6frhGCOrm8_tg2=M4sHCu_JBmqodWdKUF+AuL2TNw@mail.gmail.com>
 <D87J6E7DFLS0.1BY00BAZFWEH7@gmail.com>
In-Reply-To: <D87J6E7DFLS0.1BY00BAZFWEH7@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 4 Mar 2025 15:02:32 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwGyntPekopke0iKZdb-rJEm8MRkhrfvfvhn4sJKRxQb9A@mail.gmail.com>
X-Gm-Features: AQ5f1JrxbGIG_Zx2dTptA0gqnUgK1wvTTAv6IB_6CenY6VL35rpFF5HD6uX0mRo
Message-ID: 
 <CAGwozwGyntPekopke0iKZdb-rJEm8MRkhrfvfvhn4sJKRxQb9A@mail.gmail.com>
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
 <174109702609.641.10387405444828925985@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 4 Mar 2025 at 14:55, Kurt Borja <kuurtb@gmail.com> wrote:
>
> On Tue Mar 4, 2025 at 8:32 AM -05, Antheas Kapenekakis wrote:
> > On Tue, 4 Mar 2025 at 14:28, Kurt Borja <kuurtb@gmail.com> wrote:
> >>
> >> Hi all,
> >>
> >> On Tue Mar 4, 2025 at 7:49 AM -05, Mario Limonciello wrote:
> >> >
> >> >
> >> > On 3/4/25 02:38, Antheas Kapenekakis wrote:
> >> >> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wrote:
> >> >>>
> >> >>> From: Mario Limonciello <mario.limonciello@amd.com>
> >> >>>
> >> >>> When two drivers don't support all the same profiles the legacy interface
> >> >>> only exports the common profiles.
> >> >>>
> >> >>> This causes problems for cases where one driver uses low-power but another
> >> >>> uses quiet because the result is that neither is exported to sysfs.
> >> >>>
> >> >>> If one platform profile handler supports quiet and the other
> >> >>> supports low power treat them as the same for the purpose of
> >> >>> the sysfs interface.
> >> >>>
> >> >>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
> >> >>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> >>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> >> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> >>> ---
> >> >>>   drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++---
> >> >>>   1 file changed, 35 insertions(+), 3 deletions(-)
> >> >>>
> >> >>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> >> >>> index 2ad53cc6aae53..d9a7cc5891734 100644
> >> >>> --- a/drivers/acpi/platform_profile.c
> >> >>> +++ b/drivers/acpi/platform_profile.c
> >> >>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, void *data)
> >> >>>
> >> >>>          lockdep_assert_held(&profile_lock);
> >> >>>          handler = to_pprof_handler(dev);
> >> >>> -       if (!test_bit(*bit, handler->choices))
> >> >>> -               return -EOPNOTSUPP;
> >> >>> +       if (!test_bit(*bit, handler->choices)) {
> >> >>> +               switch (*bit) {
> >> >>> +               case PLATFORM_PROFILE_QUIET:
> >> >>> +                       *bit = PLATFORM_PROFILE_LOW_POWER;
> >> >>> +                       break;
> >> >>> +               case PLATFORM_PROFILE_LOW_POWER:
> >> >>> +                       *bit = PLATFORM_PROFILE_QUIET;
> >> >>> +                       break;
> >> >>> +               default:
> >> >>> +                       return -EOPNOTSUPP;
> >> >>> +               }
> >> >>> +               if (!test_bit(*bit, handler->choices))
> >> >>> +                       return -EOPNOTSUPP;
> >> >>> +       }
> >> >>>
> >> >>>          return handler->ops->profile_set(dev, *bit);
> >> >>>   }
> >> >>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, void *data)
> >> >>>          handler = to_pprof_handler(dev);
> >> >>>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> >> >>>                  bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
> >> >>> -       else
> >> >>> +       else {
> >> >>> +               /* treat quiet and low power the same for aggregation purposes */
> >> >>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) &&
> >> >>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
> >> >>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
> >> >>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->choices) &&
> >> >>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
> >> >>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
> >> >>>                  bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
> >> >>> +       }
> >> >>
> >> >> So you end up showing both? If that's the case, isn't it equivalent to
> >> >> just make amd-pmf show both quiet and low-power?
> >> >>
> >> >> I guess it is not ideal for framework devices. But if asus devices end
> >> >> up showing both, then it should be ok for framework devices to show
> >> >> both.
> >> >>
> >> >> I like the behavior of the V1 personally.
> >> >
> >> > No; this doesn't cause it to show both.  It only causes one to show up.
> >> > I confirmed it with a contrived situation on my laptop that forced
> >> > multiple profile handlers that supported a mix.
> >> >
> >> >
> >> > # cat /sys/firmware/acpi/platform_profile*
> >> > low-power
> >> > low-power balanced performance
> >> >
> >> > # cat /sys/class/platform-profile/platform-profile-*/profile
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > quiet
> >> > low-power
> >> >
> >> >>
> >> >>>          return 0;
> >> >>>   }
> >> >>> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev, void *data)
> >> >>>          if (err)
> >> >>>                  return err;
> >> >>>
> >> >>> +       /* treat low-power and quiet as the same */
> >> >>> +       if ((*profile == PLATFORM_PROFILE_LOW_POWER &&
> >> >>> +            val == PLATFORM_PROFILE_QUIET) ||
> >> >>> +           (*profile == PLATFORM_PROFILE_QUIET &&
> >> >>> +            val == PLATFORM_PROFILE_LOW_POWER))
> >> >>> +               *profile = val;
> >> >>> +
> >> >>>          if (*profile != PLATFORM_PROFILE_LAST && *profile != val)
> >> >>>                  *profile = PLATFORM_PROFILE_CUSTOM;
> >> >>>          else
> >> >>> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struct device *dev, const char *name,
> >> >>>                  dev_err(dev, "Failed to register platform_profile class device with empty choices\n");
> >> >>>                  return ERR_PTR(-EINVAL);
> >> >>>          }
> >> >>> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
> >> >>> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
> >> >>> +               dev_err(dev, "Failed to register platform_profile class device with both quiet and low-power\n");
> >> >>> +               return ERR_PTR(-EINVAL);
> >> >>> +       }
> >> >>
> >> >> Can you avoid failing here? It caused a lot of issues in the past (the
> >> >> WMI driver bails). a dev_err should be enough. Since you do not fail
> >> >> maybe it can be increased to dev_crit.
> >> >>
> >> >> There is at least one driver that implements both currently, and a fix
> >> >> would have to precede this patch.
> >> >
> >> > Oh, acer-wmi?  Kurt; can you please comment?  Are both simultaneous?
> >>
> >> There are a few laptops supported by alienware-wmi that definitely have
> >> both (including mine). The acer-wmi and the samsung-galaxybook drivers
> >> also probe for available choices dynamically, so some of those devices
> >> may be affected by this too.
> >>
> >> So yes, we shouldn't fail registration here.
> >>
> >> Anyway, I like this approach more than v1. What do you think about
> >> constraining this fix to the legacy interface?
> >
> > AFAIK new interface is ok and should not be modified. None of the
> > previous solutions touched it (well, changing quiet to low-power did).
> > But I still expect the legacy interface to work the same way on 6.14.
>
> This patch also permanently alias quiet and low-power for the new
> interface, if either one is not available.

Mmm, aliasing it as a hidden option is more of a side effect. I guess
if people start relying on that it might become problematic to revert
though.

> >
> > What happens if there is one handler that does low-power and one that
> > does quiet? Is one choice preferred? And then are writes accepted in
> > both?
> >
> > I cannot have the same device requiring low-power and quiet depending
> > on kernel version or boot. I do tdp controls per manufacturer.
>
> I'm not sure what you mean here.

You have an Asus Z13, in 6.13 it reports low-power, in 6.14 it reports
quiet. This patch series fixes writing blindly to it I would say, not
so much reading from it. Although it is unclear who that would affect.
I think reading will become a bigger problem in the future, as
Legion/Thinkpad devices can change their platform profile via user
action, and I would expect ppd/tuned to respond to that. They do not
currently. By the point they do, they can use the modern ABI though,
and bind bidirectionality to the /name attribute of platform profiles.

> --
>  ~ Kurt
>
> >
> >> --
> >>  ~ Kurt
> >>
> >> >
> >> >>
> >> >>>
> >> >>>          guard(mutex)(&profile_lock);
> >> >>>
> >> >>> --
> >> >>> 2.43.0
> >> >>>
> >>
>

