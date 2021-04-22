Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7CD3688B9
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 23:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhDVVry (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 17:47:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:1514 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238922AbhDVVrx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 17:47:53 -0400
IronPort-SDR: V2I8IJ21gilyU3UmqTcc7jyZp9bPxjh5wcMbM0bbWtSCbbnukhDP90bB7Y07ONgCuAQcdI3wxM
 Zy+ERw2L+KFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="281306573"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="281306573"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:18 -0700
IronPort-SDR: vvyokabO7ctkhcBzEC/Fe/XjLB/NXP0AZuZniBQyL6oRVSzVI2Ve8oBEaLoO7ngDqAbZPbX7Fx
 URVDw34aPxmw==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="455965129"
Received: from eassadia-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.4.68])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 14:47:17 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Rafael J Wysocki <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 3/3] x86/acpi, x86/boot: Add multiprocessor wake-up support
Date:   Thu, 22 Apr 2021 14:47:08 -0700
Message-Id: <20210422214708.716164-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210422214708.716164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As per ACPI specification r6.4, sec 5.2.12.19, a new sub
structure – multiprocessor wake-up structure - is added to the
ACPI Multiple APIC Description Table (MADT) to describe the
information of the mailbox. If a platform firmware produces the
multiprocessor wake-up structure, then OS may use this new
mailbox-based mechanism to wake up the APs.

Add ACPI MADT wake table parsing support for x86 platform and if
MADT wake table is present, update apic->wakeup_secondary_cpu with
new API which uses MADT wake mailbox to wake-up CPU.

Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/apic.h     |  3 ++
 arch/x86/kernel/acpi/boot.c     | 56 +++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/probe_32.c |  8 +++++
 arch/x86/kernel/apic/probe_64.c |  8 +++++
 4 files changed, 75 insertions(+)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 412b51e059c8..3e94e1f402ea 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -487,6 +487,9 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
+typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
+extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
+
 extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 14cd3186dc77..a4a6b97910e1 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -65,6 +65,9 @@ int acpi_fix_pin2_polarity __initdata;
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static u64 acpi_mp_wake_mailbox_paddr;
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -329,6 +332,29 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	return 0;
 }
 
+static void acpi_mp_wake_mailbox_init(void)
+{
+	if (acpi_mp_wake_mailbox)
+		return;
+
+	acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+			sizeof(*acpi_mp_wake_mailbox), MEMREMAP_WB);
+}
+
+static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+{
+	acpi_mp_wake_mailbox_init();
+
+	if (!acpi_mp_wake_mailbox)
+		return -EINVAL;
+
+	WRITE_ONCE(acpi_mp_wake_mailbox->apic_id, apicid);
+	WRITE_ONCE(acpi_mp_wake_mailbox->wakeup_vector, start_ip);
+	WRITE_ONCE(acpi_mp_wake_mailbox->command, ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	return 0;
+}
+
 #endif				/*CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1086,6 +1112,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	}
 	return 0;
 }
+
+static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
+				      const unsigned long end)
+{
+	struct acpi_madt_multiproc_wakeup *mp_wake;
+
+	if (acpi_mp_wake_mailbox)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_SMP))
+		return -ENODEV;
+
+	mp_wake = (struct acpi_madt_multiproc_wakeup *) header;
+	if (BAD_MADT_ENTRY(mp_wake, end))
+		return -EINVAL;
+
+	acpi_table_print_madt_entry(&header->common);
+
+	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
+
+	acpi_wake_cpu_handler_update(acpi_wakeup_cpu);
+
+	return 0;
+}
 #endif				/* CONFIG_X86_LOCAL_APIC */
 
 #ifdef	CONFIG_X86_IO_APIC
@@ -1284,6 +1334,12 @@ static void __init acpi_process_madt(void)
 
 				smp_found_config = 1;
 			}
+
+			/*
+			 * Parse MADT MP Wake entry.
+			 */
+			acpi_table_parse_madt(ACPI_MADT_TYPE_MULTIPROC_WAKEUP,
+					      acpi_parse_mp_wake, 1);
 		}
 		if (error == -EINVAL) {
 			/*
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index a61f642b1b90..d450014841b2 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -207,3 +207,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	}
 	return 0;
 }
+
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu = handler;
+}
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index c46720f185c0..986dbb68d3c4 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -50,3 +50,11 @@ int __init default_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	}
 	return 0;
 }
+
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu = handler;
+}
-- 
2.25.1

