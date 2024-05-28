Return-Path: <linux-acpi+bounces-6069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3B08D254D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 21:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C53F1C25A9E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 19:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CFF178383;
	Tue, 28 May 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+OAbSM0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640D178372;
	Tue, 28 May 2024 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926283; cv=none; b=qJv4HWFguycOCsXUaV1t7PVRtwh3/cZKK8hZ+My0hZMl0Res1w8LmGh2BVYnSFgoNNX9a6bBzvfSOrCUziJ9pUfQuFIgLIt4SrRyojV7xez4WHYBTltPYqnwg5Fkjw3HET+/4jBXpJ+po0x1UO0sNTc/Atva81Eseokd93x+3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926283; c=relaxed/simple;
	bh=BZlSwuttDPw9S9+xlwtc5/DNO6T6WU/rzwVlBiGJZJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShGq6ZyUExZAmVeO0226HWEYf8pMOsu9f2l2Yu3V4QZ15hqrQawre/e1tCURGVcYIs6qsh/wNSVeui8e6lFCVCSIyHz5O9aVynU39VWiW19y0ZK1d3Ldau8UoafartWBG4fAac3fTMj52eEeSINlUDaTkovzDspDkf6gtmGeILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+OAbSM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC8AC32786;
	Tue, 28 May 2024 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926283;
	bh=BZlSwuttDPw9S9+xlwtc5/DNO6T6WU/rzwVlBiGJZJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W+OAbSM0A/BaV3StQPVI1WdF2UWFKuReytJe3cR/rVYbeVX5pTYv1sUodh8WAjSac
	 VTqwOu7uYLtO/MfClEvTFskJoPIZWxbetOMyVaV9aZ/gQOttZJ6Hc0k59F6nsUwNc3
	 bfRwG4N/8+4N1AHKKlTkXOEKZ5IpCvf3AKDXnVeyA0zRLv00PByTXustEVm7s7X8Nv
	 3uLtEyBEd4SSk85AMKQDjw7ulj6cBfOi9lDyWqH69TFFBrjnmQmirO+EQpCUYnigrz
	 z9BDbe5PFQ8XaxFA8dE6Dd3JtVOrNtjYouQCWxF34HR6JbIByX5bh4FsCJ7IR64Y5G
	 USw2t+bDMboaQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24ffb6ee0f4so33807fac.0;
        Tue, 28 May 2024 12:58:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkTXyWD3+MX679GIohMb62YdYTiD7XsG9nBVRsjMx9rXcd+5kNLySG/V6kLOCdP23PD2zINRkPAkmQr/BahixKqkaOA9kyx85xNyc8Nbejhqbj9vxNwP4hxbYWDkA9QBB+npU98KdOMGu3EMEZF44fgrcHw+UzvWqZwgpzSm/jy822
X-Gm-Message-State: AOJu0YyTv2qRgPGm/j2bbOYNB5+bV7IXlpTPwwE1CJ5KTYIwaaxOczhA
	fgFo5dLIBNp6hT6lCj0dbH16D5zcyviU3YKbwlghs8OullzyGgpj5++WMIA19DImRlrA61z/09W
	a1RfUPm8cfE04ZY9HiIS7OV3TGo8=
X-Google-Smtp-Source: AGHT+IHhJdeeDpS76IDj68NZSHlaeZBVsNJkwgWvAhU1PNPDrzgrgarPIYTNLvW7O8ElosU15zALYFfGTD9297NASQM=
X-Received: by 2002:a05:6870:d888:b0:24c:b2d0:bfff with SMTP id
 586e51a60fabf-24cb2d0c0camr12861111fac.2.1716926282655; Tue, 28 May 2024
 12:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526-acpi-ac-changed-v1-1-f4b5997753bb@weissschuh.net> <r5x24fxz5cbyd4laoteq577toqfblfmy4btn4c6o6rrl7godeu@4fgsimcubzrd>
In-Reply-To: <r5x24fxz5cbyd4laoteq577toqfblfmy4btn4c6o6rrl7godeu@4fgsimcubzrd>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 21:57:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNs5vSMuPgtg=tbu=4Y1UHeGUnGM7Fo_LgjZmP1SqkZg@mail.gmail.com>
Message-ID: <CAJZ5v0hNs5vSMuPgtg=tbu=4Y1UHeGUnGM7Fo_LgjZmP1SqkZg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: AC: Properly notify powermanagement core about changes
To: Sebastian Reichel <sebastian.reichel@collabora.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Rajas Paranjpe <paranjperajas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 11:43=E2=80=AFPM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Sun, May 26, 2024 at 11:40:01PM +0200, Thomas Wei=C3=9Fschuh wrote:
> > The powermanagement core does various actions when a power-supply chang=
es.
> > It calls into notifiers, LED triggers, other power supplies and emits a=
n uevent.
> >
> > To make sure that all these actions happen properly call power_supply_c=
hanged().
> >
> > Reported-by: Rajas Paranjpe <paranjperajas@gmail.com>
> > Closes: https://github.com/MrChromebox/firmware/issues/420#issuecomment=
-2132251318
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>
> -- Sebastian
>
> >  drivers/acpi/ac.c  | 4 ++--
> >  drivers/acpi/sbs.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> > index 2d4a35e6dd18..09a87fa222c7 100644
> > --- a/drivers/acpi/ac.c
> > +++ b/drivers/acpi/ac.c
> > @@ -145,7 +145,7 @@ static void acpi_ac_notify(acpi_handle handle, u32 =
event, void *data)
> >                                                 dev_name(&adev->dev), e=
vent,
> >                                                 (u32) ac->state);
> >               acpi_notifier_call_chain(adev, event, (u32) ac->state);
> > -             kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
> > +             power_supply_changed(ac->charger);
> >       }
> >  }
> >
> > @@ -268,7 +268,7 @@ static int acpi_ac_resume(struct device *dev)
> >       if (acpi_ac_get_state(ac))
> >               return 0;
> >       if (old_state !=3D ac->state)
> > -             kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
> > +             power_supply_changed(ac->charger);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> > index 94e3c000df2e..dc8164b182dc 100644
> > --- a/drivers/acpi/sbs.c
> > +++ b/drivers/acpi/sbs.c
> > @@ -610,7 +610,7 @@ static void acpi_sbs_callback(void *context)
> >       if (sbs->charger_exists) {
> >               acpi_ac_get_present(sbs);
> >               if (sbs->charger_present !=3D saved_charger_state)
> > -                     kobject_uevent(&sbs->charger->dev.kobj, KOBJ_CHAN=
GE);
> > +                     power_supply_changed(sbs->charger);
> >       }
> >
> >       if (sbs->manager_present) {
> > @@ -622,7 +622,7 @@ static void acpi_sbs_callback(void *context)
> >                       acpi_battery_read(bat);
> >                       if (saved_battery_state =3D=3D bat->present)
> >                               continue;
> > -                     kobject_uevent(&bat->bat->dev.kobj, KOBJ_CHANGE);
> > +                     power_supply_changed(bat->bat);
> >               }
> >       }
> >  }
> >
> > ---

Applied as 6.10-rc material, thanks!

