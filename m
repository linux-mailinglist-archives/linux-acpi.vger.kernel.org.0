Return-Path: <linux-acpi+bounces-15200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B06BB079C7
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 17:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8007169CDB
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940B273D9E;
	Wed, 16 Jul 2025 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Jda32v08"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EC1E0E14
	for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 15:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679635; cv=none; b=Uq6GsTBZphcNDEGUd/PKzzy+hbwGeue7pWTj0WK+Mn5CGdQo1EtvPFzQ3N5kWCaIHKCz1+VUX3eHtY4iCPDA39ORToNQfe62VgnZVU1CVM6I5DBEM2PQ23G+zukGCVpfgBewoL4BtFm4zPYKydq0JxIJqZ+OyQ3rMoJjSKGYfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679635; c=relaxed/simple;
	bh=c9K3Jeyllh9acXj8/pMhkma1YgpPHnE/1br2gKtyXNY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=V8Z8oebEzmJYO1fb4g1qW3lCqZayyagj86t5yshLOh/z5Ed3dQiu/G1nCXYB6dWiOyZfVB+1DJcS+9IFD9f9T4NCqG/c6QGSvPEz6LvAsq7GzrFl6JQ5eZXO0xF7n6i6Ka+q7S/NJM1IURYxe7klIAxCZ/KwHcQe6lKinJ1Ui+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Jda32v08; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b54cead6cso50217b3a.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jul 2025 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1752679632; x=1753284432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLHXWx3e4qVyWFktNcTinbMTNqw3Gsd0ZZ2hzOlFYG4=;
        b=Jda32v08Ah3rz+x38BsvdPZZ3V0SZnG8L0Djg/kNAeZPOo9/eUMf+IqEJXuItY+b01
         ZI5XgM6OLnZW6DVC8R6Nx/90sPNJs48hCN5qTv5Oye/NPE78822As8XfFTynMlTDFCdH
         rhs+QFuV7aT6qhEa+DgL2rWkYNa4jL0StHtJ27vt/ZbrNagfDYH05XS3pVkvKFCI1NKs
         mzkNzIU90Xghu3u3Clxr/aFyYdVc1uZFK/8bZokk/PF68fXahuLF/Vu3glSV3deQM4Zj
         xAYrhwn9pkJ0lQWxYapYxobh23KFIgDqmgC90aUTbrbZ+AEPbw7GbHpI0FsJNgdkQC78
         s5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679632; x=1753284432;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLHXWx3e4qVyWFktNcTinbMTNqw3Gsd0ZZ2hzOlFYG4=;
        b=KqvQVUeu+e5zYYdHlui75HG0kf6/rew9P4RteUqWZjEBpFlc21jeHBUTvIIhoYL1vu
         i0h7c9B7ybHEwBsoxWflNGM0zblnl9fnKlClgmUO72vjaqY7PNi9G4L9oV+XoNlCbfnO
         2XDHwu7ehtRXVHYDjd8A0bY15jB9lAjMV4f3gjc2+LnnqF2BMbcJzs4R3K0LYwaOnBzN
         KBtxOMx6wkMAdsaSGnI98SJ9G9RfMBu+Ua512Pe0CoFHQuHSaA7CDdDVI+uRWYIDj0dG
         4USRB2k+LI4kCxs6ogzHuvM+r2jMJNYYZP9o4wyCofwViBXdt83xYYArXIDRQHJI30/0
         lP0w==
X-Forwarded-Encrypted: i=1; AJvYcCU0xDgurlgmuZn0fTdvxFijKd91EumLn7j/uY2XERyUp6wDe0NI8yC/XH5Yav6PPz81ZfQGrERC+cF7@vger.kernel.org
X-Gm-Message-State: AOJu0YxoH/sAWGVpxPwR/bnbd+2vEzn7WKgUbkK7pNegC1dgwen+4/Pc
	3n3QjhT3xJs2LY1ntaFhNQMJUpv7wXfn/xVguKq+QYi7wEjy+wv+Ec5m0BIpAIfmAso=
