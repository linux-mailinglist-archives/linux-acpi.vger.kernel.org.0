Return-Path: <linux-acpi+bounces-11768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E309A4DF3B
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838D87A18C2
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D48204683;
	Tue,  4 Mar 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHyI1SuD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A92045B3;
	Tue,  4 Mar 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094820; cv=none; b=lsrpLz6znll47WEpZ7N9EPFbqh+fZDIQvyHd91eAByGKUGuX/xynJyBtUyJfL0RaU7A4vGwnppwlQTjYCE24zPPLdUge5SoxmzEXpm3O8CTMfwYqmjy6TWpUUtyebKViRqY5pCX3WjbO65FkrATzQh7S0JeB0GcF89b8gR+uB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094820; c=relaxed/simple;
	bh=Dbh0yWnJ9wNGOeGtfH9NE1eZNuNZSiESIwromLOHGNY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=Sfz/4aEiJxQ27EQsVRScc2wDeN5gGs6bSAUAsefNa7bYdsinAIIH5uQiyQm+EpZImNjQ8ZOfpimHuTMd1cATDu/BDs/N28FGEShX3XA3FPd3ejZch9xK4Go2sJ7TZtOHHtAkV6MkhSUuEGbqKuRHeUOdT1FYQrP6oNn3jVvkQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHyI1SuD; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52367fd5af5so1659543e0c.3;
        Tue, 04 Mar 2025 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741094816; x=1741699616; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vL3fp9Q7jjBrH7sjWaqesrfVNl8ZcjvkllY5xGeMDnY=;
        b=bHyI1SuDnAK8zJcwJoFNk23L08bM8nwUD5zbyDkBt9LrTpm8bBNfm+DhOVZ5H5komq
         IhIQaHVx9BtnQ/j/SbIUAJ51C9zE1tJCIwkE9A0d3XnGJr2jB260s0nwYfiD7CRPknlh
         3FNcf/nHm7f0g1Yceoekbfqk20qkkrr4m6NCucDzea6biOq0AjJKYMQHuDZ1wFd/p3J9
         XTs22uYSKO3v9uMOWDGm2R8D7Q3qsyt3aIimE+afMyoONlqt92CXMlvjvespsYSuxCaT
         tQunBY8ZI606abvTAVl3YAdKYiiCyMd2kGvOcpwd66bgV4LqwAWO7ZGZYts3n6BALnTq
         ze2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741094816; x=1741699616;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vL3fp9Q7jjBrH7sjWaqesrfVNl8ZcjvkllY5xGeMDnY=;
        b=w0HLQ18SJfbyVCXtqxFyddtkVhYoO6BUmQ/zLHnaUoSPCfAd8IhOI7uBtY6g1u3zd5
         YBq1BzLwvFrP1vRXk9mB1uEfyOZYfZ59WmjiNKLWuISpbfuDNYLiQkP/DUla0fX9MAA8
         EvEBjVunqZ4UEoE96kET1b7GpqYeRCbtAquTeTwiCD7Np7i6QijzMxtGN8h8wFoLWoPK
         3nspFq6paHT8yYLafzb6fWJnfjHcEbz1l7sybNlztanELpwOXzsm0jaMIlCV9JMoJ+Qm
         4r6lGSvII4JuB+ztjl8tbNBcCqe37ZoqWT4S9JFUqYkC57INuC5w16qbI3jHX6gW2gcJ
         2tuA==
X-Forwarded-Encrypted: i=1; AJvYcCUkthwephSbJrwi56AvR21yfyZmq3f6tQCHiUw6gcEn4+TY8MthYhL2Evgkh1jr+XxkeT3u718Q2v5O@vger.kernel.org, AJvYcCWEtufZolN1Y0cyAl4Grw/aI5qjGZF4azWf0e/kv6Jy6Udup0gPE4PhXD+3KCt0DHJgEvfCN1TkVdeXYCOZ@vger.kernel.org, AJvYcCX56vKqPw1u7Cxrl9DcwcIZ4tevgRzHzyb1hEt4cE2GO90vupm2V9b4dOdfK0ipzyoFioybT17fxKNuJlwzUml13Y5fnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXcavQqHLh7Y+SJgp/qP49YiLhn5EWirICBpnjvseVDTpA2k80
	0ofD1uRbmz0ypMC2NfUVMR57C6TNTenw+wL8pmcvqc+Y8nexphcC
