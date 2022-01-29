Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2B4A2C70
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jan 2022 08:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbiA2HWB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 29 Jan 2022 02:22:01 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:49730
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345005AbiA2HWA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 29 Jan 2022 02:22:00 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F9F83F1E0
        for <linux-acpi@vger.kernel.org>; Sat, 29 Jan 2022 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643440912;
        bh=gd0EKd6fDKmy3iDkdc1Y7rY2ChXdjo4gH4LtOs2S/h8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=uTuAlO35XAYomha6SzNdXKUrEMkAzsjd4DBXNZRRZkPwccIGh7E9gkRhJWU2/bPr6
         XXvIQh4t8GplzfnQcspRQsGSudYLoXJ0MbKqkv8jiXsoyGRlEUi2HPQcKYyH7yM33U
         D1eHefCPO1SelPl2LMewe350FqAj/qSf2y7UOYPHqDEBJFFt72tjEsL3cU589YWizd
         HshOZDuuhNr3jd5jc/9Vb38DPXaWETZ3vyF35PENxiZKQz8/BZDyHppZCJqiUG6JRF
         h1Jx36Ca93YZ6Zk8WuiOTiEnDgYvVLP9Bl7BD1+pn8wTBx0nM/D3TUV17ssWztSGC2
         +ckcJ0i7cqrSQ==
Received: by mail-oi1-f199.google.com with SMTP id o130-20020aca5a88000000b002c8dd0d6fa3so4503743oib.18
        for <linux-acpi@vger.kernel.org>; Fri, 28 Jan 2022 23:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd0EKd6fDKmy3iDkdc1Y7rY2ChXdjo4gH4LtOs2S/h8=;
        b=5wzeBpHFApQCNbtvecV5wKQf8jHQFMPtzuB3V7R4jdXXoSkU4tNnqh1Hx3GO053S0L
         Htw7/09ZtvCuomflFdquNq8SBSUYH0W+Avp7IJPt3TqikTOjrS3KtgfBBBwYN7BqPG1y
         ClaP9E+QHuqU2iQ4aZmqLjn9K1HouKuA21pddQXOju/LGsorZIAZfsxYHY0SzU4xO0th
         w9L7uWgmzvpimQYQwNHyOl2myPGRwWgmp1GYUKgtg3XRKGiFPns4Ew+9yxkLGVylFhjn
         ry2vXOsnHOL87AyTJnczEON6TsWOCZC/w+aBk2hHWQ1VjwWuu5kGKywG32t2K82pDtsx
         1lZA==
X-Gm-Message-State: AOAM5333CP0zq25IOWvH/9FdoUl5ci7Uj44evHoJgWWy9fiijiuFNcTS
        6VOQXEtDUNjJQnyKaBrkPWZWgG8BDaLEajXOlDTJ/v4skpihJ5YKPIFxWcJN0WZjQTo0bkhfMPi
        Mg2/XOj/jrzEVTWggLs03rpYMG4qSORKX2VoQn2pgFwGCFa9oD8i9CfI=
X-Received: by 2002:a9d:66c4:: with SMTP id t4mr6898897otm.11.1643440911330;
        Fri, 28 Jan 2022 23:21:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYhFX7ko1UM+PtaCUoW3HdGpmKluBKt8z7LLu0f2CImKdWdpyVoDmyenKBNuXUSzx70knYan/8rstWujAzrDo=
X-Received: by 2002:a9d:66c4:: with SMTP id t4mr6898885otm.11.1643440911041;
 Fri, 28 Jan 2022 23:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20220128203503.17962-1-mario.limonciello@amd.com>
In-Reply-To: <20220128203503.17962-1-mario.limonciello@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Sat, 29 Jan 2022 15:21:37 +0800
Message-ID: <CAAd53p7Z+F3uCRTc8hqssqqmpBEjbZMnEkVpKNEFeEavepDM2Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Revert "Only mark EC GPE for wakeup on Intel systems"
To:     Mario Limonciello <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, acelan.kao@canonical.com,
        Aaron Ma <aaron.ma@canonical.com>,
        Hao-Sheng Lu <kevin.lu@canonical.com>,
        Bhutani Amit <Amit.Bhutani@amd.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Gong Richard <Richard.Gong@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 29, 2022 at 4:34 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Testing on various upcoming OEM systems shows commit 7b167c4cb48e ("ACPI:
> PM: Only mark EC GPE for wakeup on Intel systems") was short
> sighted and the symptoms were indicative of other problems. Some OEMs
> do have the dedicated GPIOs for the power button but also rely upon
> an interrupt to the EC SCI to let the lid work.
>
> The original commit showed spurious activity on Lenovo systems:
>      * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
>        sometimes the power button event doesn't work.
>
> This was confirmed on my end at that time.
>
> However further development in the kernel showed that the issue was
> actually the IRQ for the GPIO controller was also shared with the EC SCI.
> This was actually fixed by commit 2d54067fcd23 ("pinctrl: amd: Fix
> wakeups when IRQ is shared with SCI").
>
> The original commit also showed problems with AC adapter:
>      * On HP 635 G7 detaching or attaching AC during suspend will cause
>        the system not to wakeup
>      * On Asus vivobook to prevent detaching AC causing resume problems
>      * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
>      * On HP ENVY x360  to prevent detaching AC causing resume problems
>
> Detaching AC adapter causing problems appears to have been a problem
> because the EC SCI went off to notify the OS of the power adapter change
> but the SCI was ignored and there was no other way to wake up this system
> since GPIO controller wasn't properly enabled.  The wakeups were fixed by
> enabling the GPIO controller in commit acd47b9f28e5 ("pinctrl: amd: Handle
> wake-up interrupt").
>
> I've confirmed on a variety of OEM notebooks with the following test
> 1) echo 1 | sudo tee /sys/power/pm_debug_messages
> 2) sudo systemctl suspend
> 3) unplug AC adapter, make sure system is still asleep
> 4) wake system from lid (which is provided by ACPI SCI on some of them)
> 5) dmesg
>    a) see the EC GPE dispatched, timekeeping for X seconds (matching ~time
>       until AC adapter plug out)
>    b) see timekeeping for Y seconds until woke (matching ~time from AC
>       adapter until lid event)
> 6) Look at /sys/kernel/debug/amd_pmc/s0ix_stats
>    "Time (in us) in S0i3" = X + Y - firmware processing time
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Fixes LID wakeup on several AMD based HP ProBook and EliteBook.
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/acpi/x86/s2idle.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index a2f16d4ecbae..665a89e2c940 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -427,15 +427,11 @@ static int lps0_device_attach(struct acpi_device *adev,
>                 mem_sleep_current = PM_SUSPEND_TO_IDLE;
>
>         /*
> -        * Some Intel based LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U don't
> -        * use intel-hid or intel-vbtn but require the EC GPE to be enabled while
> -        * suspended for certain wakeup devices to work, so mark it as wakeup-capable.
> -        *
> -        * Only enable on !AMD as enabling this universally causes problems for a number
> -        * of AMD based systems.
> +        * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
> +        * EC GPE to be enabled while suspended for certain wakeup devices to
> +        * work, so mark it as wakeup-capable.
>          */
> -       if (!acpi_s2idle_vendor_amd())
> -               acpi_ec_mark_gpe_for_wake();
> +       acpi_ec_mark_gpe_for_wake();
>
>         return 0;
>  }
> --
> 2.25.1
>
