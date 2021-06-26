Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCB3B4EEF
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Jun 2021 16:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhFZOY4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 26 Jun 2021 10:24:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:10776 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhFZOYw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 26 Jun 2021 10:24:52 -0400
IronPort-SDR: xqP8DXa8XQHivQ1ff/kU2HkCuSP6JDK63grjuuVDXdAw7CUwqETazYa2qsDsEj4jgieDGBtEwP
 plRD1uHZ8cBg==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207828227"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207828227"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:22:28 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="640382648"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:22:28 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 5/5] x86: Skip WBINVD instruction for VM guest
Date:   Sat, 26 Jun 2021 07:22:13 -0700
Message-Id: <178da14b6e77c7ab87ba5fd8ad121ab10dcae2e3.1624666915.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624666915.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624666915.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

VM guests that supports ACPI, use standard ACPI mechanisms to signal
sleep state entry (including reboot) to the host. The ACPI
specification mandates WBINVD on any sleep state entry with the
expectation that the platform is only responsible for maintaining the
state of memory over sleep states, not preserving dirty data in any
CPU caches. ACPI cache flushing requirements pre-date the advent of
virtualization. Given guest sleep state entry does not affect any
host power rails it is not required to flush caches. The host is
responsible for maintaining cache state over its own bare metal sleep
state transitions that power-off the cache. A TDX guest, unlike a
typical guest, will machine check if the CPU cache is powered off.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/acenv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 9aff97f0de7f..d4162e94bee8 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -10,10 +10,15 @@
 #define _ASM_X86_ACENV_H
 
 #include <asm/special_insns.h>
+#include <asm/cpu.h>
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+#define ACPI_FLUSH_CPU_CACHE()				\
+do {							\
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))	\
+		wbinvd();				\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
-- 
2.25.1

