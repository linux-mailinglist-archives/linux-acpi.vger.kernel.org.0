Return-Path: <linux-acpi+bounces-14845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF17FAED31D
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 05:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EBA171FBE
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jun 2025 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466F986344;
	Mon, 30 Jun 2025 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d7vqhopj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCFA59
	for <linux-acpi@vger.kernel.org>; Mon, 30 Jun 2025 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751255496; cv=none; b=HACmFJ2gz9j/e6Nc9RleJskyN2AwoooKb0e9GVy4rlxgf0/Nvu5KUWrgUb2IUW4dWYA93eEPzN4DKgu3uNiiACktp5Df/1ZyS39oIbqKJU/iSB1si353RGBYC/FtU66u/+oKSVoK/87cGmXJ+jXHt+17wiMEj8fpcbqoO60daH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751255496; c=relaxed/simple;
	bh=QTzyOXu5qu2K9jHAadeJSq39OHr964W9UaOXOneTV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgV51NLuqoCw06rJM+8k5xnRBzSomEozOirYKYcEb09wQYTvswouMcfYyjMTdym9XMAXoUGkOdUS4PiKPTR1nd4o+HchKvgBfUdq9yChGg+aPUkUMRpvMxc07qh3l83k818k3zukRo9ifMHxz2/xCpZexotmcHek5AZFjTHoy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d7vqhopj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4181277b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 29 Jun 2025 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751255494; x=1751860294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UED82EXPvvwcKwvtCpX0i6qazNmJqZIAw5hRVMYvLpc=;
        b=d7vqhopjBWRLP56ynLjf+xzDu/AGoISYQAJ7xUlErLkXrgV2fyTJHINB/GfwtvrRyn
         rMOQYVHDMqPhAjk93A8BLw1UyjUQGhhprzVF/zw7POdEckkmFgB8Ms+i+RfuV7rZpP4h
         QGj0uruJNqBxKxZLToxToNe+mJ7na981Na216hYcXh5ewrtp7xeEVbmjZN4bvJn/i/7e
         W0IElfYG93jkWPqCNaB46OIu1xB7EZi9l7/9Ygn2ucQ/qJ5LUqOdhlUCcwK5Sp13gEPh
         iMpkah3dK1nIIqNUxXhktueWYWy2G0I7kvGuUlZ7mGNCEsQ4aG86bU79HqBULxT2kGWp
         S5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751255494; x=1751860294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UED82EXPvvwcKwvtCpX0i6qazNmJqZIAw5hRVMYvLpc=;
        b=JGoVKSsd4RNJGF1cI/2ZXjMvoKtLbZ1McdDUUIDHMlIsa4agadFInmWsDaDPRNR/iG
         iAe9Km2nkxvPdQb3tX8819VtcUxMzwG97+CVWeTyBm5xL/CNmyX3HfZDO8I4/aDC4+AE
         tQ5njZnypxZI//1eC8iZhTR5IN46Rtak1ZbGicySKG4zu83qTBgYmSHcb08p7++jQl07
         YZmFfQIZGXBOZ5+n5dBv0tQ9zqoy8C4+ZrilwJAVYFcDrvQ6fFvHXuv8h/Bgr+m0TSO4
         nHX85Paro+4sm9qOFbCUeMq3d6D5ddpyR9x+O63MANTf/rTWSGCoGUG+SlECrZTbVIHJ
         R/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW5B8afTmtkusLS1ppOr7oNmA+je8sOFv/wwlOXAB4ZV/LC1kRPkVM0wV8NM+i8Ym7rDmijx0EO9O+s@vger.kernel.org
X-Gm-Message-State: AOJu0YxNYX/0NK+MDn1rPwWyzgFY53UliIcoDAplIooSFFDbOipmiu5V
	v1bLqOxopXCG1sLFpPvgcyHKIsIF2j7cYNqcqMad2qzbdKeGuB6px+ued63nDHkd5yE=
X-Gm-Gg: ASbGncuOLr0o/g0nDx2qHffyle3lowK5S/Ba9Vg6Gcg8Pabbr+RtPaG0Q5e2Zqz9cVl
	TrN1KbseRIMxzP3iveVVNOtJgdrVq29NEAmbsCZeBp5Fz1kdSrupJ6BYbCAnD1bWokFgsGXcYWM
	730h2AOq8k9KPt54fRPYVLglN1xq96A10VtLouKMuh+QWQlTDedc92TPGkb47e0ThSYk+UIDxJe
	fFrrUFUL6sPFNrOlMmA8iLqbUp6fNCe7BsyZsTi0mC+0sJ29OvJBY825he2ea7qCGZZAJJ74PcZ
	+Xs+j4kuKIR2Yw3WcLBKTnBDrdHqdKNIZFtXGby/E5OZspoXC+wYQw+OGTjFxcwqg8rKmg==
X-Google-Smtp-Source: AGHT+IH50RyHuOnxZl2ccwGVqZn5SetEZq+s0+V/7t4N3nC29VesI3/CLLW5Bs7mTAzZWQEnHHyh/A==
X-Received: by 2002:a05:6a00:1704:b0:749:bc7:1577 with SMTP id d2e1a72fcca58-74af6e6618emr15035867b3a.9.1751255494141;
        Sun, 29 Jun 2025 20:51:34 -0700 (PDT)
Received: from sunil-laptop ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b5c8sm7808043b3a.83.2025.06.29.20.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 20:51:33 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:21:22 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v3 0/3] RISC-V: Add ACPI support for IOMMU
Message-ID: <aGIJuiSuZs17DSiM@sunil-laptop>
References: <20250630034803.1611262-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630034803.1611262-1-sunilvl@ventanamicro.com>

Hi Tomasz,

Could you please help reviewing this series?

Thanks!
Sunil
On Mon, Jun 30, 2025 at 09:18:00AM +0530, Sunil V L wrote:
> This series adds support for RISC-V IOMMU on ACPI based platforms.
> RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
> to communicate IOMMU information to the OS.
> 
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf
> 
> Changes since v2:
> 	1) Rebased to 6.16-rc4
> 	2) Removed Anup's SOB and link tags added by mistake in v2.
> 
> Changes since v1:
> 	1) Rebased to v6.16-rc1.
> 	2) Dropped ACPICA patch since it is already available in 6.16-rc1.
> 	3) Added Rafael's ACK.
> 	4) Fixed few issues found by bots.
> 
> 
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
>  drivers/acpi/riscv/rimt.c            | 523 +++++++++++++++++++++++++++
>  drivers/acpi/scan.c                  |   9 +-
>  drivers/iommu/riscv/iommu-platform.c |  17 +-
>  drivers/iommu/riscv/iommu.c          |  10 +
>  include/linux/acpi_rimt.h            |  26 ++
>  12 files changed, 599 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/acpi/riscv/Kconfig
>  create mode 100644 drivers/acpi/riscv/rimt.c
>  create mode 100644 include/linux/acpi_rimt.h
> 
> -- 
> 2.43.0
> 

