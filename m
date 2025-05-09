Return-Path: <linux-acpi+bounces-13659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFCDAB1C91
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 20:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE9017C22F
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641F923F403;
	Fri,  9 May 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PamPCRVn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5923C8A4;
	Fri,  9 May 2025 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816277; cv=none; b=MsS8i3hIx5mZFRVYtNr/suPSP3skk8g9QWwss09KiXzfpx7Zu0x0VewNDk8YMBg30uCiGuClkYZdJa54C8L8gmiOS/WTCHQ8/E7bK5EVoPhAeg0XBO/uTkMIInkcZtWTbMqufwmF8tuzkfeC1xBopKJlLhwrdzq2D27kWQbjqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816277; c=relaxed/simple;
	bh=yHaPm4qYpYakP99c9fr3sBVTMug1rAOAFQ48UO7BKr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTfxGRvsEBNduUAyTFzAKdLUscRueS85+VXSnbngmAvanEq3dE87m0PEPzVLGCuca2W3ALp3tX5m7vSvLC/zS3mjM4kSpLgxkc6JrIQb7sh1LZFBkK+pNTDv2yimO+rccKI3dq7oC9OIt70TR/urgolJhrNFkqLn70zscKtGJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PamPCRVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900A4C4CEE4;
	Fri,  9 May 2025 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746816276;
	bh=yHaPm4qYpYakP99c9fr3sBVTMug1rAOAFQ48UO7BKr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PamPCRVn20oP1A683QShRBN1sJIHXwDVyJlOkoJGr8ldx8kH3HZNpVu3aKGbM+cnq
	 6pL7qxO/I45i/lX+K+5ty5D3z5+Tgh2p/HSamyiMaVadtoWq+uBfYN6Kh8V8U8eGv7
	 4lxozxOWL32j7l1SejHmhwKGKiqo9ibSq8wo8/YuBkDPSGY8WK1wHAu3OiZ6rXTu/k
	 SpEN+aE33YX4q0WyDIYdaFqeOE1/L/Zwc9h2UZUU7GhH7ZN95Oj7qbn6bng6uCH41R
	 kkT1QT1ihQNPgGKlvkNYKeevqmvYLhjB0Qhj1UKamLEz5BI1g+pZbbqabo9Z0hdTrr
	 MuFoN1sTrKf+A==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c40235c34so757078a34.3;
        Fri, 09 May 2025 11:44:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVT5LPGCwnQpF8DfR06jdE5wfxva7auN7pGTDuIbGLNik7vq83jBTeR2oLPeegtS4BiySFnbeJoDD6I@vger.kernel.org, AJvYcCXaPTc6jnje+FQchhk32J0VY7l1XjkoHJvPrce2tl/ClMSZd3KQckBCWWWibrNXsHROxOWNDJ7til29tlXu@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhRxjRC8f6GjrhKpiNFLWHr5w8zWzxHuCYEvwCzJ+ti8Omk0c
	4k6oJ6w9UmkBJ/nxAtWFvIvvcnYmjVHQ0WY+U0bTgq0BslYqn2avxyPQHpgiFcBcALp8Lnr8Ij4
	RDP+z0yMvzCgdTaeRAuKSxfnAMzw=
X-Google-Smtp-Source: AGHT+IGnIB3dxnKCZBESbcMEIkuIMPo40sj9h4o5CkdBSYiYRMpjeIlwywlrdNyE8gw5xWZypzdlCcQknuVOm4tdM0Y=
X-Received: by 2002:a05:6870:5251:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2dba42a441emr2752948fac.10.1746816275865; Fri, 09 May 2025
 11:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427075317.42687-1-qiyuzhu2@amd.com>
In-Reply-To: <20250427075317.42687-1-qiyuzhu2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 20:44:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOBu0r7L5TzJWgddtsKA@mail.gmail.com>
X-Gm-Features: ATxdqUEW9I43TrLpU3xnfxiYegRlBKgljA4GdvREP4sjHZ8NC3qwUzxdCbsX5ps
Message-ID: <CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOBu0r7L5TzJWgddtsKA@mail.gmail.com>
Subject: Re: [PATCH] ACPI:PRM: Reduce unnecessary printing to avoid the
 worries of regular users
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 9:54=E2=80=AFAM Zhu Qiyu <qiyuzhu2@amd.com> wrote:
>
> Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
> handler and context") introduces non-essential printing "Failed
> to find VA for GUID: 7626C6AE-F973-429C-A91C-107D7BE298B0, PA: 0x0"
> which causes unnecessary worry for regular users.
>
> Refer to PRM Spec Section 4.1.2[1], both static data buffer address
> and ACPI parameter buffer address may be NULL if they are not needed.
> So there is no need to print out "Failed to find VA ... " to intimidate
> regular users.
>
> Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%2=
0Mechanism%20-%20with%20legal%20notice.pdf # [1]
>
> Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
> ---
>  drivers/acpi/prmt.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index e549914a636c..fcd721559eb5 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -72,7 +72,20 @@ struct prm_module_info {
>         struct prm_handler_info handlers[] __counted_by(handler_count);
>  };
>
> -static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
> +enum prm_addr_type {
> +       PRM_HANDLER_ADDR,
> +       PRM_STATIC_DATA_BUFFER_ADDR,
> +       PRM_ACPI_PARAM_BUFFER_ADDR,
> +       PRM_ADD_TYPE_MAX,
> +};
> +
> +static char *prm_addr_type_name[PRM_ADD_TYPE_MAX] =3D {
> +       "handler",
> +       "static data buffer",
> +       "acpi param buffer",
> +};
> +
> +static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa, enum prm_addr_type=
 type)
>  {
>         efi_memory_desc_t *md;
>         u64 pa_offset =3D pa & ~PAGE_MASK;
> @@ -85,7 +98,12 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>                 }
>         }
>
> -       pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa)=
;

Well, maybe just change the line above to something like:

  pr_info("VA for GUID: %pUL, PA: 0x%llx not found\n", guid, pa);

which should look less intimidating?

> +       if (type =3D=3D PRM_HANDLER_ADDR)
> +               pr_warn("Failed to find %s VA for GUID: %pUL, PA: 0x%llx"=
,
> +                       prm_addr_type_name[type], guid, pa);
> +       else
> +               pr_debug("Failed to find %s VA for GUID: %pUL, PA: 0x%llx=
",
> +                       prm_addr_type_name[type], guid, pa);
>
>         return 0;
>  }
> @@ -153,13 +171,16 @@ acpi_parse_prmt(union acpi_subtable_headers *header=
, const unsigned long end)
>
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid=
);
>                 th->handler_addr =3D
> -                       (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
> +                       (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address,
> +                                       PRM_HANDLER_ADDR);
>
>                 th->static_data_buffer_addr =3D
> -                       efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address);
> +                       efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address,
> +                                       PRM_STATIC_DATA_BUFFER_ADDR);
>
>                 th->acpi_param_buffer_addr =3D
> -                       efi_pa_va_lookup(&th->guid, handler_info->acpi_pa=
ram_buffer_address);
> +                       efi_pa_va_lookup(&th->guid, handler_info->acpi_pa=
ram_buffer_address,
> +                                       PRM_ACPI_PARAM_BUFFER_ADDR);
>
>         } while (++cur_handler < tm->handler_count && (handler_info =3D g=
et_next_handler(handler_info)));
>
>
> base-commit: 9d7a0577c9db35c4cc52db90bc415ea248446472
> --
> 2.34.1
>

