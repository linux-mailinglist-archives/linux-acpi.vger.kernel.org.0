Return-Path: <linux-acpi+bounces-6844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842592D389
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 15:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE1B1C20B2E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26530193441;
	Wed, 10 Jul 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SoHWUk97"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF981723
	for <linux-acpi@vger.kernel.org>; Wed, 10 Jul 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619771; cv=none; b=HvP3pRojZEPxYs1o9s0FI3D4f8r9E7jnTo9ZAzuep25eW9DpsqhsYo5Ts7KywtBwuKF100ioNyme057x9b5gTKaXK+xj+v4OAm8w+qxErs1RTrIh59blUShAM4AERjkKEtL8SDHDWLPBn95jrOHYY6P47XL0nHZ0WGbjHXRnOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619771; c=relaxed/simple;
	bh=4orvUMMoNpng3DjzFKund9fT1GMrWdRRxaueO/TppS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cByQFjV5cXql4COfLw84Bnn8N23hiy2Rlvl+M5J1mtNDikYcKCg+LoW8fc5s7wIbGR/OYcNIRI2BdGXZwKAw7n2/MdIgE4duFKN+LRmkxiQZcCGlnUQvFQNAPHld9zRe1Sw2Gx4Wi/m6SrAu34lEGsu/qVBLhWqVYG2zaCBTsGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SoHWUk97; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c661bcb9a0so1930264eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 10 Jul 2024 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1720619768; x=1721224568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbBxTrEkr/JgMWsq56fte0LuyrtPahP1hWVuaQ2pC/c=;
        b=SoHWUk97tdbn5PqfLriC1Ee1BNwrd0J+RQT/dFKknoBWFOmVC7wmvhn230anLOaGg4
         922bVy5OGgPBq589ymaiOaPEmfaqBGVVSSYrTC0GaFdWtYz0FONOGK8P8GBEeO/orLtV
         1c8YR1sx4404duudzCOyD1ObAlUfeOn72VKE7nOfeNI2TpDIQWnD+pJtVv1Y1ajX7tK0
         E3rxxA1/ak3tf8hmnbKo3Ko/wI5XBU+dNe346p0tgPCK+hcCtnOK5REZ5EGXFjKFN6ny
         bSvkK5u4vPa87NFMzVPiZveOMiIdyPiZLN9KKZp0SzYs/cjKYgom1ko2qXa/6CF0fo2o
         TdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619768; x=1721224568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbBxTrEkr/JgMWsq56fte0LuyrtPahP1hWVuaQ2pC/c=;
        b=nWwnW/s3XpyOO7uRfNO37FgrKlBpKwNh3NRxH+bYgUzEKBEH/3SRE+jzhUpPldKGAO
         DIbkjpCVw8hHqS57qvWny4KMWuxCAbtOsIPR6AKmwTdR+v189Ib+NxkP1Xp3J7VgHb8k
         D3VMkpFKHr3m8bRkvqID7wFltUYHCA2ja2vzMjug8TmBKF454vfH5nEpO/SZVn9etx0P
         yjucfow4Dyb2jLAg7cj2bGls0mjzckvIrM5qi2DE5UMm//p1n0jkfX9dtZyoJ3CBy8sg
         u8k/XfrE+5I7aFwGeW0nyBiB6/D5tlKWWnrRmHlvE/HIivmkvj7yJGDR3GgH4njy4tZl
         7M0g==
X-Forwarded-Encrypted: i=1; AJvYcCVTebarjQLbXahN6cp+98ZD2LYodV0Ap+eP6G0trcKZlzxmlju9ZmrrHp+fAhWzJTmRbLv4hbgkOFNiLo0+9bYRsIEcwriswNmcMQ==
X-Gm-Message-State: AOJu0YzChBCxFPWFxjYIUJSNmPG1rynLzw2BYEJ47d1OMaGC0PYl2tL+
	NXeLX2K5IBotuNHz/nsivcC2O/x1cOJ9/WFZ0QZqhIn9mjJjARf4VX/+8C6GOwk=
