Return-Path: <linux-acpi+bounces-15809-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02ACB2ADF5
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9D44E2579
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 16:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2B5335BAE;
	Mon, 18 Aug 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcbrFitr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE0229B2A;
	Mon, 18 Aug 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534066; cv=none; b=EppvBVvAxj2pa8wldeGmVtZ9eewF2Q+ZvV4QLDBSKg/Axd2fccbQnyKVKhxnpp7ifdX8rx7CSTqEqfPIRuMoQAWIAwP1dvqARPfsiJVKYlK/tfT6YOY3r7GZjd7P/eLBvV2MtWROVpRrNnVYugoMCyfYHLICgIlOCxnS5sM5csU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534066; c=relaxed/simple;
	bh=qUKrvyW0beuc+sw2BGlkXExMSVbJbG2RqtuPQDlzROo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyRTbxYbWDhGHgillUqG8uqeeR8H82s2MRv5dk45oMPQevZmva1/ho9Y9EhCOCie0vElK39ILKwX1wrg7Nty75C8NOi0fXjqTH23rpGL92gUfWA/nJCXe6MHsE+0IbnToTZP8B13I52EhMr+hxgT1UvgFd4oyJ4D67nQMvhZ8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcbrFitr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB2CC4AF09;
	Mon, 18 Aug 2025 16:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755534066;
	bh=qUKrvyW0beuc+sw2BGlkXExMSVbJbG2RqtuPQDlzROo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bcbrFitr9YGR3P5hWECUFThj39D+FjqmBUYx075ZcWu+LoPzLCULfB2Zgal8U5wzT
	 NthJbQy8ldxPVI1K6cRfcddreox1mRDkpkgglflgjOOfkL9p8mGdOYEKHub/BYkHJr
	 Pr0gG6hEtz2kBngwjBtG0Z1xSjBSBLj+q7F3KnY5TCdDO9L7QfXax3pkRr7hoNJ+Z3
	 p9NxWR+hh09gLI0p1lOYDKNqJEN0cgzcifnJuTsJwoutwR6z2rFmNH7ik5RURafM4n
	 Vf2J3yelpTjt5Y2Soe56HGbZVu4wXlrOGN+Kn+ZZGkn44SYfRjNCbXSsPlg7G32Qmn
	 5kPUEiq8VQuJg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61bd4e24ac7so1335608eaf.2;
        Mon, 18 Aug 2025 09:21:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUx2+IAdDsgavhyJPdeydCKx4naQZTMdjFyEYY94tRbxSssmVTrvyIfUPL2llLyPWomxh5UeIXe13FmtgCU@vger.kernel.org, AJvYcCWY9zZsXrLVBVZ80qlnD2Bs9gCLlmlti9kTybM/wz/bvpLAguu7z4kNY7pHiUfegAhF5AtxTwR6S9LC@vger.kernel.org
X-Gm-Message-State: AOJu0YyUQptqoTXm6sO2uw73HCZbPfNqcJi8iVJDmMw9ioEaLNrzyDS2
	u/4LxO6mz2ZmPV7a48GkMQoEBY43QFaCA7m72AKIZ/siwqEHW0myUPC+i6egTYsmEkbuHXxSnIz
	44N9NWb7gNQU/JsLP8vY7iAzUaojfivI=
X-Google-Smtp-Source: AGHT+IE8+JuEsDQNcm0X/WVYZdNkKbvLVNjlUE8NpD1s8kswPVsJGRw/6WgSjumINfgbdXgeY+FpMZiezy30Pdm0kPM=
X-Received: by 2002:a05:6820:1c88:b0:61c:a11:ce96 with SMTP id
 006d021491bc7-61c0a11ddc6mr3534246eaf.8.1755534065224; Mon, 18 Aug 2025
 09:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814051157.35867-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250814051157.35867-2-u.kleine-koenig@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Aug 2025 18:20:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSoG8tTvY+im+h0ObUhM5_GDWbUa=6Doc1SRRNnuxfiw@mail.gmail.com>
X-Gm-Features: Ac12FXwjxxmfI0rOk-5SHu5dRy9Ve7UNBCcDlleto6Zdv0AgFx7Sq90-BCd2Qck
Message-ID: <CAJZ5v0hSoG8tTvY+im+h0ObUhM5_GDWbUa=6Doc1SRRNnuxfiw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix resource leak by remove callback in .exit.text
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, 
	Zaid Alali <zaidal@os.amperecomputing.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sudeep.holla@arm.covm, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:12=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> The .remove() callback is also used during error handling in
> faux_probe(). As einj_remove() was marked with __exit it's not linked
> into the kernel if the driver is built-in, potentially resulting in
> resource leaks.
>
> Also remove the comment justifying the __exit annotation which doesn't
> apply any more since the driver was converted to the faux device
> interface.
>
> Fixes: 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device int=
erface")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Until the faux device code is updated, this is needed, so applied as
6.17-rc material.

Thanks!

> ---
> Hello,
>
> note that the intention seems to be that this construct is safe, see
> commit c393befa14ab ("driver core: faux: Suppress bind attributes").
> Note further that I don't have a machine to test that so this is only
> based on code reading. An appropriate test might be:
>
> | diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> | index f5fbda0a9a44..decb15f1194a 100644
> | --- a/drivers/base/faux.c
> | +++ b/drivers/base/faux.c
> | @@ -39,6 +39,8 @@ static int faux_match(struct device *dev, const struc=
t device_driver *drv)
> |       return 1;
> |  }
> |
> | +static int once;
> | +
> |  static int faux_probe(struct device *dev)
> |  {
> |       struct faux_object *faux_obj =3D to_faux_object(dev);
> | @@ -56,7 +58,11 @@ static int faux_probe(struct device *dev)
> |        * Add groups after the probe succeeds to ensure resources are
> |        * initialized correctly
> |        */
> | -     ret =3D device_add_groups(dev, faux_obj->groups);
> | +
> | +     if (once++)
> | +             ret =3D -ENOMEM;
> | +     else
> | +             ret =3D device_add_groups(dev, faux_obj->groups);
> |       if (ret && faux_ops && faux_ops->remove)
> |               faux_ops->remove(faux_dev);
>
> (quoted to make sure that this hunk won't be used when the patch is
> applied).
>
> Even if the faux device interface is fixed not to rely on .remove() the
> comment in einj-core.c needs some love.
>
> Best regards
> Uwe
>
>  drivers/acpi/apei/einj-core.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.=
c
> index bf8dc92a373a..1204fa3df285 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -1091,7 +1091,7 @@ static int __init einj_probe(struct faux_device *fd=
ev)
>         return rc;
>  }
>
> -static void __exit einj_remove(struct faux_device *fdev)
> +static void einj_remove(struct faux_device *fdev)
>  {
>         struct apei_exec_context ctx;
>
> @@ -1114,15 +1114,9 @@ static void __exit einj_remove(struct faux_device =
*fdev)
>  }
>
>  static struct faux_device *einj_dev;
> -/*
> - * einj_remove() lives in .exit.text. For drivers registered via
> - * platform_driver_probe() this is ok because they cannot get unbound at
> - * runtime. So mark the driver struct with __refdata to prevent modpost
> - * triggering a section mismatch warning.
> - */
> -static struct faux_device_ops einj_device_ops __refdata =3D {
> +static struct faux_device_ops einj_device_ops =3D {
>         .probe =3D einj_probe,
> -       .remove =3D __exit_p(einj_remove),
> +       .remove =3D einj_remove,
>  };
>
>  static int __init einj_init(void)
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> --
> 2.50.1
>
>

