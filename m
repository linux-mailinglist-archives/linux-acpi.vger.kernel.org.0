Return-Path: <linux-acpi+bounces-2388-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E746C811AB5
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839A41F219A0
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Dec 2023 17:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE353E32;
	Wed, 13 Dec 2023 17:18:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B6EAAB;
	Wed, 13 Dec 2023 09:18:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E9621576;
	Wed, 13 Dec 2023 09:19:16 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B3323F762;
	Wed, 13 Dec 2023 09:18:26 -0800 (PST)
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
	Rob Herring <robh@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/7] OF: Simplify DMA range calculations
Date: Wed, 13 Dec 2023 17:17:55 +0000
Message-Id: <368a546e36235bd0008f66838d0c8edcd864ab94.1702486837.git.robin.murphy@arm.com>
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

Juggling start, end, and size values for a range is somewhat redundant
and a little hard to follow. Consolidate down to just using inclusive
start and end, which saves us worrying about size overflows for full
64-bit ranges (note that passing a potentially-overflowed value through
to arch_setup_dma_ops() is benign for all current implementations, and
this is working towards removing that anyway).

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/of/device.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 526a42cdf66e..51062a831970 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -97,7 +97,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 dma_start = 0;
-	u64 mask, end, size = 0;
+	u64 mask, end = 0;
 	bool coherent;
 	int ret;
 
@@ -118,17 +118,15 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 			return ret == -ENODEV ? 0 : ret;
 	} else {
 		const struct bus_dma_region *r = map;
-		u64 dma_end = 0;
 
 		/* Determine the overall bounds of all DMA regions */
 		for (dma_start = ~0; r->size; r++) {
 			/* Take lower and upper limits */
 			if (r->dma_start < dma_start)
 				dma_start = r->dma_start;
-			if (r->dma_start + r->size > dma_end)
-				dma_end = r->dma_start + r->size;
+			if (r->dma_start + r->size > end)
+				end = r->dma_start + r->size;
 		}
-		size = dma_end - dma_start;
 	}
 
 	/*
@@ -142,16 +140,15 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		dev->dma_mask = &dev->coherent_dma_mask;
 	}
 
-	if (!size && dev->coherent_dma_mask)
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
-	else if (!size)
-		size = 1ULL << 32;
+	if (!end && dev->coherent_dma_mask)
+		end = dev->coherent_dma_mask;
+	else if (!end)
+		end = (1ULL << 32) - 1;
 
 	/*
 	 * Limit coherent and dma mask based on size and default mask
 	 * set by the driver.
 	 */
-	end = dma_start + size - 1;
 	mask = DMA_BIT_MASK(ilog2(end) + 1);
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
@@ -177,7 +174,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
-	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
+	arch_setup_dma_ops(dev, dma_start, end - dma_start + 1, iommu, coherent);
 
 	if (!iommu)
 		of_dma_set_restricted_buffer(dev, np);
-- 
2.39.2.101.g768bb238c484.dirty


