Return-Path: <linux-acpi+bounces-480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE27BBCE2
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 18:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3641C20833
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4628E07
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426EA26E0D
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 15:53:12 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18A0E4;
	Fri,  6 Oct 2023 08:53:09 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3a707bc2397so311050b6e.0;
        Fri, 06 Oct 2023 08:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696607589; x=1697212389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4GYgflDwY9AuDhmEVpfbOPUfQRD0KvYicGzoyRixaE=;
        b=SDcovMXKlUqUNzs5xvGsBGBZpip09eJd7LhAR0c/FInBgaQE6RtCB5y9AfzmyoLGtf
         sogA+2f3HuRju001i0ZsewEVnkPRcC56ScYZv7/3Kv4waQhCxdC0VCsry7O4zL8EJarn
         QNbPN3vFUwJV2TuABw0MYJ1vhjRsKSNSVfCR8njFIkI/JIxxg3t6I0UWGRD/kTLesip1
         yX3FP9VSLME5WcE8glX1nSE2oEd63MIs8+5GLzJVLYoSGNJ5FA9kk6jTm0AgTHpH8Ggt
         8lVlsWsG88nbuOlP8WhrW/JMVohSKW6etDmq3xNhCssXuzc5QJ/wweK5lkB0YzGZ1T/r
         TQwQ==
X-Gm-Message-State: AOJu0YzT+rr7Y5uVruTobE/gSeuhwbk27+p8vQjcWQcAxuYoJBvB391O
	MI0Gx79WDwPchpufFfQTp6ygS3YQ+ZghzvsFV2M=
X-Google-Smtp-Source: AGHT+IGwjjMU7Kix3QO5gneyMiBpwwPu7LhwNJ17iovpWcMNERJhnIv/vUsETuzupb7BXubbyc5O+KLB7JIiDdpi6Sw=
X-Received: by 2002:a4a:df07:0:b0:57b:73f6:6f80 with SMTP id
 i7-20020a4adf07000000b0057b73f66f80mr9078256oou.0.1696607589020; Fri, 06 Oct
 2023 08:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006153612.5851-1-sumitg@nvidia.com> <20231006153612.5851-3-sumitg@nvidia.com>
In-Reply-To: <20231006153612.5851-3-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Oct 2023 17:52:58 +0200
Message-ID: <CAJZ5v0gneBtF8-cwMEtNAA2jBjQxzEc4N4feLDk70rngTSAOaw@mail.gmail.com>
Subject: Re: [Patch v3 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, bbasu@nvidia.com, sanjayc@nvidia.com, 
	ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 5:36=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wrot=
e:
>
> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>
> Current implementation of processor_thermal performs software throttling
> in fixed steps of "20%" which can be too coarse for some platforms.
> We observed some performance gain after reducing the throttle percentage.
> Change the CPUFREQ thermal reduction percentage and maximum thermal steps
> to be configurable. Also, update the default values of both for Nvidia
> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
> and accordingly the maximum number of thermal steps are increased as they
> are derived from the reduction percentage.
>
> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/processor_thermal.c | 43 +++++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_th=
ermal.c
> index b7c6287eccca..677ba8bc3fbc 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -26,7 +26,16 @@
>   */
>
>  #define CPUFREQ_THERMAL_MIN_STEP 0
> -#define CPUFREQ_THERMAL_MAX_STEP 3
> +
> +static int cpufreq_thermal_max_step __read_mostly =3D 3;
> +
> +/*
> + * Minimum throttle percentage for processor_thermal cooling device.
> + * The processor_thermal driver uses it to calculate the percentage amou=
nt by
> + * which cpu frequency must be reduced for each cooling state. This is a=
lso used
> + * to calculate the maximum number of throttling steps or cooling states=
.
> + */
> +static int cpufreq_thermal_pctg __read_mostly =3D 20;
>
>  static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
>
> @@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
>         if (!cpu_has_cpufreq(cpu))
>                 return 0;
>
> -       return CPUFREQ_THERMAL_MAX_STEP;
> +       return cpufreq_thermal_max_step;
>  }
>
>  static int cpufreq_get_cur_state(unsigned int cpu)
> @@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, in=
t state)
>                 if (!policy)
>                         return -EINVAL;
>
> -               max_freq =3D (policy->cpuinfo.max_freq * (100 - reduction=
_pctg(i) * 20)) / 100;
> +               max_freq =3D (policy->cpuinfo.max_freq *
> +                           (100 - reduction_pctg(i) * cpufreq_thermal_pc=
tg)) / 100;
>
>                 cpufreq_cpu_put(policy);
>
> @@ -126,10 +136,37 @@ static int cpufreq_set_cur_state(unsigned int cpu, =
int state)
>         return 0;
>  }
>
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +#define SMCCC_SOC_ID_T241      0x036b0241
> +
> +static void acpi_thermal_cpufreq_config_nvidia(void)
> +{
> +       s32 soc_id =3D arm_smccc_get_soc_id_version();
> +
> +       /* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
> +       if (soc_id < 0 || soc_id !=3D SMCCC_SOC_ID_T241)
> +               return;
> +
> +       /* Reduce the CPUFREQ Thermal reduction percentage to 5% */
> +       cpufreq_thermal_pctg =3D 5;
> +
> +       /*
> +        * Derive the MAX_STEP from minimum throttle percentage so that t=
he reduction
> +        * percentage doesn't end up becoming negative. Also, cap the MAX=
_STEP so that
> +        * the CPU performance doesn't become 0.
> +        */
> +       cpufreq_thermal_max_step =3D (100 / cpufreq_thermal_pctg) - 1;
> +}

Looks better now, but one more thing: This is introducing an
ARM-specific piece of code into an otherwise generic file and there is
drivers/acpi/arm64/ for ARM-specific code, so I would very much prefer
this piece of code to go there.

Of course, it won't be able to modify the static variables directly
then, but what if instead it defines functions to return the
appropriate values?

The variables in question could be initialized with the help of those
functions then.

> +#else
> +static inline void acpi_thermal_cpufreq_config_nvidia(void) {}
> +#endif
> +
>  void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
>  {
>         unsigned int cpu;
>
> +       acpi_thermal_cpufreq_config_nvidia();
> +
>         for_each_cpu(cpu, policy->related_cpus) {
>                 struct acpi_processor *pr =3D per_cpu(processors, cpu);
>                 int ret;
> --
> 2.17.1
>

