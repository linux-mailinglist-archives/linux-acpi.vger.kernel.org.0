Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF213CF349
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jul 2021 06:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhGTDpD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jul 2021 23:45:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:35128 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232252AbhGTDox (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jul 2021 23:44:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="272288708"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="272288708"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:25:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="494528464"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:25:27 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v7 1/1] x86/acpi, x86/boot: Add multiprocessor wake-up support
Date:   Mon, 19 Jul 2021 21:25:06 -0700
Message-Id: <20210720042506.2123009-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Rafael J. Wysocki<rafael.j.wysocki@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v6:
 * Rebased on top of v5.14-rc1.

Changes since v5:
 * None ( CCed ACPI list)

Changes since v4:
 * Used smp_store_release() in place of WRITE_ONCE().
 * Addressed some checkpatch warnings.

Changes since v3:
 * Removed acpi_mp_wake_mailbox_init() and moved init code to
   acpi_wakeup_cpu().
 * Removed redundant NULL pointer check for acpi_mp_wake_mailbox.
 * Added comments/debug prints as per Rafael's suggestion.
 * Removed MADT/SVKL ACPI patches from this patchset. It will be
   merged via ACPICA submission.

 arch/x86/include/asm/apic.h |  3 ++
 arch/x86/kernel/acpi/boot.c | 96 +++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/apic/apic.c |  8 ++++
 3 files changed, 107 insertions(+)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 48067af94678..463905172cd0 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -488,6 +488,9 @@ static inline unsigned int read_apic_id(void)
 	return apic->get_apic_id(reg);
 }
 
+typedef int (*wakeup_cpu_handler)(int apicid, unsigned long start_eip);
+extern void acpi_wake_cpu_handler_update(wakeup_cpu_handler handler);
+
 extern int default_apic_id_valid(u32 apicid);
 extern int default_acpi_madt_oem_check(char *, char *);
 extern void default_setup_apic_routing(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e55e0c1fad8c..c2df8843950d 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -64,6 +64,10 @@ int acpi_fix_pin2_polarity __initdata;
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
 #endif
 
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
+static u64 acpi_mp_wake_mailbox_paddr;
+static physid_mask_t apic_id_wakemap = PHYSID_MASK_NONE;
+
 #ifdef CONFIG_X86_IO_APIC
 /*
  * Locks related to IOAPIC hotplug
@@ -327,6 +331,68 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
 	return 0;
 }
 
+static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
+{
+	u8 timeout = 0xFF;
+
+	/* Remap mailbox memory only for the first call to acpi_wakeup_cpu() */
+	if (physids_empty(apic_id_wakemap)) {
+		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
+						sizeof(*acpi_mp_wake_mailbox),
+						MEMREMAP_WB);
+	}
+
+	/*
+	 * According to the ACPI specification r6.4, sec 5.2.12.19, the
+	 * mailbox-based wakeup mechanism cannot be used more than once
+	 * for the same CPU, so skip sending wake commands to already
+	 * awake CPU.
+	 */
+	if (physid_isset(apicid, apic_id_wakemap)) {
+		pr_err("CPU already awake (APIC ID %x), skipping wakeup\n",
+		       apicid);
+		return -EINVAL;
+	}
+
+	/*
+	 * Mailbox memory is shared between firmware and OS. Firmware will
+	 * listen on mailbox command address, and once it receives the wakeup
+	 * command, CPU associated with the given apicid will be booted. So,
+	 * the value of apic_id and wakeup_vector has to be set before updating
+	 * the wakeup command. So use smp_store_release to let the compiler know
+	 * about it and preserve the order of writes.
+	 */
+	smp_store_release(&acpi_mp_wake_mailbox->apic_id, apicid);
+	smp_store_release(&acpi_mp_wake_mailbox->wakeup_vector, start_ip);
+	smp_store_release(&acpi_mp_wake_mailbox->command,
+			  ACPI_MP_WAKE_COMMAND_WAKEUP);
+
+	/*
+	 * After writing wakeup command, wait for maximum timeout of 0xFF
+	 * for firmware to reset the command address back zero to indicate
+	 * the successful reception of command.
+	 * NOTE: 255 as timeout value is decided based on our experiments.
+	 *
+	 * XXX: Change the timeout once ACPI specification comes up with
+	 *      standard maximum timeout value.
+	 */
+	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
+		cpu_relax();
+
+	if (timeout) {
+		/*
+		 * If the CPU wakeup process is successful, store the
+		 * status in apic_id_wakemap to prevent re-wakeup
+		 * requests.
+		 */
+		physid_set(apicid, apic_id_wakemap);
+		return 0;
+	}
+
+	/* If timed out (timeout == 0), return error */
+	return -EIO;
+}
+
 #endif				/*CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
@@ -1074,6 +1140,30 @@ static int __init acpi_parse_madt_lapic_entries(void)
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
+	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
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
@@ -1269,6 +1359,12 @@ static void __init acpi_process_madt(void)
 
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
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d262811ce14b..2a5b0bd16846 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2554,6 +2554,14 @@ u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
 }
 EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
 
+void __init acpi_wake_cpu_handler_update(wakeup_cpu_handler handler)
+{
+	struct apic **drv;
+
+	for (drv = __apicdrivers; drv < __apicdrivers_end; drv++)
+		(*drv)->wakeup_secondary_cpu = handler;
+}
+
 /*
  * Override the generic EOI implementation with an optimized version.
  * Only called during early boot when only one CPU is active and with
-- 
2.25.1

