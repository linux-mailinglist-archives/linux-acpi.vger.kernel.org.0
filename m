Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBED139E7EE
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhFGT6O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:58:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhFGT6H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623095775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXilTFrZi86NxOlc4RQYwf6Nqu4Zwwi2cog1GH5xiTs=;
        b=JNWtmCvM5NhF48/70r5+CZ5sFIBxr3mBtYysi75Z2ucQV/217/TtpFHyFil4ssQfFU6Noi
        IxzwkZmbTPeOFPUEffg4fwwAbYyaUV40WBulgE5i8MoX5I6R4PTjE/3Of6Wc6a8jHrjjDX
        X7TUpw4TkS2N5GEcxSd1DyoRlUmatBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-pPmNchjyNhKsKSJ4J5ndAQ-1; Mon, 07 Jun 2021 15:56:12 -0400
X-MC-Unique: pPmNchjyNhKsKSJ4J5ndAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EC3E10074A8;
        Mon,  7 Jun 2021 19:56:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8376210013C1;
        Mon,  7 Jun 2021 19:56:05 +0000 (UTC)
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
Subject: [PATCH v1 12/12] mm/memory_hotplug: improved dynamic memory group aware "auto-movable" online policy
Date:   Mon,  7 Jun 2021 21:54:30 +0200
Message-Id: <20210607195430.48228-13-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 drivers/base/memory.c  | 25 ++++++++++++++++++
 include/linux/memory.h |  3 +++
 mm/memory_hotplug.c    | 60 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index ae70d4005fe2..b826cf96ffcd 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -86,6 +86,7 @@ static DEFINE_XARRAY(memory_blocks);
  * Memory groups, indexed by memory group identification (mgid).
  */
 static DEFINE_XARRAY_FLAGS(memory_groups, XA_FLAGS_ALLOC);
+#define MEMORY_GROUP_MARK_DYNAMIC	XA_MARK_1
 
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
@@ -931,6 +932,8 @@ static int register_memory_group(struct memory_group group)
 		       GFP_KERNEL);
 	if (ret)
 		kfree(new_group);
+	else if (group.is_dynamic)
+		xa_set_mark(&memory_groups, mgid, MEMORY_GROUP_MARK_DYNAMIC);
 	return ret ? ret : mgid;
 }
 
@@ -987,3 +990,25 @@ struct memory_group *get_memory_group(int mgid)
 {
 	return xa_load(&memory_groups, mgid);
 }
+
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
index 0eceb8467d9a..c56260853caf 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -142,6 +142,9 @@ extern int register_static_memory_group(int nid, unsigned long max_pages);
 extern int register_dynamic_memory_group(int nid, unsigned long unit_pages);
 extern int unregister_memory_group(int mgid);
 struct memory_group *get_memory_group(int mgid);
+typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
+int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
+			       struct memory_group *excluded, void *arg);
 
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 5a3ad9cb48a3..61bff8f3bfb1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -876,11 +876,44 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
 		stats->kernel_early_pages -= zone->cma_pages;
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
+	 * mode is already enabled. Just avoid the division by zero below.
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
@@ -901,6 +934,21 @@ static bool auto_movable_can_online_movable(int nid, unsigned long nr_pages)
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
@@ -958,6 +1006,10 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
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
@@ -1023,12 +1075,12 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
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

