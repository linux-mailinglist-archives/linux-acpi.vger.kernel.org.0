Return-Path: <linux-acpi+bounces-402-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797937B728F
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 27495280FEE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF233D961
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:32:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152EEDDC2
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 19:37:39 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DB593;
	Tue,  3 Oct 2023 12:37:37 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57c0775d4fcso247697eaf.0;
        Tue, 03 Oct 2023 12:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361856; x=1696966656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ccmlGy2Mpj0agjQaoiAjTBgUHjd8WbboN2wDRrBQbg=;
        b=LlsSPt26JISEpGag6HeTAQpvi7Aa/EkpTUJt8ombYWdkWjaOSTI5AVlTqU5vLj5cqn
         N6i0dZx+0EpBDm+F0odXUuK9T/PBm+TxqJoI2E13oOzr5BwwC08OJuT4olQJV3ucO9mO
         8M/HzmmLbGO9C5R+1Q3RkjnIlDAmYPLBl4Nq2NqFkkoC8wnWLZ4loTlLx4xez15FtIDw
         QGiGxzDAuKwfyyirhhqhTtsxBoKEBNnqDY2Ej3/jF4TWRhnVJI9bl3ptCjLnyrqkdweQ
         t0wrRBCWNySHoER8TFXETe+iW/4j00sKswDl0tjTgelQFrn1mj2tAN04R92wYMi9dZgq
         HiZw==
X-Gm-Message-State: AOJu0YwPrZipZFmF0ezf8neM2hmXVdTmIAjBXoP03lrOVYhtTyiyrN19
	Ag/WMQPLf3FyiNQ04x0kfChQ/O35inA2bP6CkxY=
X-Google-Smtp-Source: AGHT+IF3oODQUXaNEPqSf6bmGVF6R0EdPJYjwRcvO3GRYaMIcE+m3TwW5hNlj6m3JTup0r+51tg6Er90fnuKyxV1OnU=
X-Received: by 2002:a4a:d097:0:b0:57b:7e31:c12 with SMTP id
 i23-20020a4ad097000000b0057b7e310c12mr317457oor.1.1696361856385; Tue, 03 Oct
 2023 12:37:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230913164659.9345-1-sumitg@nvidia.com> <20230913164659.9345-3-sumitg@nvidia.com>
In-Reply-To: <20230913164659.9345-3-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2023 21:37:25 +0200
Message-ID: <CAJZ5v0jcaskAa0DF3YjMEv=12d7bVst01iGKnKeVnhoUuOj6hQ@mail.gmail.com>
Subject: Re: [Patch v2 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org, 
	treding@nvidia.com, jonathanh@nvidia.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, sanjayc@nvidia.com, 
	ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com, 
	bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 13, 2023 at 6:47=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
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
>  drivers/acpi/processor_thermal.c | 41 +++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_th=
ermal.c
> index b7c6287eccca..30f2801abce6 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -26,7 +26,16 @@
>   */
>
>  #define CPUFREQ_THERMAL_MIN_STEP 0
> -#define CPUFREQ_THERMAL_MAX_STEP 3
> +
> +static int cpufreq_thermal_max_step =3D 3;

__read_mostly I suppose?

> +
> +/*
> + * Minimum throttle percentage for processor_thermal cooling device.

+ *

> + * The processor_thermal driver uses it to calculate the percentage amou=
nt by
> + * which cpu frequency must be reduced for each cooling state. This is a=
lso used
> + * to calculate the maximum number of throttling steps or cooling states=
.
> + */
> +static int cpufreq_thermal_pctg =3D 20;

__read_mostly here too?

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
> @@ -126,10 +136,35 @@ static int cpufreq_set_cur_state(unsigned int cpu, =
int state)
>         return 0;
>  }
>

#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY

> +#define SMCCC_SOC_ID_T241      0x036b0241
> +
> +void acpi_thermal_cpufreq_config_nvidia(void)

static void ?

> +{
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +       s32 soc_id =3D arm_smccc_get_soc_id_version();
> +
> +       /* Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) */
> +       if ((soc_id < 0) || (soc_id !=3D SMCCC_SOC_ID_T241))

Inner parens are redundant.

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
> +       cpufreq_thermal_max_step =3D ((100 / cpufreq_thermal_pctg) - 1);

Outer parens are redundant.

> +#endif
> +}

#else
static inline void void acpi_thermal_cpufreq_config_nvidia(void) {}
#endif

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

And patch [1/2] needs to be rebased on the current ACPI thermal
material in linux-next.

Thanks!

