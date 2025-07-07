Return-Path: <linux-acpi+bounces-15048-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08BAFB918
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 18:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7274A6269
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 16:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D8A226D16;
	Mon,  7 Jul 2025 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmFaFG9a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C3224B0E;
	Mon,  7 Jul 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907039; cv=none; b=mTztLtihQOJeZsq2SIpu+ltuofHdfCS6HYo8t+waknV2/U8k1nENX1e3zSvr4HZUqi7vsEIWiGFfooSApX92aMuBM1qWyXeWvDpAvB/o7bwkbv0DDpxbX0bDRAT31sOoZxU6QTUlkx0/A9K9/g8pC4z7cZO0lNo+qRBeNx4Pbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907039; c=relaxed/simple;
	bh=9a1wcjgGyuGBH9dz8iciM2zoxRYiXr1OThzA70moRAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyhkisEdnwrKVHMcGgQ4l7bcghz3ZbZ8HD5naIdoyOSFLZJlhvq1YKLcnbdrXt/z0ieg36DiEjSUMLLK15KPncwz3dKUtZTStz91Ap9uN1ySc3Vt5cK1lAUrK0JzvqtJHNLSqbD31KqHA04XOq1mJmsAMOSwis5kYoVwRQofOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmFaFG9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95487C4CEF1;
	Mon,  7 Jul 2025 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751907038;
	bh=9a1wcjgGyuGBH9dz8iciM2zoxRYiXr1OThzA70moRAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QmFaFG9amTsKCMhZTdRsdRLBhzbA9RgaZYGw7TGX/1hNfeXtiwzqS577/OOcXfVOe
	 VJ5VDUIUOkUQZbjDJ1waqGZyhKQO7/oelpE8cgIMrOTdHs7WjpGKuTpTKNGek7XAvZ
	 wGdmbnZOA7lKx52GlkSCtztm4URBUMKpHvFuY1wt+ge9xmnS1+9Ay5d7vB1bpiTjUN
	 1ZE33gDJOzihdZqw6Q040WHZgWYvyDg7pcE6IfxlTwgOMseNl0z+NMPWZq7tkY4xBY
	 +QbM0DsXHkDFVXSYu09qZo5Zs4ofrP1/0B1w5uomHVQ8A7hyzi+xMMNUZiUPk4bpSp
	 a6ydhRgQPR7tA==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61208b86da2so784750eaf.2;
        Mon, 07 Jul 2025 09:50:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6QB6LuEfEm+W36AK9wYtrRhrfePr5S+PI4YmzTMD6RdIOHW6pVO+EHiC7WhJ0sDjdNPpN2KqpVMS5PjjT@vger.kernel.org, AJvYcCVfTklTGF3hl78JEc7uQKcGsLIrczUnCzEd24Bo6gqKbfCqYs56nZgjWRO1JOZUapOymv91V4tbRijP@vger.kernel.org, AJvYcCWGgtVPTPh5uWE0FzN9ODyA/KU26Tx5AsUfUNdv0Tr0xsuagVbW5krqy9NIPamc1OMvYv9KkZhe1DTxIQ==@vger.kernel.org, AJvYcCXjHVU5Yq0NsDgRNNuMdvdtIsc2rn72XHyia31eLSnyMHVOcR/N0BzELY0XVCsD+PKakVXl32W+kIg8@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFXDmBQflpSLyFFG4aGm7Ek0QTNf+bIp8sa6eV2Ij0jXzFYmf
	ApWaNSURKP+6iQSzAjjLMaVMYzLz0cOV7EKeOIvE6nG8XhPfZT4QZcbifB2N09IRQ+CMt18XP13
	SxQt9+5pOVQcFvK4RHOmJWU24kmEi4wI=
X-Google-Smtp-Source: AGHT+IHNACN6r3MQBzl2AxnxkY7b3vwCCOzvxM4DbSJ5BWQkgWMplMg/AADsP0wxtsyFOxnDcsFDRO8teU3gGL28ZLg=
X-Received: by 2002:a05:6820:2901:b0:611:ab60:3003 with SMTP id
 006d021491bc7-613c02a087bmr171510eaf.8.1751907037895; Mon, 07 Jul 2025
 09:50:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <20250704070356.1683992-16-apatel@ventanamicro.com>
