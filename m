Return-Path: <linux-acpi+bounces-14875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE88AEED12
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 05:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4553BE5FB
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jul 2025 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1AA1E5701;
	Tue,  1 Jul 2025 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jcr/3CjO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865C1805A
	for <linux-acpi@vger.kernel.org>; Tue,  1 Jul 2025 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751341668; cv=none; b=pCd69wZgnKTO+M87Thgf3tM/+GwPraDLhk3ff06a7YFMbnrc0rx6ij/8l3i/VMPWekeJnd0Rx6yUgUc4RtQTNsczXAqweXS62NiMx2LO4/Ta6c3OkcANW91CI2xnk98ter7S3vx/TLAn1hF7Fs9pIXMxs+5wjbEoLZ0yVl5q+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751341668; c=relaxed/simple;
	bh=pxIbsYpOLc6LPCX7Y2ZibVmY1Hku+f+8eNIhpZl5XhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvFhIOu/MaSVzh9JX4Yyxx78o9rwbkiawWLpkO0djc5SfuiVHh427aU1fB3y1uqG6n8omHWY3oQgK7J2bwdP86JFLeg6xNWnLNyG3SwsHiNfSmkfc+bakKKlW1TWJjuQ1n7ybzeoBuW+Bn3Re3DDHYjD8d+IafABBb1ieEQrgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jcr/3CjO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349f096605so31318415ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 20:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751341664; x=1751946464; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q70BTMXv+elr6mx+h6qORt+5RlAkLGyM2dZSnSb4WnM=;
        b=jcr/3CjO3pOfM1wn9OSdXFNnOpkOPlFYHUADEiTZV1FpS5Vc0g0tu0zrbePSQlPiDv
         k/NHYrf8byNE1gCShI+CEeNgb4k/B+eIE7EBBdFq8iYL3170yyHXO+zoEvNuhw5P1UTH
         5ZneBZ1BmN/2ycQqLbd/oSWzLVXiTt9sktFerVncYivcxqZ4cYtErdQOZKg2mAQtM3zq
         7nUtU0PW4prb+pHjjSonR7G6OKZbotV3mIU2tqDNvmICjLXDjoI04+TJM4Hxw+RfyMOq
         aONptXDl+7CpQ2HhEL2+DxLf3BfGoHUoLs6gtKMAmH7bRJcZLjFI2BlBLbot2je15MuT
         ndXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751341664; x=1751946464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q70BTMXv+elr6mx+h6qORt+5RlAkLGyM2dZSnSb4WnM=;
        b=lJzDlDQStSX2JVfvXxKtLyHRdukF2IBvksk5Nkxaz9HB8Nq1TrSrpZdKducOduU+4d
         TM2pV2W7DMY4Y036DG5+EbH9QwG8KFlY2ib4xNUHOMVY4gpPbpK4lKGRGzSumURaSvQk
         2NFT2cxiGLRoIjtZHV/xFgwnxnLnxA+cNvMdYV7tSGRGtFZjV4nUkL4oJwE+LhGkwspI
         AijBjiInsCHZVqPbY+xdI5ujVfEzeiO9eFcexGaLhAXgKoQ84fVzoDx3k/DDpjSwo2WJ
         1IKcj63fyNc2Fc/Xo4jl/bgEjIL6W2T4mB81XeOWZpFNXMSpx5kTYDcj72TpkPMVU3hM
         da8g==
X-Forwarded-Encrypted: i=1; AJvYcCXyVydp9kK7u+dpsQe2322P4jbBFCJmMHvs+DbATOIVLcOXGXi9c8U1msYRk+Z8MPyyYn+X41VwYs0o@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIXa1kPdjF5q9fVmbiOXRZtmAP3GtWsOFTr3t3dLGrqrjKNgu
	RX7ASsEQV6rYKOQQsrosIquiDkB/pWs8/DxDZHKHkJBAxOJwj47Z/8AQNRpxyGwpxlnHPsd0JrH
	mLkiJZ6c=
X-Gm-Gg: ASbGncsi9xHmsa4RHhGSymtYmCTLx7Q89mDPyzWtx1ZAQoZEzG/P7RGFtAae3wuSHFS
	XwrokugP/gTDX+QycZKG5TAqQ63EhHM/ZJ1fX54bYD10I36HlHMWIsBfPmr7NbOyEzp2I2bTrUY
	0F8uVJHK3e+1aYLpM+9ROHoOho2vS7ok6HWumen7DRzg2x9mVpj9HqetgNsRS5YvBJJc3vSa3A+
	zGyOx1yhlPhL7sLl6SDn07nknGcbfONYHQxToYVjQh+R6/xrrIaXzMbrj3SQu1lOLmLkywnrSvj
	1qnSibc3FT/RwlROIPTSYMFtxJERepinyqNzlRNdsT8ffvVR6vgX0r9nEO/1i4O/szE3LA==
