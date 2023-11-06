Return-Path: <linux-acpi+bounces-1264-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1E57E26EB
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 15:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485671C2085C
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA328DA7
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Nov 2023 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4BC1799E
	for <linux-acpi@vger.kernel.org>; Mon,  6 Nov 2023 14:26:28 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E8DF;
	Mon,  6 Nov 2023 06:26:25 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b2d9a9c824so873761b6e.0;
        Mon, 06 Nov 2023 06:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280785; x=1699885585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b56u0WaEQeITXS0hleeBCMhAKd5IZuufQZDWVLUnIEI=;
        b=Ik4Z5idXOD4Xbi+xZIcVdafkHx1pqI93XQO9ULRURoJJ+4MYfCvHadL2rM1cBAm0M7
         j+2npgEBWS/H0wM/1KowJfl47apyCdrtq3llijwprhs2GXjmnoB45tOi+PcWHllLWE/I
         xFJxBaWZ0dI3KyBDX9aKyTKUA949P1z5c0n78IwRFEgk8yoz9FUvOpqkrWItx5ihP1pC
         J2R2gQr7f8z7Ev3GyugRxsnGI1cE5F4mIZzJb4vo0Vy4nGXabwg8Y8uLT0rMxJ6S/lLP
         PLmiwIJA9gB+4XCdd/qduSJFcBnER0sLyUdTRtA+HCcwRhWwRqqon0QPdkgw2YDdX0c4
         gTdw==
X-Gm-Message-State: AOJu0Yx+4TuN2iH6V4x+9PaFSK3K1rYa0CriCPuZefTSHyjnPFUbW8BV
	trwKkis3xQ1yyauPTuwYyN8U9FIDxF9BpfnILAF34jWM
X-Google-Smtp-Source: AGHT+IFfaJW3GERgkYJsdiLf7B/IDjTeXsuU75TeeNUYD+P7/0OmNuYaTH2Gec1TGE3TQVgxCzNT1+NT9fzGUpvzn60=
X-Received: by 2002:a05:6808:1b11:b0:3b2:efd3:e78c with SMTP id
 bx17-20020a0568081b1100b003b2efd3e78cmr34018633oib.1.1699280784738; Mon, 06
 Nov 2023 06:26:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231104105907.1365392-1-vincent.guittot@linaro.org> <20231104105907.1365392-6-vincent.guittot@linaro.org>
In-Reply-To: <20231104105907.1365392-6-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Nov 2023 15:26:13 +0100
Message-ID: <CAJZ5v0iShk--0LJQRrpnAx_Bf-MKvpN9qKy_3UqebHuC-xJKmQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] cpufreq/cppc: Move and rename cppc_cpufreq_{perf_to_khz|khz_to_perf}
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, ionela.voinescu@arm.com, pierre.gondois@arm.com, 
	beata.michalska@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	conor.dooley@microchip.com, suagrfillet@gmail.com, ajones@ventanamicro.com, 
	lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 4, 2023 at 11:59=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Move and rename cppc_cpufreq_perf_to_khz and cppc_cpufreq_khz_to_perf to
