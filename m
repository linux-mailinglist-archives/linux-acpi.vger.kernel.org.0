Return-Path: <linux-acpi+bounces-15047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 524C5AFB8E9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 18:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFB27AE80A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCA321B9FD;
	Mon,  7 Jul 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJL3ZCEM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F054F2E370C;
	Mon,  7 Jul 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906902; cv=none; b=Bmx2geicEvCOlSFDrCfAZfyTOqfmA3803O/y2Nt1I+lKqqdx1UoItwEM0xJHgmfBEI0/4exC+Z9VrS034JUJAGcvqC6hv2EPKzN5aeNrWpRnfvvNPbwlyVrUsOVblmDxo1Qoy2OvLgFexvYK3CGGj7Mu1keCiCcPfgMAQqZo0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906902; c=relaxed/simple;
	bh=lr5Ok0BtzLVe2DMzdRYn2HLQ6o5Js7Aoy/d36/h8hMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7d6sXUopfGXgBv1TNtgy7oMgljuZliSRXMzZ1Ke+aVQFeXQDkCByo6OObiRCp+ygJ7T+nY+4+94Tqx8gheEseSmXyN3Z660RcFV9F4n9QSjr8/Vq88DwM5I9Xvx26zuZZAsIsF9iM4fZogIagKSJTfp/ZqTS7JhLwgD86RioXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJL3ZCEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84335C4CEFA;
	Mon,  7 Jul 2025 16:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751906901;
	bh=lr5Ok0BtzLVe2DMzdRYn2HLQ6o5Js7Aoy/d36/h8hMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WJL3ZCEMDK6r6o718A0CMFAGlKrU4TlzSuYmw4B9Xkc2CR2QBc7fhnm+yhjjLwiIv
	 hXiV0I2RF+VLDSFkFPeTuD6W0PBDLD28JDFNyX+e4CG3kBAVX04Az3yaG04MlgtHfU
	 WcJ1wdfMVL7kKQA2EqMyrlmZDRAWw+E8LWhGEEo2+Q7QII0nzfGaR8LrhblPqGbg2+
	 z4T1rylWUgHUucLPWRl6OTJY/KdGGDwa660tgEuA/KN+HaIfF///a24qPsXt8OgygK
	 Yqeto7maIdjmk0+BdAE5vvOKApxXEc0Fa0UAqMLKnECoNLJ/d44lBadfzWBqyiJ5Wq
	 P85tvLYhmyBUg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6119cd1a154so1633329eaf.0;
        Mon, 07 Jul 2025 09:48:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV27fdVXT7zkfP5TysGKXUfII3s7k2mJbkJZlSEh/YgWgnIh1oU3BrR+NrZYV90JcKKwJv77rild5f1@vger.kernel.org, AJvYcCVSA02YNVhCd8VEJ3wGvPEs870MmEkb6wfMcNFZtt8UyTeUWr2Yx2UR74xcXKB62D7s/ip0bTP0dS78@vger.kernel.org, AJvYcCX9HIktmvG5BWD97P5gzGQ6UucFapgCXmOdXcn8lZGW0cSw7WIaNgxqMOAT/Rz0RCdSj6BxkA0c1uaomA==@vger.kernel.org, AJvYcCXQJaaRPhg6guwIDWkCcPKuGx3k5rBjOgL7B/oOzC8TVdRySJiLQ5+fGzJv9IDNB3Tt3KmCKZn6zA5xPLvK@vger.kernel.org
X-Gm-Message-State: AOJu0YzkIFP1Ad6v+vruQZF6M2+AoVhLjp83lG+MdujI7Q7b8H3AL9R+
	Vd7SXfrDqcAlZ5wDlPIY5emQqMAaQch1i2y4tUVETNGq2xRMnLH7m1uZn2qx9PU4fy+ZrjdbQy7
	r5GHvm9VMt0DMv871V6u6os/0/GQz/eo=
