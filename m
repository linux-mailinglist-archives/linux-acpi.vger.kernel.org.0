Return-Path: <linux-acpi+bounces-13862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EDAAC257E
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 16:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066761C06D2D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9979297A46;
	Fri, 23 May 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8mi6Fyo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28A202F9A;
	Fri, 23 May 2025 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011936; cv=none; b=ukjpxhk0NxFBdoPq1cDi+ParUA7vux0yDqKBmPlR+F8+mSu2+Vl2ZUKqQNw+kP0BNxV/BsEBCCFzF0gJLOY+Lipi0LPzMrPz6zJvhKImZz1zUdMDmx3yieyvVOc3MPPmurKglcj+coHHPdXc7JoJxELVX12ine0ZjDACs42FTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011936; c=relaxed/simple;
	bh=UTAR2iy/uxOeSJh9VEWXa5QU73DR1njr4ZjUY2GTTDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWOM7KYdT1svdVWjx0/HJRLPlv8SHEOsxeEjIApjOrD5X6pLqvtUWLHCT9hVeqoKUCqoRM9pm5MHUi53qiBhNk0lbsK3lSW/J1xvgCkYn5ARynL0mVLtmoa/BnonIONr1z2FissjM3vw1ZtOO9hEG4fFl1r0o+kn6P6LLg3lmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8mi6Fyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC7AC4CEED;
	Fri, 23 May 2025 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748011936;
	bh=UTAR2iy/uxOeSJh9VEWXa5QU73DR1njr4ZjUY2GTTDo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s8mi6FyortUYGt0IIRnZsD9veN9LrHvjRTHHqreVHHzOGIg9AalHJfv/Y98LDPCpo
	 qdqsyMVJNZglcmKej1gMDHxgktpuKJJ8asQlFY93hbyY0QlJsoDhQ+3omy3cKjjLIe
	 pYrls4Amuf8miGy6Q/H4sA5+WUOxQOi/j9X1NjUolEVlDPmPzQpjQ9fNoO1VRu5kK0
	 1S3YKA86yiuYDdUfjpO2fxQAqMUQ1whTBgih79bl7EQ3cYJnR7yEr07CMvHYripsfA
	 LuFbYDExh70JI/2xvBQiRFQkwgdg3j1xTVQqdIM8bZm6St+W2gR4FTZ6N3hmgHcjCM
	 XtlhxfpxgGlpQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-60638c07cabso5044313eaf.3;
        Fri, 23 May 2025 07:52:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhk/vxnQT/6aj48WmlluXeUlyTa4yBMMQqVBk0k+L2luADVf5onStBAo84GEn/Hp1P7VkUM6Pl1NfRMHfZ@vger.kernel.org, AJvYcCXvK0mOsd76Xaw+pwJtoaiRyfBzzAl9NXPn5TO0xpnBYwAtLP+u/YYGnURF2cPFjOfKDJ57GlaWxdnH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtp0gv1OMdw71IGR3V8cgJqvM6s6pYAk9ypdck6Zbl1NEUJkhi
	rBb2PUloQJ1ox+hlv8gZqquQtapShSHsLWAKj4RzbJ9gYT/LrQRFewrTL/fwVy9JmyeJ9JUTv6f
	wuQ0OqH22wVmVQ/5UkPJ41W6klWh0c0c=
X-Google-Smtp-Source: AGHT+IEjIt9zuW1SYHAzDYXZZ2aidbpwLVD1ppi88XkXtZ3szJvG/WZsF4tlPCqUd+BP3rE3sA+BkHwkQWxfvq6xm0w=
X-Received: by 2002:a05:6820:1807:b0:608:34d1:db96 with SMTP id
 006d021491bc7-609f3731c81mr18219981eaf.4.1748011935630; Fri, 23 May 2025
 07:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518062507.218855-1-qiyuzhu2@amd.com>
In-Reply-To: <20250518062507.218855-1-qiyuzhu2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 16:52:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+CSu80-ZBbU-_RpHbdG8As4rrsKbXLM4RqY12JtV-Cg@mail.gmail.com>
X-Gm-Features: AX0GCFuHUx7XTCRRPtV2RuD93zdMXdHrSYDsHVxTcBkuvqL81CkEn1AhkkAKjOo
Message-ID: <CAJZ5v0h+CSu80-ZBbU-_RpHbdG8As4rrsKbXLM4RqY12JtV-Cg@mail.gmail.com>
Subject: Re: [PATCH v4] ACPI:PRM: Reduce unnecessary printing to avoid the
 worries of regular users
To: Zhu Qiyu <qiyuzhu2@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 18, 2025 at 8:25=E2=80=AFAM Zhu Qiyu <qiyuzhu2@amd.com> wrote:
>
> Commit 088984c8d54c ("ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM
> handler and context") introduces non-essential printing "Failed to find
> VA for GUID: xxxx, PA: 0x0" which causes unnecessary worry for regular
> users.
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
> v3: https://lore.kernel.org/linux-acpi/20250512011833.142204-1-qiyuzhu2@a=
md.com/t/#u
>
> Changes in v2:
>  - Reduce the code changes.
> Changes in v3:
>  - Fixed title letters not showing.
> Changes in v4:
>  - Only print the necessary warnings.
>
>  drivers/acpi/prmt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index e549914a636c..bee450869cce 100644
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
> @@ -154,6 +152,15 @@ acpi_parse_prmt(union acpi_subtable_headers *header,=
 const unsigned long end)
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid=
);
>                 th->handler_addr =3D
>                         (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
> +               /*
> +                * Refer to PRM Spec, both static data buffer address and
> +                * ACPI parameter buffer address may be NULL if they are =
not
> +                * needed. So there only print out warning if handler add=
ress
> +                * is zero.
> +                */
> +               if (!th->handler_addr)
> +                       pr_warn("Failed to find VA for GUID: %pUL, PA: 0x=
%llx",
> +                               &th->guid, handler_info->handler_address)=
;

I think that the message should still be printed in the other cases if
the physical address passed to efi_pa_va_lookup() is nonzero and the
lookup fails.

>
>                 th->static_data_buffer_addr =3D
>                         efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address);
>
> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
> --

