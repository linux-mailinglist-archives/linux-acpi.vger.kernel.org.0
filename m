Return-Path: <linux-acpi+bounces-8494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D898A231
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 14:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC6A284A9C
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A9190059;
	Mon, 30 Sep 2024 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqZo/0bD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792B18EFD4;
	Mon, 30 Sep 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698714; cv=none; b=RcUi30MhWYrEM7hHJoJLZRymPAOvvvaQAx9e/tkKBQkRa48ZEonVyDYeieBTT3PApQ9Sz9fGYO4oOXshW4Mm9ENrZLlakYuDLUdU91QhcoBm/QM3905dNQqPc/N82HrbvEJb31RVC4FQdzR/3VYmk43FpFRV44F0VO1cZdQ3uGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698714; c=relaxed/simple;
	bh=DqgkOK0c1WAPtZv1JIxjBbNZvRGsp4zZcjU+1weQBwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juesommcz/NBErsSLjbHXxRbczkx0TbSyoTKmSAMcv782h2IU/ahxy8soVRRTNsglntIL7vcyMdXzZ+EiEDGcVgfcx5WFRcrVNfwASU3lkOqMBrYKyBq5HDLLACRZjev5IxfonEC5/ZcAWCK5CHXjU0G+HD0iTz+s1gbqQYgE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqZo/0bD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE78C4CED4;
	Mon, 30 Sep 2024 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727698713;
	bh=DqgkOK0c1WAPtZv1JIxjBbNZvRGsp4zZcjU+1weQBwY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VqZo/0bDUoG8SQwyZseB+cS8MztNc2Ah+dqnB3QpXDwPqLT1ITGDGL4AXSYJiYKaK
	 eK0pDgGLK7wDVfwJmpHVbsh72Y9l4JdZgrqGNj34ZODQwFHcV9U0NW3O40MnVBVIoY
	 W18nu0WnwcekZVDXRGeeXfNYYBgZrrcZVx/aF5uglR4gduUo7q/p0q2Z4Zxcr8FUOz
	 h1Plm3WrbgInBosXBejLSUhPeacy27oz99LmiuqVC9HsOTMSjrtDjGCUH36X/eHZvW
	 ygsWWPEdzKydx55proOoc69QFyFvvVru8BNG/lCqbJZ/MUbr+VBSNif3aKeOiUTgta
	 ETQTV6oP1GMIA==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7091558067eso1540446a34.3;
        Mon, 30 Sep 2024 05:18:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKjF74PCK3NbRNYQOmrBJt9bvsYxegrB6q/SBWaq3S8Jm7Wk6SFvlnWFoBIZcivmKTN45xUOZfGvv4@vger.kernel.org, AJvYcCWXRIkcxK9wJgpF1IqEgsPjv3P7DUwjXziMgkRhsF9+In0/oiWr3k8g/6DMeLOyu+3XRbXwc1pg@vger.kernel.org
X-Gm-Message-State: AOJu0YyI57QwL9GyKiBNPjcY/ztwL4B2O8gOEG405/luavDEzmjG3NnB
	eBGsUlGksEark60FNxde81GBj4AqR5OfsVSjf+4U0q/q4nF4sQAIn9zsdAnhGEgSurbYDjYsv6T
	Ah+m765TbJIv1K1Nm3Z+L4chwMPQ=
X-Google-Smtp-Source: AGHT+IFnM5CzHQNkvnbcGZiEv55cRi6RA9rWLscchcqhi6cSF9Lb8SPy2BMjXcnQ7ceC+a9vprwwPaDy/bLDZ6KivgI=
X-Received: by 2002:a05:6830:a91:b0:709:4266:988f with SMTP id
 46e09a7af769-714fbeff9eemr8121155a34.25.1727698712896; Mon, 30 Sep 2024
 05:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927141606.66826-1-hdegoede@redhat.com> <20240927141606.66826-2-hdegoede@redhat.com>
 <2f45a6ac-5bb7-4954-adb5-3bf706363062@molgen.mpg.de> <d69af7ad-244d-45e8-ad7e-4a3ebf30d04d@redhat.com>
In-Reply-To: <d69af7ad-244d-45e8-ad7e-4a3ebf30d04d@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Sep 2024 14:18:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gxSz-aeoDqhp1dS5g6aoDXSn8ZwYB0TuN7SU2Sbar8ow@mail.gmail.com>
Message-ID: <CAJZ5v0gxSz-aeoDqhp1dS5g6aoDXSn8ZwYB0TuN7SU2Sbar8ow@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: resource: Loosen the Asus E1404GAB DMI match to
 also cover the E1404GA
To: Hans de Goede <hdegoede@redhat.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Ben Mayo <benny1091@gmail.com>, Tamim Khan <tamim@fusetak.com>, linux-acpi@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 12:56=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 30-Sep-24 12:42 PM, Paul Menzel wrote:
> > Dear Hans,
> >
> >
> > Thank you for your patch.
> >
> > Am 27.09.24 um 16:16 schrieb Hans de Goede:
> >> Like other Asus Vivobooks, the Asus Vivobook Go E1404GA has a DSDT
> >> describing IRQ 1 as ActiveLow, while the kernel overrides to Edge_High=
.
> >>
> >>      $ sudo dmesg | grep DMI:.*BIOS
> >>      [    0.000000] DMI: ASUSTeK COMPUTER INC. Vivobook Go E1404GA_E14=
04GA/E1404GA, BIOS E1404GA.302 08/23/2023
> >>      $ sudo cp /sys/firmware/acpi/tables/DSDT dsdt.dat
> >>      $ iasl -d dsdt.dat
> >>      $ grep -A 30 PS2K dsdt.dsl | grep IRQ -A 1
> >>                  IRQ (Level, ActiveLow, Exclusive, )
> >>                      {1}
> >>
> >> There already is an entry in the irq1_level_low_skip_override[] DMI ma=
tch
> >> table for the "E1404GAB", change this to match on "E1404GA" to cover
> >> the E1404GA model as well (DMI_MATCH() does a substring match).
> >
> > Ah, good to know. Thank you for fixing it.
> >
> >> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219224
> >> Cc: Tamim Khan <tamim@fusetak.com>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >> Note this patch replaces Paul Menzel's patch which added a new entry
> >> for the "E1404GA", instead of loosening the "E1404GAB" match:
> >> https://lore.kernel.org/linux-acpi/20240911081612.3931-1-pmenzel@molge=
n.mpg.de/
> >> ---
> >>   drivers/acpi/resource.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> >> index 1ff251fd1901..dfe108e2ccde 100644
> >> --- a/drivers/acpi/resource.c
> >> +++ b/drivers/acpi/resource.c
> >> @@ -504,10 +504,10 @@ static const struct dmi_system_id irq1_level_low=
_skip_override[] =3D {
> >>           },
> >>       },
> >>       {
> >> -        /* Asus Vivobook Go E1404GAB */
> >> +        /* Asus Vivobook Go E1404GA* */
> >
> > I guess people are going to grep for the model, if something does not w=
ork, so maybe the known ones should listed. I know it=E2=80=99s not optimal=
, as the comments are very likely be incomplete, but it=E2=80=99s better th=
an than not having it listed, in my opinion.
>
> That is a valid point, OTOH I don't think we want to take patches later j=
ust to update
> the comment if more models show up.
>
> I guess we could change the comment to:
>
>                 /* Asus Vivobook Go E1404GA / E1404GAB */
>
> Rafael any preference from you here ?   (1)

Not really.

> Regards,
>
> Hans
>
>
>
>
>
> 1) Other then coming up with a better fix which does not require this qui=
rks at all ...

Yeah.

