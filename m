Return-Path: <linux-acpi+bounces-749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941B7CE6DF
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 20:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92817B20D33
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 18:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F5941E46
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978235899
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 17:27:13 +0000 (UTC)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBC4239;
	Wed, 18 Oct 2023 10:27:11 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-581e106fd25so242176eaf.0;
        Wed, 18 Oct 2023 10:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650031; x=1698254831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEUIY5QyjghLE7xGwQzhvXJZ4aU5BXHM5RIgZGxd/GA=;
        b=PsQ6GeEHLce2/FqqYR9QeCilnzeigPvDdYLVBYNEzl6X3i5uxXTPhz3fwrWbRV1CbW
         EI2knXTJavTjXYdX9vSvQ4YiuTXsElmORh3uEt51XuJPEV40CjnetEKldXQl1EGlHRr+
         2kj9LvG4DxKOk0kq0LiWGUVz3APMZ0PXX8j3adOvFYn4WuQ4YZXVOAmEtcolLiV7KI30
         p+kslgfCKjmmiAzou/ZHneh/iMT+S9QBtgZS6UrC3FeqFBzU0KS9Jj5Evwn1ta41VUXb
         sYvIph4PRfFta6nXJGlyCnWqexonVl8hHz+XiwCh21HqDFU/AOJTJBQxEFucIp/eV3mt
         Spww==
X-Gm-Message-State: AOJu0YzcseBZIYTciuVW/1I62Oek/qaRH5sPMi+i0NKqECnD7QdyHbtT
	IK9+UT8HJerEcrJeFXru2v6yxZ3W1zENhCeP1/Y=
X-Google-Smtp-Source: AGHT+IFnU5p8/t6Zwrw5PhiN9DM50ck0kviuX3tGaJ30HZAMVB52mE0u7x4RXmHjuUGny6qSHytlagQB1dIYWcZIJNU=
X-Received: by 2002:a4a:d897:0:b0:581:ed38:5505 with SMTP id
 b23-20020a4ad897000000b00581ed385505mr3873219oov.0.1697650030719; Wed, 18 Oct
 2023 10:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org> <20231018162540.667646-6-vincent.guittot@linaro.org>
In-Reply-To: <20231018162540.667646-6-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Oct 2023 19:26:59 +0200
Message-ID: <CAJZ5v0hS7bdUv=-k4ut2Fw0LYfB7Hb1_rro7UOVTRq4=JLNchg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for computing
 the capacity
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
> Save the frequency associated to the performance that has been used when
> initializing the capacity of CPUs.
> Also, cppc cpufreq driver can register an artificial energy model. In suc=
h
> case, it needs the frequency for this compute capacity.
> We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
> outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

