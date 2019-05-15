Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7471FC79
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 00:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfEOWAT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 May 2019 18:00:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:39649 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfEOWAS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 May 2019 18:00:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 15:00:17 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2019 15:00:16 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Rafael Wysocki <rafael@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 2/2] hmat: Register attributes for memory hot add
Date:   Wed, 15 May 2019 15:54:44 -0600
Message-Id: <20190515215444.22256-2-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190515215444.22256-1-keith.busch@intel.com>
References: <20190515215444.22256-1-keith.busch@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some of the memory nodes described in HMAT may not be online at the
time the hmat subsystem parses their nodes' attributes. Should the node be
set to online later, as can happen when using PMEM as RAM after boot, the
nodes will be missing their initiator links and performance attributes.

Regsiter a memory notifier callback and register the memory attributes
the first time its node is brought online if it wasn't registered.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
v1 -> v2:

  Fixed an unintended __init attribute that generated compiler warnings
  (Brice).

 drivers/acpi/hmat/hmat.c | 75 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index bf23c9a27958..f86fe7130736 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -14,14 +14,18 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/list_sort.h>
+#include <linux/memory.h>
+#include <linux/mutex.h>
 #include <linux/node.h>
 #include <linux/sysfs.h>
 
-static __initdata u8 hmat_revision;
+static u8 hmat_revision;
 
-static __initdata LIST_HEAD(targets);
-static __initdata LIST_HEAD(initiators);
-static __initdata LIST_HEAD(localities);
+static LIST_HEAD(targets);
+static LIST_HEAD(initiators);
+static LIST_HEAD(localities);
+
+static DEFINE_MUTEX(target_lock);
 
 /*
  * The defined enum order is used to prioritize attributes to break ties when
@@ -47,6 +51,8 @@ struct memory_target {
 	unsigned int processor_pxm;
 	struct node_hmem_attrs hmem_attrs;
 	struct list_head caches;
+	struct node_cache_attrs cache_attrs;
+	bool registered;
 };
 
 struct memory_initiator {
@@ -59,7 +65,7 @@ struct memory_locality {
 	struct acpi_hmat_locality *hmat_loc;
 };
 
-static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
+static struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 {
 	struct memory_initiator *initiator;
 
@@ -69,7 +75,7 @@ static __init struct memory_initiator *find_mem_initiator(unsigned int cpu_pxm)
 	return NULL;
 }
 
-static __init struct memory_target *find_mem_target(unsigned int mem_pxm)
+static struct memory_target *find_mem_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
@@ -155,7 +161,7 @@ static __init const char *hmat_data_type_suffix(u8 type)
 	}
 }
 
-static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
+static u32 hmat_normalize(u16 entry, u64 base, u8 type)
 {
 	u32 value;
 
@@ -190,7 +196,7 @@ static __init u32 hmat_normalize(u16 entry, u64 base, u8 type)
 	return value;
 }
 
-static __init void hmat_update_target_access(struct memory_target *target,
+static void hmat_update_target_access(struct memory_target *target,
 					     u8 type, u32 value)
 {
 	switch (type) {
@@ -453,7 +459,7 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
-static __init u32 hmat_initiator_perf(struct memory_target *target,
+static u32 hmat_initiator_perf(struct memory_target *target,
 			       struct memory_initiator *initiator,
 			       struct acpi_hmat_locality *hmat_loc)
 {
@@ -491,7 +497,7 @@ static __init u32 hmat_initiator_perf(struct memory_target *target,
 			      hmat_loc->data_type);
 }
 
-static __init bool hmat_update_best(u8 type, u32 value, u32 *best)
+static bool hmat_update_best(u8 type, u32 value, u32 *best)
 {
 	bool updated = false;
 
@@ -535,7 +541,7 @@ static int initiator_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return ia->processor_pxm - ib->processor_pxm;
 }
 
-static __init void hmat_register_target_initiators(struct memory_target *target)
+static void hmat_register_target_initiators(struct memory_target *target)
 {
 	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
 	struct memory_initiator *initiator;
@@ -595,7 +601,7 @@ static __init void hmat_register_target_initiators(struct memory_target *target)
 	}
 }
 
-static __init void hmat_register_target_cache(struct memory_target *target)
+static void hmat_register_target_cache(struct memory_target *target)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
 	struct target_cache *tcache;
@@ -604,23 +610,28 @@ static __init void hmat_register_target_cache(struct memory_target *target)
 		node_add_cache(mem_nid, &tcache->cache_attrs);
 }
 
-static __init void hmat_register_target_perf(struct memory_target *target)
+static void hmat_register_target_perf(struct memory_target *target)
 {
 	unsigned mem_nid = pxm_to_node(target->memory_pxm);
 	node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
 }
 
-static __init void hmat_register_target(struct memory_target *target)
+static void hmat_register_target(struct memory_target *target)
 {
 	if (!node_online(pxm_to_node(target->memory_pxm)))
 		return;
 
-	hmat_register_target_initiators(target);
-	hmat_register_target_cache(target);
-	hmat_register_target_perf(target);
+	mutex_lock(&target_lock);
+	if (!target->registered) {
+		hmat_register_target_initiators(target);
+		hmat_register_target_cache(target);
+		hmat_register_target_perf(target);
+		target->registered = true;
+	}
+	mutex_unlock(&target_lock);
 }
 
-static __init void hmat_register_targets(void)
+static void hmat_register_targets(void)
 {
 	struct memory_target *target;
 
@@ -628,6 +639,30 @@ static __init void hmat_register_targets(void)
 		hmat_register_target(target);
 }
 
+static int hmat_callback(struct notifier_block *self,
+			 unsigned long action, void *arg)
+{
+	struct memory_target *target;
+	struct memory_notify *mnb = arg;
+	int pxm, nid = mnb->status_change_nid;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_OK;
+
+	pxm = node_to_pxm(nid);
+	target = find_mem_target(pxm);
+	if (!target)
+		return NOTIFY_OK;
+
+	hmat_register_target(target);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block hmat_callback_nb = {
+	.notifier_call = hmat_callback,
+	.priority = 2,
+};
+
 static __init void hmat_free_structures(void)
 {
 	struct memory_target *target, *tnext;
@@ -698,6 +733,10 @@ static __init int hmat_init(void)
 		}
 	}
 	hmat_register_targets();
+
+	/* Keep the table and structures if the notifier may use them */
+	if (!register_hotmemory_notifier(&hmat_callback_nb))
+		return 0;
 out_put:
 	hmat_free_structures();
 	acpi_put_table(tbl);
-- 
2.14.4

