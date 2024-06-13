Return-Path: <linux-acpi+bounces-6384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E29907CA1
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59A81C2259F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BABA12C7E3;
	Thu, 13 Jun 2024 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm6LvKOq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D2A1EA87;
	Thu, 13 Jun 2024 19:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307096; cv=none; b=CK/6hGJQybOzDQ5txNXJ4B9o7pmB/pXoQ0raEiKMC5rakHIjcEeoWWFA1Y+/Zy9DOf2T1EmC9rBqD2NNFQrzjxDujea44zvsFzo9DVJH1sNVqLZ1D8VpFv0v46FG8o/GmYoBQb1K7AL/GQhzZOOVqtJ77NZOYoyy90qIj07FgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307096; c=relaxed/simple;
	bh=Msrty0CWghk7EgHSD1Enom1a+uVe/GJvqQt78XwijVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TH4sX8MWCO3BJJ8vr5dyMkkRtuzCElVfd2+enHi8a45B2xRBiLRPZJ9MkGRWxSe9lUzEoRvzaUrr1iRvBRxDfZ4G5qhbSzQTXZxco9vDk1oLw9+FamZUs1Bs6o4A+SdEdPgW9xkww52t3HO4Rq0PiVrcv36jyAe5M4FmXLl2M9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm6LvKOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B88C3277B;
	Thu, 13 Jun 2024 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307095;
	bh=Msrty0CWghk7EgHSD1Enom1a+uVe/GJvqQt78XwijVc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fm6LvKOq8LnCkBKudRaefpRrC9T/XZx9lMSs+kmy3GilS6OOTjYz0bbmhro7CPW+z
	 JIJOSCprtyehKRXBJif3Je62s5h884wbeaMM+rh64Z+XdWxbwHFaVojIngZ1oMp6Bc
	 UiGSrmploDvU1bCi0dAsnnZIY269KCwJy5LlKlhxlZobY4Zc2Y2k75m+obusE1zBEE
	 50tnPmceVKM/u1IJmK/TMLwUDiN45ZvidKgUQ3wYtkW4LDBrT982XxT3dBKj04EjAm
	 3Ngmnh+M0MOJT4KrPdubtUZMLdd0aFs7XdYYIfKsFJjWZ6S9PKLO0OcFAohEvNOzvk
	 jOogEuJ6APleQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bad97708efso76639eaf.1;
        Thu, 13 Jun 2024 12:31:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqhMFnW2/iSDSXVG1dTV42Ew566CqkYl+5FeugrTXvzrK/t9wbTG/CCyTgwF9w+PRkw7jqeajqTqgWOUBKGQJmyqYRsXCotXzBhHyUE3Xzk+FWdIE29uqC9twL3u84uB6bunAXn4o9Tw==
X-Gm-Message-State: AOJu0YzjOcWyA86xrLC+4/oKiwKQYtvGiR0NbwfT9Fw9VGYauGIN4JaX
	nWR1A8hueh/8OHtxoKp1M1wT40Wox+XD7H6mi8Q3BZ9v4iaHuITgg3yrJJc6a09+liSpipf32r0
	4yepfPRl8/ELd6FDfbVo7q2sHMgo=
X-Google-Smtp-Source: AGHT+IHRs3zSxlvThk3H+BGoZJ70j/dsSZLDQhgr/sGb0RpjaRB8rMEr1itwIj3NvzD+SyS9OPhnuPBWM0fXin64EV4=
X-Received: by 2002:a05:6820:287:b0:5ba:ca8a:6598 with SMTP id
 006d021491bc7-5bdad9f3131mr667709eaf.0.1718307095066; Thu, 13 Jun 2024
 12:31:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609-acpi-sbs-sysfs-group-v1-1-7f0bf95523e7@weissschuh.net>
In-Reply-To: <20240609-acpi-sbs-sysfs-group-v1-1-7f0bf95523e7@weissschuh.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 21:31:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0im2ThDaMyV3bEtYsQYWJH0Y9sYVjpJJ0Zb-wBk_wZr0Q@mail.gmail.com>
Message-ID: <CAJZ5v0im2ThDaMyV3bEtYsQYWJH0Y9sYVjpJJ0Zb-wBk_wZr0Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SBS: manage alarm sysfs attribute through psy core
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 9, 2024 at 1:13=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisssc=
huh.net> wrote:
>
> Let the power supply core register the attribute.
> This ensures that the attribute is created before the device is
> announced to userspace, avoiding a race condition.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
> Only compile-tested.
>
> This is the SBS equivalent of
> "ACPI: battery: create alarm sysfs attribute atomically" [0]
>
> [0] https://lore.kernel.org/lkml/20240609-acpi-battery-cleanup-v1-5-34451=
7bdca73@weisss
> ---
>  drivers/acpi/sbs.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index dc8164b182dc..442c5905d43b 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -77,7 +77,6 @@ struct acpi_battery {
>         u16 spec;
>         u8 id;
>         u8 present:1;
> -       u8 have_sysfs_alarm:1;
>  };
>
>  #define to_acpi_battery(x) power_supply_get_drvdata(x)
> @@ -462,12 +461,18 @@ static ssize_t acpi_battery_alarm_store(struct devi=
ce *dev,
>         return count;
>  }
>
> -static const struct device_attribute alarm_attr =3D {
> +static struct device_attribute alarm_attr =3D {
>         .attr =3D {.name =3D "alarm", .mode =3D 0644},
>         .show =3D acpi_battery_alarm_show,
>         .store =3D acpi_battery_alarm_store,
>  };
>
> +static struct attribute *acpi_battery_attrs[] =3D {
> +       &alarm_attr.attr,
> +       NULL
> +};
> +ATTRIBUTE_GROUPS(acpi_battery);
> +
>  /* ---------------------------------------------------------------------=
-----
>                                   Driver Interface
>     ---------------------------------------------------------------------=
----- */
> @@ -518,7 +523,10 @@ static int acpi_battery_read(struct acpi_battery *ba=
ttery)
>  static int acpi_battery_add(struct acpi_sbs *sbs, int id)
>  {
>         struct acpi_battery *battery =3D &sbs->battery[id];
> -       struct power_supply_config psy_cfg =3D { .drv_data =3D battery, }=
;
> +       struct power_supply_config psy_cfg =3D {
> +               .drv_data =3D battery,
> +               .attr_grp =3D acpi_battery_groups,
> +       };
>         int result;
>
>         battery->id =3D id;
> @@ -548,10 +556,6 @@ static int acpi_battery_add(struct acpi_sbs *sbs, in=
t id)
>                 goto end;
>         }
>
> -       result =3D device_create_file(&battery->bat->dev, &alarm_attr);
> -       if (result)
> -               goto end;
> -       battery->have_sysfs_alarm =3D 1;
>        end:
>         pr_info("%s [%s]: Battery Slot [%s] (battery %s)\n",
>                ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
> @@ -563,11 +567,8 @@ static void acpi_battery_remove(struct acpi_sbs *sbs=
, int id)
>  {
>         struct acpi_battery *battery =3D &sbs->battery[id];
>
> -       if (battery->bat) {
> -               if (battery->have_sysfs_alarm)
> -                       device_remove_file(&battery->bat->dev, &alarm_att=
r);
> +       if (battery->bat)
>                 power_supply_unregister(battery->bat);
> -       }
>  }
>
>  static int acpi_charger_add(struct acpi_sbs *sbs)
>
> ---

Applied as 6.11 material, thanks!

