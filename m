Return-Path: <linux-acpi+bounces-12921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8602A82D50
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 19:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD84464B17
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10086270EDD;
	Wed,  9 Apr 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovq1dc1I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F1D270EBF;
	Wed,  9 Apr 2025 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218619; cv=none; b=HJJ+h2rKd5/WspYj+6/WfpyJz2T4D7jOS7b9Q8hA5q1LII4xF8bEqmjctmNSLPqLH+BvgZleUCgdqCz4N/5TSKdhu8HlwyY4SLFhbqOPJ/euQmHgGLIXgZVvPKifuZLEZH+E/NvKk2Z+SnIT3XoeAbwv2fGmqzXxtnPozdKvYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218619; c=relaxed/simple;
	bh=cAQwVlXf7+CjPLnuPwVGgRDY9ncDHb1puhcdzHnY0jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOQbuN0gkJhbivQHZW1/LG1eXQM/KVJyF62lP0gwtR5cYqPMadotQd58/uwSbDXWzj+tyfxly7JyDSG3l+pa+jcc4Jrin0QiIkb1zJUbMXD7fLrOFHFQAKdFP9Boytu0BLXy9olh1gLq70Rbs+H5Jfo1yHwRxXtY/0KQq38YtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovq1dc1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C601C4AF0B;
	Wed,  9 Apr 2025 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744218618;
	bh=cAQwVlXf7+CjPLnuPwVGgRDY9ncDHb1puhcdzHnY0jY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ovq1dc1IXAl5wnc9ryHVYFDKGcsVmLts9fdhHxRd6Ws8T5QKCvKmR7LKHn5l+zlbu
	 x4Arzznvq6P+X5kbPB2XgQQwiQnmInizm6I4RF9aLofbJ8AvKSoOHxAJxZet9U3zH/
	 d3rUtnBvtvX87CFu9D31IQd4NUkTEPgs5/XivyzKTtfxpeEP7DW92lD18Dk0voOsen
	 2VQdXPuQWZhUJpSp2xilMss32k6mfkVcFTNj5zg0dBylCElIpBN3wz+74cDt3E35Sm
	 gaf/vF5ywRmKIodBboG2VjREIsD5FNI6dccSzg5xmmDB51XgrxLU/9JPjjRV6Yt3O7
	 AnEketpdYnnmg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c7f876b321so2190276fac.1;
        Wed, 09 Apr 2025 10:10:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvXz0SyhbDjXjwyYRKFVZM1Auun3RgQEgzFxGr/+aexioRPf+QiGLieC31lmBqT0b9iqbun+wWpQgHGFR1@vger.kernel.org, AJvYcCXTkEDr6DizXVuRfl4CM19Xgkz8kWlKpYaGJBmCyMg+qRtcDiaNbDjjyVtMCDjmIV4Da8RRZEYQlJw=@vger.kernel.org, AJvYcCXkx/RvTiFUIQeiNtoX1gGFMs3Kp1tpxe3ZPUuG7XoZ9PH9jGRFRwpRmn0v54eKBTnj6gOR15fPOCgb@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYVsxio7HxGkjkGiQLvCkDy0S/uKocDU+A+BTJ89EmpffWM4h
	ymdOf8vf5EVr6og5af/cDlHuHtP6RG5ZOYYiD+fx0w2Y7V5fHEfTlheNQTEmjxd6gW9Sadqxqca
	ZEvQpnOWs9ULlf4i7EHyuv3ms1uY=
X-Google-Smtp-Source: AGHT+IE1HcaprfbES+AEj26IYVhioa7kyOAsoqMrfIDfQQwSe2RuMsl/a8oiE9RCn4sEC+kDDYA6hgAtGjfVmjvNbho=
X-Received: by 2002:a05:6870:ab0d:b0:2c2:2f08:5e5b with SMTP id
 586e51a60fabf-2d0917bb20cmr1802929fac.13.1744218617585; Wed, 09 Apr 2025
 10:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409065703.1461867-1-zhenglifeng1@huawei.com> <20250409065703.1461867-3-zhenglifeng1@huawei.com>
In-Reply-To: <20250409065703.1461867-3-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 19:10:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0is5YXxqHDAC4Ki44U9mwDH3KvW0=JmFYS-25QwKYDR1A@mail.gmail.com>
X-Gm-Features: ATxdqUEZY7ZSPbkwrXMr4u7_twpdladBp3zkPIRv7P3Mi7CxPU_yAnM6-yPmvM4
Message-ID: <CAJZ5v0is5YXxqHDAC4Ki44U9mwDH3KvW0=JmFYS-25QwKYDR1A@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] ACPI: CPPC: Optimize cppc_get_perf()
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com, 
	viresh.kumar@linaro.org, mario.limonciello@amd.com, gautham.shenoy@amd.com, 
	ray.huang@amd.com, perry.yuan@amd.com, pierre.gondois@arm.com, 
	acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	cenxinghai@h-partners.com, hepeng68@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 8:57=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.co=
m> wrote:
>
> Optimize cppc_get_perf() with three changes:
>
> 1. Change the error kind to "no such device" when pcc_ss_id < 0, as other
> register value getting functions.
>
> 2. Add a check to verify if the register is supported to be read before
> using it. The logic is:
>
> (1) If the register is of the integer type, check whether the register is
> optional and its value is 0. If yes, the register is not supported.
>
> (2) If the register is of other types, a null one is not supported.
>
> 3. Return the result of cpc_read() instead of 0.
>
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 39f019e265da..2f789d3b3cad 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1201,20 +1201,29 @@ static int cppc_get_perf(int cpunum, enum cppc_re=
gs reg_idx, u64 *perf)
>
>         reg =3D &cpc_desc->cpc_regs[reg_idx];
>
> +       if (reg->type =3D=3D ACPI_TYPE_INTEGER ?
> +           (IS_OPTIONAL_CPC_REG(reg_idx) && !reg->cpc_entry.int_value) :
> +           IS_NULL_REG(&reg->cpc_entry.reg)) {

Please avoid using the ternary operator in any new kernel code.

Why not write it this way

if ((reg->type =3D=3D ACPI_TYPE_INTEGER && IS_OPTIONAL_CPC_REG(reg_idx)
    && !reg->cpc_entry.int_value) || (reg->type !=3D ACPI_TYPE_INTEGER &&
    IS_NULL_REG(&reg->cpc_entry.reg)) {

> +               pr_debug("CPC register is not supported\n");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (CPC_IN_PCC(reg)) {
>                 int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpunum);
>                 struct cppc_pcc_data *pcc_ss_data =3D NULL;
> -               int ret =3D 0;
> +               int ret;
>
> -               if (pcc_ss_id < 0)
> -                       return -EIO;
> +               if (pcc_ss_id < 0) {
> +                       pr_debug("Invalid pcc_ss_id\n");
> +                       return -ENODEV;
> +               }
>
>                 pcc_ss_data =3D pcc_data[pcc_ss_id];
>
>                 down_write(&pcc_ss_data->pcc_lock);
>
>                 if (send_pcc_cmd(pcc_ss_id, CMD_READ) >=3D 0)
> -                       cpc_read(cpunum, reg, perf);
> +                       ret =3D cpc_read(cpunum, reg, perf);
>                 else
>                         ret =3D -EIO;
>
> @@ -1223,9 +1232,7 @@ static int cppc_get_perf(int cpunum, enum cppc_regs=
 reg_idx, u64 *perf)
>                 return ret;
>         }
>
> -       cpc_read(cpunum, reg, perf);
> -
> -       return 0;
> +       return cpc_read(cpunum, reg, perf);
>  }
>
>  /**
> --

