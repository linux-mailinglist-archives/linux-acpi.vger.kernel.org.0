Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0338E3E2AE4
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Aug 2021 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbhHFMuW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Aug 2021 08:50:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343807AbhHFMtC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Aug 2021 08:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628254126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDzuZ6IdMTvF3qVkPbjWIl11oCFxHS1t3MfZjxdBoeA=;
        b=dMazw58gvRuxjFHDTq35c9CGkx+NkUFP1NnsbZRs86SE9YwDtx70jTnYHRRcqxl5pzMVd1
        D2k8UCkyex/+5mshhmp4CzulDU7dGzqxK1H9dBFfIfqQDQy5jVj/p1VL4wfPJozDyjulN9
        Ey8+F9dvjZosfF3Nzv3BPyaf1LGsbsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-1TEwGDjIN3SGheWIwh4ObQ-1; Fri, 06 Aug 2021 08:48:45 -0400
X-MC-Unique: 1TEwGDjIN3SGheWIwh4ObQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AAE2107ACF5;
        Fri,  6 Aug 2021 12:48:42 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4410F5D6A1;
        Fri,  6 Aug 2021 12:48:37 +0000 (UTC)
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
Subject: [PATCH v3 8/9] mm/memory_hotplug: memory group aware "auto-movable" online policy
Date:   Fri,  6 Aug 2021 14:47:14 +0200
Message-Id: <20210806124715.17090-9-david@redhat.com>
In-Reply-To: <20210806124715.17090-1-david@redhat.com>
References: <20210806124715.17090-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use memory groups to improve our "auto-movable" onlining policy:

1. For static memory groups (e.g., a DIMM), online a memory block MOVABLE
   only if all other memory blocks in the group are either MOVABLE or could
   be onlined MOVABLE. A DIMM will either be MOVABLE or not, not a mixture.

2. For dynamic memory groups (e.g., a virtio-mem device), online a
   memory block MOVABLE only if all other memory blocks inside the
   current unit are either MOVABLE or could be onlined MOVABLE. For a
   virtio-mem device with a device block size with 512 MiB, all 128 MiB
   memory blocks wihin a 512 MiB unit will either be MOVABLE or not, not
   a mixture.

We have to pass the memory group to zone_for_pfn_range() to take the
memory group into account.

Note: for now, there seems to be no compelling reason to make this
behavior configurable.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 18 +++++++------
 include/linux/memory_hotplug.h |  3 ++-
 mm/memory_hotplug.c            | 48 +++++++++++++++++++++++++++++++---
 3 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index a1082013e10c..b699ddc42693 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -182,7 +182,8 @@ static int memory_block_online(struct memory_block *mem)
 	struct zone *zone;
 	int ret;
 
-	zone = zone_for_pfn_range(mem->online_type, mem->nid, start_pfn, nr_pages);
+	zone = zone_for_pfn_range(mem->online_type, mem->nid, mem->group,
+				  start_pfn, nr_pages);
 
 	/*
 	 * Although vmemmap pages have a different lifecycle than the pages
@@ -379,12 +380,13 @@ static ssize_t phys_device_show(struct device *dev,
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
 static int print_allowed_zone(char *buf, int len, int nid,
+			      struct memory_group *group,
 			      unsigned long start_pfn, unsigned long nr_pages,
 			      int online_type, struct zone *default_zone)
 {
 	struct zone *zone;
 
-	zone = zone_for_pfn_range(online_type, nid, start_pfn, nr_pages);
+	zone = zone_for_pfn_range(online_type, nid, group, start_pfn, nr_pages);
 	if (zone == default_zone)
 		return 0;
 
@@ -397,9 +399,10 @@ static ssize_t valid_zones_show(struct device *dev,
 	struct memory_block *mem = to_memory_block(dev);
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
+	struct memory_group *group = mem->group;
 	struct zone *default_zone;
+	int nid = mem->nid;
 	int len = 0;
-	int nid;
 
 	/*
 	 * Check the existing zone. Make sure that we do that only on the
@@ -418,14 +421,13 @@ static ssize_t valid_zones_show(struct device *dev,
 		goto out;
 	}
 
-	nid = mem->nid;
-	default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, start_pfn,
-					  nr_pages);
+	default_zone = zone_for_pfn_range(MMOP_ONLINE, nid, group,
+					  start_pfn, nr_pages);
 
 	len += sysfs_emit_at(buf, len, "%s", default_zone->name);
-	len += print_allowed_zone(buf, len, nid, start_pfn, nr_pages,
+	len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
 				  MMOP_ONLINE_KERNEL, default_zone);
-	len += print_allowed_zone(buf, len, nid, start_pfn, nr_pages,
+	len += print_allowed_zone(buf, len, nid, group, start_pfn, nr_pages,
 				  MMOP_ONLINE_MOVABLE, default_zone);
 out:
 	len += sysfs_emit_at(buf, len, "\n");
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index cf3f423c8a74..e5a867c950b2 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -349,7 +349,8 @@ extern void sparse_remove_section(struct mem_section *ms,
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(int online_type, int nid,
-		unsigned long start_pfn, unsigned long nr_pages);
+		struct memory_group *group, unsigned long start_pfn,
+		unsigned long nr_pages);
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 24feccfa7859..fd2edd99f8df 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -852,12 +852,53 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
  *    "present pages" is an upper limit that can get reached at runtime. As
  *    we base our calculations on KERNEL_EARLY, this is not an issue.
  */