X-Gm-Gg: ASbGncs1JqfTcK38MC8z8bbetSXTucLKk9JwZ2QwqIfVgZtVPybqxnGCmAjAvnn0hDx
	nYRI3TgRJ7xrxT2irOWCNrZ5J+AALXyOj83rums0AsA74xNmz8ntfxpHUffse4fB/dfzLCNl4nw
	4dt521XTNj3HUJ7cZ0XliUvdtgZX9qhWsHW0M60XZEk4f0ZOluxmWA7eZqd81wmxlM8g8HjlQkf
	RsXNTgjGTwc9l4mq3BzSJYRLF0vDevEoYrhqHjRgTJ30YqgH5pAm+kEbuIew6s4mqelNn2i7e24
	iJpaYJTTmPJ+AZZCevIi5L6RjPl1H31aTSVU
X-Google-Smtp-Source: AGHT+IGeE0DtxbZy0AS94tKp3ljhVZFbmqT5dQpu9xx62aCvOcS2kduSwj9MwYhFItAiqqWKahL88w==
X-Received: by 2002:a05:6122:d10:b0:51f:405e:866e with SMTP id 71dfb90a1353d-5235b7e1aa7mr9063404e0c.1.1741094815809;
        Tue, 04 Mar 2025 05:26:55 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5234c08c5b6sm2139336e0c.36.2025.03.04.05.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 05:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Mar 2025 08:26:52 -0500
Message-Id: <D87ILMWSRUPG.3FHTWG38N2IFJ@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Mario Limonciello" <superm1@kernel.org>, "Antheas Kapenekakis"
 <lkml@antheas.dev>
Cc: "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Hans de Goede" <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Luke D .
 Jones" <luke@ljones.dev>, "Mark Pearson" <mpearson-lenovo@squebb.ca>, "open
 list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, "open list"
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
In-Reply-To: <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>

Hi all,

