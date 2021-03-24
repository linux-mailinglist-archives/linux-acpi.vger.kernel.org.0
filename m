Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE45E347CC8
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 16:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhCXPh1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 11:37:27 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45653 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbhCXPhQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 11:37:16 -0400
Received: by mail-ot1-f44.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so2098651oty.12;
        Wed, 24 Mar 2021 08:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5isp94cnzEOtV1H4N6eT1OECLoyIrbr/DPOQ/Wd8FCE=;
        b=Fe+m5wTQW5t8zPRvycKWi1M2s2BJZk/elDkZEzYxX54VDMNSVh+a+7S1gb1Gqva0S5
         Y+oa/ZGAr5Sj3nz9yydm2V4ZCs8zL7loquRumkz+2j8SEECe3p6IfcdAyJ4IXKwtuS9m
         DyGS0kXpboZGwij4VifVy6hyFHLt1NkvHlriCAT8DpBid8a7MUbsSkBJXmv28lzdZvHU
         67mf7YWH8qWpqWa73MrAOyl3n1qFtiZx6nVZsBaAy74a9czXpVav9WbBRJXEbx310HBO
         MYUQkC3l40zEpAxgZRjgWx3RUEM3XQ/gocUuY+uU425uIGq8c+DfLkrFOpWw7szrBG+x
         Pozw==
X-Gm-Message-State: AOAM533w3OI3OtAO+AvfHhPYj5+r51sJD+J9vX+zmeqN+7ttQlbbgSR4
        d04Rwmu5Wp+B0W5WfnMfH/atee/YnpcSaMbbQ0g=
X-Google-Smtp-Source: ABdhPJxB4O2PYpT/ShUr3YRn+rzbAqjNiZK2WCJ0fZSyuhIz3smvOaMigWBny1mRClWBvAypmC+gcN7OMBRAmnBB9HE=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr3782893otr.321.1616600235492;
 Wed, 24 Mar 2021 08:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210324152219.1456012-1-vkuznets@redhat.com>
In-Reply-To: <20210324152219.1456012-1-vkuznets@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Mar 2021 16:37:04 +0100
Message-ID: <CAJZ5v0jFRhgVPtH=NJy9NJ+PGV3OXsEjb3U7_0q6fOLUqYJXZA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Fix CPU0 wakeup in acpi_idle_play_dead()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Wed, Mar 24, 2021 at 4:23 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Commit 496121c02127 ("ACPI: processor: idle: Allow probing on platforms
> with one ACPI C-state") broke CPU0 hotplug on certain systems, e.g.
> I'm observing the following on AWS Nitro (e.g r5b.xlarge but other
> instance types are affected as well):
>
>  # echo 0 > /sys/devices/system/cpu/cpu0/online
>  # echo 1 > /sys/devices/system/cpu/cpu0/online
>  <10 seconds delay>
>  -bash: echo: write error: Input/output error
>
> In fact, the above mentioned commit only revealed the problem and did
> not introduce it. On x86, to wakeup CPU an NMI is being used and
> hlt_play_dead()/mwait_play_dead() loops are prepared to handle it:
>
>         /*
>          * If NMI wants to wake up CPU0, start CPU0.
>          */
>         if (wakeup_cpu0())
>                 start_cpu0();
>
> cpuidle_play_dead() -> acpi_idle_play_dead() (which is now being called on
> systems where it wasn't called before the above mentioned commit) serves
> the same purpose but it doesn't have a path for CPU0. What happens now on
> wakeup is:
> - NMI is sent to CPU0
> - wakeup_cpu0_nmi() works as expected
> - we get back to while (1) loop in acpi_idle_play_dead()
> - safe_halt() puts CPU0 to sleep again.
>
> The straightforward/minimal fix is add the special handling for CPU0 on x86
> and that's what the patch is doing.
>
> Fixes: 496121c02127 ("ACPI: processor: idle: Allow probing on platforms with one ACPI C-state")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

This looks reasonable to me, but I'll give others some time to respond.

> ---
>  arch/x86/include/asm/smp.h    | 1 +
>  arch/x86/kernel/smpboot.c     | 2 +-
>  drivers/acpi/processor_idle.c | 7 +++++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index c0538f82c9a2..57ef2094af93 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -132,6 +132,7 @@ void native_play_dead(void);
>  void play_dead_common(void);
>  void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
> +bool wakeup_cpu0(void);
>
>  void native_smp_send_reschedule(int cpu);
>  void native_send_call_func_ipi(const struct cpumask *mask);
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 02813a7f3a7c..f877150a91da 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1659,7 +1659,7 @@ void play_dead_common(void)
>         local_irq_disable();
>  }
>
> -static bool wakeup_cpu0(void)
> +bool wakeup_cpu0(void)
>  {
>         if (smp_processor_id() == 0 && enable_start_cpu0)
>                 return true;
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index d93e400940a3..eb1101b16c08 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -29,6 +29,7 @@
>   */
>  #ifdef CONFIG_X86
>  #include <asm/apic.h>
> +#include <asm/cpu.h>
>  #endif
>
>  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
> @@ -541,6 +542,12 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
>                         wait_for_freeze();
>                 } else
>                         return -ENODEV;
> +
> +#ifdef CONFIG_X86
> +               /* If NMI wants to wake up CPU0, start CPU0. */
> +               if (wakeup_cpu0())
> +                       start_cpu0();
> +#endif
>         }
>
>         /* Never reached */
> --
> 2.30.2
>
