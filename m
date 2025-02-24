Return-Path: <linux-acpi+bounces-11407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA73FA42B27
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 19:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA5D3B86DA
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509692661AC;
	Mon, 24 Feb 2025 18:22:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34236198A38;
	Mon, 24 Feb 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421328; cv=none; b=U85LUDVuQgXrXAta5znyfzGP0mZ9xadP4xOeyRPy94YBjydzMrGDEYD7eV77Wy56NjA74wbfy7i0t8hNbC+fjn1Qq1O8XKirTqbhzLKtMlihdFoWPZ52v9Ta77FKMO4H91+OrNFazrwaPIheQo7Mp1TK+EYngo9MJ4h9+WIfdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421328; c=relaxed/simple;
	bh=oQSPsvzjTz9eS+4jX4P8b5dnwp01ZQmL0Xi1TW/i6AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=US8wcPO91vgyzR8WPlSAjqeh/ihobQwBsnRLajJSt0O4si92xQ4nnz5Gee7YZY0eI/mCP2CT38Vaz34hNkh2eftISuGLVPWVnbTFpzx8uiRIfHLG9WmAQcceHB7y34u/xlDCJs1/j0jU6sjlkTfGw72QXSD0qXCghndWuRHJ0Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D4C4CED6;
	Mon, 24 Feb 2025 18:22:07 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	bp@alien8.de,
	dan.j.williams@intel.com,
	tony.luck@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	ming.li@zohomail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 2/4] acpi/hmat / cxl: Add extended linear cache support for CXL
Date: Mon, 24 Feb 2025 11:21:00 -0700
Message-ID: <20250224182202.1683380-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224182202.1683380-1-dave.jiang@intel.com>
References: <20250224182202.1683380-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current cxl region size only indicates the size of the CXL memory
region without accounting for the extended linear cache size. Retrieve the
cache size from HMAT and append that to the cxl region size for the cxl
region range that matches the SRAT range that has extended linear cache
enabled.

The SRAT defines the whole memory range that includes the extended linear
cache and the CXL memory region. The new HMAT ECN/ECR to the Memory Side
Cache Information Structure defines the size of the extended linear cache
size and matches to the SRAT Memory Affinity Structure by the memory
proxmity domain. Add a helper to match the cxl range to the SRAT memory
range in order to retrieve the cache size.

There are several places that checks the cxl region range against the
decoder range. Use new helper to check between the two ranges and address
the new cache size.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Add adjustment for cxl_dpa_to_hpa() (Alison)
- Add check of adjusted region start against CFMWS. (Alison)
- Update dev_warn() to be more precise. (Alison)
---
 drivers/acpi/numa/hmat.c  | 39 +++++++++++++++++++
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/acpi.c   | 11 ++++++
 drivers/cxl/core/core.h   |  3 ++
 drivers/cxl/core/region.c | 80 ++++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h         |  2 +
 include/linux/acpi.h      | 11 ++++++
 tools/testing/cxl/Kbuild  |  1 +
 8 files changed, 143 insertions(+), 5 deletions(-)
 create mode 100644 drivers/cxl/core/acpi.c

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2630511937f5..9d9052258e92 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -108,6 +108,45 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
 	return NULL;
 }
 
+/**
+ * hmat_get_extended_linear_cache_size - Retrieve the extended linear cache size
+ * @backing_res: resource from the backing media
+ * @nid: node id for the memory region
+ * @cache_size: (Output) size of extended linear cache.
+ *
+ * Return: 0 on success. Errno on failure.
+ *
+ */
+int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
+					resource_size_t *cache_size)
+{
+	unsigned int pxm = node_to_pxm(nid);
+	struct memory_target *target;
+	struct target_cache *tcache;
+	struct resource *res;
+
+	target = find_mem_target(pxm);
+	if (!target)
+		return -ENOENT;
+
+	list_for_each_entry(tcache, &target->caches, node) {
+		if (tcache->cache_attrs.address_mode !=
+				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR)
+			continue;
+
+		res = &target->memregions;
+		if (!resource_contains(res, backing_res))
+			continue;
+
+		*cache_size = tcache->cache_attrs.size;
+		return 0;
+	}
+
+	*cache_size = 0;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, "CXL");
+
 static struct memory_target *acpi_find_genport_target(u32 uid)
 {
 	struct memory_target *target;
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..1a0c9c6ca818 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -14,5 +14,6 @@ cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
+cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
new file mode 100644
index 000000000000..f13b4dae6ac5
--- /dev/null
+++ b/drivers/cxl/core/acpi.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+#include <linux/acpi.h>
+#include "cxl.h"
+#include "core.h"
+
+int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
+					    int nid, resource_size_t *size)
+{
+	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
+}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 800466f96a68..0fb779b612d1 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -115,4 +115,7 @@ bool cxl_need_node_perf_attrs_update(int nid);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
+					    int nid, resource_size_t *size);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e8d11a988fd9..cd7b0c31ebf7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -824,6 +824,21 @@ static int match_free_decoder(struct device *dev, const void *data)
 	return 1;
 }
 
