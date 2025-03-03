Return-Path: <linux-acpi+bounces-11726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817FA4BFE7
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 13:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5986A3A6A61
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 12:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4577720E71C;
	Mon,  3 Mar 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzHF4bu3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9E220E714;
	Mon,  3 Mar 2025 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003623; cv=none; b=gNvGd94vX/XYDtw1YR25fsXfVIKbkp5b2/rt36WbFVjH41FoJ0hHRLvYjUPvZHw3qWYv8uOHQhXYXpUysaKEOeLl8VnmFlC19NMdr3fWdQ+wQawJK6OLKF9JF3Lw2zZRiPotiD8YVs0+9rU4mqHYQSh3YLC0oai6HWQKp7yFCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003623; c=relaxed/simple;
	bh=GGhPuAF/+Ro/cKx+hXHR3wcMXAcPr1+p3afDdwS8nRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY1Ryy6pbaoMexfU38Sh0NbwEin2uacM+IU54NModm2MJxDjs9W/+VGQgz0kzlsuhz1x3l4Qxsj2t2UdpmBgesM/Pr6WKE5CZuXc8LneFzylociMdLRFxzia0mrGX/Cjdqbgft1MPENbk6+lWpRTb0olrLAHVaRn+24gVR4tINE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzHF4bu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB5EC4CEEA;
	Mon,  3 Mar 2025 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741003622;
	bh=GGhPuAF/+Ro/cKx+hXHR3wcMXAcPr1+p3afDdwS8nRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kzHF4bu32yq9bd4utkgKjHfGOk3N2WHVpKJyJ+gKl1UeRVgzpZtiSJFVwQH1guoNa
	 8ZyPgTy8Bv8aBn1shZrHUWknvJLRU4ZYAQci13+MVHXLZuw0xbSEqm5uHV9ZkQycn/
	 LNKWtqq9s0KqhBP8EbkOnGcPBgjAKPdjxxXEg0izgufOOHG7LJ1j3j7sx4RM92qJUR
	 s+Ts4kIdE9wotmqpTtbbuswcFby94OSUQogQDLejlkd54Rb+iOJo9BXc7wVVpUhCFX
	 RUdDW42ZbA4ZRkJiwf6DkkiqTGnv3Kk3FRQmLW9NLwb3ybTCQ8Jvsa25eJWo8n0QZJ
	 8NdaCfxHojlxg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f4d935084aso3323673eaf.2;
        Mon, 03 Mar 2025 04:07:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU45rqgWSaPrjAfMge9MI0Y9fAjQsBOFj0KcL9JwxHR1bbsgIO1M+l8XdAO52UxnXyoA6pr9sni0O85UPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiKNjIIC2AfKL1SlPnsUUIsWi29EiS9lNyuQz4kUoqiOxLxDk
	Aos9aq+JcKy16wpGmdA4cGGtLHrEqPacwYPJw5/GfLRo1u4jXiBTwMmrXXmFn67lBsrawTVoNb9
	kZcTYFCw4lm4Wi7qKSR2tPkILJLw=
X-Google-Smtp-Source: AGHT+IF3nuslyD1cM4oIcy7W1U/tBThh6i0pBYhkyve1Uv7EJul0hcBY1imYUYYWkaDY1TtyrEveFps+Jof9uI1yWjQ=
X-Received: by 2002:a05:6820:a08:b0:600:17b0:ab04 with SMTP id
 006d021491bc7-60017b0ada8mr1174782eaf.0.1741003621834; Mon, 03 Mar 2025
 04:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com> <20250303-pcc_fixes_updates-v1-14-3b44f3d134b1@arm.com>
