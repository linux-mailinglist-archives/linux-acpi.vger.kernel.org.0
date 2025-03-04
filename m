Return-Path: <linux-acpi+bounces-11785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D5CA4E283
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 16:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506B7178334
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35F2620DE;
	Tue,  4 Mar 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRJTmVKU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3126036C;
	Tue,  4 Mar 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100348; cv=none; b=bdsAmrD1fp2S03KujFAuDmWl4icvDVgeq4RVSkuKkbZT5UNreIHfzp9/n+mxzOLRKLkdFW83LF1prJMeB93XPhkgcHCwH8Bgmss/ZyCNatfnWb/oQ44tWJhWUL8i+mvqbHkjsXdYuglSj4YD3bt48blSPTjNZhs5EaWxSK3r2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100348; c=relaxed/simple;
	bh=BJioHZs7npMxT1EZrWhLh92wotTsWQ13abN3EvOE9RE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFyXReRaLD8BsiorlGK04XTIS5KS8q/vo67wYxP19gsHQHEaRNtVaXE5G3J/PD6ZJpE0hLJjZC5jY+0zebDWEi3kd9+rn32mEURr0vpJc4k+aR88QnhNy3q69EOd0NrucwBrz1Mj1s+4I+LY1SdpeQMp4FEbbkhgvp+pwGvKWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRJTmVKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52421C4CEF2;
	Tue,  4 Mar 2025 14:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100347;
	bh=BJioHZs7npMxT1EZrWhLh92wotTsWQ13abN3EvOE9RE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uRJTmVKUDQ70Nt7Z+2CFBjqCqUXW2AXR7ZZFQpBN6LtvhUk9WUxZNmGl3qEGdgVA8
	 34ppa/Sm9DaMEcoD0ZhTIfBaYBZNiG08JQdqB7hQis1Inn05liKHh6JjPUnya1/DnM
	 mVmwlOBLT+d6641L1lQkRtuRrenX0H0kCkgjzjIwBQzWja5eLAFMJln9CYS5Rk7Yjj
	 /8qGYpuJGF+kzDKymQ4r5yqOUt2WmPZ76zV5u0ykeJEoQCrBLzJ/Vythn9FzMp7N18
	 9VIOnrrOb7NFreHZpzuhIEY9oKPpAqSG8Xg4zu1O+WqUminhYQ9GzjBYF7wjVP5Drk
	 GLdoqmOE4gQ8Q==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5fcc45803easo1330120eaf.3;
        Tue, 04 Mar 2025 06:59:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmpQlLAh8nYuZuoIEaZ+ikq7a7vaBa3NJCHmwGTgYFHbPNV1BfGd5zYgwLN8K+sj+FckJWN2RQxQ98TnGyAzu3TLgR9g==@vger.kernel.org, AJvYcCWKUUk0GWVG5D5mFeH2PJGVJyAV7MCGvbYeUVrf0iclQl3FYmAmaa4jlUwzn38bHPGx9zmgbAyEK7mM@vger.kernel.org, AJvYcCXaQKGe0uJ+SrLDlY0dUKea3+Fq/oGZ9TULZ6tI+HtfV+5+NkmbI4IfC5hlc0JIm0B3m5OpOz5rrJikl7Al@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQElC5qAFaRfudnnidDAjz6bTPAWN4je3wS4eTcJGHbEy6u3Y
	JLaITwSrYM69sjpKrmcmaH4zMcSh+XsRHB5lK5QCzZBn1Zz53fxtrVDrGGXfzTti250pzzk3ZyA
	F/QPd1r2OqQYgv6I1Zj5oUmtEBRM=
X-Google-Smtp-Source: AGHT+IHV4OYxfCU/t1WTUxkTaNo8H8GNLQAFxAAet6Nu+4CwM7JxdLruJtd4pXXPuDqTQMQDQdHOE7tLLv9Xo98895g=
X-Received: by 2002:a05:6820:1629:b0:5fd:b85:9b47 with SMTP id
 006d021491bc7-5feb349ece4mr9806448eaf.1.1741100346518; Tue, 04 Mar 2025
 06:59:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304064745.1073770-1-superm1@kernel.org> <20250304064745.1073770-2-superm1@kernel.org>
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com>
 <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org> <CAJZ5v0geaYYRQm0Hs2M4ak_8AZoWLJS-v0jqyrsaVjmXk267rA@mail.gmail.com>
 <71b14dc3-77e1-4fd7-b576-821e3a41ba19@kernel.org>
