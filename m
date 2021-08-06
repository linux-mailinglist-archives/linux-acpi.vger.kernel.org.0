Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763833E2ACD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbhHFMsO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 08:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343778AbhHFMsN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 08:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628254077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ssewax4zJA7aV04SKuSOfzxrliSI9lIe6KRxzUbBY5k=;
        b=EUO5G/yAUdDuK2zz7yQ9NjgYJKStm/PPD+s67j2o8QP3BxiUATRDXWPYJLbNXnM0JrIDS0
        20MBFPsmG48m71RXVwX0zW1jYijOxJV5LTjOWerro74hYYpseMhOCIuB2ZCKn8OnguLaoW
        abRplrkCLk0ZlUwRqPGhbseNdjaDmPs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-o5fIhKXUMlq8YmP3bRXvog-1; Fri, 06 Aug 2021 08:47:56 -0400
X-MC-Unique: o5fIhKXUMlq8YmP3bRXvog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A68BD94DC1;
        Fri,  6 Aug 2021 12:47:53 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2D05D6A1;
        Fri,  6 Aug 2021 12:47:44 +0000 (UTC)
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v3 3/9] drivers/base/memory: introduce "memory groups" to logically group memory blocks
Date:   Fri,  6 Aug 2021 14:47:09 +0200
Message-Id: <20210806124715.17090-4-david@redhat.com>
In-Reply-To: <20210806124715.17090-1-david@redhat.com>
References: <20210806124715.17090-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In our "auto-movable" memory onlining policy, we want to make decisions
across memory blocks of a single memory device. Examples of memory devices
include ACPI memory devices (in the simplest case a single DIMM) and
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
 drivers/base/memory.c          | 159 ++++++++++++++++++++++++++++++++-
 include/linux/memory.h         |  46 +++++++++-
 include/linux/memory_hotplug.h |   5 ++
 mm/memory_hotplug.c            |  11 ++-
 4 files changed, 215 insertions(+), 6 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 86ec2dc82fc2..16f5a3610229 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -82,6 +82,11 @@ static struct bus_type memory_subsys = {
  */
 static DEFINE_XARRAY(memory_blocks);
 
+/*
+ * Memory groups, indexed by memory group id (mgid).
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
@@ -652,6 +658,12 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
 	mem->state = state;
 	mem->nid = NUMA_NO_NODE;
 	mem->nr_vmemmap_pages = nr_vmemmap_pages;
+	INIT_LIST_HEAD(&mem->group_next);
+
+	if (group) {
+		mem->group = group;
+		list_add(&mem->group_next, &group->memory_blocks);
+	}
 
 	ret = register_memory(mem);
 
@@ -671,7 +683,7 @@ static int add_memory_block(unsigned long base_section_nr)
 	if (section_count == 0)
 		return 0;
 	return init_memory_block(memory_block_id(base_section_nr),
-				 MEM_ONLINE, 0);
+				 MEM_ONLINE, 0,  NULL);
 }
 
 static void unregister_memory(struct memory_block *memory)
@@ -681,6 +693,11 @@ static void unregister_memory(struct memory_block *memory)
 
 	WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
 
+	if (memory->group) {
+		list_del(&memory->group_next);
+		memory->group = NULL;
+	}
+
 	/* drop the ref. we got via find_memory_block() */
 	put_device(&memory->dev);
 	device_unregister(&memory->dev);
@@ -694,7 +711,8 @@ static void unregister_memory(struct memory_block *memory)
  * Called under device_hotplug_lock.
  */
 int create_memory_block_devices(unsigned long start, unsigned long size,
-				unsigned long vmemmap_pages)
+				unsigned long vmemmap_pages,
+				struct memory_group *group)
 {
 	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
 	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
@@ -707,7 +725,8 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
 		return -EINVAL;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages);
+		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages,
+					group);
 		if (ret)
 			break;
 	}
@@ -891,3 +910,135 @@ int for_each_memory_block(void *arg, walk_memory_blocks_func_t func)
 	return bus_for_each_dev(&memory_subsys, NULL, &cb_data,
 				for_each_memory_block_cb);
 }
