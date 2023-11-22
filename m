Return-Path: <linux-acpi+bounces-1754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E1E7F4D1E
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A251C209A8
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3359D4D103
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofb0cSwW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3408B4CDEA
	for <linux-acpi@vger.kernel.org>; Wed, 22 Nov 2023 15:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A5DC433A9;
	Wed, 22 Nov 2023 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700667287;
	bh=ApWZ3asiJZxmCLPaFMSAJuCUuvsOI/gQJG1FVuql0Z4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ofb0cSwWedHXtlYbQVZtfiSthcmdvjrho1371f+XwhlEne5t/HukIVT7RgwYH7pUG
	 RJygkEoM/veILdgC4PFZ2OURDUm1Mw+CpQECjkrVDGtDmQg8yLNEoEo80r+CXkvzlg
	 2aS8NE9mIEhPWqBeSWePn6tVhpUEfkxyJ4XqhS0KrRz9yTTpHCGczjkyHIl5ypsYbZ
	 nCduawf9Pzb00dJ8r7HVUZVO1FnJc/3eGjjZ3Q0rSklxFT8z2rY3/mdvil95VTePX7
	 SJ7YvwN4t8E5S+H2vMIRcchLcw1YHJIZmKocGvrvoT2O97V7njuQWp9a/5C3FYp1LB
	 SRNMY9Ce8KLvw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 1/9] x86/acpi: Ignore invalid x2APIC entries
Date: Wed, 22 Nov 2023 10:34:25 -0500
Message-ID: <20231122153440.852807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.63
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit ec9aedb2aa1ab7ac420c00b31f5edc5be15ec167 ]

Currently, the kernel enumerates the possible CPUs by parsing both ACPI
MADT Local APIC entries and x2APIC entries. So CPUs with "valid" APIC IDs,
even if they have duplicated APIC IDs in Local APIC and x2APIC, are always
enumerated.

Below is what ACPI MADT Local APIC and x2APIC describes on an
Ivebridge-EP system,

[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
[02Fh 0047   1]                Local Apic ID : 00
...
[164h 0356   1]                Subtable Type : 00 [Processor Local APIC]
[167h 0359   1]                Local Apic ID : 39
[16Ch 0364   1]                Subtable Type : 00 [Processor Local APIC]
[16Fh 0367   1]                Local Apic ID : FF
...
[3ECh 1004   1]                Subtable Type : 09 [Processor Local x2APIC]
[3F0h 1008   4]                Processor x2Apic ID : 00000000
...
[B5Ch 2908   1]                Subtable Type : 09 [Processor Local x2APIC]
[B60h 2912   4]                Processor x2Apic ID : 00000077

As a result, kernel shows "smpboot: Allowing 168 CPUs, 120 hotplug CPUs".
And this wastes significant amount of memory for the per-cpu data.
Plus this also breaks https://lore.kernel.org/all/87edm36qqb.ffs@tglx/,
because __max_logical_packages is over-estimated by the APIC IDs in
the x2APIC entries.

According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure:

  "[Compatibility note] On some legacy OSes, Logical processors with APIC
   ID values less than 255 (whether in XAPIC or X2APIC mode) must use the
   Processor Local APIC structure to convey their APIC information to OSPM,
   and those processors must be declared in the DSDT using the Processor()
   keyword. Logical processors with APIC ID values 255 and greater must use
   the Processor Local x2APIC structure and be declared using the Device()
   keyword."

Therefore prevent the registration of x2APIC entries with an APIC ID less
than 255 if the local APIC table enumerates valid APIC IDs.

[ tglx: Simplify the logic ]

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230702162802.344176-1-rui.zhang@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/acpi/boot.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 2252340b2133e..14af7fbdc6b5e 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -62,6 +62,7 @@ int acpi_fix_pin2_polarity __initdata;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
+static bool has_lapic_cpus __initdata;
 static bool acpi_support_online_capable;
 #endif
 
@@ -235,6 +236,14 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	if (!acpi_is_processor_usable(processor->lapic_flags))
 		return 0;
 
+	/*
+	 * According to https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-local-x2apic-structure
+	 * when MADT provides both valid LAPIC and x2APIC entries, the APIC ID
+	 * in x2APIC must be equal or greater than 0xff.
+	 */
+	if (has_lapic_cpus && apic_id < 0xff)
+		return 0;
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
@@ -1114,10 +1123,7 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 
 static int __init acpi_parse_madt_lapic_entries(void)
 {
-	int count;
-	int x2count = 0;
-	int ret;
-	struct acpi_subtable_proc madt_proc[2];
+	int count, x2count = 0;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
@@ -1126,21 +1132,11 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		memset(madt_proc, 0, sizeof(madt_proc));
-		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
-		madt_proc[0].handler = acpi_parse_lapic;
-		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
-		madt_proc[1].handler = acpi_parse_x2apic;
-		ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
-				sizeof(struct acpi_table_madt),
-				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
-		if (ret < 0) {
-			pr_err("Error parsing LAPIC/X2APIC entries\n");
-			return ret;
-		}
-
-		count = madt_proc[0].count;
-		x2count = madt_proc[1].count;
+		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
+					acpi_parse_lapic, MAX_LOCAL_APIC);
+		has_lapic_cpus = count > 0;
+		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
+					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
-- 
2.42.0


