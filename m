Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F6439E7CC
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhFGT47 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231437AbhFGT47 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623095707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+2r3VzSeT6McLy6rSeUv9CVZcFjhZ+9fSc1TUY6nWg=;
        b=EdV73r804oBbFIcQVb4JjFPaTlwTP+KLiljPR3K8YRw4q0TtK+IJJ+9PsRmZDD3ZKz4clr
        sOxoGiQ5i8VNzS1dMYun1FcEYZZNi95Sou1RfwYO9I8ItT+agtRsx2ViCoR9N4vNvTCkZQ
        1cBZdVkX0q1pYg3h61QQO4GuSf7lLMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-T6msX2MeOH2tx3fzzSuYOw-1; Mon, 07 Jun 2021 15:55:05 -0400
X-MC-Unique: T6msX2MeOH2tx3fzzSuYOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8C3010074A8;
        Mon,  7 Jun 2021 19:55:02 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58F5F10013C1;
        Mon,  7 Jun 2021 19:54:52 +0000 (UTC)
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
Subject: [PATCH v1 03/12] mm/memory_hotplug: introduce "auto-movable" online policy
Date:   Mon,  7 Jun 2021 21:54:21 +0200
Message-Id: <20210607195430.48228-4-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When onlining without specifying a zone (using "online" instead of
"online_kernel" or "online_movable"), we currently select a zone such that
existing zones are kept contiguous. This online policy made sense in the
past, where contiguous zones where required.

We'd like to implement smarter policies, however:

* User space has little insight. As one example, it has no idea which
  memory blocks logically belong together (e.g., to a DIMM or to a
  virtio-mem device).
* Drivers that add memory in separate memory blocks, especially
  virtio-mem, want memory to get onlined right from the kernel when
  adding.

So we really want to have onlining to differing zones managed in the
kernel, configured by user space.

We see more and more cases where we might eventually hotplug a lot of
memory in the future (e.g., eventually grow a 2 GiB VM to 64 GiB), however:

* Resizing happens dynamically, in smaller steps in both directions
  (e.g., 2 GiB -> 8 GiB -> 4 GiB -> 16 GiB ...)
* We still want as much flexibility as possible, especially,
  hotunplugging as much memory as possible later.

We can really only use "online_movable" if we know that the amount of
memory we are going to hotplug upfront, and we know that it won't result
in a zone imbalance. So in our example, a 2 GiB VM that could grow to 64
GiB could currently not use "online_movable", and instead,
"online_kernel" would have to be used, resulting in worse (no) memory
hotunplug reliability.

Let's add a new "auto-movable" online policy that considers the current
zone ratios (global, per-node) to determine, whether we a memory block
can be onlined to ZONE_MOVABLE:

	MOVABLE : KERNEL

However, internally we'll only consider the following ratio for now:

	MOVABLE : KERNEL_EARLY

For now, we don't allow for hotplugged KERNEL memory to allow for more
MOVABLE memory, because there is no coordination accross memory devices.
In follow-up patches, we will allow for more KERNEL memory within a memory
device to allow for more MOVABLE memory within the same memory device --
which only makes sense for special memory device types.

We base our calculation on "present pages", see the code comments for
details. Hotplugged memory will get online to ZONE_MOVABLE if the
configured ratio allows for it. Depending on the setup, this can result
in fragmented zones, which can make compaction slower and dynamic
allocation of gigantic pages when not using CMA less reliable
(... which is already pretty unreliable).

The old policy will be the default and called "contig-zones". In follow-up
patches, our new policy will use additional information, such as memory
groups, to make even smarter decisions across memory blocks.

Configuration:

* memory_hotplug.online_policy is used to switch between both polices and
  defaults to "contig-zones".
* memory_hotplug.auto_movable_ratio defines the maximum ratio is in percent
  and defaults to "301" -- allowing e.g., most 8 GiB machines to grow to 32
  GiB and have all hotplugged memory in ZONE_MOVABLE. The additional
  percent accounts for a handful of lost present pages (e.g., firmware
  allocations). User space is expected to adjust this ratio when enabling
  the new "auto-movable" policy, though.
* memory_hotplug.auto_movable_numa_aware considers numa node stats in
  addition to global stats, and defaults to "true".

