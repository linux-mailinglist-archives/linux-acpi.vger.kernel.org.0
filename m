Return-Path: <linux-acpi+bounces-6663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ADB91B6BE
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 08:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78F91F21516
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Jun 2024 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9F4DA0E;
	Fri, 28 Jun 2024 06:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ozNmNKLx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E94CE04
	for <linux-acpi@vger.kernel.org>; Fri, 28 Jun 2024 06:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554986; cv=none; b=h0JeOiSbFe1Fg7yUmm18NT+TeJeVWptlrd4Hkyy9bbhSkVM08wRmlIyDs09Jw3pnPlMaLbw6KFGNdIHzlnLWKFqkgYf+Ju7+gq8t//6B7Lx7AvDBi4AVH6NWvmvyPIq9tGTHnmPPEkd3eVgtx8hYS3QIoYuB/4fOHH70SeHyJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554986; c=relaxed/simple;
	bh=rJbP0H6zcyNnEPT7nMCo+39TVYBfeqvk4CvyUuvHmhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PJAmT8Vw9xZ6z4ZcwVNw2GaT/uHQK05uQNmcwe/tOukO0999iHCfjyP3m/qVBbPEZ1txyi11OVILdAv2WX/+ao55v2k2tsIr+v671VmX7hIn0wrHxPBNOm0yCxCOtCcaRccMxZt22XCZe2gBHmEENQFXUfD3iLxP913EfDC8CYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ozNmNKLx; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jonathan.cameron@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719554982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/wXQWGav/NessrnFMRHKMQL87wUrpOC9eqQBIItt68=;
	b=ozNmNKLx7zHsfjGoKtTomX6lQR3xt4PbhMXFd8+/mQLV7/CTmKoDozleczUMPTB7/2URCA
	bJoZ4hvC8inLmZOIMrtIoltwu3L3JUXgkNLZaOV5fWa5q8EAkQizAhl00ojXGtM0CK/tnT
	KnuB2zFDjyF2eMZLo9Y6cbO0VB3/Eo0=
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: gourry.memverge@gmail.com
X-Envelope-To: aneesh.kumar@linux.ibm.com
X-Envelope-To: mhocko@suse.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: john@jagalactic.com
X-Envelope-To: emirakhur@micron.com
X-Envelope-To: vtavarespetr@micron.com
X-Envelope-To: ravis.opensrc@micron.com
X-Envelope-To: apopple@nvidia.com
X-Envelope-To: sthanneeru@micron.com
X-Envelope-To: sj@kernel.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: lenb@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: dave.jiang@intel.com
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: horen.chuang@linux.dev
X-Envelope-To: linux-acpi@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: horenc@vt.edu
X-Envelope-To: horenchuang@bytedance.com
X-Envelope-To: horenchuang@gmail.com
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: qemu-devel@nongnu.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
To: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	"Gregory Price" <gourry.memverge@gmail.com>,
	aneesh.kumar@linux.ibm.com,
	mhocko@suse.com,
	tj@kernel.org,
	john@jagalactic.com,
	"Eishan Mirakhur" <emirakhur@micron.com>,
	"Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,
	"Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
	"Alistair Popple" <apopple@nvidia.com>,
	"Srinivasulu Thanneeru" <sthanneeru@micron.com>,
	"SeongJae Park" <sj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
	"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
	"Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
	linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] memory tier: consolidate the initialization of memory tiers
Date: Fri, 28 Jun 2024 06:09:23 +0000
Message-Id: <20240628060925.303309-2-horen.chuang@linux.dev>
In-Reply-To: <20240628060925.303309-1-horen.chuang@linux.dev>
References: <20240628060925.303309-1-horen.chuang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If we simply move the set_node_memory_tier() from memory_tier_init()
to late_initcall(), it will result in HMAT not registering
the mt_adistance_algorithm callback function, because
set_node_memory_tier() is not performed during the memory tiering
initialization phase, leading to a lack of correct default_dram
information.

Therefore, we introduced a nodemask to pass the information of the
default DRAM nodes. The reason for not choosing to reuse
default_dram_type->nodes is that it is not clean enough. So in the end,
we use a __initdata variable, which is a variable that is released once
initialization is complete, including both CPU and memory nodes for HMAT
to iterate through.

Besides, since default_dram_type may be checked/used during the
initialization process of HMAT and drivers, it is better to keep the
allocation of default_dram_type in memory_tier_init().

Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/numa/hmat.c     |  5 +--
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            | 59 +++++++++++++++---------------------
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 2c8ccc91ebe6..a2f9e7a4b479 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -940,10 +940,7 @@ static int hmat_set_default_dram_perf(void)
 	struct memory_target *target;
 	struct access_coordinate *attrs;
 
