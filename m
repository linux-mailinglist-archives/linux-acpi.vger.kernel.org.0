Return-Path: <linux-acpi+bounces-11774-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E058EA4DFCF
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733CA3A93D5
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1262046AF;
	Tue,  4 Mar 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+hIQATt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BC202F79;
	Tue,  4 Mar 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096445; cv=none; b=Xm2l7KkJ053wG1+G3a0QUsCIntcScpkd9rUzdWvmktbCe0eGt8BsbGM4ohtonk+d72AQ6QALcFbxigQSNnCmEfs3DOK3nMAWYUEMfFyC8IncjzyI6jJigA8APLJLubwWRXd6sIedvgnNhju95FrhNMaABEAfO9rs9an+B1IcsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096445; c=relaxed/simple;
	bh=fqkgvHjPswFAMvaE5kReX52SACWPZ9WhJfUporlkjBs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=saSR2Cn1VMsaECMTTIaDry47oafx76uvDm5S63Mbxy2D6si+VDbymAbS+bVfIg0DE/HbcyC/JPGekpjdu1J9zc15G8PGi0vPIX9JF6w+wQYhwDFCWGiDljsUjUBVUAJPnJV+cFLnjeofhXGAR/i6Bko9K4oaTUgGcTxmWKFivyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+hIQATt; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso2177117241.0;
        Tue, 04 Mar 2025 05:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741096443; x=1741701243; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1lRAoDM8LwgraF/afnpgCSOZyx5bcbveUqB2scrlYM=;
        b=E+hIQATtLp/+pVbQhWI6kVtK+1V0qP9IgbabgwjkTmOCKqkqYPv2w6qV2wbI2BA1zK
         qkPPXGqRwqAjoSYCbDBzH/BTygkxZOSIC6rIqoJgpUdDEF7RmC8RUOMpt1p9P5rSx0en
         1fkDtheZwsv9XVpwpj3GMD/rsyT3VAmQEe6P9Eh6IBTwMiC3uKxvkhY5KQIw4bKgM97I
         XQ5zDkQQTyZpPnrETidOO0gnqncTNEkXHuEZqMzQ/U+yMKJ2xU8x9sucOjZ4BJSDLRnW
         8DGrsqJa1SNvVxbdCaeaPaYvgVBWuqWRsfBH3GR6tin7gXXvvCkBGN7kSPHTyhMkkxFu
         8YGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096443; x=1741701243;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D1lRAoDM8LwgraF/afnpgCSOZyx5bcbveUqB2scrlYM=;
        b=L0ARj/kZ3F09rNhAd46ZZ0hj8rqXldmDW7RabMhl82zSQ4KG9DeMtN2D0G7LHNqYSH
         XN17cLExSZJp0kcEYQuQ9IdTkajpN7WuSe7fo7FLHSdgaIZhoG+w3/E+hVqfayK2UyHg
         LU3T39QlIdv6U1ohFh4JW0ESOugOKzF9u2KlPU4yr9SRpAme0aMWqY3w7JKrfz9DoDRG
         qcD+e7jZxXqPE6S9U5IdAKYa6JVClf1LGo5tDjbLztaFXmhg2z0QydjPcUnlh1j+u/pQ
         pkLzlPFF1vPkvWOSS3QHskx2/OUdr9XlkpYkgDOkdXlwW5ACBYIIFrt54KKxhWKGdK4D
         trIA==
X-Forwarded-Encrypted: i=1; AJvYcCUerqb1VH762E5I80HoLxKmWIlxz+gmgDR6gLmkhPgxg/KL/ne/USiaEMY0P1g9XBCMUOAj1hwZyc3C@vger.kernel.org, AJvYcCUewhO7t1JBBugBeafZzLxcr0kUjR6ReRKfxcWqbie3nxe7po60seWmJ7i05wdfy7VHG/tvYS7XcEmZLh67BzR55zcM7g==@vger.kernel.org, AJvYcCUyO1t4QKTbZBx+9f6q6fI9GRWVLwa8eaHKghToV15EUVm20k71kDc3ktLwpidgc4//MbCDh5kk2Tr3ugp7@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+OfPjDmjE2sRTyIZX+P3rl58RtoySmixSUiJSNocSPMVkJ/b
	tLOTjX3ieuFvOJlgd5m6rRSp9jepyV8OjF6kSV+QAaYAxoF9v72C
