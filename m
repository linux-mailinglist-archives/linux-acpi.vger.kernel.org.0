Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C582C42972B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbhJKTBf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 15:01:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:7163 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230394AbhJKTBd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 15:01:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="214094069"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="214094069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:59:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="562329863"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:59:31 -0700
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
Subject: [PATCH v9 1/7] x86/sgx: Add new sgx_epc_page flag bit to mark in-use pages
Date:   Mon, 11 Oct 2021 11:59:18 -0700
Message-Id: <20211011185924.374213-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011185924.374213-1-tony.luck@intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
 <20211011185924.374213-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGX EPC pages go through the following life cycle:

        DIRTY ---> FREE ---> IN-USE --\
                    ^                 |
                    \-----------------/

Recovery action for poison for a DIRTY or FREE page is simple. Just
make sure never to allocate the page. IN-USE pages need some extra
handling.

Add a new flag bit SGX_EPC_PAGE_IN_USE that is set when a page
is allocated and cleared when the page is freed.

Notes:

1) These transitions are made while holding the node->lock so that
   future code that checks the flags while holding the node->lock
   can be sure that if the SGX_EPC_PAGE_IN_USE bit is set, then the
   page is on the free list.

2) Initially while the pages are on the dirty list the
   SGX_EPC_PAGE_IN_USE bit is set.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 4 +++-
 arch/x86/kernel/cpu/sgx/sgx.h  | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..d18988a46c13 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -472,6 +472,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 	page = list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
 	sgx_nr_free_pages--;
+	page->flags = SGX_EPC_PAGE_IN_USE;
 
 	spin_unlock(&node->lock);
 
@@ -626,6 +627,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
+	page->flags = 0;
 
 	spin_unlock(&node->lock);
 }
@@ -651,7 +653,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 
 	for (i = 0; i < nr_pages; i++) {
 		section->pages[i].section = index;
-		section->pages[i].flags = 0;
+		section->pages[i].flags = SGX_EPC_PAGE_IN_USE;
 		section->pages[i].owner = NULL;
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628acec0009..f9202d3d6278 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -26,6 +26,9 @@
 /* Pages, which are being tracked by the page reclaimer. */
 #define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
 
+/* Allocated pages */
+#define SGX_EPC_PAGE_IN_USE		BIT(1)
+
 struct sgx_epc_page {
 	unsigned int section;
 	unsigned int flags;
-- 
2.31.1

