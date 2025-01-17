Return-Path: <linux-acpi+bounces-10746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED01A155C5
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 18:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8FF188D647
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 17:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70648165F01;
	Fri, 17 Jan 2025 17:31:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279719ADA4;
	Fri, 17 Jan 2025 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135063; cv=none; b=elPL1JPJ1vwpHXxKBceIrxY+NR8LiGam+3vnKOXlMjImWsL9diYf05aeftwX+p2jhOwWHvP5G2ziomjib0tQmkbfGS3EKRpeYMk+UMoBbRKti1XakysUcLQG9+dhiFZxs7QxxpxrqnHNXJYJvDDRdYYJ9UCJbvelG4I9XoUpC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135063; c=relaxed/simple;
	bh=6G8oL9vbGzWBSSqUimmHYa7O93kMjLiouJA1EaIvuMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8Q6D0l72cYN1Dyp7ecv0dcHxsVy85OcOYcohFDwUzjwhdhkxuN05xIroOeR7D/2a07KdMsWQeJ7PshSHE8OfL4J6Ywm1om5VFBx6C3eMY3GBMxmMn06SK6PRxArTm2UO4A2i7RHNnxiBEitUoeIal7wy6j5EoYgIV8Bh2Cn5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67F1C4CEDD;
	Fri, 17 Jan 2025 17:31:02 +0000 (UTC)
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
Subject: [PATCH v3 4/4] cxl: Add mce notifier to emit aliased address for extended linear cache
Date: Fri, 17 Jan 2025 10:28:33 -0700
Message-ID: <20250117173054.4147877-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117173054.4147877-1-dave.jiang@intel.com>
References: <20250117173054.4147877-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below is a setup with extended linear cache configuration with an example
layout of memory region shown below presented as a single memory region
consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
The kernel sees a region of total 256G of system memory.

              128G DRAM                          128G CXL memory
|-----------------------------------|-------------------------------------|

Data resides in either DRAM or far memory (FM) with no replication. Hot
data is swapped into DRAM by the hardware behind the scenes. When error is
detected in one location, it is possible that error also resides in the
aliased location. Therefore when a memory location that is flagged by MCE
is part of the special region, the aliased memory location needs to be
offlined as well.

Add an mce notify callback to identify if the MCE address location is part
of an extended linear cache region and handle accordingly.

Added symbol export to set_mce_nospec() in x86 code in order to call
set_mce_nospec() from the CXL MCE notify callback.

Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Add endpoint pointer check. (Ming)
- Add mce notifier removal. (Ming)
- Return ~0ULL for no cache alias.
---
 arch/x86/mm/pat/set_memory.c |  1 +
 drivers/cxl/Kconfig          |  4 +++
 drivers/cxl/core/Makefile    |  1 +
 drivers/cxl/core/mbox.c      |  8 +++++
 drivers/cxl/core/mce.c       | 63 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mce.h       | 16 +++++++++
 drivers/cxl/core/region.c    | 28 ++++++++++++++++
 drivers/cxl/cxl.h            |  6 ++++
 drivers/cxl/cxlmem.h         |  2 ++
 tools/testing/cxl/Kbuild     |  1 +
 10 files changed, 130 insertions(+)
 create mode 100644 drivers/cxl/core/mce.c
 create mode 100644 drivers/cxl/core/mce.h

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 95bc50a8541c..a0df698f46a2 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2083,6 +2083,7 @@ int set_mce_nospec(unsigned long pfn)
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(set_mce_nospec);
 
 /* Restore full speculative operation to the pfn. */
 int clear_mce_nospec(unsigned long pfn)
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 876469e23f7a..d1c91dacae56 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -146,4 +146,8 @@ config CXL_REGION_INVALIDATION_TEST
 	  If unsure, or if this kernel is meant for production environments,
 	  say N.
 
+config CXL_MCE
+	def_bool y
+	depends on X86_MCE && MEMORY_FAILURE
+
 endif
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 1a0c9c6ca818..61c9332b3582 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,3 +17,4 @@ cxl_core-y += cdat.o
 cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_CXL_MCE) += mce.o
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f42c4c56dc43..ad11f49cb117 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "trace.h"
+#include "mce.h"
 
 static bool cxl_raw_allow_all;
 
