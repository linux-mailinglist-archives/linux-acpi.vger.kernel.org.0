Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAED221CA47
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Jul 2020 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGLQnI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Jul 2020 12:43:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:18059 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbgGLQnI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Jul 2020 12:43:08 -0400
IronPort-SDR: ETA8AWK5rPEDd9OSytziniyun5ioDO9l14nSclzBq7FoQHjCGmDBJdexvxESmEojL+zAuz2QUb
 1DwmWKopalhA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="149971545"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="149971545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:05 -0700
IronPort-SDR: +LoP6vAnoAe0hF9U/NMAgygQcY4L/uwvjnfRGkNfM1sABLBb7c7ZVfW41KfUFD4NY2AqxkDA3L
 8Rrrtmm5XlOQ==
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; 
   d="scan'208";a="307187659"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 09:43:05 -0700
Subject: [PATCH v2 08/22] memblock: Introduce a generic
 phys_addr_to_target_node()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Jia He <justin.he@arm.com>,
        Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, hch@lst.de, joao.m.martins@oracle.com
Date:   Sun, 12 Jul 2020 09:26:48 -0700
Message-ID: <159457120893.754248.7783260004248722175.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Similar to how generic memory_add_physaddr_to_nid() interrogates
memblock data for numa information, introduce
get_reserved_pfn_range_from_nid() to enable the same operation for
reserved memory ranges. Example memory ranges that are reserved, but
still have associated numa-info are persistent memory or Soft Reserved
(EFI_MEMORY_SP) memory.

Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jia He <justin.he@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memblock.h |    4 +++
 include/linux/mm.h       |    2 +
 include/linux/numa.h     |    2 +
 mm/memblock.c            |   22 ++++++++++++++--
 mm/page_alloc.c          |   63 +++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 017fae833d4a..0655e8376c72 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -234,6 +234,10 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 
+#define for_each_reserved_pfn_range(i, nid, p_start, p_end, p_nid)		\
+	for (i = -1, __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid); \
+	     i >= 0; __next_reserved_pfn_range(&i, nid, p_start, p_end, p_nid))
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
 				  unsigned long *out_spfn,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1e76ee5da20b..82dac9f42c46 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2438,6 +2438,8 @@ extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 
 extern void get_pfn_range_for_nid(unsigned int nid,
 			unsigned long *start_pfn, unsigned long *end_pfn);
+extern void get_reserved_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn);
 extern unsigned long find_min_pfn_with_active_regions(void);
 extern void sparse_memory_present_with_active_regions(int nid);
 
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 5d25c5de1322..52b2430bc759 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -19,7 +19,7 @@ int numa_map_to_online_node(int node);
 
 /*
  * Optional architecture specific implementation, users need a "depends
- * on $ARCH"
+ * on $ARCH" or depends on CONFIG_MEMBLOCK_NUMA_INFO
  */
 int phys_to_target_node(phys_addr_t addr);
 #else
diff --git a/mm/memblock.c b/mm/memblock.c
index 39aceafc57f6..43c3abab705e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1200,11 +1200,11 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
 /*
  * Common iterator interface used to define for_each_mem_pfn_range().
  */
-void __init_memblock __next_mem_pfn_range(int *idx, int nid,
+static void __init_memblock __next_memblock_pfn_range(int *idx, int nid,
 				unsigned long *out_start_pfn,
-				unsigned long *out_end_pfn, int *out_nid)
+				unsigned long *out_end_pfn, int *out_nid,
+				struct memblock_type *type)
 {
-	struct memblock_type *type = &memblock.memory;
 	struct memblock_region *r;
 	int r_nid;
 
@@ -1230,6 +1230,22 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		*out_nid = r_nid;
 }
 
+void __init_memblock __next_mem_pfn_range(int *idx, int nid,
+				unsigned long *out_start_pfn,
+				unsigned long *out_end_pfn, int *out_nid)
+{
+	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
+				  &memblock.memory);
+}
+
+void __init_memblock __next_reserved_pfn_range(int *idx, int nid,
+				unsigned long *out_start_pfn,
+				unsigned long *out_end_pfn, int *out_nid)
+{
+	__next_memblock_pfn_range(idx, nid, out_start_pfn, out_end_pfn, out_nid,
+				  &memblock.reserved);
+}
+
 /**
  * memblock_set_node - set node ID on memblock regions
  * @base: base of area to set node ID for
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index df8bd169dbb4..94ad77c0c338 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6369,12 +6369,39 @@ void __init_or_memblock get_pfn_range_for_nid(unsigned int nid,
 		*start_pfn = 0;
 }
 
+/**
+ * get_reserved_pfn_range_for_nid - Return the start and end page frames for a node
+ * @nid: The nid to return the range for. If MAX_NUMNODES, the min and max PFN are returned.
+ * @start_pfn: Passed by reference. On return, it will have the node start_pfn.
+ * @end_pfn: Passed by reference. On return, it will have the node end_pfn.
+ *
+ * Mostly identical to get_pfn_range_for_nid() except it operates on
+ * reserved ranges rather than online memory.
+ */
+void __init_or_memblock get_reserved_pfn_range_for_nid(unsigned int nid,
+			unsigned long *start_pfn, unsigned long *end_pfn)
+{
+	unsigned long this_start_pfn, this_end_pfn;
+	int i;
+
+	*start_pfn = -1UL;
+	*end_pfn = 0;
+
+	for_each_mem_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
+		*start_pfn = min(*start_pfn, this_start_pfn);
+		*end_pfn = max(*end_pfn, this_end_pfn);
+	}
+
+	if (*start_pfn == -1UL)
+		*start_pfn = 0;
+}
+
 /*
  * Generic implementation of memory_add_physaddr_to_nid() depends on
  * architecture using memblock data for numa information.
  */
 #ifdef CONFIG_MEMBLOCK_NUMA_INFO
-int __init_or_memblock memory_add_physaddr_to_nid(u64 addr)
+static int __init_or_memblock __memory_add_physaddr_to_nid(u64 addr)
 {
 	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
 	int nid;
@@ -6384,10 +6411,42 @@ int __init_or_memblock memory_add_physaddr_to_nid(u64 addr)
 		if (pfn >= start_pfn && pfn <= end_pfn)
 			return nid;
 	}
+	return NUMA_NO_NODE;
+}
+
+int __init_or_memblock memory_add_physaddr_to_nid(u64 addr)
+{
+	int nid = __memory_add_physaddr_to_nid(addr);
+
 	/* Default to node0 as not all callers are prepared for this to fail */
-	return 0;
+	if (nid == NUMA_NO_NODE)
+		return 0;
+	return nid;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+
+int __init_or_memblock phys_to_target_node(u64 addr)
+{
+	unsigned long start_pfn, end_pfn, pfn = PHYS_PFN(addr);
+	int nid = __memory_add_physaddr_to_nid(addr);
+
+	if (nid != NUMA_NO_NODE)
+		return nid;
+
+	/*
+	 * Search reserved memory ranges since the memory address does
+	 * not appear to be online
+	 */
+	for_each_possible_node(nid) {
+		if (node_online(nid))
+			continue;
+		get_reserved_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (pfn >= start_pfn && pfn <= end_pfn)
+			return nid;
+	}
+	return NUMA_NO_NODE;
+}
+EXPORT_SYMBOL_GPL(phys_to_target_node);
 #endif /* CONFIG_MEMBLOCK_NUMA_INFO */
 
 /*

