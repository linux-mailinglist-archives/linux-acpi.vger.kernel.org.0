Return-Path: <linux-acpi+bounces-15176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667EAB06C98
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 06:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87557189E3DF
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 04:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F056273807;
	Wed, 16 Jul 2025 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="OvP4bFzi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C302940D
	for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752639580; cv=none; b=JCS9hNQSpyw/Tp1C7GgLrUIST9hOkkOvLY/40e/mkDCWjTJjEY5N5M1IldqFLyKwPUHbqyjyt/ihfM1FY3860rsTIQl28Qcx7/PFn1/Ylr+fJzi62TER0zLe6exFJbmfabDWUEezAs0ZalBIMeYJHVun5q8KlboOd+hSmljzMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752639580; c=relaxed/simple;
	bh=ggBvwrNmOG0tfhTRKkF3waESHhkY055jARtdJCmeAH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftjlN5rQMLr8690CdOtzowpVSQig/i+HxgvCiuOoF7V/6lLg+QHyXJbaFC1MZ1oUo1Zo6QOi/SO578lzRwuV8ZdAtKNhweSOotvwX0OpR2wjuJejTPv5l0s1hlvFWtXvqdYKUI8AoVD+0jhENaF95LbmLlSfYTGUvtqPiaJ4cHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=OvP4bFzi; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86d0168616aso493735739f.1
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jul 2025 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752639577; x=1753244377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRjpuxjkB9pRMP490bb1PdCyYw7ocE76yoCeQDXQdMc=;
        b=OvP4bFziBzHSWMz+B9dtJKk9t5zhAWZOOH1/wuUhpqHXEnLCC0P2/MtgZ4/aJIrH/Q
         k3NTS6udt6ek6CUnsPEx9w7i6BKSY+Kl91wj3E06fyg3lrfVe+gqi7pNg4/Xz3qz9TqO
         4BspVYPk897gEeRjCbVZP4xlNd0GQhjU0EU3ZXIzdocL70BERU5lzx7arBNAhrAlVFlz
         KgmsV7LUMSQphOG+apeYc0AUpsRwJ2dNq7zdnNaGXAuTzcs5pYTXGa/fR9wmFG+FYnKS
         PjqPiCVnvB6mTO6/JIA9ANQPWpd5X/2IxoLPxALDiFRsAzWEPuZ3QkKx3VkFscgb0MfK
         iHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752639577; x=1753244377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRjpuxjkB9pRMP490bb1PdCyYw7ocE76yoCeQDXQdMc=;
        b=UwPI2EDXxZqLKclGZNDBKAxg2guZ7mvrV+iNUzW2bmLr8pITxd7IS/knjLBahYaH3J
         sNDqKnuSq0h69YyAr4tALpHS9DHNhQ1Bnu/XZoo6ZusrCGkWa5XOijKNeXtP9YoVF4MU
         FcvdLq9cx2IdzsRio6txvtxWZSS4YGyIwBycBsRyezN0HWrMW8w+Jyl2Iii4XjtPDeP5
         JlLf+2Z0b158dWkpjDScN9mU5djhZMyI+CW5oVjKNOm2hUcewPimcsb2VozsQOV5bIY8
         URx9exHJz5tOGKpD50TCZU5WPGraIkMYrBGkoEf2XLyyQ6G5liTu5KBwZujOO5YY4OEA
         r5ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwdXmaGz4g2kiiC6hBZJM6rYpn2+MsPV7pVTiItYuFGuaoabrmg70Yh1+2K6JjvJXiY/W4ZxKQgSiU@vger.kernel.org
X-Gm-Message-State: AOJu0YzzzLNv2Cc69RFmXhoa8rFk07FshpKYT5mVrnFqEqmNJXYfMh86
	JF0m2ao6qSgRpt32qimYRzNXSgunOvfp1lLySccJZ0hpLPmAdf0iKXiWO0ywYwxcOmmyRJUADc/
	cbuZfLjLc9B658t4ULKYEkAb9eciNdfZ0brqT2BrR9w==
X-Gm-Gg: ASbGncv/fki4YAZLgJ/WclcRJUEteQVYO1ubf1wRedMIRNIaDoQ9BrDSxsytdpWzx9g
	iaC79Qk0TqZz9NnwitRtF3lWcpW553mnvq4LrLegkYapm+7wdaapgnepAbTytIl1BhBNrZNkh8i
	Png1JxnuMQ0S9Dd0+gYWZKv+WMcD9UJzELJrTrib6ev8VcjMR0amLKCusXpxjg1Jc8m6p7du2Td
	dkmSg==
