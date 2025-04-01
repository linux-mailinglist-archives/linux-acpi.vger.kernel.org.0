Return-Path: <linux-acpi+bounces-12583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD99A77A70
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C23C3A79D5
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 12:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B33202C43;
	Tue,  1 Apr 2025 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/m2p2JW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089111F91CD;
	Tue,  1 Apr 2025 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509648; cv=none; b=odbC3U4GVkP1U3P+PwuGJoFnh6kSqWBDMv9OZ8yIlmJtBoMQmZZGqxWrfF54aoDQyIQn/R/QLzdZIMPi5KRGHVBkEihp+kBhmZ86N+2z20seRfMI9oqVqiXuyV+cb5hIJjp9WDvVgbK7VTLZ2v1p1xiCur66FX6gpH5WahUFAB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509648; c=relaxed/simple;
	bh=cW+SgWG4t5icqmSDD5B28BvPyfh8yfBleexRLseF73k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7IduuxXE6+B03ZWxDxhXZtOyxF3EIh21tfOgn8mOSIk85iQCpleZZI+Ut1KJV68ChvdRIbf3Th+PBJCuY9oGRsfj0cTp/PeqcpmTvAwZMHm1XVXihkFeXQXgDhZvORfffnRwn/2KRsB5Mtvfk69uqXh1+BrOumBBZal1qg+LsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/m2p2JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C69DC4CEED;
	Tue,  1 Apr 2025 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743509646;
	bh=cW+SgWG4t5icqmSDD5B28BvPyfh8yfBleexRLseF73k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m/m2p2JWYS9MkVHRFy5prVSfpIMH5SY3jiiWZrPRgGhfd0KNH/PA1tOg7S+KrJxkk
	 JSX0cD90OB4srHDpp2NCGpyjzGIwACeD0oMeDEI8FNeU3Te/nSYZJ7IQ8PWzdUMktP
	 CDXdXN96p45hx7W98t9osxv7ohk1bS66TN+4GeSI2mFN8/2rYf0/Ma6kRPhVynCyUW
	 70E0A1eIbNihkaJVcogpm4i7xO3+1O18jP3ZXUGFwY/oCWWK2b3Xjxd35+2ElDER5Q
	 hbUeOONMmPAY/FcwTQ0BwB/gJZhc+EhEcCLduC0klRJrH0mL52uS+E/hvi0irNyREs
	 YZcmhVD7KYUvA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c818343646so3537995fac.3;
        Tue, 01 Apr 2025 05:14:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMrZQzrAu7UkbdnV/sC/nmXueENngvryKfXSR8c7+lxXDHT3/NNRI306Q0JNOctq+FympXMSN+I4U=@vger.kernel.org, AJvYcCWFhajWfdqvZaYPT/zH0Vj5js9X4Gqa3IKNn6/w1fTswFzj2pOvnSLz3y5vXLCJkglVOlxLJTJ5yAfn@vger.kernel.org, AJvYcCXI9bZWAUzTvzL4n7lb4DLNJNkiNwFK/d3j1sy3icOgrgAySbVKKbZJouOVn+rBnfGRttABtWWjQLF+zjJB@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhi0w1DlNHixMHdFhSJxS3ibbmRy8phzYa/n0PS+XwaunhDKAn
	1DNa2yJFo6P/dnsAxSytlBRcrjQlEqvvIFjok9RRooez/jvxpMNmigIwnjQiLXyG2DZz3lY3gHi
	krl3gTgaVXEMh12dBaLf00FNzqnE=
X-Google-Smtp-Source: AGHT+IGOlogupRrW1ILu3k/BWzEUrlfnOQdl3bgoOraLGfT5cXQwFCdTo4dpWOe+YYaMJLSMdHaLzj7VnVnNwllSJKU=
X-Received: by 2002:a05:6870:330a:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2cbcf7e09acmr7956746fac.36.1743509645617; Tue, 01 Apr 2025
 05:14:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328143040.9348-1-ggherdovich@suse.cz> <20250328143040.9348-2-ggherdovich@suse.cz>
 <SJ0PR11MB66228319834B1C7B48FCE52EF5AD2@SJ0PR11MB6622.namprd11.prod.outlook.com>
 <CAJZ5v0gC3DzanSdPqQiJ4JQppgNeRA7Z9Cge7NxmTO_shoUyOA@mail.gmail.com> <7a14ea42462a346958954f328933f583dcf9cb52.camel@intel.com>
