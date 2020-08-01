Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B583234FF0
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 05:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgHADlx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 23:41:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:4817 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgHADlx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 23:41:53 -0400
IronPort-SDR: DttwG2MlhFGYvNUIO0hs8/hxSD5ZB7AvmhFPK/aGJrJlylUB1saesj7XeeZ5qpZ8SyyOhZ9Sfj
 O0sIOiZt05pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="151106203"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="151106203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:52 -0700
IronPort-SDR: J5+oL9gEiI7vege3Ovi/9v7xpYCEboTm9hZtr+gXJdO66m+2rxqdrkMRX7lKZOF9RCQEiNvQEJ
 c+Flf4FPBDOA==
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="365776535"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:52 -0700
Subject: [PATCH v3 06/23] mm/memory_hotplug: Introduce default
 phys_to_target_node() implementation
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Jia He <justin.he@arm.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        vishal.l.verma@intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, joao.m.martins@oracle.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Fri, 31 Jul 2020 20:25:34 -0700
Message-ID: <159625233419.3040297.13342516597848248917.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation to set a fallback value for dev_dax->target_node,
introduce generic fallback helpers for phys_to_target_node()

A generic implementation based on node-data or memblock was proposed,
but as noted by Mike:

    "Here again, I would prefer to add a weak default for
     phys_to_target_node() because the "generic" implementation is not really
     generic.

     The fallback to reserved ranges is x86 specfic because on x86 most of
     the reserved areas is not in memblock.memory. AFAIK, no other
     architecture does this."

The info message in the generic memory_add_physaddr_to_nid()
implementation is fixed up to properly reflect that
memory_add_physaddr_to_nid() communicates "online" node info and
phys_to_target_node() indicates "target / to-be-onlined" node info.

Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Jia He <justin.he@arm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/numa.c             |    1 -
 include/linux/memory_hotplug.h |    5 +++++
 mm/memory_hotplug.c            |   10 +++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index f3805bbaa784..c62e274d52d0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -917,7 +917,6 @@ int phys_to_target_node(phys_addr_t start)
 
 	return meminfo_to_nid(&numa_reserved_meminfo, start);
 }
-EXPORT_SYMBOL_GPL(phys_to_target_node);
 
 int memory_add_physaddr_to_nid(u64 start)
 {
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 375515803cd8..dcdc7d6206d5 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -151,11 +151,16 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 
 #ifdef CONFIG_NUMA
 extern int memory_add_physaddr_to_nid(u64 start);
+extern int phys_to_target_node(u64 start);
 #else
 static inline int memory_add_physaddr_to_nid(u64 start)
 {
 	return 0;
 }
+static inline int phys_to_target_node(u64 start)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index dcdf3271f87e..426b79adf529 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -353,11 +353,19 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 #ifdef CONFIG_NUMA
 int __weak memory_add_physaddr_to_nid(u64 start)
 {
-	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
+	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
 			start);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+
+int __weak phys_to_target_node(u64 start)
+{
+	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
+			start);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phys_to_target_node);
 #endif
 
 /* find the smallest valid pfn in the range [start_pfn, end_pfn) */

