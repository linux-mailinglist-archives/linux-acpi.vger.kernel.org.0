Return-Path: <linux-acpi+bounces-6068-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB518D2551
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 21:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2660B279E6
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041C17837F;
	Tue, 28 May 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9ynps6a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604B17798C;
	Tue, 28 May 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926144; cv=none; b=PqmGQwpIchnJjLQJhpdXM3TLZWld+ff7mkLV8qOc0P4LdT19gvDbCqXKFaKljuKcNeC1DtQ0QHm1Dsi3TOWhgo4BkrUVx5fbKcNlSKCrRmrpElBQ64KsObEYjiLbK2MyYkv9LHvmv9gdhYrT7uOxi67vEh9PBba4WFfR9cgyMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926144; c=relaxed/simple;
	bh=ueRDZg/EI4X7ST15DK0fbJaHhl59ANhm8a1wKKNp0z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hQrzewrteEUpkaReBsf2priID8v3RlXAQ+VJ0jiamI3yW8+Wcq+TB+yVxQO1om+xSgG1Wb5V+K1inb0wpa36ev4Zwn92TWykBi36wJZnmBYbqf6Y5OCfuiJAblltWTUwkMNFzEbbhm44bYYM4ZjQSGfwuYmotyHdAvPNjzinCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9ynps6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853E1C4AF0A;
	Tue, 28 May 2024 19:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926143;
	bh=ueRDZg/EI4X7ST15DK0fbJaHhl59ANhm8a1wKKNp0z8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c9ynps6aja61mjnZdCClIkomdX7xsaFmJhjZO0FPQ/fZgEzNxYVh9dpWMghD93m+U
	 xIQZuPXbWJoMGHAmx9WPiXSGEeFrO9yPdBJfQkgGIc3k1q8u7vglMJzIcmUAEiPx+5
	 UIEcPIvt+R35OsyKfJKVdRZGy10aAq8pyvcJvZ+zbOStLDVANwCoqss4hr/n//9af/
	 cVDWw3heviGeFuH6PinfeA25/tgW4KRx50a/HfRw96Rqq9PPgAFAN4h+ELbvHUsFwq
	 waajo/sFATWhQqhPVKRGh10UM2GW2I86dIvONCEEaxqzaeD4RMljyZf66jZ9b6JOiA
	 QivJsKlvEYQ9g==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b31337e229so141373eaf.3;
        Tue, 28 May 2024 12:55:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwo9hCeYu9tlLEmSybo8lIHnqmn37De6l7Yz2GhxgytfXZnj7p6ljKIRnxFVJt3L39zyGkLXFj2G9wx70sJjUr2xusfmDLVHPZeRAj
X-Gm-Message-State: AOJu0YyAojVPygeX0k5Pe29w3rZwh3KnM4IAjGEblvMW1ffyvrihXOrW
	LTlWdb8ewF12ou6/HXe9Ip10zydJn6Fc0sClB1PKxTX3y/Z3Y90FCBKopFwzwEFn7lZSFTwirYB
	9zqC0dhYZTRBd19e2cqKzWJZx3pQ=
X-Google-Smtp-Source: AGHT+IE4f1AmGg6rbLDvGcVqaxBuYGC4KHXThV6AVqrtIeBak3HsRhZR+qatPUZWZBxrmmGG7Jw8wgyjKioN5sKsCgw=
X-Received: by 2002:a4a:e6d8:0:b0:5b2:7aa7:7b29 with SMTP id
 006d021491bc7-5b96195f885mr13901803eaf.1.1716926142725; Tue, 28 May 2024
 12:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528102708.1451343-1-andy.shevchenko@gmail.com> <20240528102708.1451343-2-andy.shevchenko@gmail.com>
In-Reply-To: <20240528102708.1451343-2-andy.shevchenko@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 21:55:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMwTSr8NQx5my4ejZPa_S=BczeYg1tVcQ15a=djTsCmw@mail.gmail.com>
Message-ID: <CAJZ5v0gMwTSr8NQx5my4ejZPa_S=BczeYg1tVcQ15a=djTsCmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PNP: Make dev_is_pnp() to be a function and export
 it for modules
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guanbing Huang <albanhuang@outlook.com>, 
	Guanbing Huang <albanhuang@tencent.com>, Christoph Hellwig <hch@infradead.org>, 
	Woody Suwalski <terraluna977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 12:27=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Since we have a dev_is_pnp() macro that utilises the address of the
> pnp_bus_type variable, the users, which can be compiled as modules,
> will fail to build. Convert the macro to be a function and export it
> to the modules to prevent build breakage.
>
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Closes: https://lore.kernel.org/r/cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gm=
ail.com
> Fixes: 2a49b45cd0e7 ("PNP: Add dev_is_pnp() macro")
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/pnp/driver.c | 6 ++++++
>  include/linux/pnp.h  | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index 0a5d0d8befa8..3483e52e3a81 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -266,6 +266,12 @@ const struct bus_type pnp_bus_type =3D {
>         .dev_groups =3D pnp_dev_groups,
>  };
>
> +bool dev_is_pnp(const struct device *dev)
> +{
> +       return dev->bus =3D=3D &pnp_bus_type;
> +}
> +EXPORT_SYMBOL_GPL(dev_is_pnp);
> +
>  int pnp_register_driver(struct pnp_driver *drv)
>  {
>         drv->driver.name =3D drv->name;
> diff --git a/include/linux/pnp.h b/include/linux/pnp.h
> index 82561242cda4..a8def1cea32c 100644
> --- a/include/linux/pnp.h
> +++ b/include/linux/pnp.h
> @@ -469,7 +469,7 @@ int compare_pnp_id(struct pnp_id *pos, const char *id=
);
>  int pnp_register_driver(struct pnp_driver *drv);
>  void pnp_unregister_driver(struct pnp_driver *drv);
>
> -#define dev_is_pnp(d) ((d)->bus =3D=3D &pnp_bus_type)
> +bool dev_is_pnp(const struct device *dev);
>
>  #else
>
> @@ -502,7 +502,7 @@ static inline int compare_pnp_id(struct pnp_id *pos, =
const char *id) { return -E
>  static inline int pnp_register_driver(struct pnp_driver *drv) { return -=
ENODEV; }
>  static inline void pnp_unregister_driver(struct pnp_driver *drv) { }
>
> -#define dev_is_pnp(d) false
> +static inline bool dev_is_pnp(const struct device *dev) { return false; =
}
>
>  #endif /* CONFIG_PNP */
>
> --

Applied along with the [2/2] as 6.10-rc material, thanks!

