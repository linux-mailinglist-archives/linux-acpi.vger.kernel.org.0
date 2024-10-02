Return-Path: <linux-acpi+bounces-8528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8078098D2B1
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 14:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31155284A32
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 12:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A7D1CF5E7;
	Wed,  2 Oct 2024 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIDDjI7w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118C18D65A;
	Wed,  2 Oct 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870818; cv=none; b=Gh3QbP4rfsf0occz9rNBtq4TdVlI9xrLUziLBJA+WCAO03bkw0ER68nX+s1tGXtVPVXy+PaKaThJ80Rt8tqcDzKwIEOEh4q2UoMMNXim192Lds8OJPZBu68eTPgtnxxEvLeFHcXWzSYyjd0Th/a0eUe4VH55EpxmXgc+13zlEqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870818; c=relaxed/simple;
	bh=b9GNYX2BI7qHHXFOFPCMaQHNT770RnHy1g3aVLCaAFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ1nfRac6lB9f+XNOe8dF2XNvVfTWJ/of4J/ec3Z6Ij74CbiDzxAHTKeX9zj7JxHmhYn4HEI3QW1nQMEfbW64SClg286eaCQsloCkikqdsA/qImq4D6eQFahODC3WpEoVXi8xo8EYwfw80psP1GvSEKsQwM6c306GYuuWkWduPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIDDjI7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659B9C4CECF;
	Wed,  2 Oct 2024 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727870818;
	bh=b9GNYX2BI7qHHXFOFPCMaQHNT770RnHy1g3aVLCaAFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tIDDjI7w3L7aF/z0MMA59dp5o4zjoXS41rZXNeTFFYMj8YMqxnBeVwi7GQjtV/q5E
	 nMMK2qjQUBz5oFMPPYMSVOUVk3T0mXD3HZHyHQ2L8b8O/TfoodnwG20xmm5QHcZ3a3
	 IOy9vnGEqrDOHPb8+5ACERTX3UKo4FGvy/rajY0JllTynzzjg3yCoWyO9+rFyj4EgY
	 CsWexZ2KtYuqTOi6JOHnzG8gOd4n8+b3R+0nIEfrxkfPW0Jv6nLmYTPdMjwnu2ZSwc
	 8jNESEnjyLL3JFLOH1tYwa6vCEtrDTq0PUSBR8BfdI+mRZFVyBc1DKqnu+Sn90vcah
	 yQUE8j4Q9TSfg==
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e0894f1b14so4913864a91.1;
        Wed, 02 Oct 2024 05:06:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2vI7YiU2NQZfXgYwO3AFFH69gAs5TOzCkeGqhADYGDverSi+jn/8jakx/COmHllWVD9SKeIJ6uFl7@vger.kernel.org, AJvYcCUriE9kpP6bVYkskXi0cPM+8FAUiF51rcm2uRo/SlzT5l+lLoVMTCgxrtmcClzWnLmf2g9bOMGAd7lEiMQfnXv+sShNvg==@vger.kernel.org, AJvYcCWFgTK1pCZCfM2cbG9vFxoJE5g4P6Dt/BFVPaCcpKxPMaB+t/wbwry9bdcPnLYv4lAoHo6ljVmQWw0vpmkK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zpoeotzxj2g/E+dPeOhSuz32X9v6T07vLLVIgVajU3opZP77
	mpWGKCMbYYXxxI12cIa++nXwx0KCbfzbUo8EzISQYhyX4vu65Ql20AlLl/MIPGj5wWwi18oAJ1X
	dw4KeCTMvzj3PrxlJuU0L8RsCZGI=
X-Google-Smtp-Source: AGHT+IEIUXLbHGbWwPhZw1CcY1eYZnn25hLs+4aWOCg3d6/TNPbck4rJI9zffDeJP2LoEVukfsf3Phi5izLkrXdBjfk=
X-Received: by 2002:a17:90b:790:b0:2d3:c4d1:c95d with SMTP id
 98e67ed59e1d1-2e1846ca4f4mr3567708a91.21.1727870817979; Wed, 02 Oct 2024
 05:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001212835.341788-1-W_Armin@gmx.de> <20241001212835.341788-2-W_Armin@gmx.de>
In-Reply-To: <20241001212835.341788-2-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Oct 2024 14:06:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0geqx92+XG-yxXnBFUeNBBygwvAbkxPBEtKi6f88_RYJA@mail.gmail.com>
Message-ID: <CAJZ5v0geqx92+XG-yxXnBFUeNBBygwvAbkxPBEtKi6f88_RYJA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 1/3] ACPI: battery: Simplify battery hook locking
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, dilinger@queued.net, rafael@kernel.org, lenb@kernel.org, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:28=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Move the conditional locking from __battery_hook_unregister()
> into battery_hook_unregister() and rename the low-level function
> to simplify the locking during battery hook removal.
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

Well, "looks good to me" doesn't usually mean "Reviewed-by", but you
can retain the tag in this particular case.

But in the future please don't add Reviewed-by or Acked-by tags from
people to patches if you have not actually received those tags.

> Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/battery.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index f4599261cfc3..dda59ee5a11e 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -703,28 +703,28 @@ static LIST_HEAD(acpi_battery_list);
>  static LIST_HEAD(battery_hook_list);
>  static DEFINE_MUTEX(hook_mutex);
>
> -static void __battery_hook_unregister(struct acpi_battery_hook *hook, in=
t lock)
> +static void battery_hook_unregister_unlocked(struct acpi_battery_hook *h=
ook)
>  {
>         struct acpi_battery *battery;
> +
>         /*
>          * In order to remove a hook, we first need to
>          * de-register all the batteries that are registered.
>          */
> -       if (lock)
> -               mutex_lock(&hook_mutex);
>         list_for_each_entry(battery, &acpi_battery_list, list) {
>                 if (!hook->remove_battery(battery->bat, hook))
>                         power_supply_changed(battery->bat);
>         }
>         list_del(&hook->list);
> -       if (lock)
> -               mutex_unlock(&hook_mutex);
> +
>         pr_info("extension unregistered: %s\n", hook->name);
>  }
>
>  void battery_hook_unregister(struct acpi_battery_hook *hook)
>  {
> -       __battery_hook_unregister(hook, 1);
> +       mutex_lock(&hook_mutex);
> +       battery_hook_unregister_unlocked(hook);
> +       mutex_unlock(&hook_mutex);
>  }
>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
>
> @@ -750,7 +750,7 @@ void battery_hook_register(struct acpi_battery_hook *=
hook)
>                          * hooks.
>                          */
>                         pr_err("extension failed to load: %s", hook->name=
);
> -                       __battery_hook_unregister(hook, 0);
> +                       battery_hook_unregister_unlocked(hook);
>                         goto end;
>                 }
>
> @@ -804,7 +804,7 @@ static void battery_hook_add_battery(struct acpi_batt=
ery *battery)
>                          */
>                         pr_err("error in extension, unloading: %s",
>                                         hook_node->name);
> -                       __battery_hook_unregister(hook_node, 0);
> +                       battery_hook_unregister_unlocked(hook_node);
>                 }
>         }
>         mutex_unlock(&hook_mutex);
> @@ -837,7 +837,7 @@ static void __exit battery_hook_exit(void)
>          * need to remove the hooks.
>          */
>         list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
> -               __battery_hook_unregister(hook, 1);
> +               battery_hook_unregister(hook);
>         }
>         mutex_destroy(&hook_mutex);
>  }
> --
> 2.39.5
>

