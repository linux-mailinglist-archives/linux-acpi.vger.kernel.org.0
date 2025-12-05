Return-Path: <linux-acpi+bounces-19445-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24AACA827F
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 16:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACABF3036B26
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9DD2DECBD;
	Fri,  5 Dec 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwywkSkO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF472F99A3
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947617; cv=none; b=RC76dJzF3Lo+WphV/CJY2CwjhZsXBqCU1yJI/XQeEguNt7IXtwhl2O4g3zaXI7Juj5RVYah4MMPyqtc2l1RYVyBY+xOzS0VcJwfI0WMiRsjT/Eadp7RdlfpxNsF1pIFWlmQNmLoFL4swxgnxbk0rlX6l+JtaPp9wk9sA/8nJZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947617; c=relaxed/simple;
	bh=gToDeN6Xc25jVYcui6qGpeppUtC7Whn5YW0S6Qumrkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2kDfwu+BqVNLYmTyi2f5fqG8k+M4z3Ko/sxp0jXN7CWOwaOq37Zi/ATBzWU3JG/w3nQs3RQlvLqI0eK8t1ov23VkqofpdUDH0jCOQmmShm6CS7QZRWUfl3ceaQiZCxtBq7VVV7+jRFC4P8nH9QxlnVTK9n5lojY5Mf4BCiuXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwywkSkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD97C2BCAF
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 15:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764947616;
	bh=gToDeN6Xc25jVYcui6qGpeppUtC7Whn5YW0S6Qumrkk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pwywkSkOrM9W497oFGAp6bFMeHPHsAjetaQ83LHhMMByeP58M7PlIeS9uS/+7tSVH
	 kbrv4yuLV4F4i/vb3BpgP+xlgLcde2S2TWOz+WK6P6aB7DgSQG0Sk5irxZQKNehrWa
	 a0DKNRR6xFd55jAEh6d0ME2x9mPMrnIFeRPyqFYXb1Q53x97tscyjnATwpuXOxlSQn
	 Oug5c5Si0KpXD1n2c07GZukXOv0lpK9cOSfFGY/siQ5v7WUZRDkD+Oy6/ZkAi/2tFl
	 ngsOZZwhYcnGVmkdqem/UUJiqhxVb6mmL3K6IpAlYsdtOG7a4Rznje4JGIAK8J+GJu
	 aBxYg6z3ZIFbQ==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c76607b968so972956a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 07:13:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9JrU01Od8IBbXxZe74gir7iShzIPc8QhDtZpXdehjF5pIGoo5uuyeNhMs0C+iKA6DhsGvTTVJRZ5K@vger.kernel.org
X-Gm-Message-State: AOJu0YzuN33cZrkFA/cmVrZRys17SaDg8AEH6f10p5ZSYvEJNv753/dd
	wtvffC9kEKvQuPnTM7Km5akE07x2wKiBa4qouqJWV7xraZaRnXOx2MipBnJ7lrKBEMG/UiWkJ/3
	nRBbodnUyuYabD4aF/hmugvTeFyGlOBM=
X-Google-Smtp-Source: AGHT+IHrXWrqtMGXJxmwV1GVuCRVKcQU0z6/rzwbxUJ6/BP2yyYwuq+UjnxGK8r3GeEdRUHh75+CQgXDFSasFrCHpBs=
X-Received: by 2002:a05:6830:719c:b0:7c5:3798:fa4e with SMTP id
 46e09a7af769-7c94dc0bf51mr8467872a34.17.1764947615507; Fri, 05 Dec 2025
 07:13:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com> <20251203032422.3232957-2-zhanjie9@hisilicon.com>
In-Reply-To: <20251203032422.3232957-2-zhanjie9@hisilicon.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Dec 2025 16:13:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvk+gs+h+76__LLZDa=OGzLxQQsWEMDHXzeV8aV6UYsA@mail.gmail.com>
X-Gm-Features: AWmQ_bmOH7nN5gWZs3xRPWHos4wTiEv97BodDPulN0JnoJDgcE3MNy86R_44060
Message-ID: <CAJZ5v0jvk+gs+h+76__LLZDa=OGzLxQQsWEMDHXzeV8aV6UYsA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: viresh.kumar@linaro.org, rafael@kernel.org, ionela.voinescu@arm.com, 
	beata.michalska@arm.com, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, yubowen8@huawei.com, 
	lihuisong@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 4:25=E2=80=AFAM Jie Zhan <zhanjie9@hisilicon.com> wr=
ote:
>
> Factor out cppc_perf_ctrs_in_pcc_cpu() for checking whether per-cpu CPC
> regs are defined in PCC channels, and export it out for further use.
>
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++-------------------
>  include/acpi/cppc_acpi.h |  5 +++++
>  2 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3bdeeee3414e..aa80dbcf42c0 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1422,6 +1422,29 @@ int cppc_get_perf_caps(int cpunum, struct cppc_per=
f_caps *perf_caps)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>
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
> +       if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
> +           CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
> +           CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
> +           CPC_IN_PCC(ref_perf_reg))
> +               return true;
> +
> +       return false;

Why not

return CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
          CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
          CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
          CPC_IN_PCC(ref_perf_reg);

> +}
> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
> +
>  /**
>   * cppc_perf_ctrs_in_pcc - Check if any perf counters are in a PCC regio=
n.
>   *
> @@ -1436,27 +1459,7 @@ bool cppc_perf_ctrs_in_pcc(void)
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
>

