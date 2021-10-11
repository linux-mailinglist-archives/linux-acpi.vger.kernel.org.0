Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338E7429729
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhJKTBe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 15:01:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:7163 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhJKTBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 15:01:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="214094067"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="214094067"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:59:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="562329859"
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
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 0/7] Basic recovery for machine checks inside SGX
Date:   Mon, 11 Oct 2021 11:59:17 -0700
Message-Id: <20211011185924.374213-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001164724.220532-1-tony.luck@intel.com>
References: <20211001164724.220532-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Posting latest version to a slightly wider audience.

The big picture is that SGX uses some memory pages that are walled off
from access by the OS. This means they:
1) Don't have "struct page" describing them
2) Don't appear in the kernel 1:1 map

But they are still backed by normal DDR memory, so errors can occur.

Parts 1-4 of this series handle the internal SGX bits to keep track of
these pages in an error context. They've had a fair amount of review
on the linux-sgx list (but if any of the 37 subscribers to that list
not named Jarkko or Reinette want to chime in with extra comments and
{Acked,Reviewed,Tested}-by that would be great).

Linux-mm reviewers can (if they like) skip to part 5 where two changes are
made: 1) Hook into memory_failure() in the same spot as device mapping 2)
Skip trying to change 1:1 map (since SGX pages aren't there).

The hooks have generic looking names rather than specifically saying
"sgx" at the suggestion of Dave Hansen. I'm not wedded to the names,
so better suggestions welcome.  I could also change to using some
"ARCH_HAS_PLATFORM_PAGES" config bits if that's the current fashion.

Rafael (and other ACPI list readers) can skip to parts 6 & 7 where there
are hooks into error injection and reporting to simply say "these odd
looking physical addresses are actually ok to use). I added some extra
notes to the einj.rst documentation on how to inject into SGX memory.

Tony Luck (7):
  x86/sgx: Add new sgx_epc_page flag bit to mark in-use pages
  x86/sgx: Add infrastructure to identify SGX EPC pages
  x86/sgx: Initial poison handling for dirty and free pages
  x86/sgx: Add SGX infrastructure to recover from poison
  x86/sgx: Hook arch_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation
  x86/sgx: Add check for SGX pages to ghes_do_memory_failure()

 .../firmware-guide/acpi/apei/einj.rst         |  19 ++++
 arch/x86/include/asm/processor.h              |   8 ++
 arch/x86/include/asm/set_memory.h             |   4 +
 arch/x86/kernel/cpu/sgx/main.c                | 104 +++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |   6 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 drivers/acpi/apei/ghes.c                      |   2 +-
 include/linux/mm.h                            |  14 +++
 mm/memory-failure.c                           |  19 +++-
 9 files changed, 168 insertions(+), 11 deletions(-)


base-commit: 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
-- 
2.31.1

