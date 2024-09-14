Return-Path: <linux-acpi+bounces-8293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C92978EA3
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 09:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1301C256EE
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 07:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F81CF5C2;
	Sat, 14 Sep 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J74b5Vz4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530A1CF2B9;
	Sat, 14 Sep 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297286; cv=none; b=tvlHIgoSZag5yVYUi3SSI46hHOB6lXmLpEi51KtvaHQ7tIAJouF+ATQaKObRGFftWJY1p4v3eusPVOJCdKUvG7nLhufP8lCa3mQdY9yykUwq8aTXQtDPlMK3/tZDyMSu8lHjW1N073ZwKDMDooJEInj8xTqjZQz1/NFd5moGWhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297286; c=relaxed/simple;
	bh=pAAX0KCSWLQBA01Cd4CQx1R8SR/audm/xYtxJbBZpUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM/BjTzndrdsa9Uv+2sbsRPGi+0mC3ZalGWUrGJmb2vBTsvEv2WDI5D0tSeyC484xVsB9wibG6tlyNleM3CdYrBa1u+JKGZXKxl1nBzr/XNj8/VzhFVYC/k2C0H1bT9lm9wo1ZYqYOdDqxvz/1mILNedJfsImzwUhPTgr5NsEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J74b5Vz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DC1C4CECD;
	Sat, 14 Sep 2024 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726297286;
	bh=pAAX0KCSWLQBA01Cd4CQx1R8SR/audm/xYtxJbBZpUM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J74b5Vz4+f3CdfiHng+lO6CemsJs+rNJwG2eChMkifZKQ+LvI8NAKpzpNYjC2Wet1
	 aEVvn0fWLDDu4RJeZ6DpFCxDPjNIQ7R98oVvUKAONLyf35VJ0663M5bJDScgGAEVXx
	 5pBjknskq2eE7eX1SoRalqOr4TNSr2a/rFp8pI7VpQF2oySndCtcVU7Yl5HRfA7DM6
	 BC0wZZFLYuGKh0LUNPcrsUwpB+IzaHyWkPqKirtJrbQJkD6trGEnz2cWHZXRzZ28F/
	 hTV0DaMQDpUDx6ENQlMIZqEiNUgWfeBNfggWqoSff+ogYPcdIJDqgRKN2X31SMMfGn
	 OF2/P5jnoae2A==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso1985162a12.3;
        Sat, 14 Sep 2024 00:01:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrUG5QlbRKNm4xDGmy6w682ww6r93CV5tJPaijHTP/FsIaqhEROOeibj886MyKUOXsRIQJ0qSDQMXm@vger.kernel.org, AJvYcCX73VWNsyKlqCDOjSoaPuJQVtCBeQaCaUlNL54iFNeDC1dssw7NBDCcZsELn15AY9NkUWTa2V2F1c9/o+vm@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1sgk1lQaKyPD4AHP4mFI4yce9MvII8cyuQDp68AG3uFSacVw
	xJeMLlEnoivWRVjL8vWLMVKFfAEwMqWCyC92E2YvQxdag6NpgNleaX9x4skyeVYgrgl21LzoV6Y
	4zdkBz0DQItD+wxr5E5EcAyK7aAc=
X-Google-Smtp-Source: AGHT+IHtBBMLgh+2a9loR1CyOfl973gonH0M92BPbQAzTuGjcRcCGrclL2qbUIUH5p8hwjjcDoEyR/4TbDZwO11Va6c=
X-Received: by 2002:a05:6402:d05:b0:5c2:4a98:7520 with SMTP id
 4fb4d7f45d1cf-5c41e1b5302mr4978875a12.31.1726297284766; Sat, 14 Sep 2024
 00:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914065318.2099448-1-maobibo@loongson.cn>
