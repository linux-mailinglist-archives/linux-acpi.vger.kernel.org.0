Return-Path: <linux-acpi+bounces-14918-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1CAF11A1
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A77A1C260D6
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14F2561AE;
	Wed,  2 Jul 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gymx7RVv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A11245003;
	Wed,  2 Jul 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451668; cv=none; b=gNULrySnYc6eAiO5XariN8OJkWd47YyF0U7YI4abQv7NDp1igyUBtUeauos2BSBAvl2S5hxvBrVfSX9FQHQxZk62G5jcUIuERXPduYfKgNM873iapCHl6bA6YQEnNtS7SUfjMallIosVLMF+LI38esFc1sw/axzRd9KM7Y7Lo48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451668; c=relaxed/simple;
	bh=yR4QX8AXCTa9zd/85SYFl0Yy3vsYSL9PyHxARwsxIfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7DsfN0EDmBheqHBrA1CPh1yuQEIn111PNGEfOIl7WpPOUwOSm0BqEoOM4CfTsTaeNCm+7x0PyPcCNp5Dgh/jSkeMXNmJ3xP1qnXrIXxozod/7b/P09a2AmPK+raeFoUOAE0XoWxO/Y38GuiTlcfE2xFJ5nQszk2uZr8jfMI75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gymx7RVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE3EC4CEFB;
	Wed,  2 Jul 2025 10:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751451667;
	bh=yR4QX8AXCTa9zd/85SYFl0Yy3vsYSL9PyHxARwsxIfA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gymx7RVvDN4idY4KXMg5H3w1GiKCaihmgnle1aF81JViV02n8GLqRg2sSKraLP27p
	 3TLJLz77nLpAb14TgF7sJ6hBEJp9kh8FyJF4sHJI83ByJuw62cX+AnFfpvgL1qMYLh
	 BDG8eVupTnFW/dCx7sL17+CJcLSIz91pCA/Z20IumIE7EXuswNHQyNDVr6cRcJuE1t
	 WQEfZGvqqPhsk/fJUnQp+7AtghIwkZpizM7RODr5uUGbMVSfysuxcx6/+Io9qygfmn
	 g8Aggvlt92ZW9UMEAwtUXJxjQFikPyw9FcpFwdQou8db7nfP00sUrOr0REbAjoLCCK
	 WFdc/JSm1DaZQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-612033bb26cso190766eaf.3;
        Wed, 02 Jul 2025 03:21:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2OOoMnWTQKs5rQndrZwA66v8KLvSzflgHbzqKDCiupcQBsJYH3GV1yKSJ3ZgRGaimCGCD2scCtIGaUSPc@vger.kernel.org, AJvYcCVthKOvDKH1PgH190aZTlErQxOSzBqF0F/6AxN/rfmNMBfBp+gV/ciNY4GJztNyPADKFKXZN5D8E4SduA==@vger.kernel.org, AJvYcCW/ZERNHz6bqbU8KhyN6D4JX+g5TLTX3WI/A+mdrGxnOV7YXhMVapbv+4quhEKazdAdhJEeQi8EWgPT@vger.kernel.org, AJvYcCXCB6bxdQMdyZcWPrfVsDXZVHRzNDSGY0oTWtpkGN2uddo0AMZFigW1eQcBgAfW/tuZKIZcEPpEsmUP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JviliAFMtzAAvxGO011+O8SdGrfaPnpI+cXiAOKL6uEBY6nB
	ihe14/L03DgVsZ0ZAtkaQ0TFVockicMwlrZPdMDVDKeSpbSkmSpfTJucCyFNNrrFC2tSDNEOgfM
	sbXz3QYnGEesBNN+cC0RZBWhFpB8wbuw=
X-Google-Smtp-Source: AGHT+IEIAYeGapqbvzgRtPBZhUUR/7BOdbNNDra2py939LpzhZKiwziH27/5pwK7uUznA1K8dVixQvtQR4qL3igFyhY=
X-Received: by 2002:a05:6820:2713:b0:611:bbad:7b62 with SMTP id
 006d021491bc7-6120112a218mr1475999eaf.3.1751451666947; Wed, 02 Jul 2025
 03:21:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com> <20250702051345.1460497-16-apatel@ventanamicro.com>