+
+/*
+ * This is an internal helper to unify allocation and initialization of
+ * memory groups. Note that the passed memory group will be copied to a
+ * dynamically allocated memory group. After this call, the passed
+ * memory group should no longer be used.
+ */
+static int memory_group_register(struct memory_group group)
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
+	INIT_LIST_HEAD(&new_group->memory_blocks);
+
+	ret = xa_alloc(&memory_groups, &mgid, new_group, xa_limit_31b,
+		       GFP_KERNEL);
+	if (ret) {
+		kfree(new_group);
+		return ret;
+	}
+	return mgid;
+}
+
+/**
+ * memory_group_register_static() - Register a static memory group.
+ * @nid: The node id.
+ * @max_pages: The maximum number of pages we'll have in this static memory
+ *	       group.
+ *
+ * Register a new static memory group and return the memory group id.
+ * All memory in the group belongs to a single unit, such as a DIMM. All
+ * memory belonging to a static memory group is added in one go to be removed
+ * in one go -- it's static.
+ *
+ * Returns an error if out of memory, if the node id is invalid, if no new
+ * memory groups can be registered, or if max_pages is invalid (0). Otherwise,
+ * returns the new memory group id.
+ */
+int memory_group_register_static(int nid, unsigned long max_pages)
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
+	return memory_group_register(group);
+}
+EXPORT_SYMBOL_GPL(memory_group_register_static);
+
+/**
+ * memory_group_register_dynamic() - Register a dynamic memory group.
+ * @nid: The node id.
+ * @unit_pages: Unit in pages in which is memory added/removed in this dynamic
+ *		memory group.
+ *
+ * Register a new dynamic memory group and return the memory group id.
+ * Memory within a dynamic memory group is added/removed dynamically
+ * in unit_pages.
+ *
+ * Returns an error if out of memory, if the node id is invalid, if no new
+ * memory groups can be registered, or if unit_pages is invalid (0, not a
+ * power of two, smaller than a single memory block). Otherwise, returns the
+ * new memory group id.
+ */
+int memory_group_register_dynamic(int nid, unsigned long unit_pages)
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
+	return memory_group_register(group);
+}
+EXPORT_SYMBOL_GPL(memory_group_register_dynamic);
+
+/**
+ * memory_group_unregister() - Unregister a memory group.
+ * @mgid: the memory group id
+ *
+ * Unregister a memory group. If any memory block still belongs to this
+ * memory group, unregistering will fail.
+ *
+ * Returns -EINVAL if the memory group id is invalid, returns -EBUSY if some
+ * memory blocks still belong to this memory group and returns 0 if
+ * unregistering succeeded.
+ */
+int memory_group_unregister(int mgid)
+{
+	struct memory_group *group;
+
+	if (mgid < 0)
+		return -EINVAL;
+
+	group = xa_load(&memory_groups, mgid);
+	if (!group)
+		return -EINVAL;
+	if (!list_empty(&group->memory_blocks))
+		return -EBUSY;
+	xa_erase(&memory_groups, mgid);
+	kfree(group);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(memory_group_unregister);
+
+/*
+ * This is an internal helper only to be used in core memory hotplug code to
+ * lookup a memory group. We don't care about locking, as we don't expect a
+ * memory group to get unregistered while adding memory to it -- because
+ * the group and the memory is managed by the same driver.
+ */
+struct memory_group *memory_group_find_by_id(int mgid)
+{
+	return xa_load(&memory_groups, mgid);
+}
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 97e92e8b556a..d505c12c5c77 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -23,6 +23,42 @@
 
 #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
 
+/**
+ * struct memory_group - a logical group of memory blocks
+ * @nid: The node id for all memory blocks inside the memory group.
+ * @blocks: List of all memory blocks belonging to this memory group.
+ * @is_dynamic: The memory group type: static vs. dynamic
+ * @s.max_pages: Valid with &memory_group.is_dynamic == false. The maximum
+ *		 number of pages we'll have in this static memory group.
+ * @d.unit_pages: Valid with &memory_group.is_dynamic == true. Unit in pages
+ *		  in which memory is added/removed in this dynamic memory group.
+ *		  This granularity defines the alignment of a unit in physical
+ *		  address space; it has to be at least as big as a single
+ *		  memory block.
+ *
+ * A memory group logically groups memory blocks; each memory block
+ * belongs to at most one memory group. A memory group corresponds to
+ * a memory device, such as a DIMM or a NUMA node, which spans multiple
+ * memory blocks and might even span multiple non-contiguous physical memory
+ * ranges.
+ *
+ * Modification of members after registration is serialized by memory
+ * hot(un)plug code.
+ */
+struct memory_group {
+	int nid;
+	struct list_head memory_blocks;
+	bool is_dynamic;
+	union {
+		struct {
+			unsigned long max_pages;
+		} s;
+		struct {
+			unsigned long unit_pages;
+		} d;
+	};
+};
+
 struct memory_block {
 	unsigned long start_section_nr;
 	unsigned long state;		/* serialized by the dev->lock */
@@ -34,6 +70,8 @@ struct memory_block {
 	 * lay at the beginning of the memory block.
 	 */
 	unsigned long nr_vmemmap_pages;
+	struct memory_group *group;	/* group (if any) for this block */
+	struct list_head group_next;	/* next block inside memory group */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
@@ -86,7 +124,8 @@ static inline int memory_notify(unsigned long val, void *v)
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
 int create_memory_block_devices(unsigned long start, unsigned long size,
-				unsigned long vmemmap_pages);
+				unsigned long vmemmap_pages,
+				struct memory_group *group);
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
@@ -96,6 +135,11 @@ extern int walk_memory_blocks(unsigned long start, unsigned long size,
 			      void *arg, walk_memory_blocks_func_t func);
 extern int for_each_memory_block(void *arg, walk_memory_blocks_func_t func);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
+
+extern int memory_group_register_static(int nid, unsigned long max_pages);
+extern int memory_group_register_dynamic(int nid, unsigned long unit_pages);
+extern int memory_group_unregister(int mgid);
+struct memory_group *memory_group_find_by_id(int mgid);
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 39b04e99a30e..5d341978b4bc 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -50,6 +50,11 @@ typedef int __bitwise mhp_t;
  * Only selected architectures support it with SPARSE_VMEMMAP.
  */
 #define MHP_MEMMAP_ON_MEMORY   ((__force mhp_t)BIT(1))
+/*
+ * The nid field specifies a memory group id (mgid) instead. The memory group
+ * implies the node id (nid).
+ */
+#define MHP_NID_IS_MGID		((__force mhp_t)BIT(2))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a67207d4340..f7017d8eb576 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1258,6 +1258,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
 	struct vmem_altmap mhp_altmap = {};
+	struct memory_group *group = NULL;
 	u64 start, size;
 	bool new_node = false;
 	int ret;
@@ -1269,6 +1270,13 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	if (ret)
 		return ret;
 
+	if (mhp_flags & MHP_NID_IS_MGID) {
+		group = memory_group_find_by_id(nid);
+		if (!group)
+			return -EINVAL;
+		nid = group->nid;
+	}
+
 	if (!node_possible(nid)) {
 		WARN(1, "node %d was absent from the node_possible_map\n", nid);
 		return -EINVAL;
@@ -1303,7 +1311,8 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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

