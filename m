Return-Path: <linux-acpi+bounces-1164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 802F37DF526
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 15:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE73DB21111
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75E1BDEA
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hw639FMK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16C11724
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 13:51:00 +0000 (UTC)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B963D12E
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 06:50:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27e0c1222d1so894643a91.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Nov 2023 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698933055; x=1699537855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQsf0uxz+p9a7ZD7Gz0obekgX/RPQUCjSUYXjonlb9s=;
        b=hw639FMK9g3NA1vIVLnw9CBPU5fEiTPwftoz+Ej2cImRAWRpBILLrIxhFLyttWK3GU
         qENtJ/JcwTrLENeQifUJv11Wehgm/aKy6Z1qjYG4/+fh2Cso8CWeFjHxkbX2czHynEwr
         vRwQkbOYPDMe+r2delixxNoCbvK46l8LQjRt5uwMI5BRcq9fnlvzi6qlTf33cxHkVorx
         DQKz6gqvEcn58ZrmOFKnmYnV1E9Jl2wPb6fv4E4YHwjK2COzZTtRDcumGgU83VsO9pXd
         7fGYe8tFKD9lDU6x0BktjKDstwwDddS7jUMvIspyYD7Ogrk+riXS1dONcMSmYjFnHq50
         ImHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933055; x=1699537855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQsf0uxz+p9a7ZD7Gz0obekgX/RPQUCjSUYXjonlb9s=;
        b=qGx/GIX0/RCpmETcX32Nqd4aoagNdtvI4mRcHr8rzpVbMg7ocUxUn+gKflk2cRf0Oh
         WKNXt2Iw4sqA3hcKg/GDntppBwCj61OBv2n6T88ZXQamM96IM7AzFv8iFnk6NJLLZI8h
         zffnz8U3dglPgH2rBmpXdxd/wdx7IvPqmNrn2Mdtd7RRR+ncS6yWvNO/YIIJ+XSfpb5Q
         RxF9VKNXagoQDgVEemUXvvCENe5jgvxSda7p7UrJHbAHGlmpPg1jCpnr9MInbl/ZAKAv
         uS9G6Aw4N9tYif12+k3HnecrnETFCPyH/w2AFyRVvfzWLC1QYkrkF4y+jLKbrjqNwkyO
         rtdQ==
X-Gm-Message-State: AOJu0YwG783PEiXvZYaEzU2KKkOxRC0TA+PTwquOxiiZs6Pu3shwZbxW
	Jl1yoNp+/Ft9f8Gcp4/ZNiizqSsQVW9ge/j0uoBuCQ==
X-Google-Smtp-Source: AGHT+IGE6VrTzGimyIx/5AqMdiH/F+ab3llp7q4Er0Tig+PZspNmxu8j8yjkEz6hamAecMX4JJJElojuPrceWNTn8Z4=
X-Received: by 2002:a17:90a:bf07:b0:27d:1df4:26f3 with SMTP id
 c7-20020a17090abf0700b0027d1df426f3mr14996247pjs.15.1698933055202; Thu, 02
 Nov 2023 06:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-8-vincent.guittot@linaro.org> <ZUGUvdjrpw9NHSex@e129154.nice.arm.com>
 <CAKfTPtDDouduP57P8GH6J4qDjbKUasVRe-K0QUKcZHC2NZ+syQ@mail.gmail.com>
 <ZUN6K4d9FD31phbs@e129154.nice.arm.com> <CAKfTPtATBHyCvGkoKrN1Y9LpWX7nb3njY2zFPiJyj2bTSfbcNw@mail.gmail.com>
