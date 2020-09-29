Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0110127C03F
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgI2I6s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Sep 2020 04:58:48 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:52212 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727759AbgI2I6s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Sep 2020 04:58:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UATjWF-_1601369923;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UATjWF-_1601369923)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 29 Sep 2020 16:58:44 +0800
Date:   Tue, 29 Sep 2020 16:58:43 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v1 1/5] mm/page_alloc: convert "report" flag of
 __free_one_page() to a proper flag
Message-ID: <20200929085843.GA36790@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200928182110.7050-1-david@redhat.com>
 <20200928182110.7050-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928182110.7050-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 28, 2020 at 08:21:06PM +0200, David Hildenbrand wrote:
>Let's prepare for additional flags and avoid long parameter lists of bools.
>Follow-up patches will also make use of the flags in __free_pages_ok(),
>however, I wasn't able to come up with a better name for the type - should
>be good enough for internal purposes.
>
>Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>Cc: Mel Gorman <mgorman@techsingularity.net>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Dave Hansen <dave.hansen@intel.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Mike Rapoport <rppt@kernel.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> mm/page_alloc.c | 28 ++++++++++++++++++++--------
> 1 file changed, 20 insertions(+), 8 deletions(-)
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index df90e3654f97..daab90e960fe 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -77,6 +77,18 @@
> #include "shuffle.h"
> #include "page_reporting.h"
> 
>+/* Free One Page flags: for internal, non-pcp variants of free_pages(). */
>+typedef int __bitwise fop_t;
>+
>+/* No special request */
>+#define FOP_NONE		((__force fop_t)0)
>+
>+/*
>+ * Skip free page reporting notification for the (possibly merged) page. (will
>+ * *not* mark the page reported, only skip the notification).
>+ */
>+#define FOP_SKIP_REPORT_NOTIFY	((__force fop_t)BIT(0))
>+
> /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
> static DEFINE_MUTEX(pcp_batch_high_lock);
> #define MIN_PERCPU_PAGELIST_FRACTION	(8)
>@@ -948,10 +960,9 @@ buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
>  * -- nyc
>  */
> 
>-static inline void __free_one_page(struct page *page,
>-		unsigned long pfn,
>-		struct zone *zone, unsigned int order,
>-		int migratetype, bool report)
>+static inline void __free_one_page(struct page *page, unsigned long pfn,
>+				   struct zone *zone, unsigned int order,
>+				   int migratetype, fop_t fop_flags)
> {
> 	struct capture_control *capc = task_capc(zone);
> 	unsigned long buddy_pfn;
>@@ -1038,7 +1049,7 @@ static inline void __free_one_page(struct page *page,
> 		add_to_free_list(page, zone, order, migratetype);
> 
> 	/* Notify page reporting subsystem of freed page */
>-	if (report)
>+	if (!(fop_flags & FOP_SKIP_REPORT_NOTIFY))
> 		page_reporting_notify_free(order);
> }
> 
>@@ -1379,7 +1390,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> 		if (unlikely(isolated_pageblocks))
> 			mt = get_pageblock_migratetype(page);
> 
>-		__free_one_page(page, page_to_pfn(page), zone, 0, mt, true);
>+		__free_one_page(page, page_to_pfn(page), zone, 0, mt, FOP_NONE);
> 		trace_mm_page_pcpu_drain(page, 0, mt);
> 	}
> 	spin_unlock(&zone->lock);
>@@ -1395,7 +1406,7 @@ static void free_one_page(struct zone *zone,
> 		is_migrate_isolate(migratetype))) {
> 		migratetype = get_pfnblock_migratetype(page, pfn);
> 	}
>-	__free_one_page(page, pfn, zone, order, migratetype, true);
>+	__free_one_page(page, pfn, zone, order, migratetype, FOP_NONE);
> 	spin_unlock(&zone->lock);
> }
> 
>@@ -3288,7 +3299,8 @@ void __putback_isolated_page(struct page *page, unsigned int order, int mt)
> 	lockdep_assert_held(&zone->lock);
> 
> 	/* Return isolated page to tail of freelist. */
>-	__free_one_page(page, page_to_pfn(page), zone, order, mt, false);
>+	__free_one_page(page, page_to_pfn(page), zone, order, mt,
>+			FOP_SKIP_REPORT_NOTIFY);
> }
> 
> /*
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
