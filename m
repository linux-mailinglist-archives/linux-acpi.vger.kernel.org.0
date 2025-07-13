Return-Path: <linux-acpi+bounces-15116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B20B030E3
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jul 2025 13:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A5817C808
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jul 2025 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDA61E5018;
	Sun, 13 Jul 2025 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5cG82/4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F820311;
	Sun, 13 Jul 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752407260; cv=none; b=p4LAmJVTM7Zs3YqwGh2RFKWDtuf54SUukBjUC1r/rkaPpg2nFLWxYfjhaquYBNVdTiKeZ1KiLs6MQVb7lZ0bLpZP16eedtBbX8e+jviMsxKQtigSovPxNDW2nl4n/KDJ+TKmjr8K0aHgr1q1NUYefxIfOWreJgH4FmPtC2blULA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752407260; c=relaxed/simple;
	bh=M/pi6LcA8Q4D+HAp7JPhFXciqaEe2rBWyhTGd354j1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJNM+SNxAK0rOwCQ+vQgVSWnC7RcbO+1MOl/cHyx4folD9LWjSwE9p3TUhKRGKO/dCIpUuMqJWWmsdAUURtN+rwiXgSD/if1iBHW65EoZ7zMlE5buVpHa752CNv+YzWot27vYhV9tcQC1V3LpECl8hazMkW4Fx1jWaHjyq9oz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5cG82/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7336BC4CEF5;
	Sun, 13 Jul 2025 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752407259;
	bh=M/pi6LcA8Q4D+HAp7JPhFXciqaEe2rBWyhTGd354j1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5cG82/4gVQfid77wwr29J57EImm7MjS7SurIH1RZmUizMZ6e0+tnRbr0JpNOxIx0
	 KqQI6Ppp2MqsW6wxvPivqX//8zf403hUEFmoifKoAguPaiBlD+4XR1YVzte91l7mT7
	 F1yMfSFBaITIpGfjeJn8Z4Zz12K+hCyFbmaHVQ2iYqoqIqs3hpXtSMUSUWExjRj3m1
	 uI6qnGvyJRUGnRwstf4pEdLf+iO+3+Cf5F6wiyg/uxr/9rbv8bR70G8X4zHl6z+2Qp
	 rRPQzuRnmtxCU4JrinplBVAJJZ6x4NwYdZiNyrVZuvGuYMTOv5W9lGv3CENcVnW65G
	 JcA/h1HkvEbmA==
Date: Sun, 13 Jul 2025 12:47:33 +0100
From: Will Deacon <will@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 3/3] iommu/riscv: Add ACPI support
Message-ID: <aHOc1Syl1roOd5Pz@willie-the-truck>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
 <20250630034803.1611262-4-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630034803.1611262-4-sunilvl@ventanamicro.com>

On Mon, Jun 30, 2025 at 09:18:03AM +0530, Sunil V L wrote:
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
> ---
>  drivers/iommu/riscv/iommu-platform.c | 17 ++++++++++++++++-
>  drivers/iommu/riscv/iommu.c          | 10 ++++++++++
>  2 files changed, 26 insertions(+), 1 deletion(-)

This looks relatively straightforward from the IOMMU perspective
(assuming the driver still compiles if CONFIG_ACPI=n) but the ACPI parts
in the first two patches need reviewing before this can land.

Will