In-Reply-To: <CAKfTPtATBHyCvGkoKrN1Y9LpWX7nb3njY2zFPiJyj2bTSfbcNw@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 2 Nov 2023 14:50:43 +0100
Message-ID: <CAKfTPtCv1WUDr72eqWeJh6iakkn+d4rX1N0d=8G8TEdyeOxH3g@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] arm64/amu: use capacity_ref_freq to set AMU ratio
To: Beata Michalska <beata.michalska@arm.com>, pierre.gondois@arm.com
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Nov 2023 at 11:40, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Thu, 2 Nov 2023 at 11:31, Beata Michalska <beata.michalska@arm.com> wrote:
> >
> > Hi Vincent,
> >
> > On Wed, Nov 01, 2023 at 10:04:27AM +0100, Vincent Guittot wrote:
> > > Hi Beata,
> > >
> > > On Wed, 1 Nov 2023 at 00:59, Beata Michalska <beata.michalska@arm.com> wrote:
> > > >
> > > > On Fri, Oct 27, 2023 at 10:04:00AM +0200, Vincent Guittot wrote:
> > > > > Use the new capacity_ref_freq to set the ratio that is used by AMU for
> > > > > computing the arch_scale_freq_capacity().
> > > > > This helps to keep everything aligned using the same reference for
> > > > > computing CPUs capacity.
> > > > >
> > >
> > > [..]
> > >
> > > > > @@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
> > > > >       }
> > > > >
> > > > >       for_each_possible_cpu(cpu) {
> > > > > +             freq_inv_set_max_ratio(cpu,
> > > > > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > > > > +
> > > > The capacity_ref_freq set earlier will still lead to units mismatch,
> > > > as at the point of calling topology_init_cpu_capacity_cppc the lowest & nominal
> > > > frequencies will be provided in MHz (unless I have missed smth).
> > >
> > > I don't get your point:
> > > the unit of per_cpu(capacity_freq_ref, cpu) is Khz
> > >
> > > For cppc, we have
> > > per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps,
> > > raw_capacity[cpu]);
> > >
> > > freq_inv_set_max_ratio() uses
> > > arch_timer_get_rate() which returns a freq in Hz
> > > and
> > > per_cpu(capacity_freq_ref, cpu) * HZ_PER_KHZ. to get a freq in Hz too.
> > >
> > Apologies, I should have been more verbose here.
> > Before the change made in [1] the cppc_perf_to_khz was indeed operating on
> > lowest & nominal frequency values expressed in kHZ, as those were appropriately
> > amended:
> > cppc_cpufreq_cpu_init
> >         |__> cppc_cpufreq_get_cpu_data:
> >                 |__>    ...
> >                         /* Convert the lowest and nominal freq from MHz to KHz */
> >                         cpu_data->perf_caps.lowest_freq *= 1000;
> >                         cpu_data->perf_caps.nominal_freq *= 1000;
> >
> > So far cppc_perf_to_khz (previously cppc_cpufreq_perf_to_khz) was being called
> > with the post-processed CPC data (through cppc_cpufreq_get_cpu_data) and thus
> > guaranteed to be operating on values in kHz.
> > With the new changes the cppc_perf_to_khz will operate on raw CPC data,
> > which are expressed in MHz.(as per acpi spec)
>
> Ok, thanks for the explanation. I haven't noticed that cppc_cpufreq
> was processing the raw CPC data  (*1000) before using them. I'm going
> to fix that.

With cppc_perf_to_khz() being moved into the generic cppc_acpi.c, we
can't change perf_caps.nominal_freq and perf_caps.lowest_freq
directly. So, I'm planning to add the conversion from MHz to kHz in
the functions cppc_perf_to_khz() and cppc_khz_to_perf() and remove the
2 conversions above in cppc_cpufreq_get_cpu_data().

>
>
> >
> > ---
> > Best Regards
> > B.
> > > > This means that use of both, the capacity_ref_freq and the arch_freq_scale
> > > > will generate unexpected results, so I guess this should get amended in the
> > > > preceding patch (?) [1]
> > > >
> > > > ---
> > > > BR
> > > > B.
> > > >
> > > > [1] https://lore.kernel.org/linux-arm-kernel/20231027080400.56703-4-vincent.guittot@linaro.org/T/#m42daa167097edc190b1cfc05382c385ed801d909
> > > >
> > > > >               capacity = raw_capacity[cpu];
> > > > >               capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> > > > >                                    capacity_scale);
> > > > > @@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
> > > > >
> > > > >       cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
> > > > >
> > > > > -     for_each_cpu(cpu, policy->related_cpus)
> > > > > +     for_each_cpu(cpu, policy->related_cpus) {
> > > > >               per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
> > > > > +             freq_inv_set_max_ratio(cpu,
> > > > > +                                    per_cpu(capacity_ref_freq, cpu) * HZ_PER_KHZ);
> > > > > +     }
> > > > >
> > > > >       if (cpumask_empty(cpus_to_visit)) {
> > > > >               topology_normalize_cpu_scale();
> > > > > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > > > > index 38ca6c76af56..ffdf0b7c55fa 100644
> > > > > --- a/include/linux/arch_topology.h
> > > > > +++ b/include/linux/arch_topology.h
> > > > > @@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
> > > > >  void remove_cpu_topology(unsigned int cpuid);
> > > > >  void reset_cpu_topology(void);
> > > > >  int parse_acpi_topology(void);
> > > > > +void freq_inv_set_max_ratio(int cpu, u64 max_rate);
> > > > >  #endif
> > > > >
> > > > >  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> > > > > --
> > > > > 2.34.1
> > > > >