X-Google-Smtp-Source: AGHT+IGnZ6eZiNTQftIIKZge+mZ/ZXA6YuLTB6t1uSw7BxDTRYAoqISlg4x+sRksezcbc9Q9fRO7up+bvKcVvFN/EEI=
X-Received: by 2002:a05:6602:2c8f:b0:879:c609:f5a1 with SMTP id
 ca18e2360f4ac-879c609f634mr28537639f.12.1752639576566; Tue, 15 Jul 2025
 21:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com> <20250710085657.2844330-2-sunilvl@ventanamicro.com>
In-Reply-To: <20250710085657.2844330-2-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 16 Jul 2025 09:49:25 +0530
X-Gm-Features: Ac12FXxUGmEgY3S32H7u0RUela1sTcCvJf4NgDCL-QtI39z61M5lXBhqxYJbFd0
Message-ID: <CAAhSdy00i5c-hmd8+MP=tDBjoPpHtjMD0_CYJTCjvTR6tGvd2A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ACPI: RISC-V: Add support for RIMT
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:28=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> RISC-V IO Mapping Table (RIMT) is a static ACPI table to communicate
> IOMMU information to the OS. The spec is available at [1].
>
> The changes at high level are,
>         a) Initialize data structures required for IOMMU/device
>            configuration using the data from RIMT. Provide APIs required
>            for device configuration.
>         b) Provide an API for IOMMU drivers to register the
>            fwnode with RIMT data structures. This API will create a
>            fwnode for PCIe IOMMU.
>
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  MAINTAINERS                 |   1 +
>  arch/riscv/Kconfig          |   1 +
>  drivers/acpi/Kconfig        |   4 +
>  drivers/acpi/riscv/Kconfig  |   7 +
>  drivers/acpi/riscv/Makefile |   1 +
>  drivers/acpi/riscv/init.c   |   2 +
>  drivers/acpi/riscv/init.h   |   1 +
>  drivers/acpi/riscv/rimt.c   | 520 ++++++++++++++++++++++++++++++++++++
>  include/linux/acpi_rimt.h   |  28 ++
>  9 files changed, 565 insertions(+)
>  create mode 100644 drivers/acpi/riscv/Kconfig
>  create mode 100644 drivers/acpi/riscv/rimt.c
>  create mode 100644 include/linux/acpi_rimt.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fad6cb025a19..21125f7c0d0a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -345,6 +345,7 @@ L:  linux-acpi@vger.kernel.org
>  L:     linux-riscv@lists.infradead.org
>  S:     Maintained
>  F:     drivers/acpi/riscv/
> +F:     include/linux/acpi_rimt.h
>
>  ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
>  M:     Sudeep Holla <sudeep.holla@arm.com>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d71ea0f4466f..67bbf3b7302d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,7 @@ config RISCV
>         select ACPI_MCFG if (ACPI && PCI)
>         select ACPI_PPTT if ACPI
>         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +       select ACPI_RIMT if ACPI
>         select ACPI_SPCR_TABLE if ACPI
>         select ARCH_DMA_DEFAULT_COHERENT
>         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATIO=
N
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7bc40c2735ac..4381803c308c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -546,6 +546,10 @@ if ARM64
>  source "drivers/acpi/arm64/Kconfig"
>  endif
>
> +if RISCV
> +source "drivers/acpi/riscv/Kconfig"
> +endif
> +
>  config ACPI_PPTT
>         bool
>
> diff --git a/drivers/acpi/riscv/Kconfig b/drivers/acpi/riscv/Kconfig
> new file mode 100644
> index 000000000000..046296a18d00
> --- /dev/null
> +++ b/drivers/acpi/riscv/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# ACPI Configuration for RISC-V
> +#
> +
> +config ACPI_RIMT
> +       bool
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index a96fdf1e2cb8..1284a076fa88 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -2,3 +2,4 @@
>  obj-y                                  +=3D rhct.o init.o irq.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)      +=3D cpuidle.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)            +=3D cppc.o
> +obj-$(CONFIG_ACPI_RIMT)                        +=3D rimt.o
> diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
> index 673e4d5dd752..7c00f7995e86 100644
> --- a/drivers/acpi/riscv/init.c
> +++ b/drivers/acpi/riscv/init.c
> @@ -10,4 +10,6 @@
>  void __init acpi_arch_init(void)
>  {
>         riscv_acpi_init_gsi_mapping();
> +       if (IS_ENABLED(CONFIG_ACPI_RIMT))
> +               riscv_acpi_rimt_init();
>  }
> diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
> index 0b9a07e4031f..1680aa2aaf23 100644
> --- a/drivers/acpi/riscv/init.h
> +++ b/drivers/acpi/riscv/init.h
> @@ -2,3 +2,4 @@
>  #include <linux/init.h>
>
>  void __init riscv_acpi_init_gsi_mapping(void);
> +void __init riscv_acpi_rimt_init(void);
> diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
> new file mode 100644
> index 000000000000..0cb486b19470
> --- /dev/null
> +++ b/drivers/acpi/riscv/rimt.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024-2025, Ventana Micro Systems Inc
> + *     Author: Sunil V L <sunilvl@ventanamicro.com>
> + *
> + */
> +
> +#define pr_fmt(fmt)    "ACPI: RIMT: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_rimt.h>
> +#include <linux/iommu.h>
> +#include <linux/list.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include "init.h"
> +
> +struct rimt_fwnode {
> +       struct list_head list;
> +       struct acpi_rimt_node *rimt_node;
> +       struct fwnode_handle *fwnode;
> +};
> +
> +static LIST_HEAD(rimt_fwnode_list);
> +static DEFINE_SPINLOCK(rimt_fwnode_lock);
> +
> +#define RIMT_TYPE_MASK(type)   (1 << (type))

