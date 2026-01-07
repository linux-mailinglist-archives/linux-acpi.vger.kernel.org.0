Return-Path: <linux-acpi+bounces-20018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 724E6CFFDF6
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 20:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E0DD30012E6
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D017257828;
	Wed,  7 Jan 2026 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/6eo/5z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9ADBA3F
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767815824; cv=none; b=ab0nw5/1CfQevOFxqhe4nQRFQZ8kEPy5x1yk8kS0TROUFqwAHT3xEbqeTlyJ5e35kzicn/7H6qigGb2vrnHVG2JiTCzpIH/67J8LzAePBQ6+ymZpo3elOClUlC3j2prxQSul8TqDxmg8PqleGXjOkGWuUbJhnIe/iCqeCOUAaZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767815824; c=relaxed/simple;
	bh=+VBjyrmdJBHXv8hFipAjm6s+ntR7S0VRhaAQ6AcLC0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEkYr6ISda0D3Dryl57Mit2qcE7RsfMMZPJ4fKhgT7DGEx7fUqNeW6p1Lv7SwvuEKthyX09XVDgzc7/i/0ZYkiurayyc4QkPOqre3P3PH9PIcPllVrnzE9YXomJ1U7lyG0CUG5b9DAzSLFeahkc6oDbjiwAXRjwtpIaJOhECtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/6eo/5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A204FC2BCB2
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767815823;
	bh=+VBjyrmdJBHXv8hFipAjm6s+ntR7S0VRhaAQ6AcLC0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o/6eo/5zs0RzXoNw5Ej9A45/1N5wStTrAkCwQJWGqcoSZmcUnd0Z+L8dzDyqux/GG
	 ger8d/1SVEIuBfiPbwUxUkYxfVj0akHUvCUlocVWEA8dJaJC5vdVoWraq4QHCwzVZi
	 c6OnRnVP8IR4n3fzJ8l/g30EYVO2t76gGhU9k8apkzF3INh5cvFLIt4EPOYZYEygP6
	 c1Hw+qRhRR6Ojb0vcyb12O2+HtxkUvGGQAKCcLcYSYMG88umzmcSGlWd+3DLCdiYp6
	 qebF5+mJkvX8Xyu98keGoBpNtnJgsfXLvLQGeJaYIMd+0ehCz09TPbUe7YoOkSWy2l
	 hWDVOXgWQQT1g==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3e8819eda8bso915663fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 11:57:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9etF4rUc6mT1vT0vEoN0iNYjKcMl/DMx3L439+O/jdyDAE/HO0aXmLOwb+KF5EALk4tZ63I4uy2TW@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRFP6T3XEz6xlE7hIa5X0l8vrttsHqdnFSzIo+Aj9itngqlhw
	oAe/7zFWNr3op8NDSzAoOQVavy63h3cqrmjRJW1vtiSi2CFeR9EGU67owsDR1x023pVdFVKghBu
	KdYD2OHwXEtCnyQGR9aGvERDPTJ/nazc=
X-Google-Smtp-Source: AGHT+IGD121X1TOzfCHSPDnImhpxYxlydTwNjoEEqXnErTuAQNSSQWGE9TltWwcuH40GRao6lXf2ebmHYSFBy+rTjm0=
X-Received: by 2002:a4a:da4c:0:b0:65b:387a:835f with SMTP id
 006d021491bc7-65f54ef230dmr1210110eaf.31.1767815822629; Wed, 07 Jan 2026
 11:57:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223072119.3372582-1-zhanjie9@hisilicon.com> <20251223072119.3372582-2-zhanjie9@hisilicon.com>
