Return-Path: <linux-acpi+bounces-8588-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73902993417
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 18:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F44F1F23623
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Oct 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AB1DC730;
	Mon,  7 Oct 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf/5GY9/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE481DC071;
	Mon,  7 Oct 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319917; cv=none; b=pcgZdVTMk+EIdF+B2qD6s/Rz7L+W9bsDkCveV68/GKR9uWNJMLVGqh56i6wuxE4JhkitwhAgrGeoA+kpHUwcoijbcbtYwB6/bz8ooJZmBrumDDkNkTEWDrsUedE2QGAjPNETmLH0fsS1OWhIeFA6wZIAS62WzodZvEahzYHrjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319917; c=relaxed/simple;
	bh=mQ692TNlccdh3ekLUIq5Y+tz2OVkv0kzgv7FGWTnYH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apIPFFiQl7m7qG/+Y+fRozG2lFRdcV+8HfJ6QHt+fUZP3DQ4qcpGxu0qXC7R1ITc86cOpE+Y1WJ1dVqiaouR3bxms6l/UI86wPkaCHYTxWYfMAPdBa8Wb5nShDszMk+wHoaL1kGDI52hZKk5mVI550vLiHsppx2NB04kAlrB1SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf/5GY9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74304C4AF09;
	Mon,  7 Oct 2024 16:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728319917;
	bh=mQ692TNlccdh3ekLUIq5Y+tz2OVkv0kzgv7FGWTnYH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jf/5GY9/+s9+S/fNqb6a9j4iizFNkCCIFLgf0GS1WuymVUkh6OqgLRuOPyb1sga88
	 ksuposVNbs+QCJ6FQn2JLB0OvqumFQijkGIPrUCYVNiG4byQk2mqO5OrcUAQbJMqnd
	 U23+OSc+zBnnVMaTQUTYKPalZwLKTiufDGxgS5tPKvLkxLeUe8Zm2rv4suoVYi7tDj
	 43ovlqLX06AGJhn3FunQfxRIAZTOHoImAbytxffp+Q3SQYa5RODHGBDoBrC1nZGn+l
	 4rwJux+Ap6V8/is9wMOZn1Tu8kh+51Sjrb2bD+SiRGRD2DGxpUWQfukTgr0UeXYgwj
	 x+Oif5/pv9uJg==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e06b72f3e7so2161148b6e.0;
        Mon, 07 Oct 2024 09:51:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7BbmIlI7rFJrFB+PsZpYzlMj6Zt6ohJWtahD9iSBAkAeWbh2DVrTWKsa5azRmKP+qxvTUfg574SzW@vger.kernel.org, AJvYcCW4vd213RJsPQMcQB8wI7qHt6/p4uCUSVxD12cTiUyXFCe/F03lp8djh2fWxK6JmwdeDsK1IAJ6jC080jEA@vger.kernel.org, AJvYcCWmKNVZOxqX0iH3+OlRPM3gVFduTMWYkK95S9UOMT19l14P3iZSGI0uperHQ2LZTzkxTGO6Fqea47M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTZMy7+an7/wfRbOtmqD8Xzo71W1lVffmTWLNoMRTFrMMSy5HF
	YWIKx2UNWKPAYT2/IaQDI/82FhXpbTqM1lJo2NLp/wKBGkvwoqumXu8/2A2hSpmFXuN5qdwz89G
	Z3CjnLcRA5qbzyZd+8fGnxZxnbIE=
X-Google-Smtp-Source: AGHT+IFiOIOqw/qc4ZTHJxfoSzE6KMoRDbdjxV+x8/xIF8IxxUPacNXZKL7rCHi5nnkzXzSbE7rIDVx1ilQP30xw0C0=
X-Received: by 2002:a05:6808:228d:b0:3df:a2f:4ad3 with SMTP id
 5614622812f47-3e3db5cc315mr123616b6e.11.1728319916851; Mon, 07 Oct 2024
 09:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
 <20241005-power-supply-no-wakeup-source-v1-2-1d62bf9bcb1d@weissschuh.net>
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-2-1d62bf9bcb1d@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 18:51:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j=P9orUe9k0bsUfxE0YA8stsbAi=k+ge4_XBeuHVnyrw@mail.gmail.com>
Message-ID: <CAJZ5v0j=P9orUe9k0bsUfxE0YA8stsbAi=k+ge4_XBeuHVnyrw@mail.gmail.com>
Subject: Re: [PATCH 2/8] ACPI: battery: Register power supply with power_supply_register()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	=?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:05=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> power_supply_register_no_ws() is going to be removed.
> Switch to the general registration API.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@inte;.com>

and I'm assuming this to be handled along with the rest of the series.

> ---
>  drivers/acpi/battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 65fa3444367a13ac83644444076a11f08152c382..9a3a475f8ad334bb365e6a027=
3084034b8baa3bd 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -853,6 +853,7 @@ static int sysfs_add_battery(struct acpi_battery *bat=
tery)
>         struct power_supply_config psy_cfg =3D {
>                 .drv_data =3D battery,
>                 .attr_grp =3D acpi_battery_groups,
> +               .no_wakeup_source =3D true,
>         };
>         bool full_cap_broken =3D false;
>
> @@ -888,7 +889,7 @@ static int sysfs_add_battery(struct acpi_battery *bat=
tery)
>         battery->bat_desc.type =3D POWER_SUPPLY_TYPE_BATTERY;
>         battery->bat_desc.get_property =3D acpi_battery_get_property;
>
> -       battery->bat =3D power_supply_register_no_ws(&battery->device->de=
v,
> +       battery->bat =3D power_supply_register(&battery->device->dev,
>                                 &battery->bat_desc, &psy_cfg);
>
>         if (IS_ERR(battery->bat)) {
>
> --
> 2.46.2
>