X-Gm-Gg: ASbGncv/TCdZmR1yy9J+j0qweNwK+DLq5ShJeaQnTlQOnHNZByI/HM6WbtGIRBTbBn9
	DYsFaPm4EEOyJIb3Ab211OXXGyYhpDrpT5QsKTwXxsusgzwl5dll8PXWo6fmXJOlNoJsVDTghix
	ikGO4pKHXUWlIWd7weIk2jzaFFcGdQXY94nvithgjUnMg3k562aliN7+oH62usf5uS2UcwkNByI
	DhFEH/+qKqAXX0ZYWbO/BXmm5ck8ZvwpkpjurOOrgoRGYM1s3t00yHZNFvqVw7n24ec/bKMvK4b
	GvRiL4TZA41jsEc7yFki0oTLyEzW18iHBATRZYbwNkMVTiFlwmGmVadiP+lTIrrzt1etxDUpI0w
	ZyyqFAic0N2jKZmnKZMN1
X-Google-Smtp-Source: AGHT+IH7iBG8I47ZPk3kjc8DlfJqKS+H6u2KneCpl6yYfAutQXIcMVrF/w+WWdKN0EwIATcq6Y7GTg==
X-Received: by 2002:a05:6a00:22d0:b0:748:e0ee:dcff with SMTP id d2e1a72fcca58-75723d7d2c8mr4843826b3a.11.1752679632185;
        Wed, 16 Jul 2025 08:27:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:b02a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f22c01sm14929679b3a.101.2025.07.16.08.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:27:11 -0700 (PDT)
Date: Wed, 16 Jul 2025 08:27:11 -0700 (PDT)
X-Google-Original-Date: Wed, 16 Jul 2025 08:27:09 PDT (-0700)
Subject:     Re: [PATCH v5 0/3] RISC-V: Add ACPI support for IOMMU
In-Reply-To: <20250716104059.3539482-1-sunilvl@ventanamicro.com>
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  linux-acpi@vger.kernel.org, iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
  Alexandre Ghiti <alex@ghiti.fr>, rafael@kernel.org, lenb@kernel.org, tjeznach@rivosinc.com, joro@8bytes.org,
  Will Deacon <will@kernel.org>, robin.murphy@arm.com, Atish Patra <atishp@rivosinc.com>,
  apatel@ventanamicro.com, ajones@ventanamicro.com, Sunil V L <sunilvl@ventanamicro.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Message-ID: <mhng-E714E5B9-0828-46CE-B890-9AE61C2E341D@palmerdabbelt-mac>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 03:40:56 PDT (-0700), Sunil V L wrote:
> This series adds support for RISC-V IOMMU on ACPI based platforms.
> RISC-V IO Mapping Table (RIMT) is a new static ACPI table [1] introduced
> to communicate IOMMU information to the OS.
>
> [1] - https://github.com/riscv-non-isa/riscv-acpi-rimt/releases/download/v1.0/rimt-spec.pdf
>
> Changes since v4:
> 	1) Rebased to 6.16-rc6
> 	2) Addressed Anup's feedback on formatting.
> 	3) Added RB tag from Will and Anup.
>
> Changes since v3:
> 	1) Rebased to 6.16-rc5
> 	2) Addressed Drew's feedback on v3.
> 		a) Reordered calling rimt_iommu_configure_id().
> 		b) Removed unnecessary inline.
> 		c) Added pr_fmt.
> 		d) Removed redundant rimt_iommu_configure_id() stub.
> 	3) Added Drew's RB tag in PATCH 3.
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

Thanks.  Anup came to the patchwork meeting this morning and asked me to 
pick it up.  It only barely touches arch/riscv stuff so I'd figured it 
was going somewhere else, but happy to do so.  I've picked it up into my 
staging tree as

    *   e5efe466d9bd - (HEAD -> for-next, palmer/for-next) Merge patch series "RISC-V: Add ACPI support for IOMMU" (2 minutes ago) <Palmer Dabbelt>
    |\
    | * 368ed89f7ac9 - iommu/riscv: Add ACPI support (2 minutes ago) <Sunil V L>
    | * 0d7c16d0df92 - ACPI: scan: Add support for RISC-V in acpi_iommu_configure_id() (2 minutes ago) <Sunil V L>
    | * ea35561bc965 - ACPI: RISC-V: Add support for RIMT (2 minutes ago) <Sunil V L>

it should show up on for-next assuming it builds and such (it's behind 
some fixes, so might take a bit).  Happy to do a tag if someone wants, 
just let me know...

>  12 files changed, 595 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/riscv/Kconfig
>  create mode 100644 drivers/acpi/riscv/rimt.c
>  create mode 100644 include/linux/acpi_rimt.h


