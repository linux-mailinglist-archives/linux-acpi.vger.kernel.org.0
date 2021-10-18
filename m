Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273E343286E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbhJRU2F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 16:28:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:28503 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233190AbhJRU2C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 16:28:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="215522867"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="215522867"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 13:25:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="493758185"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 13:25:50 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH v10 4/7] x86/sgx: Add SGX infrastructure to recover from poison
Date:   Mon, 18 Oct 2021 13:25:39 -0700
Message-Id: <20211018202542.584115-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018202542.584115-1-tony.luck@intel.com>
References: <20211011185924.374213-1-tony.luck@intel.com>
 <20211018202542.584115-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Provide a recovery function sgx_memory_failure(). If the poison was
consumed synchronously then send a SIGBUS. Note that the virtual
address of the access is not included with the SIGBUS as is the case
for poison outside of SGX enclaves. This doesn't matter as addresses
of code/data inside an enclave is of little to no use to code executing
outside the (now dead) enclave.

Poison found in a free page results in the page being moved from the
free list to the per-node poison page list.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index e5fcb8354bcc..231c494dfd40 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -693,6 +693,82 @@ bool arch_is_platform_page(u64 paddr)
 }
 EXPORT_SYMBOL_GPL(arch_is_platform_page);
 
+static struct sgx_epc_page *sgx_paddr_to_page(u64 paddr)
+{
+	struct sgx_epc_section *section;
+
+	section = xa_load(&sgx_epc_address_space, paddr);
+	if (!section)
+		return NULL;
+
+	return &section->pages[PFN_DOWN(paddr - section->phys_addr)];
+}
+
+/*
+ * Called in process context to handle a hardware reported
+ * error in an SGX EPC page.
+ * If the MF_ACTION_REQUIRED bit is set in flags, then the
+ * context is the task that consumed the poison data. Otherwise
+ * this is called from a kernel thread unrelated to the page.
+ */
+int arch_memory_failure(unsigned long pfn, int flags)
+{
+	struct sgx_epc_page *page = sgx_paddr_to_page(pfn << PAGE_SHIFT);
+	struct sgx_epc_section *section;
+	struct sgx_numa_node *node;
+
+	/*
+	 * mm/memory-failure.c calls this routine for all errors
+	 * where there isn't a "struct page" for the address. But that
+	 * includes other address ranges besides SGX.
+	 */
+	if (!page)
+		return -ENXIO;
+
+	/*
+	 * If poison was consumed synchronously. Send a SIGBUS to
+	 * the task. Hardware has already exited the SGX enclave and
+	 * will not allow re-entry to an enclave that has a memory
+	 * error. The signal may help the task understand why the
+	 * enclave is broken.
+	 */
+	if (flags & MF_ACTION_REQUIRED)
+		force_sig(SIGBUS);
+
+	section = &sgx_epc_sections[page->section];
+	node = section->node;
+
+	spin_lock(&node->lock);
+
+	/* Already poisoned? Nothing more to do */
+	if (page->poison)
+		goto out;
+
+	page->poison = 1;
+
+	/*
+	 * If the page is on a free list, move it to the per-node
+	 * poison page list.
+	 */
+	if (page->flags & SGX_EPC_PAGE_IS_FREE) {
+		list_move(&page->list, &node->sgx_poison_page_list);
+		goto out;
+	}
+
+	/*
+	 * TBD: Add additional plumbing to enable pre-emptive
+	 * action for asynchronous poison notification. Until
+	 * then just hope that the poison:
+	 * a) is not accessed - sgx_free_epc_page() will deal with it
+	 *    when the user gives it back
+	 * b) results in a recoverable machine check rather than
+	 *    a fatal one
+	 */
+out:
+	spin_unlock(&node->lock);
+	return 0;
+}
+
 /**
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
-- 
2.31.1

