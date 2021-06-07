Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01C039E7C5
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 21:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhFGT4o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 15:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231263AbhFGT4n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 15:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623095691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q50miELZBDJItXtYwAibMviHcNFzP32Zr9gGDf9CmwQ=;
        b=aZpGZ7e/a3AxZuFyM7a66VO4yLa12LLYTw28Y5PySONxLTmWQUv6NBpOd4faMOgN5KF1N8
        Hlim0dOj0bnz8RM4IDCBwz3M9WOepYi0xBDrVARtJR6tx93i7Mwh9ok9g/g/C+7X+369+n
        fC/EcP+0Qv64FjPiaF0vcx2TlIpsZxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-KFMsgfAJMCuHwnRYnG1I3w-1; Mon, 07 Jun 2021 15:54:50 -0400
X-MC-Unique: KFMsgfAJMCuHwnRYnG1I3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EF3F107ACCD;
        Mon,  7 Jun 2021 19:54:47 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 393041002D71;
        Mon,  7 Jun 2021 19:54:43 +0000 (UTC)
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
Subject: [PATCH v1 01/12] mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()
Date:   Mon,  7 Jun 2021 21:54:19 +0200
Message-Id: <20210607195430.48228-2-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Checkpatch complained on a follow-up patch that we are using "unsigned"
here, which defaults to "unsigned int" and checkpatch is correct.

Use "unsigned long" instead, just as we do in other places when handling
PFNs. This can bite us once we have physical addresses in the range of
multiple TB.

Fixes: e5e689302633 ("mm, memory_hotplug: display allowed zones in the preferred ordering")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h | 4 ++--
 mm/memory_hotplug.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 28f32fd00fe9..57a8aa463ccb 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -366,8 +366,8 @@ extern void sparse_remove_section(struct mem_section *ms,
 		unsigned long map_offset, struct vmem_altmap *altmap);
 extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
-extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
-		unsigned long nr_pages);
+extern struct zone *zone_for_pfn_range(int online_type, int nid,
+		unsigned long start_pfn, unsigned long nr_pages);
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 70620d0dd923..4969614d2140 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -834,8 +834,8 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 	return movable_node_enabled ? movable_zone : kernel_zone;
 }
 
-struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
-		unsigned long nr_pages)
+struct zone *zone_for_pfn_range(int online_type, int nid,
+		unsigned long start_pfn, unsigned long nr_pages)
 {
 	if (online_type == MMOP_ONLINE_KERNEL)
 		return default_kernel_zone_for_pfn(nid, start_pfn, nr_pages);
-- 
2.31.1