-static struct zone *auto_movable_zone_for_pfn(int nid, unsigned long pfn,
+static struct zone *auto_movable_zone_for_pfn(int nid,
+					      struct memory_group *group,
+					      unsigned long pfn,
 					      unsigned long nr_pages)
 {
+	unsigned long online_pages = 0, max_pages, end_pfn;
+	struct page *page;
+
 	if (!auto_movable_ratio)
 		goto kernel_zone;
 
+	if (group && !group->is_dynamic) {
+		max_pages = group->s.max_pages;
+		online_pages = group->present_movable_pages;
+
+		/* If anything is !MOVABLE online the rest !MOVABLE. */
+		if (group->present_kernel_pages)
+			goto kernel_zone;
+	} else if (!group || group->d.unit_pages == nr_pages) {
+		max_pages = nr_pages;
+	} else {
+		max_pages = group->d.unit_pages;
+		/*
+		 * Take a look at all online sections in the current unit.
+		 * We can safely assume that all pages within a section belong
+		 * to the same zone, because dynamic memory groups only deal
+		 * with hotplugged memory.
+		 */
+		pfn = ALIGN_DOWN(pfn, group->d.unit_pages);
+		end_pfn = pfn + group->d.unit_pages;
+		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+			page = pfn_to_online_page(pfn);
+			if (!page)
+				continue;
+			/* If anything is !MOVABLE online the rest !MOVABLE. */
+			if (page_zonenum(page) != ZONE_MOVABLE)
+				goto kernel_zone;
+			online_pages += PAGES_PER_SECTION;
+		}
+	}
+
+	/*
+	 * Online MOVABLE if we could *currently* online all remaining parts
+	 * MOVABLE. We expect to (add+) online them immediately next, so if
+	 * nobody interferes, all will be MOVABLE if possible.
+	 */
+	nr_pages = max_pages - online_pages;
 	if (!auto_movable_can_online_movable(NUMA_NO_NODE, nr_pages))
 		goto kernel_zone;
 
@@ -897,7 +938,8 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 }
 
 struct zone *zone_for_pfn_range(int online_type, int nid,
-		unsigned long start_pfn, unsigned long nr_pages)
+		struct memory_group *group, unsigned long start_pfn,
+		unsigned long nr_pages)
 {
 	if (online_type == MMOP_ONLINE_KERNEL)
 		return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);
@@ -906,7 +948,7 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
 		return &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
 
 	if (online_policy == ONLINE_POLICY_AUTO_MOVABLE)
-		return auto_movable_zone_for_pfn(nid, start_pfn, nr_pages);
+		return auto_movable_zone_for_pfn(nid, group, start_pfn, nr_pages);
 
 	return default_zone_for_pfn(nid, start_pfn, nr_pages);
 }
-- 
2.31.1

