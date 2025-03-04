Return-Path: <linux-acpi+bounces-11773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A02A4DFC9
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C25188A4A3
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD172046BD;
	Tue,  4 Mar 2025 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRNnieV+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596461FDA9E;
	Tue,  4 Mar 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096392; cv=none; b=YpBcyOGL0Dq1zJMhYJgKkLR80NCisP3qW6sEShw2cyGOCeNHpLkkrK7mt+yqmggdlSdTg9zUMLKxBAwinHcwlnp7V1WouHwe2/1WfOJCBkEljzASlOxhk+iehZlB1D4thqLsXp07prupl8xJWbbSA9RS8c3z9gKpTOJJSoTeVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096392; c=relaxed/simple;
	bh=vSYR8sdDA9fpVrVLnZW1YgDZO2SdMWKSj9j/BO8k8og=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pLN1UpVBzGtsLxvinYlwHWNoDt7xHAKCWitbpd8cjzQr3vOA3ZXV9tNMkjtFP5/G4TsxpbNLFGMno9oEWlp+W14oFF+6JUEaCSFHW48OmU4tgy1hrlqJqVZYAGACYvLJIADmBsm+IlZpy3rIeVy7MyYteYF2HDSCg336jmVe164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRNnieV+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so8987809a91.2;
        Tue, 04 Mar 2025 05:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741096389; x=1741701189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S7G7WaJIfv7aTRMF48OU/T3y/D9ykES0eI4crfxP85E=;
        b=IRNnieV+d3GgWpJP7CSaiuVLafl7UlbdWbT/EshdJwPUbvsWQqAtaeCEPL1s+JbGO9
         HkSHdvu9+GDyAOy4NsXen3D9gIXrUc+vkkFrU7L/sINUMvhmAXW30aIPWmF68hhu3gfo
         bOZYQ6wv86EmXdE3fkQpk8i+1YxE7AUg0jcsM4D8SJRbVuCClUoIZ2YGu53+ioxRYh8y
         B79qmrjgUwqXtnjjLNEiUMYSNPScgB4hD5zklqlNR0ol+iRjBu0A6/citnRy7wIELoMm
         bcBsFx66BJw2wGXTwhr7dgNoC3PmgJPH67jlMGgy644EhX5w0fdWS64gZ2ujtX0w56Uf
         adpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096389; x=1741701189;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7G7WaJIfv7aTRMF48OU/T3y/D9ykES0eI4crfxP85E=;
        b=rD8ghTdiN4rofr0ejmamGqb2l0Mp1yriToMnTTzd3yInA5KanZLXnoljlGOWJWUxNH
         Fnm6EnKzeD5RW5/xpp40IixPZeFp8xC+W9W1vb5k666MiZaEESnT48/BnPzy39lBeNIm
         dE5YzFGleg0DIMgqqhU2VnHP+67v13b8O/PzVXyNoj7MzRFVcNeJ5G8Bx+DqVB79e/R0
         pPVFZp+PoTAA0N+og7FAfp9JgwtGsi43FbfIIM6GvGo9NB0nDVquJEQIsSU/5RufnZLf
         /6qyse6xwhBuyfHy/dROJwSuSyAEDdI2lLqGZDxF+UPa2DTHUqL4ej8szI40wbs0H3pr
         7mmw==
X-Forwarded-Encrypted: i=1; AJvYcCU2XO6Vn+wiR9GzFlhT6uH+XrKQWAEYd2yqjVaHPmt71x13dMAMCuhLZcTo5bwEJYHRteSmiFy1r9y/f8yUOFvD6TJTYw==@vger.kernel.org, AJvYcCU534vIfV3tChRLY0X1aM797TiEel0bK65izm0llavOFTfNsPQW+vLXwyAFdSDSmAXwWyKZvv557l1Wpd+B@vger.kernel.org, AJvYcCVsM0tkK8bN/9mMDm2o61k7E+dFailm2dwNuedFUH1mR69Lvm9Z7/yvlRNlR2utu9vrn5jO7N2uuLpz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RzXBAfPnqNiNs/YtMGJ5OLmTSJHHI4J8bGKlHD4Au/aYIdc2
	9a+Vhoxzzt9SfKgi8qveAwD89P9KqBivAqXvt2+udXOsh9pMCA2g
X-Gm-Gg: ASbGncsLGRGDRyXXahtOdmyWqm2hs2URPh/eA6mEyJOgQ0nozeBpHWa5E1ilIhc4ZOC
	n9WYomzbcoAVuB8IfXjuPCm/w5Ngefjf0LwQYx3dkSWoTaRrAOoPHnUgjnNNCN55dh4tzfRIGcA
	aQdildW9D5X/Ly+tJHCSENHJ5GEh0Vz8yQIoyNZdFa/gHgd43TB1Jmlvp7g681ZBg0fu6+A75bB
	G3h/4wPk6ok9oL67YTd0rG/dQzHVfpWf52ElpF5/E+Ibk/pAxQ5JyGRpAkvDsrsbfycNYmC5nxU
	2HcFWcKHKX4a8nx5ms+IQEbkIBNL2m9jvoy9uXzBvAX1mfcwgVXqhe0VPZ9VV0FbW4yu2p8zfuH
	MmKxVJb7cx4ws/xUQoRcFn961V3JH