+static bool region_res_match_cxl_range(const struct cxl_region_params *p,
+				       struct range *range)
+{
+	if (!p->res)
+		return false;
+
+	/*
+	 * If an extended linear cache region then the CXL range is assumed
+	 * to be fronted by the DRAM range in current known implementation.
+	 * This assumption will be made until a variant implementation exists.
+	 */
+	return p->res->start + p->cache_size == range->start &&
+		p->res->end == range->end;
+}
+
 static int match_auto_decoder(struct device *dev, const void *data)
 {
 	const struct cxl_region_params *p = data;
@@ -836,7 +851,7 @@ static int match_auto_decoder(struct device *dev, const void *data)
 	cxld = to_cxl_decoder(dev);
 	r = &cxld->hpa_range;
 
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
+	if (region_res_match_cxl_range(p, r))
 		return 1;
 
 	return 0;
@@ -1424,8 +1439,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
-		    cxld->hpa_range.start != p->res->start ||
-		    cxld->hpa_range.end != p->res->end ||
+		    !region_res_match_cxl_range(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
@@ -1951,7 +1965,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
+	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
 	    resource_size(p->res)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
@@ -2921,7 +2935,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
 	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
 
 	/* Apply the hpa_offset to the region base address */
-	hpa = hpa_offset + p->res->start;
+	hpa = hpa_offset + p->res->start + p->cache_size;
 
 	/* Root decoder translation overrides typical modulo decode */
 	if (cxlrd->hpa_to_spa)
@@ -3224,6 +3238,50 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return rc;
 }
 
+static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
+					    struct resource *res)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_region_params *p = &cxlr->params;
+	int nid = phys_to_target_node(res->start);
+	resource_size_t size, cache_size, start;
+	int rc;
+
+	size = resource_size(res);
+	if (!size)
+		return -EINVAL;
+
+	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
+	if (rc)
+		return rc;
+
+	if (!cache_size)
+		return 0;
+
+	if (size != cache_size) {
+		dev_warn(&cxlr->dev, "Extended Linear Cache is not 1:1, unsupported!");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Move the start of the range to where the cache range starts. The
+	 * implementation assumes that the cache range is in front of the
+	 * CXL range. This is not dictated by the HMAT spec but is how the
+	 * current known implementation is configured.
+	 *
+	 * The cache range is expected to be within the CFMWS. The adjusted
+	 * res->start should not be less than cxlrd->res->start.
+	 */
+	start = res->start - cache_size;
+	if (start < cxlrd->res->start)
+		return -ENXIO;
+
+	res->start = start;
+	p->cache_size = cache_size;
+
+	return 0;
+}
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3270,6 +3328,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
+
+	rc = cxl_extended_linear_cache_resize(cxlr, res);
+	if (rc) {
+		/*
+		 * Failing to support extended linear cache region resize does not
+		 * prevent the region from functioning. Only causes cxl list showing
+		 * incorrect region size.
+		 */
+		dev_warn(cxlmd->dev.parent,
+			 "Extended linear cache calculation failed.\n");
+	}
+
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
 		/*
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bbbaa0d0a670..7ee96867ac73 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -493,6 +493,7 @@ enum cxl_config_state {
  * @res: allocated iomem capacity for this region
  * @targets: active ordered targets in current decoder configuration
  * @nr_targets: number of targets
+ * @cache_size: extended linear cache size if exists, otherwise zero.
  *
  * State transitions are protected by the cxl_region_rwsem
  */
@@ -504,6 +505,7 @@ struct cxl_region_params {
 	struct resource *res;
 	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
 	int nr_targets;
+	resource_size_t cache_size;
 };
 
 /*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4e495b29c640..cbd933504dbf 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1095,6 +1095,17 @@ static inline acpi_handle acpi_get_processor_handle(int cpu)
 
 #endif	/* !CONFIG_ACPI */
 
+#ifdef CONFIG_ACPI_HMAT
+int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
+					resource_size_t *size);
+#else
+static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
+						      int nid, resource_size_t *size)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 extern void arch_post_acpi_subsys_init(void);
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..1ae13987a8a2 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -61,6 +61,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
+cxl_core-y += $(CXL_CORE_SRC)/acpi.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
-- 
2.48.1


