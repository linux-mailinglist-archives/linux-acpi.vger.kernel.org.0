Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FBB3C5C74
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhGLMog (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 08:44:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233517AbhGLMof (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626093707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iimg+qQSgcqxiRNdP92p/YunXPxELvQ8PHwm9CDHrrU=;
        b=gtBeDxczV/yWqKfjr0cVXNyn0kXIwa5ZjKFqoBHHXVWZhgGRrE5lWDpYpWaBjOgpYT/nik
        A3MssR1Z14mzDKYuiTD9Ev2H3jMZHo4kr5fOXwR9rMRlSO/+R6q2YmOYzZQxNlruN0Jqmn
        3s3p/bKKs+ylEjniNrOuOvp93jiiPVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-9K5-8dqLPLuDmHE1nn5TOQ-1; Mon, 12 Jul 2021 08:41:45 -0400
X-MC-Unique: 9K5-8dqLPLuDmHE1nn5TOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1FDC100CED4;
        Mon, 12 Jul 2021 12:41:39 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-111.rdu2.redhat.com [10.10.113.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E63A15C232;
        Mon, 12 Jul 2021 12:41:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
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
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jia He <justin.he@arm.com>, Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rich Felker <dalias@libc.org>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v1 1/4] mm/memory_hotplug: use "unsigned long" for PFN in zone_for_pfn_range()
Date:   Mon, 12 Jul 2021 14:40:49 +0200
Message-Id: <20210712124052.26491-2-david@redhat.com>
In-Reply-To: <20210712124052.26491-1-david@redhat.com>
References: <20210712124052.26491-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
index a7fd2c3ccb77..d01b504ce06f 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -339,8 +339,8 @@ extern void sparse_remove_section(struct mem_section *ms,
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
index 8cb75b26ea4f..93b3abaf9828 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -708,8 +708,8 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
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

