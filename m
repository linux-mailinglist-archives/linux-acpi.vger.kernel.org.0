Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ECC43286A
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 22:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhJRU2C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 16:28:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:28503 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhJRU2B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Oct 2021 16:28:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="215522861"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="215522861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 13:25:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="493758159"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 13:25:49 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        naoya.horiguchi@nec.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>, linux-sgx@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 0/7] Basic recovery for machine checks inside SGX
Date:   Mon, 18 Oct 2021 13:25:35 -0700
Message-Id: <20211018202542.584115-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211011185924.374213-1-tony.luck@intel.com>
References: <20211011185924.374213-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

v10 (based on v5.15-rc6)

Changes since v9:

ACPI reviewers (Rafael): No changes to parts 6 & 7.

MM reviewers (Horiguchi-san): No changes to part 5.

Jarkko:
	Added Reviewed-by tags to remaining patches.
	N.B. I kept the tags on parts 1, 3, 4 because
	changes based on Sean feedback didn't seem
	consequential. Please let me know if you disagree
	and see new problems introduced by me trying to
	follow Sean's feedback.

Sean:
	1) Reverse the polarity of the neutron flow (sorry,
	Dr Who fan will always autocomplete a sentence that
	begins "reverse the polarity" that way.) Actual change
	is for the new flag bit. Instead of marking in-use
	pages with the new bit, mark free pages instead. This
	avoids the weirdness where I marked the pages on the
	dirty list as "in-use", when clearly they are not.

	2) Race conditions adding poisoned pages to the global
	list of poisoned pages.
	Fixed this by changing from a global list to a per-node
	list. Additions are protected by the node->lock.

	3) Use list_move() instead of list_del(); list_add()
	Fixed both places I used this idiom.

	4) Race looking at page->poison when cleaning dirty pages.
	Added a comment documenting why losing this race isn't
	overly harmful.

Tony Luck (7):
  x86/sgx: Add new sgx_epc_page flag bit to mark free pages
  x86/sgx: Add infrastructure to identify SGX EPC pages
  x86/sgx: Initial poison handling for dirty and free pages
  x86/sgx: Add SGX infrastructure to recover from poison
  x86/sgx: Hook arch_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation
  x86/sgx: Add check for SGX pages to ghes_do_memory_failure()

 .../firmware-guide/acpi/apei/einj.rst         |  19 +++
 arch/x86/include/asm/processor.h              |   8 ++
 arch/x86/include/asm/set_memory.h             |   4 +
 arch/x86/kernel/cpu/sgx/main.c                | 113 +++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |   7 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 drivers/acpi/apei/ghes.c                      |   2 +-
 include/linux/mm.h                            |  14 +++
 mm/memory-failure.c                           |  19 ++-
 9 files changed, 179 insertions(+), 10 deletions(-)


base-commit: 519d81956ee277b4419c723adfb154603c2565ba
-- 
2.31.1

