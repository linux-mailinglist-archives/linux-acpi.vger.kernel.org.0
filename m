Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 725A134D626
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhC2RiJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 13:38:09 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:43632 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhC2Rho (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Mar 2021 13:37:44 -0400
Received: by mail-ot1-f43.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so13009216otn.10;
        Mon, 29 Mar 2021 10:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQhrQowW8xIEfUyJDufAx+rPZsQDmTvEu9++gWrDQO0=;
        b=lo0MuY14nX3KYjW7Tx+q5U9nGHuE6fCw/M0ao8GV7TywU2J7zu54C3BsB+5588PIEg
         dVmQrNOSBuphNzq4NoXEf+0qtikNyNqN5SaY6Rnp2mLTFP48SqyN8MC+T3+rkhSo0y5C
         tFGWh3SEXvucXIs0bcSnBlgrHiBu4OhYPRx/LQtM2WyaAfg8eYc2PU6n/F3DZbl0WRap
         7n4g6niQdjEqmcVy6MxJkAAmzvzcUqZ6c38+IxhZeimd0AzcqZBwkzTEH6dK1q+ocUlW
         2lBz3TgTdeilOS0ncFwPBW9mRQsfBz1xTfDdbi2Np4pJIu43MGZiYY2nJLyq+8uzcxBv
         X/3A==
X-Gm-Message-State: AOAM532NtJ0PJ+9OiZTZFUnAlXLfWuBOzzHVzsnoUiJay7pv+RJ3opAh
        NF6RYhx0JlEFj+f1uTv6cDrppg207fZk2RhvEMs=
X-Google-Smtp-Source: ABdhPJzM1TGowHVgIa6UwFzMtretdTIZcL5OKDWcEZSb1ZAJeFWDuASsX/InfFqyD1VLPpNN83xTsoXxcShEchKt85w=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr23368258otq.260.1617039463407;
 Mon, 29 Mar 2021 10:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210324152219.1456012-1-vkuznets@redhat.com> <CAJZ5v0jFRhgVPtH=NJy9NJ+PGV3OXsEjb3U7_0q6fOLUqYJXZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jFRhgVPtH=NJy9NJ+PGV3OXsEjb3U7_0q6fOLUqYJXZA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 Mar 2021 19:37:32 +0200
Message-ID: <CAJZ5v0g0PcRD=PPMkzM-GNrxpmy4on0RyBE8ujoiDi6TJ6W8KQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Stone <ahs3@redhat.com>, Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 24, 2021 at 4:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 24, 2021 at 4:23 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > Commit 496121c02127 ("ACPI: processor: idle: Allow probing on platforms
> > with one ACPI C-state") broke CPU0 hotplug on certain systems, e.g.
> > I'm observing the following on AWS Nitro (e.g r5b.xlarge but other
> > instance types are affected as well):
> >
> >  # echo 0 > /sys/devices/system/cpu/cpu0/online
> >  # echo 1 > /sys/devices/system/cpu/cpu0/online
> >  <10 seconds delay>
> >  -bash: echo: write error: Input/output error
> >
> > In fact, the above mentioned commit only revealed the problem and did
> > not introduce it. On x86, to wakeup CPU an NMI is being used and
> > hlt_play_dead()/mwait_play_dead() loops are prepared to handle it:
> >
> >         /*
> >          * If NMI wants to wake up CPU0, start CPU0.
> >          */
> >         if (wakeup_cpu0())
> >                 start_cpu0();
> >
> > cpuidle_play_dead() -> acpi_idle_play_dead() (which is now being called on
> > systems where it wasn't called before the above mentioned commit) serves
> > the same purpose but it doesn't have a path for CPU0. What happens now on
> > wakeup is:
> > - NMI is sent to CPU0
> > - wakeup_cpu0_nmi() works as expected
> > - we get back to while (1) loop in acpi_idle_play_dead()
> > - safe_halt() puts CPU0 to sleep again.
> >
> > The straightforward/minimal fix is add the special handling for CPU0 on x86
> > and that's what the patch is doing.
> >
> > Fixes: 496121c02127 ("ACPI: processor: idle: Allow probing on platforms with one ACPI C-state")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> This looks reasonable to me, but I'll give others some time to respond.

No comments, so applied as 5.12-rc material, thanks!

> > ---
> >  arch/x86/include/asm/smp.h    | 1 +
> >  arch/x86/kernel/smpboot.c     | 2 +-
> >  drivers/acpi/processor_idle.c | 7 +++++++
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> > index c0538f82c9a2..57ef2094af93 100644
> > --- a/arch/x86/include/asm/smp.h
> > +++ b/arch/x86/include/asm/smp.h
> > @@ -132,6 +132,7 @@ void native_play_dead(void);
> >  void play_dead_common(void);
> >  void wbinvd_on_cpu(int cpu);
> >  int wbinvd_on_all_cpus(void);
> > +bool wakeup_cpu0(void);
> >
> >  void native_smp_send_reschedule(int cpu);
> >  void native_send_call_func_ipi(const struct cpumask *mask);
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 02813a7f3a7c..f877150a91da 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -1659,7 +1659,7 @@ void play_dead_common(void)
> >         local_irq_disable();
> >  }
> >
> > -static bool wakeup_cpu0(void)
> > +bool wakeup_cpu0(void)
> >  {
> >         if (smp_processor_id() == 0 && enable_start_cpu0)
> >                 return true;
> > diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> > index d93e400940a3..eb1101b16c08 100644
> > --- a/drivers/acpi/processor_idle.c
> > +++ b/drivers/acpi/processor_idle.c
> > @@ -29,6 +29,7 @@
> >   */
> >  #ifdef CONFIG_X86
> >  #include <asm/apic.h>
> > +#include <asm/cpu.h>
> >  #endif
> >
> >  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
> > @@ -541,6 +542,12 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
> >                         wait_for_freeze();
> >                 } else
> >                         return -ENODEV;
> > +
> > +#ifdef CONFIG_X86
> > +               /* If NMI wants to wake up CPU0, start CPU0. */
> > +               if (wakeup_cpu0())
> > +                       start_cpu0();
> > +#endif
> >         }
> >
> >         /* Never reached */
> > --
> > 2.30.2
> >