In-Reply-To: <20250702051345.1460497-16-apatel@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 12:20:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
X-Gm-Features: Ac12FXzQ49ZuTSEHsHpxG_hICq-H4KxJ6ZjrT4VtlTSQu1Nb2pu-7KR4sK-HNfM
Message-ID: <CAJZ5v0iYYuK2GF2Pg3NiO4vLFzoYm6Q3Dnk5O2DkMJm1R3qSfQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/24] ACPI: property: Add support for cells property
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

On Wed, Jul 2, 2025 at 7:16=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> From: Sunil V L <sunilvl@ventanamicro.com>
>
> Currently, ACPI doesn't support cells property when
> fwnode_property_get_reference_args() is called.

What exactly do you mean by "cells property" here and below?

> ACPI always expects
> the number of arguments to be passed. However, the above mentioned
> call being a common interface for OF and ACPI, it is better to have
> single calling convention which works for both. Hence, add support
> for cells property on the reference device to get the number of
> arguments dynamically.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  drivers/acpi/property.c | 22 ++++++++++++++++++----
>  drivers/base/property.c |  2 +-
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index d4863746fb11..d08b0ea5c915 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -882,6 +882,17 @@ static struct fwnode_handle *acpi_parse_string_ref(c=
onst struct fwnode_handle *f
>         return &dn->fwnode;
>  }
>
> +static unsigned int acpi_fwnode_get_args_count(const struct acpi_device =
*device,
> +                                              const char *nargs_prop)
> +{
> +       const union acpi_object *obj;
> +
> +       if (acpi_dev_get_property(device, nargs_prop, ACPI_TYPE_INTEGER, =
&obj))
> +               return 0;
> +
> +       return obj->integer.value;
> +}
> +
>  static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fw=
node,
>                                           const char *propname, const cha=
r *nargs_prop,
>                                           unsigned int args_count, unsign=
ed int index,
> @@ -892,6 +903,7 @@ static int acpi_fwnode_get_reference_args(const struc=
t fwnode_handle *fwnode,
>         const struct acpi_device_data *data;
>         struct fwnode_handle *ref_fwnode;
>         struct acpi_device *device;
> +       unsigned int nargs_count;
>         int ret, idx =3D 0;
>
>         data =3D acpi_device_data_of_node(fwnode);
> @@ -960,11 +972,12 @@ static int acpi_fwnode_get_reference_args(const str=
uct fwnode_handle *fwnode,
>                         if (!device)
>                                 return -EINVAL;
>
> +                       nargs_count =3D acpi_fwnode_get_args_count(device=
, nargs_prop);

I think it should work the same way as it used to for the callers that
pass args_count, so maybe

if (!args_count)
        args_count =3D acpi_fwnode_get_args_count(device, nargs_prop);

>                         element++;
> -
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
>                                                 acpi_fwnode_handle(device=
),
> -                                               &element, end, args_count=
);
> +                                               &element, end,
> +                                               nargs_count ? nargs_count=
 : args_count);

And this change would not be necessary?

And analogously below.

>                         if (ret < 0)
>                                 return ret;
>
> @@ -978,11 +991,12 @@ static int acpi_fwnode_get_reference_args(const str=
uct fwnode_handle *fwnode,
>                         if (!ref_fwnode)
>                                 return -EINVAL;
>
> +                       device =3D to_acpi_device_node(ref_fwnode);
> +                       nargs_count =3D acpi_fwnode_get_args_count(device=
, nargs_prop);
>                         element++;
> -
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
>                                                 ref_fwnode, &element, end=
,
> -                                               args_count);
> +                                               nargs_count ? nargs_count=
 : args_count);
>                         if (ret < 0)
>                                 return ret;
>
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