X-Google-Smtp-Source: AGHT+IEL+yp0PljSvznfGMai9yp43Jg5JZrJU1ZvqcX+Hp8ViTDobsjmMWoaW+8AGloguCZxPuIaWdlqHhYISu0rqFo=
X-Received: by 2002:a05:6820:1999:b0:611:31a:6ff5 with SMTP id
 006d021491bc7-61392c26c5fmr8986475eaf.7.1751906900608; Mon, 07 Jul 2025
 09:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704070356.1683992-1-apatel@ventanamicro.com> <20250704070356.1683992-15-apatel@ventanamicro.com>
In-Reply-To: <20250704070356.1683992-15-apatel@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:48:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iX2KRXb5CdY9FbnMSR5RUEG7eBn2QQQKj2wa4doWh_nw@mail.gmail.com>
X-Gm-Features: Ac12FXwHpPP-bFT_eng9Gfv5MuT8xuYuEAg81du49PdE3XAR8ZaXZPBtBzvvsG0
Message-ID: <CAJZ5v0iX2KRXb5CdY9FbnMSR5RUEG7eBn2QQQKj2wa4doWh_nw@mail.gmail.com>
Subject: Re: [PATCH v8 14/24] ACPI: property: Refactor acpi_fwnode_get_reference_args()
 to support nargs_prop
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
> Currently, acpi_fwnode_get_reference_args() delegates to the internal
> function __acpi_node_get_property_reference() to retrieve property
> references. However, this function does not handle the nargs_prop (cells
> property) parameter, and instead expects the number of arguments (nargs)
> to be known or hardcoded.
>
> As a result, when fwnode_property_get_reference_args() is used with a
> valid nargs_prop, the ACPI backend ignores it, whereas the Device Tree
> (DT) backend uses the #*-cells property from the reference node to
> determine the number of arguments dynamically.
>
> To support the nargs_prop in ACPI, refactor the code as follows:
>
> - Move the implementation from __acpi_node_get_property_reference()
>   into acpi_fwnode_get_reference_args().
>
> - Update __acpi_node_get_property_reference() to call the (now updated)
>   acpi_fwnode_get_reference_args() passing NULL as nargs_prop to keep
>   the behavior of __acpi_node_get_property_reference() intact.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

