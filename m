Return-Path: <linux-acpi+bounces-11776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F6A4E055
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C1D189E2FB
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805F02054E6;
	Tue,  4 Mar 2025 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY2Lystw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F0717583;
	Tue,  4 Mar 2025 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097337; cv=none; b=fjMD/5JCQ5zp1qIobc+FdCHjLZ2D8pwrEGs5ae8EecDfBAvaB8DCWcg6hmVqgrB7HY+E4b1DqfVCyBgsV8rbZ56xBuy0HwlVs1LbSviZ5j37/0z+RUMdJi+vTw45ZdTG4YXS9O/H/MbxyTqjV76s/o3HU8THjucxeHj4mz1BJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097337; c=relaxed/simple;
	bh=FFaXfiYouNPiW/BtNV6Qmzgm6qPvTQ+bB7wLiJRdIcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC39boMv4TvCJTfxsj9m+lcHF0uk1mjHpAeH1C14fxnl3f1wZ4wqa94BOUcYcR0vT56Oo105fLeI4RyhcJyqV1pFtfSPEJJALRil+js5J9J6fvBOdL0/9j1ZS4YNHkGskM3A1FfyQMLKT8jSpZ5lZlakWhabei6lP0lukw0f2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY2Lystw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8050C4CEEC;
	Tue,  4 Mar 2025 14:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097336;
	bh=FFaXfiYouNPiW/BtNV6Qmzgm6qPvTQ+bB7wLiJRdIcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GY2LystwnorpL8dP/sFJRQx6aUFNOrPHQ/UoDO677cvDGMM5WldzYt2wer6itlpAB
	 Q7FDeOgxBbl5emPjpQVxDGm/VJU3uKySNjC0UrITeSK5tiM9v3qCsFBxi94Ac60jJo
	 1BvXASdqHL+KeGOBi0xUQqQX2RG7zw1ONcAwtMF9yNsU+fEEWw9nzlPKWxiQkRoDTD
	 uQ3wGTysxcyRF18FGa8tGc0eo1H950nJrhAkZf8trsBnVsmNGqadBoxdBlzv8Da3TZ
	 ihklEBs7UBlzteGPYHWt/5Lzz/uJeVaJux3Un4SnutiPCYUl4KbucqwLGieTgquGEh
	 tJehGnP8xJ7iA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72a0c41e049so1254421a34.2;
        Tue, 04 Mar 2025 06:08:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWr+O9BKL/9vyxMu/Ty9BvSO8rSk4cYXUG+CvPKRoueQbt7kXTWjkCJp+2asg+E88cROG/6ZemCFfAJrCV@vger.kernel.org, AJvYcCUaFFgufImhzkFwhPf8qjnCBqFg0N1lhv9pYXP9xIAxm4WavZMmPJsMUEEfHH+DXvwGbIjN/9tL7+2N66899Khwl+2zTA==@vger.kernel.org, AJvYcCXRaa05ppqG5m9BxIpgxE7+sCmub+e8rm/wn8GLAJMqazVl039y+ZhDTgG8+6GmDHFfEr8VVsE26De0@vger.kernel.org
X-Gm-Message-State: AOJu0YwPye+Ii+50UTuVINihHwUGoLQ0h/I/+vE4dEB/LJTVIBASCd2U
	eIUPTT28jKYiGQwEi4S7J+vtqYu+9VF/Zgxwk9HSQX7bTD3A+0VRUcTQzzDzjnePY0CuWAWNA9l
	1EMdXQkhD8Ff9arct3KrpUXolViM=
X-Google-Smtp-Source: AGHT+IHxUPi7QDl9YORcAoX5Q4QPTAef7rjqM9Z9bAU/V4Qg+QA43MqYaCMOwQlJ1psX0BhpUmLxGp/mzB/Npid83pI=
X-Received: by 2002:a05:6830:6c8c:b0:72a:10ec:35f7 with SMTP id
 46e09a7af769-72a10ec36b0mr2511201a34.13.1741097335957; Tue, 04 Mar 2025
 06:08:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304064745.1073770-1-superm1@kernel.org> <20250304064745.1073770-2-superm1@kernel.org>
 <CAGwozwHniWGQ7qK6FYD_WK5zNjkro7-Q1nTcFPAuWDt9UQ+noA@mail.gmail.com> <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
