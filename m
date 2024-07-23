Return-Path: <linux-acpi+bounces-7037-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B130393A15B
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 15:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CA01F22A76
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 13:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAD9153581;
	Tue, 23 Jul 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BJVuHA4R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CEA152E1D
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jul 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741403; cv=none; b=QMUb8ykbzWc+8PA+Ytbsuy67wUmQZdEFHPLqkPUgWh102eE27KNCTrgkgDn4SyJdVycHBH8KSQfVFQojgcFk1JLeOgCHVGElKofLNVixIszEzH6sgmxooJVrngCVCFFKx5Haq9GgzbAPtQgIbI89Gtin1C21FJlY53PMwG5wzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741403; c=relaxed/simple;
	bh=nAOfBO2Y2r3svkakgl+lTAOtJTZk9SFbG5lphbRVNRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6Alac5pVAaXMbPx9qMZgO3n84Nkxkrl/sFjxsqjRdCxU56ormYEFxWOuQTtX/2Fw9BkmzBqYL+Ids270vItQDAjEoXjdI/ad3OBaxb3L/8pgHDPhpteyMT2KwGTcbswHV4zU+9n71KjDljYvggMDKRKNLcBblqQawjBIJTHCjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=BJVuHA4R; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-816b627a7b6so192695739f.0
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jul 2024 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721741400; x=1722346200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLXpOJ5NKoFQFTZD98u7pTCjufqwrqSU5zSslcWK47s=;
        b=BJVuHA4Rea9vuyNPKgbyZXzvHsMHv1nb/0KK197rk5M06WSuN9acSl46a18crZDH39
         ScKa+Wv1mlr9jYRCOeem3Gqw0OhQ9yq/M2iQFShQOeHbtDBpj79fQKEnabSTZi+vo2bw
         8+a1kyEg4BQR3jmv1C+ysN0ehCSBj6Vv8JYxUeCmDXngJDryemII8zxEkCWD7YXYGRWf
         Rgsna4YpZWru2HqM9a1VOn3eBM/E2rknORTFMDyLBimOa8LEA5ZePy+B+mJQtpnqfU7k
         SkXEd5vkuo2lJFQTfXhXmYtEK5GMwQ6LHN6xR/qzTsl3SVBHZZiLeRJqlwm2oLbrEqzj
         pCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741400; x=1722346200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLXpOJ5NKoFQFTZD98u7pTCjufqwrqSU5zSslcWK47s=;
        b=QamDGbU1w0LZ6L8v+3w1mJKdYLG62rTyTxtSYgvIOviQgsX3XFtNCqnYgIGYRcHgXV
         ZCjaEuBtvkdEIWwPXt8yKd8DoJGFoSlCSbJQho6KDBVR9Kw2cIHb4eeu1JXs75pyE/0d
         RZQHUNCoSWArT+D5+k1ZAfnw2etdKQjcd9iVY99pLxdEM++MPJeBM2SAfuxuxlmNi15I
         zmWZsTM9AjzSjDak1BD5YCwiCWfjAbbX6JREf7DHKbWR3dfLv3lvtt0jwUuJ4hC7P9Wn
         uZJtakvSdzbVd3TFKEBGxXCVH5ckFq+vvkHHIbLeKT8fsQHo/f8ugUqrHGeK0Xer63/v
         kpDA==
X-Forwarded-Encrypted: i=1; AJvYcCWvx+4GylD1g6QC4OyZRGZ95RyNtswhz6pxPcY3vKjTeseOzAL1PO9QuwSFZ93p2k9Poy5mWW55vCokm1DAlsa9f2Y7tA48omC/xA==
X-Gm-Message-State: AOJu0Yw+YHv3CySo+99yGe4vCdqDVXRM8vtAD2cQ5oM+iqnDlBIBmnPF
	r/eqhh9yIxcuLLYNjWI3a0ZBrv48QbzkqhPZ6HqZmfnoJfID9nRJR3z6N+mruzg=
X-Google-Smtp-Source: AGHT+IF80eTqdhOJ79Y+uIGpgNKKtwlWUq1s4pL4fYqejLfcrt2vZMzY19zIDC9qjGAE1kLmyRI9aw==
X-Received: by 2002:a05:6602:2dd3:b0:804:9060:c0b8 with SMTP id ca18e2360f4ac-81b362aade3mr1199303039f.15.1721741400383;
        Tue, 23 Jul 2024 06:30:00 -0700 (PDT)
