Return-Path: <linux-acpi+bounces-7039-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EED693A298
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 16:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFB4B24B57
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4315383B;
	Tue, 23 Jul 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg/aGMAI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E715252E;
	Tue, 23 Jul 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744495; cv=none; b=pZY6ZIy1EJ7LpC+JF67PZFnJaMFxuwBbvXOB9PHHeCYbLMxggsbJg5k71wFxa9YVkefaYLM/pMzHAprrahPv3hgS0g53VfXglHqSpUjUYZzhFaYQu6D41NW054b1mW7jhTDnSkOqiuJkfk6azbK5OPDDC5Pjm0etzEl5UtzJh2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744495; c=relaxed/simple;
	bh=/+vh5Izzq6t7XO0n7bUh6HgctsHMqpaChg3gDNKgH1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlmMQjR8AW8jrvC67uJBLgge2+qvmuK9I6a1M47sv31SZeyFtEMzr3hp7OFKQ9IXXWR9Q7zxfBT2gNTcNPF9XtyBiDKm70GpDbXdH5aMW5y3UQBQQqojGN3O889QGbbOEswJA63rf59j5hXXWzDPspKQft1gbAe/qfyqDcA4FJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg/aGMAI; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so4416802e87.1;
        Tue, 23 Jul 2024 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721744492; x=1722349292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYMdjIba5GVjSk5LLCgsucuwd1uTMo/SWZKsqPwbIS0=;
        b=cg/aGMAIpVhGmWeSuTzpomt2cPlobwDJH9VYJydNAPIll+hol7fbUflc/66SChgrUB
         UVmsBtRn0zpf9A5Cy85ALYDwMBJtN2DvKf80cF74pwptqDlYZkra54VWsxAQKSA6F75H
         kJZgxDRsJKfXqqf9c8VEV960QAaJ7SHO/INPVSBqFcQvdQZv5pl3wAQaXKpgVebaMDt2
         8bp/oJ4PpN8odS5TvO6eq22gdP85ilcRCBJXJ+T4uvuaXNluMsqm7DQoslW3PPImyNHZ
         xTMyLalIRcuRY61l46TsIYF6bnXWGnkWDoz7Uzak51FHfurYLzMbeCdQX3T9sTrhKdIO
         O7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721744492; x=1722349292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYMdjIba5GVjSk5LLCgsucuwd1uTMo/SWZKsqPwbIS0=;
        b=vDZx1HsrzkVP0L2TBeHfFLECIIsPwQTDfx5lpnQAFi7Gu54h/HROM5bomIID203And
         tlrTHI0/K71bkuMsFz/tRKYMjWnsatBv0T2zVhBNWhtmey78vAKdgm7KkLX0PjK0MLEB
         qE990z1XlPypOq7e81czEnAj+1C7enWBjY3CpOq9t0HNsh8EA4b7vwAYGnHsSQvog+ys
         MgdtCjtLuDiQ0EDSJvSK4sSpDoDAjI+Z9AZ+Om9hq5EhRxvxSkNkda7nqgOD9wH/Vf7F
         4ls8SLW6J3J/24qViKAH2kKF9VnOhORTZarZYbGwucNSXREL2NqyK9QCJLpg9ePvr1S8
         1www==
X-Forwarded-Encrypted: i=1; AJvYcCWsQmufzfDOyItzk3jHwJWrjescozz2r03uzSBTRQtfNbPA0xeGhmJ2HoixH1uDt4125w0dqZrKKf/sDKeKjewLprn2+aszBhPTfRVsIOtXIn5I0QsBz1JF66YF+ZtjjQEYrbC91bRZcw==
X-Gm-Message-State: AOJu0YwEY8Iq5+5D0Qe5ZhJt0R5/WNip6JwBMq1Sso8vlEJBX4XI1OeF
	KxP30l5E9vmhIcjpvBtVSKGFE4dQL1CXSoD962E8/zu3egR/mm87gnuDbsE34RgwTDBKZEkq911
	pfMaD3JoVlRzehUC6cOEBTSpJoho=
X-Google-Smtp-Source: AGHT+IHHK4zzI0FK6dtJOc4sOSTKvTpBc8BrSaSqFkRUk7Pli2OGk28Gtofg4RA96R38FMJpb/0BtPOqBp98J0CCXQw=
X-Received: by 2002:a05:6512:a86:b0:52e:969c:db83 with SMTP id
 2adb3069b0e04-52efb53b775mr6049905e87.17.1721744490858; Tue, 23 Jul 2024
 07:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718268003.git.haibo1.xu@intel.com> <65dbad1fda08a32922c44886e4581e49b4a2fecc.1718268003.git.haibo1.xu@intel.com>
 <20240723-23811cc47f7863d12b6a78e8@orel>
