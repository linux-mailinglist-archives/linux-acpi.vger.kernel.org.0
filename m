Return-Path: <linux-acpi+bounces-875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391DC7D4E10
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D944B20E67
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF1226280
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETQo8HMu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C713224EA
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 09:58:16 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03023C1
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 02:58:15 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d134a019cso30253956d6.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698141494; x=1698746294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZADg+Sp3ExqHuirYv8+xin3LzD6ONTFW/tVjt2x+ao=;
        b=ETQo8HMuGs3ZPotTFfypjpFHJg5ThMF3kaK04jPzXYoSUTz2TmhOQL5Ru1rlX3G52a
         ZkRceR9n+w7Ox/nkBG/VFXNtSV1KUeDMBS9CBy54wU8Kh/sZY/S34LuLuXWF6NKFZape
         sh21TpEbiwPdz4oqogImQrc0wW8Sogg7PBBrgz4M1vV8CIvEMjD1/lCDWQEWlOK3+Qt5
         X9RxQkBcKLAbVU7Pcuj9nxz7huNxWCjBrUTfYVwCGrpLcogGa4lr4hONGs41Z3gMzI+l
         LVuw5bo2BWmQL1Tg2SFAC4pB7+E0qu3KcUJLwKjPNjGWNmtYQuS+eaVG6YveR88vkPmP
         bpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141494; x=1698746294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZADg+Sp3ExqHuirYv8+xin3LzD6ONTFW/tVjt2x+ao=;
        b=PSw/2b0kLLIuwzT0/wHc5NvLzR1FXZCZ3OiqzDMo99lZiz+J4rzWSv4+5zGLmTmUFK
         D3MzwEJsUTJh7c3o/Yl1mXzBltsOEkgjaDuJEXH81rIDBkqtUJPRWSvypAUcqHmwRfkn
         hEouWS0UABphoRTI4/Ybbv7zkJ32F/RD7My+CuSGLRn3Is5B1QHwwERvYaOgsjwcHp2N
         jbu9QeqXwiLVMjHnVfrFhuQrZV6iGPUtIHWhJgWpTrDX9mHpeyagmzcCxf/G1sO3xs/V
         rvTsNXMFriI9r1iZQjl+slS0roume6jhx5RvvWA/9Uk2iYezkHt7498LZHaC5k/vH3dc
         2J7A==
X-Gm-Message-State: AOJu0YyljMRzQNDm8uDWRzDV8PZcA3DezjYQwRUm+hMDBz4g3N05xPGS
	iGZmVWKJ1UJrxAuHZuZbFsB/u2nzC8RLlnxctymZ2w==
X-Google-Smtp-Source: AGHT+IFvQNTiY8h9DihnpBay7z2PZaSgr+8LHY4epswRYy2cqC6kgw6hX8vTVQqUhYs3ZNPn/a8Fc1K0/MVyLDXEnR8=
X-Received: by 2002:a05:6214:5008:b0:658:c75c:1946 with SMTP id
 jo8-20020a056214500800b00658c75c1946mr12280231qvb.52.1698141493903; Tue, 24
 Oct 2023 02:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-7-vincent.guittot@linaro.org> <ZTbebQrK3K+JwWxR@arm.com>
In-Reply-To: <ZTbebQrK3K+JwWxR@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 24 Oct 2023 11:58:02 +0200
Message-ID: <CAKfTPtA0KBE8TFifOEXddF9d_wqDjb4QUvgK8c0DTtyLrX0atA@mail.gmail.com>
Subject: Re: [RFC v3 6/6] arm64/amu: use capacity_ref_freq to set AMU ratio
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Oct 2023 at 22:58, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi,
>
> On Wednesday 18 Oct 2023 at 18:25:40 (+0200), Vincent Guittot wrote:
> > Use the new capacity_ref_freq to set the ratio that is used by AMU for
> > computing the arch_scale_freq_capacity().
> > This helps to keep everything aligned using the same reference for
> > computing CPUs capacity.
> >
> > The default value of the ratio ensures that arch_scale_freq_capacity()
> > returns max capacity until it is set to its correct value with the
> > cpu capacity and capacity_ref_freq.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  arch/arm64/kernel/topology.c  | 18 ++++++++++--------
> >  drivers/base/arch_topology.c  | 14 ++++++++++++--
> >  include/linux/arch_topology.h |  1 +
> >  3 files changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 817d788cd866..0f8f6e90c46d 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
> >  #undef pr_fmt
> >  #define pr_fmt(fmt) "AMU: " fmt
> >
> > -static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
> > +/*
> > + * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SHIFT until
> > + * the CPU capacity and its assosciated frequency have been correctly
> > + * initialized.
>
> s/SCHED_CAPACITY_SHIFT/SCHED_CAPACITY_SCALE
>
> > + */
> > +static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) = (2 * SCHED_CAPACITY_SHIFT);
>
> It should be 1UL << (2 * SCHED_CAPACITY_SHIFT).

