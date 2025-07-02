Return-Path: <linux-acpi+bounces-14938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F2AF585F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 15:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AFF3A40CE
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1234283128;
	Wed,  2 Jul 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8gk/D1N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1DA2741C0;
	Wed,  2 Jul 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462173; cv=none; b=klB6XNP+3XOb/BpmbEhHhrMeB6B4/c6DFMg+vgKkMc9xqXVB3HHWVWb63hKkgYCpHVTVR7bkHJdq8gz6ODXdY0KUHeP3ACPEtolZFnEXapmR9LlrhLKGdcn4+mAzCMxAGogzpyKU4oHXPnze+8VrZh/uFn/Md0cUAgTQHsIP7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462173; c=relaxed/simple;
	bh=GdEMIMP/ZD2NlQMB7UwdH4vkioz/Fr9+gYnj68JSXJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRmmO+3DRYIw+95Be5ritqnFBF/UAiZW+D3N3rXuBlG+slYnFNzCveO5/02dFsYe50pziF5x0wzeRKITQnhDFHeHNrK0sovdjfW3BBAkEbhPJLsQs+ynPA57p2eJ1KHcdWfG3HWIa/J3TwBkg/GiRoIFJu84f6J2bdDBeNbn2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8gk/D1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33346C4CEF1;
	Wed,  2 Jul 2025 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462173;
	bh=GdEMIMP/ZD2NlQMB7UwdH4vkioz/Fr9+gYnj68JSXJE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K8gk/D1N97NJRGD8yl+gE3NWFQ+5KuP9HYW2FqRyQ/4JTJEPBM8X/N982uJJ6EzMR
	 VsYVfyeUXgaaFLZYStMMQjnubPBkNAnDKUWGWHn9cVf2eQkAeknknYNqnZUPYNNYRs
	 WIkGwK8fpIZ7R1NHzL//sWRtHihvtdClFEPPnuAPf1PqwWK6XtQu0SVtpUo8vmDLWG
	 kS62HZt1jSyObot7BUj2ILorYHb7/RMCH9MqByKhQSIF2WGVnxDTl94yP52JgglKFz
	 jfA1dqr6x0/RSi7JDqTzDdcqvlJ+u7ExRK1D37Ec/MFkGavGNzb/QLw/eIQtNa7dYY
	 xECWnyEfd/wNQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6118b000506so1630266eaf.0;
        Wed, 02 Jul 2025 06:16:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWDs5D46GfyjnLOrN+I1ctIxWwASMv+z7qa0e7z0ifbcg6i2wwYD+GCIsVNir8xLF6EG+BURhIXuU3jlQ==@vger.kernel.org, AJvYcCWi4ydMWnI46TPvr97ZoqxKYLjuJaEaE63Y+bFAaWjEyZgmuw9LXBt1O82PsyzWmm1RnlUPqYtfNNNms8Cf@vger.kernel.org, AJvYcCX5Bxg6kJBYUt68W2XVrtPLx+duycWI6UZdxGL7hrHHyAswQ7DNamIjOLPHBbUE5RraLbAthpCDWLFt@vger.kernel.org, AJvYcCXcr3V3LRXlxUItxvDUbjb/+c0yT0ayxsiygVuT3T89TUPCUEnHnRWX5+ePjFEKMHuXwxXvAsu66FWA@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwDYJ7lNQZax+QSsBLF72GKKtjwZz1GVdQFA6rzpgHF5FFvrB
	+OJnDgm1S/4QIA+hZQEYB/058A3+W03SGTQoK2W1xCOM63Z7TvXo46LUravygMocU3NfU4obP+P
	e2KH5YRNZY7jfgHagP6QwLGq3gUWU770=
X-Google-Smtp-Source: AGHT+IExuMqttOKIUYDi+vcXqSuKCbKvlhqQnT1REYwcx9EA5ftg4W7ZWLLFZPOL0rfqf8a4k8cL0HPmiaY5KvT1aRo=
X-Received: by 2002:a05:6820:1e0d:b0:611:af6f:ee77 with SMTP id
 006d021491bc7-612010dfe12mr1692210eaf.8.1751462172310; Wed, 02 Jul 2025
 06:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-16-apatel@ventanamicro.com> <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
 <aGUaFX9WgTW1I_ZO@smile.fi.intel.com> <CAJZ5v0h=qzS67Xu6NUfN_LmQUmKF9=AtkaRrTx81td0m-mRNNg@mail.gmail.com>
 <aGUsg121lenWHL-w@smile.fi.intel.com>
In-Reply-To: <aGUsg121lenWHL-w@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 15:16:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ja5eUiAn7Ht5+-7-b40JtzsCqmztN9WdtLY=kJ7vbtQw@mail.gmail.com>
X-Gm-Features: Ac12FXwc4zqpJNNErqBqjCI2hKLQ3Xi8ekft38n4p6qLhM2Gh3XrHd9uynY6pvk
Message-ID: <CAJZ5v0ja5eUiAn7Ht5+-7-b40JtzsCqmztN9WdtLY=kJ7vbtQw@mail.gmail.com>
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

On Wed, Jul 2, 2025 at 2:56=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 02, 2025 at 02:39:30PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 2, 2025 at 1:38=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Jul 02, 2025 at 12:20:55PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Jul 2, 2025 at 7:16=E2=80=AFAM Anup Patel <apatel@ventanami=
cro.com> wrote:
>
> ...
>
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
> I see your point now. But do we have such a user? I dunno.

Well, __acpi_node_get_property_reference() gets called in a couple of place=
s.