LGTM now, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/property.c | 101 ++++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 436019d96027..d4863746fb11 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -882,45 +882,10 @@ static struct fwnode_handle *acpi_parse_string_ref(=
const struct fwnode_handle *f
>         return &dn->fwnode;
>  }
>
> -/**
> - * __acpi_node_get_property_reference - returns handle to the referenced=
 object
> - * @fwnode: Firmware node to get the property from
> - * @propname: Name of the property
> - * @index: Index of the reference to return
> - * @num_args: Maximum number of arguments after each reference
> - * @args: Location to store the returned reference with optional argumen=
ts
> - *       (may be NULL)
> - *
> - * Find property with @name, verifify that it is a package containing at=
 least
> - * one object reference and if so, store the ACPI device object pointer =
to the
> - * target object in @args->adev.  If the reference includes arguments, s=
tore
> - * them in the @args->args[] array.
> - *
> - * If there's more than one reference in the property value package, @in=
dex is
> - * used to select the one to return.
> - *
> - * It is possible to leave holes in the property value set like in the
> - * example below:
> - *
> - * Package () {
> - *     "cs-gpios",
> - *     Package () {
> - *        ^GPIO, 19, 0, 0,
> - *        ^GPIO, 20, 0, 0,
> - *        0,
> - *        ^GPIO, 21, 0, 0,
> - *     }
> - * }
> - *
> - * Calling this function with index %2 or index %3 return %-ENOENT. If t=
he
> - * property does not contain any more values %-ENOENT is returned. The N=
ULL
> - * entry must be single integer and preferably contain value %0.
> - *
> - * Return: %0 on success, negative error code on failure.
> - */
> -int __acpi_node_get_property_reference(const struct fwnode_handle *fwnod=
e,
> -       const char *propname, size_t index, size_t num_args,
> -       struct fwnode_reference_args *args)
> +static int acpi_fwnode_get_reference_args(const struct fwnode_handle *fw=
node,
> +                                         const char *propname, const cha=
r *nargs_prop,
> +                                         unsigned int args_count, unsign=
ed int index,
> +                                         struct fwnode_reference_args *a=
rgs)
>  {
>         const union acpi_object *element, *end;
>         const union acpi_object *obj;
> @@ -999,7 +964,7 @@ int __acpi_node_get_property_reference(const struct f=
wnode_handle *fwnode,
>
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
>                                                 acpi_fwnode_handle(device=
),
> -                                               &element, end, num_args);
> +                                               &element, end, args_count=
);
>                         if (ret < 0)
>                                 return ret;
>
> @@ -1017,7 +982,7 @@ int __acpi_node_get_property_reference(const struct =
fwnode_handle *fwnode,
>
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
>                                                 ref_fwnode, &element, end=
,
> -                                               num_args);
> +                                               args_count);
>                         if (ret < 0)
>                                 return ret;
>
> @@ -1039,6 +1004,50 @@ int __acpi_node_get_property_reference(const struc=
t fwnode_handle *fwnode,
>
>         return -ENOENT;
>  }
> +
> +/**
> + * __acpi_node_get_property_reference - returns handle to the referenced=
 object
> + * @fwnode: Firmware node to get the property from
> + * @propname: Name of the property
> + * @index: Index of the reference to return
> + * @num_args: Maximum number of arguments after each reference
> + * @args: Location to store the returned reference with optional argumen=
ts
> + *       (may be NULL)
> + *
> + * Find property with @name, verifify that it is a package containing at=
 least
> + * one object reference and if so, store the ACPI device object pointer =
to the
> + * target object in @args->adev.  If the reference includes arguments, s=
tore
> + * them in the @args->args[] array.
> + *
> + * If there's more than one reference in the property value package, @in=
dex is
> + * used to select the one to return.
> + *
> + * It is possible to leave holes in the property value set like in the
> + * example below:
> + *
> + * Package () {
> + *     "cs-gpios",
> + *     Package () {
> + *        ^GPIO, 19, 0, 0,
> + *        ^GPIO, 20, 0, 0,
> + *        0,
> + *        ^GPIO, 21, 0, 0,
> + *     }
> + * }
> + *
> + * Calling this function with index %2 or index %3 return %-ENOENT. If t=
he
> + * property does not contain any more values %-ENOENT is returned. The N=
ULL
> + * entry must be single integer and preferably contain value %0.
> + *
> + * Return: %0 on success, negative error code on failure.
> + */
> +int __acpi_node_get_property_reference(const struct fwnode_handle *fwnod=
e,
> +                                      const char *propname, size_t index=
,
> +                                      size_t num_args,
> +                                      struct fwnode_reference_args *args=
)
> +{
> +       return acpi_fwnode_get_reference_args(fwnode, propname, NULL, ind=
ex, num_args, args);
> +}
>  EXPORT_SYMBOL_GPL(__acpi_node_get_property_reference);
>
>  static int acpi_data_prop_read_single(const struct acpi_device_data *dat=
a,
> @@ -1558,16 +1567,6 @@ acpi_fwnode_property_read_string_array(const struc=
t fwnode_handle *fwnode,
>                                    val, nval);
>  }
>
> -static int
> -acpi_fwnode_get_reference_args(const struct fwnode_handle *fwnode,
> -                              const char *prop, const char *nargs_prop,
> -                              unsigned int args_count, unsigned int inde=
x,
> -                              struct fwnode_reference_args *args)
> -{
> -       return __acpi_node_get_property_reference(fwnode, prop, index,
> -                                                 args_count, args);
> -}
> -
>  static const char *acpi_fwnode_get_name(const struct fwnode_handle *fwno=
de)
>  {
>         const struct acpi_device *adev;
> --
> 2.43.0
>

