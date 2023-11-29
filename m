Return-Path: <linux-acpi+bounces-1923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E807FDF63
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 19:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67E92830D3
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 18:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBE3D0AA
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D39F4;
	Wed, 29 Nov 2023 09:43:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BBFBC15;
	Wed, 29 Nov 2023 09:44:03 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81BF13F73F;
	Wed, 29 Nov 2023 09:43:12 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH 0/7] dma-mapping: Clean up arch_setup_dma_ops()
Date: Wed, 29 Nov 2023 17:42:57 +0000
Message-Id: <cover.1701268753.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Prompted by Jason's proposal[1], here's a first step towards truly
unpicking the dma_configure vs. IOMMU mess. As I commented before, we
have an awful lot of accumulated cruft and technical debt here making
things more complicated than they need to be, and we already have hacks
on top of hacks trying to work around it, so polishing those hacks even
further is really not a desirable direction of travel. And I do know
they're hacks, because I wrote most of them and still remember enough of
the context of the time ;)

I'm taking a methodical bottom-up approach here, so step 1 is cleaning
*all* the out-of-date stuff from arch_setup_dma_ops() and simplifying
that interface, which gets it right out of the way for the next step of
pulling apart {of,acpi}_dma_configure(). This part is really a
dma-mapping series, but I'm not sure yet if would need to target the
IOMMU tree - nothing here should strictly depend on the pending IOMMU
change, but the follow-up patches might. Still working on those, so
hopefully I'll know soon...

Thanks,
Robin.

[1] https://lore.kernel.org/linux-iommu/0-v1-720585788a7d+811b-iommu_fwspec_p1_jgg@nvidia.com/


Robin Murphy (7):
  OF: Retire dma-ranges mask workaround
  OF: Simplify DMA range calculations
  ACPI/IORT: Handle memory address size limits as limits
  dma-mapping: Add helpers for dma_range_map bounds
  iommu/dma: Make limit checks self-contained
  iommu/dma: Centralise iommu_setup_dma_ops()
  dma-mapping: Simplify arch_setup_dma_ops()

 arch/arc/mm/dma.c               |  3 +--
 arch/arm/mm/dma-mapping-nommu.c |  3 +--
 arch/arm/mm/dma-mapping.c       | 12 ++++++----
 arch/arm64/mm/dma-mapping.c     |  5 +---
 arch/loongarch/kernel/dma.c     |  9 ++-----
 arch/mips/mm/dma-noncoherent.c  |  3 +--
 arch/riscv/mm/dma-noncoherent.c |  3 +--
 drivers/acpi/arm64/dma.c        | 17 ++++---------
 drivers/acpi/arm64/iort.c       | 18 +++++++-------
 drivers/acpi/scan.c             |  3 +--
 drivers/hv/hv_common.c          |  6 +----
 drivers/iommu/amd/iommu.c       |  8 -------
 drivers/iommu/dma-iommu.c       | 35 ++++++++++-----------------
 drivers/iommu/dma-iommu.h       |  6 +++++
 drivers/iommu/intel/iommu.c     |  7 ------
 drivers/iommu/iommu.c           |  2 ++
 drivers/iommu/s390-iommu.c      |  6 -----
 drivers/iommu/virtio-iommu.c    | 10 --------
 drivers/of/device.c             | 42 ++++++---------------------------
 include/linux/acpi_iort.h       |  4 ++--
 include/linux/dma-direct.h      | 18 ++++++++++++++
 include/linux/dma-map-ops.h     |  6 ++---
 include/linux/iommu.h           |  7 ------
 23 files changed, 78 insertions(+), 155 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


