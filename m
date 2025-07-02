Return-Path: <linux-acpi+bounces-14934-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27AAF15E0
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3127167A74
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE412741BC;
	Wed,  2 Jul 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/eKRVFZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64F1E485;
	Wed,  2 Jul 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459982; cv=none; b=q3fcJtPwQEqSciWx8iO9/NlIHGbagL/+qbDP0TAaSV5f9dS1UC4YyHL/6Ruwww5d519oEj+vsrHCfFv1ybPwdKRHL9WQnunV7sQEChuQRfvc3iepjCqR22jfdzpEOSBh0aoHD2mLynbbXUCZa0P3Uww4eaUYzkuoMcybcKYd9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459982; c=relaxed/simple;
	bh=RXfGdpMxEW2mvf3XGFHZjd8a9jo+IHTngUjPMRBX77E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2Ya4BgiChq5a+1I0SLQGaZrrBXW99bPbxLLsqvEuDnImDEPYhi39SDoIN6y0IsCIZ/yg7TTi6v/TJ9T0s/emJrrg8D7S/Y7KyrulE/RjFfQ6yg1mM74aurQdDxLOrAIZ/bRGtQ2qB2eDK2PPH4F+9WGDUd4xLinSD9ybnX7ygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/eKRVFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ABBC4CEF2;
	Wed,  2 Jul 2025 12:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751459982;
	bh=RXfGdpMxEW2mvf3XGFHZjd8a9jo+IHTngUjPMRBX77E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S/eKRVFZCRbBbtovWvZH4KxhDC/eufK748/Q9/d2OpPmfuN6s0ESLnb5xlSq0ahFe
	 9PWb2kCrl79vNKt6brA5YaNYfYr2/5GrH6Nj6oWAmfq3IatjkgF/iqyGkVoYbc97MD
	 eFeVHg4clwOecBcip/WC2GggM6PI4O24+u3KLTuAD8vlmGEIBCrlnDSRF1dycGEoaw
	 vy8d1zG4CsgBtmmEYAK93ULhEW/nOT0Eq12kL3gYNrXY+w2kJf9wG52eB5TeHIfKEq
	 /odi82LETxPI+RVMUBMdW7Zyj2YP8fGjGThNPfq76mVJbn/7/vuQgEqNUoXLIvZvjG
	 5RTXP5EWC/UkQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-611a7c617a7so968401eaf.1;
        Wed, 02 Jul 2025 05:39:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUR4OJnyjBIPYNUpkTCnuIEjZmM2xPzi0OSnDXI6UaeP2TD+VZiQZ/4u9H11UCPfjEnx1WFlmHvRK4z@vger.kernel.org, AJvYcCUc/h1pjSYrPaRYnp7iULXabFKZIfH1rh7P3jH+AEvd6ZfVoxVoJttOMgeYKdG5rUzy+K7DVHEotqRG5sCz@vger.kernel.org, AJvYcCVGUh7lt2HwfyVpkFSD824GdYjsoc9dJk1Ug//dTtyzMWHvflFarB70drwt8qnUB46yyf9QZ8MVXLZvHQ==@vger.kernel.org, AJvYcCWGTzqSU8L44RhduYMKH1eeZYNOTGPudhyiOnrIXmLaKqUOGqTFMffWi2SfOgEJ36qMe6G68tuJrxwt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1/t1LTzPEjwUt/FhD11vWg6mjDvFcflwdVjUciTG0j6uvx8J
	z5dOPtvBPuRCqaaaW5CDtphPUHP2/Sz8gNH5xCcnqNfbPGyornjCxHI1dTFXaQ/Qwszj3qJMnsN
	5PVBCbeEFzn9/RnFpv+HXTaCjO5JfhS8=
X-Google-Smtp-Source: AGHT+IGW25OfeA+0PsSXYDwv8m1B6RMZiKJW4YrXLQ0ampAUyQxrE9UfHC02pfBOxDa9YiBqQVbM3vLvBrJdVfo07lk=
X-Received: by 2002:a05:6808:1383:b0:406:5a47:a081 with SMTP id
 5614622812f47-40b8875166amr2066248b6e.13.1751459981281; Wed, 02 Jul 2025
 05:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com> <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
 <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
In-Reply-To: <aGUaFX9WgTW1I_ZO@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 14:39:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
X-Gm-Features: Ac12FXypBdgduXgh2Soy9Mv3gI1-zeaGzzf1uZj9CeuqmyjyihvOhvxvz4Yj7ag
Message-ID: <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
Subject: Re: [PATCH v7 15/24] ACPI: property: Add support for cells property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Anup Patel <apatel@ventanamicro.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Rahul Pathak <rpathak@ventanamicro.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 1:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 2, 2025 at 7:16=E2=80=AFAM Anup Patel <apatel@ventanamicro.=
com> wrote:
>
> ...
>
> > >  static int acpi_fwnode_get_reference_args(const struct fwnode_handle=
 *fwnode,
> > >                                           const char *propname, const=
 char *nargs_prop,
> > >                                           unsigned int args_count, un=
signed int index,
>
> > >         const struct acpi_device_data *data;
> > >         struct fwnode_handle *ref_fwnode;
> > >         struct acpi_device *device;
> > > +       unsigned int nargs_count;
> > >         int ret, idx =3D 0;
>
> > > +                       nargs_count =3D acpi_fwnode_get_args_count(de=
vice, nargs_prop);
> >
> > I think it should work the same way as it used to for the callers that
> > pass args_count, so maybe
> >
> > if (!args_count)
> >         args_count =3D acpi_fwnode_get_args_count(device, nargs_prop);
>
> But this is different variable.

Of course it is different.  It is an acpi_fwnode_get_reference_args() param=
eter.

> > >                         element++;
> > > -
> > >                         ret =3D acpi_get_ref_args(idx =3D=3D index ? =
args : NULL,
> > >                                                 acpi_fwnode_handle(de=
vice),
> > > -                                               &element, end, args_c=
ount);
> > > +                                               &element, end,
> > > +                                               nargs_count ? nargs_c=
ount : args_count);
> >
> > And this change would not be necessary?
>
> This is not the same check as proposed above.

No, it is not.

It just makes the function work the same way it did before the change
for the callers who passed nozero args_count and so they might be
forgiven expecting that it would be taken into account.

