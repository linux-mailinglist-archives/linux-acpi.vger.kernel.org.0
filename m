Return-Path: <linux-acpi+bounces-5797-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3A8C4D3F
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 09:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 909D3B22208
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 07:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D714277;
	Tue, 14 May 2024 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOjU5dzi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD51413ACC;
	Tue, 14 May 2024 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715672743; cv=none; b=dtAD3DpTwPdueiV91w0J9ZZeO3b7s1TlAVh/9xKIuTZ4q2BkysH3yX++bweniQkhmBMJdq4nip8/6eRCu0kFK5N3P2x740/mufVx5gCmoUkJ4J4tLSG4CSNcwB/nDbB9dBA4qs0/Ykowr7A8KivFtGX/oweezJf8IpwZILE8ZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715672743; c=relaxed/simple;
	bh=EGS3ZuMGZ+F6WZx/X5Vj2TH/jG0ZBFzj2A5DAjkwPAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuBKKVty5JlT0D6n3v2rlNbjRcQsH+Q5tLv87qtLkFvg7mtmLRNtf1VLIa6Rp5P2fIBxGs5OlHzAstvx5BbP87PTlFzQBKD2bsyQihJp11dt4N0oYTjqTvJUjgWkgjr+IMMQhhTck5jdbCCK1XYtB8T+VYSo3WmkuNwJB0LV+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOjU5dzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0CDC4AF07;
	Tue, 14 May 2024 07:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715672743;
	bh=EGS3ZuMGZ+F6WZx/X5Vj2TH/jG0ZBFzj2A5DAjkwPAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AOjU5dzizmJ+ccKgqPrPj4cKxv5pDyunMmD/rI6PXp1uKmJ273a7mFMEh3lp0Oj2t
	 /6Q4NBUjAAyeUodIuavCcpV8+a/rRHdLFhT1wjNQXtlqP24QOK5A2h++kH43uMfc6d
	 o16lekPQMIIu8gkTrZ0R76hkCfce2uo/lY3qsnducvDIpRUq6BnHMOnefYLpZvpmIO
	 WI/VwJIYtOOay2VT2U1o42jtJrF2C78FW16cKmCtQhVoT2KMvhWVOgq6XuSxXrsYpV
	 nA+6Nrb7gZDwwNW7vl7sYG7eNgoIoqoOmTvLp9UP2r7X7546O0yzvHiKCotwvGsprk
	 8lT4rGrUyrh5g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a8f0d941so1281218166b.2;
        Tue, 14 May 2024 00:45:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4di7VbMfrYdeMMlwgVD4rK4OaPlT3g3bfqeafUz4mFt9WSnWgDVM71ioNLU8jkwVwV4IfQEi6F7mp6i6TpHXZ0O/IHr8ezC6f0Qc+MkV8ceriJvJt+FtdnzI7SdVhIoEOiBeVWv8ukA==
X-Gm-Message-State: AOJu0Yxe8eS5WLWBCFIMFXEOwdaCcWsRKVnk+al6dn5e66lEVHoI7H5T
	Zt/mqlw9/L0eV9xnnlRwQf6+3ie0JbU0E/ejk4L1wfkAYa2333gWVfK+VyfDvm2f6/zUo3XHM3r
	meWkbaEnmijMr0vlSBC9CcwlX4rM=
X-Google-Smtp-Source: AGHT+IG/vt7uex7Qy0NM4l2+AXyhPJrZt+Cl6DItLGM2nktOppCoa0s3wse2tMHclrvpOZKL68tnmNP+/iRxh+BiO0c=
X-Received: by 2002:a17:906:6a1c:b0:a5a:6c0e:90f7 with SMTP id
 a640c23a62f3a-a5a6c0e91a4mr357298266b.42.1715672741853; Tue, 14 May 2024
 00:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514073910.27048-1-yangtiezhu@loongson.cn>
In-Reply-To: <20240514073910.27048-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 14 May 2024 15:45:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7iOuEEDZNHveirZA9pAH1Ax1+nRo=_miqhyzDSzzCWtw@mail.gmail.com>
Message-ID: <CAAhV-H7iOuEEDZNHveirZA9pAH1Ax1+nRo=_miqhyzDSzzCWtw@mail.gmail.com>
Subject: Re: [RFC PATCH] LoongArch: Remove ACPI related ifdefs in platform_init()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: rafael@kernel.org, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Tue, May 14, 2024 at 3:39=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> acpi_table_upgrade() and acpi_boot_table_init() are defined as
> empty function under !CONFIG_ACPI_TABLE_UPGRADE and !CONFIG_ACPI
> in include/linux/acpi.h, there are no implicit declaration errors
> with various configs. Furthermore, CONFIG_ACPI is always set due
> to config ACPI is selected by config LOONGARCH. Thus, just remove
> ACPI related ifdefs to call the functions directly.
>
>   #ifdef CONFIG_ACPI_TABLE_UPGRADE
>   void acpi_table_upgrade(void);
>   #else
>   static inline void acpi_table_upgrade(void) { }
>   #endif
>
>   #ifdef        CONFIG_ACPI
>   ...
>   void acpi_boot_table_init (void);
>   ...
>   #else /* !CONFIG_ACPI */
>   ...
>   static inline void acpi_boot_table_init(void)
>   {
>   }
>   ...
>   #endif        /* !CONFIG_ACPI */
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>
> Another way is to guard the related code under CONFIG_ACPI,
> but I think it is not necessary, like this:
>
> @@ -351,10 +351,8 @@ void __init platform_init(void)
>         arch_reserve_vmcore();
>         arch_reserve_crashkernel();
>
> -#ifdef CONFIG_ACPI_TABLE_UPGRADE
> -       acpi_table_upgrade();
> -#endif
>  #ifdef CONFIG_ACPI
> +       acpi_table_upgrade();
>         acpi_gbl_use_default_register_widths =3D false;
>         acpi_boot_table_init();
>  #endif
I agree to remove CONFIG_ACPI_TABLE_UPGRADE since it is ugly and
unnecessary here. But I prefer to keep CONFIG_ACPI (in addition, put
acpi_table_upgrade() after CONFIG_ACPI). Because CONFIG_ACPI is not
just to prevent build error, but also a signal to tell us the code is
ACPI-specific.

Huacai

>
>  arch/loongarch/kernel/setup.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 60e0fe97f61a..da96f871cf73 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -351,13 +351,9 @@ void __init platform_init(void)
>         arch_reserve_vmcore();
>         arch_reserve_crashkernel();
>
> -#ifdef CONFIG_ACPI_TABLE_UPGRADE
>         acpi_table_upgrade();
> -#endif
> -#ifdef CONFIG_ACPI
>         acpi_gbl_use_default_register_widths =3D false;
>         acpi_boot_table_init();
> -#endif
>
>         early_init_fdt_scan_reserved_mem();
>         unflatten_and_copy_device_tree();
> --
> 2.42.0
>

