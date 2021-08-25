Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA33F7BCB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Aug 2021 19:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhHYRzY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Aug 2021 13:55:24 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:40675 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhHYRzX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Aug 2021 13:55:23 -0400
Received: by mail-oo1-f52.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so58864ooh.7;
        Wed, 25 Aug 2021 10:54:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=df/OerwKAWPLPQITF2yDRoTeJU9NwWh+Y/yCNdwz/ko=;
        b=I4vFIBZiZ0IVvOBOtgacSGIl3cwGeMfk3O6X5UJweFgZOK4YYqgFrJ/XBskc1XRBeB
         mxcvE71JWAQDa0lmMF0gzo4HuwYbrr8yKVjt5E7I0CFAjYI8K0AgwNP39KIpntnb2/0d
         1Al2cxDThdOVwQnTgsdh/R5RP8ti51SzfBibD9GxFFKE08hWV9OPUXmy9Jz/xfhi5Ev/
         zaefV40IKH/sKIEdPHo5Mnxpvh8Xo2/C5AhQ4amGZDlRa+eBwm1DxqSAmSeHRBOmxTu5
         eXQRhrZg/BcS8e+Y4Bi1l6sVcmUkpUw81MPjfdZ5jJn2/TRwW8SrjffzuAyTlPqZ98XQ
         /2fA==
X-Gm-Message-State: AOAM530wgZNyl5Xaan0rNDtxdyC/FnPzIPaf4tBBBIfO+Q/SCyBm6v5I
        e8tKNj+UwESM2kh0oZ/jwgZ3hnldtBgBfDWBWcw=
X-Google-Smtp-Source: ABdhPJw0iO5RUl0kIcWZiNbqkCp6fjYKpiq2CzB1BUVvZZmUvvEDmlByZS3c3GeJtyQMOY+XgXbVv0pa4d6u50r6jFY=
X-Received: by 2002:a4a:a552:: with SMTP id s18mr35593004oom.1.1629914077598;
 Wed, 25 Aug 2021 10:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210824105651.28660-1-ionela.voinescu@arm.com> <20210824105651.28660-3-ionela.voinescu@arm.com>
In-Reply-To: <20210824105651.28660-3-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 19:54:26 +0200
Message-ID: <CAJZ5v0hkgWQqOzfdv4kr6rxz9eMsOgHkMYj0cZpO7yC+=SnQfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arch_topology: obtain cpu capacity using
 information from CPPC
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 24, 2021 at 12:57 PM Ionela Voinescu
<ionela.voinescu@arm.com> wrote:
>
> Define topology_init_cpu_capacity_cppc() to use highest performance
> values from _CPC objects to obtain and set maximum capacity information
> for each CPU. acpi_cppc_processor_probe() is a good point at which to
> trigger the initialization of CPU (u-arch) capacity values, as at this
> point the highest performance values can be obtained from each CPU's
> _CPC objects. Architectures can therefore use this functionality
> through arch_init_invariance_cppc().
>
> The performance scale used by CPPC is a unified scale for all CPUs in
> the system. Therefore, by obtaining the raw highest performance values
> from the _CPC objects, and normalizing them on the [0, 1024] capacity
> scale, used by the task scheduler, we obtain the CPU capacity of each
> CPU.
>
> While an ACPI Notify(0x85) could alert about a change in the highest
> performance value, which should in turn retrigger the CPU capacity
> computations, this notification is not currently handled by the ACPI
> processor driver. When supported, a call to arch_init_invariance_cppc()
> would perform the update.
>
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/arch_topology.c  | 37 +++++++++++++++++++++++++++++++++++
>  include/linux/arch_topology.h |  4 ++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 921312a8d957..358e22cd629e 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -306,6 +306,43 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>         return !ret;
>  }
>
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +#include <acpi/cppc_acpi.h>
> +
> +void topology_init_cpu_capacity_cppc(void)
> +{
> +       struct cppc_perf_caps perf_caps;
> +       int cpu;
> +
> +       if (likely(acpi_disabled || !acpi_cpc_valid()))
> +               return;
> +
> +       raw_capacity = kcalloc(num_possible_cpus(), sizeof(*raw_capacity),
> +                              GFP_KERNEL);
> +       if (!raw_capacity)
> +               return;
> +
> +       for_each_possible_cpu(cpu) {
> +               if (!cppc_get_perf_caps(cpu, &perf_caps)) {
> +                       raw_capacity[cpu] = perf_caps.highest_perf;

From experience, I would advise doing some sanity checking on the
per_caps values before using them here.

Also note that highest_perf may not be sustainable, so would using
highest_perf as raw_capacity[] always work as expected?

> +                       pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
> +                                cpu, raw_capacity[cpu]);
> +               } else {
> +                       pr_err("cpu_capacity: CPU%d missing highest performance.\n", cpu);
> +                       pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
> +                       goto exit;
> +               }
> +       }
> +
> +       topology_normalize_cpu_scale();
> +       schedule_work(&update_topology_flags_work);
> +       pr_debug("cpu_capacity: cpu_capacity initialization done\n");
> +
> +exit:
> +       free_raw_capacity();
> +}
> +#endif
> +
>  #ifdef CONFIG_CPU_FREQ
>  static cpumask_var_t cpus_to_visit;
>  static void parsing_done_workfn(struct work_struct *work);
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index f180240dc95f..9cf1a17938f0 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -11,6 +11,10 @@
>  void topology_normalize_cpu_scale(void);
>  int topology_update_cpu_topology(void);
>
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +void topology_init_cpu_capacity_cppc(void);
> +#endif
> +
>  struct device_node;
>  bool topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
>
> --
> 2.29.2.dirty
>