For the changes in drivers/acpi/cppc_acpi.c :

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
>  drivers/base/arch_topology.c   |  15 +++-
>  drivers/cpufreq/cppc_cpufreq.c | 141 ++++++---------------------------
>  include/acpi/cppc_acpi.h       |   2 +
>  4 files changed, 133 insertions(+), 118 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..72aae5e87788 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -39,6 +39,8 @@
>  #include <linux/rwsem.h>
>  #include <linux/wait.h>
>  #include <linux/topology.h>
> +#include <linux/dmi.h>
> +#include <asm/unaligned.h>
>
>  #include <acpi/cppc_acpi.h>
>
> @@ -1760,3 +1762,94 @@ unsigned int cppc_get_transition_latency(int cpu_n=
um)
>         return latency_ns;
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_transition_latency);
> +
> +/* Minimum struct length needed for the DMI processor entry we want */
> +#define DMI_ENTRY_PROCESSOR_MIN_LENGTH 48
> +
> +/* Offset in the DMI processor structure for the max frequency */
> +#define DMI_PROCESSOR_MAX_SPEED                0x14
> +
> +/* Callback function used to retrieve the max frequency from DMI */
> +static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private=
)
> +{
> +       const u8 *dmi_data =3D (const u8 *)dm;
> +       u16 *mhz =3D (u16 *)private;
> +
> +       if (dm->type =3D=3D DMI_ENTRY_PROCESSOR &&
> +           dm->length >=3D DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
> +               u16 val =3D (u16)get_unaligned((const u16 *)
> +                               (dmi_data + DMI_PROCESSOR_MAX_SPEED));
> +               *mhz =3D val > *mhz ? val : *mhz;
> +       }
> +}
> +
> +/* Look up the max frequency in DMI */
> +static u64 cppc_get_dmi_max_khz(void)
> +{
> +       u16 mhz =3D 0;
> +
> +       dmi_walk(cppc_find_dmi_mhz, &mhz);
> +
> +       /*
> +        * Real stupid fallback value, just in case there is no
> +        * actual value set.
> +        */
> +       mhz =3D mhz ? mhz : 1;
> +
> +       return (1000 * mhz);
> +}
> +
> +/*
> + * If CPPC lowest_freq and nominal_freq registers are exposed then we ca=
n
> + * use them to convert perf to freq and vice versa. The conversion is
> + * extrapolated as an affine function passing by the 2 points:
> + *  - (Low perf, Low freq)
> + *  - (Nominal perf, Nominal perf)
> + */
> +unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsigned int =
perf)
> +{
> +       s64 retval, offset =3D 0;
> +       static u64 max_khz;
> +       u64 mul, div;
> +
> +       if (caps->lowest_freq && caps->nominal_freq) {
> +               mul =3D caps->nominal_freq - caps->lowest_freq;
> +               div =3D caps->nominal_perf - caps->lowest_perf;
> +               offset =3D caps->nominal_freq - div64_u64(caps->nominal_p=
erf * mul, div);
> +       } else {
> +               if (!max_khz)
> +                       max_khz =3D cppc_get_dmi_max_khz();
> +               mul =3D max_khz;
> +               div =3D caps->highest_perf;
> +       }
> +
> +       retval =3D offset + div64_u64(perf * mul, div);
> +       if (retval >=3D 0)
> +               return retval;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_to_khz);
> +
> +unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsigned int =
freq)
> +{
> +       s64 retval, offset =3D 0;
> +       static u64 max_khz;
> +       u64  mul, div;
> +
> +       if (caps->lowest_freq && caps->nominal_freq) {
> +               mul =3D caps->nominal_perf - caps->lowest_perf;
> +               div =3D caps->nominal_freq - caps->lowest_freq;
> +               offset =3D caps->nominal_perf - div64_u64(caps->nominal_f=
req * mul, div);
> +       } else {
> +               if (!max_khz)
> +                       max_khz =3D cppc_get_dmi_max_khz();
> +               mul =3D caps->highest_perf;
> +               div =3D max_khz;
> +       }
> +
> +       retval =3D offset + div64_u64(freq * mul, div);
> +       if (retval >=3D 0)
> +               return retval;
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_khz_to_perf);
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 9a073c2d2086..2372ce791bb4 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -350,6 +350,7 @@ bool __init topology_parse_cpu_capacity(struct device=
_node *cpu_node, int cpu)
>  void topology_init_cpu_capacity_cppc(void)
>  {
>         struct cppc_perf_caps perf_caps;
> +       u64 capacity, capacity_scale;
>         int cpu;
>
>         if (likely(!acpi_cpc_valid()))
> @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
>                     (perf_caps.highest_perf >=3D perf_caps.nominal_perf) =
&&
>                     (perf_caps.highest_perf >=3D perf_caps.lowest_perf)) =
{
>                         raw_capacity[cpu] =3D perf_caps.highest_perf;
> +                       capacity_scale =3D max_t(u64, capacity_scale, raw=
_capacity[cpu]);
> +
> +                       per_cpu(capacity_ref_freq, cpu) =3D cppc_perf_to_=
khz(&perf_caps, raw_capacity[cpu]);
> +
>                         pr_debug("cpu_capacity: CPU%d cpu_capacity=3D%u (=
raw).\n",
>                                  cpu, raw_capacity[cpu]);
>                         continue;
> @@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
>                 goto exit;
>         }
>
> -       topology_normalize_cpu_scale();
> +       for_each_possible_cpu(cpu) {
> +               capacity =3D raw_capacity[cpu];
> +               capacity =3D div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> +                                    capacity_scale);
> +               topology_set_cpu_scale(cpu, capacity);
> +               pr_debug("cpu_capacity: CPU%d cpu_capacity=3D%lu\n",
> +                       cpu, topology_get_cpu_scale(cpu));
> +       }
> +
>         schedule_work(&update_topology_flags_work);
>         pr_debug("cpu_capacity: cpu_capacity initialization done\n");
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index fe08ca419b3d..822376b0cb78 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -27,12 +27,6 @@
>
>  #include <acpi/cppc_acpi.h>
>
> -/* Minimum struct length needed for the DMI processor entry we want */
> -#define DMI_ENTRY_PROCESSOR_MIN_LENGTH 48
> -
> -/* Offset in the DMI processor structure for the max frequency */
> -#define DMI_PROCESSOR_MAX_SPEED                0x14
> -
>  /*
>   * This list contains information parsed from per CPU ACPI _CPC and _PSD
>   * structures: e.g. the highest and lowest supported performance, capabi=
lities,
> @@ -291,97 +285,9 @@ static inline void cppc_freq_invariance_exit(void)
>  }
>  #endif /* CONFIG_ACPI_CPPC_CPUFREQ_FIE */
>
> -/* Callback function used to retrieve the max frequency from DMI */
> -static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private=
)
> -{
> -       const u8 *dmi_data =3D (const u8 *)dm;
> -       u16 *mhz =3D (u16 *)private;
> -
> -       if (dm->type =3D=3D DMI_ENTRY_PROCESSOR &&
> -           dm->length >=3D DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
> -               u16 val =3D (u16)get_unaligned((const u16 *)
> -                               (dmi_data + DMI_PROCESSOR_MAX_SPEED));
> -               *mhz =3D val > *mhz ? val : *mhz;
> -       }
> -}
> -
> -/* Look up the max frequency in DMI */
> -static u64 cppc_get_dmi_max_khz(void)
> -{
> -       u16 mhz =3D 0;
> -
> -       dmi_walk(cppc_find_dmi_mhz, &mhz);
> -
> -       /*
> -        * Real stupid fallback value, just in case there is no
> -        * actual value set.
> -        */
> -       mhz =3D mhz ? mhz : 1;
> -
> -       return (1000 * mhz);
> -}
> -
> -/*
> - * If CPPC lowest_freq and nominal_freq registers are exposed then we ca=
n
> - * use them to convert perf to freq and vice versa. The conversion is
> - * extrapolated as an affine function passing by the 2 points:
> - *  - (Low perf, Low freq)
> - *  - (Nominal perf, Nominal perf)
> - */
> -static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu_da=
ta,
> -                                            unsigned int perf)
> -{
> -       struct cppc_perf_caps *caps =3D &cpu_data->perf_caps;
> -       s64 retval, offset =3D 0;
> -       static u64 max_khz;
> -       u64 mul, div;
> -
> -       if (caps->lowest_freq && caps->nominal_freq) {
> -               mul =3D caps->nominal_freq - caps->lowest_freq;
> -               div =3D caps->nominal_perf - caps->lowest_perf;
> -               offset =3D caps->nominal_freq - div64_u64(caps->nominal_p=
erf * mul, div);
> -       } else {
> -               if (!max_khz)
> -                       max_khz =3D cppc_get_dmi_max_khz();
> -               mul =3D max_khz;
> -               div =3D caps->highest_perf;
> -       }
> -
> -       retval =3D offset + div64_u64(perf * mul, div);
> -       if (retval >=3D 0)
> -               return retval;
> -       return 0;
> -}
> -
> -static unsigned int cppc_cpufreq_khz_to_perf(struct cppc_cpudata *cpu_da=
ta,
> -                                            unsigned int freq)
> -{
> -       struct cppc_perf_caps *caps =3D &cpu_data->perf_caps;
> -       s64 retval, offset =3D 0;
> -       static u64 max_khz;
> -       u64  mul, div;
> -
> -       if (caps->lowest_freq && caps->nominal_freq) {
> -               mul =3D caps->nominal_perf - caps->lowest_perf;
> -               div =3D caps->nominal_freq - caps->lowest_freq;
> -               offset =3D caps->nominal_perf - div64_u64(caps->nominal_f=
req * mul, div);
> -       } else {
> -               if (!max_khz)
> -                       max_khz =3D cppc_get_dmi_max_khz();
> -               mul =3D caps->highest_perf;
> -               div =3D max_khz;
> -       }
> -
> -       retval =3D offset + div64_u64(freq * mul, div);
> -       if (retval >=3D 0)
> -               return retval;
> -       return 0;
> -}
> -
>  static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>                                    unsigned int target_freq,
>                                    unsigned int relation)
> -
>  {
>         struct cppc_cpudata *cpu_data =3D policy->driver_data;
>         unsigned int cpu =3D policy->cpu;
> @@ -389,7 +295,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_pol=
icy *policy,
>         u32 desired_perf;
>         int ret =3D 0;
>
> -       desired_perf =3D cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
> +       desired_perf =3D cppc_khz_to_perf(&cpu_data->perf_caps, target_fr=
eq);
>         /* Return if it is exactly the same perf */
>         if (desired_perf =3D=3D cpu_data->perf_ctrls.desired_perf)
>                 return ret;
> @@ -417,7 +323,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct c=
pufreq_policy *policy,
>         u32 desired_perf;
>         int ret;
>
> -       desired_perf =3D cppc_cpufreq_khz_to_perf(cpu_data, target_freq);
> +       desired_perf =3D cppc_khz_to_perf(&cpu_data->perf_caps, target_fr=
eq);
>         cpu_data->perf_ctrls.desired_perf =3D desired_perf;
>         ret =3D cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>
> @@ -530,7 +436,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>         min_step =3D min_cap / CPPC_EM_CAP_STEP;
>         max_step =3D max_cap / CPPC_EM_CAP_STEP;
>
> -       perf_prev =3D cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +       perf_prev =3D cppc_khz_to_perf(perf_caps, *KHz);
>         step =3D perf_prev / perf_step;
>
>         if (step > max_step)
> @@ -550,8 +456,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>                         perf =3D step * perf_step;
>         }
>
> -       *KHz =3D cppc_cpufreq_perf_to_khz(cpu_data, perf);
> -       perf_check =3D cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +       *KHz =3D cppc_perf_to_khz(perf_caps, perf);
> +       perf_check =3D cppc_khz_to_perf(perf_caps, *KHz);
>         step_check =3D perf_check / perf_step;
>
>         /*
> @@ -561,8 +467,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>          */
>         while ((*KHz =3D=3D prev_freq) || (step_check !=3D step)) {
>                 perf++;
> -               *KHz =3D cppc_cpufreq_perf_to_khz(cpu_data, perf);
> -               perf_check =3D cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +               *KHz =3D cppc_perf_to_khz(perf_caps, perf);
> +               perf_check =3D cppc_khz_to_perf(perf_caps, *KHz);
>                 step_check =3D perf_check / perf_step;
>         }
>
> @@ -591,7 +497,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, =
unsigned long KHz,
>         perf_caps =3D &cpu_data->perf_caps;
>         max_cap =3D arch_scale_cpu_capacity(cpu_dev->id);
>
> -       perf_prev =3D cppc_cpufreq_khz_to_perf(cpu_data, KHz);
> +       perf_prev =3D cppc_khz_to_perf(perf_caps, KHz);
>         perf_step =3D CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_ca=
p;
>         step =3D perf_prev / perf_step;
>
> @@ -643,6 +549,7 @@ static void cppc_cpufreq_register_em(struct cpufreq_p=
olicy *policy)
>                 EM_ADV_DATA_CB(cppc_get_cpu_power, cppc_get_cpu_cost);
>
>         cpu_data =3D policy->driver_data;
> +
>         em_dev_register_perf_domain(get_cpu_device(policy->cpu),
>                         get_perf_level_count(policy), &em_cb,
>                         cpu_data->shared_cpu_map, 0);
> @@ -724,20 +631,20 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_pol=
icy *policy)
>          * Set min to lowest nonlinear perf to avoid any efficiency penal=
ty (see
>          * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>          */
> -       policy->min =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                              caps->lowest_nonlinear_per=
f);
> -       policy->max =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                              caps->nominal_perf);
> +       policy->min =3D cppc_perf_to_khz(caps,
> +                                      caps->lowest_nonlinear_perf);
> +       policy->max =3D cppc_perf_to_khz(caps,
> +                                      caps->nominal_perf);
>
>         /*
>          * Set cpuinfo.min_freq to Lowest to make the full range of perfo=
rmance
>          * available if userspace wants to use any perf between lowest & =
lowest
>          * nonlinear perf
>          */
> -       policy->cpuinfo.min_freq =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                           caps->lowest_=
perf);
> -       policy->cpuinfo.max_freq =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                           caps->nominal=
_perf);
> +       policy->cpuinfo.min_freq =3D cppc_perf_to_khz(caps,
> +                                                   caps->lowest_perf);
> +       policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps,
> +                                                   caps->nominal_perf);
>
>         policy->transition_delay_us =3D cppc_cpufreq_get_transition_delay=
_us(cpu);
>         policy->shared_type =3D cpu_data->shared_type;
> @@ -773,7 +680,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
y *policy)
>                 boost_supported =3D true;
>
>         /* Set policy->cur to max now. The governors will adjust later. *=
/
> -       policy->cur =3D cppc_cpufreq_perf_to_khz(cpu_data, caps->highest_=
perf);
> +       policy->cur =3D cppc_perf_to_khz(caps, caps->highest_perf);
>         cpu_data->perf_ctrls.desired_perf =3D  caps->highest_perf;
>
>         ret =3D cppc_set_perf(cpu, &cpu_data->perf_ctrls);
> @@ -863,7 +770,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned in=
t cpu)
>         delivered_perf =3D cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
>                                                &fb_ctrs_t1);
>
> -       return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
> +       return cppc_perf_to_khz(&cpu_data->perf_caps, delivered_perf);
>  }
>
>  static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int sta=
te)
> @@ -878,11 +785,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_po=
licy *policy, int state)
>         }
>
>         if (state)
> -               policy->max =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                      caps->highest_perf=
);
> +               policy->max =3D cppc_perf_to_khz(caps,
> +                                              caps->highest_perf);
>         else
> -               policy->max =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                      caps->nominal_perf=
);
> +               policy->max =3D cppc_perf_to_khz(caps,
> +                                              caps->nominal_perf);
>         policy->cpuinfo.max_freq =3D policy->max;
>
>         ret =3D freq_qos_update_request(policy->max_freq_req, policy->max=
);
> @@ -937,7 +844,7 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsign=
ed int cpu)
>         if (ret < 0)
>                 return -EIO;
>
> -       return cppc_cpufreq_perf_to_khz(cpu_data, desired_perf);
> +       return cppc_perf_to_khz(&cpu_data->perf_caps, desired_perf);
>  }
>
>  static void cppc_check_hisi_workaround(void)
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6126c977ece0..3a0995f8bce8 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -144,6 +144,8 @@ extern int cppc_set_perf(int cpu, struct cppc_perf_ct=
rls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
>  extern bool cppc_perf_ctrs_in_pcc(void);
> +extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsign=
ed int perf);
> +extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsign=
ed int freq);
>  extern bool acpi_cpc_valid(void);
>  extern bool cppc_allow_fast_switch(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_d=
ata);
> --
> 2.34.1
>

