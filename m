Return-Path: <linux-acpi+bounces-11269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FC4A3A588
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9AC1686AD
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7192356D1;
	Tue, 18 Feb 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDGuJ7Hq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF72356CE;
	Tue, 18 Feb 2025 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903271; cv=none; b=IRTrOmTjcRejMDqiXdotJBMT2dh3n16XLF6C8dZ1jm3XC3IHTm1rM1Q/V3AXNN95veZQFOtYBYO49tig7ZU45qBVDDAM0Ggv5KbpCtPhKqvd24mK6GR+7Zj4UOWdgE45bq1U5tU+TPTlFr6ItQDEf8ojEpBzO/e0aWrwbUtaQ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903271; c=relaxed/simple;
	bh=HxKuZoG5faLYpcvIYAbnKZghPB+UgsCntvdpKFyaRVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hjzexPmM5T4q1Zv+TweQQm0003k//y0Ex2LCagLU0sm6yqK78wNR6yD9T8yNGkUlpHFK0bq2uy8XJst5lOb4Pw9DobfMAcx+m7Nyn/skImLVwtJCWm55a/YH5h70kZ2nHnyjg1ZAgOIJGVTYDnUaeAYyrD3coM2x/yrJFD+SeEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDGuJ7Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FA9C4CEEB;
	Tue, 18 Feb 2025 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739903271;
	bh=HxKuZoG5faLYpcvIYAbnKZghPB+UgsCntvdpKFyaRVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qDGuJ7HqZuBQ1yLpk4Ai0UgteucDUpqqe7VMhU1iwDeu75i9PA0j6KW4vJEzzz/cL
	 xOApKilis9FKt6GwXUV0m4w2HgJP6ogCLn06mvGzxTn5t+8if3HHN1OB203iGoIA83
	 sYPSHDOgo0wU2jcLepJpKfbkLjayPM8RT2E+v8dYVbZC48MxLsP5MhXJ56K5ELMT4T
	 dy+eqAUn1tmJr2gQaX+oI5/TtrLZ6ipL/DuayiKr7kKj2NpiZZKVGhV+bBuQwp0hMp
	 STfOOoTDrrkvhPEV/MlmPzIY5H/sMvXmoq0qsvm+PyOsAOk/ZEqurFniSshjX3ZMw2
	 7RAbfcs2Em15Q==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3f410506043so24253b6e.0;
        Tue, 18 Feb 2025 10:27:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3MTB8CEuVrjT+fhtdR1CrnREUBVgiAfXmCweg3Ac5eL4yACS6UbBb3xcuJW9gbyj6sP9WcvjQyxU9ro8a@vger.kernel.org, AJvYcCXtYmImuWE1wgd1qgEQ2txrUXjf98HUxSm1W8xbDGeWVofuQVIGJy7dDV/DvtaPi4SF2CrHnqrKgkn8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzshei+bD9VwgEfNBaTIYkugjf1nnZRLJF+8GO8i5I25QPdDP1M
	1maqPR/bTppDqcDYKmo0J0sJF8vN7Yx9p4/b+CcAebgPoaqhqfzM0AKDroRcUfymsl9TrWhvUb7
	moP5HVmG2IAcGTR29EyiXaj9LPJU=
X-Google-Smtp-Source: AGHT+IGa7BMO7Wkfm+DYBVltpZHxVEi/pMSUuEhYVJBWRL3zo0/I7MHgntiQBtOfww2TxxblD8B73EqqL6D3Uln52fo=
X-Received: by 2002:a05:6808:3847:b0:3f1:c7ab:480 with SMTP id
 5614622812f47-3f3eb1216admr9373364b6e.27.1739903270509; Tue, 18 Feb 2025
 10:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212193058.32110-1-kuurtb@gmail.com> <9a8a5084-589d-4c45-a011-5bf4d0dfc8ba@app.fastmail.com>
 <CAJZ5v0hv3frfZCLgANBi-Kn8LCiuoWFSMcjDSipXQyycS5i1rw@mail.gmail.com> <D7VS189559P4.BKIIWBE7VCPE@gmail.com>
In-Reply-To: <D7VS189559P4.BKIIWBE7VCPE@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 19:27:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_wU-6tgZDtAJg=ypP=xM7dc3JCPf9AP0G6SDMEYS2og@mail.gmail.com>
X-Gm-Features: AWEUYZmIH4kksHN7xPu6G9ilXGAe2VNdbu1Qhwb6Gk7Al_4r1vKARswXQUJj8Q0
Message-ID: <CAJZ5v0i_wU-6tgZDtAJg=ypP=xM7dc3JCPf9AP0G6SDMEYS2og@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform_profile: Fix memory leak in profile_class_is_visible()
To: Kurt Borja <kuurtb@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Len Brown <lenb@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Limonciello, Mario" <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, Gergo Koteles <soyer@irl.hu>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 7:18=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote=
:
>
> On Tue Feb 18, 2025 at 1:07 PM -05, Rafael J. Wysocki wrote:
> > On Sat, Feb 15, 2025 at 3:18=E2=80=AFAM Mark Pearson <mpearson-lenovo@s=
quebb.ca> wrote:
> >>
> >>
> >> On Wed, Feb 12, 2025, at 2:30 PM, Kurt Borja wrote:
> >> > If class_find_device() finds a device it's reference count is
> >> > incremented. Call put_device() to drop this reference before returni=
ng.
> >> >
> >> > Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> >> > platform profile")
> >> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> >> > ---
> >> >  drivers/acpi/platform_profile.c | 8 +++++++-
> >> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/acpi/platform_profile.c
> >> > b/drivers/acpi/platform_profile.c
> >> > index fc92e43d0fe9..2ad53cc6aae5 100644
> >> > --- a/drivers/acpi/platform_profile.c
> >> > +++ b/drivers/acpi/platform_profile.c
> >> > @@ -417,8 +417,14 @@ static int profile_class_registered(struct devi=
ce
> >> > *dev, const void *data)
> >> >
> >> >  static umode_t profile_class_is_visible(struct kobject *kobj, struc=
t
> >> > attribute *attr, int idx)
> >> >  {
> >> > -     if (!class_find_device(&platform_profile_class, NULL, NULL,
> >> > profile_class_registered))
> >> > +     struct device *dev;
> >> > +
> >> > +     dev =3D class_find_device(&platform_profile_class, NULL, NULL,
> >> > profile_class_registered);
> >> > +     if (!dev)
> >> >               return 0;
> >> > +
> >> > +     put_device(dev);
> >> > +
> >> >       return attr->mode;
> >> >  }
> >> >
> >> >
> >> > base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
> >> > --
> >> > 2.48.1
> >> Good find. Looks good to me.
> >> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> >
> > Applied as 6.15 material, thanks!
>
> Hi Rafael,
>
> Thank you!
>
> I believe this should be merged as a fix for v6.14-rc4 before
> commit 77be5cacb2c2 hits stable.

I can queue it up for 6.14-rc, but that may not prevent 77be5cacb2c2
from going into -stable before it.

Thanks!

