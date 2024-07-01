Return-Path: <linux-acpi+bounces-6714-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EED91E6B8
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 19:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8571C21D30
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 17:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A716D9D8;
	Mon,  1 Jul 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBU/oxK7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F4D2C6A3;
	Mon,  1 Jul 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855269; cv=none; b=XMBMW9yB25PhykZcX1hcOQUxG8bSA4V8O//VSub+gy4NxAnX8T41abU8AzjQ3SmBSwQt4GINa6z5rvBP4YJCzUHf0BLblY23VWsmXfLQXdIVJ2eTWFYId8oyXYTZvpFXlVmIhTAFoY1USTQ3LqgHiNv5a8Mi+TxlZ7V+v7Tv2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855269; c=relaxed/simple;
	bh=+bbr0YgH3S6DRuV/lOUY3GAma0Hm5f6urxThBML5+3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjdnRvSRy+iVaFqCAKH46NW90mMj2Fig4DOdrmJ5/tzhhCgUKXK2pGSea56NcAt+LRaAXW+kcXmLTNP6bT+4EjU0xwH7dgOWHkZ8djgq+25L1EBX+lnKAseGWcM2SQS6hfB+p8PQ5DHDpjD3hhBvA+kfnZAHRHvFyjX85ebvxOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBU/oxK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED2FC116B1;
	Mon,  1 Jul 2024 17:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719855269;
	bh=+bbr0YgH3S6DRuV/lOUY3GAma0Hm5f6urxThBML5+3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cBU/oxK7snZtrNzlef9OrNN4XC68y/IKWJPRYLx3x4+TqAnFTtnBpIp+gy6vLkQ9x
	 PVtg6i98unqGXy/TyeYesaGOJHDs852/PscX37HbMDE68hVHhyInLUGe4sjYRA5d7L
	 g7JJurglzvC5z/VsL2RsxY5l3iLUohB92YYXKJDxyHEA9n10YlTwgAXkQnBwkdp6vE
	 Zlbs84U3TiABRuaByrbUrNEPb6DS/PD7LIpIhBhuAaaLoxwfusIUm20f2jQ7gyDjq4
	 ynBtMNv6iYr/oEioj0mNDuJ7roOMG1e5herjTYC/B16Xu+rjDh8Gn7XHejPkElsNtu
	 U4AGT2GTpTS/A==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-25075f3f472so488014fac.2;
        Mon, 01 Jul 2024 10:34:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWa7mJ8q3As4P+P/Lli+qHBJlG4f5ZIcxhL7FFLkVQYBJ1Gt++5nldv3q6ocy4zYytxQUqdhFyU37/6yKVDcqRkQFemHUsfRRpE/aX5o5PjvvkKSZQlCSwfotrTL8TL0n7932y6SimvBA==
X-Gm-Message-State: AOJu0Yzay9KMWBpD+3SacdaWTjoYBgVC+1E6R3dml/ME10f92pRoCYph
	CbcDDAFdoY6I02yoLODUoaABZVSpq175kJJ/BFSZsQMGSDsvvejSPJlbY7GEY1AcRfL4rNjw0YI
	LXv32soCkopbLgl5D/Vp9X3Ay5jI=
X-Google-Smtp-Source: AGHT+IEucRk7+G9KtfTHkimt+xorhTmeosEBYSOKBZhF3xpIYPGpUXcaGyJhAHV7iVEKD7fC+u4M6x1GGFHWexjqsug=
X-Received: by 2002:a05:6870:4195:b0:25d:d69:eaf with SMTP id
 586e51a60fabf-25db36406d0mr6182660fac.4.1719855268686; Mon, 01 Jul 2024
 10:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620191410.3646-1-W_Armin@gmx.de>
In-Reply-To: <20240620191410.3646-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 19:34:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iG4fAp1NL1Xf3JAY1XcYRuCttaZyR1S6AYD=FZpmzRWw@mail.gmail.com>
Message-ID: <CAJZ5v0iG4fAp1NL1Xf3JAY1XcYRuCttaZyR1S6AYD=FZpmzRWw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: battery: Add support for charge limiting state
To: Armin Wolf <W_Armin@gmx.de>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 9:14=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> The ACPI specification says that bit 3 inside the battery state
> signals that the battery is in charge limiting state. In this state,
> the platform limits the battery from reaching its full capacity, the
> exact limit is platform-specific.
>
> This might explain why a number of batteries reported a "Unknown"
> battery state in the past when using platform-specific interfaces to
> stop battery charging at a user defined level.
>
> Unfortunately not all platforms set this bit in such cases, so
> "non-charging" is still the default state when the battery is neither
> charging, discharging or full.
>
> Tested on a Lenovo Ideapad S145-14IWL.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/battery.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index d289b98a2cca..9ba2191a96d6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -38,9 +38,10 @@
>  /* Battery power unit: 0 means mW, 1 means mA */
>  #define ACPI_BATTERY_POWER_UNIT_MA     1
>
> -#define ACPI_BATTERY_STATE_DISCHARGING 0x1
> -#define ACPI_BATTERY_STATE_CHARGING    0x2
> -#define ACPI_BATTERY_STATE_CRITICAL    0x4
> +#define ACPI_BATTERY_STATE_DISCHARGING         0x1
> +#define ACPI_BATTERY_STATE_CHARGING            0x2
> +#define ACPI_BATTERY_STATE_CRITICAL            0x4
> +#define ACPI_BATTERY_STATE_CHARGE_LIMITING     0x8
>
>  #define MAX_STRING_LENGTH      64
>
> @@ -155,7 +156,7 @@ static int acpi_battery_get_state(struct acpi_battery=
 *battery);
>
>  static int acpi_battery_is_charged(struct acpi_battery *battery)
>  {
> -       /* charging, discharging or critical low */
> +       /* charging, discharging, critical low or charge limited */
>         if (battery->state !=3D 0)
>                 return 0;
>
> @@ -215,6 +216,8 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>                         val->intval =3D acpi_battery_handle_discharging(b=
attery);
>                 else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
>                         val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +               else if (battery->state & ACPI_BATTERY_STATE_CHARGE_LIMIT=
ING)
> +                       val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
>                 else if (acpi_battery_is_charged(battery))
>                         val->intval =3D POWER_SUPPLY_STATUS_FULL;
>                 else
> --

Applied as 6.11 material along with the [2/2], thanks!