Received: from localhost ([138.199.100.237])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81bed28605esm197619739f.47.2024.07.23.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:30:00 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:29:57 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, arnd@arndb.de, xiaobo55x@gmail.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Anup Patel <anup@brainfault.org>, Charlie Jenkins <charlie@rivosinc.com>, 
	Baoquan He <bhe@redhat.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>, Zhao Ke <ke.zhao@shingroup.cn>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Chiu <andy.chiu@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Robert Richter <rrichter@amd.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 1/4] ACPI: RISCV: Add NUMA support based on SRAT and
 SLIT
Message-ID: <20240723-23811cc47f7863d12b6a78e8@orel>
References: <cover.1718268003.git.haibo1.xu@intel.com>
 <65dbad1fda08a32922c44886e4581e49b4a2fecc.1718268003.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65dbad1fda08a32922c44886e4581e49b4a2fecc.1718268003.git.haibo1.xu@intel.com>

On Thu, Jun 13, 2024 at 04:54:33PM GMT, Haibo Xu wrote:
> Add acpi_numa.c file to enable parse NUMA information from
> ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> memory nodes to proximity domain mapping, while SLIT table
> provide the distance metrics between proximity domains.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h |  15 +++-
>  arch/riscv/kernel/Makefile    |   1 +
>  arch/riscv/kernel/acpi.c      |   5 --
>  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c     |   4 +-
>  arch/riscv/kernel/smpboot.c   |   2 -
>  include/linux/acpi.h          |   6 ++
>  7 files changed, 154 insertions(+), 10 deletions(-)
>  create mode 100644 arch/riscv/kernel/acpi_numa.c
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 7dad0cf9d701..e0a1f84404f3 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  
>  void acpi_init_rintc_map(void);
>  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> -u32 get_acpi_id_for_cpu(int cpu);
> +static inline u32 get_acpi_id_for_cpu(int cpu)
> +{
> +	return acpi_cpu_get_madt_rintc(cpu)->uid;
> +}
> +
>  int acpi_get_riscv_isa(struct acpi_table_header *table,
>  		       unsigned int cpu, const char **isa);
>  
> -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
>  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
>  			     u32 *cboz_size, u32 *cbop_size);
>  #else
> @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
>  
>  #endif /* CONFIG_ACPI */
>  
> +#ifdef CONFIG_ACPI_NUMA
> +int acpi_numa_get_nid(unsigned int cpu);
> +void acpi_map_cpus_to_nodes(void);
> +#else
> +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> +static inline void acpi_map_cpus_to_nodes(void) { }
> +#endif /* CONFIG_ACPI_NUMA */
> +
>  #endif /*_ASM_ACPI_H*/
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 5b243d46f4b1..1e2afec141b5 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -110,3 +110,4 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
>  
>  obj-$(CONFIG_64BIT)		+= pi/
>  obj-$(CONFIG_ACPI)		+= acpi.o
> +obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index e619edc8b0cc..040bdbfea2b4 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
>  	return &cpu_madt_rintc[cpu];
>  }
>  
> -u32 get_acpi_id_for_cpu(int cpu)
> -{
> -	return acpi_cpu_get_madt_rintc(cpu)->uid;
> -}
> -
>  /*
>   * __acpi_map_table() will be called before paging_init(), so early_ioremap()
>   * or early_memremap() should be called here to for ACPI table mapping.
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> new file mode 100644
> index 000000000000..0231482d6946
> --- /dev/null
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI 6.6 based NUMA setup for RISCV
> + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> + *
> + * Copyright 2004 Andi Kleen, SuSE Labs.
> + * Copyright (C) 2013-2016, Linaro Ltd.
> + *		Author: Hanjun Guo <hanjun.guo@linaro.org>
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Reads the ACPI SRAT table to figure out what memory belongs to which CPUs.
> + *
> + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
> + * Assumes all memory regions belonging to a single proximity domain
> + * are in one chunk. Holes between them will be included in the node.
> + */
> +
> +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bitmap.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/memblock.h>
> +#include <linux/mmzone.h>
> +#include <linux/module.h>
> +#include <linux/topology.h>
> +
> +#include <asm/numa.h>
> +
> +static int acpi_early_node_map[NR_CPUS] __initdata = { NUMA_NO_NODE };

This only sets acpi_early_node_map[0] to NUMA_NO_NODE. Assuming we want
to ensure all of them are initialized to NUMA_NO_NODE, then we need

static int acpi_early_node_map[NR_CPUS] __initdata = { [0 ... NR_CPUS - 1] = NUMA_NO_NODE };

Thanks,
drew

