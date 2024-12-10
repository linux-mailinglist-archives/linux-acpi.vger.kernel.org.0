Return-Path: <linux-acpi+bounces-10032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5833B9EB921
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761321889AF7
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41212046AB;
	Tue, 10 Dec 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxLGqill"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECE86349;
	Tue, 10 Dec 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854511; cv=none; b=lyshMEFbUmoX9knC+tTxapdq39e66PRNpgR+wGKwvd8ys9Tkphr/BFHTVxf0JcksZL+Y1dq8LHS2HlordQom7DxKxqRxbT49WVBdHsW5c8MCBz2maGMibBwCYZ3naBvZU1fS4fo41sII0KbT8EsgpuRCzYFHYmXcAFdeJ/+xLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854511; c=relaxed/simple;
	bh=RWNr3vVhHnPrVOyjZD5oMiOFzVgk4i/HCFKtx2yA70g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a0lBT8z8mLJp/7+e1YUvFM4DJ7pp0SRW/cw1JvaR+SNEnYY6D07R9aCInkHugW1VHEkpxTYgrTmKBwu4Oi0GXahMfTyEybAoBdti222DNb1pXg2F8m3OAFU6aTy+fJfAXk0dNksyu64dLwx6vWzSLljcYYWq4TXW1ke1sPIHI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxLGqill; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50036C4CEE2;
	Tue, 10 Dec 2024 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733854511;
	bh=RWNr3vVhHnPrVOyjZD5oMiOFzVgk4i/HCFKtx2yA70g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VxLGqillv37Sh2NDOi4e2o91C27OTlJx6tGWnMlYBK27BSHt+7qFW8ZscJo4ilazd
	 fueKb4UXxlI7TRsq6PXwBj7nBoNnoHJZiFqwYRfoGumG/UyOwUh8Kmjba9zygGN927
	 AKLSK2hYtrz7yXNKWI5rh2l/nL+Nck00fz9bJxDVJDTgLWXZAj/iAOoTTcWAQpNwEK
	 GZqw5xpl3AowYoyWqE1kVRNAy+PMrzDOofHnEk4Pc4x1nCzsZA0S5HOvHKXr30n1Jr
	 XaTcRJdh5h8DFCd5yF/gDzh8ziUzeBWeC3iEe1sLNuuZZFAahtRSXF7xaO0HH+o/mN
	 azjK5PxrmyM/Q==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb66b02e1cso522804b6e.3;
        Tue, 10 Dec 2024 10:15:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU37h2NNLJ/fQ+Fk5sdqdDXrKg7vqrs7OaBzQeejGcrBylaAtkbWOOnSWHy5LX2p6QG2cgFWafB/X0=@vger.kernel.org, AJvYcCWZjMdFrU+CnmjCEoDQ+s0JMoaIAdQ33eheCiEaK1rJbr130aSx4pN+Reie80u7uEeCeOWzE/FYTAplILGP@vger.kernel.org, AJvYcCXycY3EH5cNmO7Y+hhSS71vlhTXJ0AWLAfC8Yfpgut7dY2gRgly6uR7hqndHJrEdGUyXh4KzfZZFwjS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzntc/hN5D7yKYNdRiVw4IUsb1uXVAk552BXkfta/DiXBpujkt6
	bTrls6s4sJevcNbDJ093sw0v48My48zwwJS9hybFXS1QaT6kigbYy9I0ojpg0YJuhHX3KDnzwL0
	Oly9ZQvrSsxtITPQ115R1i+JSS8M=
X-Google-Smtp-Source: AGHT+IH2o+tbT3bBgK+gbTK2BdnZ++ux+IuNI9duS6lHtkOdfFLBqwXFm3jXPIjmwvGayBzTQA90Pb3DbmaNkmzNeAw=
X-Received: by 2002:a05:6808:1919:b0:3eb:63c9:fe7f with SMTP id
 5614622812f47-3eb66f8c27cmr3740676b6e.40.1733854510425; Tue, 10 Dec 2024
 10:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122062051.3658577-1-zhenglifeng1@huawei.com> <20241122062051.3658577-2-zhenglifeng1@huawei.com>
