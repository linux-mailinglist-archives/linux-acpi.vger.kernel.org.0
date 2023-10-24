Return-Path: <linux-acpi+bounces-883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 468397D4FE7
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 952BEB20B10
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08233273D7
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E65CBE
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 12:07:09 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0F3111
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 05:07:07 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b413cc2789so154102b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 05:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149227; x=1698754027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAHGovCaUDV400ar4Dy5jPHX4+wYzlvwoCWXTsrxaWs=;
        b=jLrD1CE0AtxkcjiLKfpwsqZRkDepRDbvemlKlsGNgakC8S3RbcW9qRecEufI1U7fKZ
         ya38O96WiNJ41bczosLQTktOTD4uLgjBlD9utCntL1IFnYmuMlnjnTp0JOWDqUtZy4d5
         BJQ00GMdF8PuuUikzDnLkN7b4OYG+zs8HEcgeOG10ldqbdZQi3C8o1TCuqA96ge56I/r
         RQ8tO8hHY8lCGG2J97viNesHdwgE7Mri1/uq0mhGAiCCCQ8MIx9e5dn0Efq7Y4+RCDlf
         Mcs3s6pcYdrcXGgRXA2+6ztJuTUO8IPqU/dz5C5fmhTjnUSqXuCxkvz+hrz9v13xja6C
         ChgQ==
X-Gm-Message-State: AOJu0Ywl2TbaBSy//cyx7Ltekv59z4Uhqlbm8p1Xjn1iUPm41qggyQ0b
	y3oXjtGTrv2nxM4nkh0tqvXEEJJ/LHdL145dS4NXJCRY
X-Google-Smtp-Source: AGHT+IHXO+xLofRlyyP/aJbNp16pbaSharLAj/mupsjEAp3UhYFGS+OG76gkHW8oZ7/iU2DLj/o+8gp8Xt1VmcrDGr0=
X-Received: by 2002:a05:6808:2e8c:b0:3ad:aadd:6cbf with SMTP id
 gt12-20020a0568082e8c00b003adaadd6cbfmr13562256oib.0.1698149226861; Tue, 24
 Oct 2023 05:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1quv5D-00AeNJ-U8@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1quv5D-00AeNJ-U8@rmk-PC.armlinux.org.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 24 Oct 2023 14:06:55 +0200
Message-ID: <CAJZ5v0j+h9M4qhcdRW7_sOxbwdVqjyyrZWw14JsM1h1JoUL5+Q@mail.gmail.com>
Subject: Re: [PATCH] arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check
 into a helper
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:35=E2=80=AFPM Russell King <rmk+kernel@armlinux.o=
rg.uk> wrote:
>
> From: James Morse <james.morse@arm.com>
>
> ACPI, irqchip and the architecture code all inspect the MADT
> enabled bit for a GICC entry in the MADT.
>
> The addition of an 'online capable' bit means all these sites need
> updating.
>
> Move the current checks behind a helper to make future updates easier.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the generic ACPI changes in this patch, but it is knod of
ARM-specific, so I'd prefer ARM64 to pick it up (CC Sudeep).

> ---
> Changes since RFC v2:
>  * Remove unnecessary parens
>  * Moved earlier in series
>
> Suggestion by Jonathan Cameron that this can be part of a pre-cursor
> series. As it doesn't depend on anything else, sending separately so
> it can be merged into the aarch64 tree.
> ---
>  arch/arm64/kernel/smp.c       |  2 +-
>  drivers/acpi/processor_core.c |  2 +-
>  drivers/irqchip/irq-gic-v3.c  | 10 ++++------
>  include/linux/acpi.h          |  5 +++++
>  4 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 960b98b43506..8c8f55721786 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -520,7 +520,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_i=
nterrupt *processor)
>  {
>         u64 hwid =3D processor->arm_mpidr;
>
> -       if (!(processor->flags & ACPI_MADT_ENABLED)) {
> +       if (!acpi_gicc_is_usable(processor)) {
>                 pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n=
", hwid);
>                 return;
>         }
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.=
c
> index 7dd6dbaa98c3..b203cfe28550 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -90,7 +90,7 @@ static int map_gicc_mpidr(struct acpi_subtable_header *=
entry,
>         struct acpi_madt_generic_interrupt *gicc =3D
>             container_of(entry, struct acpi_madt_generic_interrupt, heade=
r);
>
> -       if (!(gicc->flags & ACPI_MADT_ENABLED))
> +       if (!acpi_gicc_is_usable(gicc))
>                 return -ENODEV;
>
>         /* device_declaration means Device object in DSDT, in the
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index f59ac9586b7b..d50d9414f471 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -2380,8 +2380,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_header=
s *header,
>         u32 size =3D reg =3D=3D GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64=
K * 2;
>         void __iomem *redist_base;
>
> -       /* GICC entry which has !ACPI_MADT_ENABLED is not unusable so ski=
p */
> -       if (!(gicc->flags & ACPI_MADT_ENABLED))
> +       if (!acpi_gicc_is_usable(gicc))
>                 return 0;
>
>         redist_base =3D ioremap(gicc->gicr_base_address, size);
> @@ -2431,7 +2430,7 @@ static int __init gic_acpi_match_gicc(union acpi_su=
btable_headers *header,
>          * If GICC is enabled and has valid gicr base address, then it me=
ans
>          * GICR base is presented via GICC
>          */
> -       if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address)=
 {
> +       if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
>                 acpi_data.enabled_rdists++;
>                 return 0;
>         }
> @@ -2440,7 +2439,7 @@ static int __init gic_acpi_match_gicc(union acpi_su=
btable_headers *header,
>          * It's perfectly valid firmware can pass disabled GICC entry, dr=
iver
>          * should not treat as errors, skip the entry instead of probe fa=
il.
>          */
> -       if (!(gicc->flags & ACPI_MADT_ENABLED))
> +       if (!acpi_gicc_is_usable(gicc))
>                 return 0;
>
>         return -ENODEV;
> @@ -2499,8 +2498,7 @@ static int __init gic_acpi_parse_virt_madt_gicc(uni=
on acpi_subtable_headers *hea
>         int maint_irq_mode;
>         static int first_madt =3D true;
>
> -       /* Skip unusable CPUs */
> -       if (!(gicc->flags & ACPI_MADT_ENABLED))
> +       if (!acpi_gicc_is_usable(gicc))
>                 return 0;
>
>         maint_irq_mode =3D (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index afd94c9b8b8a..ebfea7bf663d 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -256,6 +256,11 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
>  int acpi_parse_mcfg (struct acpi_table_header *header);
>  void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
>
> +static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrup=
t *gicc)
> +{
> +       return gicc->flags & ACPI_MADT_ENABLED;
> +}
> +
>  /* the following numa functions are architecture-dependent */
>  void acpi_numa_slit_init (struct acpi_table_slit *slit);
>
> --
> 2.30.2
>

