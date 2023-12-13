Return-Path: <linux-acpi+bounces-2391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2672F811ABE
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 18:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB239B20F65
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817054BEF;
	Wed, 13 Dec 2023 17:18:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77C6E184;
	Wed, 13 Dec 2023 09:18:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11FC61516;
	Wed, 13 Dec 2023 09:19:29 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 07F9C3F762;
	Wed, 13 Dec 2023 09:18:38 -0800 (PST)
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
	devicetree@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 5/7] iommu/dma: Make limit checks self-contained
Date: Wed, 13 Dec 2023 17:17:58 +0000
Message-Id: <6d1aac26db65bf439f4625986ca76be520774759.1702486837.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1702486837.git.robin.murphy@arm.com>
References: <cover.1702486837.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's now easy to retrieve the device's DMA limits if we want to check
them against the domain aperture, so do that ourselves instead of
relying on them being passed through the callchain.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5dc012220ca9..27a167f4cd3e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -659,19 +659,16 @@ static void iommu_dma_init_options(struct iommu_dma_options *options,
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
- * @base: IOVA at which the mappable address space starts
- * @limit: Last address of the IOVA space
  * @dev: Device the domain is being initialised for
  *
- * @base and @limit + 1 should be exact multiples of IOMMU page granularity to
- * avoid rounding surprises. If necessary, we reserve the page at address 0
+ * If the geometry and dma_range_map include address 0, we reserve that page
  * to ensure it is an invalid IOVA. It is safe to reinitialise a domain, but
  * any change which could make prior IOVAs invalid will fail.
  */
-static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
-				 dma_addr_t limit, struct device *dev)
+static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	const struct bus_dma_region *map = dev->dma_range_map;
 	unsigned long order, base_pfn;
 	struct iova_domain *iovad;
 	int ret;
@@ -683,18 +680,18 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
-	base_pfn = max_t(unsigned long, 1, base >> order);
+	base_pfn = 1;
 
 	/* Check the domain allows at least some access to the device... */
-	if (domain->geometry.force_aperture) {
+	if (map) {
+		dma_addr_t base = dma_range_map_min(map);
 		if (base > domain->geometry.aperture_end ||
-		    limit < domain->geometry.aperture_start) {
+		    dma_range_map_max(map) < domain->geometry.aperture_start) {
 			pr_warn("specified DMA range outside IOMMU capability\n");
 			return -EFAULT;
 		}
 		/* ...then finally give it a kicking to make sure it fits */
-		base_pfn = max_t(unsigned long, base_pfn,
-				domain->geometry.aperture_start >> order);
+		base_pfn = max(base, domain->geometry.aperture_start) >> order;
 	}
 
 	/* start_pfn is always nonzero for an already-initialised domain */
@@ -1743,7 +1740,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
 	 * underlying IOMMU driver needs to support via the dma-iommu layer.
 	 */
 	if (iommu_is_dma_domain(domain)) {
-		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
+		if (iommu_dma_init_domain(domain, dev))
 			goto out_err;
 		dev->dma_ops = &iommu_dma_ops;
 	}
-- 
2.39.2.101.g768bb238c484.dirty