In-Reply-To: <20241122062051.3658577-2-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:14:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jnF82WX_=4KtqwnLd=vcHYt_pbtyvQV74p0ojKr33D=A@mail.gmail.com>
Message-ID: <CAJZ5v0jnF82WX_=4KtqwnLd=vcHYt_pbtyvQV74p0ojKr33D=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: CPPC: Refactor register get and set ABIs
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, acpica-devel@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxarm@huawei.com, jonathan.cameron@huawei.com, 
	zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 7:21=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> Refactor register get and set ABIs using cppc_get_reg() and cppc_set_reg(=
).

I don't quite like the cppc_get_reg() name.  I think that
cppc_get_reg_val() would be better.

> Rename cppc_get_perf() to cppc_get_reg() as a generic function to read cp=
pc
> registers, with two changes:
>
> 1. Change the error kind to "no such device" when pcc_ss_id < 0, which
> means that this cpu cannot get a valid pcc_ss_id.
>
> 2. Add a check to verify if the register is a cpc supported one before
> using it.

So it's not just a rename, but also a change in behavior.  Can this
change in behavior become user-visible?

> Add cppc_set_reg() as a generic function for setting cppc registers.

Again, I would prefer cppc_set_reg_val().

> Unlike other set reg ABIs, this function checks CPC_SUPPORTED right after=
 getting
> the register, because the rest of the operations are meaningless if this
> register is not a cpc supported one.