X-Google-Smtp-Source: AGHT+IE8J+Wh6ctCfgIGfvagh5SKOHkxEowX3znJ61vfw6UHeIXceQ0WHhx7umoYyIIZJj3IAUUF3w==
X-Received: by 2002:a05:6a00:10d5:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-73654c9e5damr11050807b3a.15.1741096389449;
        Tue, 04 Mar 2025 05:53:09 -0800 (PST)
Received: from [127.0.0.1] (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736290957f1sm8389380b3a.67.2025.03.04.05.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 05:53:08 -0800 (PST)
Date: Tue, 04 Mar 2025 05:53:07 -0800
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, Kurt Borja <kuurtb@gmail.com>
CC: Mario Limonciello <superm1@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_ACPI=3A_platform=5Fprof?=
 =?US-ASCII?Q?ile=3A_Treat_quiet_and_low_power_the_same?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAGwozwHXd6frhGCOrm8_tg2=M4sHCu_JBmqodWdKUF+AuL2TNw@mail.gmail.com>
References: <20250304064745.1073770-1-superm1@kernel.org> <20250304064745.1073770-2-superm1@kernel.org> <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com> <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org> <D87ILMWSRUPG.3FHTWG38N2IFJ@gmail.com> <CAGwozwHXd6frhGCOrm8_tg2=M4sHCu_JBmqodWdKUF+AuL2TNw@mail.gmail.com>
Message-ID: <176C0445-D930-4812-890B-DA4F3221F382@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 4, 2025 5:32:50 AM PST, Antheas Kapenekakis <lkml@antheas=2Edev> =
wrote:
>On Tue, 4 Mar 2025 at 14:28, Kurt Borja <kuurtb@gmail=2Ecom> wrote:
>>
>> Hi all,
>>
>> On Tue Mar 4, 2025 at 7:49 AM -05, Mario Limonciello wrote:
>> >
>> >
>> > On 3/4/25 02:38, Antheas Kapenekakis wrote:
>> >> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel=2Eorg=
> wrote:
>> >>>
>> >>> From: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>
>> >>>
>> >>> When two drivers don't support all the same profiles the legacy int=
erface
>> >>> only exports the common profiles=2E
>> >>>
>> >>> This causes problems for cases where one driver uses low-power but =
another
>> >>> uses quiet because the result is that neither is exported to sysfs=
=2E
>> >>>
>> >>> If one platform profile handler supports quiet and the other
>> >>> supports low power treat them as the same for the purpose of
>> >>> the sysfs interface=2E
>> >>>
>> >>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handle=
rs")
>> >>> Reported-by: Antheas Kapenekakis <lkml@antheas=2Edev>
>> >>> Closes: https://lore=2Ekernel=2Eorg/platform-driver-x86/e64b771e-32=
55-42ad-9257-5b8fc6c24ac9@gmx=2Ede/T/#mc068042dd29df36c16c8af92664860fc4763=
974b
>> >>> Signed-off-by: Mario Limonciello <mario=2Elimonciello@amd=2Ecom>
>> >>> ---
>> >>>   drivers/acpi/platform_profile=2Ec | 38 ++++++++++++++++++++++++++=
++++---
>> >>>   1 file changed, 35 insertions(+), 3 deletions(-)
>> >>>
>> >>> diff --git a/drivers/acpi/platform_profile=2Ec b/drivers/acpi/platf=
orm_profile=2Ec
>> >>> index 2ad53cc6aae53=2E=2Ed9a7cc5891734 100644
>> >>> --- a/drivers/acpi/platform_profile=2Ec
>> >>> +++ b/drivers/acpi/platform_profile=2Ec
>> >>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *d=
ev, void *data)
>> >>>
>> >>>          lockdep_assert_held(&profile_lock);
>> >>>          handler =3D to_pprof_handler(dev);
>> >>> -       if (!test_bit(*bit, handler->choices))
>> >>> -               return -EOPNOTSUPP;
>> >>> +       if (!test_bit(*bit, handler->choices)) {
>> >>> +               switch (*bit) {
>> >>> +               case PLATFORM_PROFILE_QUIET:
>> >>> +                       *bit =3D PLATFORM_PROFILE_LOW_POWER;
>> >>> +                       break;
>> >>> +               case PLATFORM_PROFILE_LOW_POWER:
>> >>> +                       *bit =3D PLATFORM_PROFILE_QUIET;
>> >>> +                       break;
>> >>> +               default:
>> >>> +                       return -EOPNOTSUPP;
>> >>> +               }
>> >>> +               if (!test_bit(*bit, handler->choices))
>> >>> +                       return -EOPNOTSUPP;
>> >>> +       }
>> >>>
>> >>>          return handler->ops->profile_set(dev, *bit);
>> >>>   }
>> >>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *d=
ev, void *data)
>> >>>          handler =3D to_pprof_handler(dev);
>> >>>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>> >>>                  bitmap_copy(aggregate, handler->choices, PLATFORM_=
PROFILE_LAST);
>> >>> -       else
>> >>> +       else {
>> >>> +               /* treat quiet and low power the same for aggregati=
on purposes */
>> >>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choic=
es) &&
>> >>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate)=
)
>> >>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
>> >>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handl=
er->choices) &&
>> >>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate=
))
>> >>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggrega=
te);
>> >>>                  bitmap_and(aggregate, handler->choices, aggregate,=
 PLATFORM_PROFILE_LAST);
