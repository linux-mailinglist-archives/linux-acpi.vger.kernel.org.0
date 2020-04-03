Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3172119DA75
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Apr 2020 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgDCPpX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Apr 2020 11:45:23 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34128 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgDCPpX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Apr 2020 11:45:23 -0400
Received: by mail-ot1-f66.google.com with SMTP id m2so7738703otr.1;
        Fri, 03 Apr 2020 08:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0OlPmNS9dHURUW1j/GP8nWFfBJCMF/4MX3QGW5VBkAY=;
        b=pr3XatD/u0bflYOqdv4naKRHo5cXjvZ020DJ3K6CodtyVHVfWEseNiA6YhKl8A6gJO
         3FPOVfRN7ZPx1fy8H3gKDvtebQGYRXnOZ4WBRse1FJ4lIspLJScbR4FmTiFsgV4zStEV
         6F2+7Zd7xgEIOcTAu8DD6lNVM9Z2KDr9CP9bFbgorL9W8sDeln6yPZl4Sby3y+K0qiM1
         oiGY1ial5pjnxno89VTrpEngOOGBRMzf+MAraHbAUtL9fC7nQniPuhbRn/UHkG+vPYeH
         3WXpdx8b8nj+g55BmVKC+EUdWalNj1kO3e+AXtFPpa0i+1m7iGIZhz1ZNrBbgOrf8hTt
         DdyA==
X-Gm-Message-State: AGi0PuZxztcTWja6s3OOyIpT7EhRtWfHdlfoyo3hpWpxJiPpUs+7INci
        hs/rB5g/y+SxgtmY8LivjRugxfcUoi/UPlPrZZEBOw==
X-Google-Smtp-Source: APiQypKQ9Xp8nVHgM9+0xGucPJq4E+PtvuvYZbbCag4WBSihL1keZIQUi+fwlcVCwlz+1SIf8dFIIwlkqu7iL3CyLCQ=
X-Received: by 2002:a9d:750a:: with SMTP id r10mr6596381otk.118.1585928721634;
 Fri, 03 Apr 2020 08:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200403140345.3828-1-cai@lca.pw>
