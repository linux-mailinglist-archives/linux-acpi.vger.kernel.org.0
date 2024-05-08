Return-Path: <linux-acpi+bounces-5659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31798BFDD3
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 14:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D3D283348
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61A5D74C;
	Wed,  8 May 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VidFep32"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD1F5B1E4
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172967; cv=none; b=Fv92jFI+m7pxExRXUVT8+Qb5eX38qFGZZuO+3SJkYdP2kekEbqXsgbXy2CgN+lySsG2UtsAQPt5uFpY6JvL1o08iqWBdFZ+CFz4NxKKZCpXhTT9sRdeWn6t7MJKGOj1+F5QWEO0PLIzEWVXZYs6gPGYjbwKilTVXqTJVU18QzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172967; c=relaxed/simple;
	bh=25OHVSzE17X3IyS4SOYKNJjuOEZtWJmB6f2CGqotamU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KR+3PGUPTs6J1hKaxblOU5OQTqUm44zJKPAzemXqrcCMWgcQ9/vhCaizzjo+tODkgOVAzPnRmWM55SfhTTNWJ7dgTwI9Dg4m8qIPTunlP5WLbRtOpl/e7KiyXlm8GBFIzDpzA+CYjTFNBrJ+U3PngK1TSXninb6AiYyWcIanc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VidFep32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E29BC4AF63
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715172966;
	bh=25OHVSzE17X3IyS4SOYKNJjuOEZtWJmB6f2CGqotamU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VidFep32CWhxeF18PHLetrp+9m5xLntz4tpdt1RAx7TiHvo1vWS22thNcZ7dVWC1y
	 W4dz7qOQ+hkNvzm0B2Z7z1ZoJArf4SwRRhLkUgFuVuyHBgCWNjQ5I6d72jgKcgA1mE
	 fRN+NhBp5caADIiOYSmt++UeOaF+XC6wRwSrxiH78x6K/269CJ04pl14LmaMNpuhaa
	 q7oyT1vWGH3+2viznpKjiiyJnH0iB+rIG0yiF/0LzqF40b6EHbPpylskTIcvdHwFPC
	 MG5jH77DVef8J82NnZnanrDF9iPu4YUytzPS1x4U3HgCTyGZnJUgjG12VPgb3b5Mve
	 aCgA8S7FTaPEQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ad288442bdso490232eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 08 May 2024 05:56:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZBdLGal8Kh3D8gb7PxMueaxb+bGc6PJbdX9is4ff55qsb9p22KOi/pW3oJS3/EeXP7SRnjFIzbMoiVQkgSIysEz5zghh9R8vauw==
X-Gm-Message-State: AOJu0YzvPJUO20okTwjRnz63mYunb0U4KL9vdCWef+Ke0t2K9m61hXBu
	jmZKSqbxUrA6QvbL7xLSdw9Xpy9Lm4S8cB6gp3raL7P6NdiAhYrWzxm5EF8St2Lazv9nH08f+MK
	UtwMmGLmoYc17VOq1L8SoAOoxyrg=
X-Google-Smtp-Source: AGHT+IFKL6/c0XebvjWhJj0g7H4oUzqGJmL7r7wgJX1KNn+62y5tL6OEGsNYargXwx4rAbi0FnG0X91RKcn8F58TZZE=
X-Received: by 2002:a4a:d12b:0:b0:5b2:f29:93f4 with SMTP id
 006d021491bc7-5b24ca9ea41mr2383445eaf.0.1715172965814; Wed, 08 May 2024
 05:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com> <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
 <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com> <5781917.DvuYhMxLoT@kreacher>