X-Gm-Gg: ASbGnctkdII8S9nD4H122Nq0HvZpJEAaALjf8mtsgbL2Yy8QENdJuKRpvK0iA0OSlQP
	XxZPGFrS2W1IxbckDebwsL0sAfQxDacx783DTQcmhPJa7NXO/+5SH8Sw8FIYqGOvX2PplvgMaW9
	q3bsStIU/Hq4FpFFR29nafnDwMeYulQhTfrWrQhekpjgHkQrIJxmJAp9RO/C9OpTNK8BjQ3+9E3
	XuB+F18QEoE65+nxo+WHC3ZQ9Ei6kwNV6c5zGKW/gBPEUSLgxtSFcavkr5gVNYqBCPkGOa8TO1R
	evbG5G/YAiL1yfAs5wRlhkMKdnZvQ6/rjqk3
X-Google-Smtp-Source: AGHT+IEmOSsLfZwMbSUmujd2VobQKPKffA1MxlWqFJZua7YydsrISWQUTjDBmQQVurvETyeZkh4MsQ==
X-Received: by 2002:a05:6102:918:b0:4c1:9536:523c with SMTP id ada2fe7eead31-4c195365578mr5207709137.24.1741096442934;
        Tue, 04 Mar 2025 05:54:02 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b3dd048f6sm1928400241.21.2025.03.04.05.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 05:54:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Mar 2025 08:53:59 -0500
Message-Id: <D87J6E7DFLS0.1BY00BAZFWEH7@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Antheas Kapenekakis" <lkml@antheas.dev>
Cc: "Mario Limonciello" <superm1@kernel.org>, "Shyam Sundar S K"
 <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Hans
 de Goede" <hdegoede@redhat.com>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, "open list:AMD PMF DRIVER"
 <platform-driver-x86@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>, "Derek J . Clark"
 <derekjohn.clark@gmail.com>, <me@kylegospodneti.ch>, "Denis Benato"
 <benato.denis96@gmail.com>, "Mario Limonciello" <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low
 power the same
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250304064745.1073770-1-superm1@kernel.org>
 <20250304064745.1073770-2-superm1@kernel.org>
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
 <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
 <D87ILMWSRUPG.3FHTWG38N2IFJ@gmail.com>
 <CAGwozwHXd6frhGCOrm8_tg2=M4sHCu_JBmqodWdKUF+AuL2TNw@mail.gmail.com>
In-Reply-To: <CAGwozwHXd6frhGCOrm8_tg2=M4sHCu_JBmqodWdKUF+AuL2TNw@mail.gmail.com>

