Return-Path: <linux-acpi+bounces-2390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123D5811ABC
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 18:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BA1B2112E
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 17:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019A54BDC;
	Wed, 13 Dec 2023 17:18:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2090EF2;
	Wed, 13 Dec 2023 09:18:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3B33C15;
	Wed, 13 Dec 2023 09:19:24 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BA2223F762;
	Wed, 13 Dec 2023 09:18:34 -0800 (PST)
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
Subject: [PATCH v2 4/7] dma-mapping: Add helpers for dma_range_map bounds
Date: Wed, 13 Dec 2023 17:17:57 +0000
Message-Id: <16d3e9100cd4a4a397641df963f416cc7f70cc4c.1702486837.git.robin.murphy@arm.com>
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

Several places want to compute the lower and/or upper bounds of a
dma_range_map, so let's factor that out into reusable helpers.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: fix warning for 32-bit builds
---
 arch/loongarch/kernel/dma.c |  9 ++-------
 drivers/acpi/arm64/dma.c    |  8 +-------
 drivers/of/device.c         | 11 ++---------
 include/linux/dma-direct.h  | 18 ++++++++++++++++++
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/kernel/dma.c b/arch/loongarch/kernel/dma.c
index 7a9c6a9dd2d0..429555fb4e13 100644
--- a/arch/loongarch/kernel/dma.c
+++ b/arch/loongarch/kernel/dma.c
@@ -8,17 +8,12 @@
 void acpi_arch_dma_setup(struct device *dev)
 {
 	int ret;
-	u64 mask, end = 0;
+	u64 mask, end;
 	const struct bus_dma_region *map = NULL;
 
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
-		const struct bus_dma_region *r = map;
-
-		for (end = 0; r->size; r++) {
-			if (r->dma_start + r->size - 1 > end)
-				end = r->dma_start + r->size - 1;
-		}
+		end = dma_range_map_max(map);
 
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
 		dev->bus_dma_limit = end;
diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
index b98a149f8d50..52b2abf88689 100644
--- a/drivers/acpi/arm64/dma.c
+++ b/drivers/acpi/arm64/dma.c
@@ -28,13 +28,7 @@ void acpi_arch_dma_setup(struct device *dev)
 
 	ret = acpi_dma_get_range(dev, &map);
 	if (!ret && map) {
-		const struct bus_dma_region *r = map;
-
-		for (end = 0; r->size; r++) {
-			if (r->dma_start + r->size - 1 > end)
-				end = r->dma_start + r->size - 1;
-		}
-
+		end = dma_range_map_max(map);
 		dev->dma_range_map = map;
 	}
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 51062a831970..66879edb4a61 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -117,16 +117,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		if (!force_dma)
 			return ret == -ENODEV ? 0 : ret;
 	} else {
-		const struct bus_dma_region *r = map;
-
 		/* Determine the overall bounds of all DMA regions */
-		for (dma_start = ~0; r->size; r++) {
-			/* Take lower and upper limits */
-			if (r->dma_start < dma_start)
-				dma_start = r->dma_start;
-			if (r->dma_start + r->size > end)
-				end = r->dma_start + r->size;
-		}
+		dma_start = dma_range_map_min(map);
+		end = dma_range_map_max(map);
 	}
 
 	/*
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 3eb3589ff43e..edbe13d00776 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -54,6 +54,24 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
 	return (phys_addr_t)-1;
 }
 
+static inline dma_addr_t dma_range_map_min(const struct bus_dma_region *map)
+{
+	dma_addr_t ret = (dma_addr_t)U64_MAX;
+
+	for (; map->size; map++)
+		ret = min(ret, map->dma_start);
+	return ret;
+}
+
+static inline dma_addr_t dma_range_map_max(const struct bus_dma_region *map)
+{
+	dma_addr_t ret = 0;
+
+	for (; map->size; map++)
+		ret = max(ret, map->dma_start + map->size - 1);
+	return ret;
+}
+
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #ifndef phys_to_dma_unencrypted
-- 
2.39.2.101.g768bb238c484.dirty


