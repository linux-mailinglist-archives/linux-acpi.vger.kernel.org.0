Return-Path: <linux-acpi+bounces-13750-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8A3AB9E31
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1191118955E1
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF5478F5D;
	Fri, 16 May 2025 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byNQzAgX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AAF13B590;
	Fri, 16 May 2025 14:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747404464; cv=none; b=JqMgzh8zqq4u6jzfApkvm0xRN1jxyBWdNNMxT24/4Dep3SKNngLsZtKBIFMeeXZj96SitVstE648WoOOrBArsERwvUdzAxISFKTvcEjgcGy2J7qeWcC+OPhYnHeqAwa+15tO8O0UgkQoEFEgXRt2mHHukxbFipM75K6XfuP6OEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747404464; c=relaxed/simple;
	bh=z5CJXSHYb56Hs6grzL8lMrLCv9J6o+xPsjvhA8R4mN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwezeUm1xd88gmleAiEJY0+D6kv0jcJLxcGKiWjkhK3dMyenSO9Py403ycRaPLBRd8m/EN9BlgetsRT2pQdL1EKCdX5c+P8AGhVqoiNhCymnrmsCA8DM8DmQeTil4JXO+YOt29UQJz3XMiT2JHoLR6PC6+kqRAZOTC6mu7q+R/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byNQzAgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117BDC4CEED;
	Fri, 16 May 2025 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747404463;
	bh=z5CJXSHYb56Hs6grzL8lMrLCv9J6o+xPsjvhA8R4mN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=byNQzAgXeHEilmF9wp+3Hx/ikqXyGzH4MZuC/KUbg1TswccvypwhKqERitNRQba5h
	 675MuUPGrPTv/Khfh+XQ88Z7stYfx5ezYWgh8rovA8Mj8lyP/Roeufjo7253KwOPno
	 CA8/sKoZ7TYjQziUqxHMKxYnocjaDhm+LsV+HiKQfL3NErwAaEwjBodF7fkU07sFQr
	 IEX6CfbfNO/fMvueo2in2YZyxjcEg1mFIpNaNCVC5U1vn6XscH08p3wpPvUJJYgwx5
	 /MhwMQ1jlSMRoC/6wIZmtsi87KXybWUyjXVeiF9jROBUn6Ehf+Qy47vI+AaI67P3bL
	 W3UOWuk4P/T2g==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3fefbbc7dd4so1934421b6e.2;
        Fri, 16 May 2025 07:07:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbZk6hPT0+EImprv1EPX9YD6ZG+slbnLr3xqBksUYhcckxxIoU4eSX7w4r7qw6lJAf8WjDFG0qsZvexshH@vger.kernel.org, AJvYcCXojnOTthlNUhwHeVhYcz4tnxS7wqs5XEWy+s5ZYdCL6brk0n8FtJKTJNDu8iFZjk1YfsglYTKcg0nH@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjDFEYhjqKXlfeUP4s73+30iJ5koXTcJETnetw5U6lXWLWK1O
	BP0kQzUt2qqEOPJ42PVZb81AfbKqXeL6warf8hpmo45eXro0mL5enKs5R6bnqDcQX3a2QjYl0F3
	j53aiRZC+lcwrKWHkYOjShObxeHzO7/E=
X-Google-Smtp-Source: AGHT+IHj3cGtBESuyk5acA7ZnDt3cc0CYgGRZbKlMhvz8S2gwW5RE5WldFPS7054QkWZhHJ8KMK2aFDgQO9tBiCnlVg=
X-Received: by 2002:a05:6808:22a5:b0:403:28ab:cfe4 with SMTP id
 5614622812f47-404da76769amr1853099b6e.22.1747404462401; Fri, 16 May 2025
 07:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411194820.3976363-1-chenyuan0y@gmail.com>
In-Reply-To: <20250411194820.3976363-1-chenyuan0y@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 16:07:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9YZLct_OkQsNDeh3HUv9YccvvT18JJd8Hu9JpQ0ksRw@mail.gmail.com>
X-Gm-Features: AX0GCFuEcBC0DziP9FKUFxc2cysX_VpvY51zJLLdcAALPBZeB4AP_nFhQUWz_eM
Message-ID: <CAJZ5v0g9YZLct_OkQsNDeh3HUv9YccvvT18JJd8Hu9JpQ0ksRw@mail.gmail.com>
Subject: Re: [PATCH] x86/acpi: fix potential NULL deref in acpi_wakeup_cpu()
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	bhe@redhat.com, kai.huang@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 9:48=E2=80=AFPM Chenyuan Yang <chenyuan0y@gmail.com=
> wrote:
>
> The result of memremap() may be NULL on failure, leading to a NULL
> dereference. Add explicit checks after memremap() call: if the
> MADT mailbox fails to map, return immediately.

This mailbox is called Multiprocessor Wakeup Mailbox in the
specification, so please follow the established terminology.

> This is similar to the commit 966d47e1f27c
> ("efi: fix potential NULL deref in efi_mem_reserve_persistent").
>
> This is found by our static analysis tool KNighter.
>
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 2b5e22afae07 ("x86/acpi: Extract ACPI MADT wakeup code into a sepa=
rate file")
> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/ma=
dt_wakeup.c
> index f36f28405dcc..b386ec4b87c2 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -143,6 +143,10 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long=
 start_ip)
>                 acpi_mp_wake_mailbox =3D memremap(acpi_mp_wake_mailbox_pa=
ddr,
>                                                 sizeof(*acpi_mp_wake_mail=
box),
>                                                 MEMREMAP_WB);
> +               if (!acpi_mp_wake_mailbox) {
> +                       pr_err("Failed to remap MADT mailbox\n");

Please follow Kirill's advice on using pr_err_once() here and use the
proper terminology in the message (also this is mapping, not
remapping, even though memremap() is used).

> +                       return -ENOMEM;
> +               }
>         }
>
>         /*
> --

Thanks!