On Tue Mar 4, 2025 at 7:49 AM -05, Mario Limonciello wrote:
>
>
> On 3/4/25 02:38, Antheas Kapenekakis wrote:
>> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wrot=
e:
>>>
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> When two drivers don't support all the same profiles the legacy interfa=
ce
>>> only exports the common profiles.
>>>
>>> This causes problems for cases where one driver uses low-power but anot=
her
>>> uses quiet because the result is that neither is exported to sysfs.
>>>
>>> If one platform profile handler supports quiet and the other
>>> supports low power treat them as the same for the purpose of
>>> the sysfs interface.
>>>
>>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers")
>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-=
9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++--=
-
>>>   1 file changed, 35 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
>>> index 2ad53cc6aae53..d9a7cc5891734 100644
>>> --- a/drivers/acpi/platform_profile.c
>>> +++ b/drivers/acpi/platform_profile.c
>>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev, =
void *data)
>>>
>>>          lockdep_assert_held(&profile_lock);
>>>          handler =3D to_pprof_handler(dev);
>>> -       if (!test_bit(*bit, handler->choices))
>>> -               return -EOPNOTSUPP;
>>> +       if (!test_bit(*bit, handler->choices)) {
>>> +               switch (*bit) {
>>> +               case PLATFORM_PROFILE_QUIET:
>>> +                       *bit =3D PLATFORM_PROFILE_LOW_POWER;
>>> +                       break;
>>> +               case PLATFORM_PROFILE_LOW_POWER:
>>> +                       *bit =3D PLATFORM_PROFILE_QUIET;
>>> +                       break;
>>> +               default:
>>> +                       return -EOPNOTSUPP;
>>> +               }
>>> +               if (!test_bit(*bit, handler->choices))
>>> +                       return -EOPNOTSUPP;
>>> +       }
>>>
>>>          return handler->ops->profile_set(dev, *bit);
>>>   }
>>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev, =
void *data)
>>>          handler =3D to_pprof_handler(dev);
>>>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
>>>                  bitmap_copy(aggregate, handler->choices, PLATFORM_PROF=
ILE_LAST);
>>> -       else
>>> +       else {
>>> +               /* treat quiet and low power the same for aggregation p=
urposes */
>>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices) =
&&
>>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
>>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
>>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler->=
choices) &&
>>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
>>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate);
>>>                  bitmap_and(aggregate, handler->choices, aggregate, PLA=
TFORM_PROFILE_LAST);
>>> +       }
>>=20
>> So you end up showing both? If that's the case, isn't it equivalent to
>> just make amd-pmf show both quiet and low-power?
>>=20
>> I guess it is not ideal for framework devices. But if asus devices end
>> up showing both, then it should be ok for framework devices to show
>> both.
>>=20
>> I like the behavior of the V1 personally.
>
> No; this doesn't cause it to show both.  It only causes one to show up.=
=20
> I confirmed it with a contrived situation on my laptop that forced=20
> multiple profile handlers that supported a mix.
>
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
>>=20
>>>          return 0;
>>>   }
>>> @@ -305,6 +325,13 @@ static int _aggregate_profiles(struct device *dev,=
 void *data)
>>>          if (err)
>>>                  return err;
>>>
>>> +       /* treat low-power and quiet as the same */
>>> +       if ((*profile =3D=3D PLATFORM_PROFILE_LOW_POWER &&
>>> +            val =3D=3D PLATFORM_PROFILE_QUIET) ||
>>> +           (*profile =3D=3D PLATFORM_PROFILE_QUIET &&
>>> +            val =3D=3D PLATFORM_PROFILE_LOW_POWER))
>>> +               *profile =3D val;
>>> +
>>>          if (*profile !=3D PLATFORM_PROFILE_LAST && *profile !=3D val)
>>>                  *profile =3D PLATFORM_PROFILE_CUSTOM;
>>>          else
>>> @@ -531,6 +558,11 @@ struct device *platform_profile_register(struct de=
vice *dev, const char *name,
>>>                  dev_err(dev, "Failed to register platform_profile clas=
s device with empty choices\n");
>>>                  return ERR_PTR(-EINVAL);
>>>          }
>>> +       if (test_bit(PLATFORM_PROFILE_QUIET, pprof->choices) &&
>>> +           test_bit(PLATFORM_PROFILE_LOW_POWER, pprof->choices)) {
>>> +               dev_err(dev, "Failed to register platform_profile class=
 device with both quiet and low-power\n");
>>> +               return ERR_PTR(-EINVAL);
>>> +       }
>>=20
>> Can you avoid failing here? It caused a lot of issues in the past (the
>> WMI driver bails). a dev_err should be enough. Since you do not fail
>> maybe it can be increased to dev_crit.
>>=20
>> There is at least one driver that implements both currently, and a fix
>> would have to precede this patch.
>
> Oh, acer-wmi?  Kurt; can you please comment?  Are both simultaneous?

There are a few laptops supported by alienware-wmi that definitely have
both (including mine). The acer-wmi and the samsung-galaxybook drivers
also probe for available choices dynamically, so some of those devices
may be affected by this too.

So yes, we shouldn't fail registration here.

Anyway, I like this approach more than v1. What do you think about
constraining this fix to the legacy interface?

--=20
 ~ Kurt

>
>>=20
>>>
>>>          guard(mutex)(&profile_lock);
>>>
>>> --
>>> 2.43.0
>>>


