Return-Path: <linux-acpi+bounces-14865-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F8AEE7F7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DA6189D406
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752601DFE26;
	Mon, 30 Jun 2025 20:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enJ4rWDg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13619F130;
	Mon, 30 Jun 2025 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314032; cv=none; b=ajWp9ExhrMhQMPZSZ2DRfOwUpSsQWl7IQoIgeIUCAGIoznAcNb21xLX0T+85GJJ/ENt5L53KpRe7GNsvS7Wj6gbcdUEeT4Mhj3HyDE+Fu+JZjrLghpNuvLi+qriTkHpu1AVZjoKzQREo/oG6qjZeYPPV/YTge75/nCk5JYP79Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314032; c=relaxed/simple;
	bh=r1AWKj41a1sd0zceKrDNzhF2CygHLZVhZnJgrhIxi14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbhDKzurCVUzR/HYd35RQuuQgJCJsi2QeCu5nwtDPGO8PQPwFxLHVRtIvJlTczVHgeic/3nkBZPrErx4MrFSQX3Qz0d8wBB8j/WqNcGog/xMzPTkTy7jgAjXzsdfT7rteAmBf//gbrancsiz9Jo0fVp0EH4f5IsQCb5Ec56zCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enJ4rWDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C404BC4CEF1;
	Mon, 30 Jun 2025 20:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751314029;
	bh=r1AWKj41a1sd0zceKrDNzhF2CygHLZVhZnJgrhIxi14=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=enJ4rWDgtU7O+aKA9rrgUJQjs5FBFVvwrqjGxU8Jd83sLw4yR00YvpCksbMpspRi8
	 HsCjRTIG7/aZCdZ7HkYwkJhYR7M6kc7FQpS+GXJv5oafT+058zxFlWc3pMCKDx1ytA
	 V8d/lLuDJzy1e3S/4pwUL3JbF1a2amyqc6LYSKsTr8JYsdTOx+BUwh6fqNLrg+VRER
	 hojNCbxaeJqcjGGXYdAUNF/JD+cgqDKC535WwDlk7efnVBElJRSoORUrAwu/T5rsd6
	 2Y7z9TQInQsfOXtyCGx3X9+JtD/6HNK/l/L15UNE4JAc0bN+Y79IvpojrAqZbDYhlt
	 CwvGuNMAJxNYw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6118b000506so1168749eaf.0;
        Mon, 30 Jun 2025 13:07:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGhzkWvJFEQV0IgONVAOWR7SKfrftRMujO4js/eX4I39AoMFBF+VIRaO3Ib09hN97EF33MZy4F2fpAGErQ@vger.kernel.org, AJvYcCX6CvOwLDXf5BUWdDplqgGhmyQPRBl5gOxGJCFoUJPuzKpneF4PvaTxyCOoy7NfAIv2FTd0N8Vl6tAF@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrBIKJSRHTE1fYPebggOSmysfegLHG2RC2zUjfN2rm/l5eYrN
	UR3De8nu1J3QhcX8wDj0EKjEgE7uuaM5qLAaxjB42Yp4D0+xRwU1wRJmWt4gYq3Ccrh309agz5w
	G+Nb2VnG2DFhjwqqHcXmKbJqZCo+cKYo=
X-Google-Smtp-Source: AGHT+IFslIZMTl4pJP0AqDhio6+67azk3qrKNhvD+UFrMTCrHmUWjBxpcaD/bHzG6Cp+7GjfV5H+KgUY19UtXhoQwRI=
X-Received: by 2002:a4a:e90b:0:b0:611:80f3:eb44 with SMTP id
 006d021491bc7-611b90eca36mr9646540eaf.3.1751314028969; Mon, 30 Jun 2025
 13:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527024259.56996-1-qiyuzhu2@amd.com>
