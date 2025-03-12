Return-Path: <linux-acpi+bounces-12136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76722A5E4D6
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 20:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DC23BDD8C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Mar 2025 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDCE1F0E4A;
	Wed, 12 Mar 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhy+nLOc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF9B1E8823;
	Wed, 12 Mar 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809288; cv=none; b=jrYAVWYQN6qtUPbGY2LFWZeTUyb+1d42BQznEue2ylvEtcMfNV2GSHRAjIwA3XtaYX96LX2UCNPnAmk5w64bmoFfSWn18mTmWMZToY0YESJkl4nUwoCZzWrE9Y3sBDH59a5ZnYjTNSFre4tfa4thmze+JQH2pdYjMNH4j8rzYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809288; c=relaxed/simple;
	bh=lKt4v6B/Hv/DuheeaArB6L02/tBeX5Mg5/cRp3lVdsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWUiEHNO53szKVINZMODhWOtE7qlKNQchxx9veo42uciW/hI7vmATaskiVZVL+dEJaTD5DJTG1k4i0UDRdoCleXLBuc2ZVsrkPES++1xoNHl1606XkKh+rHLNC1z6UMB+ca1E8b4BOcI9bSCSUCDFjcYpHLLnfyxdTTgbr+nao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhy+nLOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21510C4CEEF;
	Wed, 12 Mar 2025 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741809288;
	bh=lKt4v6B/Hv/DuheeaArB6L02/tBeX5Mg5/cRp3lVdsU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rhy+nLOcuegG9GRsRnZfn4eUz+8IK92sp+r2Lnz20uoBfcf3B5PRZQuHld87R32Uy
	 7sWWdbWS6T1lIznmf34VIwwYxOXN8UHInoQ+5qmVzKMK61xvvrpv+CoGCG6Iev9M18
	 fmgtKmpE7yzAlAhA18cL0e/up9roNS/bW2tof5O/PFYf+dVMLrac3QZJXV78KTDbhs
	 gXl+V3CFiF7dQ6LxA+sPAZBNKDoeDifu7/G9VU69XxDj6Oz1gLDIWtD73m2Jg7M/Zn
	 EO1uMeC7kD//PfXKzVum72KWEBZw5oTs1FQv6r31Lg22J23zPxipMu7Y8yDNq98dJh
	 FakOuJ+EyyW1Q==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7275bc6638bso61952a34.2;
        Wed, 12 Mar 2025 12:54:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUClm2WZ7don+6qvgQUjzrhTOl7xzse8r1W4hQFoNuRyW4rjcN0DMBVLcRETIYXdzlMcIEapc9B1vcW@vger.kernel.org, AJvYcCUPIYbzK5VWJSBX+Oh3/CxpldpBbhSKYjVKH3qeDy0qhWDs3Mpxs6qAf8oybBJvIZiRvMJYTszkbpHs8H/7@vger.kernel.org, AJvYcCXVaHipkrVdVdZPO/Q07Boiq8Pc2JVHjWCnIrAgi/owdT7o4RYwqgS0/cmNv1sci6AtOAq1GDUY4EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYt3diDWdi5LUBcR3FS86os9Sgfn6qLWL+4bRasNr2XE/R/Bg3
	4jMhvpH3ikqAp5WT1pPfmnHS9FSWNr49iv7J1eI2Cv/uEbxSrPkulcHsRTDsZLVdG0Fokj1/l6G
	VBTDv0QYI81TOPdTjARKKJJyP1Dw=
X-Google-Smtp-Source: AGHT+IFWQ+68T4cDYbzYqN7yYRPuiErjeJlW/C3PqbsPHji5gMhp9e3GkwZlyvDgbgSTRVqkboScmEK2ysD6txHZ8lU=
X-Received: by 2002:a05:6830:314b:b0:72a:4804:77ff with SMTP id
 46e09a7af769-72a48047df7mr9950313a34.25.1741809287316; Wed, 12 Mar 2025
 12:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com> <20250206131428.3261578-4-zhenglifeng1@huawei.com>