In-Reply-To: <20200403140345.3828-1-cai@lca.pw>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Apr 2020 17:45:10 +0200
Message-ID: <CAJZ5v0jjZzSosFwR3Yqu9mWtUNms1u9fbJbQb=tc5=CPc7r_1w@mail.gmail.com>
Subject: Re: [PATCH v3] x86/acpi: fix a deadlock with cpu hotplug
To:     Qian Cai <cai@lca.pw>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 3, 2020 at 4:04 PM Qian Cai <cai@lca.pw> wrote:
>
> Similar to the commit 0266d81e9bf5 ("acpi/processor: Prevent cpu hotplug
> deadlock") except this is for acpi_processor_ffh_cstate_probe():
>
> "The problem is that the work is scheduled on the current CPU from the
> hotplug thread associated with that CPU.
>
> It's not required to invoke these functions via the workqueue because
> the hotplug thread runs on the target CPU already.
>
> Check whether current is a per cpu thread pinned on the target CPU and
> invoke the function directly to avoid the workqueue."
>
>  WARNING: possible circular locking dependency detected
>  ------------------------------------------------------
>  cpuhp/1/15 is trying to acquire lock:
>  ffffc90003447a28 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: __flush_work+0x4c6/0x630
>
>  but task is already holding lock:
>  ffffffffafa1c0e8 (cpuidle_lock){+.+.}-{3:3}, at: cpuidle_pause_and_lock+0x17/0x20
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
>  -> #1 (cpu_hotplug_lock){++++}-{0:0}:
>  cpus_read_lock+0x3e/0xc0
>  irq_calc_affinity_vectors+0x5f/0x91
>  __pci_enable_msix_range+0x10f/0x9a0
>  pci_alloc_irq_vectors_affinity+0x13e/0x1f0
>  pci_alloc_irq_vectors_affinity at drivers/pci/msi.c:1208
>  pqi_ctrl_init+0x72f/0x1618 [smartpqi]
>  pqi_pci_probe.cold.63+0x882/0x892 [smartpqi]
>  local_pci_probe+0x7a/0xc0
>  work_for_cpu_fn+0x2e/0x50
>  process_one_work+0x57e/0xb90
>  worker_thread+0x363/0x5b0
>  kthread+0x1f4/0x220
>  ret_from_fork+0x27/0x50
>
>  -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
>  __lock_acquire+0x2244/0x32a0
>  lock_acquire+0x1a2/0x680
>  __flush_work+0x4e6/0x630
>  work_on_cpu+0x114/0x160
>  acpi_processor_ffh_cstate_probe+0x129/0x250
>  acpi_processor_evaluate_cst+0x4c8/0x580
>  acpi_processor_get_power_info+0x86/0x740
>  acpi_processor_hotplug+0xc3/0x140
>  acpi_soft_cpu_online+0x102/0x1d0
>  cpuhp_invoke_callback+0x197/0x1120
>  cpuhp_thread_fun+0x252/0x2f0
>  smpboot_thread_fn+0x255/0x440
>  kthread+0x1f4/0x220
>  ret_from_fork+0x27/0x50
>
>  other info that might help us debug this:
>
>  Chain exists of:
>  (work_completion)(&wfc.work) --> cpuhp_state-up --> cpuidle_lock
>
>  Possible unsafe locking scenario:
>
>  CPU0                    CPU1
>  ----                    ----
>  lock(cpuidle_lock);
>                          lock(cpuhp_state-up);
>                          lock(cpuidle_lock);
>  lock((work_completion)(&wfc.work));
>
>  *** DEADLOCK ***
>
>  3 locks held by cpuhp/1/15:
>  #0: ffffffffaf51ab10 (cpu_hotplug_lock){++++}-{0:0}, at: cpuhp_thread_fun+0x69/0x2f0
>  #1: ffffffffaf51ad40 (cpuhp_state-up){+.+.}-{0:0}, at: cpuhp_thread_fun+0x69/0x2f0
>  #2: ffffffffafa1c0e8 (cpuidle_lock){+.+.}-{3:3}, at: cpuidle_pause_and_lock+0x17/0x20
>
>  Call Trace:
>  dump_stack+0xa0/0xea
>  print_circular_bug.cold.52+0x147/0x14c
>  check_noncircular+0x295/0x2d0
>  __lock_acquire+0x2244/0x32a0
>  lock_acquire+0x1a2/0x680
>  __flush_work+0x4e6/0x630
>  work_on_cpu+0x114/0x160
>  acpi_processor_ffh_cstate_probe+0x129/0x250
>  acpi_processor_evaluate_cst+0x4c8/0x580
>  acpi_processor_get_power_info+0x86/0x740
>  acpi_processor_hotplug+0xc3/0x140
>  acpi_soft_cpu_online+0x102/0x1d0
>  cpuhp_invoke_callback+0x197/0x1120
>  cpuhp_thread_fun+0x252/0x2f0
>  smpboot_thread_fn+0x255/0x440
>  kthread+0x1f4/0x220
>  ret_from_fork+0x27/0x50
>
> Signed-off-by: Qian Cai <cai@lca.pw>

I can take this one unless there are objections or concerns.

> ---
>
> v3:
> Remove #ifdef since cstate.o should rather depend on ACPI_PROCESSOR_IDLE
> per Rafael.
>
> v2:
> Make call_on_cpu() a static inline function to avoid a compilation
> error when ACPI_PROCESSOR=m thanks to lkp@intel.com.
>
>  arch/x86/kernel/acpi/cstate.c       | 3 ++-
>  drivers/acpi/processor_throttling.c | 7 -------
>  include/acpi/processor.h            | 8 ++++++++
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index caf2edccbad2..49ae4e1ac9cd 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -161,7 +161,8 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
>
>         /* Make sure we are running on right CPU */
>
> -       retval = work_on_cpu(cpu, acpi_processor_ffh_cstate_probe_cpu, cx);
> +       retval = call_on_cpu(cpu, acpi_processor_ffh_cstate_probe_cpu, cx,
> +                            false);
>         if (retval == 0) {
>                 /* Use the hint in CST */
>                 percpu_entry->states[cx->index].eax = cx->address;
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index 532a1ae3595a..a0bd56ece3ff 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -897,13 +897,6 @@ static long __acpi_processor_get_throttling(void *data)
>         return pr->throttling.acpi_processor_get_throttling(pr);
>  }
>
> -static int call_on_cpu(int cpu, long (*fn)(void *), void *arg, bool direct)
> -{
> -       if (direct || (is_percpu_thread() && cpu == smp_processor_id()))
> -               return fn(arg);
> -       return work_on_cpu(cpu, fn, arg);
> -}
> -
>  static int acpi_processor_get_throttling(struct acpi_processor *pr)
>  {
>         if (!pr)
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 47805172e73d..683e124ad517 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -297,6 +297,14 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
>  }
>  #endif
>
> +static inline int call_on_cpu(int cpu, long (*fn)(void *), void *arg,
> +                             bool direct)
> +{
> +       if (direct || (is_percpu_thread() && cpu == smp_processor_id()))
> +               return fn(arg);
> +       return work_on_cpu(cpu, fn, arg);
> +}
> +
>  /* in processor_perflib.c */
>
>  #ifdef CONFIG_CPU_FREQ
> --
> 2.21.0 (Apple Git-122.2)
>
