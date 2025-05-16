Return-Path: <linux-acpi+bounces-13753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C0AB9EB2
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB65C1BC345F
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC9192598;
	Fri, 16 May 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB1vcffg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF718DF6D;
	Fri, 16 May 2025 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406089; cv=none; b=dFEogqbgaJTkISMbYhUpOegRv9xWhQ37aDip2M4yljuDgVTBDUJ4rKO+5iUzMGrqzw4q3UjnEXgkqsaE/elLR0joOLYZV1MCGJGsTdB5WwD98yCsQDI8ZYimYHdmQpH9E3yplPcGPvn20HouqJjJrSgytnB6uzQLZCtpTOmSihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406089; c=relaxed/simple;
	bh=0NjYNMvQxfUI57i71mZdpWSId3SrSDS4W9O9Zr+MoGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DG90qXkGat8+pb/mfSvPMB6ykawEfRMgswJM48TCO4k3qAAmlYZhPc8JigUe58otkhls9xJ0eyH3Qbi9o9ZZE2wTCCTmiImMA5ncR9bQhjuNxQO7PNGZhORqcXBcpGH6oE+IVUTpt1yb4kb8U2S2Qw9mRSL6UVWif6ki7B/R3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB1vcffg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411F3C4CEE4;
	Fri, 16 May 2025 14:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747406089;
	bh=0NjYNMvQxfUI57i71mZdpWSId3SrSDS4W9O9Zr+MoGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uB1vcffgg6asDkiwuek2idPAL+Xa/uDS0WdWBL4YgJDRKFiNPLuN00aztZgtSO7ho
	 RkKK5Yv3968Fwo35Te+ut9+nyP2CX3xXRYqovjFmv8C32OApNkZvqDJsqV3FviVYEe
	 h9id4yigUG/lWWrP+jzRzmisVO5n9rl/j/YhxIeFZhiFktdq6mrEhGjV7lalhPwqo8
	 0/NdrhAf+dc2etCqo9+TOy004idrbJ1YcADi0B8yaS0gPG/4DfnyH/gt6MOnM00hCq
	 uglyaAlv5/1NzIV01oIqLfAdd3yBWc0ik7q/ghLSnHz7Xqrh3LcdyAc5qIQNhKRtSy
	 txHclJUTbLTiw==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72a4793d4e2so1799187a34.2;
        Fri, 16 May 2025 07:34:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVd6pRiYMzk7f35cwlypQYgOldwdYwfStr09+pQTmvqAgBTuQwGa4uQBI5NPKZi4jPDhfjTPE/DAdTg@vger.kernel.org, AJvYcCXZhAvr6m3Ymv41vIP+FeXRobqT2uWDDzONVMo556xHRXHU3K5CnVQqrF5VZ5ZtEJuxIkkC1c/pw7HQ+/bf@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xkXn6UvnF0aE+wsTgYocU67UE/NBuWSBX+m/FWnENiUywC33
	OLKc/2MPmZezAnRYxlQDyYWte/DaPv5shQ4I8BCDgID3GAzJMWfLBobU+AZhX2CiH4hWR7Ifba2
	bsT6pCigYZ49HEcfkSSyNxc8PLl2Oq3o=
X-Google-Smtp-Source: AGHT+IE1b+2SUr/+Z1nzo4YCIhc1faUpWy8qmtN/YR8z+9MG/tkEjVzSXTYLTsCJsEgl7e+RNHo99Z+n43Rh/jV2Hl0=
X-Received: by 2002:a05:6820:1908:b0:606:361b:52ad with SMTP id
 006d021491bc7-609f3731c3bmr2213078eaf.3.1747406088562; Fri, 16 May 2025
 07:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512011833.142204-1-qiyuzhu2@amd.com>
In-Reply-To: <20250512011833.142204-1-qiyuzhu2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 16:34:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ibrZOLi8yi1VzTPVVTTTb7S7_5RO4knfNJcaL9vOWYjg@mail.gmail.com>
X-Gm-Features: AX0GCFtWIRrf42a8BQLU188g_6BH0wOMrnKzeAVlk1ei0WcxuSAzKQg-PsCucwA
Message-ID: <CAJZ5v0ibrZOLi8yi1VzTPVVTTTb7S7_5RO4knfNJcaL9vOWYjg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI:PRM: Reduce unnecessary printing to avoid the
 worries of regular users
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 3:19=E2=80=AFAM Zhu Qiyu <qiyuzhu2@amd.com> wrote:
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
>
> Previous versions can be found at:
> v1: https://lore.kernel.org/linux-acpi/CAJZ5v0hv0WKd-SXFhUgYs-Zpc+-PsSNOB=
u0r7L5TzJWgddtsKA@mail.gmail.com/t/#u
> v2: https://lore.kernel.org/linux-acpi/20250512010620.142155-1-qiyuzhu2@a=
md.com/#r
>
> Changes in v2:
>  - Reduce the code changes.
> Changes in v3:
>  - Fixed title letters not showing.
>
>  drivers/acpi/prmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index e549914a636c..28a9930267a3 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -85,7 +85,7 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
>                 }
>         }
>
> -       pr_warn("Failed to find VA for GUID: %pUL, PA: 0x%llx", guid, pa)=
;
> +       pr_info("VA for GUID: %pUL, PA: 0x%llx not found\n", guid, pa);

Thanks for following my advice, but on second thought, it would be
good to discard the message entirely if pa is zero and it is valid by
the spac, but still complain if pa is nonzero and it cannot be mapped.

So what about doing something like this in acpi_parse_prmt():

if (handler_info->static_data_buffer_address)
        th->static_data_buffer_addr =3D efi_pa_va_lookup(&th->guid,
handler_info->static_data_buffer_address);
else
        th->static_data_buffer_addr =3D 0;

and analogously for th->acpi_param_buffer_addr()?

>
>         return 0;
>  }
>
> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
> --