In-Reply-To: <5781917.DvuYhMxLoT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 May 2024 14:55:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jx1QLRwwfZuKDs8mQUvoyL_oeuYNg6JYRueOdfBXXtQg@mail.gmail.com>
Message-ID: <CAJZ5v0jx1QLRwwfZuKDs8mQUvoyL_oeuYNg6JYRueOdfBXXtQg@mail.gmail.com>
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 2:50=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
>
> [Resending because it appears to have got lost, sorry for duplicates.]
>
> On Wednesday, May 8, 2024 2:20:59 PM CEST Heikki Krogerus wrote:
> > On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
> > > Hi,
> > >
> > > On Mon, Apr 29, 2024 at 4:55=E2=80=AFPM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > There's a bug that is caused by an EmbeddedControl OpRegion which i=
s
> > > > declared inside the scope of a specific USB Type-C device (PNP0CA0)=
:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D218789
> > >
> > > And in this bug you are essentially proposing to install the EC
> > > OpRegion handler at the namespace root instead of the EC device.
> > >
> > > This sounds reasonable, although AFAICS this is a matter of modifying
> > > the EC driver (before the EC OpRegion handler is installed by the EC
> > > drvier, ACPICA has no way to handle EC address space accesses anyway)=
.
> > >
> > > > It looks like that's not the only case where that OpRegion ID is us=
ed
> > > > outside of the EC device scope. There is at least one driver in Lin=
ux
> > > > Kernel (drivers/platform/x86/wmi.c) that already has a custom handl=
er
> > > > for the EmbeddedControl OpRegion, and based on a quick search, the
> > > > problem "Region EmbeddedControl (ID=3D3) has no handler" has happen=
ed
> > > > with some other devices too.
> > >
> > > AFAICS, installing the EC address space handler at the EC device
> > > object itself is not based on any sound technical arguments, it's jus=
t
> > > been always done this way in Linux.  It's quite possible that the EC
> > > address space handler should have been installed at the namespace roo=
t
> > > from the outset.
> >
> > Okay, thank you for the explanation. So can we simply change it like
> > this (I may have still misunderstood something)?
>
> Roughly speaking, yes, but it is missing an analogous change around
> the removal.

Actually, not around the removal, but around the evaluation of _REG
methods and dropping address_space_handler_holder is better IMO,
because it will always be ACPI_ROOT_OBJECT now.

> Please see the appended patch (which I have created independently in
> the meantime).  It doesn't break stuff for me and Andy points out that
> there are examples of EmbeddedControl OpRegions outside the EC device
> scope in the spec (see Section 9.17.15 in ACPI 6.5, for instance).
>
> So I think that this change can be made relatively safely (but adding Han=
s and
> Mario to the CC in case they know something that might be broken by it).
>
>
> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> > index 02255795b800..6b9dd27171ee 100644
> > --- a/drivers/acpi/ec.c
> > +++ b/drivers/acpi/ec.c
> > @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct acpi_ec *ec=
, struct acpi_device *device,
> >
> >         if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
> >                 acpi_ec_enter_noirq(ec);
> > -               status =3D acpi_install_address_space_handler_no_reg(ec=
->handle,
> > +               status =3D acpi_install_address_space_handler_no_reg(AC=
PI_ROOT_OBJECT,
> >                                                                    ACPI=
_ADR_SPACE_EC,
> >                                                                    &acp=
i_ec_space_handler,
> >                                                                    NULL=
, ec);
> > @@ -1497,7 +1497,7 @@ static int ec_install_handlers(struct acpi_ec *ec=
, struct acpi_device *device,
> >                         return -ENODEV;
> >                 }
> >                 set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> > -               ec->address_space_handler_holder =3D ec->handle;
> > +               ec->address_space_handler_holder =3D ACPI_ROOT_OBJECT;
> >         }
> >
> >         if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) =
{
> >
>
> ---
>  drivers/acpi/ec.c       |   10 +++++-----
>  drivers/acpi/internal.h |    1 -
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/acpi/ec.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct ac
>
>         if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>                 acpi_ec_enter_noirq(ec);
> -               status =3D acpi_install_address_space_handler_no_reg(ec->=
handle,
> +               status =3D acpi_install_address_space_handler_no_reg(ACPI=
_ROOT_OBJECT,
>                                                                    ACPI_A=
DR_SPACE_EC,
>                                                                    &acpi_=
ec_space_handler,
>                                                                    NULL, =
ec);
> @@ -1497,11 +1497,10 @@ static int ec_install_handlers(struct ac
>                         return -ENODEV;
>                 }
>                 set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> -               ec->address_space_handler_holder =3D ec->handle;
>         }
>
>         if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
> -               acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
> +               acpi_execute_reg_methods(ACPI_ROOT_OBJECT, ACPI_ADR_SPACE=
_EC);
>                 set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>         }
>
> @@ -1555,8 +1554,9 @@ static void ec_remove_handlers(struct ac
>  {
>         if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>                 if (ACPI_FAILURE(acpi_remove_address_space_handler(
> -                                       ec->address_space_handler_holder,
> -                                       ACPI_ADR_SPACE_EC, &acpi_ec_space=
_handler)))
> +                                               ACPI_ROOT_OBJECT,
> +                                               ACPI_ADR_SPACE_EC,
> +                                               &acpi_ec_space_handler)))
>                         pr_err("failed to remove space handler\n");
>                 clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>         }
> Index: linux-pm/drivers/acpi/internal.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -186,7 +186,6 @@ enum acpi_ec_event_state {
>
>  struct acpi_ec {
>         acpi_handle handle;
> -       acpi_handle address_space_handler_holder;
>         int gpe;
>         int irq;
>         unsigned long command_addr;
>
>
>

