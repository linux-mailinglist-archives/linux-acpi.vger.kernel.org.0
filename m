Return-Path: <linux-acpi+bounces-7041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB8893A348
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 16:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE80B1F23334
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jul 2024 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8426156C65;
	Tue, 23 Jul 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crICik7Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD0155C90;
	Tue, 23 Jul 2024 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746455; cv=none; b=Gv2E9kZf5nqL7K8A6PtKCHQ1bLCV8sd2y7PKLOIp07QuCs8IDLTmUg5KdTqOz6ar5H41fD2KWcjSG3a9uCCcZc2yFVZxWwxUYtCGOfWlX6uVvCkUBJm/8AHBHS9KuJByxiskP/XoJJnAuL9HfFjwz1O1ukMBaW63nFNKS/m0EXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746455; c=relaxed/simple;
	bh=XYVGWXsVxmc2JPUk7qSLKkR2pfoh0lZKvQpisvT1fnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3CDxY7YUkoxbEhoyFRYHMruZPTHHWT93R3ruMp+aZ63TuNvZoFt/6yR2B54QlY5q0NqJVpvuedEtHORatIFPFYtvIKH8lzpkQ7YixC7LTBsS+LW0guAXdrMn76CAYlgNEPRml3UBvDsJ930LUobAzrd5SqKxHBV7DXLrGr/+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crICik7Z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efd855adbso4149481e87.2;
        Tue, 23 Jul 2024 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721746452; x=1722351252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgTGl7/iLwA8lXOdx8/6BLZrlAts/9/eNlLEa+P/MyA=;
        b=crICik7ZmTdvwdAR6GFTod7nPvlIK0lR1IdQz3tFy9zQirVFTdJd/TeTxOr9zPRSPI
         I9+TWpzOH/naNz1Lv8WdPKx3ePGh3f4e3m1tGVh4VL4DP02kF3rOykQPHctFALDoSAcT
         BrG3piQs+7dvI+S4gFiCbHfV1mi/tuwxVRKbytHZrVOiJaqgjzfCy2WVDQMkDw2aSMLt
         h7+uycZln2cvW+NumaIDVbr+g9Jak1JK2bRxqMrEhq8HG/eKXJUZr/M4AEmUYc2Q5m6e
         7zW2cCO2nceO5CCz/mDtllktpxgzyjL94YFQWJWpYQZcjqWuIpWp7Z6Olchyf69ROT2D
         I7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746452; x=1722351252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgTGl7/iLwA8lXOdx8/6BLZrlAts/9/eNlLEa+P/MyA=;
        b=VOJM0pg9rgof7Ct4EETUtsqqnKHk6vkK8Xs/NLlAt3byJL3kk/OXKzxhxk43K2uixF
         XRQuilq7DD8tj6WAtvxiXIEwAkqA4uWRvOgGeo6QHFD8eFHbfy6v/frEylbQsi1qucV7
         tM70p8M0qgkuah5drDjyNXuIZX4XqIuZptrujdgQ9LQ3upOahADPWrBwRIObmXXmM66+
         nRverWkatLoUiBJL30O/vK0BDxAICTFjztKbpWpKAVT4D1NpSKXa+lmtArFTP77eUYqg
         tC1FnzweDAL2sWv3gYgRIOjcUX1WP+jjkVymUCr4IxpF2JR+Oo8jyGOeO+j20F/k2Qkp
         uUDA==
X-Forwarded-Encrypted: i=1; AJvYcCVnkF4PlvnoeUesXqlC28cChZBuUdxFo3tZ9KStDszIBPJv66r2gugmg8IbGqk7KqAVkeXRPyUGo5z3dzL76+8N/MXrpKIV0qEN/43PG99KCGgSqsO7PdN4oSB5JOjw3ReexFv2Q0nYsA==
X-Gm-Message-State: AOJu0YwrgZ4uTWIweQYzICEG4pIr97Wju3HYbhGmBCUoOTqEVNc8bUGP
	kU9qg203nTGRzhRv/mMhOJXsdQNLTyMX6ZVS1zsb/5fv2ctAHMjTrip4fCbXMpvabWMYpM93cbH
	xVcII8U3A4F/+sTeCVD9CVtyMHY4=
