Return-Path: <linux-acpi+bounces-16405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C156B45878
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1042B607A4
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82446199935;
	Fri,  5 Sep 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="N3ruazn7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264E19CCEC;
	Fri,  5 Sep 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757077680; cv=none; b=NZsHxZx/ta4qwSKDIuk4K5fva4irtJ9kqVYzvu0kyO5DEeQ7GP5BcBxJCCPfWr47dorNLAgLIfIIiEo68DeuEpMO0bKxkNXNb/vcYsf5UvpHGuAKXMDSFHgcOQOxFYIZ4p7nWqcpL4N0p5UZt8o1DSIJYy05VNjwUnhI3eQYFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757077680; c=relaxed/simple;
	bh=l2WYFgNBaZ4MPlTyWgrzjuvT6QefjAm47yBpEriSIzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAEXk7gdQpaEaqynfKcYE+TcGG4Hr/iAMZhdGKCr/qPvbnN0UyUbYc8byviWWkxyZ4bTOhF58BCoh90enGKQ3BnaLDBKodlc0OAwojRj+UZuWqzN4WFH7JIkzw5V9CA2TFkaWn9gxp+NcwDD/xcmmlYHYeo+I1o/0sXFGfTVV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=N3ruazn7; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A487C54B04;
	Fri,  5 Sep 2025 15:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757077676;
	bh=l2WYFgNBaZ4MPlTyWgrzjuvT6QefjAm47yBpEriSIzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3ruazn7B23/bC9vVhxp+lCN8z7Ji/30T9XvQ2a/vkxR1T8vn/MEx7ESEE8ox8Orv
	 qfoYJMK9KHecd97sU1eWDtxrzerXg5xyJyXxKQJA7jveApAefw43PWOxzpsN2py9km
	 RN+2ztf2Qg5JBGtK9h60EkPo6iwO+PRoTSjOZO38GdWsF+uG6NoHjuMG85yD2ZJWoE
	 aAsezNtF6WzYs9xzWGBdz6csTgf9taXtwp3tkCoA9fYKk76swDbEAtjypBlLoIj3Ta
	 J1Fx7jaDTMoeVfM/rC91FNmrTYTlt3nkzdjm0hKFNOmjRhUHYOcRL+tGr2wAWUVyhF
	 e7WkErgLNTI5g==
Date: Fri, 5 Sep 2025 15:07:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v6 0/3] RISC-V: Add ACPI support for IOMMU
Message-ID: <aLrgq_n1WiQxOKmJ@8bytes.org>
References: <20250818045807.763922-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818045807.763922-1-sunilvl@ventanamicro.com>

On Mon, Aug 18, 2025 at 10:28:04AM +0530, Sunil V L wrote:
> Sunil V L (3):
>   ACPI: RISC-V: Add support for RIMT
>   ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id()
>   iommu/riscv: Add ACPI support
> 
>  MAINTAINERS                          |   1 +
>  arch/riscv/Kconfig                   |   1 +
>  drivers/acpi/Kconfig                 |   4 +
>  drivers/acpi/riscv/Kconfig           |   7 +
>  drivers/acpi/riscv/Makefile          |   1 +
>  drivers/acpi/riscv/init.c            |   2 +
>  drivers/acpi/riscv/init.h            |   1 +
>  drivers/acpi/riscv/rimt.c            | 520 +++++++++++++++++++++++++++
>  drivers/acpi/scan.c                  |   4 +
>  drivers/iommu/riscv/iommu-platform.c |  17 +-
>  drivers/iommu/riscv/iommu.c          |  10 +
>  include/linux/acpi_rimt.h            |  28 ++
>  12 files changed, 595 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/riscv/Kconfig
>  create mode 100644 drivers/acpi/riscv/rimt.c
>  create mode 100644 include/linux/acpi_rimt.h

Applied, thanks.

