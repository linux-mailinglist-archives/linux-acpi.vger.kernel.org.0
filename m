Return-Path: <linux-acpi+bounces-8468-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AEA9886FC
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB6DF1C22BC6
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABE315FD16;
	Fri, 27 Sep 2024 14:21:35 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F78E13635C;
	Fri, 27 Sep 2024 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446895; cv=none; b=TOVV/yk0bFeDsgFRn49SXPbgp+PRSsZZB1Bfe2xP1GGK9DazqL9ylVcyIN+B5j8skxcgczvH+n2iDRVAl+YhFXWU4h/t/29svRKVp03Xm4accDFs1Z7rDPMOynQZVxn+SX3OxXRvuNqcojkDjiLeTJzl+DJOpMLOotrLgj5eDw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446895; c=relaxed/simple;
	bh=Tj7g9Qz2+m9XOubxNkSKkbchbcNiJ9Ze8iorf5CIJ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPC0M/TwX27hIoEwOkPQB67dQYAqm+8zHzTHCpJ6hCsFv3C8W7adh+OrZ4NHrTm+2zWJ+VJ23nScmizAD8oovvCAiWeicCt/Xc3/oggJ+FZtRiuWXVldXsRpz0qROSCCiEcX4+WSUV8GjRrPu8AsPrWVEq1CiQNgGe9t/8j7za4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6682C4CEC4;
	Fri, 27 Sep 2024 14:21:33 +0000 (UTC)
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
Subject: [RFC PATCH 6/6] cxl: Add mce notifier to emit aliased address for extended linear cache
Date: Fri, 27 Sep 2024 07:16:58 -0700
Message-ID: <20240927142108.1156362-7-dave.jiang@intel.com>
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

Below is a setup with extended linear cache configuration with an example
layout of of memory region shown below presented as a single memory region
consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
The kernel sees a region of total 256G of system memory.

              128G DRAM                          128G CXL memory
|-----------------------------------|-------------------------------------|

Data resides in either DRAM or far memory (FM) with no replication. Hot data
is swapped into DRAM by the hardware behind the scenes. When error is detected
in one location, it is possible that error also resides in the aliased
location. Therefore when a memory location that is flagged by MCE is part of
the special region, the aliased memory location needs to be offlined as well.

Add an mce notify callback to identify if the MCE address location is part of
an extended linear cache region and handle accordingly.

Added symbol export to set_mce_nospec() in x86 code in order to call
set_mce_nospec() from the CXL MCE notify callback.

Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 arch/x86/include/asm/mce.h   |  1 +
 arch/x86/mm/pat/set_memory.c |  1 +
 drivers/cxl/core/mbox.c      | 45 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c    | 25 ++++++++++++++++++++
 drivers/cxl/cxl.h            |  6 +++++
 drivers/cxl/cxlmem.h         |  2 ++
 6 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3ad29b128943..5da45e870858 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -182,6 +182,7 @@ enum mce_notifier_prios {
 	MCE_PRIO_NFIT,
 	MCE_PRIO_EXTLOG,
 	MCE_PRIO_UC,
+	MCE_PRIO_CXL,
 	MCE_PRIO_EARLY,
 	MCE_PRIO_CEC,
 	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 44f7b2ea6a07..1f85c29e118e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2083,6 +2083,7 @@ int set_mce_nospec(unsigned long pfn)
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(set_mce_nospec);
 
 /* Restore full speculative operation to the pfn. */
 int clear_mce_nospec(unsigned long pfn)
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ac170fd85a1a..4488f30abc64 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,6 +4,9 @@
 #include <linux/debugfs.h>
 #include <linux/ktime.h>
 #include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/set_memory.h>
+#include <asm/mce.h>
 #include <asm/unaligned.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -1444,6 +1447,44 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
 
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
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 {
 	struct cxl_memdev_state *mds;
@@ -1463,6 +1504,10 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
 	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
+	mds->mce_notifier.notifier_call = cxl_handle_mce;
+	mds->mce_notifier.priority = MCE_PRIO_CXL;
+	mce_register_decode_chain(&mds->mce_notifier);
+
 	return mds;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c19bbbf8079d..a60af9763a95 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3420,6 +3420,31 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
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
index d8d715090779..8516f6da620c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -864,6 +864,7 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -882,6 +883,11 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
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
index afb53d058d62..46515d2a49cb 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -470,6 +470,7 @@ struct cxl_dev_state {
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
+ * @mce_notifier: MCE notifier
  * @mbox_wait: RCU wait for mbox send completely
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
@@ -500,6 +501,7 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
+	struct notifier_block mce_notifier;
 
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_memdev_state *mds,
-- 
2.46.1