Can we not use BIT() here ?

> +#define RIMT_IOMMU_TYPE                BIT(0)
> +
> +/* Root pointer to the mapped RIMT table */
> +static struct acpi_table_header *rimt_table;
> +
> +/**
> + * rimt_set_fwnode() - Create rimt_fwnode and use it to register
> + *                    iommu data in the rimt_fwnode_list
> + *
> + * @rimt_node: RIMT table node associated with the IOMMU
> + * @fwnode: fwnode associated with the RIMT node
> + *
> + * Returns: 0 on success
> + *          <0 on failure
> + */
> +static int rimt_set_fwnode(struct acpi_rimt_node *rimt_node,
> +                          struct fwnode_handle *fwnode)
> +{
> +       struct rimt_fwnode *np;
> +
> +       np =3D kzalloc(sizeof(*np), GFP_ATOMIC);
> +
> +       if (WARN_ON(!np))
> +               return -ENOMEM;
> +
> +       INIT_LIST_HEAD(&np->list);
> +       np->rimt_node =3D rimt_node;
> +       np->fwnode =3D fwnode;
> +
> +       spin_lock(&rimt_fwnode_lock);
> +       list_add_tail(&np->list, &rimt_fwnode_list);
> +       spin_unlock(&rimt_fwnode_lock);
> +
> +       return 0;
> +}
> +
> +/**
> + * rimt_get_fwnode() - Retrieve fwnode associated with an RIMT node
> + *
> + * @node: RIMT table node to be looked-up
> + *
> + * Returns: fwnode_handle pointer on success, NULL on failure
> + */
> +static struct fwnode_handle *rimt_get_fwnode(struct acpi_rimt_node *node=
)
> +{
> +       struct rimt_fwnode *curr;
> +       struct fwnode_handle *fwnode =3D NULL;

Inverted pyramid declaration of local variable here and everywhere else bel=
ow.

> +
> +       spin_lock(&rimt_fwnode_lock);
> +       list_for_each_entry(curr, &rimt_fwnode_list, list) {
> +               if (curr->rimt_node =3D=3D node) {
> +                       fwnode =3D curr->fwnode;
> +                       break;
> +               }
> +       }
> +       spin_unlock(&rimt_fwnode_lock);
> +
> +       return fwnode;
> +}
> +
> +static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
> +                                           void *context)
> +{
> +       struct device *dev =3D context;
> +       acpi_status status =3D AE_NOT_FOUND;
> +
> +       if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_IOMMU) {
> +               struct acpi_rimt_iommu *iommu_node =3D (struct acpi_rimt_=
iommu *)&node->node_data;
> +
> +               if (dev_is_pci(dev)) {
> +                       struct pci_dev *pdev;
> +                       u16 bdf;
> +
> +                       pdev =3D to_pci_dev(dev);
> +                       bdf =3D PCI_DEVID(pdev->bus->number, pdev->devfn)=
;
> +                       if ((pci_domain_nr(pdev->bus) =3D=3D iommu_node->=
pcie_segment_number) &&
> +                           bdf =3D=3D iommu_node->pcie_bdf) {
> +                               status =3D AE_OK;
> +                       } else {
> +                               status =3D AE_NOT_FOUND;
> +                       }
> +               } else {
> +                       struct platform_device *pdev =3D to_platform_devi=
ce(dev);
> +                       struct resource *res;
> +
> +                       res =3D platform_get_resource(pdev, IORESOURCE_ME=
M, 0);
> +                       if (res && res->start =3D=3D iommu_node->base_add=
ress)
> +                               status =3D AE_OK;
> +                       else
> +                               status =3D AE_NOT_FOUND;
> +               }
> +       } else if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLE=
X) {
> +               struct acpi_rimt_pcie_rc *pci_rc;
> +               struct pci_bus *bus;
> +
> +               bus =3D to_pci_bus(dev);
> +               pci_rc =3D (struct acpi_rimt_pcie_rc *)node->node_data;
> +
> +               /*
> +                * It is assumed that PCI segment numbers maps one-to-one
> +                * with root complexes. Each segment number can represent=
 only
> +                * one root complex.
> +                */
> +               status =3D pci_rc->pcie_segment_number =3D=3D pci_domain_=
nr(bus) ?
> +                                                       AE_OK : AE_NOT_FO=
UND;
> +       } else if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
> +               struct acpi_buffer buf =3D { ACPI_ALLOCATE_BUFFER, NULL }=
;
> +               struct acpi_device *adev;
> +               struct acpi_rimt_platform_device *ncomp;
> +               struct device *plat_dev =3D dev;
> +
> +               /*
> +                * Walk the device tree to find a device with an
> +                * ACPI companion; there is no point in scanning
> +                * RIMT for a device matching a platform device if
> +                * the device does not have an ACPI companion to
> +                * start with.
> +                */
> +               do {
> +                       adev =3D ACPI_COMPANION(plat_dev);
> +                       if (adev)
> +                               break;
> +
> +                       plat_dev =3D plat_dev->parent;
> +               } while (plat_dev);
> +
> +               if (!adev)
> +                       return status;
> +
> +               status =3D acpi_get_name(adev->handle, ACPI_FULL_PATHNAME=
, &buf);
> +               if (ACPI_FAILURE(status)) {
> +                       dev_warn(plat_dev, "Can't get device full path na=
me\n");
> +                       return status;
> +               }
> +
> +               ncomp =3D (struct acpi_rimt_platform_device *)node->node_=
data;
> +               status =3D !strcmp(ncomp->device_name, buf.pointer) ?
> +                                                       AE_OK : AE_NOT_FO=
UND;
> +               acpi_os_free(buf.pointer);
> +       }
> +
> +       return status;
> +}
> +
> +static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type ty=
pe,
> +                                            void *context)
> +{
> +       struct acpi_rimt_node *rimt_node, *rimt_end;
> +       struct acpi_table_rimt *rimt;
> +       int i;
> +
> +       if (!rimt_table)
> +               return NULL;
> +
> +       /* Get the first RIMT node */
> +       rimt =3D (struct acpi_table_rimt *)rimt_table;
> +       rimt_node =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
> +                                rimt->node_offset);
> +       rimt_end =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
> +                               rimt_table->length);
> +
> +       for (i =3D 0; i < rimt->num_nodes; i++) {
> +               if (WARN_TAINT(rimt_node >=3D rimt_end, TAINT_FIRMWARE_WO=
RKAROUND,
> +                              "RIMT node pointer overflows, bad table!\n=
"))
> +                       return NULL;
> +
> +               if (rimt_node->type =3D=3D type &&
> +                   ACPI_SUCCESS(rimt_match_node_callback(rimt_node, cont=
ext)))
> +                       return rimt_node;
> +
> +               rimt_node =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_no=
de,
> +                                        rimt_node->length);
> +       }
> +
> +       return NULL;
> +}
> +
> +static bool rimt_pcie_rc_supports_ats(struct acpi_rimt_node *node)
> +{
> +       struct acpi_rimt_pcie_rc *pci_rc;
> +
> +       pci_rc =3D (struct acpi_rimt_pcie_rc *)node->node_data;
> +       return pci_rc->flags & ACPI_RIMT_PCIE_ATS_SUPPORTED;
> +}
> +
> +static int rimt_iommu_xlate(struct device *dev, struct acpi_rimt_node *n=
ode, u32 deviceid)
> +{
> +       struct fwnode_handle *rimt_fwnode;
> +
> +       if (!node)
> +               return -ENODEV;
> +
> +       rimt_fwnode =3D rimt_get_fwnode(node);
> +
> +       /*
> +        * The IOMMU drivers may not be probed yet.
> +        * Defer the IOMMU configuration
> +        */
> +       if (!rimt_fwnode)
> +               return -EPROBE_DEFER;
> +
> +       return acpi_iommu_fwspec_init(dev, deviceid, rimt_fwnode);
> +}
> +
> +struct rimt_pci_alias_info {
> +       struct device *dev;
> +       struct acpi_rimt_node *node;
> +       const struct iommu_ops *ops;
> +};
> +
> +static int rimt_id_map(struct acpi_rimt_id_mapping *map, u8 type, u32 ri=
d_in, u32 *rid_out)
> +{
> +       if (rid_in < map->source_id_base ||
> +           (rid_in > map->source_id_base + map->num_ids))
> +               return -ENXIO;
> +
> +       *rid_out =3D map->dest_id_base + (rid_in - map->source_id_base);
> +       return 0;
> +}
> +
> +static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *no=
de,
> +                                              u32 *id_out, int index)
> +{
> +       struct acpi_rimt_platform_device *plat_node;
> +       struct acpi_rimt_pcie_rc *pci_node;
> +       u32 id_mapping_offset, num_id_mapping;
> +       struct acpi_rimt_id_mapping *map;
> +       struct acpi_rimt_node *parent;
> +
> +       if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> +               pci_node =3D (struct acpi_rimt_pcie_rc *)&node->node_data=
;
> +               id_mapping_offset =3D pci_node->id_mapping_offset;
> +               num_id_mapping =3D pci_node->num_id_mappings;
> +       } else if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
> +               plat_node =3D (struct acpi_rimt_platform_device *)&node->=
node_data;
> +               id_mapping_offset =3D plat_node->id_mapping_offset;
> +               num_id_mapping =3D plat_node->num_id_mappings;
> +       } else {
> +               return NULL;
> +       }
> +
> +       if (!id_mapping_offset || !num_id_mapping || index >=3D num_id_ma=
pping)
> +               return NULL;
> +
> +       map =3D ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
> +                          id_mapping_offset + index * sizeof(*map));
> +
> +       /* Firmware bug! */
> +       if (!map->dest_offset) {
> +               pr_err(FW_BUG "[node %p type %d] ID map has NULL parent r=
eference\n",
> +                      node, node->type);
> +               return NULL;
> +       }
> +
> +       parent =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->d=
est_offset);
> +
> +       if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
> +           node->type =3D=3D ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
> +               *id_out =3D map->dest_offset;
> +               return parent;
> +       }
> +
> +       return NULL;
> +}
> +
> +static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *no=
de,
> +                                              u32 id_in, u32 *id_out,
> +                                              u8 type_mask)
> +{
> +       struct acpi_rimt_pcie_rc *pci_node;
> +       struct acpi_rimt_platform_device *plat_node;
> +       u32 id =3D id_in;
> +       u32 id_mapping_offset, num_id_mapping;
> +
> +       /* Parse the ID mapping tree to find specified node type */
> +       while (node) {
> +               struct acpi_rimt_id_mapping *map;
> +               int i, rc =3D 0;
> +               u32 map_id =3D id;
> +
> +               if (RIMT_TYPE_MASK(node->type) & type_mask) {
> +                       if (id_out)
> +                               *id_out =3D id;
> +                       return node;
> +               }
> +
> +               if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPL=
EX) {
> +                       pci_node =3D (struct acpi_rimt_pcie_rc *)&node->n=
ode_data;
> +                       id_mapping_offset =3D pci_node->id_mapping_offset=
;
> +                       num_id_mapping =3D pci_node->num_id_mappings;
> +               } else if (node->type =3D=3D ACPI_RIMT_NODE_TYPE_PLAT_DEV=
ICE) {
> +                       plat_node =3D (struct acpi_rimt_platform_device *=
)&node->node_data;
> +                       id_mapping_offset =3D plat_node->id_mapping_offse=
t;
> +                       num_id_mapping =3D plat_node->num_id_mappings;
> +               } else {
> +                       goto fail_map;
> +               }
> +
> +               if (!id_mapping_offset || !num_id_mapping)
> +                       goto fail_map;
> +
> +               map =3D ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
> +                                  id_mapping_offset);
> +
> +               /* Firmware bug! */
> +               if (!map->dest_offset) {
> +                       pr_err(FW_BUG "[node %p type %d] ID map has NULL =
parent reference\n",
> +                              node, node->type);
> +                       goto fail_map;
> +               }
> +
> +               /* Do the ID translation */
> +               for (i =3D 0; i < num_id_mapping; i++, map++) {
> +                       rc =3D rimt_id_map(map, node->type, map_id, &id);
> +                       if (!rc)
> +                               break;
> +               }
> +
> +               if (i =3D=3D num_id_mapping)
> +                       goto fail_map;
> +
> +               node =3D ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
> +                                   rc ? 0 : map->dest_offset);
> +       }
> +
> +fail_map:
> +       /* Map input ID to output ID unchanged on mapping failure */
> +       if (id_out)
> +               *id_out =3D id_in;
> +
> +       return NULL;
> +}
> +
> +static struct acpi_rimt_node *rimt_node_map_platform_id(struct acpi_rimt=
_node *node, u32 *id_out,
> +                                                       u8 type_mask, int=
 index)