X-Google-Smtp-Source: AGHT+IGN1GMdTqZAPJCguumolenY1Wtb8nB6QKle+VjMdicMJz56dOOYCipT836/9qVM3LRjuPHcgA==
X-Received: by 2002:a17:903:fa3:b0:235:779:ede3 with SMTP id d9443c01a7336-23ac4680a0fmr213846545ad.41.1751341664573;
        Mon, 30 Jun 2025 20:47:44 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2f1c40sm95714045ad.67.2025.06.30.20.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 20:47:44 -0700 (PDT)
Date: Tue, 1 Jul 2025 09:17:33 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 1/3] ACPI: RISC-V: Add support for RIMT
Message-ID: <aGNaVQEsZX7vmrFv@sunil-laptop>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-2-sunilvl@ventanamicro.com>
 <20250630-4a94187c794980bb830c539a@orel>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-4a94187c794980bb830c539a@orel>

Hi Drew,

Thank you very much for the review!.

On Mon, Jun 30, 2025 at 09:55:09AM +0200, Andrew Jones wrote:
> Hi Sunil,
> 
> I found a few nits while skimming this.
> 
> On Mon, Jun 30, 2025 at 09:18:01AM +0530, Sunil V L wrote:
> > RISC-V IO Mapping Table (RIMT) is a static ACPI table to communicate
> > IOMMU information to the OS. The spec is available at [1].
> > 
> > The changes at high level are,
> > 	a) Initialize data structures required for IOMMU/device
> > 	   configuration using the data from RIMT. Provide APIs required
> > 	   for device configuration.
> > 	b) Provide an API for IOMMU drivers to register the
> > 	   fwnode with RIMT data structures. This API will create a
> > 	   fwnode for PCIe IOMMU.
> > 
> > [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  MAINTAINERS                 |   1 +
> >  arch/riscv/Kconfig          |   1 +
> >  drivers/acpi/Kconfig        |   4 +
> >  drivers/acpi/riscv/Kconfig  |   7 +
> >  drivers/acpi/riscv/Makefile |   1 +
> >  drivers/acpi/riscv/init.c   |   2 +
> >  drivers/acpi/riscv/init.h   |   1 +
> >  drivers/acpi/riscv/rimt.c   | 523 ++++++++++++++++++++++++++++++++++++
> >  include/linux/acpi_rimt.h   |  26 ++
> >  9 files changed, 566 insertions(+)
> >  create mode 100644 drivers/acpi/riscv/Kconfig
> >  create mode 100644 drivers/acpi/riscv/rimt.c
> >  create mode 100644 include/linux/acpi_rimt.h
> > 
[...]
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 36061f4732b7..96d64e0a7b97 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -16,6 +16,7 @@ config RISCV
> >  	select ACPI_MCFG if (ACPI && PCI)
> >  	select ACPI_PPTT if ACPI
> >  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > +        select ACPI_RIMT if ACPI
> 
> Should use tab here.
> 
Okay.
> >  	select ACPI_SPCR_TABLE if ACPI
> >  	select ARCH_DMA_DEFAULT_COHERENT
> >  	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
[...]
> > +static inline int rimt_set_fwnode(struct acpi_rimt_node *rimt_node,
> > +				  struct fwnode_handle *fwnode)
> 
> I see this is a faithful port of arm's iort functions, but using
> 'inline' in source files is pretty pointless, so we could drop
> that.
> 
Sure.

> > +{
> > +	struct rimt_fwnode *np;
> > +
> > +	np = kzalloc(sizeof(*np), GFP_ATOMIC);
>
[...]
> > +	map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
> > +			   id_mapping_offset + index * sizeof(*map));
> > +
> > +	/* Firmware bug! */
> > +	if (!map->dest_offset) {
> > +		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
> > +		       node, node->type);
> 
> Should we have a pr_fmt() definition at the top of this source file for
> this pr_err?
> 
Oh yeah. Will add.

> > +		return NULL;
> > +	}
> > +
>
[...]
> > +	return err;
> > +}
> > +
> > +#else
> > +int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
> > +{
> > +	return -ENODEV;
> > +}
> 
> This is unnecessary since we have the stub in the header file.
> 
Right.

> > +#endif
> > +
>
[...]
> > +int rimt_iommu_configure_id(struct device *dev, const u32 *id_in);
> > +
> 
> ubernit: no need for this blank line
> 
Sure.

Thanks!
Sunil

