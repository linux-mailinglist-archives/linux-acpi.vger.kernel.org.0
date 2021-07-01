Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B6C3B94DE
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jul 2021 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGAQvE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jul 2021 12:51:04 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38448 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGAQvE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jul 2021 12:51:04 -0400
Received: by mail-oi1-f171.google.com with SMTP id t3so8008881oic.5
        for <linux-acpi@vger.kernel.org>; Thu, 01 Jul 2021 09:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWmfrIjC6NGeYGIHT0HaNDsjbNJdlkOi17oHy7aVsOc=;
        b=ETADIu5qZLyd4jlQjEJS//2jdSq6NEM2xHSIhiVmLw4a586Lwf5Lzi8s+fFQ9ZcnNq
         6AJyhkVpKlvf/tBV+NnGkGuzQ/ntQjY72lUo/wcKPCrdLYi5i4FpccITn7jIAZKS8Asn
         nrQWeP8zmdATn+jnKcZfVQ9kGx/GPHK0iniEptISU2OISRiYeyn0BKB4Cz7FmZldlADX
         zxZokyDjaOUq7FZ3VO1ugS2w+0ZS/Cnp0UcBGi/UEQU2bJygg7LAu1uIBr9MoVR1lFv5
         VGaIytMRk5inD8qhHECBieHgJ4QVvq5y+bq2t/X1L2VD1M4lq9YXqZNtxIbwcvEVFfOV
         SQhw==
X-Gm-Message-State: AOAM532nZoMc9lQL+Kab+h6UlAU4Ns6ia8u1Eko/hM3j6/uKmr/oFGVD
        lRKcmwy+XHpi5gpGrjYpwiOIoj4wltvgTW+diGY=
X-Google-Smtp-Source: ABdhPJwPpefHjqAkZrkfnaX0Ivp1W4ae9mkBjuoqMy8Qh+XyCHWRxEFK+9hmOOZpMoSwgxXggxBT7jQBOswoWWv6MPg=
X-Received: by 2002:aca:417:: with SMTP id 23mr339156oie.71.1625158113383;
 Thu, 01 Jul 2021 09:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210630194606.530-1-mario.limonciello@amd.com>
In-Reply-To: <20210630194606.530-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Jul 2021 18:48:22 +0200
Message-ID: <CAJZ5v0jhYL6Qrj5vvU=5FguF=mVryfrBBtgvc8cHzcKkXM_eOg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Only mark EC GPE for wakeup on Intel systems
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Julian Sikorski <belegdol@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 30, 2021 at 9:46 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When using s2idle on a variety of AMD notebook systems, they are
> experiencing spurious events that the EC or SMU are in the wrong
> state leading to a hard time waking up or higher than expected
> power consumption.
>
> These events only occur when the EC GPE is inadvertently set as a wakeup
> source. Originally the EC GPE was only set as a wakeup source when using
> the intel-vbtn or intel-hid drivers in commit 10a08fd65ec1 ("ACPI: PM:
> Set up EC GPE for system wakeup from drivers that need it") but during
> testing a reporter discovered that this was not enough for their ASUS
> Zenbook UX430UNR/i7-8550U to wakeup by lid event or keypress.
> Marking the EC GPE for wakeup universally resolved this for that
> reporter in commit b90ff3554aa3 ("ACPI: PM: s2idle: Always set up EC GPE
> for system wakeup").
>
> However this behavior has lead to a number of problems:
>
> * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
> sometimes the power button event doesn't work.
> * On HP 635 G7 detaching or attaching AC during suspend will cause
> the system not to wakeup
> * On Asus vivobook to prevent detaching AC causing resume problems
> * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
> * On HP ENVY x360  to prevent detaching AC causing resume problems
>
> As there may be other Intel systems besides ASUS Zenbook UX430UNR/i7-8550U
> that don't use intel-vbtn or intel-hid avoid these problems by only
> universally marking the EC GPE wakesource on non-AMD systems.
>
> Link: https://patchwork.kernel.org/project/linux-pm/cover/5997740.FPbUVk04hV@kreacher/#22825489
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1629
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 816bf2c34b7a..1c507804fb10 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -417,11 +417,15 @@ static int lps0_device_attach(struct acpi_device *adev,
>                 mem_sleep_current = PM_SUSPEND_TO_IDLE;
>
>         /*
> -        * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
> -        * EC GPE to be enabled while suspended for certain wakeup devices to
> -        * work, so mark it as wakeup-capable.
> +        * Some Intel based LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U don't
> +        * use intel-hid or intel-vbtn but require the EC GPE to be enabled while
> +        * suspended for certain wakeup devices to work, so mark it as wakeup-capable.
> +        *
> +        * Only enable on !AMD as enabling this universally causes problems for a number
> +        * of AMD based systems.
>          */
> -       acpi_ec_mark_gpe_for_wake();
> +       if (!acpi_s2idle_vendor_amd())
> +               acpi_ec_mark_gpe_for_wake();
>
>         return 0;
>  }
> --

Applied as 5.14-rc1 material, thanks!
