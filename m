Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839F539E7D8
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhFGT53 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231582AbhFGT50 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:57:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623095734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+4paKvG6GrNLwTw/zPYhocAQ6n+M9UGJdGP/M6kJg4=;
        b=OifDbZqfpf2VGwyEibLxmzkdmOHgmmH1nAROmaN2DH3SkZwWr+XTOgvFoK+xpAN2pF7VyC
        JUBIgs/5V39UwdN3t4MRB2/B1A/rnfOso/CkxRnZ45uuzj12bUnR3+CuPT2oFqdP9s5Jwa
        hty+CnDrNid0Rk0kwNvYdn6nHR6pRfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-a3uJRSwFNpiiVXo8BS2GAA-1; Mon, 07 Jun 2021 15:55:33 -0400
X-MC-Unique: a3uJRSwFNpiiVXo8BS2GAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4060210074C0;
        Mon,  7 Jun 2021 19:55:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BE8310013C1;
        Mon,  7 Jun 2021 19:55:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v1 06/12] drivers/base/memory: "memory groups" to logically group memory blocks
Date:   Mon,  7 Jun 2021 21:54:24 +0200
Message-Id: <20210607195430.48228-7-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In our "auto-movable" memory onlining policy, we want to make decisions
across memory blocks of a single memory device. Examples of memory devices
include ACPI memory devices (in the simplest case a single DIMM) a
virtio-mem. For now, we don't have a connection between a single memory
block device and the real memory device. Each memory device consists of
1..X memory block devices.

Let's logically group memory blocks belonging to the same memory device
in "memory groups". Memory groups can span multiple physical ranges and a
memory group itself does not contain any information regarding physical
ranges, only properties (e.g., "max_pages") necessary for improved memory
onlining.

Introduce two memory group types:

1) Static memory group: E.g., a single ACPI memory device, consisting of
   1..X memory resources. A memory group consists of 1..Y memory blocks.
   The whole group is added/removed in one go. If any part cannot get
   offlined, the whole group cannot be removed.

2) Dynamic memory group: E.g., a single virtio-mem device. Memory is
   dynamically added/removed in a fixed granularity, called a "unit",
   consisting of 1..X memory blocks. A unit is added/removed in one go.
   If any part of a unit cannot get offlined, the whole unit cannot be
   removed.

In case of 1) we usually want either all memory managed by ZONE_MOVABLE
or none. In case of 2) we usually want to have as many units as possible
managed by ZONE_MOVABLE. We want a single unit to be of the same type.

For now, memory groups are an internal concept that is not exposed to
user space; we might want to change that in the future, though.

add_memory() users can specify a mgid instead of a nid when passing
the MHP_NID_IS_MGID flag.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 102 +++++++++++++++++++++++++++++++--
 include/linux/memory.h         |  46 ++++++++++++++-
 include/linux/memory_hotplug.h |   6 +-
 mm/memory_hotplug.c            |  11 +++-
 4 files changed, 158 insertions(+), 7 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 427323620ce8..00c58a6632a6 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -82,6 +82,11 @@ static struct bus_type memory_subsys = {
  */
 static DEFINE_XARRAY(memory_blocks);
 
+/*
+ * Memory groups, indexed by memory group identification (mgid).
+ */
+static DEFINE_XARRAY_FLAGS(memory_groups, XA_FLAGS_ALLOC);
+
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
 int register_memory_notifier(struct notifier_block *nb)
@@ -634,7 +639,8 @@ int register_memory(struct memory_block *memory)
 }
 
 static int init_memory_block(unsigned long block_id, unsigned long state,
-			     unsigned long nr_vmemmap_pages)
+			     unsigned long nr_vmemmap_pages,
+			     struct memory_group *group)
 {
 	struct memory_block *mem;
 	int ret = 0;
@@ -653,6 +659,11 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
 	mem->nid = NUMA_NO_NODE;
 	mem->nr_vmemmap_pages = nr_vmemmap_pages;
 
+	if (group) {
+		mem->group = group;
+		refcount_inc(&group->refcount);
+	}
+
 	ret = register_memory(mem);
 
 	return ret;
@@ -671,7 +682,7 @@ static int add_memory_block(unsigned long base_section_nr)
 	if (section_count == 0)
 		return 0;
 	return init_memory_block(memory_block_id(base_section_nr),
-				 MEM_ONLINE, 0);
+				 MEM_ONLINE, 0,  NULL);
 }
 
 static void unregister_memory(struct memory_block *memory)
@@ -681,6 +692,11 @@ static void unregister_memory(struct memory_block *memory)
 
 	WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
 
+	if (memory->group) {
+		refcount_dec(&memory->group->refcount);
+		memory->group = NULL;
+	}
+
 	/* drop the ref. we got via find_memory_block() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
@@ -694,7 +710,8 @@ static void unregister_memory(struct memory_block *memory)
  * Called under device_hotplug_lock.
  */
 int create_memory_block_devices(unsigned long start, unsigned long size,
-				unsigned long vmemmap_pages)
+				unsigned long vmemmap_pages,
+				struct memory_group *group)
 {
 	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
 	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
@@ -707,7 +724,8 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 		return -EINVAL;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages);
+		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages,
+					group);
 		if (ret)
 			break;
 	}
@@ -891,3 +909,79 @@ int for_each_memory_block(void *arg, walk_memory_blocks_func_t func)
 	return bus_for_each_dev(&memory_subsys, NULL, &cb_data,
 				for_each_memory_block_cb);
 }
