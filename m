Return-Path: <linux-acpi+bounces-9927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258309E481C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 23:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC332168F97
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Dec 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B01F541A;
	Wed,  4 Dec 2024 22:48:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6BC1C3C13;
	Wed,  4 Dec 2024 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733352519; cv=none; b=YWVQ4bSPDpgn6zS7wI3XMYNAiiD6smhh3EyIGAkq1CPrYAjU+obfYDXFlrYXh2Z7a/mj9slCPVu/oWUt6P7RB/3hk757tk/svHfIUDJyx7zW/6XaZaveNmCvlXB9rbAkCamk87Xg2IpLw7/nNsUXYL58B33i1jyOnDSJmoekJuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733352519; c=relaxed/simple;
	bh=8JV25FIsCR1X3lRp53Lfszu/nhpiLP+gaXgnKxOO0iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utTTj0H+E+7Y1LJPfv1SAQ8/qpcC3th1zs2P0zmso44JGLI+nirggUwchI7Bi7OrGNSf6NtVytH2C+25WRzSkFnrpmSmdCiZn/EGlvhlDvDnHSNBR1qmFy22SND0n8EQGtmuZHToeCLzKCEISF/Cp6U/z5tMJShubUnXUCefXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9151FC4CECD;
	Wed,  4 Dec 2024 22:48:38 +0000 (UTC)
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
Subject: [PATCH 4/4] cxl: Add mce notifier to emit aliased address for extended linear cache
Date: Wed,  4 Dec 2024 15:46:49 -0700
Message-ID: <20241204224827.2097263-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241204224827.2097263-1-dave.jiang@intel.com>
References: <20241204224827.2097263-1-dave.jiang@intel.com>
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
RFC:
- Drop MCE_PRI_CXL and use MCE_PRI_UC (Boris)
---
 arch/x86/mm/pat/set_memory.c |  1 +
 drivers/cxl/core/Makefile    |  1 +
 drivers/cxl/core/mbox.c      |  3 +++
 drivers/cxl/core/mce.c       | 52 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mce.h       | 14 ++++++++++
 drivers/cxl/core/region.c    | 25 +++++++++++++++++
 drivers/cxl/cxl.h            |  6 +++++
 drivers/cxl/cxlmem.h         |  2 ++
 8 files changed, 104 insertions(+)
 create mode 100644 drivers/cxl/core/mce.c
 create mode 100644 drivers/cxl/core/mce.h

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 069e421c2247..c6c07cc4558b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2083,6 +2083,7 @@ int set_mce_nospec(unsigned long pfn)
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(set_mce_nospec);
 
 /* Restore full speculative operation to the pfn. */
 int clear_mce_nospec(unsigned long pfn)
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 1a0c9c6ca818..d619fb11febd 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -17,3 +17,4 @@ cxl_core-y += cdat.o
 cxl_core-y += acpi.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
+cxl_core-$(CONFIG_X86_MCE) += mce.o
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4017b7afa78a..95a5a98feafa 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "trace.h"
+#include "mce.h"
 
 static bool cxl_raw_allow_all;
 
@@ -1474,6 +1475,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
+	cxl_register_mce_notifier(&mds->mce_notifier);
+
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
new file mode 100644
index 000000000000..f983822992a4
--- /dev/null
+++ b/drivers/cxl/core/mce.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
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
+	struct mce *mce = (struct mce *)data;
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
+	dev_emerg(mds->cxlds.dev, "Offlining aliased SPA address: %#llx\n",
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
index 000000000000..1d747618bbc0
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
+#ifdef CONFIG_X86_MCE
+void cxl_register_mce_notifier(struct notifier_block *mce_notifer);
+#else
+static inline void cxl_register_mce_notifier(struct notifier_block *mce_notifier) {}
+#endif
+
+#endif
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8bf4efb2c48c..b279148ec3ff 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3435,6 +3435,31 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
 
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
+EXPORT_SYMBOL_NS_GPL(cxl_port_get_spa_cache_alias, CXL);
+
 static int is_system_ram(struct resource *res, void *arg)
 {
 	struct cxl_region *cxlr = arg;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 61df87a31e02..7e22d8d0221a 100644
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
2.47.0