> +{
> +       struct acpi_rimt_node *parent;
> +       u32 id;
> +
> +       parent =3D rimt_node_get_id(node, &id, index);
> +       if (!parent)
> +               return NULL;
> +
> +       if (!(RIMT_TYPE_MASK(parent->type) & type_mask))
> +               parent =3D rimt_node_map_id(parent, id, id_out, type_mask=
);
> +       else
> +               if (id_out)
> +                       *id_out =3D id;
> +
> +       return parent;
> +}
> +
> +static int rimt_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *da=
ta)
> +{
> +       struct rimt_pci_alias_info *info =3D data;
> +       struct acpi_rimt_node *parent;
> +       u32 deviceid;
> +
> +       parent =3D rimt_node_map_id(info->node, alias, &deviceid, RIMT_IO=
MMU_TYPE);
> +       return rimt_iommu_xlate(info->dev, parent, deviceid);
> +}
> +
> +/*
> + * RISC-V supports IOMMU as a PCI device or a platform device.
> + * When it is a platform device, there should be a namespace device as
> + * well along with RIMT. To create the link between RIMT information and
> + * the platform device, the IOMMU driver should register itself with the
> + * RIMT module. This is true for PCI based IOMMU as well.
> + */
> +int rimt_iommu_register(struct device *dev)
> +{
> +       struct fwnode_handle *rimt_fwnode;
> +       struct acpi_rimt_node *node;
> +
> +       node =3D rimt_scan_node(ACPI_RIMT_NODE_TYPE_IOMMU, dev);
> +       if (!node) {
> +               pr_err("Could not find IOMMU node in RIMT\n");
> +               return -ENODEV;
> +       }
> +
> +       if (dev_is_pci(dev)) {
> +               rimt_fwnode =3D acpi_alloc_fwnode_static();
> +               if (!rimt_fwnode)
> +                       return -ENOMEM;
> +
> +               rimt_fwnode->dev =3D dev;
> +               if (!dev->fwnode)
> +                       dev->fwnode =3D rimt_fwnode;
> +
> +               rimt_set_fwnode(node, rimt_fwnode);
> +       } else {
> +               rimt_set_fwnode(node, dev->fwnode);
> +       }
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_IOMMU_API
> +
> +static int rimt_plat_iommu_map(struct device *dev, struct acpi_rimt_node=
 *node)
> +{
> +       struct acpi_rimt_node *parent;
> +       int err =3D -ENODEV, i =3D 0;
> +       u32 deviceid =3D 0;
> +
> +       do {
> +               parent =3D rimt_node_map_platform_id(node, &deviceid,
> +                                                  RIMT_IOMMU_TYPE,
> +                                                  i++);
> +
> +               if (parent)
> +                       err =3D rimt_iommu_xlate(dev, parent, deviceid);
> +       } while (parent && !err);
> +
> +       return err;
> +}
> +
> +static int rimt_plat_iommu_map_id(struct device *dev,
> +                                 struct acpi_rimt_node *node,
> +                                 const u32 *in_id)
> +{
> +       struct acpi_rimt_node *parent;
> +       u32 deviceid;
> +
> +       parent =3D rimt_node_map_id(node, *in_id, &deviceid, RIMT_IOMMU_T=
YPE);
> +       if (parent)
> +               return rimt_iommu_xlate(dev, parent, deviceid);
> +
> +       return -ENODEV;
> +}
> +
> +/**
> + * rimt_iommu_configure_id - Set-up IOMMU configuration for a device.
> + *
> + * @dev: device to configure
> + * @id_in: optional input id const value pointer
> + *
> + * Returns: 0 on success, <0 on failure
> + */
> +int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
> +{
> +       struct acpi_rimt_node *node;
> +       int err =3D -ENODEV;
> +
> +       if (dev_is_pci(dev)) {
> +               struct iommu_fwspec *fwspec;
> +               struct pci_bus *bus =3D to_pci_dev(dev)->bus;
> +               struct rimt_pci_alias_info info =3D { .dev =3D dev };
> +
> +               node =3D rimt_scan_node(ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COM=
PLEX, &bus->dev);
> +               if (!node)
> +                       return -ENODEV;
> +
> +               info.node =3D node;
> +               err =3D pci_for_each_dma_alias(to_pci_dev(dev),
> +                                            rimt_pci_iommu_init, &info);
> +
> +               fwspec =3D dev_iommu_fwspec_get(dev);
> +               if (fwspec && rimt_pcie_rc_supports_ats(node))
> +                       fwspec->flags |=3D IOMMU_FWSPEC_PCI_RC_ATS;
> +       } else {
> +               node =3D rimt_scan_node(ACPI_RIMT_NODE_TYPE_PLAT_DEVICE, =
dev);
> +               if (!node)
> +                       return -ENODEV;
> +
> +               err =3D id_in ? rimt_plat_iommu_map_id(dev, node, id_in) =
:
> +                             rimt_plat_iommu_map(dev, node);
> +       }
> +
> +       return err;
> +}
> +
> +#endif
> +
> +void __init riscv_acpi_rimt_init(void)
> +{
> +       acpi_status status;
> +
> +       /* rimt_table will be used at runtime after the rimt init,
> +        * so we don't need to call acpi_put_table() to release
> +        * the RIMT table mapping.
> +        */
> +       status =3D acpi_get_table(ACPI_SIG_RIMT, 0, &rimt_table);
> +       if (ACPI_FAILURE(status)) {
> +               if (status !=3D AE_NOT_FOUND) {
> +                       const char *msg =3D acpi_format_exception(status)=
;
> +
> +                       pr_err("Failed to get table, %s\n", msg);
> +               }
> +
> +               return;
> +       }
> +}
> diff --git a/include/linux/acpi_rimt.h b/include/linux/acpi_rimt.h
> new file mode 100644
> index 000000000000..fad3adc4d899
> --- /dev/null
> +++ b/include/linux/acpi_rimt.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + *  Copyright (C) 2024-2025, Ventana Micro Systems Inc.
> + *     Author: Sunil V L <sunilvl@ventanamicro.com>
> + */
> +
> +#ifndef _ACPI_RIMT_H
> +#define _ACPI_RIMT_H
> +
> +#ifdef CONFIG_ACPI_RIMT
> +int rimt_iommu_register(struct device *dev);
> +#else
> +static inline int rimt_iommu_register(struct device *dev)
> +{
> +       return -ENODEV;
> +}
> +#endif
> +
> +#if defined(CONFIG_IOMMU_API) && defined(CONFIG_ACPI_RIMT)
> +int rimt_iommu_configure_id(struct device *dev, const u32 *id_in);
> +#else
> +static inline int rimt_iommu_configure_id(struct device *dev, const u32 =
*id_in)
> +{
> +       return -ENODEV;
> +}
> +#endif
> +
> +#endif /* _ACPI_RIMT_H */
> --
> 2.43.0
>
>

Otherwise, it looks good to me from RISC-V perspective.

Reviewed-by: Anup Patel <anup@brainfault.org>

Thanks,
ANup

