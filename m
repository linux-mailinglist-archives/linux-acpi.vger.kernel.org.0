Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62623E2AE6
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 14:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhHFMuW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 08:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343826AbhHFMtI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 08:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628254132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r/SgQo4rPUsW9F0dO56kaeaqlgSVg1Obn3tnWbE8+Ww=;
        b=Mqui/rXxaetL6ydmmkx7YGjeViGHPh4P+6GegmT2sg5D9FqEdy0Ngp9O4KQpv3eju62X/t
        q1nP7m9WfyLiWIRRYVFm4ieN0Rsi9mpJQQN4oHi8G4ZpFh3WdAm1iyQsvTVb/r2hYccN6O
        OkYmHs2qicVjnGZZG8S7MkF0Y3G87QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-nhBixEt3MnqJpJGiX_Bmfg-1; Fri, 06 Aug 2021 08:48:51 -0400
X-MC-Unique: nhBixEt3MnqJpJGiX_Bmfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC6FE107ACF5;
        Fri,  6 Aug 2021 12:48:48 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 021885D6A1;
        Fri,  6 Aug 2021 12:48:42 +0000 (UTC)
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
Subject: [PATCH v3 9/9] mm/memory_hotplug: improved dynamic memory group aware "auto-movable" online policy
Date:   Fri,  6 Aug 2021 14:47:15 +0200
Message-Id: <20210806124715.17090-10-david@redhat.com>
In-Reply-To: <20210806124715.17090-1-david@redhat.com>
References: <20210806124715.17090-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently, the "auto-movable" online policy does not allow for hotplugged
KERNEL (ZONE_NORMAL) memory to increase the amount of MOVABLE memory we can
have, primarily, because there is no coordiantion across memory devices and
we don't want to create zone-imbalances accidentially when unplugging
memory.

However, within a single memory device it's different. Let's allow for
KERNEL memory within a dynamic memory group to allow for more MOVABLE
within the same memory group. The only thing we have to take care of is
that the managing driver avoids zone imbalances by unplugging MOVABLE
memory first, otherwise there can be corner cases where unplug of memory
could result in (accidential) zone imbalances.

virtio-mem is the only user of dynamic memory groups and recently added
support for prioritizing unplug of ZONE_MOVABLE over ZONE_NORMAL, so we
don't need a new toggle to enable it for dynamic memory groups.

We limit this handling to dynamic memory groups, because:

* We want to keep the runtime overhead for collecting stats when onlining
  a single memory block small. We tend to have only a handful of dynamic
  memory groups, but we can have quite some static memory groups (e.g., 256
  DIMMs).
* It doesn't make too much sense for static memory groups, as we try
  onlining all applicable memory blocks either completely to ZONE_MOVABLE
  or not. In ordinary operation, we won't have a mixture of zones
  within a static memory group.

When adding memory to a dynamic memory group, we'll first online memory to
ZONE_MOVABLE as long as early KERNEL memory allows for it. Then, we'll
online the next unit(s) to ZONE_NORMAL, until we can online the next
unit(s) to ZONE_MOVABLE.

For a simple virtio-mem device with a MOVABLE:KERNEL ratio of 3:1, it
will result in a layout like:

  [M][M][M][M][M][M][M][M][N][M][M][M][N][M][M][M]...
  ^ movable memory due to early kernel memory
			   ^ allows for more movable memory ...
			      ^-----^ ... here
				       ^ allows for more movable memory ...
				          ^-----^ ... here

While the created layout is sub-optimal when it comes to contiguous zones,
it gives us the maximum flexibility when dynamically growing/shrinking a
device; we can grow small VMs really big in small steps, and still
shrink reliably to e.g., 1/4 of the maximum VM size in this example,
removing full memory blocks along with meta data more reliably.

Mark dynamic memory groups in the xarray such that we can efficiently
iterate over them when collecting stats. In usual setups, we have one
virtio-mem device per NUMA node, and usually only a small number of NUMA
nodes.

Note: for now, there seems to be no compelling reason to make this
behavior configurable.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 30 +++++++++++++++++++++
 include/linux/memory.h |  3 +++
 mm/memory_hotplug.c    | 60 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b699ddc42693..440fd656c002 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -86,6 +86,7 @@ static DEFINE_XARRAY(memory_blocks);
  * Memory groups, indexed by memory group id (mgid).
  */
 static DEFINE_XARRAY_FLAGS(memory_groups, XA_FLAGS_ALLOC);
+#define MEMORY_GROUP_MARK_DYNAMIC	XA_MARK_1
 
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
@@ -939,6 +940,8 @@ static int memory_group_register(struct memory_group group)
 	if (ret) {
 		kfree(new_group);
 		return ret;
+	} else if (group.is_dynamic) {
+		xa_set_mark(&memory_groups, mgid, MEMORY_GROUP_MARK_DYNAMIC);
 	}
 	return mgid;
 }
@@ -1044,3 +1047,30 @@ struct memory_group *memory_group_find_by_id(int mgid)
 {
 	return xa_load(&memory_groups, mgid);
 }
