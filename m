Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA364568E3
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Nov 2021 05:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhKSEGu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 23:06:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:36844 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhKSEGt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 23:06:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234588655"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="234588655"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 20:03:48 -0800
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="455615417"
Received: from jchun-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.86.248])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 20:03:47 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2] x86: Skip WBINVD instruction for VM guest
Date:   Thu, 18 Nov 2021 20:03:30 -0800
Message-Id: <20211119040330.4013045-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YZPbQVwWOJCrAH78@zn.tnic>
References: <YZPbQVwWOJCrAH78@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI mandates that CPU caches be flushed before entering any sleep
state. This ensures that the CPU and its caches can be powered down
without losing data.

ACPI-based VMs have maintained this sleep-state-entry behavior.
However, cache flushing for VM sleep state entry is useless. Unlike on
bare metal, guest sleep states are not correlated with potential data
loss of any kind; the host is responsible for data preservation. In
fact, some KVM configurations simply skip the cache flushing
instruction (see need_emulate_wbinvd()).

Further, on TDX systems, the WBINVD instruction causes an
unconditional #VE exception.  If this cache flushing remained, it would
need extra code in the form of a #VE handler.

All use of ACPI_FLUSH_CPU_CACHE() appears to be in sleep-state-related
code.

This means that the ACPI use of WBINVD is at *best* superfluous.

Disable ACPI CPU cache flushing on all X86_FEATURE_HYPERVISOR systems,
which includes TDX.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Used cpu_feature_enabled() instead of boot_cpu_has().

 arch/x86/include/asm/acenv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 9aff97f0de7f..dba05c74bd7e 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -10,10 +10,15 @@
 #define _ASM_X86_ACENV_H
 
 #include <asm/special_insns.h>
+#include <asm/cpu.h>
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+#define ACPI_FLUSH_CPU_CACHE()					\
+do {								\
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))	\
+		wbinvd();					\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
-- 
2.25.1

