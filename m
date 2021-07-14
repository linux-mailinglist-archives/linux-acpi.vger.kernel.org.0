Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B993C8477
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jul 2021 14:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGNMdg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Jul 2021 08:33:36 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:34458 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbhGNMdf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Jul 2021 08:33:35 -0400
Received: by mail-oi1-f178.google.com with SMTP id u11so2080752oiv.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jul 2021 05:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWjs+l2KRQxhNxy2IfZ3C4oLVq4qtI5HHK2Spq22OdY=;
        b=QWXFC0HsiDUTYBBjsOh/2EwBbzHGcg2oBvVErF0jYVC5kXsTLl5WUPxZzrpsJfli7+
         MsW4DMvCDVaFRrLLuNMlatKsyJvVut3QiEvegNZ6uiyhgLu/jDDUJAPf1hJRk6a6KfoP
         666BUbxMbQmT3CmHAwIvHLyw9T0SNb8IY83AZ9OC/cqMlmiHpEJShdG6AJCHca9cSaXY
         Y78j80I6O9ySVIFC1+7kk3m2TMpLpjS+QDvmxP7B1045Ko5uaxCmkd4qb28QWw/kJLSM
         z3enzxOcKOv9ouMR+rUlBTWf5U+1ufRDBR9ADyse3l6TEpUxWijFd9yss3sDk+qrrgAq
         BWCQ==
X-Gm-Message-State: AOAM533bp6GLOD7NbTCVrofNoYL/2QGgfvgie5stiuAR0+nkiMGdbqTF
        djjf7DfOC6y4GK2hCcQ66l8LXKPZR6yBHa19qiA=
X-Google-Smtp-Source: ABdhPJw27x2/gF/JpIqFRGtZCA5yTdAIx9dyGZ8AH8Jl5ocHToKpNtDpx2xbNWDRJF4JN1uVeLx6ABg2uLvEnT4hxW8=
X-Received: by 2002:aca:3502:: with SMTP id c2mr649070oia.157.1626265844194;
 Wed, 14 Jul 2021 05:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210705124206.1228958-1-chenhuacai@loongson.cn> <20210705124206.1228958-2-chenhuacai@loongson.cn>
In-Reply-To: <20210705124206.1228958-2-chenhuacai@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 14:30:33 +0200
Message-ID: <CAJZ5v0gyun_85uXrH6jt-d3XjaOFZmHEYGnKKGL-XUb=4ZcrMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: Add LoongArch support for ACPI_PROCESSOR/ACPI_NUMA
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 5, 2021 at 2:41 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> We are preparing to add new Loongson (based on LoongArch, not MIPS)
> support. LoongArch use ACPI other than DT as its boot protocol, so
> add its support for ACPI_PROCESSOR/ACPI_NUMA.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/acpi/Kconfig      | 4 ++--
>  drivers/acpi/numa/Kconfig | 2 +-
>  drivers/acpi/numa/srat.c  | 2 +-
>  include/linux/acpi.h      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index fe0bb6277e4d..90afa44efcba 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -280,9 +280,9 @@ config ACPI_CPPC_LIB
>
>  config ACPI_PROCESSOR
>         tristate "Processor"
> -       depends on X86 || IA64 || ARM64
> +       depends on X86 || IA64 || ARM64 || LOONGARCH
>         select ACPI_PROCESSOR_IDLE
> -       select ACPI_CPU_FREQ_PSS if X86 || IA64
> +       select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
>         default y
>         help
>           This driver adds support for the ACPI Processor package. It is required
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index fcf2e556d69d..39b1f34c21df 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -2,7 +2,7 @@
>  config ACPI_NUMA
>         bool "NUMA support"
>         depends on NUMA
> -       depends on (X86 || IA64 || ARM64)
> +       depends on (X86 || IA64 || ARM64 || LOONGARCH)
>         default y if IA64 || ARM64
>
>  config ACPI_HMAT
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 6021a1013442..b8795fc49097 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -206,7 +206,7 @@ int __init srat_disabled(void)
>         return acpi_numa < 0;
>  }
>
> -#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
> +#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
>  /*
>   * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
>   * I/O localities since SRAT does not list them.  I/O localities are
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6bb36fd6ba31..3ba8511cbede 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -249,7 +249,7 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>  /* the following numa functions are architecture-dependent */
>  void acpi_numa_slit_init (struct acpi_table_slit *slit);
>
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64)
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
>  void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
>  #else
>  static inline void
> --

Does this patch alone make sense without the other two in the series?
If so, I can queue it up for 5.15, so please let me know.

Thanks!
