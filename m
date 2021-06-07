Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F9139E7C8
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFGT4r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230351AbhFGT4r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623095695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wn5HEanvq6cV+H/hmppNuHJLR2f/Vr4t/qqBD5o0Vjg=;
        b=MH7bOO8P2Txe0N/pUilhNmAB6WIxXkfa9Aull0q/mv48EfIIc7u3Iu3NTBlCddByQOrRRs
        GeI6uAZAhSRlZ2DkxdhEwqJGnphGgYRkyTsVRmX2lTdiHuX5/lAfCARLHL9ezVfARGA/T6
        FpgT+eeiU9y7ym2A4X20PjzJ03G41uI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-bo-VIC_BPUq9gnm3JgGUOw-1; Mon, 07 Jun 2021 15:54:54 -0400
X-MC-Unique: bo-VIC_BPUq9gnm3JgGUOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDB73FE4;
        Mon,  7 Jun 2021 19:54:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D856A10013C1;
        Mon,  7 Jun 2021 19:54:47 +0000 (UTC)
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
Subject: [PATCH v1 02/12] mm: track present early pages per zone
Date:   Mon,  7 Jun 2021 21:54:20 +0200
Message-Id: <20210607195430.48228-3-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

For implementing a new memory onlining policy, which determines when to
online memory blocks to ZONE_MOVABLE semi-automatically, we need the number
of present early (boot) pages -- present pages excluding hotplugged pages.
Let's track these pages per zone.

Pass a page instead of the zone to adjust_present_page_count(), similar
as adjust_managed_page_count() and derive the zone from the page.

It's worth noting that a memory block to be offlined/onlined is either
completely "early" or "not early". add_memory() and friends can only add
complete memory blocks and we only online/offline complete (individual)
memory blocks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 14 +++++++-------
 include/linux/memory_hotplug.h |  2 +-
 include/linux/mmzone.h         |  7 +++++++
 mm/memory_hotplug.c            | 13 ++++++++++---
 mm/page_alloc.c                |  3 +++
 5 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d5ffaab3cb61..427323620ce8 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -205,7 +205,8 @@ static int memory_block_online(struct memory_block *mem)
 	 * now already properly populated.
 	 */
 	if (nr_vmemmap_pages)
-		adjust_present_page_count(zone, nr_vmemmap_pages);
+		adjust_present_page_count(pfn_to_page(start_pfn),
+					  nr_vmemmap_pages);
 
 	return ret;
 }
@@ -215,24 +216,23 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
-	struct zone *zone;
 	int ret;
 
 	/*
 	 * Unaccount before offlining, such that unpopulated zone and kthreads
 	 * can properly be torn down in offline_pages().
 	 */
-	if (nr_vmemmap_pages) {
-		zone = page_zone(pfn_to_page(start_pfn));
-		adjust_present_page_count(zone, -nr_vmemmap_pages);
-	}
+	if (nr_vmemmap_pages)
+		adjust_present_page_count(pfn_to_page(start_pfn),
+					  -nr_vmemmap_pages);
 
 	ret = offline_pages(start_pfn + nr_vmemmap_pages,
 			    nr_pages - nr_vmemmap_pages);
 	if (ret) {
 		/* offline_pages() failed. Account back. */
 		if (nr_vmemmap_pages)
-			adjust_present_page_count(zone, nr_vmemmap_pages);
+			adjust_present_page_count(pfn_to_page(start_pfn),
+						  nr_vmemmap_pages);
 		return ret;
 	}
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 57a8aa463ccb..571734fd95bd 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -107,7 +107,7 @@ static inline void zone_seqlock_init(struct zone *zone)
 extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
-extern void adjust_present_page_count(struct zone *zone, long nr_pages);
+extern void adjust_present_page_count(struct page *page, long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 				     struct zone *zone);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d53eba1c383..71621f96077e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -512,6 +512,10 @@ struct zone {
 	 * is calculated as:
 	 *	present_pages = spanned_pages - absent_pages(pages in holes);
 	 *
+	 * present_early_pages is present pages existing within the zone
+	 * located on memory available since early boot, excluding hotplugged
+	 * memory.
+	 *
 	 * managed_pages is present pages managed by the buddy system, which
 	 * is calculated as (reserved_pages includes pages allocated by the
 	 * bootmem allocator):
@@ -544,6 +548,9 @@ struct zone {
 	atomic_long_t		managed_pages;
 	unsigned long		spanned_pages;
 	unsigned long		present_pages;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	unsigned long		present_early_pages;
+#endif
 #ifdef CONFIG_CMA
 	unsigned long		cma_pages;
 #endif
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4969614d2140..f2646db86190 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -850,10 +850,17 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
  * This function should only be called by memory_block_{online,offline},
  * and {online,offline}_pages.
  */
-void adjust_present_page_count(struct zone *zone, long nr_pages)
+void adjust_present_page_count(struct page *page, long nr_pages)
 {
+	struct zone *zone = page_zone(page);
 	unsigned long flags;
 
+	/*
+	 * We only support onlining/offlining/adding/removing of complete
+	 * memory blocks; therefore, either all is early or hotplugged.
+	 */
+	if (early_section(__pfn_to_section(page_to_pfn(page))))
+		zone->present_early_pages += nr_pages;
 	zone->present_pages += nr_pages;
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages += nr_pages;
@@ -956,7 +963,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	}
 
 	online_pages_range(pfn, nr_pages);
-	adjust_present_page_count(zone, nr_pages);
+	adjust_present_page_count(pfn_to_page(pfn), nr_pages);
 
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
@@ -1827,7 +1834,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-	adjust_present_page_count(zone, -nr_pages);
+	adjust_present_page_count(pfn_to_page(start_pfn), -nr_pages);
 
 	init_per_zone_wmark_min();
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1f5de1c1283..08f68238882e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7007,6 +7007,9 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 			zone->zone_start_pfn = 0;
 		zone->spanned_pages = size;
 		zone->present_pages = real_size;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+		zone->present_early_pages = real_size;
+#endif
 
 		totalpages += size;
 		realtotalpages += real_size;
-- 
2.31.1