On Tue Mar 4, 2025 at 8:32 AM -05, Antheas Kapenekakis wrote:
> On Tue, 4 Mar 2025 at 14:28, Kurt Borja <kuurtb@gmail.com> wrote:
>>
>> Hi all,
>>
>> On Tue Mar 4, 2025 at 7:49 AM -05, Mario Limonciello wrote:
>> >
>> >
>> > On 3/4/25 02:38, Antheas Kapenekakis wrote:
>> >> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> w=
rote:
>> >>>
>> >>> From: Mario Limonciello <mario.limonciello@amd.com>
>> >>>
>> >>> When two drivers don't support all the same profiles the legacy inte=
rface
>> >>> only exports the common profiles.
>> >>>
>> >>> This causes problems for cases where one driver uses low-power but a=
nother
>> >>> uses quiet because the result is that neither is exported to sysfs.
>> >>>
>> >>> If one platform profile handler supports quiet and the other
>> >>> supports low power treat them as the same for the purpose of
>> >>> the sysfs interface.
>> >>>
>> >>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handler=
s")
>> >>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>> >>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42=
ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
>> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> >>> ---
>> >>>   drivers/acpi/platform_profile.c | 38 +++++++++++++++++++++++++++++=
+---
>> >>>   1 file changed, 35 insertions(+), 3 deletions(-)
>> >>>
>> >>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform=
_profile.c
>> >>> index 2ad53cc6aae53..d9a7cc5891734 100644
>> >>> --- a/drivers/acpi/platform_profile.c
>> >>> +++ b/drivers/acpi/platform_profile.c
>> >>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *de=
v, void *data)
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
>> >>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *de=
v, void *data)
>> >>>          handler =3D to_pprof_handler(dev);
>> >>>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>> >>>                  bitmap_copy(aggregate, handler->choices, PLATFORM_P=
ROFILE_LAST);
>> >>> -       else
>> >>> +       else {
>> >>> +               /* treat quiet and low power the same for aggregatio=
n purposes */
>> >>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choice=
s) &&
>> >>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
>> >>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
>> >>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handle=
r->choices) &&
>> >>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate)=
)
>> >>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregat=
e);
>> >>>                  bitmap_and(aggregate, handler->choices, aggregate, =
PLATFORM_PROFILE_LAST);
>> >>> +       }
>> >>
>> >> So you end up showing both? If that's the case, isn't it equivalent t=
o
>> >> just make amd-pmf show both quiet and low-power?
>> >>
>> >> I guess it is not ideal for framework devices. But if asus devices en=
d
>> >> up showing both, then it should be ok for framework devices to show
>> >> both.
>> >>
>> >> I like the behavior of the V1 personally.
>> >
>> > No; this doesn't cause it to show both.  It only causes one to show up=
.
>> > I confirmed it with a contrived situation on my laptop that forced
>> > multiple profile handlers that supported a mix.
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
>> >>> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *d=
ev, void *data)
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
>> >>>          if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D va=
l)
>> >>>                  *profile =3D PLATFORM_PROFILE_CUSTOM;
>> >>>          else
>> >>> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struct=
 device *dev, const char *name,
>> >>>                  dev_err(dev, "Failed to register platform_profile c=
lass device with empty choices\n");
>> >>>                  return ERR_PTR(-EINVAL);
>> >>>          }
>> >>> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
>> >>> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
>> >>> +               dev_err(dev, "Failed to register platform_profile cl=
ass device with both quiet and low-power\n");
>> >>> +               return ERR_PTR(-EINVAL);
>> >>> +       }
>> >>
>> >> Can you avoid failing here? It caused a lot of issues in the past (th=
e
>> >> WMI driver bails). a dev_err should be enough. Since you do not fail
>> >> maybe it can be increased to dev_crit.
>> >>
>> >> There is at least one driver that implements both currently, and a fi=
x
>> >> would have to precede this patch.
>> >
>> > Oh, acer-wmi?  Kurt; can you please comment?  Are both simultaneous?
>>
>> There are a few laptops supported by alienware-wmi that definitely have
>> both (including mine). The acer-wmi and the samsung-galaxybook drivers
>> also probe for available choices dynamically, so some of those devices
>> may be affected by this too.
>>
>> So yes, we shouldn't fail registration here.
>>
>> Anyway, I like this approach more than v1. What do you think about
>> constraining this fix to the legacy interface?
>
> AFAIK new interface is ok and should not be modified. None of the
> previous solutions touched it (well, changing quiet to low-power did).
> But I still expect the legacy interface to work the same way on 6.14.

This patch also permanently alias quiet and low-power for the new
interface, if either one is not available.

>
> What happens if there is one handler that does low-power and one that
> does quiet? Is one choice preferred? And then are writes accepted in
> both?
>
> I cannot have the same device requiring low-power and quiet depending
> on kernel version or boot. I do tdp controls per manufacturer.

I'm not sure what you mean here.

--=20
 ~ Kurt

>
>> --
>>  ~ Kurt
>>
>> >
>> >>
>> >>>
>> >>>          guard(mutex)(&profile_lock);
>> >>>
>> >>> --
>> >>> 2.43.0
>> >>>
>>


