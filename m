Return-Path: <linux-acpi+bounces-1820-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C44CE7F7E8D
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 19:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7D62820F1
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2433E9
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ADB819AD;
	Fri, 24 Nov 2023 10:10:09 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CC141007;
	Fri, 24 Nov 2023 10:10:55 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 800793F73F;
	Fri, 24 Nov 2023 10:10:07 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de
Cc: rafael@kernel.org,
	lenb@kernel.org,
	robh+dt@kernel.org,
	frowand.list@gmail.com,
	m.szyprowski@samsung.com,
	james.quinlan@broadcom.com,
	iommu@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma-mapping: Don't store redundant offsets
Date: Fri, 24 Nov 2023 18:10:03 +0000
Message-Id: <94e0cec15546ef2be61d90869e499e40e2a55308.1700849106.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bus_dma_region necessarily stores both CPU and DMA base addresses for
a range, so there's no need to also store the difference between them.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c        |  1 -
 drivers/of/address.c       |  1 -
 include/linux/dma-direct.h | 19 ++++++++++++-------
 kernel/dma/direct.c        |  1 -
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 026130b37967..c72155606550 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1532,7 +1532,6 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 			r->cpu_start = rentry->res->start;
 			r->dma_start = rentry->res->start - rentry->offset;
 			r->size = resource_size(rentry->res);
-			r->offset = rentry->offset;
 			r++;
 		}
 	}
diff --git a/drivers/of/address.c b/drivers/of/address.c
index b59956310f66..ae46a3605904 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -955,7 +955,6 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
 		r->cpu_start = range.cpu_addr;
 		r->dma_start = range.bus_addr;
 		r->size = range.size;
-		r->offset = range.cpu_addr - range.bus_addr;
 		r++;
 	}
 out:
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 18aade195884..3eb3589ff43e 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -21,7 +21,6 @@ struct bus_dma_region {
 	phys_addr_t	cpu_start;
 	dma_addr_t	dma_start;
 	u64		size;
-	u64		offset;
 };
 
 static inline dma_addr_t translate_phys_to_dma(struct device *dev,
@@ -29,9 +28,12 @@ static inline dma_addr_t translate_phys_to_dma(struct device *dev,
 {
 	const struct bus_dma_region *m;
 
-	for (m = dev->dma_range_map; m->size; m++)
-		if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
-			return (dma_addr_t)paddr - m->offset;
+	for (m = dev->dma_range_map; m->size; m++) {
+		u64 offset = paddr - m->cpu_start;
+
+		if (paddr >= m->cpu_start && offset < m->size)
+			return m->dma_start + offset;
+	}
 
 	/* make sure dma_capable fails when no translation is available */
 	return DMA_MAPPING_ERROR;
@@ -42,9 +44,12 @@ static inline phys_addr_t translate_dma_to_phys(struct device *dev,
 {
 	const struct bus_dma_region *m;
 
-	for (m = dev->dma_range_map; m->size; m++)
-		if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
-			return (phys_addr_t)dma_addr + m->offset;
+	for (m = dev->dma_range_map; m->size; m++) {
+		u64 offset = dma_addr - m->dma_start;
+
+		if (dma_addr >= m->dma_start && offset < m->size)
+			return m->cpu_start + offset;
+	}
 
 	return (phys_addr_t)-1;
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 73c95815789a..98b2e192fd69 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -677,7 +677,6 @@ int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 		return -ENOMEM;
 	map[0].cpu_start = cpu_start;
 	map[0].dma_start = dma_start;
-	map[0].offset = offset;
 	map[0].size = size;
 	dev->dma_range_map = map;
 	return 0;
-- 
2.39.2.101.g768bb238c484.dirty


