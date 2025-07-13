Return-Path: <linux-acpi+bounces-15117-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B4B03132
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jul 2025 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A734A189B426
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jul 2025 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2692D1DE2DE;
	Sun, 13 Jul 2025 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiV9hFLr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB932E36E3;
	Sun, 13 Jul 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413678; cv=none; b=dquNXB/AckHEhpXobp6p1+YugOZENZuQRWcFdiueQDYpCNM1cIicoSLX8E+Ihg+eDFNvkdIIgIP8fyIFzAq/g3gHFieuqmuGg7hI0Clq4gs0tIZMccRV7TXt67LY7k20krAWQzSjJf/cXjurTgTq1oowgKdBhFTivk7hzjnsfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413678; c=relaxed/simple;
	bh=M0e7BZCRHQvfdjHIlPvPxnacXc8HJ3PDKZo0Z3OiJXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYgm5CZXVnx/R4t/jQtUX08selJ3dudRbfTG0H9J7nNKpc0qWAix+7v/D/0dnEAeCKFvzJLEvz8K+3kbZ/Up4axeqtv8xQs27n9i4LhuS6OPj+U0TXf2hYLYRsuiluR6xdvfumnwe+RJAgtwyFg0don1PGo9Fpd+UBixfGLupig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiV9hFLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3888C4CEE3;
	Sun, 13 Jul 2025 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752413677;
	bh=M0e7BZCRHQvfdjHIlPvPxnacXc8HJ3PDKZo0Z3OiJXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiV9hFLr8XQeVItHWo75SPFqO5eqrOznmElvxKVepqha9jdxgmw7eTbwOWIlCH1Dp
	 zHUlgmf2x4oJHKW97aVh4OHhpJtW0WY5tKsl/yHPCJf8WgNMzOaLejiRKz+xmdS/2Y
	 sIyMkA1gAcoxsrke78FuWKVLJmRMuJ9LLiKNh9hI68F8NO8YL7u8S2dtvf0LFrlK4H
	 AnZBKWlIxXev4xL6vTCTfsJ43R6ZpqlX3/4znWHtnREOr9RA6Y6zrnIVjUXCx6tyHr
	 022ikIksXB9GmjH8RjWhlB54FqJH14XUYhmI/gGuW5ybD8I006KhhtAoPv+4fNgEfX
	 4TH++r9lkI0jA==
Date: Sun, 13 Jul 2025 14:34:31 +0100
From: Will Deacon <will@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v4 3/3] iommu/riscv: Add ACPI support
Message-ID: <aHO158RO9fD6mXVh@willie-the-truck>
References: <20250710085657.2844330-1-sunilvl@ventanamicro.com>
 <20250710085657.2844330-4-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710085657.2844330-4-sunilvl@ventanamicro.com>

On Thu, Jul 10, 2025 at 02:26:57PM +0530, Sunil V L wrote:
> RISC-V IO Mapping Table (RIMT) provides the information about the IOMMU
> to the OS in ACPI. Add support for ACPI in RISC-V IOMMU drivers by using
> RIMT data.
> 
> The changes at high level are,
> 
> a) Register the IOMMU with RIMT data structures.
> b) Enable probing of platform IOMMU in ACPI way using the ACPIID defined
>    for the RISC-V IOMMU in the BRS spec [1]. Configure the MSI domain if
>    the platform IOMMU uses MSIs.
> 
> [1] - https://github.com/riscv-non-isa/riscv-brs/blob/main/acpi-id.adoc
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
>  drivers/iommu/riscv/iommu.c          | 10 ++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)

Sorry, I missed there was a v4 of this. I'm not sure how you plan to
merge the series, but from the IOMMU side:

Acked-by: Will Deacon <will@kernel.org>

Will

