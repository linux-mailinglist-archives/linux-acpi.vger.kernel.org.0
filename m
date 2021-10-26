Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3075243BCC4
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbhJZWEB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 18:04:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:57938 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239727AbhJZWEB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 18:04:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="216934489"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="216934489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 15:01:00 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497555765"
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
Subject: [PATCH v11 3/7] x86/sgx: Initial poison handling for dirty and free pages
Date:   Tue, 26 Oct 2021 15:00:46 -0700
Message-Id: <20211026220050.697075-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026220050.697075-1-tony.luck@intel.com>
References: <20211018202542.584115-1-tony.luck@intel.com>
 <20211026220050.697075-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A memory controller patrol scrubber can report poison in a page
that isn't currently being used.

Add "poison" field in the sgx_epc_page that can be set for an
sgx_epc_page. Check for it:
1) When sanitizing dirty pages
2) When freeing epc pages

Poison is a new field separated from flags to avoid having to make all
updates to flags atomic, or integrate poison state changes into some
other locking scheme to protect flags (Currently just sgx_reclaimer_lock
which protects the SGX_EPC_PAGE_RECLAIMER_TRACKED bit in page->flags).

In both cases place the poisoned page on a per-node list of poisoned
epc pages to make sure it will not be reallocated.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 26 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h  |  4 +++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 5c02cffdabc8..e5fcb8354bcc 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -62,6 +62,24 @@ static void __sgx_sanitize_pages(struct list_head *dirty_page_list)
 
 		page = list_first_entry(dirty_page_list, struct sgx_epc_page, list);
 
+		/*
+		 * Checking page->poison without holding the node->lock
+		 * is racy, but losing the race (i.e. poison is set just
+		 * after the check) just means __eremove() will be uselessly
+		 * called for a page that sgx_free_epc_page() will put onto
+		 * the node->sgx_poison_page_list later.
+		 */
+		if (page->poison) {
+			struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+			struct sgx_numa_node *node = section->node;
+
+			spin_lock(&node->lock);
+			list_move(&page->list, &node->sgx_poison_page_list);
+			spin_unlock(&node->lock);
+
+			continue;
+		}
+
 		ret = __eremove(sgx_get_epc_virt_addr(page));
 		if (!ret) {
 			/*
@@ -626,7 +644,11 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	spin_lock(&node->lock);
 
-	list_add_tail(&page->list, &node->free_page_list);
+	page->owner = NULL;
+	if (page->poison)
+		list_add(&page->list, &node->sgx_poison_page_list);
+	else
+		list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
 	page->flags = SGX_EPC_PAGE_IS_FREE;
 
@@ -658,6 +680,7 @@ static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
 		section->pages[i].section = index;
 		section->pages[i].flags = 0;
 		section->pages[i].owner = NULL;
+		section->pages[i].poison = 0;
 		list_add_tail(&section->pages[i].list, &sgx_dirty_page_list);
 	}
 
@@ -724,6 +747,7 @@ static bool __init sgx_page_cache_init(void)
 		if (!node_isset(nid, sgx_numa_mask)) {
 			spin_lock_init(&sgx_numa_nodes[nid].lock);
 			INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
+			INIT_LIST_HEAD(&sgx_numa_nodes[nid].sgx_poison_page_list);
 			node_set(nid, sgx_numa_mask);
 		}
 
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 5906471156c5..9ec3136c7800 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -31,7 +31,8 @@
 
 struct sgx_epc_page {
 	unsigned int section;
-	unsigned int flags;
+	u16 flags;
+	u16 poison;
 	struct sgx_encl_page *owner;
 	struct list_head list;
 };
@@ -42,6 +43,7 @@ struct sgx_epc_page {
  */
 struct sgx_numa_node {
 	struct list_head free_page_list;
+	struct list_head sgx_poison_page_list;
 	spinlock_t lock;
 };
 
-- 
2.31.1

