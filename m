Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0288A30DC5A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 15:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhBCOMb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 09:12:31 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:40989 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhBCOMa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 09:12:30 -0500
Received: by mail-oi1-f172.google.com with SMTP id m13so26802558oig.8;
        Wed, 03 Feb 2021 06:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9ddqgzFC/SZO6LcLdybWIESwjtMUBkI/PLFuncKY08=;
        b=ISVd+s0zY9ybLogszykFXh6ucbj2JQPklXMrky4ol6OXe/Of8+lvPYkLkGcBckuEXQ
         15+1+k+Ej7cDilluoUkU6lakMsBzut3+SMYG+n6huREVii+lAYUADrr35KhqyLRhLu6C
         GhDB2LitsUsSjnkqcZqsze88PmYgGpa+gZFmJiT2V0V4H3JuvEc3dmRWbPfwaKrdbo5H
         8+m78N35PaOmgunUPyz7z8QV2rVKgcieXrsAMATSYG4pcS7qPHS4kTPIvorPE9dHcywc
         huUMs20sGh/QHXswkdNelp1MrRQuabu+kUwnqXKRGc6y2NMSF892/rf74e5TAMnWAM3P
         za+A==
X-Gm-Message-State: AOAM5334uY88XpTU7Y0VD81JwrkE6CIUmZX35en6R9C92XfZn4zKl5Bs
        CcE8NrOmvIh3fdzsCRBJCC7dFC8f4Y1y+m4/idM=
X-Google-Smtp-Source: ABdhPJwqxsTTzb4IEEfpmwJUAb1fAaIb7+JNDrqajYj4O7cUdqU84yofMbf21jTrBvyYcI4gC5vrzpTNcdH/629pnZY=
X-Received: by 2002:aca:d14:: with SMTP id 20mr2105841oin.157.1612361508548;
 Wed, 03 Feb 2021 06:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20210203135321.12253-1-ggherdovich@suse.cz> <20210203135321.12253-2-ggherdovich@suse.cz>
In-Reply-To: <20210203135321.12253-2-ggherdovich@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Feb 2021 15:11:37 +0100
Message-ID: <CAJZ5v0g1SWRnV1QfZG3o+hvBg9akakhDMomGCFjwERyG2ENKww@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] x86,sched: On AMD EPYC set freq_max = max_boost in
 schedutil invariant formula
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jon Grimm <Jon.Grimm@amd.com>,
        Nathan Fontenot <Nathan.Fontenot@amd.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pu Wen <puwen@hygon.cn>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Larabel <Michael@phoronix.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 3, 2021 at 2:53 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>

[cut]

> Fixes: 41ea667227ba ("x86, sched: Calculate frequency invariance for AMD systems")
> Fixes: 976df7e5730e ("x86, sched: Use midpoint of max_boost and max_P for frequency invariance on AMD EPYC")
> Reported-by: Michael Larabel <Michael@phoronix.com>
> Tested-by: Michael Larabel <Michael@phoronix.com>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>  drivers/cpufreq/acpi-cpufreq.c   | 61 ++++++++++++++++++++++++++++++--
>  drivers/cpufreq/cpufreq.c        |  3 ++
>  include/linux/cpufreq.h          |  5 +++
>  kernel/sched/cpufreq_schedutil.c |  8 +++--

I don't really think that it is necessary to modify schedutil to
address this issue.

>  4 files changed, 73 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 1e4fbb002a31..a5facc6cad16 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/uaccess.h>
>
>  #include <acpi/processor.h>
> +#include <acpi/cppc_acpi.h>
>
>  #include <asm/msr.h>
>  #include <asm/processor.h>
> @@ -628,11 +629,57 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
>  }
>  #endif
>
> +#ifdef CONFIG_ACPI_CPPC_LIB
> +static bool amd_max_boost(unsigned int max_freq,
> +                         unsigned int *max_boost)

Is there anything specific to AMD CPUs in this function?

> +{
> +       struct cppc_perf_caps perf_caps;
> +       u64 highest_perf, nominal_perf, perf_ratio;
> +       int ret;
> +
> +       ret = cppc_get_perf_caps(0, &perf_caps);
> +       if (ret) {
> +               pr_debug("Could not retrieve perf counters (%d)\n", ret);
> +               return false;
> +       }
> +
> +       highest_perf = perf_caps.highest_perf;
> +       nominal_perf = perf_caps.nominal_perf;
> +
> +       if (!highest_perf || !nominal_perf) {
> +               pr_debug("Could not retrieve highest or nominal performance\n");
> +               return false;
> +       }
> +
> +       perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);