>> >>> +       }
>> >>
>> >> So you end up showing both? If that's the case, isn't it equivalent =
to
>> >> just make amd-pmf show both quiet and low-power?
>> >>
>> >> I guess it is not ideal for framework devices=2E But if asus devices=
 end
>> >> up showing both, then it should be ok for framework devices to show
>> >> both=2E
>> >>
>> >> I like the behavior of the V1 personally=2E
>> >
>> > No; this doesn't cause it to show both=2E  It only causes one to show=
 up=2E
>> > I confirmed it with a contrived situation on my laptop that forced
>> > multiple profile handlers that supported a mix=2E
>> >
>> >
>> > # cat /sys/firmware/acpi/platform_profile*
>> > low-power
>> > low-power balanced performance
>> >
>> > # cat /sys/class/platform-profile/platform-profile-*/profile
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > quiet
>> > low-power
>> >
>> >>
>> >>>          return 0;
>> >>>   }
>> >>> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *=
dev, void *data)
>> >>>          if (err)
>> >>>                  return err;
>> >>>
>> >>> +       /* treat low-power and quiet as the same */
>> >>> +       if ((*profile =3D=3D PLATFORM_PROFILE_LOW_POWER &&
>> >>> +            val =3D=3D PLATFORM_PROFILE_QUIET) ||
>> >>> +           (*profile =3D=3D PLATFORM_PROFILE_QUIET &&
>> >>> +            val =3D=3D PLATFORM_PROFILE_LOW_POWER))
>> >>> +               *profile =3D val;
>> >>> +
>> >>>          if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D v=
al)
>> >>>                  *profile =3D PLATFORM_PROFILE_CUSTOM;
>> >>>          else
>> >>> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struc=
t device *dev, const char *name,
>> >>>                  dev_err(dev, "Failed to register platform_profile =
class device with empty choices\n");
>> >>>                  return ERR_PTR(-EINVAL);
>> >>>          }
>> >>> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
>> >>> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
>> >>> +               dev_err(dev, "Failed to register platform_profile c=
lass device with both quiet and low-power\n");
>> >>> +               return ERR_PTR(-EINVAL);
>> >>> +       }
>> >>
>> >> Can you avoid failing here? It caused a lot of issues in the past (t=
he
>> >> WMI driver bails)=2E a dev_err should be enough=2E Since you do not =
fail
>> >> maybe it can be increased to dev_crit=2E
>> >>
>> >> There is at least one driver that implements both currently, and a f=
ix
>> >> would have to precede this patch=2E
>> >
>> > Oh, acer-wmi?  Kurt; can you please comment?  Are both simultaneous?
>>
>> There are a few laptops supported by alienware-wmi that definitely have
>> both (including mine)=2E The acer-wmi and the samsung-galaxybook driver=
s
>> also probe for available choices dynamically, so some of those devices
>> may be affected by this too=2E
>>
>> So yes, we shouldn't fail registration here=2E
>>
>> Anyway, I like this approach more than v1=2E What do you think about
>> constraining this fix to the legacy interface?
>
>AFAIK new interface is ok and should not be modified=2E None of the
>previous solutions touched it (well, changing quiet to low-power did)=2E
>But I still expect the legacy interface to work the same way on 6=2E14=2E
>
>What happens if there is one handler that does low-power and one that
>does quiet? Is one choice preferred? And then are writes accepted in
>both?
>
>I cannot have the same device requiring low-power and quiet depending
>on kernel version or boot=2E I do tdp controls per manufacturer=2E
>

I agree that isn't ideal, but I see no reason why you can't index the _cho=
ices at startup to cover that in a generic way for all manufacturers=2E The=
y present in performance order as text, specifically ensuring dynamic loadi=
ng isn't difficult=2E=20

>> --
>>  ~ Kurt
>>
>> >
>> >>
>> >>>
>> >>>          guard(mutex)(&profile_lock);
>> >>>
>> >>> --
>> >>> 2=2E43=2E0
>> >>>
>>

- Derek