In-Reply-To: <7a14ea42462a346958954f328933f583dcf9cb52.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Apr 2025 14:13:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juH2kYx-fyyfoFLBTjg30y59Dwj1wBYXxuHvU2c7X31w@mail.gmail.com>
X-Gm-Features: AQ5f1JqInvfmF-dEU2O33yfuIWE_7Znqodgm49GlPYWEkfdKphYD_-K3cc_SD6g
Message-ID: <CAJZ5v0juH2kYx-fyyfoFLBTjg30y59Dwj1wBYXxuHvU2c7X31w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "ggherdovich@suse.cz" <ggherdovich@suse.cz>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 2:25=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wro=
te:
>
> On Mon, 2025-03-31 at 14:07 +0200, Rafael J. Wysocki wrote:
> > On Mon, Mar 31, 2025 at 9:38=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com=
> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Giovanni Gherdovich <ggherdovich@suse.cz>
> > > > Sent: Friday, March 28, 2025 10:31 PM
> > > > To: Rafael J . Wysocki <rafael@kernel.org>; Zhang, Rui
> > > > <rui.zhang@intel.com>
> > > > Cc: Len Brown <lenb@kernel.org>; Giovanni Gherdovich
> > > > <ggherdovich@suse.cz>; linux-acpi@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; linux-pm@vger.kernel.org
> > > > Subject: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
> > > > Importance: High
> > > >
> > > > Since commit 496121c02127e9c460b436244c38260b044cc45a ("ACPI:
> > > > processor:
> > > > idle: Allow probing on platforms with one ACPI C-state"), the
> > > > comment
> > > > doesn't reflect the code anymore; remove it.
> > > >
> > > > Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > > > ---
> > > >  drivers/acpi/processor_idle.c | 4 ----
> > > >  1 file changed, 4 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/processor_idle.c
> > > > b/drivers/acpi/processor_idle.c
> > > > index b181f7fc2090..2a076c7a825a 100644
> > > > --- a/drivers/acpi/processor_idle.c
> > > > +++ b/drivers/acpi/processor_idle.c
> > > > @@ -482,10 +482,6 @@ static int
> > > > acpi_processor_get_cstate_info(struct
> > > > acpi_processor *pr)
> > > >
> > > >       pr->power.count =3D acpi_processor_power_verify(pr);
> > > >
> > > > -     /*
> > > > -      * if one state of type C2 or C3 is available, mark this
> > > > -      * CPU as being "idle manageable"
> > > > -      */
> > > >       for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> > > >               if (pr->power.states[i].valid) {
> > > >                       pr->power.count =3D i;
> > > > --
> > > > 2.43.0
> > >
> > > I think we can clean up a bit more. How about the patch below?
> > >
> > > From 115d3a07febff32eed49f9343ef111e7e1452f9d Mon Sep 17 00:00:00
> > > 2001
> > > From: "Zhang, Rui" <rui.zhang@intel.com>
> > > Date: Mon, 31 Mar 2025 07:29:57 +0000
> > > Subject: [PATCH] ACPI: processor: idle: Simplify
> > >  acpi_processor_get_cstate_info() logic
> > >
> > > Since commit 496121c02127 ("ACPI: processor: idle: Allow probing on
> > > platforms with one ACPI C-state"), acpi_idle driver can be probed
> > > with
> > > C1 only.
> > >
> > > Optimize the logic for setting pr->power.count and pr->flags.power by
> > > 1. unconditionally set pr->flags.power leveraging the fact that C1 is
> > >    always valid after acpi_processor_get_power_info_default().
> > > 2. update acpi_processor_power_verify() to return the highest valid
> > >    C-state directly.
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/acpi/processor_idle.c | 15 ++-------------
> > >  1 file changed, 2 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/acpi/processor_idle.c
> > > b/drivers/acpi/processor_idle.c
> > > index 698897b29de2..7ce8c3802937 100644
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -442,7 +442,7 @@ static int acpi_processor_power_verify(struct
> > > acpi_processor *pr)
> > >
> > >                 lapic_timer_check_state(i, pr, cx);
> > >                 tsc_check_state(cx->type);
> > > -               working++;
> > > +               working =3D i;
> >
> > What if some states are skipped because they are invalid?  'working'
> > can be less than 'i' then AFAICS.
>
> yes, but please refer to my comments here and below,
>
> 1. 'working' is used as return value only in acpi_processor_power_verify(=
).
>
> >
> > >         }
> > >
> > >         if (buggy_latency) {
> > > @@ -457,7 +457,6 @@ static int acpi_processor_power_verify(struct
> > > acpi_processor *pr)
> > >
> > >  static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
> > >  {
> > > -       unsigned int i;
> > >         int result;
> > >
> > >
> > > @@ -477,17 +476,7 @@ static int acpi_processor_get_cstate_info(struct
> > > acpi_processor *pr)
> > >         acpi_processor_get_power_info_default(pr);
> > >
> > >         pr->power.count =3D acpi_processor_power_verify(pr);
>
> 2. acpi_processor_get_cstate_info(), which is the only caller of
> acpi_processor_power_verify(), use this return value to set
> pr->power.count.

So far so good.

> > > -
> > > -       /*
> > > -        * if one state of type C2 or C3 is available, mark this
> > > -        * CPU as being "idle manageable"
> > > -        */
> > > -       for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
> > > -               if (pr->power.states[i].valid) {
> > > -                       pr->power.count =3D i;
>
> 3. use a loop to override pr->power.count with the index of the highest
> valid state

I see.

> So I'm proposing to return the index of the highest valid state directly
> in acpi_processor_power_verify() and then we don't need this loop any
> more.

OK, so I'd prefer to first rename power.count to power.max_index
(which it really is) and then make the changes you have proposed.