And the new function is used to reduce some existing code duplication,
isn't it?  Which would be good to mention here.

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 191 +++++++++++++++------------------------
>  1 file changed, 72 insertions(+), 119 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index c1f3568d0c50..9aab22d8136a 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1179,10 +1179,13 @@ static int cpc_write(int cpu, struct cpc_register=
_resource *reg_res, u64 val)
>         return ret_val;
>  }
>
> -static int cppc_get_perf(int cpunum, enum cppc_regs reg_idx, u64 *perf)
> +static int cppc_get_reg(int cpunum, enum cppc_regs reg_idx, u64 *val)
>  {
>         struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> +       struct cppc_pcc_data *pcc_ss_data =3D NULL;

Why are you moving this here?  This change is not related to the rest
of the patch, is it?

>         struct cpc_register_resource *reg;
> +       int pcc_ss_id;
> +       int ret =3D 0;

And here?

>
>         if (!cpc_desc) {
>                 pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> @@ -1191,20 +1194,23 @@ static int cppc_get_perf(int cpunum, enum cppc_re=
gs reg_idx, u64 *perf)
>
>         reg =3D &cpc_desc->cpc_regs[reg_idx];
>
> +       if (!CPC_SUPPORTED(reg)) {
> +               pr_debug("CPC register (reg_idx=3D%d) is not supported\n"=
, reg_idx);
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (CPC_IN_PCC(reg)) {
> -               int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> -               struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -               int ret =3D 0;
> +               pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
>
>                 if (pcc_ss_id < 0)
> -                       return -EIO;
> +                       return -ENODEV;
>
>                 pcc_ss_data =3D pcc_data[pcc_ss_id];
>
>                 down_write(&pcc_ss_data->pcc_lock);
>
>                 if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0)
> -                       cpc_read(cpunum, reg, perf);
> +                       cpc_read(cpunum, reg, val);
>                 else
>                         ret =3D -EIO;
>
> @@ -1213,21 +1219,65 @@ static int cppc_get_perf(int cpunum, enum cppc_re=
gs reg_idx, u64 *perf)
>                 return ret;
>         }
>
> -       cpc_read(cpunum, reg, perf);
> +       cpc_read(cpunum, reg, val);
>
>         return 0;
>  }
>
> +static int cppc_set_reg(int cpu, enum cppc_regs reg_idx, u64 val)
> +{
> +       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> +       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> +       struct cpc_register_resource *reg;
> +       int pcc_ss_id;
> +       int ret;
> +
> +       if (!cpc_desc) {
> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +               return -ENODEV;
> +       }
> +
> +       reg =3D &cpc_desc->cpc_regs[reg_idx];
> +
> +       if (!CPC_SUPPORTED(reg)) {
> +               pr_debug("CPC register (reg_idx=3D%d) is not supported\n"=
, reg_idx);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       if (CPC_IN_PCC(reg)) {
> +               pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);

Please declare the variables that are only needed in the PCC case here.

Also, I think it would be better to define a new function, say
cppc_set_reg_val_in_pcc() for this code and then have

if (CPC_IN_PCC(reg))
        return cppc_set_reg_val_in_pcc(reg, val);

> +
> +               if (pcc_ss_id < 0) {
> +                       pr_debug("Invalid pcc_ss_id\n");
> +                       return -ENODEV;
> +               }
> +
> +               ret =3D cpc_write(cpu, reg, val);
> +               if (ret)
> +                       return ret;
> +
> +               pcc_ss_data =3D pcc_data[pcc_ss_id];
> +
> +               down_write(&pcc_ss_data->pcc_lock);
> +               /* after writing CPC, transfer the ownership of PCC to pl=
atform */
> +               ret =3D send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +               up_write(&pcc_ss_data->pcc_lock);
> +               return ret;
> +       }
> +
> +       return cpc_write(cpu, reg, val);
> +}
> +
>  /**
>   * cppc_get_desired_perf - Get the desired performance register value.
>   * @cpunum: CPU from which to get desired performance.
>   * @desired_perf: Return address.
>   *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.
>   */
>  int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> -       return cppc_get_perf(cpunum, DESIRED_PERF, desired_perf);
> +       return cppc_get_reg(cpunum, DESIRED_PERF, desired_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>
> @@ -1236,11 +1286,11 @@ EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
>   * @cpunum: CPU from which to get nominal performance.
>   * @nominal_perf: Return address.
>   *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.

What do you mean by ERRNO?

>   */
>  int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf)
>  {
> -       return cppc_get_perf(cpunum, NOMINAL_PERF, nominal_perf);
> +       return cppc_get_reg(cpunum, NOMINAL_PERF, nominal_perf);
>  }
>
>  /**
> @@ -1248,11 +1298,11 @@ int cppc_get_nominal_perf(int cpunum, u64 *nomina=
l_perf)
>   * @cpunum: CPU from which to get highest performance.
>   * @highest_perf: Return address.
>   *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.
>   */
>  int cppc_get_highest_perf(int cpunum, u64 *highest_perf)
>  {
> -       return cppc_get_perf(cpunum, HIGHEST_PERF, highest_perf);
> +       return cppc_get_reg(cpunum, HIGHEST_PERF, highest_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>
> @@ -1261,11 +1311,11 @@ EXPORT_SYMBOL_GPL(cppc_get_highest_perf);
>   * @cpunum: CPU from which to get epp preference value.
>   * @epp_perf: Return address.
>   *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -ERRNO otherwise.

Same here?

>   */
>  int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>  {
> -       return cppc_get_perf(cpunum, ENERGY_PERF, epp_perf);
> +       return cppc_get_reg(cpunum, ENERGY_PERF, epp_perf);
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_epp_perf);

It would be cleaner to do the changes below in a separate patch IMV.

> @@ -1545,44 +1595,14 @@ EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>   */
>  int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>  {
> -       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpunum);
> -       struct cpc_register_resource *auto_sel_reg;
> -       u64  auto_sel;
> -
> -       if (!cpc_desc) {
> -               pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> -               return -ENODEV;
> -       }
> -
> -       auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> -
> -       if (!CPC_SUPPORTED(auto_sel_reg))
> -               pr_warn_once("Autonomous mode is not unsupported!\n");
> -
> -       if (CPC_IN_PCC(auto_sel_reg)) {
> -               int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
> -               struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -               int ret =3D 0;
> -
> -               if (pcc_ss_id < 0)
> -                       return -ENODEV;
> -
> -               pcc_ss_data =3D pcc_data[pcc_ss_id];
> -
> -               down_write(&pcc_ss_data->pcc_lock);
> -
> -               if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0) {
> -                       cpc_read(cpunum, auto_sel_reg, &auto_sel);
> -                       perf_caps->auto_sel =3D (bool)auto_sel;
> -               } else {
> -                       ret =3D -EIO;
> -               }
> -
> -               up_write(&pcc_ss_data->pcc_lock);
> +       u64 auto_sel;
> +       int ret;
>
> +       ret =3D cppc_get_reg(cpunum, AUTO_SEL_ENABLE, &auto_sel);
> +       if (ret)
>                 return ret;
> -       }
>
> +       perf_caps->auto_sel =3D (bool)auto_sel;
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
> @@ -1594,43 +1614,7 @@ EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
>   */
>  int cppc_set_auto_sel(int cpu, bool enable)
>  {
> -       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> -       struct cpc_register_resource *auto_sel_reg;
> -       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> -       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -       int ret =3D -EINVAL;
> -
> -       if (!cpc_desc) {
> -               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> -               return -ENODEV;
> -       }
> -
> -       auto_sel_reg =3D &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> -
> -       if (CPC_IN_PCC(auto_sel_reg)) {
> -               if (pcc_ss_id < 0) {
> -                       pr_debug("Invalid pcc_ss_id\n");
> -                       return -ENODEV;
> -               }
> -
> -               if (CPC_SUPPORTED(auto_sel_reg)) {
> -                       ret =3D cpc_write(cpu, auto_sel_reg, enable);
> -                       if (ret)
> -                               return ret;
> -               }
> -
> -               pcc_ss_data =3D pcc_data[pcc_ss_id];
> -
> -               down_write(&pcc_ss_data->pcc_lock);
> -               /* after writing CPC, transfer the ownership of PCC to pl=
atform */
> -               ret =3D send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> -               up_write(&pcc_ss_data->pcc_lock);
> -       } else {
> -               ret =3D -ENOTSUPP;
> -               pr_debug("_CPC in PCC is not supported\n");
> -       }
> -
> -       return ret;
> +       return cppc_set_reg(cpu, AUTO_SEL_ENABLE, enable);
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>
> @@ -1644,38 +1628,7 @@ EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
>   */
>  int cppc_set_enable(int cpu, bool enable)
>  {
> -       int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
> -       struct cpc_register_resource *enable_reg;
> -       struct cpc_desc *cpc_desc =3D per_cpu(cpc_desc_ptr, cpu);
> -       struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -       int ret =3D -EINVAL;
> -
> -       if (!cpc_desc) {
> -               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> -               return -EINVAL;
> -       }
> -
> -       enable_reg =3D &cpc_desc->cpc_regs[ENABLE];
> -
> -       if (CPC_IN_PCC(enable_reg)) {
> -
> -               if (pcc_ss_id < 0)
> -                       return -EIO;
> -
> -               ret =3D cpc_write(cpu, enable_reg, enable);
> -               if (ret)
> -                       return ret;
> -
> -               pcc_ss_data =3D pcc_data[pcc_ss_id];
> -
> -               down_write(&pcc_ss_data->pcc_lock);
> -               /* after writing CPC, transfer the ownership of PCC to pl=
atfrom */
> -               ret =3D send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> -               up_write(&pcc_ss_data->pcc_lock);
> -               return ret;
> -       }
> -
> -       return cpc_write(cpu, enable_reg, enable);
> +       return cppc_set_reg(cpu, ENABLE, enable);
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_enable);
>
> --