In-Reply-To: <20250704070356.1683992-16-apatel@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:50:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0n3twH8qPR04bX5uRzXXSmKhB72WfFEAuG+nbMOJcFw@mail.gmail.com>
X-Gm-Features: Ac12FXzt6T3E94Z3HOk5kB7YG-fbGgkcx6q0up1mrENTBphzopL9rtBmotWtHfA
Message-ID: <CAJZ5v0i0n3twH8qPR04bX5uRzXXSmKhB72WfFEAuG+nbMOJcFw@mail.gmail.com>
Subject: Re: [PATCH v8 15/24] ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
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

On Fri, Jul 4, 2025 at 9:07=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> From: Sunil V L <sunilvl@ventanamicro.com>
>
> Currently, ACPI does not support the use of a nargs_prop (e.g.,
> associated with a reference in fwnode_property_get_reference_args().
> Instead, ACPI expects the number of arguments (nargs) to be explicitly
> passed or known.
>
> This behavior diverges from Open Firmware (OF), which allows the use of
> a #*-cells property in the referenced node to determine the number of
> arguments. Since fwnode_property_get_reference_args() is a common
> interface used across both OF and ACPI firmware paradigms, it is
> desirable to have a unified calling convention that works seamlessly for
> both.
>
> Add the support for ACPI to parse a nargs_prop from the referenced
> fwnode, aligning its behavior with the OF backend. This allows drivers
> and subsystems using fwnode_property_get_reference_args() to work in a
> firmware-agnostic way without having to hardcode or special-case
> argument counts for ACPI.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

LGTM now, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/property.c | 29 +++++++++++++++++++++++++----
>  drivers/base/property.c |  2 +-
>  2 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index d4863746fb11..e92402deee77 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -804,13 +804,35 @@ acpi_fwnode_get_named_child_node(const struct fwnod=
e_handle *fwnode,
>         return NULL;
>  }
>
> +static unsigned int acpi_fwnode_get_args_count(struct fwnode_handle *fwn=
ode,
> +                                              const char *nargs_prop)
> +{
> +       const struct acpi_device_data *data;
> +       const union acpi_object *obj;
> +       int ret;
> +
> +       data =3D acpi_device_data_of_node(fwnode);
> +       if (!data)
> +               return 0;
> +
> +       ret =3D acpi_data_get_property(data, nargs_prop, ACPI_TYPE_INTEGE=
R, &obj);
> +       if (ret)
> +               return 0;
> +
> +       return obj->integer.value;
> +}
> +
>  static int acpi_get_ref_args(struct fwnode_reference_args *args,
>                              struct fwnode_handle *ref_fwnode,
> +                            const char *nargs_prop,
>                              const union acpi_object **element,
>                              const union acpi_object *end, size_t num_arg=
s)
>  {
>         u32 nargs =3D 0, i;
>
> +       if (nargs_prop)
> +               num_args =3D acpi_fwnode_get_args_count(ref_fwnode, nargs=
_prop);
> +
>         /*
>          * Assume the following integer elements are all args. Stop count=
ing on
>          * the first reference (possibly represented as a string) or end =
of the
> @@ -961,10 +983,10 @@ static int acpi_fwnode_get_reference_args(const str=
uct fwnode_handle *fwnode,
>                                 return -EINVAL;
>
>                         element++;
> -
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
>                                                 acpi_fwnode_handle(device=
),
> -                                               &element, end, args_count=
);
> +                                               nargs_prop, &element, end=
,
> +                                               args_count);
>                         if (ret < 0)
>                                 return ret;
>
> @@ -979,9 +1001,8 @@ static int acpi_fwnode_get_reference_args(const stru=
ct fwnode_handle *fwnode,
>                                 return -EINVAL;
>
>                         element++;
> -
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
> -                                               ref_fwnode, &element, end=
,
> +                                               ref_fwnode, nargs_prop, &=
element, end,
>                                                 args_count);
>                         if (ret < 0)
>                                 return ret;
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f626d5bbe806..6a63860579dd 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -578,7 +578,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_match_property_stri=
ng);
>   * @prop:      The name of the property
>   * @nargs_prop:        The name of the property telling the number of
>   *             arguments in the referred node. NULL if @nargs is known,
> - *             otherwise @nargs is ignored. Only relevant on OF.
> + *             otherwise @nargs is ignored.
>   * @nargs:     Number of arguments. Ignored if @nargs_prop is non-NULL.
>   * @index:     Index of the reference, from zero onwards.
>   * @args:      Result structure with reference and integer arguments.
> --
> 2.43.0
>

