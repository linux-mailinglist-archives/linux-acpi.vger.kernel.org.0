Return-Path: <linux-acpi+bounces-8529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E798D2BC
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 14:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D941C21AAD
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 12:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6181CF5F8;
	Wed,  2 Oct 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTdvw0ZI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F761CF5E9;
	Wed,  2 Oct 2024 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870909; cv=none; b=pPpnZs61sDsEuIt9v+22UYtstUhoWyQMwXmp66gxYZeccHWfFoDQWFCCQhBR9LBjNZXYMXzQrM5xwu2x9rVF6MUx4ntavAjjFXG/9T1SFSCsyCIDR6sKm19GBFSrCnMqeYGFCjNKfoPd/JIu2jF4x9N+LZFK36WOW3S/WpcOvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870909; c=relaxed/simple;
	bh=XjCN5zW5hQ1Tckp0hwyDmtgo3vBwqD5x/INylPH/msY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mT86tsNAAQ5KXPMu3piEyx3vQKsgPZ9S1HXlokQiKO41O6N58qpNa4BySx9LP1F7tvh1C19IfdixgvJlbHlAp2ftjXxNXB2bHtqSUj6V9dO5Y2exa10mqawG5BoqShpL2J8btVYh0ED27SKP/0zUcT2u8RdU9UXstIqW+MTbJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTdvw0ZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2AFC4CECE;
	Wed,  2 Oct 2024 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727870909;
	bh=XjCN5zW5hQ1Tckp0hwyDmtgo3vBwqD5x/INylPH/msY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OTdvw0ZIwsWgShcd8Vk+MsQyutK7nuN3yLNiAi+2tgsxcHEAD+9euio96vXRAuy8v
	 W/QpLpu1N3v8WObHFPcARt/87CQOtFzOLFnDUGpJ5IT4jYbevF8zqZwXKtvdkhdLn+
	 udodal8TehbTwxotXrQzYGVuYh5go0rBOmvQBMikUnbpBJ/Ow1zDvLc3b8Ponb083Y
	 3nZZLXOjXNzRVh5Hc2oYGSyEcF9BcWJvxx5RwZsF6J41thq0KQDIM96OHNZ8MIA7bq
	 V8LDTVl8T82ZXiHTPZD5uqSNKnN+FWL05rsRjkC9taItYEldbztLqygcDuOtnPky+k
	 QF7g35D+wZO8g==
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so5568738a91.2;
        Wed, 02 Oct 2024 05:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYWoy5BBGZE7Nsoxax3J4dxkcnp2h0ZLG6D6Cejk80PkuP5O5XbPEunPV8AiKI/tOcur4tw79QdcDM@vger.kernel.org, AJvYcCVJx7R/jmLHjEPcoP7UAtaFN2o3k2YxSrcy0UutWyR93yJELimGn6b9FyU7TmVq1B+hk0OGdIGYSntgcqTBbjea0nKR9Q==@vger.kernel.org, AJvYcCVVQ4F4LeR01VSb1FJLElA7JAQypvpcnjFAtDX/ky/DptQg15R8+adeOtAyoQm42CFPaIZ+UPnmD+E4sZE6@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdcLCz57bSPWkVyLZ5sy18hoHJk/v8p3lS5FBVQi/plEvI8lh
	CjHCheJ2QFydUDWNUro85L0lBQsNJhcHuPSU+Pv1WFVY6YGVbJgST2upQtN2SyobomwptjNJ1KR
	1T2QK1rQVnYxcSY8yo5lLCSfK8no=
X-Google-Smtp-Source: AGHT+IHYlBybHmovZ4Faizp/PqGGXh7Vp7cTfuD6kuV7etKaC2wy/YC59itesBagMXQRVEgVQ7mcmt2OPmh7IAbVT4Y=
X-Received: by 2002:a17:90a:f510:b0:2e0:7db9:1809 with SMTP id
 98e67ed59e1d1-2e184967c4dmr3978485a91.33.1727870908894; Wed, 02 Oct 2024
 05:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001212835.341788-1-W_Armin@gmx.de> <20241001212835.341788-3-W_Armin@gmx.de>
In-Reply-To: <20241001212835.341788-3-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 14:08:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com>
Message-ID: <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 2/3] ACPI: battery: Fix possible crash when
 unregistering a battery hook
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com
Cc: pali@kernel.org, dilinger@queued.net, lenb@kernel.org, 
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:28=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> When a battery hook returns an error when adding a new battery, then
> the battery hook is automatically unregistered.
> However the battery hook provider cannot know that, so it will later
> call battery_hook_unregister() on the already unregistered battery
> hook, resulting in a crash.
>
> Fix this by using the list head to mark already unregistered battery
> hooks as already being unregistered so that they can be ignored by
> battery_hook_unregister().
>
> Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hans, are you going to take this series or should I apply it?

> ---
>  drivers/acpi/battery.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index dda59ee5a11e..1c45ff6dbb83 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -715,7 +715,7 @@ static void battery_hook_unregister_unlocked(struct a=
cpi_battery_hook *hook)
>                 if (!hook->remove_battery(battery->bat, hook))
>                         power_supply_changed(battery->bat);
>         }
> -       list_del(&hook->list);
> +       list_del_init(&hook->list);
>
>         pr_info("extension unregistered: %s\n", hook->name);
>  }
> @@ -723,7 +723,14 @@ static void battery_hook_unregister_unlocked(struct =
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
> +       if (!list_empty(&hook->list))
> +               battery_hook_unregister_unlocked(hook);
> +
>         mutex_unlock(&hook_mutex);
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
> @@ -733,7 +740,6 @@ void battery_hook_register(struct acpi_battery_hook *=
hook)
>         struct acpi_battery *battery;
>
>         mutex_lock(&hook_mutex);
> -       INIT_LIST_HEAD(&hook->list);
>         list_add(&hook->list, &battery_hook_list);
>         /*
>          * Now that the driver is registered, we need
> --
> 2.39.5
>