+
+static int register_memory_group(struct memory_group group)
+{
+	struct memory_group *new_group;
+	uint32_t mgid;
+	int ret;
+
+	if (!node_possible(group.nid))
+		return -EINVAL;
+
+	new_group = kzalloc(sizeof(group), GFP_KERNEL);
+	if (!new_group)
+		return -ENOMEM;
+	*new_group = group;
+	refcount_set(&new_group->refcount, 1);
+
+	ret = xa_alloc(&memory_groups, &mgid, new_group, xa_limit_31b,
+		       GFP_KERNEL);
+	if (ret)
+		kfree(new_group);
+	return ret ? ret : mgid;
+}
+
+int register_static_memory_group(int nid, unsigned long max_pages)
+{
+	struct memory_group group = {
+		.nid = nid,
+		.s = {
+			.max_pages = max_pages,
+		},
+	};
+
+	if (!max_pages)
+		return -EINVAL;
+	return register_memory_group(group);
+}
+EXPORT_SYMBOL_GPL(register_static_memory_group);
+
+int register_dynamic_memory_group(int nid, unsigned long unit_pages)
+{
+	struct memory_group group = {
+		.nid = nid,
+		.is_dynamic = true,
+		.d = {
+			.unit_pages = unit_pages,
+		},
+	};
+
+	if (!unit_pages || !is_power_of_2(unit_pages) ||
+	    unit_pages < PHYS_PFN(memory_block_size_bytes()))
+		return -EINVAL;
+	return register_memory_group(group);
+}
+EXPORT_SYMBOL_GPL(register_dynamic_memory_group);
+
+int unregister_memory_group(int mgid)
+{
+	struct memory_group *group;
+
+	if (mgid < 0)
+		return -EINVAL;
+
+	group = xa_load(&memory_groups, mgid);
+	if (!group || refcount_read(&group->refcount) > 1)
+		return -EINVAL;
+
+	xa_erase(&memory_groups, mgid);
+	kfree(group);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(unregister_memory_group);
+
+struct memory_group *get_memory_group(int mgid)
+{
+	return xa_load(&memory_groups, mgid);
+}
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 97e92e8b556a..6e20a6174fe5 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -23,6 +23,42 @@
 
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
+struct memory_group {
+	/* Nid the whole group belongs to. */
+	int nid;
+	/* References from memory blocks + 1. */
+	refcount_t refcount;
+	/*
+	 * Memory group type: static vs. dynamic.
+	 *
+	 * Static: All memory in the group belongs to a single unit, such as,
+	 * a DIMM. All memory belonging to the group will be added in
+	 * one go and removed in one go -- it's static.
+	 *
+	 * Dynamic: Memory within the group is added/removed dynamically in
+	 * units of the specified granularity of at least one memory block.
+	 */
+	bool is_dynamic;
+
+	union {
+		struct {
+			/*
+			 * Maximum number of pages we'll have in this static
+			 * memory group.
+			 */
+			unsigned long max_pages;
+		} s;
+		struct {
+			/*
+			 * Unit in pages in which memory is added/removed in
+			 * this dynamic memory group. This granularity defines
+			 * the alignment of a unit in physical address space.
+			 */
+			unsigned long unit_pages;
+		} d;
+	};
+};
+
 struct memory_block {
 	unsigned long start_section_nr;
 	unsigned long state;		/* serialized by the dev->lock */
@@ -34,6 +70,7 @@ struct memory_block {
 	 * lay at the beginning of the memory block.
 	 */
 	unsigned long nr_vmemmap_pages;
+	struct memory_group *group;	/* group (if any) for this block */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
@@ -86,7 +123,8 @@ static inline int memory_notify(unsigned long val, void *v)
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
 int create_memory_block_devices(unsigned long start, unsigned long size,
-				unsigned long vmemmap_pages);
+				unsigned long vmemmap_pages,
+				struct memory_group *group);
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
@@ -95,6 +133,12 @@ typedef int (*walk_memory_blocks_func_t)(struct memory_block *, void *);
 extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
 extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func);
+
+extern int register_static_memory_group(int nid, unsigned long max_pages);
+extern int register_dynamic_memory_group(int nid, unsigned long unit_pages);
+extern int unregister_memory_group(int mgid);
+struct memory_group *get_memory_group(int mgid);
+
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 84f05435e2ae..5c910dc2526a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -54,7 +54,6 @@ typedef int __bitwise mhp_t;
  * might be stale, or the resource might have changed.
  */
 #define MHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
-
 /*
  * We want memmap (struct page array) to be self contained.
  * To do so, we will use the beginning of the hot-added range to build
@@ -62,6 +61,11 @@ typedef int __bitwise mhp_t;
  * Only selected architectures support it with SPARSE_VMEMMAP.
  */
 #define MHP_MEMMAP_ON_MEMORY   ((__force mhp_t)BIT(1))
+/*
+ * The nid field specifies a memory group identifier (mgid) instead. The memory
+ * group implies the nid.
+ */
+#define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9cae42636f3e..4e039c82e7b6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1384,6 +1384,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
 	struct vmem_altmap mhp_altmap = {};
+	struct memory_group *group = NULL;
 	u64 start, size;
 	bool new_node = false;
 	int ret;
@@ -1395,6 +1396,13 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	if (ret)
 		return ret;
 
+	if (mhp_flags & MHP_NID_IS_MGID) {
+		group = get_memory_group(nid);
+		if (!group)
+			return -EINVAL;
+		nid = group->nid;
+	}
+
 	if (!node_possible(nid)) {
 		WARN(1, "node %d was absent from the node_possible_map\n", nid);
 		return -EINVAL;
@@ -1429,7 +1437,8 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		goto error;
 
 	/* create memory block devices after memory was added */
-	ret = create_memory_block_devices(start, size, mhp_altmap.alloc);
+	ret = create_memory_block_devices(start, size, mhp_altmap.alloc,
+					  group);
 	if (ret) {
 		arch_remove_memory(start, size, NULL);
 		goto error;
-- 
2.31.1

