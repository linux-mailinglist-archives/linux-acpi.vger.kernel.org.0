Return-Path: <linux-acpi+bounces-10516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C31A094E9
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 16:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433453A663E
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B6F211299;
	Fri, 10 Jan 2025 15:19:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4701211298;
	Fri, 10 Jan 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522363; cv=none; b=jgjBITdXyFOB4rsktx0iaKWZMIHbOlZE1YxnrbrqcISPNaaH9T0b4sf9GAWwdOCknpuRwHoxZm4kB834odChGJofVD9bJy8ZB7IpCvR5N2nKA7E1A2udn1U/W6g39iy8GehZX5XPOV77SlCSbLrsSsKjtKKytgRx05LCbEDu5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522363; c=relaxed/simple;
	bh=V9P0rAFYceLqJqbMQg3EXV6ITYR6hKFKgq6v66Hu9Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAPFR2hLPFDVauy/QOgPHk0dILScNc2jZE6aCBFqDj7tN+/117WA/J/3fx3z0zsTnfNU1Ryg6C8OeonJC7MEJna8RCKKAVkBKUFbSTXcdr/2OcogooD5/4qqjjqNXobp1fommMpIB+LqLPVOr5Y0wHi48HQ/RE8U8/L5HxifreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23297C4CED6;
	Fri, 10 Jan 2025 15:19:23 +0000 (UTC)
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 4/4] cxl: Add mce notifier to emit aliased address for extended linear cache
Date: Fri, 10 Jan 2025 08:17:47 -0700
Message-ID: <20250110151913.3462283-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110151913.3462283-1-dave.jiang@intel.com>
References: <20250110151913.3462283-1-dave.jiang@intel.com>
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
v2:
- Update new EXPORT_SYMOBOL_() input. (Jonathan)
- Remove unnecessary pointer cast. (Jonathan)
- Introduce CONFIG_CXL_MCE to shield from missing CONFIG_MEMORY_FAILURE kbuilds.
- Emit alias address0 (Jonathan)
---
 arch/x86/mm/pat/set_memory.c |  1 +
 drivers/cxl/Kconfig          |  4 +++
 drivers/cxl/core/Makefile    |  1 +
 drivers/cxl/core/mbox.c      |  3 ++
 drivers/cxl/core/mce.c       | 53 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mce.h       | 14 ++++++++++
 drivers/cxl/core/region.c    | 25 +++++++++++++++++
 drivers/cxl/cxl.h            |  6 ++++
 drivers/cxl/cxlmem.h         |  2 ++
 9 files changed, 109 insertions(+)
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
index d7999260f004..4e12f1c17909 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "trace.h"
+#include "mce.h"
 
 static bool cxl_raw_allow_all;
 
@@ -1478,6 +1479,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
+	cxl_register_mce_notifier(&mds->mce_notifier);
+
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
new file mode 100644
index 000000000000..bd1c4f46a67f
--- /dev/null
+++ b/drivers/cxl/core/mce.c
@@ -0,0 +1,53 @@
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
+	spa = mce->addr & MCI_ADDR_PHYSADDR;
+
+	pfn = spa >> PAGE_SHIFT;
+	if (!pfn_valid(pfn))
+		return NOTIFY_DONE;
+
+	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
+	if (!spa_alias)
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
diff --git a/drivers/cxl/core/mce.h b/drivers/cxl/core/mce.h
new file mode 100644
index 000000000000..b3c63bddf14e
--- /dev/null
+++ b/drivers/cxl/core/mce.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
+#ifndef _CXL_CORE_MCE_H_
+#define _CXL_CORE_MCE_H_
+
+#include <linux/notifier.h>
+
+#ifdef CONFIG_CXL_MCE
+void cxl_register_mce_notifier(struct notifier_block *mce_notifer);
+#else
+static inline void cxl_register_mce_notifier(struct notifier_block *mce_notifier) {}
+#endif
+
+#endif
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5d23bd26d9ba..f866ee2fefed 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3449,6 +3449,31 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
 
+u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
+{
+	struct cxl_region_ref *iter;
+	unsigned long index;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	xa_for_each(&endpoint->regions, index, iter) {
+		struct cxl_region_params *p = &iter->region->params;
+
+		if (p->res->start <= spa && spa <= p->res->end) {
+			if (!p->cache_size)
+				return 0;
+
+			if (spa > p->res->start + p->cache_size)
+				return spa - p->cache_size;
+
+			return spa + p->cache_size;
+		}
+	}
+
+	return 0;
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
-- 
2.47.1