In-Reply-To: <20240914065318.2099448-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 14 Sep 2024 15:01:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6k2c9M1htncx3UQdqy275PHDZTeo_56fWbtxDYNH-s6w@mail.gmail.com>
Message-ID: <CAAhV-H6k2c9M1htncx3UQdqy275PHDZTeo_56fWbtxDYNH-s6w@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Enable ACPI BGRT handling
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Sat, Sep 14, 2024 at 2:53=E2=80=AFPM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> Add ACPI BGRT support on LoongArch so it can display image provied by
> acpi table at boot stage and switch to graphical UI smoothly.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409102056.DNqh6zzA-lkp@i=
ntel.com/
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v1 ... v2:
>   1. Solve compile warning issue reported from lkp, return type of
>      function early_memunmap() is void *, that of function early_ioremap(=
)
>      is void __iomem *, force type conversion is added.
I've applied V1, build warnings seems another problem which has no
relationship with this patch itself.

Huacai

> ---
>  arch/loongarch/include/asm/io.h | 4 +---
>  arch/loongarch/kernel/acpi.c    | 8 ++++++--
>  arch/loongarch/mm/ioremap.c     | 9 +++++++++
>  drivers/acpi/Kconfig            | 2 +-
>  4 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm=
/io.h
> index 5e95a60df180..3049bccec693 100644
> --- a/arch/loongarch/include/asm/io.h
> +++ b/arch/loongarch/include/asm/io.h
> @@ -10,6 +10,7 @@
>
>  #include <asm/addrspace.h>
>  #include <asm/cpu.h>
> +#include <asm/early_ioremap.h>
>  #include <asm/page.h>
>  #include <asm/pgtable-bits.h>
>  #include <asm/string.h>
> @@ -17,9 +18,6 @@
>  extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long s=
ize);
>  extern void __init early_iounmap(void __iomem *addr, unsigned long size)=
;
>
> -#define early_memremap early_ioremap
> -#define early_memunmap early_iounmap
> -
>  #ifdef CONFIG_ARCH_IOREMAP
>
>  static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned lo=
ng size,
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index 929a497c987e..2993d7921198 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/init.h>
>  #include <linux/acpi.h>
> +#include <linux/efi-bgrt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/memblock.h>
> @@ -39,14 +40,14 @@ void __init __iomem * __acpi_map_table(unsigned long =
phys, unsigned long size)
>         if (!phys || !size)
>                 return NULL;
>
> -       return early_memremap(phys, size);
> +       return (void __iomem *)early_memremap(phys, size);
>  }
>  void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>  {
>         if (!map || !size)
>                 return;
>
> -       early_memunmap(map, size);
> +       early_memunmap((void *)map, size);
>  }
>
>  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size=
)
> @@ -212,6 +213,9 @@ void __init acpi_boot_table_init(void)
>         /* Do not enable ACPI SPCR console by default */
>         acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
>
> +       if (IS_ENABLED(CONFIG_ACPI_BGRT))
> +               acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> +
>         return;
>
>  fdt_earlycon:
> diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
> index 70ca73019811..28562ac510c8 100644
> --- a/arch/loongarch/mm/ioremap.c
> +++ b/arch/loongarch/mm/ioremap.c
> @@ -16,6 +16,15 @@ void __init early_iounmap(void __iomem *addr, unsigned=
 long size)
>
>  }
>
> +void __init *early_memremap(resource_size_t phys_addr, unsigned long siz=
e)
> +{
> +       return (__force void *)early_ioremap(phys_addr, size);
> +}
> +
> +void __init early_memunmap(void *addr, unsigned long size)
> +{
> +}
> +
>  void *early_memremap_ro(resource_size_t phys_addr, unsigned long size)
>  {
>         return early_memremap(phys_addr, size);
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e3a7c2aedd5f..d67f63d93b2a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -451,7 +451,7 @@ config ACPI_HED
>
>  config ACPI_BGRT
>         bool "Boottime Graphics Resource Table support"
> -       depends on EFI && (X86 || ARM64)
> +       depends on EFI && (X86 || ARM64 || LOONGARCH)
>         help
>           This driver adds support for exposing the ACPI Boottime Graphic=
s
>           Resource Table, which allows the operating system to obtain
>
> base-commit: 196145c606d0f816fd3926483cb1ff87e09c2c0b
> --
> 2.39.3
>
>

