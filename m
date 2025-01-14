Return-Path: <linux-acpi+bounces-10638-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C9A10DFA
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379B17A2277
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E51F9A81;
	Tue, 14 Jan 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2maKCJR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CE41C1F0C;
	Tue, 14 Jan 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876514; cv=none; b=Bas9Via+XU/49mhA6R0Cc0RkMkcbXZpW2j/rYSM702Z0MaDJTdTvw6tooT/vgeeuzFykdGtl9YrdFgCDkvOmAg7uMSyW19Id+VZ0/zeyPpBiVtLSUpWNL5HFgv7dmUjV7MFPF+GL/NC9jpjUh/wNN4wwCRsF2lctnxBPyINAnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876514; c=relaxed/simple;
	bh=wEZ8dT0PZlqi23JTZp0cFDZB2rKwqMi5MSkO0O3iaA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZrp/MeUpKaShh72mR5PE4R/9HF6aPgU8dZ+23Ru8AdJ94ZKS1uV8e0vAOAY/WtGZwXTa4xIJmztLsffMS8OG+FHvOtJfnz7HH1T3XVKp7QF92lFRuQFY8sSy/C57ksMwBqJjCthWSSotCENj/vT+0DJ17RFcyNq/Xb3csZoQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2maKCJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FCBC4CEEA;
	Tue, 14 Jan 2025 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736876513;
	bh=wEZ8dT0PZlqi23JTZp0cFDZB2rKwqMi5MSkO0O3iaA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G2maKCJRVBC9PJ9l5yk23xrB+p1QZgJN9W4TMuYPefS+VKPM0bB4di7zZMdqn6gCy
	 iaEkT1sFcFbePj9LEYlpoMs7pV1qIXet2tXTaUojKrFDUrUzuPiAHHKsOLbfHZ9T/7
	 QudBLr+nuF2h0/pq2MkwnJM6QHRT5GGsN3XDQoGwEXJ8iR69GHLasgfp7Z/QK3KyJL
	 CSNabMbm4jdtGgL2rFdGwm+kxQpywjDqP2N9YwoFCSJjJ+5iCqcVMfRGfehURfHyLN
	 rQ49VGWcsoHt2hRJZNu85eabwldnYByNkQG0o6x0OHHbHoQICCpyBDZ7A6uqPAO4G+
	 8erPK8H+GqDKA==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eba347aa6fso3582502b6e.3;
        Tue, 14 Jan 2025 09:41:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiFglV6fLqaBG1s361b4ktXntHLlAj9eQ1OGQ6dCUgOz3lOBOD31Ce/mkyF3+/5+2Pb6rvzSO+5ssiLGxq@vger.kernel.org, AJvYcCVh/dz7iYcG2OriFCC1mLsAFaCydXwseKe7EuuYH6jn1Gn2Zs+opoLP4q6M9WrD4ZLbWa7KH/z0Hwa8@vger.kernel.org, AJvYcCWiZyLf57/UPX9MbShrrbjgjoqLPOZJIgVjo8nwZ3Vx0T8d7kl3/BUfmjDUNqaH+vtZq+LnxMJ1/aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJXEd7p4oOp30fkjV9nocaLejqByKBpuephW8A6iLNbP7FhAe
	TxLO6SZEXpSHIcVVUJ6w/btsPOwc/O05jNVCNo4ksdZ+BT7ANWrG0sQUEKXkX4yh4hT+4mYmJZ0
	E2uQ/WqGLcwVbvTTl3PCFZ4HWJO4=
X-Google-Smtp-Source: AGHT+IFI+C4ErCM+V60/ozQiwwdOhrIiiwCSVSrl7STdX5BXIOvWCSlRs093HMXawDQKMjebU7/Z3HIZiz8CB+eY11A=
X-Received: by 2002:a05:6808:13d0:b0:3e7:b3d9:4109 with SMTP id
 5614622812f47-3ef2ec6c8a3mr17185301b6e.22.1736876513104; Tue, 14 Jan 2025
 09:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com> <20250113122104.3870673-3-zhenglifeng1@huawei.com>
In-Reply-To: <20250113122104.3870673-3-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 18:41:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g5vuO9jHD+vRUyCeNE7V6zaW6okAVep3V=TLRosk1NAQ@mail.gmail.com>
X-Gm-Features: AbW1kvZQ4eo44ZDPpROwb0aIEJr9R-LIb7IX_VmNmlZpYX7ahnLlZw4q5gySm5A
Message-ID: <CAJZ5v0g5vuO9jHD+vRUyCeNE7V6zaW6okAVep3V=TLRosk1NAQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] ACPI: CPPC: Add cppc_get_reg_val and
 cppc_set_reg_val function
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, pierre.gondois@arm.com, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The word "function" at the end of the subject is redundant IMV.

On Mon, Jan 13, 2025 at 1:21=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> Rename cppc_get_perf() to cppc_get_reg_val() as a generic function to rea=
d
> cppc registers, with four changes:
>
> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
> means that this cpu cannot get a valid pcc_ss_id.
>
> 2. Add a check to verify if the register is a mandatory or cpc supported
> one before using it.
>
> 3. Extract the operations if register is in pcc out as
> cppc_get_reg_val_in_pcc().
>
> 4. Return the result of cpc_read() instead of 0.
>
> Add cppc_set_reg_val() as a generic function for setting cppc registers
> value, with this features:
>
> 1. Check register type. If a register is writeable, it must be a buffer.
>
> 2. Check if the register is a optional and null one right after getting t=
he
> register.  Because if so, the rest of the operations are meaningless.
>
> 3. Extract the operations if register is in pcc out as
> cppc_set_reg_val_in_pcc().
>
> These functions can be used to reduce some existing code duplication.