X-Google-Smtp-Source: AGHT+IFYMOiLDzvDOKK6+vBAVn/8k5uVYxbcIexSwHx+d+SAZWWHPZMdYHFed1xA+jHc+tweeg7UVxoQuNuIAfPIUzM=
X-Received: by 2002:a05:6512:33d3:b0:52c:d904:d26e with SMTP id
 2adb3069b0e04-52fc40446d9mr2549501e87.21.1721746451484; Tue, 23 Jul 2024
 07:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718268003.git.haibo1.xu@intel.com> <65dbad1fda08a32922c44886e4581e49b4a2fecc.1718268003.git.haibo1.xu@intel.com>
 <20240723-23811cc47f7863d12b6a78e8@orel> <CAJve8omO0DwQEO+KEjhJFn=uYNAyZNYsnQieETocRzwb0RTGiA@mail.gmail.com>
 <CAK9=C2Xt2JPaUOTfN9CyyeVQiS9KKYWaH4RUTwYQ6UGjq3VnHQ@mail.gmail.com>
In-Reply-To: <CAK9=C2Xt2JPaUOTfN9CyyeVQiS9KKYWaH4RUTwYQ6UGjq3VnHQ@mail.gmail.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 23 Jul 2024 22:53:59 +0800
Message-ID: <CAJve8o=MK1huJ7x7NFhsmT2YiwtrDuKaVMnjK=bb3HhZBJprOw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] ACPI: RISCV: Add NUMA support based on SRAT and SLIT
To: Anup Patel <apatel@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Haibo Xu <haibo1.xu@intel.com>, 
	sunilvl@ventanamicro.com, arnd@arndb.de, 
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

On Tue, Jul 23, 2024 at 10:50=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
>
> On Tue, Jul 23, 2024 at 7:51=E2=80=AFPM Haibo Xu <xiaobo55x@gmail.com> wr=
ote:
> >
> > On Tue, Jul 23, 2024 at 9:30=E2=80=AFPM Andrew Jones <ajones@ventanamic=
ro.com> wrote:
> > >
> > > On Thu, Jun 13, 2024 at 04:54:33PM GMT, Haibo Xu wrote:
> > > > Add acpi_numa.c file to enable parse NUMA information from
> > > > ACPI SRAT and SLIT tables. SRAT table provide CPUs(Hart) and
> > > > memory nodes to proximity domain mapping, while SLIT table
> > > > provide the distance metrics between proximity domains.
> > > >
> > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > ---
> > > >  arch/riscv/include/asm/acpi.h |  15 +++-
> > > >  arch/riscv/kernel/Makefile    |   1 +
> > > >  arch/riscv/kernel/acpi.c      |   5 --
> > > >  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++=
++++
> > > >  arch/riscv/kernel/setup.c     |   4 +-
> > > >  arch/riscv/kernel/smpboot.c   |   2 -
> > > >  include/linux/acpi.h          |   6 ++
> > > >  7 files changed, 154 insertions(+), 10 deletions(-)
> > > >  create mode 100644 arch/riscv/kernel/acpi_numa.c
> > > >
> > > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm=
/acpi.h
> > > > index 7dad0cf9d701..e0a1f84404f3 100644
> > > > --- a/arch/riscv/include/asm/acpi.h
> > > > +++ b/arch/riscv/include/asm/acpi.h
> > > > @@ -61,11 +61,14 @@ static inline void arch_fix_phys_package_id(int=
 num, u32 slot) { }
