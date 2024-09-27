Return-Path: <linux-acpi+bounces-8465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F89886F5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59946281E41
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0091482F2;
	Fri, 27 Sep 2024 14:21:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBEA143C41;
	Fri, 27 Sep 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446889; cv=none; b=CiHYHlHerNvSzKGxGFcdFZ8HA40nKekP9XnBIgSsSnWoLMToBDtR0hX83wyvPbRmhSKe8ySmDCxdTEvDPN6QfpXbL5YBhOigyNStQwJsda9ioYwBqAvZMBtlHnIQqWNdogCAltZO+sApPL/YIDLlT+656CgKbZiAkG3At3Xxf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446889; c=relaxed/simple;
	bh=JR+boErfx6HXPEBQqZPJG07E0KCfZi2RTSJxp/+ITcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXj2durZR/SI9JxPMQM4gw29DjQeX/Jsb+qqS8R+EFcN8Kr+v0QD/KhLPEKbvqMK0c9GUA+a1sZFsg0HPZF1Gkv2CtOG2CA1i8HEdYE5ePfKYpTsQ/1jhRnZYQxNTclgn+SibJBYoHey/yZzIxuFOKmTDjXTgU/IpXLsbQ545IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF93C4CEC4;
	Fri, 27 Sep 2024 14:21:29 +0000 (UTC)
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
	ira.weiny@intel.com
Subject: [RFC PATCH 3/6] acpi/hmat / cxl: Add extended linear cache support for CXL
Date: Fri, 27 Sep 2024 07:16:55 -0700
Message-ID: <20240927142108.1156362-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927142108.1156362-1-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current cxl region size only indicates the size of the CXL memory region
without accounting for the extended linear cache size. Retrieve the cache
size from HMAT and append that to the cxl region size for the cxl region
range that matches the SRAT range that has extended linear cache enabled.

The SRAT defines the whole memory range that inclues the extended linear
cache and the CXL memory region. The new HMAT update to the Memory Side
Cache Information Structure defines the size of the extended linear cache
size and matches to the SRAT Memory Affinity Structure by the memory proxmity
domain. Add a helper to match the cxl range to the SRAT memory range in order
to retrieve the cache size.

There are several places that checks the cxl region range against the
decoder range. Use new helper to check between the two ranges and address
the new cache size.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c  | 44 +++++++++++++++++++++++++++++++++
 drivers/cxl/core/Makefile |  1 +
 drivers/cxl/core/acpi.c   | 11 +++++++++
 drivers/cxl/core/core.h   |  3 +++
 drivers/cxl/core/region.c | 51 ++++++++++++++++++++++++++++++++++++---
 drivers/cxl/cxl.h         |  2 ++
 include/linux/acpi.h      |  8 ++++++
 tools/testing/cxl/Kbuild  |  1 +
 8 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 drivers/cxl/core/acpi.c

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 39524f36be5b..d299f8d7af8c 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -108,6 +108,50 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
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
+	bool cache_found = false;
+	struct resource *res;
+
+	target = find_mem_target(pxm);
+	if (!target)
+		return -ENOENT;
+
+	list_for_each_entry(tcache, &target->caches, node) {
+		if (tcache->cache_attrs.mode == NODE_CACHE_MODE_EXTENDED_LINEAR) {
+			cache_found = true;
+			break;
+		}
+	}
+
+	if (!cache_found) {
+		*cache_size = 0;
+		return 0;
+	}
+
+	res = &target->memregions;
+	if (!resource_contains(res, backing_res))
+		return -ENOENT;
+
+	*cache_size = tcache->cache_attrs.size;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
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
index 72a506c9dbd0..dd586c76c773 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -108,4 +108,7 @@ int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
 				       enum access_coordinate_class access);
 bool cxl_need_node_perf_attrs_update(int nid);
 
+int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
+					    int nid, resource_size_t *size);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 21ad5f242875..ddfb1e1a8909 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -816,6 +816,17 @@ static int match_free_decoder(struct device *dev, void *data)
 	return 0;
 }
 
+static bool region_res_match_range(struct cxl_region_params *p,
+				   struct range *range)
+{
+	if (p->res &&
+	    p->res->start + p->cache_size == range->start &&
+	    p->res->end == range->end)
+		return true;
+
+	return false;
+}
+
 static int match_auto_decoder(struct device *dev, void *data)
 {
 	struct cxl_region_params *p = data;
@@ -828,7 +839,7 @@ static int match_auto_decoder(struct device *dev, void *data)
 	cxld = to_cxl_decoder(dev);
 	r = &cxld->hpa_range;
 
-	if (p->res && p->res->start == r->start && p->res->end == r->end)
+	if (region_res_match_range(p, r))
 		return 1;
 
 	return 0;
@@ -1406,8 +1417,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
 		    cxld->interleave_granularity != ig ||
-		    cxld->hpa_range.start != p->res->start ||
-		    cxld->hpa_range.end != p->res->end ||
+		    !region_res_match_range(p, &cxld->hpa_range) ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
@@ -1931,7 +1941,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
+	if (resource_size(cxled->dpa_res) * p->interleave_ways + p->cache_size !=
 	    resource_size(p->res)) {
 		dev_dbg(&cxlr->dev,
 			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
@@ -3226,6 +3236,34 @@ static int match_region_by_range(struct device *dev, void *data)
 	return rc;
 }
 
+static int cxl_extended_linear_cache_resize(struct cxl_region_params *p,
+					    struct resource *res)
+{
+	int nid = phys_to_target_node(res->start);
+	resource_size_t size, cache_size;
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
+	if (size != cache_size)
+		return -EINVAL;
+
+	res->start -= cache_size;
+	p->cache_size = cache_size;
+
+	return 0;
+}
+
+
 /* Establish an empty region covering the given HPA range */
 static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 					   struct cxl_endpoint_decoder *cxled)
@@ -3272,6 +3310,11 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
 				    dev_name(&cxlr->dev));
+
+	rc = cxl_extended_linear_cache_resize(p, res);
+	if (rc)
+		goto err;
+
 	rc = insert_resource(cxlrd->res, res);
 	if (rc) {
 		/*
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9afb407d438f..d8d715090779 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -483,6 +483,7 @@ enum cxl_config_state {
  * @res: allocated iomem capacity for this region
  * @targets: active ordered targets in current decoder configuration
  * @nr_targets: number of targets
+ * @cache_size: extended linear cache size, if exists
  *
  * State transitions are protected by the cxl_region_rwsem
  */
@@ -494,6 +495,7 @@ struct cxl_region_params {
 	struct resource *res;
 	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
 	int nr_targets;
+	resource_size_t cache_size;
 };
 
 /*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0687a442fec7..8ed72d431dca 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -435,12 +435,20 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 
 #ifdef CONFIG_ACPI_HMAT
 int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
+int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
+					resource_size_t *size);
 #else
 static inline int acpi_get_genport_coordinates(u32 uid,
 					       struct access_coordinate *coord)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
+						      int nid, resource_size_t *size)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_ACPI_NUMA
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 3d1ca9e38b1f..c687ef56717d 100644
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
2.46.1