In-Reply-To: <20251223072119.3372582-2-zhanjie9@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 20:56:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_1nM3S93prH60VPkicQSdH_gzh7VkXHNCzfLq-aLP-Q@mail.gmail.com>
X-Gm-Features: AQt7F2qmAPuD1J1j6UNwANWUUqw4-V9DUtSrJcD5sPI_qu_DLnXIVN8OvdSsCC8
Message-ID: <CAJZ5v0h_1nM3S93prH60VPkicQSdH_gzh7VkXHNCzfLq-aLP-Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: viresh.kumar@linaro.org, rafael@kernel.org, ionela.voinescu@arm.com, 
	beata.michalska@arm.com, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, yubowen8@huawei.com, 
	lihuisong@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 8:23=E2=80=AFAM Jie Zhan <zhanjie9@hisilicon.com> w=
rote:
>
> Factor out cppc_perf_ctrs_in_pcc_cpu() for checking whether per-cpu CPC
> regs are defined in PCC channels, and export it out for further use.
>
> Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and I'd prefer Viresh to take care of this along with the other two
patches in the series.

> ---
>  drivers/acpi/cppc_acpi.c | 48 ++++++++++++++++++++++------------------
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 32 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index e66e20d1f31b..22d7fd669a6c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1423,6 +1423,32 @@ int cppc_get_perf_caps(int cpunum, struct cppc_per=
f_caps *perf_caps)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>
> +/**
> + * cppc_perf_ctrs_in_pcc_cpu - Check if any perf counters of a CPU are i=
n PCC.
> + * @cpu: CPU on which to check perf counters.
> + *
> + * Return: true if any of the counters are in PCC regions, false otherwi=
se
> + */
> +bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
> +{
> +       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +       struct cpc_register_resource *ref_perf_reg;
> +
> +       /*
> +        * If reference perf register is not supported then we should use=
 the
> +        * nominal perf value
> +        */
> +       ref_perf_reg =3D &cpc_desc->cpc_regs[REFERENCE_PERF];
> +       if (!CPC_SUPPORTED(ref_perf_reg))
> +               ref_perf_reg =3D &cpc_desc->cpc_regs[NOMINAL_PERF];
> +
> +       return CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> +               CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> +               CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
> +               CPC_IN_PCC(ref_perf_reg);
> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
> +
>  /**
>   * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC regio=
n.
>   *
> @@ -1437,27 +1463,7 @@ bool cppc_perf_ctrs_in_pcc(void)
>         int cpu;
>
>         for_each_online_cpu(cpu) {
> -               struct cpc_register_resource *ref_perf_reg;
> -               struct cpc_desc *cpc_desc;
> -
> -               cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> -
> -               if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> -                   CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> -                   CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]))
> -                       return true;
> -
> -
> -               ref_perf_reg =3D &cpc_desc->cpc_regs[REFERENCE_PERF];
> -
> -               /*
> -                * If reference perf register is not supported then we sh=
ould
> -                * use the nominal perf value
> -                */
> -               if (!CPC_SUPPORTED(ref_perf_reg))
> -                       ref_perf_reg =3D &cpc_desc->cpc_regs[NOMINAL_PERF=
];
> -
> -               if (CPC_IN_PCC(ref_perf_reg))
> +               if (cppc_perf_ctrs_in_pcc_cpu(cpu))
>                         return true;
>         }
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 13fa81504844..4bcdcaf8bf2c 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -154,6 +154,7 @@ extern int cppc_get_perf_ctrs(int cpu, struct cppc_pe=
rf_fb_ctrs *perf_fb_ctrs);
>  extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  extern int cppc_set_enable(int cpu, bool enable);
>  extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
> +extern bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu);
>  extern bool cppc_perf_ctrs_in_pcc(void);
>  extern unsigned int cppc_perf_to_khz(struct cppc_perf_caps *caps, unsign=
ed int perf);
>  extern unsigned int cppc_khz_to_perf(struct cppc_perf_caps *caps, unsign=
ed int freq);
> @@ -204,6 +205,10 @@ static inline int cppc_get_perf_caps(int cpu, struct=
 cppc_perf_caps *caps)
>  {
>         return -EOPNOTSUPP;
>  }
> +static inline bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
> +{
> +       return false;
> +}
>  static inline bool cppc_perf_ctrs_in_pcc(void)
>  {
>         return false;
> --
> 2.33.0
>

