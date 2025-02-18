Return-Path: <linux-acpi+bounces-11264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69DDA3A4F0
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC54168D3E
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36D270EC0;
	Tue, 18 Feb 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u05GIM1b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9A246348;
	Tue, 18 Feb 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902063; cv=none; b=tZZNE8ae2nnQF1qTmkNfRZlxtVOhhYaBPNA7P73Z1nNfeaHi4etcEUWgp8Ih9cazUswJCXVEYIGCgxUj+uENBiAqAXr3ndTC9BNQAd2lj0t8COga7+XweWDpgQItH7G955zjs1oCSJ4y1ZYp+OKRApm7uaM0WIuuwdZUmX6Dv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902063; c=relaxed/simple;
	bh=fv38A/jZk2hWPuTGmlaAYUt6BUalrsIkLT3UCj+BNOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ow8QGfb29RB5zCraD6gV+3MDibazPPtvmdtJwDFrRdsF7S96d6t4uEG+XVWpvL+OwBsoMdGTSnwUxH5K6uqt5x8J4RQltjHehEpqIXVRDxbpOCiM9sYC9A0LSr1EVFdCJeEdAiKsEZU/H2zR4k/ZjvMpQ5Rqnbn2Wb3pab7zYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u05GIM1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98951C4CEEA;
	Tue, 18 Feb 2025 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739902062;
	bh=fv38A/jZk2hWPuTGmlaAYUt6BUalrsIkLT3UCj+BNOQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u05GIM1bPF1fOZ3pjInd9U8T38l18MUA42POfYkeDvOK87TPINS/lwzp2FYh9sEi0
	 RFLBcrXB13uC8EpcQtPnQm6k1iPstp3r/He14I0UAYNBBkgMjXaDBWH0OWbVSln6nn
	 rpOWU960vFlNavmrxR95L3gSDVyR/jVzCKu9eeprpEcLOi8nF9IEU1W/PwEOy5aK6m
	 8nyBZe3+mh7bQPofmwUvwEhk16fdzHeVmjGkFOo8oEgSAwbNA1O1EzbwNp/enruR7H
	 s6DkAhjnHmreyQwp0UC23uHrWalaNeDY0w6G879eODkp3YSpyXuqv7nhcfxBiE7uHl
	 hMKeOmyBJ4p3w==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f40a38cb6bso429030b6e.1;
        Tue, 18 Feb 2025 10:07:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN2GKU+OjipgZdRR9kV9G6cwzz/wh3fpd47IZTiaisOMznH9hp0lFAzum6J5k5QQwNYnZLKM07Fc1E0Jr7@vger.kernel.org, AJvYcCWzxktvpqvdZA7V4rkdwAbIkImqEsVUr3C/MhUjGeCOtsaCFqdXLelkPVagM98BwAgg7EJv3yRXz+QD@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7Rjv24YjFP3SzSLnKcIBn7aZOsemzoUqwtWdz9rQiqkQuWud
	igQfB3hmWcL4ZPPV71kOTtEoDac7lxn4i1CFfIUcqpxmDO3OzRmPxEim7sB/f64XqHfTl83J/OB
	L/4dSUNyG7Y7RaS5QQUJ7DFTqahc=
X-Google-Smtp-Source: AGHT+IHtCzeowEMsz7o85Uwwfq1Mxs+5d0HRYs5q+Hir4NsEiOM4NJfyws+ifmwOdGlRPkcMPcF/vdxhDliEhECCev0=
X-Received: by 2002:a05:6808:1a08:b0:3eb:3b69:8ff4 with SMTP id
 5614622812f47-3f40f1eb965mr434145b6e.15.1739902061872; Tue, 18 Feb 2025
 10:07:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212193058.32110-1-kuurtb@gmail.com> <9a8a5084-589d-4c45-a011-5bf4d0dfc8ba@app.fastmail.com>
In-Reply-To: <9a8a5084-589d-4c45-a011-5bf4d0dfc8ba@app.fastmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 19:07:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hv3frfZCLgANBi-Kn8LCiuoWFSMcjDSipXQyycS5i1rw@mail.gmail.com>
X-Gm-Features: AWEUYZkPklzlv2gvlQCGDPAXygqxoHj3l42L2M7DsqRdRMjTabp0oARrhuydHWA
Message-ID: <CAJZ5v0hv3frfZCLgANBi-Kn8LCiuoWFSMcjDSipXQyycS5i1rw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: platform_profile: Fix memory leak in profile_class_is_visible()
To: Mark Pearson <mpearson-lenovo@squebb.ca>, Kurt Borja <kuurtb@gmail.com>
Cc: Len Brown <lenb@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Limonciello, Mario" <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, Gergo Koteles <soyer@irl.hu>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 3:18=E2=80=AFAM Mark Pearson <mpearson-lenovo@squeb=
b.ca> wrote:
>
>
> On Wed, Feb 12, 2025, at 2:30 PM, Kurt Borja wrote:
> > If class_find_device() finds a device it's reference count is
> > incremented. Call put_device() to drop this reference before returning.
> >
> > Fixes: 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> > platform profile")
> > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > ---
> >  drivers/acpi/platform_profile.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/platform_profile.c
> > b/drivers/acpi/platform_profile.c
> > index fc92e43d0fe9..2ad53cc6aae5 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -417,8 +417,14 @@ static int profile_class_registered(struct device
> > *dev, const void *data)
> >
> >  static umode_t profile_class_is_visible(struct kobject *kobj, struct
> > attribute *attr, int idx)
> >  {
> > -     if (!class_find_device(&platform_profile_class, NULL, NULL,
> > profile_class_registered))
> > +     struct device *dev;
> > +
> > +     dev =3D class_find_device(&platform_profile_class, NULL, NULL,
> > profile_class_registered);
> > +     if (!dev)
> >               return 0;
> > +
> > +     put_device(dev);
> > +
> >       return attr->mode;
> >  }
> >
> >
> > base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
> > --
> > 2.48.1
> Good find. Looks good to me.
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Applied as 6.15 material, thanks!

