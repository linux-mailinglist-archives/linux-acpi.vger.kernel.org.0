Return-Path: <linux-acpi+bounces-14917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F9AF1142
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B93A7B44
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED4F253938;
	Wed,  2 Jul 2025 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXyEV+l4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6872417E6;
	Wed,  2 Jul 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450870; cv=none; b=t0lwJ+17XhauGxmkpoLu3ewHvWyqifEaG/v6tjOzzrPHD4G6BGPN2YE9C6uNPmDdf+RjeHLo3f4GMtn4M4P3ekzxL/6kQPwz8AvN4t2yKndemWW1OnrcFZIczd9gvS4/DoLPUTED4Z+esxtZNnvoh5CMh752Owsf7599hEzwHaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450870; c=relaxed/simple;
	bh=weyTifFbm+9UaGAzEaZQa9PZjTRZ7slzMKMFXBEpui8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tk3Ce4POlwJim9TjTz3vjvm7ikNYeSRttxzcRzJ31pylPMy+NdbDNxjgRls5f0TbtmsdS8pEbf6wPcN0Hj+4ZQ/rpceOQJiNma/dMmnxaK3K6P9zTZOSLIm1SncuDpM1FjwMYb+/CjZAJqo0TCiliiqjul26QGskdLddC7bLq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXyEV+l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B786C4CEFE;
	Wed,  2 Jul 2025 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751450869;
	bh=weyTifFbm+9UaGAzEaZQa9PZjTRZ7slzMKMFXBEpui8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NXyEV+l4prWmA5xNasJNgIgmUSgM3+Yt1Z/QGc3tu04lP7Vd/35XgG1bIgRYF6QbC
	 hS+BNUi5W3ZeJZwhElILpy2EoCd0J8/7vcaATsh2V+yR4W/jv8iDQSMzoyf7V+Ggz0
	 33j4MJ4bvLXmVPIUU3N/6UvmUqGHDwzNYx9ajuOeB4zwMoOnB6HaZwzZJolDGmNnj6
	 Eyl38o0v5Cx7zG8V7a5LhakoabbxDhmevK4Q8cpgCr3LtW2gnsrQHfbql1ZrgOkFcD
	 bxLHy8FIjT0wGCwFi9W6leaK6OdKg+oyBWDMj7TWBNil94GI6wHRS19liEy2PqhvmE
	 Aq+JQaKrxTr7w==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40b32b6af9eso3109534b6e.1;
        Wed, 02 Jul 2025 03:07:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjzwE5Cf7LsrPTYK5cGF6DAEPYyY41Z2VpwFZDYd+YHohYHkigpvS0nrdB3zESPGfNOirM2wMbtLAT@vger.kernel.org, AJvYcCUzcniCTLJ9r6c9m18GLLPdC96sUme0ckh0GrFajwuwBmD8/bAWHXXwXuV62CSZ+NuCSqm6IkvaWBt1@vger.kernel.org, AJvYcCXXvYuN8BTZr7TQyMLQ7HxngfbJjpGqbSeopWrKbPBdbMf9g7aPO7RX5hxJk2zAXZ9Oly/18m5iYITfGA==@vger.kernel.org, AJvYcCXjXazA9qbbTexJguqJaev0oLADE02uAX3W/um8XQrcJ/rYrke47IqOH1wm65yMyo/6dnaiPl2OSglKlAui@vger.kernel.org
X-Gm-Message-State: AOJu0YwXTSzW/u5yBFNy3krn7jfgBD5ZAcJ5upsrogr/j3ahrYDsOpV2
	7bQVZ3yh0yds4Wo/hPXc7qur3HmGXkPL42gwMbD1aVffpiTSYblVmKUT/DOGbHdfkeiGgNdycrA
	PmVNiI8ikdeeXMUz7CYQY0CdH10iC/Nk=
X-Google-Smtp-Source: AGHT+IGtIVuzmhoykn4M0axoi0CGQ6+4aSkLoPsqP+2+vacu7bYqMOdAim8lVESGAzHhcXoXAFFINc4I7/DELd8kc+U=
X-Received: by 2002:a05:6808:1b07:b0:404:e0b3:12f with SMTP id
 5614622812f47-40b8876eecbmr1608611b6e.11.1751450868525; Wed, 02 Jul 2025
 03:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702051345.1460497-1-apatel@ventanamicro.com> <20250702051345.1460497-15-apatel@ventanamicro.com>
In-Reply-To: <20250702051345.1460497-15-apatel@ventanamicro.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 12:07:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifCN7OWEw0DHpULSmXn4nCb9EdJMjQPJwmdoF_y0nfjA@mail.gmail.com>
X-Gm-Features: Ac12FXwydwjWOWusGuVaIxI2hPrV2omvDChuKbmceQ_-F0JLp5oiXfu_5tSYAEY
Message-ID: <CAJZ5v0ifCN7OWEw0DHpULSmXn4nCb9EdJMjQPJwmdoF_y0nfjA@mail.gmail.com>
Subject: Re: [PATCH v7 14/24] ACPI: property: Refactor acpi_fwnode_get_reference_args()
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

On Wed, Jul 2, 2025 at 7:15=E2=80=AFAM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> From: Sunil V L <sunilvl@ventanamicro.com>
>
> Currently acpi_fwnode_get_reference_args() calls the public function
> __acpi_node_get_property_reference() which ignores the nargs_prop
> parameter.

Which I suppose is a problem.  Why is it so?

> To fix this, make __acpi_node_get_property_reference() to
> call the static acpi_fwnode_get_reference() so that callers of
> fwnode_get_reference_args() can still pass a valid property name to
> fetch the number of arguments.

Are the current callers of acpi_fwnode_get_reference_args() going to
be affected by this change and if so, then how?

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
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
>