yes

>
> >  static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
> >  static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
> >  static cpumask_var_t amu_fie_cpus;
> > @@ -112,9 +117,9 @@ static inline bool freq_counters_valid(int cpu)
> >       return true;
> >  }
> >
> > -static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
> > +int freq_inv_set_max_ratio(int cpu, u64 max_rate)
> >  {
> > -     u64 ratio;
> > +     u64 ratio, ref_rate = arch_timer_get_rate();
> >
> >       if (unlikely(!max_rate || !ref_rate)) {
> >               pr_debug("CPU%d: invalid maximum or reference frequency.\n",
> > @@ -142,7 +147,7 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
> >               return -EINVAL;
> >       }
>
> The return value is no longer used so it might be worth declaring it to
> return void and WARN_ONCE for unlikely(!max_rate || !ref_rate).
>
> >
> > -     per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
> > +     WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);
> >
> >       return 0;
> >  }
> > @@ -195,10 +200,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
> >               return;
> >
> >       for_each_cpu(cpu, cpus) {
> > -             if (!freq_counters_valid(cpu) ||
> > -                 freq_inv_set_max_ratio(cpu,
> > -                                        cpufreq_get_hw_max_freq(cpu) * 1000ULL,
> > -                                        arch_timer_get_rate()))
> > +             if (!freq_counters_valid(cpu))
> >                       return;
> >       }
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 2372ce791bb4..3a604b77b12d 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -344,6 +344,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> >       return !ret;
> >  }
> >
> > +int __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
> > +{
> > +     return 0;
> > +}
> > +
> >  #ifdef CONFIG_ACPI_CPPC_LIB
> >  #include <acpi/cppc_acpi.h>
> >
> > @@ -369,7 +374,6 @@ void topology_init_cpu_capacity_cppc(void)
> >                       capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
> >
> >                       per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
> > -
> >                       pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
> >                                cpu, raw_capacity[cpu]);
> >                       continue;
> > @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
> >       }
> >
> >       for_each_possible_cpu(cpu) {
> > +             freq_inv_set_max_ratio(cpu,
> > +                                    per_cpu(capacity_ref_freq, cpu));
> > +
> >               capacity = raw_capacity[cpu];
> >               capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> >                                    capacity_scale);
> > @@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> >
> >       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> >
> > -     for_each_cpu(cpu, policy->related_cpus)
> > +     for_each_cpu(cpu, policy->related_cpus) {
> >               per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
> > +             freq_inv_set_max_ratio(cpu,
> > +                                    per_cpu(capacity_ref_freq, cpu));
>
> capacity_ref_freq is in KHz while arch_timer_get_rate() is in Hz. One or
> the other needs to be scaled.
>
> The same in topology_init_cpu_capacity_cppc().
>
> Thanks,
> Ionela.
>
> > +     }
> >
> >       if (cpumask_empty(cpus_to_visit)) {
> >               topology_normalize_cpu_scale();
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index 38ca6c76af56..b6e95d763279 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
> >  void remove_cpu_topology(unsigned int cpuid);
> >  void reset_cpu_topology(void);
> >  int parse_acpi_topology(void);
> > +int freq_inv_set_max_ratio(int cpu, u64 max_rate);
> >  #endif
> >
> >  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> > --
> > 2.34.1
> >

