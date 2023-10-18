Return-Path: <linux-acpi+bounces-748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC147CE6DD
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847441C20B36
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 18:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806742BF7
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972053D3BD
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 17:23:26 +0000 (UTC)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699C63C0F;
	Wed, 18 Oct 2023 10:23:25 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-582050ce2d8so25812eaf.0;
        Wed, 18 Oct 2023 10:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697649804; x=1698254604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2lwiFW7v1x6wJxRpx1c+ObPtw/kHFVlH2vUJpoYMn0=;
        b=AyN+NoPAVB8NQ1Jq3z4mylGl6Ae++nsCqlUsiob5kMuKBv7h8JL+ye1HEMthG0tvb1
         NxmK0CS9Ig+jTtmNngI04vbRqXZKncEGAORkGmXGQWV6cJ8t52KSx4DpczqDZODYlZ8j
         q8KpPMO57QECLStv3uTuylzxo7WO4zyqRkrwquJ1RgeEod1AlyvBVhmpsCwp8WAn4Gl7
         ryg3szxmrA3upeE7VjSuXQBwurv8j82xozg24GgwO5VMhCRJp2LjO4siPR93S+izqBiI
         I6NlahBmucbrDjYBLn4+ED5ck6rht4ynj1LuXSL/2NhqpuCaqz3c25gcGzdQECUJWqn4
         ks6Q==
X-Gm-Message-State: AOJu0YxpHvf0ViJg46ESn432olLBgRBMlCVdIhw7L8jwL/U9+yRTvJ1r
	6ILbfEBG4dClBZy9ndSaay29+4N6Pr+C1uW4qpLnkQX7zf0=
X-Google-Smtp-Source: AGHT+IGnNjtcabtUMJyCpUS/Q8iadNabFO9ltoFIiy6KhS15PxlDuBSBbxZIY+SzIP5PAczSNxTThF+a9wJpw+QBaOQ=
X-Received: by 2002:a05:6820:180f:b0:581:f17d:5eb5 with SMTP id
 bn15-20020a056820180f00b00581f17d5eb5mr3255065oob.0.1697649804594; Wed, 18
 Oct 2023 10:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org> <20231018162540.667646-3-vincent.guittot@linaro.org>
In-Reply-To: <20231018162540.667646-3-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 19:23:13 +0200
Message-ID: <CAJZ5v0iu9AjZWNbMPQbwErYRTz8y0PEGDyh7CU_NwxGj6KXMOQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] cpufreq: use the fixed and coherent frequency for
 scaling capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 6:25=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> cpuinfo.max_freq can change at runtime because of boost as an example. Th=
is
> implies that the value could be different from the frequency that has bee=
n
> used to compute the capacity of a CPU.
>
> The new arch_scale_freq_ref() returns a fixed and coherent frequency
> that can be used to compute the capacity for a given frequency.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpufreq/cpufreq.c | 4 ++--
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 60ed89000e82..8c4f9c2f9c44 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_polic=
y *policy,
>
>         arch_set_freq_scale(policy->related_cpus,
>                             policy->cur,
> -                           policy->cpuinfo.max_freq);
> +                           arch_scale_freq_ref(policy->cpu));
>
>         spin_lock(&policy->transition_lock);
>         policy->transition_ongoing =3D false;
> @@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpuf=
req_policy *policy,
>
>         policy->cur =3D freq;
>         arch_set_freq_scale(policy->related_cpus, freq,
> -                           policy->cpuinfo.max_freq);
> +                           arch_scale_freq_ref(policy->cpu));
>         cpufreq_stats_record_transition(policy, freq);
>
>         if (trace_cpu_frequency_enabled()) {
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 71d186d6933a..bbc483b4b6e5 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1211,6 +1211,15 @@ void arch_set_freq_scale(const struct cpumask *cpu=
s,
>  {
>  }
>  #endif
> +
> +#ifndef arch_scale_freq_ref
> +static __always_inline
> +unsigned int arch_scale_freq_ref(int cpu)
> +{
> +       return 0;
> +}
> +#endif
> +
>  /* the following are really really optional */
>  extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
>  extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
> --
> 2.34.1
>

