Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD743BCCA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 00:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbhJZWEF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 18:04:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:57940 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239733AbhJZWEC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 18:04:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="216934494"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="216934494"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 15:01:01 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497555775"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 15:01:00 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com, Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH v11 5/7] x86/sgx: Hook arch_memory_failure() into mainline code
Date:   Tue, 26 Oct 2021 15:00:48 -0700
Message-Id: <20211026220050.697075-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026220050.697075-1-tony.luck@intel.com>
References: <20211018202542.584115-1-tony.luck@intel.com>
 <20211026220050.697075-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a call inside memory_failure() to call the arch specific code
to check if the address is an SGX EPC page and handle it.

Note the SGX EPC pages do not have a "struct page" entry, so the hook
goes in at the same point as the device mapping hook.

Pull the call to acquire the mutex earlier so the SGX errors are also
protected.

Make set_mce_nospec() skip SGX pages when trying to adjust
the 1:1 map.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/processor.h  |  8 ++++++++
 arch/x86/include/asm/set_memory.h |  4 ++++
 include/linux/mm.h                | 13 +++++++++++++
 mm/memory-failure.c               | 19 +++++++++++++------
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9ad2acaaae9b..4865f2860a4f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -853,4 +853,12 @@ enum mds_mitigations {
 	MDS_MITIGATION_VMWERV,
 };
 
+#ifdef CONFIG_X86_SGX
+int arch_memory_failure(unsigned long pfn, int flags);
+#define arch_memory_failure arch_memory_failure
+
+bool arch_is_platform_page(u64 paddr);
+#define arch_is_platform_page arch_is_platform_page
+#endif
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 43fa081a1adb..ce8dd215f5b3 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_SET_MEMORY_H
 #define _ASM_X86_SET_MEMORY_H
 
+#include <linux/mm.h>
 #include <asm/page.h>
 #include <asm-generic/set_memory.h>
 
@@ -98,6 +99,9 @@ static inline int set_mce_nospec(unsigned long pfn, bool unmap)
 	unsigned long decoy_addr;
 	int rc;
 
+	/* SGX pages are not in the 1:1 map */
+	if (arch_is_platform_page(pfn << PAGE_SHIFT))
+		return 0;
 	/*
 	 * We would like to just call:
 	 *      set_memory_XX((unsigned long)pfn_to_kaddr(pfn), 1);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 73a52aba448f..0aa48b238db2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3124,6 +3124,19 @@ extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 
+#ifndef arch_memory_failure
+static inline int arch_memory_failure(unsigned long pfn, int flags)
+{
+	return -ENXIO;
+}
+#endif
+
+#ifndef arch_is_platform_page
+static inline bool arch_is_platform_page(u64 paddr)
+{
+	return false;
+}
+#endif
 
 /*
  * Error handlers for various types of pages.
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3e6449f2102a..b1cbf9845c19 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1632,21 +1632,28 @@ int memory_failure(unsigned long pfn, int flags)
 	if (!sysctl_memory_failure_recovery)
 		panic("Memory failure on page %lx", pfn);
 
+	mutex_lock(&mf_mutex);
+
 	p = pfn_to_online_page(pfn);
 	if (!p) {
+		res = arch_memory_failure(pfn, flags);
+		if (res == 0)
+			goto unlock_mutex;
+
 		if (pfn_valid(pfn)) {
 			pgmap = get_dev_pagemap(pfn, NULL);
-			if (pgmap)
-				return memory_failure_dev_pagemap(pfn, flags,
-								  pgmap);
+			if (pgmap) {
+				res = memory_failure_dev_pagemap(pfn, flags,
+								 pgmap);
+				goto unlock_mutex;
+			}
 		}
 		pr_err("Memory failure: %#lx: memory outside kernel control\n",
 			pfn);
-		return -ENXIO;
+		res = -ENXIO;
+		goto unlock_mutex;
 	}
 
-	mutex_lock(&mf_mutex);
-
 try_again:
 	if (PageHuge(p)) {
 		res = memory_failure_hugetlb(pfn, flags);
-- 
2.31.1