In-Reply-To: <20240723-23811cc47f7863d12b6a78e8@orel>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 23 Jul 2024 22:21:19 +0800
Message-ID: <CAJve8omO0DwQEO+KEjhJFn=uYNAyZNYsnQieETocRzwb0RTGiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Haibo Xu <haibo1.xu@intel.com>, sunilvl@ventanamicro.com, arnd@arndb.de, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Anup Patel <anup@brainfault.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Baoquan He <bhe@redhat.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Zong Li <zong.li@sifive.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Chen Jiahao <chenjiahao16@huawei.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, James Morse <james.morse@arm.com>, 
	Evan Green <evan@rivosinc.com>, Zhao Ke <ke.zhao@shingroup.cn>, 
	Thomas Gleixner <tglx@linutronix.de>, Andy Chiu <andy.chiu@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Alison Schofield <alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Robert Richter <rrichter@amd.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:30=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Jun 13, 2024 at 04:54:33PM GMT, Haibo Xu wrote:
> > Add acpi_numa.c file to enable parse NUMA information from
> > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > memory nodes to proximity domain mapping, while SLIT table
> > provide the distance metrics between proximity domains.
> >
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/acpi.h |  15 +++-
> >  arch/riscv/kernel/Makefile    |   1 +
> >  arch/riscv/kernel/acpi.c      |   5 --
> >  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/setup.c     |   4 +-
> >  arch/riscv/kernel/smpboot.c   |   2 -
> >  include/linux/acpi.h          |   6 ++
> >  7 files changed, 154 insertions(+), 10 deletions(-)
> >  create mode 100644 arch/riscv/kernel/acpi_numa.c
> >
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acp=
i.h
> > index 7dad0cf9d701..e0a1f84404f3 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int num=
, u32 slot) { }
> >
> >  void acpi_init_rintc_map(void);
> >  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > -u32 get_acpi_id_for_cpu(int cpu);
> > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > +{
> > +     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > +}
> > +
> >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> >                      unsigned int cpu, const char **isa);
> >
> > -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO=
_NODE; }
> >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbo=
m_size,
> >                            u32 *cboz_size, u32 *cbop_size);
> >  #else
> > @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struct ac=
pi_table_header *table,
> >
> >  #endif /* CONFIG_ACPI */
> >
> > +#ifdef CONFIG_ACPI_NUMA
> > +int acpi_numa_get_nid(unsigned int cpu);
> > +void acpi_map_cpus_to_nodes(void);
> > +#else
> > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO=
_NODE; }
> > +static inline void acpi_map_cpus_to_nodes(void) { }
> > +#endif /* CONFIG_ACPI_NUMA */
> > +
> >  #endif /*_ASM_ACPI_H*/
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index 5b243d46f4b1..1e2afec141b5 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -110,3 +110,4 @@ obj-$(CONFIG_COMPAT)              +=3D compat_vdso/
> >
> >  obj-$(CONFIG_64BIT)          +=3D pi/
> >  obj-$(CONFIG_ACPI)           +=3D acpi.o
> > +obj-$(CONFIG_ACPI_NUMA)      +=3D acpi_numa.o
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index e619edc8b0cc..040bdbfea2b4 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(in=
t cpu)
> >       return &cpu_madt_rintc[cpu];
> >  }
> >
> > -u32 get_acpi_id_for_cpu(int cpu)
> > -{
> > -     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > -}
> > -
> >  /*
> >   * __acpi_map_table() will be called before paging_init(), so early_io=
remap()
> >   * or early_memremap() should be called here to for ACPI table mapping=
.
> > diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_num=
a.c
> > new file mode 100644
> > index 000000000000..0231482d6946
> > --- /dev/null
> > +++ b/arch/riscv/kernel/acpi_numa.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ACPI 6.6 based NUMA setup for RISCV
> > + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> > + *
> > + * Copyright 2004 Andi Kleen, SuSE Labs.
> > + * Copyright (C) 2013-2016, Linaro Ltd.
> > + *           Author: Hanjun Guo <hanjun.guo@linaro.org>
> > + * Copyright (C) 2024 Intel Corporation.
> > + *
> > + * Reads the ACPI SRAT table to figure out what memory belongs to whic=
h CPUs.
> > + *
> > + * Called from acpi_numa_init while reading the SRAT and SLIT tables.
> > + * Assumes all memory regions belonging to a single proximity domain
> > + * are in one chunk. Holes between them will be included in the node.
> > + */
> > +
> > +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/bitmap.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/memblock.h>
> > +#include <linux/mmzone.h>
> > +#include <linux/module.h>
> > +#include <linux/topology.h>
> > +
> > +#include <asm/numa.h>
> > +
> > +static int acpi_early_node_map[NR_CPUS] __initdata =3D { NUMA_NO_NODE =
};
>
> This only sets acpi_early_node_map[0] to NUMA_NO_NODE. Assuming we want
> to ensure all of them are initialized to NUMA_NO_NODE, then we need
>
> static int acpi_early_node_map[NR_CPUS] __initdata =3D { [0 ... NR_CPUS -=
 1] =3D NUMA_NO_NODE };
>

Good catch! Thanks!

@Palmer Dabbelt
I noticed this series had been merged to riscv/linux.git (for-next),
could you help include the above change from Drew?
Or shall I send out a new series?

Regards,
Haibo

> Thanks,
> drew

