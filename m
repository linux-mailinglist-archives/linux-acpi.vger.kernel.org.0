Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50F443BCC7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 00:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbhJZWED (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 18:04:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:57935 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239728AbhJZWEC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Oct 2021 18:04:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="216934482"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="216934482"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 15:00:59 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497555750"
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
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v11 0/7] Basic recovery for machine checks inside SGX
Date:   Tue, 26 Oct 2021 15:00:43 -0700
Message-Id: <20211026220050.697075-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211018202542.584115-1-tony.luck@intel.com>
References: <20211018202542.584115-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Boris,

I took this series out of lkml/x86 for a few revisions, I think
the last one posted to lkml was v5. So much has changed since then
that it might be easier to just look at this as if it were v1 and
ignore the earlier history.

First four patches add infrastructure within the SGX code to
track enclave pages (because these pages don't have a "struct
page" as they aren't directly accessible by Linux). All have
"Reviewed-by" tags from Jarkko (SGX maintainer).

Patch 5 hooks into memory_failure() to invoke recovery if
the physical address is in enclave space. This has a
"Reviewed-by" tag from Naoya Horiguchi the maintainer for
mm/memory-failure.c

Patch 6 is a hook into the error injection code and addition
to the error injection documentation explaining extra steps
needed to inject into SGX enclave memory.

Patch 7 is a hook into GHES error reporting path to recognize
that SGX enclave addresses are valid and need processing.

-Tony

Tony Luck (7):
  x86/sgx: Add new sgx_epc_page flag bit to mark free pages
  x86/sgx: Add infrastructure to identify SGX EPC pages
  x86/sgx: Initial poison handling for dirty and free pages
  x86/sgx: Add SGX infrastructure to recover from poison
  x86/sgx: Hook arch_memory_failure() into mainline code
  x86/sgx: Add hook to error injection address validation
  x86/sgx: Add check for SGX pages to ghes_do_memory_failure()

 .../firmware-guide/acpi/apei/einj.rst         |  19 +++
 arch/x86/Kconfig                              |   1 +
 arch/x86/include/asm/processor.h              |   8 ++
 arch/x86/include/asm/set_memory.h             |   4 +
 arch/x86/kernel/cpu/sgx/main.c                | 113 +++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                 |   7 +-
 drivers/acpi/apei/einj.c                      |   3 +-
 drivers/acpi/apei/ghes.c                      |   2 +-
 include/linux/mm.h                            |  13 ++
 mm/memory-failure.c                           |  19 ++-
 10 files changed, 179 insertions(+), 10 deletions(-)


base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
-- 
2.31.1