In-Reply-To: <20250206131428.3261578-4-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 12 Mar 2025 20:54:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iNzNROkPD4+b=Au8DwdF9unajKivdRQMBFfwzjFxHLcg@mail.gmail.com>
X-Gm-Features: AQ5f1JoSmulRpnfW_hUqrLihklxgXLKWq2sUIv3vB-S-zZVKKZq8CTuYE0thOsU
Message-ID: <CAJZ5v0iNzNROkPD4+b=Au8DwdF9unajKivdRQMBFfwzjFxHLcg@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] ACPI: CPPC: Rename cppc_get_perf() to cppc_get_reg_val()
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, yumpusamongus@gmail.com, 
	srinivas.pandruvada@linux.intel.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 2:14=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.co=
m> wrote:
>
> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to rea=
d
> cppc registers. And extract the operations if register is in pcc out as
> cppc_get_reg_val_in_pcc(). Without functional change.

This should be split into two patches IMV.

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 66 +++++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index db22f8f107db..3c9c4ce2a0b0 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1189,48 +1189,52 @@ static int cpc_write(int cpu, struct cpc_register=
_resource *reg_res, u64 val)
>         return ret_val;
>  }
>
> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource=
 *reg, u64 *val)
>  {
> -       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> -       struct cpc_register_resource *reg;
> +       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> +       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> +       int ret;
>
> -       if (!cpc_desc) {
> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +       if (pcc_ss_id < 0) {
> +               pr_debug("Invalid pcc_ss_id\n");
>                 return -ENODEV;
>         }
>
> -       reg =3D &cpc_desc->cpc_regs[reg_idx];
> +       pcc_ss_data =3D pcc_data[pcc_ss_id];
>
> -       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
> -               pr_debug("CPC register (reg_idx=3D%d) is not supported\n"=
, reg_idx);
> -               return -EOPNOTSUPP;
> -       }

I'm not a big fan of the IS_OPTIONAL_CPC_REG() macro.  I'm not
convinced at all that it adds any value above (and in the next patch
for that matter) and the message printing the register index is just
plain unuseful to anyone who doesn't know how to decode it.

If CPC_SUPPORTED(reg) is not true, the register cannot be used AFAICS
regardless of what IS_OPTIONAL_CPC_REG() has to say about it.

> +       down_write(&pcc_ss_data->pcc_lock);
>
> -       if (CPC_IN_PCC(reg)) {
> -               int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> -               struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -               int ret;
> +       if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0)
> +               ret =3D cpc_read(cpu, reg, val);
> +       else
> +               ret =3D -EIO;
>
> -               if (pcc_ss_id < 0) {
> -                       pr_debug("Invalid pcc_ss_id\n");
> -                       return -ENODEV;
> -               }
> +       up_write(&pcc_ss_data->pcc_lock);
>
> -               pcc_ss_data =3D pcc_data[pcc_ss_id];
> +       return ret;
> +}
>
> -               down_write(&pcc_ss_data->pcc_lock);
> +static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
> +{
> +       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +       struct cpc_register_resource *reg;
>
> -               if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0)
> -                       ret =3D cpc_read(cpunum, reg, perf);
> -               else
> -                       ret =3D -EIO;
> +       if (!cpc_desc) {
> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +               return -ENODEV;
> +       }
>
> -               up_write(&pcc_ss_data->pcc_lock);
> +       reg =3D &cpc_desc->cpc_regs[reg_idx];
>
> -               return ret;
> +       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
> +               pr_debug("CPC register (reg_idx=3D%d) is not supported\n"=
, reg_idx);
> +               return -EOPNOTSUPP;
>         }
>
> -       return cpc_read(cpunum, reg, perf);
> +       if (CPC_IN_PCC(reg))
> +               return cppc_get_reg_val_in_pcc(cpu, reg, val);
> +
> +       return cpc_read(cpu, reg, val);
>  }
>
>  /**
> @@ -1242,7 +1246,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs=
 reg_idx, u64 *perf)
>   */
>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> -       return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
> +       return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>
> @@ -1255,7 +1259,7 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>   */
>  int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  {
> -       return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
> +       return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
>  }
>
>  /**
> @@ -1267,7 +1271,7 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_=
perf)
>   */
>  int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>  {
> -       return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +       return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>
> @@ -1280,7 +1284,7 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>   */
>  int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>  {
> -       return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
> +       return cppc_get_reg_val(cpunum, ENERGY_PERF, epp_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_epp_perf);
>
> --
> 2.33.0
>
>