In-Reply-To: <71b14dc3-77e1-4fd7-b576-821e3a41ba19@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Mar 2025 15:58:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hNHFLtBwTTuPc7mNZhCKkmFJgFwgw88_BR_7nQ+rc6Cw@mail.gmail.com>
X-Gm-Features: AQ5f1JqiU1riY6PdY3kp9Y6wKkJOdtqDzvJA_a9LeLoMMba-AYmBjxoxf4Tpjjg
Message-ID: <CAJZ5v0hNHFLtBwTTuPc7mNZhCKkmFJgFwgw88_BR_7nQ+rc6Cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
To: Mario Limonciello <superm1@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, Kurt Borja <kuurtb@gmail.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede <hdegoede@redhat.com>, 
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 3:52=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 3/4/2025 08:08, Rafael J. Wysocki wrote:
> > On Tue, Mar 4, 2025 at 1:49=E2=80=AFPM Mario Limonciello <superm1@kerne=
l.org> wrote:
> >>
> >> On 3/4/25 02:38, Antheas Kapenekakis wrote:
> >>> On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> w=
rote:
> >>>>
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> When two drivers don't support all the same profiles the legacy inte=
rface
> >>>> only exports the common profiles.
> >>>>
> >>>> This causes problems for cases where one driver uses low-power but a=
nother
> >>>> uses quiet because the result is that neither is exported to sysfs.
> >>>>
> >>>> If one platform profile handler supports quiet and the other
> >>>> supports low power treat them as the same for the purpose of
> >>>> the sysfs interface.
> >>>>
> >>>> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handler=
s")
> >>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42=
ad-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>> ---
> >>>>    drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++=
++---
> >>>>    1 file changed, 35 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform=
_profile.c
> >>>> index 2ad53cc6aae53..d9a7cc5891734 100644
> >>>> --- a/drivers/acpi/platform_profile.c
> >>>> +++ b/drivers/acpi/platform_profile.c
> >>>> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *de=
v, void *data)
> >>>>
> >>>>           lockdep_assert_held(&profile_lock);
> >>>>           handler =3D to_pprof_handler(dev);
> >>>> -       if (!test_bit(*bit, handler->choices))
> >>>> -               return -EOPNOTSUPP;
> >>>> +       if (!test_bit(*bit, handler->choices)) {
> >>>> +               switch (*bit) {
> >>>> +               case PLATFORM_PROFILE_QUIET:
> >>>> +                       *bit =3D PLATFORM_PROFILE_LOW_POWER;
> >>>> +                       break;
> >>>> +               case PLATFORM_PROFILE_LOW_POWER:
> >>>> +                       *bit =3D PLATFORM_PROFILE_QUIET;
> >>>> +                       break;
> >>>> +               default:
> >>>> +                       return -EOPNOTSUPP;
> >>>> +               }
> >>>> +               if (!test_bit(*bit, handler->choices))
> >>>> +                       return -EOPNOTSUPP;
> >>>> +       }
> >>>>
> >>>>           return handler->ops->profile_set(dev, *bit);
> >>>>    }
> >>>> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *de=
v, void *data)
> >>>>           handler =3D to_pprof_handler(dev);
> >>>>           if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> >>>>                   bitmap_copy(aggregate, handler->choices, PLATFORM_=
PROFILE_LAST);
> >>>> -       else
> >>>> +       else {
> >>>> +               /* treat quiet and low power the same for aggregatio=
n purposes */
> >>>> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choice=
s) &&
> >>>> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
> >>>> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
> >>>> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handle=
r->choices) &&
> >>>> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate)=
)
> >>>> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregat=
e);
> >>>>                   bitmap_and(aggregate, handler->choices, aggregate,=
 PLATFORM_PROFILE_LAST);
> >>>> +       }
> >>>
> >>> So you end up showing both? If that's the case, isn't it equivalent t=
o
> >>> just make amd-pmf show both quiet and low-power?
> >>>
> >>> I guess it is not ideal for framework devices. But if asus devices en=
d
> >>> up showing both, then it should be ok for framework devices to show
> >>> both.
> >>>
> >>> I like the behavior of the V1 personally.
> >>
> >> No; this doesn't cause it to show both.  It only causes one to show up=
.
> >
> > Which may not be the one that was shown before IIUC and that's not good=
.
> >
> > What actually is the problem with the previous version?
>
> Functionally?  Nothing.  This was to demonstrate the other way to do it
> that I preferred and get feedback on it as an alternative.
>
> If you and Ilpo are happy with v1 that's totally fine and we can go with
> that.

I'd prefer to go for the v1 at this point because it fixes a
regression affecting user space that needs to be addressed before the
6.14 release (and there is not too much time left) and it has been
checked on the affected systems.

Ilpo, do you agree?

