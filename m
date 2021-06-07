Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48CE39E7DD
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhFGT5e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21308 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231612AbhFGT5c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623095740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IKc/SqFtxV9V4C8mV49o0QGyi88/PNUdP7DzNiYq3kU=;
        b=awi3HOQlxVbeW6wjvBQNWssplz+nGLtU9YRzwcNTlr8gERvsmvCFb62bJBFIREKI68Svta
        Ja6gRkAsRA2H3lUiA+TdB9EACuiU4XxroRPaj/I5NT2KnSjzhvZUnZXzmSuO9AN+3A9y50
        ETtM5xrciO0LtKn4GcPayFzRf/4z9sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-r-RDHRl0MkqIwY02cuZ0sQ-1; Mon, 07 Jun 2021 15:55:38 -0400
X-MC-Unique: r-RDHRl0MkqIwY02cuZ0sQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A04119253C5;
        Mon,  7 Jun 2021 19:55:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8976110013C1;
        Mon,  7 Jun 2021 19:55:31 +0000 (UTC)
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
Subject: [PATCH v1 07/12] mm/memory_hotplug: track present pages in memory groups
Date:   Mon,  7 Jun 2021 21:54:25 +0200
Message-Id: <20210607195430.48228-8-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Let's track all present pages in each memory group. Especially, track
memory present in ZONE_MOVABLE and memory present in one of the kernel
zones (which really only is ZONE_NORMAL right now as memory groups only
apply to hotplugged memory) separate;y within a memory group, to prepare
for making smart auto-online decision for individualmemory blocks within a
memory group based on group statistics.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 10 +++++-----
 include/linux/memory.h         |  4 ++++
 include/linux/memory_hotplug.h | 13 +++++++++----
 mm/memory_hotplug.c            | 19 ++++++++++++++-----
 4 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 00c58a6632a6..d8ea448e5fb8 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -198,7 +198,7 @@ static int memory_block_online(struct memory_block *mem)
 	}
 
 	ret = online_pages(start_pfn + nr_vmemmap_pages,
-			   nr_pages - nr_vmemmap_pages, zone);
+			   nr_pages - nr_vmemmap_pages, zone, mem->group);
 	if (ret) {
 		if (nr_vmemmap_pages)
 			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
@@ -210,7 +210,7 @@ static int memory_block_online(struct memory_block *mem)
 	 * now already properly populated.
 	 */
 	if (nr_vmemmap_pages)
-		adjust_present_page_count(pfn_to_page(start_pfn),
+		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  nr_vmemmap_pages);
 
 	return ret;
@@ -228,16 +228,16 @@ static int memory_block_offline(struct memory_block *mem)
 	 * can properly be torn down in offline_pages().
 	 */
 	if (nr_vmemmap_pages)
-		adjust_present_page_count(pfn_to_page(start_pfn),
+		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  -nr_vmemmap_pages);
 
 	ret = offline_pages(start_pfn + nr_vmemmap_pages,
-			    nr_pages - nr_vmemmap_pages);
+			    nr_pages - nr_vmemmap_pages, mem->group);
 	if (ret) {
 		/* offline_pages() failed. Account back. */
 		if (nr_vmemmap_pages)
 			adjust_present_page_count(pfn_to_page(start_pfn),
-						  nr_vmemmap_pages);
+						  mem->group, nr_vmemmap_pages);
 		return ret;
 	}
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 6e20a6174fe5..0eceb8467d9a 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -28,6 +28,10 @@ struct memory_group {
 	int nid;
 	/* References from memory blocks + 1. */
 	refcount_t refcount;
+	/* Present (online) memory outside ZONE_MOVABLE of this memory group. */
+	unsigned long present_kernel_pages;
+	/* Present (online) memory in ZONE_MOVABLE of this memory group. */
+	unsigned long present_movable_pages;
 	/*
 	 * Memory group type: static vs. dynamic.
 	 *
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 5c910dc2526a..f607d6677873 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -12,6 +12,7 @@ struct zone;
 struct pglist_data;
 struct mem_section;
 struct memory_block;
+struct memory_group;
 struct resource;
 struct vmem_altmap;
 
@@ -111,13 +112,15 @@ static inline void zone_seqlock_init(struct zone *zone)
 extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
-extern void adjust_present_page_count(struct page *page, long nr_pages);
+extern void adjust_present_page_count(struct page *page,
+				      struct memory_group *group,
+				      long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 				     struct zone *zone);
 extern void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
-			struct zone *zone);
+			struct zone *zone, struct memory_group *group);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 					 unsigned long end_pfn);
 extern void __offline_isolated_pages(unsigned long start_pfn,
@@ -322,7 +325,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
 extern void try_offline_node(int nid);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
+extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			 struct memory_group *group);
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
 extern int offline_and_remove_memory(u64 start, u64 size);
@@ -330,7 +334,8 @@ extern int offline_and_remove_memory(u64 start, u64 size);
 #else
 static inline void try_offline_node(int nid) {}
 
-static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+				struct memory_group *group)
 {
 	return -EINVAL;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4e039c82e7b6..5dacb0ed2997 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1039,9 +1039,11 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
  * This function should only be called by memory_block_{online,offline},
  * and {online,offline}_pages.
  */
-void adjust_present_page_count(struct page *page, long nr_pages)
+void adjust_present_page_count(struct page *page, struct memory_group *group,
+			       long nr_pages)
 {
 	struct zone *zone = page_zone(page);
+	const bool movable = zone_idx(zone) == ZONE_MOVABLE;
 	unsigned long flags;
 
 	/*
@@ -1054,6 +1056,11 @@ void adjust_present_page_count(struct page *page, long nr_pages)
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages += nr_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
+
+	if (group && movable)
+		group->present_movable_pages += nr_pages;
+	else if (group && !movable)
+		group->present_kernel_pages += nr_pages;
 }
 
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
@@ -1099,7 +1106,8 @@ void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages)
 	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 }
 
-int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *zone)
+int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
+		       struct zone *zone, struct memory_group *group)
 {
 	unsigned long flags;
 	int need_zonelists_rebuild = 0;
@@ -1152,7 +1160,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	}
 
 	online_pages_range(pfn, nr_pages);
-	adjust_present_page_count(pfn_to_page(pfn), nr_pages);
+	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
@@ -1896,7 +1904,8 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
-int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			struct memory_group *group)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn, system_ram_pages = 0;
@@ -2032,7 +2041,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-	adjust_present_page_count(pfn_to_page(start_pfn), -nr_pages);
+	adjust_present_page_count(pfn_to_page(start_pfn), group, -nr_pages);
 
 	init_per_zone_wmark_min();
 
-- 
2.31.1

