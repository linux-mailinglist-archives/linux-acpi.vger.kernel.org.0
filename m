Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4F5432870
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhJRU2G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 16:28:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:28503 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhJRU2F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 16:28:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="215522873"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="215522873"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 13:25:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="493758206"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 13:25:51 -0700
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
Subject: [PATCH v10 7/7] x86/sgx: Add check for SGX pages to ghes_do_memory_failure()
Date:   Mon, 18 Oct 2021 13:25:42 -0700
Message-Id: <20211018202542.584115-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018202542.584115-1-tony.luck@intel.com>
References: <20211011185924.374213-1-tony.luck@intel.com>
 <20211018202542.584115-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

SGX EPC pages do not have a "struct page" associated with them so the
pfn_valid() sanity check fails and results in a warning message to
the console.

Add an additional check to skip the warning if the address of the error
is in an SGX EPC page.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 0c8330ed1ffd..0c5c9acc6254 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -449,7 +449,7 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 		return false;
 
 	pfn = PHYS_PFN(physical_addr);
-	if (!pfn_valid(pfn)) {
+	if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 		"Invalid address in generic error data: %#llx\n",
 		physical_addr);
-- 
2.31.1