X-Google-Smtp-Source: AGHT+IFcEa/6ymDnm7Yw+exYpWcVCdVGgsioH7lKM2D2Vq9RknY06qP+ZWew0XTxFouYZL+Q02zZqA==
X-Received: by 2002:a05:6870:82a5:b0:25e:1551:a2ec with SMTP id 586e51a60fabf-25eae75ec0bmr4447821fac.3.1720619767895;
        Wed, 10 Jul 2024 06:56:07 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.237])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25ea9f8219asm1177943fac.12.2024.07.10.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:56:07 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:25:53 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v6 10/17] ACPI: RISC-V: Implement function to reorder
 irqchip probe entries
Message-ID: <Zo6S6T3HXW1IY1lP@sunil-laptop>
References: <20240601150411.1929783-11-sunilvl@ventanamicro.com>
 <20240606220743.GA821335@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606220743.GA821335@bhelgaas>

Hi Bjorn,

On Thu, Jun 06, 2024 at 05:07:43PM -0500, Bjorn Helgaas wrote:
> On Sat, Jun 01, 2024 at 08:34:04PM +0530, Sunil V L wrote:
> > ACPI MADT entries for interrupt controllers don't have a way to describe
> > the hierarchy. However, the hierarchy is known to the architecture and
> > on RISC-V platforms, the MADT sub table types are ordered in the
> > incremental order from the root controller which is RINTC. So, add
> > architecture function for RISC-V to reorder the interrupt controller
> > probing as per the hierarchy as below.
> 
> Is this ordering requirement documented anywhere?  I don't see it in
> the RISC-V ECRs to the ACPI r6.5 spec.
> 

Thanks. We have added this clarity in a new mantis request.

> I guess the implication is that you need to process MADT structures in
> order of ascending acpi_madt_type:
> 
>   ACPI_MADT_TYPE_RINTC = 24,
>   ACPI_MADT_TYPE_IMSIC = 25,
>   ACPI_MADT_TYPE_APLIC = 26,
>   ACPI_MADT_TYPE_PLIC = 27,
> 
> regardless of the order they appear in the MADT?  I.e., process all
> the RINTC structures (in order of appearance in MADT), followed by all
> the IMSIC structures, then all the APLIC structures, etc?
> 
Correct!

> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/acpi/riscv/Makefile |  2 +-
> >  drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/acpi/riscv/irq.c
> > 
> > diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> > index 877de00d1b50..a96fdf1e2cb8 100644
> > --- a/drivers/acpi/riscv/Makefile
> > +++ b/drivers/acpi/riscv/Makefile
> > @@ -1,4 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -obj-y					+= rhct.o init.o
> > +obj-y					+= rhct.o init.o irq.o
> >  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
> >  obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> > diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> > new file mode 100644
> > index 000000000000..f56e103a501f
> > --- /dev/null
> > +++ b/drivers/acpi/riscv/irq.c
> > @@ -0,0 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023-2024, Ventana Micro Systems Inc
> > + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> > + *
> 
> Spurious blank line.
> 
Okay.

> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/sort.h>
> > +
> > +static int irqchip_cmp_func(const void *in0, const void *in1)
> > +{
> > +	struct acpi_probe_entry *elem0 = (struct acpi_probe_entry *)in0;
> > +	struct acpi_probe_entry *elem1 = (struct acpi_probe_entry *)in1;
> > +
> > +	return (elem0->type > elem1->type) - (elem0->type < elem1->type);
> > +}
> > +
> > +/*
> > + * RISC-V irqchips in MADT of ACPI spec are defined in the same order how
> > + * they should be probed. Since IRQCHIP_ACPI_DECLARE doesn't define any
> > + * order, this arch function will reorder the probe functions as per the
> > + * required order for the architecture.
> 
> But this comment seems to contradict the commit log.  This comment
> says you should process MADT structures in the order they appear in
> the MADT.  But if that were the case, you wouldn't need to sort
> anything.
> 
> Maybe "defined in the order they should be probed" means "in order of
> increasing Interrupt Controller structure type value"?
>
Agree. Let me update.

Thanks!
Sunil

