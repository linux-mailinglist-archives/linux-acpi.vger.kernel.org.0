Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AFA454A99
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 17:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhKQQNb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 11:13:31 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34310 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhKQQNa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2021 11:13:30 -0500
Received: by mail-oi1-f175.google.com with SMTP id t19so7490277oij.1;
        Wed, 17 Nov 2021 08:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOEXESk6lj7pFbgH3Rb2tc9y9z0BXP+Lu7a0SxVQzLA=;
        b=xNMMV1DZUBjmZguNO16T0lm7vnk7WAdoZ1qPmMJTEzSZ1ZhNhG8U76qPTnZZacPNOS
         TyV66SFCtuhRaAp47hBbUjCRybVxWVLBzv52d4dBnJ/rb0rh9p2sPTPLImUl0YMmXjfd
         XeF8D6kvsgPZN5iodd4eWWECwy8IwB4+MiAcDbmzn7vWUh9bRcx4c1JPUBKPww+k9fGx
         krkczQsVGViW5F1pQJlHtwrWMOFInEB+eh/KA7ss4IYxeFXEU+83pcF4B5fxb2jqti55
         nGJBRjILMhBBK/JZCwcn/wFzPny8ETtYzgZFelwlbIzEMYl4Yh/40PXvIn9ZXzsD1rZ4
         p2kA==
X-Gm-Message-State: AOAM533PlS3JdPfME/uDknqEl3zcpq0aVzwN5quZBmKso6KHG4mNgSWE
        FFm7ZBKhtxMOxd7h+jZTm8ZPOfjPLe1GNVKOPAmtvNisKiM=
X-Google-Smtp-Source: ABdhPJy8mJxyxGg3fPTO39SNRDjOj9djNOD2S81KTSqeyK+b+LfBicxet7XK4sZ3VSSPkVTZ2l0418ww9kq+v7tpKnQ=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr771360oiw.154.1637165431095;
 Wed, 17 Nov 2021 08:10:31 -0800 (PST)
MIME-Version: 1.0
References: <2623493.mvXUDI8C0e@kreacher>
In-Reply-To: <2623493.mvXUDI8C0e@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Nov 2021 17:10:20 +0100
Message-ID: <CAJZ5v0hxzcxuQ596LncMKF-kTaOpfPXUFkKUt1GT3Cm4nR9yqw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Avoid removing power from unused hardware too early
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Kyle D. Pelton" <kyle.d.pelton@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2021 at 8:53 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
> unused objects") causes power to be removed from some hardware
> resources that appear to be unused too early, which leads to boot
> issues on some systems.
>
> To address this, move putting the unused ACPI device objects into
> D3cold to a late initcall.
>
> Fixes: c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by unused objects")
> Reported-by: Kyle D. Pelton <kyle.d.pelton@intel.com>
> Tested-by: Kyle D. Pelton <kyle.d.pelton@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Unfortunately, this fix is not effective in some cases, so I'm going
to revert commit c10383e8ddf4 for 5.16 and revisit this later.

Thanks!

> ---
>  drivers/acpi/scan.c |   22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -2559,12 +2559,6 @@ int __init acpi_scan_init(void)
>                 }
>         }
>
> -       /*
> -        * Make sure that power management resources are not blocked by ACPI
> -        * device objects with no users.
> -        */
> -       bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
> -
>         acpi_turn_off_unused_power_resources();
>
>         acpi_scan_initialized = true;
> @@ -2574,6 +2568,22 @@ int __init acpi_scan_init(void)
>         return result;
>  }
>
> +static int acpi_turn_off_unused_devices(void)
> +{
> +       mutex_lock(&acpi_scan_lock);
> +
> +       /*
> +        * Make sure that power management resources are not blocked by ACPI
> +        * device objects with no users.
> +        */
> +       bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
> +
> +       mutex_unlock(&acpi_scan_lock);
> +
> +       return 0;
> +}
> +late_initcall(acpi_turn_off_unused_devices);
> +
>  static struct acpi_probe_entry *ape;
>  static int acpi_probe_count;
>  static DEFINE_MUTEX(acpi_probe_mutex);
>
>
>