In-Reply-To: <20250303-pcc_fixes_updates-v1-14-3b44f3d134b1@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Mar 2025 13:06:49 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpdhG8Ejj=ErQP3sNc4YwW_WDjmPR4A32=nFdoRtf0Ng@mail.gmail.com>
X-Gm-Features: AQ5f1Jq7sbWmZ9IUWEpPInfWVH74pfYGyd-GBpkQJTUIwc9DGM6UAhvZFh4yYh8
Message-ID: <CAJZ5v0hpdhG8Ejj=ErQP3sNc4YwW_WDjmPR4A32=nFdoRtf0Ng@mail.gmail.com>
Subject: Re: [PATCH 14/14] ACPI: CPPC: Simplify PCC shared memory region handling
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jassi Brar <jassisinghbrar@gmail.com>, Huisong Li <lihuisong@huawei.com>, 
	Adam Young <admiyo@os.amperecomputing.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 11:53=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> The PCC driver now handles mapping and unmapping of shared memory
> areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> this ACPI CPPC driver did handling of those mappings like several
> other PCC mailbox client drivers.
>
> There were redundant operations, leading to unnecessary code. Maintaining
> the consistency across these driver was harder due to scattered handling
> of shmem.
>
> Just use the mapped shmem and remove all redundant operations from this
> driver.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: "Rafael J. Wysocki" <rafael@kernel.org>

> ---
>  drivers/acpi/cppc_acpi.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f193e713825ac24203ece5f94d6cf99dd4724ce4..d972157a79b6ade2f3738c901=
28e8692141b3ee5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -47,7 +47,6 @@
>
>  struct cppc_pcc_data {
>         struct pcc_mbox_chan *pcc_channel;
> -       void __iomem *pcc_comm_addr;
>         bool pcc_channel_acquired;
>         unsigned int deadline_us;
>         unsigned int pcc_mpar, pcc_mrtt, pcc_nominal;
> @@ -95,7 +94,7 @@ static DEFINE_PER_CPU(int, cpu_pcc_subspace_idx);
>  static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>
>  /* pcc mapped address + header size + offset within PCC subspace */
> -#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_comm_ad=
dr + \
> +#define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_channel=
->shmem + \
>                                                 0x8 + (offs))
>
>  /* Check if a CPC register is in PCC */
> @@ -223,7 +222,7 @@ static int check_pcc_chan(int pcc_ss_id, bool chk_err=
_bit)
>         int ret, status;
>         struct cppc_pcc_data *pcc_ss_data =3D pcc_data[pcc_ss_id];
>         struct acpi_pcct_shared_memory __iomem *generic_comm_base =3D
> -               pcc_ss_data->pcc_comm_addr;
> +                                       pcc_ss_data->pcc_channel->shmem;
>
>         if (!pcc_ss_data->platform_owns_pcc)
>                 return 0;
> @@ -258,7 +257,7 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>         int ret =3D -EIO, i;
>         struct cppc_pcc_data *pcc_ss_data =3D pcc_data[pcc_ss_id];
>         struct acpi_pcct_shared_memory __iomem *generic_comm_base =3D
> -               pcc_ss_data->pcc_comm_addr;
> +                                       pcc_ss_data->pcc_channel->shmem;
>         unsigned int time_delta;
>
>         /*
> @@ -571,15 +570,6 @@ static int register_pcc_channel(int pcc_ss_idx)
>                 pcc_data[pcc_ss_idx]->pcc_mpar =3D pcc_chan->max_access_r=
ate;
>                 pcc_data[pcc_ss_idx]->pcc_nominal =3D pcc_chan->latency;
>
> -               pcc_data[pcc_ss_idx]->pcc_comm_addr =3D
> -                       acpi_os_ioremap(pcc_chan->shmem_base_addr,
> -                                       pcc_chan->shmem_size);
> -               if (!pcc_data[pcc_ss_idx]->pcc_comm_addr) {
> -                       pr_err("Failed to ioremap PCC comm region mem for=
 %d\n",
> -                              pcc_ss_idx);
> -                       return -ENOMEM;
> -               }
> -
>                 /* Set flag so that we don't come here for each CPU. */
>                 pcc_data[pcc_ss_idx]->pcc_channel_acquired =3D true;
>         }
>
> --
> 2.34.1
>

