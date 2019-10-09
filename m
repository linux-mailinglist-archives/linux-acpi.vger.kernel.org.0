Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA8D0F0A
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Oct 2019 14:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfJIMoW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Oct 2019 08:44:22 -0400
Received: from 8bytes.org ([81.169.241.247]:46702 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbfJIMoW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Oct 2019 08:44:22 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 46814401; Wed,  9 Oct 2019 14:44:20 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     hpa@zytor.com, x86@kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        james.morse@arm.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V2] x86/mm: Split vmalloc_sync_all()
Date:   Wed,  9 Oct 2019 14:44:18 +0200
Message-Id: <20191009124418.8286-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Git commit 3f8fd02b1bf1 ("mm/vmalloc: Sync unmappings in
__purge_vmap_area_lazy()") introduced a call to vmalloc_sync_all() in
the vunmap() code-path.  While this change was necessary to maintain
correctness on x86-32-pae kernels, it also adds additional cycles for
architectures that don't need it.

Specifically on x86-64 with CONFIG_VMAP_STACK=y some people reported
severe performance regressions in micro-benchmarks because it now also
calls the x86-64 implementation of vmalloc_sync_all() on vunmap(). But
the vmalloc_sync_all() implementation on x86-64 is only needed for
newly created mappings.

To avoid the unnecessary work on x86-64 and to gain the performance
back, split up vmalloc_sync_all() into two functions:

	* vmalloc_sync_mappings(), and
	* vmalloc_sync_unmappings()

Most call-sites to vmalloc_sync_all() only care about new mappings
being synchronized. The only exception is the new call-site
added in the above mentioned commit.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 3f8fd02b1bf1 ("mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
Changes to initial post:
	- Added comments to x86-64 version of
	  vmalloc_sync_[un]mappings() as suggested by Dave
	  Hansen.

 arch/x86/mm/fault.c      | 26 ++++++++++++++++++++++++--
 drivers/acpi/apei/ghes.c |  2 +-
 include/linux/vmalloc.h  |  5 +++--
 kernel/notifier.c        |  2 +-
 mm/nommu.c               | 10 +++++++---
 mm/vmalloc.c             | 11 +++++++----
 6 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9ceacd1156db..94174361f524 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -189,7 +189,7 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 	return pmd_k;
 }
 
-void vmalloc_sync_all(void)
+static void vmalloc_sync(void)
 {
 	unsigned long address;
 
@@ -216,6 +216,16 @@ void vmalloc_sync_all(void)
 	}
 }
 
+void vmalloc_sync_mappings(void)
+{
+	vmalloc_sync();
+}
+
+void vmalloc_sync_unmappings(void)
+{
+	vmalloc_sync();
+}
+
 /*
  * 32-bit:
  *
@@ -318,11 +328,23 @@ static void dump_pagetable(unsigned long address)
 
 #else /* CONFIG_X86_64: */
 
-void vmalloc_sync_all(void)
+void vmalloc_sync_mappings(void)
 {
+	/*
+	 * 64-bit mappings might allocate new p4d/pud pages
+	 * that need to be propagated to all tasks' PGDs.
+	 */
 	sync_global_pgds(VMALLOC_START & PGDIR_MASK, VMALLOC_END);
 }
 
+void vmalloc_sync_unmappings(void)
+{
+	/*
+	 * Unmappings never allocate or free p4d/pud pages.
+	 * No work is required here.
+	 */
+}
+
 /*
  * 64-bit:
  *
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 777f6f7122b4..e0d82fab1f44 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -171,7 +171,7 @@ int ghes_estatus_pool_init(int num_ghes)
 	 * New allocation must be visible in all pgd before it can be found by
 	 * an NMI allocating from the pool.
 	 */
-	vmalloc_sync_all();
+	vmalloc_sync_mappings();
 
 	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
 	if (rc)
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 4e7809408073..decac0790fc1 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -126,8 +126,9 @@ extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
 
 extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 							unsigned long pgoff);
-void vmalloc_sync_all(void);
- 
+void vmalloc_sync_mappings(void);
+void vmalloc_sync_unmappings(void);
+
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
diff --git a/kernel/notifier.c b/kernel/notifier.c
index d9f5081d578d..157d7c29f720 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -554,7 +554,7 @@ NOKPROBE_SYMBOL(notify_die);
 
 int register_die_notifier(struct notifier_block *nb)
 {
-	vmalloc_sync_all();
+	vmalloc_sync_mappings();
 	return atomic_notifier_chain_register(&die_chain, nb);
 }
 EXPORT_SYMBOL_GPL(register_die_notifier);
diff --git a/mm/nommu.c b/mm/nommu.c
index 99b7ec318824..3b67bd20c2af 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -359,10 +359,14 @@ void vm_unmap_aliases(void)
 EXPORT_SYMBOL_GPL(vm_unmap_aliases);
 
 /*
- * Implement a stub for vmalloc_sync_all() if the architecture chose not to
- * have one.
+ * Implement a stub for vmalloc_sync_[un]mapping() if the architecture
+ * chose not to have one.
  */
-void __weak vmalloc_sync_all(void)
+void __weak vmalloc_sync_mappings(void)
+{
+}
+
+void __weak vmalloc_sync_unmappings(void)
 {
 }
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a3c70e275f4e..c0be707db434 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1259,7 +1259,7 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	 * First make sure the mappings are removed from all page-tables
 	 * before they are freed.
 	 */
-	vmalloc_sync_all();
+	vmalloc_sync_unmappings();
 
 	/*
 	 * TODO: to calculate a flush range without looping.
@@ -3050,16 +3050,19 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 EXPORT_SYMBOL(remap_vmalloc_range);
 
 /*
- * Implement a stub for vmalloc_sync_all() if the architecture chose not to
- * have one.
+ * Implement stubs for vmalloc_sync_[un]mappings () if the architecture chose
+ * not to have one.
  *
  * The purpose of this function is to make sure the vmalloc area
  * mappings are identical in all page-tables in the system.
  */
-void __weak vmalloc_sync_all(void)
+void __weak vmalloc_sync_mappings(void)
 {
 }
 
+void __weak vmalloc_sync_unmappings(void)
+{
+}
 
 static int f(pte_t *pte, unsigned long addr, void *data)
 {
-- 
2.16.4

