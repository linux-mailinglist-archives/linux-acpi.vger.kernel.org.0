Return-Path: <linux-acpi+bounces-14946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FFAAF5F3F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C5D3AB815
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21FB2FC3AE;
	Wed,  2 Jul 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sER/DzSx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B92F0E5E;
	Wed,  2 Jul 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475421; cv=none; b=e7KTjh+Lj1cM4DDt9/QzRPyZT5xeAVScEU4aRd5qZ/PtljoCgggr2FI7bC7xbQ2YMehF0TXIQPdtytTunI+l++pL2whm8DU5fLQknPE+VrH+gZkHueonkRze0SICS+Ivei8J5ZutzZmGdjN4pgjoOM3vNRU3M+qS7JT+T1wxClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475421; c=relaxed/simple;
	bh=5fLW9lHTWD1y79pwK2fgk5Kd5I6KUd1GhgRK6nF2tYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdOhbJQOUMH3wJSYDCHOfJBVhitp5rdPgEOpsXDguLuslYw3dJGGRKgIB9OWX56lIw8xIthUH9zHU8TSDdN2Kqtpvj5LsHFY8A4NVp5W43XqOCarGxJVk5/QolLsq4yK+eNbdHxaGipBAWGdx+bjdC1umaFrsD60kNbquz1X/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sER/DzSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025B1C4CEED;
	Wed,  2 Jul 2025 16:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475421;
	bh=5fLW9lHTWD1y79pwK2fgk5Kd5I6KUd1GhgRK6nF2tYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sER/DzSxLf1cACrNLDFA83rnzm9Yg3EebdeAqx58yqiK8+c7PkNjE0vxNUv2apS/G
	 2lPoZLTxhECQi7CmUZVgv9T2HSwj4c6gAz7aiFKwatOMMAq170Kl/dnj2QMDTvgkXa
	 BMLZKktwQ08bMScdmxxW5+l+gJh08yituY7oCuLzPMFFq1Iyq0xoCp9qX/ONjpn743
	 6I2Z0/hpHrNDR+lGUkdTrAb6leaLc2wHgTZOC8TwbwfoRfW3IAJi3wzK2/FbZvcfcG
	 8gDWJ8Y/LgDObJsEmBXM+irkNgcmrhBhjMXdPgXbga2ePnNfe/Wfn8UK3KS7FpTeyH
	 GtemJkj0F817g==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-611e20dd2ffso898126eaf.2;
        Wed, 02 Jul 2025 09:57:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdA+xgBVFYNU1Jt4PYEkKdfyFdObMNhrynAT28nU7kiHOIlq+n23H3zgQWQjgiE8zBdVn2HIW60YOE@vger.kernel.org, AJvYcCVN57P8pKk/R381uDsSjKQ/vA8XOEret8nxnsWiKzKKr9OGaXkqawMYltI/IVdCLF6bHKVwxZpURt+hevT6@vger.kernel.org, AJvYcCWGbEqNT6SeVaSrZgV8rrgXaoGEx9JRBMVUIjd1G2MRF+poqNpD0sa5jZhqEeSlTGiW6zbDhVQORqZa/Q==@vger.kernel.org, AJvYcCWPuUHWzM0MPKH4nO4EXqwT9NK9s/3Stc5cH7ZxZzDwxBYDVhS45Cww5Elu+9DiK8fHLMCFR5ys/ytV@vger.kernel.org
X-Gm-Message-State: AOJu0YyoeapCdpPJxctxnas3i7rA4PDVwyy/eLmNJ3J+7dIrUw2HNRpi
	R5EaE1e2bsVFgrrTMvLCYYpCix35tev4Z621o4s7vbIkxzcpm1yMEFHVa/BHZ5omP1pElImAqcq
	aX0n57iRBRyt+BkBg7ATCsD6RzkNeVYc=