This mixes functional changes with function renames and code
refactoring while it is better to do all of these things separately.

Why don't you split the patch into a few smaller patches doing each
one thing at a time?  Like rename the existing function and refactor
it in one patch (if this makes sense), make functional changes to it
in another patch, then add new functions in a third one?

This would help to review the changes and explain why each of them is made.

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 105 ++++++++++++++++++++++++++++++---------
>  1 file changed, 82 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 6454b469338f..571f94855dce 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1181,43 +1181,102 @@ static int cpc_write(int cpu, struct cpc_registe=
r_resource *reg_res, u64 val)
>         return ret_val;
>  }
>
> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> +static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource=
 *reg, u64 *val)
>  {
> -       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> +       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> +       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> +       int ret;
> +
> +       if (pcc_ss_id < 0) {
> +               pr_debug("Invalid pcc_ss_id\n");
> +               return -ENODEV;
> +       }
> +
> +       pcc_ss_data =3D pcc_data[pcc_ss_id];
> +
> +       down_write(&pcc_ss_data->pcc_lock);
> +
> +       if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0)
> +               ret =3D cpc_read(cpu, reg, val);
> +       else
> +               ret =3D -EIO;
> +
> +       up_write(&pcc_ss_data->pcc_lock);
> +
> +       return ret;
> +}
> +
> +static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
> +{
> +       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
>         struct cpc_register_resource *reg;
>
>         if (!cpc_desc) {
> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>                 return -ENODEV;
>         }
>
>         reg =3D &cpc_desc->cpc_regs[reg_idx];
>
> -       if (CPC_IN_PCC(reg)) {
> -               int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> -               struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -               int ret =3D 0;
> -
> -               if (pcc_ss_id < 0)
> -                       return -EIO;
> +       if (IS_OPTIONAL_CPC_REG(reg_idx) && !CPC_SUPPORTED(reg)) {
> +               pr_debug("CPC register (reg_idx=3D%d) is not supported\n"=
, reg_idx);
> +               return -EOPNOTSUPP;
> +       }
>
> -               pcc_ss_data =3D pcc_data[pcc_ss_id];
> +       if (CPC_IN_PCC(reg))
> +               return cppc_get_reg_val_in_pcc(cpu, reg, val);
>
> -               down_write(&pcc_ss_data->pcc_lock);
> +       return cpc_read(cpu, reg, val);
> +}
>
> -               if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0)
> -                       cpc_read(cpunum, reg, perf);
> -               else
> -                       ret =3D -EIO;
> +static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource=
 *reg, u64 val)
> +{
> +       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> +       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> +       int ret;
>
> -               up_write(&pcc_ss_data->pcc_lock);
> +       if (pcc_ss_id < 0) {
> +               pr_debug("Invalid pcc_ss_id\n");
> +               return -ENODEV;
> +       }
>
> +       ret =3D cpc_write(cpu, reg, val);
> +       if (ret)
>                 return ret;
> +
> +       pcc_ss_data =3D pcc_data[pcc_ss_id];
> +
> +       down_write(&pcc_ss_data->pcc_lock);
> +       /* after writing CPC, transfer the ownership of PCC to platform *=
/
> +       ret =3D send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +       up_write(&pcc_ss_data->pcc_lock);
> +
> +       return ret;
> +}
> +
> +static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
> +{
> +       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +       struct cpc_register_resource *reg;
> +
> +       if (!cpc_desc) {
> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +               return -ENODEV;
>         }
>
> -       cpc_read(cpunum, reg, perf);
> +       reg =3D &cpc_desc->cpc_regs[reg_idx];
>
> -       return 0;
> +       /* if a register is writeable, it must be a buffer */
> +       if ((reg->type !=3D ACPI_TYPE_BUFFER) ||
> +           (IS_OPTIONAL_CPC_REG(reg_idx) && IS_NULL_REG(&reg->cpc_entry.=
reg))) {
> +               pr_debug("CPC register (reg_idx=3D%d) is not supported\n"=
, reg_idx);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (CPC_IN_PCC(reg))
> +               return cppc_set_reg_val_in_pcc(cpu, reg, val);
> +
> +       return cpc_write(cpu, reg, val);
>  }
>
>  /**
> @@ -1229,7 +1288,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs=
 reg_idx, u64 *perf)
>   */
>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> -       return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
> +       return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>
> @@ -1242,7 +1301,7 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>   */
>  int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  {
> -       return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
> +       return cppc_get_reg_val(cpunum, NOMINAL_PERF, nominal_perf);
>  }
>
>  /**
> @@ -1254,7 +1313,7 @@ int cppc_get_nominal_perf(int cpunum, u64 *nominal_=
perf)
>   */
>  int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>  {
> -       return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +       return cppc_get_reg_val(cpunum, HIGHEST_PERF, highest_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>
> @@ -1267,7 +1326,7 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
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

