Return-Path: <linux-acpi+bounces-8518-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AD898C5BE
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A55B225B3
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9140C1CCB54;
	Tue,  1 Oct 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVCvMRNJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DA1C2DB7;
	Tue,  1 Oct 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727809058; cv=none; b=CEWebn2sXAq95WNzs0pgonh3+hkbZGTz9sNcrxW/nxXrjhOQvXUx4eLS3RDM9eYGHU6/eZ24B46akmJyklJb/nFjUMFMaq5iP4lkBFoKsKjCbQXE9bghwHBubJuXeA2+lDGtBTRpVGICl6wim8kewTI8S+5Joc5Q3s8B99fNlhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727809058; c=relaxed/simple;
	bh=VYIHyPPIv2bf7I3RLjsI38d/asSeC/oQh1hx2nZUOiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFUC7Bp9Lx8AOI38J7baMrnYph3loSxkuytdmIqBFuexBzw0JVx+fQRyDtCsyCJ7Ff3pjxRrxWQzJFBC3SJq4Q5QCa0v5Eb7RtoMl74FITCtbKpmABhlI1wpNa6WWHqImDcH5YK5qWylpWYuzoUiv0q5pOoZrqEYpAKubE6rJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVCvMRNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFBEC4CEC7;
	Tue,  1 Oct 2024 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727809058;
	bh=VYIHyPPIv2bf7I3RLjsI38d/asSeC/oQh1hx2nZUOiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FVCvMRNJc4YDCd8GDQrCrPtaK1M7nM7Hu2SHlRilz8h24rWPoDE/lERHmXYYzX/FK
	 hs+yvIFUnuE9k2nD28Z2LqgfqN/rnUvEIp0y+ts/s8Teh38YrHfWX1v5YQKzzO3Gq6
	 tGvD7hTYAWaL5JZcrMxGTAD5CDz8kdkchxTbyQCNzjJUw2ZLs0JNPYdnC1PKxapba9
	 bNnX6TLDK0rP17UBUCLqE6eHl5RYLi9L3sRGfgVhBfpkhWcJPJgMwVlsgQUYKfG6TR
	 zTnrjGgleZCdcolykRCf5itx0yk78DaZ/FyqdEYRaOxjRuwFfsYoOvzIfViemyXFU+
	 CNwsPT6S+85Pg==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5e1ba0adcb0so2789109eaf.0;
        Tue, 01 Oct 2024 11:57:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjtTIWXCgZAGwlVlDISjLL99atXE6Fpyrs9eGoADfZi0FkRo+NE2woeHkw+GW++/PUcuj0SuaHMbNo@vger.kernel.org, AJvYcCUp9mqMRs5ZIyHB677GexzXvmjk6eff8Ol2k6K3FdACZjgb2FUBL/tbhXN6eEkLv42RJ74ogJ7BHEPCV2oH@vger.kernel.org, AJvYcCXgaozdUALkkM1IzaK9mulKSVCVn7y0jPhNhkim89XwmWWlUCRr03iRnfSM/u5zZVOjVdDCnUyMZ3v5loFxtAnvISdkrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCc45wlbv5R2clgfVKOYO+9BSyo5+C2lyIouhdXZtA3VtTcLe/
	Rzq/dXCpDsEf5vh1/nngTgVU0kbp8y0bGJwkRedg+b4czlRx1o16iDzBgD3da/gsqL4yt86AXHl
	WqcdMaz1bv2BpP1AeXrDM1h5W7n8=
X-Google-Smtp-Source: AGHT+IG37WO7IHfu9/dMzHVVPdks0hgjN0py7twk1gg4qvOlWS01dUobHR5yVOxiuGGuGJodquBfMJNaEcF9JJnkvQY=
X-Received: by 2002:a05:6820:619:b0:5e1:cca3:97aa with SMTP id
 006d021491bc7-5e7b1e73fdemr604627eaf.6.1727809057546; Tue, 01 Oct 2024
 11:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922064026.496422-1-W_Armin@gmx.de> <20240922064026.496422-3-W_Armin@gmx.de>
In-Reply-To: <20240922064026.496422-3-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Oct 2024 20:57:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4S66jp9QvTetj=KtOTqh-ae4gub_6b5DB5zkasB=yVA@mail.gmail.com>
Message-ID: <CAJZ5v0j4S66jp9QvTetj=KtOTqh-ae4gub_6b5DB5zkasB=yVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: battery: Fix possible crash when
 unregistering a battery hook
To: Armin Wolf <W_Armin@gmx.de>
Cc: mjg59@srcf.ucam.org, pali@kernel.org, dilinger@queued.net, 
	rafael@kernel.org, lenb@kernel.org, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 8:40=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> When a battery hook returns an error when adding a new battery, then
> the battery hook is automatically unregistered.
> However the battery hook provider cannot know that, so it will later
> call battery_hook_unregister() on the already unregistered battery
> hook, resulting in a crash.
>
> Fix this by using a boolean flag to mark already unregistered battery
> hooks as "dead" so that they can be ignored by
> battery_hook_unregister().
>
> Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/battery.c | 11 ++++++++++-
>  include/acpi/battery.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 10e9136897a7..b31a6183a082 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -719,6 +719,7 @@ static void battery_hook_unregister_unlocked(struct a=
cpi_battery_hook *hook)
>                         power_supply_changed(battery->bat);
>         }
>         list_del(&hook->list);
> +       hook->dead =3D true;

It looks like you could do

list_del_init((&hook->list);

here and then do a list_emtpy() check below.

>
>         pr_info("extension unregistered: %s\n", hook->name);
>  }
> @@ -726,7 +727,14 @@ static void battery_hook_unregister_unlocked(struct =
acpi_battery_hook *hook)
>  void battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
>         mutex_lock(&hook_mutex);
> -       battery_hook_unregister_unlocked(hook);
> +       /*
> +        * Ignore already unregistered battery hooks. This might happen
> +        * if a battery hook was previously unloaded due to an error when
> +        * adding a new battery.
> +        */
> +       if (!hook->dead)

if (!list_empty(&hook->list))

> +               battery_hook_unregister_unlocked(hook);
> +
>         mutex_unlock(&hook_mutex);

and the new struct field would not be necessary if I'm not mistaken.

>  }
>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
> @@ -737,6 +745,7 @@ void battery_hook_register(struct acpi_battery_hook *=
hook)
>
>         mutex_lock(&hook_mutex);
>         INIT_LIST_HEAD(&hook->list);

Also the above statement is redundant, so maybe drop it while you're at it?

> +       hook->dead =3D false;
>         list_add(&hook->list, &battery_hook_list);
>         /*
>          * Now that the driver is registered, we need
> diff --git a/include/acpi/battery.h b/include/acpi/battery.h
> index c93f16dfb944..5cfe132bb7f5 100644
> --- a/include/acpi/battery.h
> +++ b/include/acpi/battery.h
> @@ -16,6 +16,7 @@ struct acpi_battery_hook {
>         int (*add_battery)(struct power_supply *battery, struct acpi_batt=
ery_hook *hook);
>         int (*remove_battery)(struct power_supply *battery, struct acpi_b=
attery_hook *hook);
>         struct list_head list;
> +       bool dead;
>  };
>
>  void battery_hook_register(struct acpi_battery_hook *hook);
> --