Why do you use SCHED_CAPACITY_SCALE here?  And why does this multiply
instead of shifting?

> +       if (perf_ratio <= SCHED_CAPACITY_SCALE) {
> +               pr_debug("Either perf_ratio is 0, or nominal >= highest performance\n");
> +               return false;
> +       }
> +
> +       *max_boost = max_freq * perf_ratio >> SCHED_CAPACITY_SHIFT;

Is this assuming that max_freq corresponds to nominal_perf?

> +       if (!*max_boost) {
> +               pr_debug("max_boost seems to be zero\n");
> +               return false;

So this function may just return the max_boost value with 0 meaning a failure.

> +       }
> +
> +       return true;
> +}
> +#else
> +static bool amd_max_boost(unsigned int max_freq,
> +                         unsigned int *max_boost)
> +{
> +       return false;
> +}
> +#endif
> +
>  static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
>         unsigned int i;
>         unsigned int valid_states = 0;
>         unsigned int cpu = policy->cpu;
> +       unsigned int freq, max_freq = 0;
> +       unsigned int max_boost;
>         struct acpi_cpufreq_data *data;
>         unsigned int result = 0;
>         struct cpuinfo_x86 *c = &cpu_data(policy->cpu);
> @@ -779,15 +826,25 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                     freq_table[valid_states-1].frequency / 1000)
>                         continue;
>
> +               freq = perf->states[i].core_frequency * 1000;
>                 freq_table[valid_states].driver_data = i;
> -               freq_table[valid_states].frequency =
> -                   perf->states[i].core_frequency * 1000;
> +               freq_table[valid_states].frequency = freq;
> +
> +               if (freq > max_freq)
> +                       max_freq = freq;
> +
>                 valid_states++;
>         }
>         freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
>         policy->freq_table = freq_table;
>         perf->state = 0;
>
> +       if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
> +           amd_max_boost(max_freq, &max_boost)) {

AFAICS, the issue is not limited to AMD CPUs .

> +               policy->cpuinfo.max_boost = max_boost;
> +               static_branch_enable(&cpufreq_amd_max_boost);
> +       }
> +
>         switch (perf->control_register.space_id) {
>         case ACPI_ADR_SPACE_SYSTEM_IO:
>                 /*
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d0a3525ce27f..b96677f6b57e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2721,6 +2721,9 @@ int cpufreq_boost_enabled(void)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
>
> +DEFINE_STATIC_KEY_FALSE(cpufreq_amd_max_boost);
> +EXPORT_SYMBOL_GPL(cpufreq_amd_max_boost);
> +
>  /*********************************************************************
>   *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
>   *********************************************************************/
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9c8b7437b6cd..341cac76d254 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -40,9 +40,14 @@ enum cpufreq_table_sorting {
>         CPUFREQ_TABLE_SORTED_DESCENDING
>  };
>
> +DECLARE_STATIC_KEY_FALSE(cpufreq_amd_max_boost);
> +
> +#define cpufreq_driver_has_max_boost() static_branch_unlikely(&cpufreq_amd_max_boost)
> +
>  struct cpufreq_cpuinfo {
>         unsigned int            max_freq;
>         unsigned int            min_freq;
> +       unsigned int            max_boost;
>
>         /* in 10^(-9) s = nanoseconds */
>         unsigned int            transition_latency;
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 6931f0cdeb80..541f3db3f576 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -159,8 +159,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>                                   unsigned long util, unsigned long max)
>  {
>         struct cpufreq_policy *policy = sg_policy->policy;
> -       unsigned int freq = arch_scale_freq_invariant() ?
> -                               policy->cpuinfo.max_freq : policy->cur;
> +       unsigned int freq, max_freq;
> +
> +       max_freq = cpufreq_driver_has_max_boost() ?
> +                       policy->cpuinfo.max_boost : policy->cpuinfo.max_freq;
> +
> +       freq = arch_scale_freq_invariant() ? max_freq : policy->cur;
>
>         freq = map_util_freq(util, freq, max);
>
> --