Note: just like the old policy, the new policy won't take things like
unmovable huge pages or memory ballooning that doesn't support balloon
compaction into account. User space has to configure onlining
accordingly.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 189 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f2646db86190..7206787ac5a9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -52,6 +52,73 @@ module_param(memmap_on_memory, bool, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
 #endif
 
+enum {
+	ONLINE_POLICY_CONTIG_ZONES = 0,
+	ONLINE_POLICY_AUTO_MOVABLE,
+};
+
+const char *online_policy_to_str[] = {
+	[ONLINE_POLICY_CONTIG_ZONES] = "contig-zones",
+	[ONLINE_POLICY_AUTO_MOVABLE] = "auto-movable",
+};
+
+static int set_online_policy(const char *val, const struct kernel_param *kp)
+{
+	int ret = sysfs_match_string(online_policy_to_str, val);
+
+	if (ret < 0)
+		return ret;
+	*((int *)kp->arg) = ret;
+	return 0;
+}
+
+static int get_online_policy(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%s\n", online_policy_to_str[*((int *)kp->arg)]);
+}
+
+/*
+ * memory_hotplug.online_policy: configure online behavior when onlining without
+ * specifying a zone (MMOP_ONLINE)
+ *
+ * "contig-zones": keep zone contiguous
+ * "auto-movable": online memory to ZONE_MOVABLE if the configuration
+ *                 (auto_movable_ratio, auto_movable_numa_aware) allows for it
+ */
+static int online_policy __read_mostly = ONLINE_POLICY_CONTIG_ZONES;
+static const struct kernel_param_ops online_policy_ops = {
+	.set = set_online_policy,
+	.get = get_online_policy,
+};
+module_param_cb(online_policy, &online_policy_ops, &online_policy, 0644);
+MODULE_PARM_DESC(online_policy,
+		"Set the online policy (\"contig-zones\", \"auto-movable\") "
+		"Default: \"contig-zones\"");
+
+/*
+ * memory_hotplug.auto_movable_ratio: specify maximum MOVABLE:KERNEL ratio
+ *
+ * The ratio represent an upper limit and the kernel might decide to not
+ * online some memory to ZONE_MOVABLE -- e.g., because hotplugged KERNEL memory
+ * doesn't allow for more MOVABLE memory.
+ */
+static unsigned int auto_movable_ratio __read_mostly = 301;
+module_param(auto_movable_ratio, uint, 0644);
+MODULE_PARM_DESC(auto_movable_ratio,
+		"Set the maximum ratio of MOVABLE:KERNEL memory in the system "
+		"in percent for \"auto-movable\" online policy. Default: 301");
+
+/*
+ * memory_hotplug.auto_movable_numa_aware: consider numa node stats
+ */
+#ifdef CONFIG_NUMA
+static bool auto_movable_numa_aware __read_mostly = true;
+module_param(auto_movable_numa_aware, bool, 0644);
+MODULE_PARM_DESC(auto_movable_numa_aware,
+		"Consider numa node stats in addition to global stats in "
+		"\"auto-movable\" online policy. Default: true");
+#endif /* CONFIG_NUMA */
+
 /*
  * online_page_callback contains pointer to current page onlining function.
  * Initially it is generic_online_page(). If it is required it could be
@@ -789,6 +856,59 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	set_zone_contiguous(zone);
 }
 
+struct auto_movable_stats {
+	unsigned long kernel_early_pages;
+	unsigned long movable_pages;
+};
+
+static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
+					    struct zone *zone)
+{
+	if (zone_idx(zone) == ZONE_MOVABLE) {
+		stats->movable_pages += zone->present_pages;
+	} else {
+		/*
+		 * CMA pages (never on hotplugged memory) behave like
+		 * ZONE_MOVABLE.
+		 */
+		stats->movable_pages += zone->cma_pages;
+		stats->kernel_early_pages += zone->present_early_pages;
+		stats->kernel_early_pages -= zone->cma_pages;
+	}
+}
+
+static bool auto_movable_can_online_movable(int nid, unsigned long nr_pages)
+{
+	struct auto_movable_stats stats = {};
+	unsigned long kernel_early_pages, movable_pages;
+	pg_data_t *pgdat = NODE_DATA(nid);
+	struct zone *zone;
+	int i;
+
+	/* Walk all relevant zones and collect MOVABLE vs. KERNEL stats. */
+	if (nid == NUMA_NO_NODE) {
+		/* TODO: cache values */
+		for_each_populated_zone(zone)
+			auto_movable_stats_account_zone(&stats, zone);
+	} else {
+		for (i = 0; i < MAX_NR_ZONES; i++) {
+			zone = pgdat->node_zones + i;
+			if (populated_zone(zone))
+				auto_movable_stats_account_zone(&stats, zone);
+		}
+	}
+
+	kernel_early_pages = stats.kernel_early_pages;
+	movable_pages = stats.movable_pages;
+
+	/*
+	 * Test if we could online the given number of pages to ZONE_MOVABLE
+	 * and still stay in the configured ratio.
+	 */
+	movable_pages += nr_pages;
+	return movable_pages <= (auto_movable_ratio * kernel_early_pages) / 100;
+}
+
 /*
  * Returns a default kernel memory zone for the given pfn range.
  * If no kernel zone covers this pfn range it will automatically go
@@ -810,6 +930,72 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
 	return &pgdat->node_zones[ZONE_NORMAL];
 }
 
+/*
+ * Determine to which zone to online memory dynamically based on user
+ * configuration and system stats. We care about the following ratio:
+ *
+ *   MOVABLE : KERNEL
+ *
+ * Whereby MOVABLE is memory in ZONE_MOVABLE and KERNEL is memory in
+ * one of the kernel zones. CMA pages inside one of the kernel zones really
+ * behaves like ZONE_MOVABLE, so we treat them accordingly.
+ *
+ * We don't allow for hotplugged memory in a KERNEL zone to increase the
+ * amount of MOVABLE memory we can have, so we end up with:
+ *
+ *   MOVABLE : KERNEL_EARLY
+ *
+ * Whereby KERNEL_EARLY is memory in one of the kernel zones, available sinze
+ * boot. We base our calculation on KERNEL_EARLY internally, because:
+ *
+ * a) Hotplugged memory in one of the kernel zones can sometimes still get
+ *    hotunplugged, especially when hot(un)plugging individual memory blocks.
+ *    There is no coordination across memory devices, therefore "automatic"
+ *    hotunplugging, as implemented in hypervisors, could result in zone
+ *    imbalances.
+ * b) Early/boot memory in one of the kernel zones can usually not get
+ *    hotunplugged again (e.g., no firmware interface to unplug, fragmented
+ *    with unmovable allocations). While there are corner cases where it might
+ *    still work, it is barely relevant in practice.
+ *
+ * We rely on "present pages" instead of "managed pages", as the latter is
+ * highly unreliable and dynamic in virtualized environments, and does not
+ * consider boot time allocations. For example, memory ballooning adjusts the
+ * managed pages when inflating/deflating the balloon, and balloon compaction
+ * can even migrate inflated pages between zones.
+ *
+ * Using "present pages" is better but some things to keep in mind are:
+ *
+ * a) Some memblock allocations, such as for the crashkernel area, are
+ *    effectively unused by the kernel, yet they account to "present pages".
+ *    Fortunately, these allocations are comparatively small in relevant setups
+ *    (e.g., fraction of system memory).
+ * b) Some hotplugged memory blocks in virtualized environments, esecially
+ *    hotplugged by virtio-mem, look like they are completely present, however,
+ *    only parts of the memory block are actually currently usable.
+ *    "present pages" is an upper limit that can get reached at runtime. As
+ *    we base our calculations on KERNEL_EARLY, this is not an issue.
+ */
+static struct zone *auto_movable_zone_for_pfn(int nid, unsigned long pfn,
+					      unsigned long nr_pages)
+{
+	if (!auto_movable_ratio)
+		goto kernel_zone;
+
+	if (!auto_movable_can_online_movable(NUMA_NO_NODE, nr_pages))
+		goto kernel_zone;
+
+#ifdef CONFIG_NUMA
+	if (auto_movable_numa_aware &&
+	    !auto_movable_can_online_movable(nid, nr_pages))
+		goto kernel_zone;
+#endif /* CONFIG_NUMA */
+
+	return &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
+kernel_zone:
+	return default_kernel_zone_for_pfn(nid, pfn, nr_pages);
+}
+
 static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn,
 		unsigned long nr_pages)
 {
@@ -843,6 +1029,9 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
 	if (online_type == MMOP_ONLINE_MOVABLE)
 		return &NODE_DATA(nid)->node_zones[ZONE_MOVABLE];
 
+	if (online_policy == ONLINE_POLICY_AUTO_MOVABLE)
+		return auto_movable_zone_for_pfn(nid, start_pfn, nr_pages);
+
 	return default_zone_for_pfn(nid, start_pfn, nr_pages);
 }
 
-- 
2.31.1