In-Reply-To: <23d6c735-e94f-4d43-87b0-ff119941fcac@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Mar 2025 15:08:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0geaYYRQm0Hs2M4ak_8AZoWLJS-v0jqyrsaVjmXk267rA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo_wCJPyQkVLSUxNxTbB9yN8I8me4jy7lvSe9m6OVWdW4gx6lKckEx-g40
Message-ID: <CAJZ5v0geaYYRQm0Hs2M4ak_8AZoWLJS-v0jqyrsaVjmXk267rA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: platform_profile: Treat quiet and low power
 the same
To: Mario Limonciello <superm1@kernel.org>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, Kurt Borja <kuurtb@gmail.com>, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, "Derek J . Clark" <derekjohn.clark@gmail.com>, 
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:49=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 3/4/25 02:38, Antheas Kapenekakis wrote:
> > On Tue, 4 Mar 2025 at 07:48, Mario Limonciello <superm1@kernel.org> wro=
te:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When two drivers don't support all the same profiles the legacy interf=
ace
> >> only exports the common profiles.
> >>
> >> This causes problems for cases where one driver uses low-power but ano=
ther
> >> uses quiet because the result is that neither is exported to sysfs.
> >>
> >> If one platform profile handler supports quiet and the other
> >> supports low power treat them as the same for the purpose of
> >> the sysfs interface.
> >>
> >> Fixes: 688834743d67 ("ACPI: platform_profile: Allow multiple handlers"=
)
> >> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Closes: https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad=
-9257-5b8fc6c24ac9@gmx.de/T/#mc068042dd29df36c16c8af92664860fc4763974b
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/acpi/platform_profile.c | 38 ++++++++++++++++++++++++++++++-=
--
> >>   1 file changed, 35 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_p=
rofile.c
> >> index 2ad53cc6aae53..d9a7cc5891734 100644
> >> --- a/drivers/acpi/platform_profile.c
> >> +++ b/drivers/acpi/platform_profile.c
> >> @@ -73,8 +73,20 @@ static int _store_class_profile(struct device *dev,=
 void *data)
> >>
> >>          lockdep_assert_held(&profile_lock);
> >>          handler =3D to_pprof_handler(dev);
> >> -       if (!test_bit(*bit, handler->choices))
> >> -               return -EOPNOTSUPP;
> >> +       if (!test_bit(*bit, handler->choices)) {
> >> +               switch (*bit) {
> >> +               case PLATFORM_PROFILE_QUIET:
> >> +                       *bit =3D PLATFORM_PROFILE_LOW_POWER;
> >> +                       break;
> >> +               case PLATFORM_PROFILE_LOW_POWER:
> >> +                       *bit =3D PLATFORM_PROFILE_QUIET;
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
> >> @@ -252,8 +264,16 @@ static int _aggregate_choices(struct device *dev,=
 void *data)
> >>          handler =3D to_pprof_handler(dev);
> >>          if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
> >>                  bitmap_copy(aggregate, handler->choices, PLATFORM_PRO=
FILE_LAST);
> >> -       else
> >> +       else {
> >> +               /* treat quiet and low power the same for aggregation =
purposes */
> >> +               if (test_bit(PLATFORM_PROFILE_QUIET, handler->choices)=
 &&
> >> +                   test_bit(PLATFORM_PROFILE_LOW_POWER, aggregate))
> >> +                       set_bit(PLATFORM_PROFILE_QUIET, aggregate);
> >> +               else if (test_bit(PLATFORM_PROFILE_LOW_POWER, handler-=
>choices) &&
> >> +                        test_bit(PLATFORM_PROFILE_QUIET, aggregate))
> >> +                       set_bit(PLATFORM_PROFILE_LOW_POWER, aggregate)=
;
> >>                  bitmap_and(aggregate, handler->choices, aggregate, PL=
ATFORM_PROFILE_LAST);
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

Which may not be the one that was shown before IIUC and that's not good.

What actually is the problem with the previous version?

