Return-Path: <linux-acpi+bounces-1126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CA97DDF69
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508D828170E
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6410959
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDR/u07J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338363236
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 09:04:45 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AFE123
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 02:04:40 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4901658a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 01 Nov 2023 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698829480; x=1699434280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T97XsuQPDMRDtHy08B+rqECq/pabjxSIR/W6V7wvFWM=;
        b=wDR/u07J09wey+Tzfc9wT2uc3JDwIYuShLiN2TlGprBgCfFRjfv8xR8r3Lo8t9BrG+
         yI0fYEEM/bfAH1gvXNxhC+vF9g7sQWRyi8uqH1tvhxh2H93ZKtVIb4Fr2bHJpulosKeK
         qHoTqaDYKKD7OwXWnTBMIqqQ2hvoHbV2rTXhQheMKWZFHN+Q248QE2pMr6WXL5wUjgnr
         YLM1BHjvcEOgUcrX1Qxwnalb4WSq2uQUOR/nCghOSD50HRCED/4tq17cPGP/lSKa1QZn
         Q9rGJ7lGWoqmub44HKvLQDahlLIyix6jZ1uCMhfpewTfcspqAJkzbQP+dvjqfu1c/lZT
         /WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829480; x=1699434280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T97XsuQPDMRDtHy08B+rqECq/pabjxSIR/W6V7wvFWM=;
        b=q0j5WG5e1xYm7h5olxVeMeQFVZggYPs9n5ta4peNgLcLN6xf6/qR8hfa1ZDcyGBKQc
         fSUaD+4VFbaQRrIbJFujD+HeEzsOlR66MUt+adb6K9JXdF9P7AwBFgD/N2C8rABwQwKc
         +U327rUPRaZsstxVw2ech4pgK9aLNkUNBzrc0JNPDMo8rZSS+hwjwk6grRBlvPDN+BBq
         Z/uf58LkoNsZaPKWFPl+D93D1kMbTaF/1hhgaRDHHjdwUxTBcaUNBVtJZANgavFb5fJU
         Dug7sD/LjbDgcwjZl/MHGQB9Uvlj5ugpgGmgNXGOL6mLOUHAOaefpy7gQiIPAcn3ZOPE
         Yjew==
X-Gm-Message-State: AOJu0Ywzs9H9PS449GS0NZMhDurvj8JdkWtD/i4kFkIUcqy6B83Ojcwf
	nkjWRr+hzWjjRfPKgaxGfPsTMIw8+M5n0TIm9gLQiw==
X-Google-Smtp-Source: AGHT+IE3lvIVL/RqHctY3lvCHB1fhOmc51H/phVezjStkLmOqrn9OaDOQHPPmsK4zrwvjKKx4RwmqYLMKXfHu3BQP9o=
X-Received: by 2002:a05:6a20:4327:b0:16b:b4a0:e06b with SMTP id
 h39-20020a056a20432700b0016bb4a0e06bmr14390989pzk.43.1698829479791; Wed, 01
 Nov 2023 02:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-8-vincent.guittot@linaro.org> <ZUGUvdjrpw9NHSex@e129154.nice.arm.com>
In-Reply-To: <ZUGUvdjrpw9NHSex@e129154.nice.arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 1 Nov 2023 10:04:27 +0100
Message-ID: <CAKfTPtDDouduP57P8GH6J4qDjbKUasVRe-K0QUKcZHC2NZ+syQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] arm64/amu: use capacity_ref_freq to set AMU ratio
To: Beata Michalska <beata.michalska@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Beata,

On Wed, 1 Nov 2023 at 00:59, Beata Michalska <beata.michalska@arm.com> wrote:
>
> On Fri, Oct 27, 2023 at 10:04:00AM +0200, Vincent Guittot wrote:
> > Use the new capacity_ref_freq to set the ratio that is used by AMU for
> > computing the arch_scale_freq_capacity().
> > This helps to keep everything aligned using the same reference for
> > computing CPUs capacity.
> >

[..]

> > @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
> >       }
> >
> >       for_each_possible_cpu(cpu) {
> > +             freq_inv_set_max_ratio(cpu,
> > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > +
> The capacity_ref_freq set earlier will still lead to units mismatch,
> as at the point of calling topology_init_cpu_capacity_cppc the lowest & nominal
> frequencies will be provided in MHz (unless I have missed smth).

I don't get your point:
the unit of per_cpu(capacity_freq_ref, cpu) is Khz

For cppc, we have
per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps,
raw_capacity[cpu]);

freq_inv_set_max_ratio() uses
arch_timer_get_rate() which returns a freq in Hz
and
per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ. to get a freq in Hz too.

> This means that use of both, the capacity_ref_freq and the arch_freq_scale
> will generate unexpected results, so I guess this should get amended in the
> preceding patch (?) [1]
>
> ---
> BR
> B.
>
> [1] https://lore.kernel.org/linux-arm-kernel/20231027080400.56703-4-vincent.guittot@linaro.org/T/#m42daa167097edc190b1cfc05382c385ed801d909
>
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
> > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > +     }
> >
> >       if (cpumask_empty(cpus_to_visit)) {
> >               topology_normalize_cpu_scale();
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index 38ca6c76af56..ffdf0b7c55fa 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
> >  void remove_cpu_topology(unsigned int cpuid);
> >  void reset_cpu_topology(void);
> >  int parse_acpi_topology(void);
> > +void freq_inv_set_max_ratio(int cpu, u64 max_rate);
> >  #endif
> >
> >  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> > --
> > 2.34.1
> >