> use them outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
>
> Modify the interface to use struct cppc_perf_caps *caps instead of
> struct cppc_cpudata *cpu_data as we only use the fields of cppc_perf_caps=
.
>
> cppc_cpufreq was converting the lowest and nominal freq from MHz to kHz
> before using them. We move this conversion inside cppc_perf_to_khz and
> cppc_khz_to_perf to make them generic and usable outside cppc_cpufreq.
>
> No functional change
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/cppc_acpi.c       | 104 ++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 139 ++++-----------------------------
>  include/acpi/cppc_acpi.h       |   2 +
>  3 files changed, 123 insertions(+), 122 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 7ff269a78c20..d155a86a8614 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -39,6 +39,9 @@
>  #include <linux/rwsem.h>
>  #include <linux/wait.h>
>  #include <linux/topology.h>
> +#include <linux/dmi.h>
> +#include <linux/units.h>
> +#include <asm/unaligned.h>
>
>  #include <acpi/cppc_acpi.h>
>
> @@ -1760,3 +1763,104 @@ unsigned int cppc_get_transition_latency(int cpu_=
num)
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
> +       return KHZ_PER_MHZ * mhz;
> +}
> +
> +/*
> + * If CPPC lowest_freq and nominal_freq registers are exposed then we ca=
n
> + * use them to convert perf to freq and vice versa. The conversion is
> + * extrapolated as an affine function passing by the 2 points:
> + *  - (Low perf, Low freq)
> + *  - (Nominal perf, Nominal freq)
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
> +               mul *=3D KHZ_PER_MHZ;
> +               div =3D caps->nominal_perf - caps->lowest_perf;
> +               offset =3D caps->nominal_freq * KHZ_PER_MHZ -
> +                        div64_u64(caps->nominal_perf * mul, div);
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
> +               /*
> +                * We don't need to convert to kHz for computing offset a=
nd can
> +                * directly use nominal_freq and lowest_freq as the div64=
_u64
> +                * will remove the frequency unit.
> +                */
> +               offset =3D caps->nominal_perf -
> +                        div64_u64(caps->nominal_freq * mul, div);
> +               /* But we need it for computing the perf level. */
> +               div *=3D KHZ_PER_MHZ;
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
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufre=
q.c
> index fe08ca419b3d..64420d9cfd1e 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -16,7 +16,6 @@
>  #include <linux/delay.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> -#include <linux/dmi.h>
>  #include <linux/irq_work.h>
>  #include <linux/kthread.h>
>  #include <linux/time.h>
> @@ -27,12 +26,6 @@
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
> @@ -291,97 +284,9 @@ static inline void cppc_freq_invariance_exit(void)
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
> @@ -389,7 +294,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_pol=
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
> @@ -417,7 +322,7 @@ static unsigned int cppc_cpufreq_fast_switch(struct c=
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
> @@ -530,7 +435,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
>         min_step =3D min_cap / CPPC_EM_CAP_STEP;
>         max_step =3D max_cap / CPPC_EM_CAP_STEP;
>
> -       perf_prev =3D cppc_cpufreq_khz_to_perf(cpu_data, *KHz);
> +       perf_prev =3D cppc_khz_to_perf(perf_caps, *KHz);
>         step =3D perf_prev / perf_step;
>
>         if (step > max_step)
> @@ -550,8 +455,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
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
> @@ -561,8 +466,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
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
> @@ -591,7 +496,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, =
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
> @@ -679,10 +584,6 @@ static struct cppc_cpudata *cppc_cpufreq_get_cpu_dat=
a(unsigned int cpu)
>                 goto free_mask;
>         }
>
> -       /* Convert the lowest and nominal freq from MHz to KHz */
> -       cpu_data->perf_caps.lowest_freq *=3D 1000;
> -       cpu_data->perf_caps.nominal_freq *=3D 1000;
> -
>         list_add(&cpu_data->node, &cpu_data_list);
>
>         return cpu_data;
> @@ -724,20 +625,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_pol=
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
> +       policy->min =3D cppc_perf_to_khz(caps, caps->lowest_nonlinear_per=
f);
> +       policy->max =3D cppc_perf_to_khz(caps, caps->nominal_perf);
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
> +       policy->cpuinfo.min_freq =3D cppc_perf_to_khz(caps, caps->lowest_=
perf);
> +       policy->cpuinfo.max_freq =3D cppc_perf_to_khz(caps, caps->nominal=
_perf);
>
>         policy->transition_delay_us =3D cppc_cpufreq_get_transition_delay=
_us(cpu);
>         policy->shared_type =3D cpu_data->shared_type;
> @@ -773,7 +670,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_polic=
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
> @@ -863,7 +760,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned in=
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
> @@ -878,11 +775,9 @@ static int cppc_cpufreq_set_boost(struct cpufreq_pol=
icy *policy, int state)
>         }
>
>         if (state)
> -               policy->max =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                      caps->highest_perf=
);
> +               policy->max =3D cppc_perf_to_khz(caps, caps->highest_perf=
);
>         else
> -               policy->max =3D cppc_cpufreq_perf_to_khz(cpu_data,
> -                                                      caps->nominal_perf=
);
> +               policy->max =3D cppc_perf_to_khz(caps, caps->nominal_perf=
);
>         policy->cpuinfo.max_freq =3D policy->max;
>
>         ret =3D freq_qos_update_request(policy->max_freq_req, policy->max=
);
> @@ -937,7 +832,7 @@ static unsigned int hisi_cppc_cpufreq_get_rate(unsign=
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

