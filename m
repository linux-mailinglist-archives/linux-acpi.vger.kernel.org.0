Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48D4AC9F9
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Feb 2022 21:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiBGT7q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Feb 2022 14:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiBGT4r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Feb 2022 14:56:47 -0500
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426CBC0401E1
        for <linux-acpi@vger.kernel.org>; Mon,  7 Feb 2022 11:56:47 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id bt13so19392631ybb.2
        for <linux-acpi@vger.kernel.org>; Mon, 07 Feb 2022 11:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxB6U9DTiuctjyDyUB8zBpepioQV5IrAufyIJgFahFw=;
        b=Lja0Yu7/n9s4WRt0NlFk4nfBRKIllLjA21P4KHTANu7wE/LHYbkgXlGjVuFSyJz9rb
         oVu/bTm5YYSnGEqH1r0IyXsodHvCVWHFOacd1gfC9DWpBs1Vpt/ww9xBRCdOWPjTvaE2
         9IBtdahUD4xOF/JADNgFKRJN2zCGGPnIVmfWpBhtuCvaq3e8N7sO3jJQMxqEZxwhPQ9q
         GqKdvJiso6RsVRmTuOdAz8aRy4fdl8NPp7FKJNizNOc2I54MQhMrkopY9rVta8U5jeKm
         zsCkkya4f/eRxNuxIXlkTg17GlJcvypB7VeIlmZ92Mn8PvmbtfP0c7XXeuelZKcYYB/D
         lj7Q==
X-Gm-Message-State: AOAM53288ICLe8ubuAiSXyhBqeTpvn4rORp1VdgD46fctc8wSrZ8qsO+
        pBPYVi4/ozcy0tcqWhGJNapGOkVEQNwo5iXJlBY=
X-Google-Smtp-Source: ABdhPJyzDTnToe83C/Zf6mQAr9k3OOcDaOIZBpskDtut6hXYcCtPQms0ZUAF+kuw6nRxrT68wLalPKtEBdeYrU9zaOM=
X-Received: by 2002:a25:180a:: with SMTP id 10mr1495450yby.552.1644263806479;
 Mon, 07 Feb 2022 11:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20220128203503.17962-1-mario.limonciello@amd.com> <CAAd53p7Z+F3uCRTc8hqssqqmpBEjbZMnEkVpKNEFeEavepDM2Q@mail.gmail.com>
In-Reply-To: <CAAd53p7Z+F3uCRTc8hqssqqmpBEjbZMnEkVpKNEFeEavepDM2Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Feb 2022 20:56:35 +0100
Message-ID: <CAJZ5v0j+Skyu91+ODTHr+AhfU1S2ici43mYbo2R40d0y=sEOTg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Revert "Only mark EC GPE for wakeup on Intel systems"
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <Mario.Limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        Hao-Sheng Lu <kevin.lu@canonical.com>,
        Bhutani Amit <Amit.Bhutani@amd.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Gong Richard <Richard.Gong@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 29, 2022 at 8:22 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> On Sat, Jan 29, 2022 at 4:34 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Testing on various upcoming OEM systems shows commit 7b167c4cb48e ("ACPI:
> > PM: Only mark EC GPE for wakeup on Intel systems") was short
> > sighted and the symptoms were indicative of other problems. Some OEMs
> > do have the dedicated GPIOs for the power button but also rely upon
> > an interrupt to the EC SCI to let the lid work.
> >
> > The original commit showed spurious activity on Lenovo systems:
> >      * On both Lenovo T14 and P14s the keyboard wakeup doesn't work, and
> >        sometimes the power button event doesn't work.
> >
> > This was confirmed on my end at that time.
> >
> > However further development in the kernel showed that the issue was
> > actually the IRQ for the GPIO controller was also shared with the EC SCI.
> > This was actually fixed by commit 2d54067fcd23 ("pinctrl: amd: Fix
> > wakeups when IRQ is shared with SCI").
> >
> > The original commit also showed problems with AC adapter:
> >      * On HP 635 G7 detaching or attaching AC during suspend will cause
> >        the system not to wakeup
> >      * On Asus vivobook to prevent detaching AC causing resume problems
> >      * On Lenovo 14ARE05 to prevent detaching AC causing resume problems
> >      * On HP ENVY x360  to prevent detaching AC causing resume problems
> >
> > Detaching AC adapter causing problems appears to have been a problem
> > because the EC SCI went off to notify the OS of the power adapter change
> > but the SCI was ignored and there was no other way to wake up this system
> > since GPIO controller wasn't properly enabled.  The wakeups were fixed by
> > enabling the GPIO controller in commit acd47b9f28e5 ("pinctrl: amd: Handle
> > wake-up interrupt").
> >
> > I've confirmed on a variety of OEM notebooks with the following test
> > 1) echo 1 | sudo tee /sys/power/pm_debug_messages
> > 2) sudo systemctl suspend
> > 3) unplug AC adapter, make sure system is still asleep
> > 4) wake system from lid (which is provided by ACPI SCI on some of them)
> > 5) dmesg
> >    a) see the EC GPE dispatched, timekeeping for X seconds (matching ~time
> >       until AC adapter plug out)
> >    b) see timekeeping for Y seconds until woke (matching ~time from AC
> >       adapter until lid event)
> > 6) Look at /sys/kernel/debug/amd_pmc/s0ix_stats
> >    "Time (in us) in S0i3" = X + Y - firmware processing time
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Fixes LID wakeup on several AMD based HP ProBook and EliteBook.
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied as 5.17-rc material, thanks!

> > ---
> >  drivers/acpi/x86/s2idle.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index a2f16d4ecbae..665a89e2c940 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -427,15 +427,11 @@ static int lps0_device_attach(struct acpi_device *adev,
> >                 mem_sleep_current = PM_SUSPEND_TO_IDLE;
> >
> >         /*
> > -        * Some Intel based LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U don't
> > -        * use intel-hid or intel-vbtn but require the EC GPE to be enabled while
> > -        * suspended for certain wakeup devices to work, so mark it as wakeup-capable.
> > -        *
> > -        * Only enable on !AMD as enabling this universally causes problems for a number
> > -        * of AMD based systems.
> > +        * Some LPS0 systems, like ASUS Zenbook UX430UNR/i7-8550U, require the
> > +        * EC GPE to be enabled while suspended for certain wakeup devices to
> > +        * work, so mark it as wakeup-capable.
> >          */
> > -       if (!acpi_s2idle_vendor_amd())
> > -               acpi_ec_mark_gpe_for_wake();
> > +       acpi_ec_mark_gpe_for_wake();
> >
> >         return 0;
> >  }
> > --
> > 2.25.1
> >