@@ -1458,6 +1459,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 {
 	struct cxl_memdev_state *mds;
+	int rc;
 
 	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
 	if (!mds) {
@@ -1473,6 +1475,12 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
+	cxl_register_mce_notifier(&mds->mce_notifier);
+	rc = devm_add_action_or_reset(dev, cxl_unregister_mce_notifier,
+				      &mds->mce_notifier);
+	if (rc)
+		return ERR_PTR(rc);
+
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
new file mode 100644
index 000000000000..dab5acce249e
--- /dev/null
+++ b/drivers/cxl/core/mce.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+#include <linux/mm.h>
+#include <linux/notifier.h>
+#include <linux/set_memory.h>
+#include <asm/mce.h>
+#include <cxlmem.h>
+#include "mce.h"
+
+static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
+			  void *data)
+{
+	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
+						    mce_notifier);
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct mce *mce = data;
+	u64 spa, spa_alias;
+	unsigned long pfn;
+
+	if (!mce || !mce_usable_address(mce))
+		return NOTIFY_DONE;
+
+	if (!endpoint)
+		return NOTIFY_DONE;
+
+	spa = mce->addr & MCI_ADDR_PHYSADDR;
+
+	pfn = spa >> PAGE_SHIFT;
+	if (!pfn_valid(pfn))
+		return NOTIFY_DONE;
+
+	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
+	if (spa_alias == ~0ULL)
+		return NOTIFY_DONE;
+
+	pfn = spa_alias >> PAGE_SHIFT;
+
+	/*
+	 * Take down the aliased memory page. The original memory page flagged
+	 * by the MCE will be taken cared of by the standard MCE handler.
+	 */
+	dev_emerg(mds->cxlds.dev, "Offlining aliased SPA address0: %#llx\n",
+		  spa_alias);
+	if (!memory_failure(pfn, 0))
+		set_mce_nospec(pfn);
+
+	return NOTIFY_OK;
+}
+
+void cxl_register_mce_notifier(struct notifier_block *mce_notifier)
+{
+	mce_notifier->notifier_call = cxl_handle_mce;
+	mce_notifier->priority = MCE_PRIO_UC;
+	mce_register_decode_chain(mce_notifier);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_register_mce_notifier, "CXL");
+
+void cxl_unregister_mce_notifier(void *mce_notifier)
+{
+	mce_unregister_decode_chain(mce_notifier);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_unregister_mce_notifier, "CXL");
diff --git a/drivers/cxl/core/mce.h b/drivers/cxl/core/mce.h
new file mode 100644
index 000000000000..b92381f4c1e8
--- /dev/null
+++ b/drivers/cxl/core/mce.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+#ifndef _CXL_CORE_MCE_H_
+#define _CXL_CORE_MCE_H_
+
+#include <linux/notifier.h>
+
+#ifdef CONFIG_CXL_MCE
+void cxl_register_mce_notifier(struct notifier_block *mce_notifer);
+void cxl_unregister_mce_notifier(void *mce_notifer);
+#else
+static inline void cxl_register_mce_notifier(struct notifier_block *mce_notifier) {}
+static inline void cxl_unregister_mce_notifier(void *mce_notifier) {}
+#endif
+
+#endif
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 2d8699a86b24..7a9ea8394876 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3437,6 +3437,34 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
+u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
+{
+	struct cxl_region_ref *iter;
+	unsigned long index;
+
+	if (!endpoint)
+		return ~0ULL;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	xa_for_each(&endpoint->regions, index, iter) {
+		struct cxl_region_params *p = &iter->region->params;
+
+		if (p->res->start <= spa && spa <= p->res->end) {
+			if (!p->cache_size)
+				return ~0ULL;
+
+			if (spa > p->res->start + p->cache_size)
+				return spa - p->cache_size;
+
+			return spa + p->cache_size;
+		}
+	}
+
+	return ~0ULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_port_get_spa_cache_alias, "CXL");
+
 static int is_system_ram(struct resource *res, void *arg)
 {
 	struct cxl_region *cxlr = arg;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6a1fb784f74a..cff98e803722 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -876,6 +876,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -894,6 +895,11 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint,
+					       u64 spa)
+{
+	return 0;
+}
 #endif
 
 void cxl_endpoint_parse_cdat(struct cxl_port *port);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..55752cbf408c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -477,6 +477,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
+ * @mce_notifier: MCE notifier
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -503,6 +504,7 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+	struct notifier_block mce_notifier;
 };
 
 static inline struct cxl_memdev_state *
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 1ae13987a8a2..f625eb2d2dc5 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -64,6 +64,7 @@ cxl_core-y += $(CXL_CORE_SRC)/cdat.o
 cxl_core-y += $(CXL_CORE_SRC)/acpi.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
+cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
 cxl_core-y += config_check.o
 cxl_core-y += cxl_core_test.o
 cxl_core-y += cxl_core_exports.o
-- 
2.47.1