> > > >
> > > >  void acpi_init_rintc_map(void);
> > > >  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> > > > -u32 get_acpi_id_for_cpu(int cpu);
> > > > +static inline u32 get_acpi_id_for_cpu(int cpu)
> > > > +{
> > > > +     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > > > +}
> > > > +
> > > >  int acpi_get_riscv_isa(struct acpi_table_header *table,
> > > >                      unsigned int cpu, const char **isa);
> > > >
> > > > -static inline int acpi_numa_get_nid(unsigned int cpu) { return NUM=
A_NO_NODE; }
> > > >  void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 =
*cbom_size,
> > > >                            u32 *cboz_size, u32 *cbop_size);
> > > >  #else
> > > > @@ -87,4 +90,12 @@ static inline void acpi_get_cbo_block_size(struc=
t acpi_table_header *table,
> > > >
> > > >  #endif /* CONFIG_ACPI */
> > > >
> > > > +#ifdef CONFIG_ACPI_NUMA
> > > > +int acpi_numa_get_nid(unsigned int cpu);
> > > > +void acpi_map_cpus_to_nodes(void);
> > > > +#else
> > > > +static inline int acpi_numa_get_nid(unsigned int cpu) { return NUM=
A_NO_NODE; }
> > > > +static inline void acpi_map_cpus_to_nodes(void) { }
> > > > +#endif /* CONFIG_ACPI_NUMA */
> > > > +
> > > >  #endif /*_ASM_ACPI_H*/
> > > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefil=
e
> > > > index 5b243d46f4b1..1e2afec141b5 100644
> > > > --- a/arch/riscv/kernel/Makefile
> > > > +++ b/arch/riscv/kernel/Makefile
> > > > @@ -110,3 +110,4 @@ obj-$(CONFIG_COMPAT)              +=3D compat_v=
dso/
> > > >
> > > >  obj-$(CONFIG_64BIT)          +=3D pi/
> > > >  obj-$(CONFIG_ACPI)           +=3D acpi.o
> > > > +obj-$(CONFIG_ACPI_NUMA)      +=3D acpi_numa.o
> > > > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > > index e619edc8b0cc..040bdbfea2b4 100644
> > > > --- a/arch/riscv/kernel/acpi.c
> > > > +++ b/arch/riscv/kernel/acpi.c
> > > > @@ -191,11 +191,6 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rint=
c(int cpu)
> > > >       return &cpu_madt_rintc[cpu];
> > > >  }
> > > >
> > > > -u32 get_acpi_id_for_cpu(int cpu)
> > > > -{
> > > > -     return acpi_cpu_get_madt_rintc(cpu)->uid;
> > > > -}
> > > > -
> > > >  /*
> > > >   * __acpi_map_table() will be called before paging_init(), so earl=
y_ioremap()
> > > >   * or early_memremap() should be called here to for ACPI table map=
ping.
> > > > diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi=
_numa.c
> > > > new file mode 100644
> > > > index 000000000000..0231482d6946
> > > > --- /dev/null
> > > > +++ b/arch/riscv/kernel/acpi_numa.c
> > > > @@ -0,0 +1,131 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * ACPI 6.6 based NUMA setup for RISCV
> > > > + * Lots of code was borrowed from arch/arm64/kernel/acpi_numa.c
> > > > + *
> > > > + * Copyright 2004 Andi Kleen, SuSE Labs.
> > > > + * Copyright (C) 2013-2016, Linaro Ltd.
> > > > + *           Author: Hanjun Guo <hanjun.guo@linaro.org>
> > > > + * Copyright (C) 2024 Intel Corporation.
> > > > + *
> > > > + * Reads the ACPI SRAT table to figure out what memory belongs to =
which CPUs.
> > > > + *
> > > > + * Called from acpi_numa_init while reading the SRAT and SLIT tabl=
es.
> > > > + * Assumes all memory regions belonging to a single proximity doma=
in
> > > > + * are in one chunk. Holes between them will be included in the no=
de.
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) "ACPI: NUMA: " fmt
> > > > +
> > > > +#include <linux/acpi.h>
> > > > +#include <linux/bitmap.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/mm.h>
> > > > +#include <linux/memblock.h>
> > > > +#include <linux/mmzone.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/topology.h>
> > > > +
> > > > +#include <asm/numa.h>
> > > > +
> > > > +static int acpi_early_node_map[NR_CPUS] __initdata =3D { NUMA_NO_N=
ODE };
> > >
> > > This only sets acpi_early_node_map[0] to NUMA_NO_NODE. Assuming we wa=
nt
> > > to ensure all of them are initialized to NUMA_NO_NODE, then we need
> > >
> > > static int acpi_early_node_map[NR_CPUS] __initdata =3D { [0 ... NR_CP=
US - 1] =3D NUMA_NO_NODE };
> > >
> >
> > Good catch! Thanks!
> >
> > @Palmer Dabbelt
> > I noticed this series had been merged to riscv/linux.git (for-next),
> > could you help include the above change from Drew?
> > Or shall I send out a new series?
>
> Since it's already in for-next, I suggest having a Fixes
> patch and add that to for-next because for-next is supposed
> to have a stable commit history.
>

Ok, I will send out the fix soon! Thanks!

> Regards,
> Anup