+
+/*
+ * This is an internal helper only to be used in core memory hotplug code to
+ * walk all dynamic memory groups excluding a given memory group, either
+ * belonging to a specific node, or belonging to any node.
+ */
+int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
+			       struct memory_group *excluded, void *arg)
+{
+	struct memory_group *group;
+	unsigned long index;
+	int ret = 0;
+
+	xa_for_each_marked(&memory_groups, index, group,
+			   MEMORY_GROUP_MARK_DYNAMIC) {
+		if (group == excluded)
+			continue;
+#ifdef CONFIG_NUMA
+		if (nid != NUMA_NO_NODE && group->nid != nid)
+			continue;
+#endif /* CONFIG_NUMA */
+		ret = func(group, arg);
+		if (ret)
+			break;
+	}
+	return ret;
+}
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 6ffdc1db385f..cbcc43ad2b97 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -146,6 +146,9 @@ extern int memory_group_register_static(int nid, unsigned long max_pages);
 extern int memory_group_register_dynamic(int nid, unsigned long unit_pages);
 extern int memory_group_unregister(int mgid);
 struct memory_group *memory_group_find_by_id(int mgid);
+typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
+int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
+			       struct memory_group *excluded, void *arg);
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index fd2edd99f8df..39faf2b56b50 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -752,11 +752,44 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
 #endif /* CONFIG_CMA */
 	}
 }
+struct auto_movable_group_stats {
+	unsigned long movable_pages;
+	unsigned long req_kernel_early_pages;
+};
 
-static bool auto_movable_can_online_movable(int nid, unsigned long nr_pages)
+static int auto_movable_stats_account_group(struct memory_group *group,
+					   void *arg)
+{
+	const int ratio = READ_ONCE(auto_movable_ratio);
+	struct auto_movable_group_stats *stats = arg;
+	long pages;
+
+	/*
+	 * We don't support modifying the config while the auto-movable online
+	 * policy is already enabled. Just avoid the division by zero below.
+	 */
+	if (!ratio)
+		return 0;
+
+	/*
+	 * Calculate how many early kernel pages this group requires to
+	 * satisfy the configured zone ratio.
+	 */
+	pages = group->present_movable_pages * 100 / ratio;
+	pages -= group->present_kernel_pages;
+
+	if (pages > 0)
+		stats->req_kernel_early_pages += pages;
+	stats->movable_pages += group->present_movable_pages;
+	return 0;
+}
+
+static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
+					    unsigned long nr_pages)
 {
-	struct auto_movable_stats stats = {};
 	unsigned long kernel_early_pages, movable_pages;
+	struct auto_movable_group_stats group_stats = {};
+	struct auto_movable_stats stats = {};
 	pg_data_t *pgdat = NODE_DATA(nid);
 	struct zone *zone;
 	int i;
@@ -777,6 +810,21 @@ static bool auto_movable_can_online_movable(int nid, unsigned long nr_pages)
 	kernel_early_pages = stats.kernel_early_pages;
 	movable_pages = stats.movable_pages;
 
+	/*
+	 * Kernel memory inside dynamic memory group allows for more MOVABLE
+	 * memory within the same group. Remove the effect of all but the
+	 * current group from the stats.
+	 */
+	walk_dynamic_memory_groups(nid, auto_movable_stats_account_group,
+				   group, &group_stats);
+	if (kernel_early_pages <= group_stats.req_kernel_early_pages)
+		return false;
+	kernel_early_pages -= group_stats.req_kernel_early_pages;
+	movable_pages -= group_stats.movable_pages;
+
+	if (group && group->is_dynamic)
+		kernel_early_pages += group->present_kernel_pages;
+
 	/*
 	 * Test if we could online the given number of pages to ZONE_MOVABLE
 	 * and still stay in the configured ratio.
@@ -834,6 +882,10 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
  *    with unmovable allocations). While there are corner cases where it might
  *    still work, it is barely relevant in practice.
  *
+ * Exceptions are dynamic memory groups, which allow for more MOVABLE
+ * memory within the same memory group -- because in that case, there is
+ * coordination within the single memory device managed by a single driver.
+ *
  * We rely on "present pages" instead of "managed pages", as the latter is
  * highly unreliable and dynamic in virtualized environments, and does not
  * consider boot time allocations. For example, memory ballooning adjusts the
@@ -899,12 +951,12 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
 	 * nobody interferes, all will be MOVABLE if possible.
 	 */
 	nr_pages = max_pages - online_pages;
-	if (!auto_movable_can_online_movable(NUMA_NO_NODE, nr_pages))
+	if (!auto_movable_can_online_movable(NUMA_NO_NODE, group, nr_pages))
 		goto kernel_zone;
 
 #ifdef CONFIG_NUMA
 	if (auto_movable_numa_aware &&
-	    !auto_movable_can_online_movable(nid, nr_pages))
+	    !auto_movable_can_online_movable(nid, group, nr_pages))
 		goto kernel_zone;
 #endif /* CONFIG_NUMA */
 
-- 
2.31.1