X-Google-Smtp-Source: AGHT+IH9qNtwc3BZ2zcpxgSNEE28TzTLjJ7V6ei87dF1FcJIxoWDLz53sAGHsJJOhX0RJfWm/FheCXyuy0fLYb8IODw=
X-Received: by 2002:a05:6808:1706:b0:40a:52cf:8870 with SMTP id
 5614622812f47-40bfde82cbcmr15178b6e.26.1751475420246; Wed, 02 Jul 2025
 09:57:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com> <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
 <aGUaFX9WgTW1I_ZO@smile.fi.intel.com> <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
 <aGVK7NxRdDIGRzNR@sunil-laptop>
In-Reply-To: <aGVK7NxRdDIGRzNR@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 18:56:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hTzrxqfejxSxqh9igiDp=8LkBw+FGSf9CJ7j3RyTJLBQ@mail.gmail.com>
X-Gm-Features: Ac12FXxz2sRU5vqvKRB8NuHZ48tg4u3JFhsyNnnrs4x6Kv_jRDKQqaFb0Fqjbyc
Message-ID: <CAJZ5v0hTzrxqfejxSxqh9igiDp=8LkBw+FGSf9CJ7j3RyTJLBQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/24] ACPI: property: Add support for cells property
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Anup Patel <apatel@ventanamicro.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Rahul Pathak <rpathak@ventanamicro.com>, 
	Leyfoon Tan <leyfoon.tan@starfivetech.com>, Atish Patra <atish.patra@linux.dev>, 
	Andrew Jones <ajones@ventanamicro.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 5:06=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> On Wed, Jul 02, 2025 at 02:39:30PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 2, 2025 at 1:38=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jul 2, 2025 at 7:16=E2=80=AFAM Anup Patel <apatel@ventanami=
cro.com> wrote:
> > >
> > > ...
> > >
> > > > >  static int acpi_fwnode_get_reference_args(const struct fwnode_ha=
ndle *fwnode,
> > > > >                                           const char *propname, c=
onst char *nargs_prop,
> > > > >                                           unsigned int args_count=
, unsigned int index,
> > >
> > > > >         const struct acpi_device_data *data;
> > > > >         struct fwnode_handle *ref_fwnode;
> > > > >         struct acpi_device *device;
> > > > > +       unsigned int nargs_count;
> > > > >         int ret, idx =3D 0;
> > >
> > > > > +                       nargs_count =3D acpi_fwnode_get_args_coun=
t(device, nargs_prop);
> > > >
> > > > I think it should work the same way as it used to for the callers t=
hat
> > > > pass args_count, so maybe
> > > >
> > > > if (!args_count)
> > > >         args_count =3D acpi_fwnode_get_args_count(device, nargs_pro=
p);
> > >
> > > But this is different variable.
> >
> > Of course it is different.  It is an acpi_fwnode_get_reference_args() p=
arameter.
> >
> > > > >                         element++;
> > > > > -
> > > > >                         ret =3D acpi_get_ref_args(idx =3D=3D inde=
x ? args : NULL,
> > > > >                                                 acpi_fwnode_handl=
e(device),
> > > > > -                                               &element, end, ar=
gs_count);
> > > > > +                                               &element, end,
> > > > > +                                               nargs_count ? nar=
gs_count : args_count);
> > > >
> > > > And this change would not be necessary?
> > >
> > > This is not the same check as proposed above.
> >
> > No, it is not.
> >
> > It just makes the function work the same way it did before the change
> > for the callers who passed nozero args_count and so they might be
> > forgiven expecting that it would be taken into account.
>
> But if we do like this, the expectation of
> fwnode_property_get_reference_args() will differ for DT and ACPI, right?
> I mean nargs_prop should take higher precedence than nargs.

So you basically want acpi_fwnode_get_reference_args() to take
nargs_prop into account (which could be explained much cleaner in the
patch changelogs).

Also, your changes don't modify the behavior of
__acpi_node_get_property_reference() AFAICS, so this is OK.

Never mind then, but you could pass nargs_prop along with the
additional device parameter to acpi_get_ref_args() and make that
function obtain the nargs_prop value.  In the patch, you need to get
the nargs_prop value before calling it anyway in both places in which
it is used.

