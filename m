Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15243BCC8
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 00:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhJZWEE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 18:04:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:57938 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239729AbhJZWEC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 18:04:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="216934484"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="216934484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 15:00:59 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497555754"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 15:00:59 -0700
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
Subject: [PATCH v11 1/7] x86/sgx: Add new sgx_epc_page flag bit to mark free pages
Date:   Tue, 26 Oct 2021 15:00:44 -0700
Message-Id: <20211026220050.697075-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026220050.697075-1-tony.luck@intel.com>
References: <20211018202542.584115-1-tony.luck@intel.com>
 <20211026220050.697075-1-tony.luck@intel.com>
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

Add a new flag bit SGX_EPC_PAGE_IS_FREE that is set when a page
is added to a free list and cleared when the page is allocated.

Notes:

1) These transitions are made while holding the node->lock so that
   future code that checks the flags while holding the node->lock
   can be sure that if the SGX_EPC_PAGE_IS_FREE bit is set, then the
   page is on the free list.

2) Initially while the pages are on the dirty list the
   SGX_EPC_PAGE_IS_FREE bit is cleared.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/sgx/main.c | 2 ++
 arch/x86/kernel/cpu/sgx/sgx.h  | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 63d3de02bbcc..825aa91516c8 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -472,6 +472,7 @@ static struct sgx_epc_page *__sgx_alloc_epc_page_from_node(int nid)
 	page = list_first_entry(&node->free_page_list, struct sgx_epc_page, list);
 	list_del_init(&page->list);
 	sgx_nr_free_pages--;
+	page->flags = 0;
 
 	spin_unlock(&node->lock);
 
@@ -626,6 +627,7 @@ void sgx_free_epc_page(struct sgx_epc_page *page)
 
 	list_add_tail(&page->list, &node->free_page_list);
 	sgx_nr_free_pages++;
+	page->flags = SGX_EPC_PAGE_IS_FREE;
 
 	spin_unlock(&node->lock);
 }
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 4628acec0009..5906471156c5 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -26,6 +26,9 @@
 /* Pages, which are being tracked by the page reclaimer. */
 #define SGX_EPC_PAGE_RECLAIMER_TRACKED	BIT(0)
 
+/* Pages on free list */
+#define SGX_EPC_PAGE_IS_FREE		BIT(1)
+
 struct sgx_epc_page {
 	unsigned int section;
 	unsigned int flags;
-- 
2.31.1