In-Reply-To: <20250527024259.56996-1-qiyuzhu2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jun 2025 22:06:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9J-4-dv=0QxEPxYDS_epnjT9dGCNoZA0LpiDZa7sy8Q@mail.gmail.com>
X-Gm-Features: Ac12FXzX06c4v2qxz4_NKajLb2NNnxBQRWYVOI3co3NqsscTI3xGPLK7ifhsdEg
Message-ID: <CAJZ5v0j9J-4-dv=0QxEPxYDS_epnjT9dGCNoZA0LpiDZa7sy8Q@mail.gmail.com>
Subject: Re: [PATCH v5] ACPI:PRM: Reduce unnecessary printing to avoid the
 worries of regular users
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 4:43=E2=80=AFAM Zhu Qiyu <qiyuzhu2@amd.com> wrote:
>
> Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
> handler and context") introduces non-essential printing "Failed to find
> VA for GUID: xxxx, PA: 0x0" which causes unnecessary worry for regular
> users.
>
> Refer to PRM Spec Section 4.1.2[1], both static data buffer address

s/Refer/According to/

> and ACPI parameter buffer address may be NULL if they are not needed.
> So there is no need to print out "Failed to find VA ... " to intimidate
> regular users.

s/intimidate regular users/confuse users/

>
> Link: https://uefi.org/sites/default/files/resources/Platform%20Runtime%2=
0Mechanism%20-%20with%20legal%20notice.pdf # [1]
>
> Signed-off-by: Zhu Qiyu <qiyuzhu2@amd.com>
> ---
> Previous versions can be found at:
> v1: https://lore.kernel.org/linux-acpi/20250427075317.42687-1-qiyuzhu2@am=
d.com/
> v2: https://lore.kernel.org/linux-acpi/20250512010620.142155-1-qiyuzhu2@a=
md.com/#r
> v3: https://lore.kernel.org/linux-acpi/20250512011833.142204-1-qiyuzhu2@a=
md.com/t/#u
> v4: https://lore.kernel.org/linux-acpi/20250518062507.218855-1-qiyuzhu2@a=
md.com/
>
> Changes in v2:
>  - Reduce the code changes.
> Changes in v3:
>  - Fixed title letters not showing.
> Changes in v4:
>  - Only print the necessary warnings.
> Changes in v5:
>  - Add more cases of print warnings.
>
>  drivers/acpi/prmt.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index e549914a636c..ed39502ed86f 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -85,8 +85,6 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>                 }
>         }
>
> -       pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa)=
;
> -
>         return 0;
>  }
>
> @@ -154,13 +152,33 @@ acpi_parse_prmt(union acpi_subtable_headers *header=
, const unsigned long end)
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid=
);
>                 th->handler_addr =3D
>                         (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
> +               /*
> +                * Refer to PRM Spec, both static data buffer address and
> +                * ACPI parameter buffer address may be NULL if they are =
not
> +                * needed, so there print out warning if handler_addr is =
zero.
> +                */

Change the comment above to something like "Print a warning message if
handler_addr is zero which is not expected to ever happen."

> +               if (unlikely(!th->handler_addr))
> +                       pr_warn("Failed to find VA of handler for GUID: %=
pUL, PA: 0x%llx",
> +                               &th->guid, handler_info->handler_address)=
;
>
>                 th->static_data_buffer_addr =3D
>                         efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address);
> +               /*
> +                * As for the static_data_buffer_addr/acpi_param_buffer_a=
ddr,
> +                * if the physical address passed to efi_pa_va_lookup() i=
s nonzero
> +                * and the return value is zero, there should print out t=
he warnings.
> +                */

Change the comment above to something like "According to the PRM
specification, static_data_buffer_address can be zero, so avoid
printing a warning message in that case."

> +               if (unlikely(!th->static_data_buffer_addr && handler_info=
->static_data_buffer_address))
> +                       pr_warn("Failed to find VA of static data buffer =
for GUID: %pUL, PA: 0x%llx",
> +                               &th->guid, handler_info->static_data_buff=
er_address);
>
>                 th->acpi_param_buffer_addr =3D
>                         efi_pa_va_lookup(&th->guid, handler_info->acpi_pa=
ram_buffer_address);
>
> +               if (unlikely(!th->acpi_param_buffer_addr && handler_info-=
>acpi_param_buffer_address))
> +                       pr_warn("Failed to find VA of acpi param buffer f=
or GUID: %pUL, PA: 0x%llx",
> +                               &th->guid, handler_info->acpi_param_buffe=
r_address);

And analogously here.

> +
>         } while (++cur_handler < tm->handler_count && (handler_info =3D g=
et_next_handler(handler_info)));
>
>         return 0;
>

Thanks!

