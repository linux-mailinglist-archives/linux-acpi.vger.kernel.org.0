Return-Path: <linux-acpi+bounces-15045-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D695EAFB8CC
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 18:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728F11883582
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jul 2025 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6D221FB8;
	Mon,  7 Jul 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scGorbum"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67919F461;
	Mon,  7 Jul 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906383; cv=none; b=kBZI2Z/+tfuWiPYP2zDp4Xz8XaWJUhgOPwFkxo06hmEYtNMu4ibAb0Y5GtCeSh+d5b5y6yyNr99rragT4KtwUTgmsUoYOAkH5b/R+qDYsvwztCH/RKUHC18Sh+jLSB0lFvmp6MTtvYF6vhHVgPOe3Th+U0rr3F9zqcl6B20agv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906383; c=relaxed/simple;
	bh=4opHbQCA27MNwwMHt2GLaUhExkIEeheJ7fdPOa2b83E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs7VyzPzNu83V+E9jHAWBRAnRpthuyfuTHvphNTgOURVkYz2lw0CcGo/x0jT2s/VHwW+dS9AH8cnZrZgaY9vQr4iBHnc45eNmEFdjWM19YcDsiN11rDyAjRaHca6BSB1BwIgikE8iwyjZ4FjBffoZCLvKgck1jj8AI16ksKO6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scGorbum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E185BC4CEF5;
	Mon,  7 Jul 2025 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751906382;
	bh=4opHbQCA27MNwwMHt2GLaUhExkIEeheJ7fdPOa2b83E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=scGorbumwG/w5BCteMs02zO2ME1r0zgNEOd/K5MuA2Nuh8cwm3rHPi37uLXtiZQEa
	 TyqTq1fRLLqnTkW5pIx1Ue/i4wpql4uMxxvxRHMo4PGE34yClfcHaf5+rtgLo3rMTE
	 TYIYPYTQWcYPEiVU5OuKbVwZ5L+cRTG0jVqujOvNJ+YJPYnrZtIi7VYiM7x3I0NV1o
	 32GdehvHpNCsKPmn7p9JOoxPVbcHHQLsrMNrVM7Bm4VeGEV+DU6/CZHsdrpBKphvyF
	 IXHy0x6bqGQJ3zQVLcFEPLgD1/BRJmXkl6wcNK7V/DkOY03DGyb60JlfiGuagtNoui
	 DdxQsteJ4OyaQ==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73caf1152bdso1462056a34.3;
        Mon, 07 Jul 2025 09:39:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDEd0HJv34ihU60bjw9wQ7swtiI6XBd9XlVOgLVWM9iZ4XfMlZV9gGjgOyRPCFIoqc4UZwJtZi1cP6eULB@vger.kernel.org, AJvYcCUipPBxF2Yk5OGM2T2eg3bFNg8ikUYMAr1vELBC4PWxN8BGqfkkEsi+rVNgYKUsmla0eTt86Sb7F5K/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/MkU4WmUeEtJyD0RdwCFuI/OjUKZftIYBDJgWeZOvaABiQwgF
	LxCCQAO8VlbWX5wBSRu9zSHJ9vJVtwBL1ubsHFrssm7oAA6jzRTNW2nK1EHQgnshbdmK2PlNKsv
	8/sB+3/gQFzCZXNAw4bWO706Xp3XnN6Y=
X-Google-Smtp-Source: AGHT+IHQiZbWmqIr7meT9HgdbspOEOBUFep8B2XUsJE3NGIv1r2zW+bY3ecngGD5T/1zU964WypJf0QnkuJinHiMDlU=
X-Received: by 2002:a05:6830:6204:b0:727:24ab:3e4 with SMTP id
 46e09a7af769-73cd63b441amr9319a34.9.1751906382139; Mon, 07 Jul 2025 09:39:42
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704014104.82524-1-qiyuzhu2@amd.com>
In-Reply-To: <20250704014104.82524-1-qiyuzhu2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Jul 2025 18:39:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixL985XeTPbgwC3iedZgHK_TqFOejAdQse5b4dOTBjXw@mail.gmail.com>
X-Gm-Features: Ac12FXzp7GxbYkoj8EYqqFGXxvBIn-N0Ogs6irefqp5XgWMBIAnPm5Egvf8ZIC4
Message-ID: <CAJZ5v0ixL985XeTPbgwC3iedZgHK_TqFOejAdQse5b4dOTBjXw@mail.gmail.com>
Subject: Re: [PATCH V6] ACPI:PRM: Reduce unnecessary printing to avoid the
 worries of regular users
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 3:41=E2=80=AFAM Zhu Qiyu <qiyuzhu2@amd.com> wrote:
>
> Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
> handler and context") introduces non-essential printing "Failed to find
> VA for GUID: xxxx, PA: 0x0" which causes unnecessary worry for regular
> users.
>
> Refer to PRM Spec Section 4.1.2[1], both static data buffer address
> and ACPI parameter buffer address may be NULL if they are not needed.
> So there is no need to print out "Failed to find VA ... " to intimidate
> regular users in that case.
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
> v5: https://lore.kernel.org/all/20250527024259.56996-1-qiyuzhu2@amd.com/
>
> Changes in v2:
>  - Reduce the code changes.
> Changes in v3:
>  - Fixed title letters not showing.
> Changes in v4:
>  - Only print the necessary warnings.
> Changes in v5:
>  - Add more cases of print warnings.
> Changes in v6:
> -  Adjust the code comments.
>
>  drivers/acpi/prmt.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index e549914a636c..d7857ca8fb4c 100644
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
> @@ -154,13 +152,39 @@ acpi_parse_prmt(union acpi_subtable_headers *header=
, const unsigned long end)
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid=
);
>                 th->handler_addr =3D
>                         (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
> +               /*
> +                * Print a warning message if handler_addr is zero which =
is not expected to
> +                * ever happen.
> +                */
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
> +                * According to the PRM specification, static_data_buffer=
_address can be zero,
> +                * so avoid printing a warning message in that case.
> +                * If the static_data_buffer_address passed to efi_pa_va_=
lookup() is nonzero
> +                * and the return value is zero, print a warning message =
in that case.
> +                */
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
> +               /*
> +                * According to the PRM specification, acpi_param_buffer_=
address can be zero,
> +                * so avoid printing a warning message in that case.
> +                * If the acpi_param_buffer_address passed to efi_pa_va_l=
ookup() is nonzero and
> +                * the return value is zero, print a warning message in t=
hat case.
> +                */
> +               if (unlikely(!th->acpi_param_buffer_addr && handler_info-=
>acpi_param_buffer_address))
> +                       pr_warn("Failed to find VA of acpi param buffer f=
or GUID: %pUL, PA: 0x%llx",
> +                               &th->guid, handler_info->acpi_param_buffe=
r_address);
> +
>         } while (++cur_handler < tm->handler_count && (handler_info =3D g=
et_next_handler(handler_info)));
>
>         return 0;
>
> base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
> --

Applied as 6.17 material with some edits in the subject and changelog,
and in the new code comments added by the patch.

Thanks!