-	if (!default_dram_type)
-		return -EIO;
-
-	for_each_node_mask(nid, default_dram_type->nodes) {
+	for_each_node_mask(nid, default_dram_nodes) {
 		pxm = node_to_pxm(nid);
 		target = find_mem_target(pxm);
 		if (!target)
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0d70788558f4..fa61ad9c4d75 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -38,6 +38,7 @@ struct access_coordinate;
 #ifdef CONFIG_NUMA
 extern bool numa_demotion_enabled;
 extern struct memory_dev_type *default_dram_type;
+extern nodemask_t default_dram_nodes __initdata;
 struct memory_dev_type *alloc_memory_type(int adistance);
 void put_memory_type(struct memory_dev_type *memtype);
 void init_node_memory_type(int node, struct memory_dev_type *default_type);
@@ -76,6 +77,7 @@ static inline bool node_is_toptier(int node)
 
 #define numa_demotion_enabled	false
 #define default_dram_type	NULL
+#define default_dram_nodes NODE_MASK_NONE
 /*
  * CONFIG_NUMA implementation returns non NULL error.
  */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 6632102bd5c9..a19a90c3ad36 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -43,6 +43,7 @@ static LIST_HEAD(memory_tiers);
 static LIST_HEAD(default_memory_types);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 struct memory_dev_type *default_dram_type;
+nodemask_t default_dram_nodes __initdata = NODE_MASK_NONE;
 
 static const struct bus_type memory_tier_subsys = {
 	.name = "memory_tiering",
@@ -671,28 +672,38 @@ EXPORT_SYMBOL_GPL(mt_put_memory_types);
 
 /*
  * This is invoked via `late_initcall()` to initialize memory tiers for
- * CPU-less memory nodes after driver initialization, which is
- * expected to provide `adistance` algorithms.
+ * memory nodes, both with and without CPUs. After the initialization of
+ * firmware and devices, adistance algorithms are expected to be provided.
  */
 static int __init memory_tier_late_init(void)
 {
 	int nid;
+	struct memory_tier *memtier;
 
+	get_online_mems();
 	guard(mutex)(&memory_tier_lock);
+	/*
+	 * Look at all the existing and uninitialized N_MEMORY nodes and
+	 * add them to default memory tier or to a tier if we already have
+	 * memory types assigned.
+	 */
 	for_each_node_state(nid, N_MEMORY) {
 		/*
-		 * Some device drivers may have initialized memory tiers
-		 * between `memory_tier_init()` and `memory_tier_late_init()`,
-		 * potentially bringing online memory nodes and
-		 * configuring memory tiers. Exclude them here.
+		 * Some device drivers may have initialized
+		 * memory tiers, potentially bringing memory nodes
+		 * online and configuring memory tiers.
+		 * Exclude them here.
 		 */
 		if (node_memory_types[nid].memtype)
 			continue;
 
-		set_node_memory_tier(nid);
+		memtier = set_node_memory_tier(nid);
+		if (IS_ERR(memtier))
+			/* Continue with memtiers we are able to setup. */
+			break;
 	}
-
 	establish_demotion_targets();
+	put_online_mems();
 
 	return 0;
 }
@@ -875,8 +886,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 
 static int __init memory_tier_init(void)
 {
-	int ret, node;
-	struct memory_tier *memtier;
+	int ret;
 
 	ret = subsys_virtual_register(&memory_tier_subsys, NULL);
 	if (ret)
@@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
 				GFP_KERNEL);
 	WARN_ON(!node_demotion);
 #endif
-	mutex_lock(&memory_tier_lock);
+
+	guard(mutex)(&memory_tier_lock);
 	/*
 	 * For now we can have 4 faster memory tiers with smaller adistance
 	 * than default DRAM tier.
@@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
 	if (IS_ERR(default_dram_type))
 		panic("%s() failed to allocate default DRAM tier\n", __func__);
 
-	/*
-	 * Look at all the existing N_MEMORY nodes and add them to
-	 * default memory tier or to a tier if we already have memory
-	 * types assigned.
-	 */
-	for_each_node_state(node, N_MEMORY) {
-		if (!node_state(node, N_CPU))
-			/*
-			 * Defer memory tier initialization on
-			 * CPUless numa nodes. These will be initialized
-			 * after firmware and devices are initialized.
-			 */
-			continue;
-
-		memtier = set_node_memory_tier(node);
-		if (IS_ERR(memtier))
-			/*
-			 * Continue with memtiers we are able to setup
-			 */
-			break;
-	}
-	establish_demotion_targets();
-	mutex_unlock(&memory_tier_lock);
+	/* Record nodes with memory and CPU to set default DRAM performance. */
+	nodes_and(default_dram_nodes, node_states[N_MEMORY],
+		  node_states[N_CPU]);
 
 	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
 	return 0;
-- 
Ho-Ren (Jack) Chuang


