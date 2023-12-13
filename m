Return-Path: <linux-acpi+bounces-2254-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D080BBCE
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Dec 2023 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AB2B20A0B
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Dec 2023 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9314F6C;
	Sun, 10 Dec 2023 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOnu8ib1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B9FA;
	Sun, 10 Dec 2023 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702219180; x=1733755180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vZQoWNlvUytP34lGQnPLapbQ8i70uET28Hp4eaTV6Iw=;
  b=OOnu8ib1tlin9o13oQJRhua1AzserXN0dYvncm5sdA2X7M0MR/UuQiRx
   3c9T3p/M89QxMB+bdl3XXQ2HElgpEfrv+Mqax2YgDq8N4fHNtJD0NnxJp
   9/RTpGGjSqHdajl1/h2t/Zh/qOIBpFcg7jrOZV65zzkllRfKa8n8Nj4Uq
   QU15GcHU/39sYPegcc2F3LfK+TyaNXhHD7PhhgCLiLb7bePsyRs5/Ak1A
   AZycUzJ7QRKglaG79h0Wb2T5sRDnTklpR3B6E+hR6QCYPglwWhoS+IkYc
   rQq7Mm+NYHYhYd8RbrgAi4X1w+NqoRiU4uGne6XrMfkWRAJUk1tu9jC+5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="374064421"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="374064421"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 06:39:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1019911255"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="1019911255"
Received: from lchen43-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.209.172])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 06:39:35 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	x86@kernel.org,
	peterz@infradead.org,
	jsperbeck@google.com,
	andres@anarazel.de
Subject: [PATCH] x86/acpi: Do strict X2APIC ID check only when LAPIC contains enabled CPUs
Date: Sun, 10 Dec 2023 22:39:25 +0800
Message-Id: <20231210143925.38722-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8e9c42d776d6 ("x86/acpi: Ignore invalid x2APIC entries") does
strict X2APIC ID check when LAPIC contains valid CPUs. The code assumes
LAPIC contains valid CPUs when acpi_table_parse_madt(LAPIC) returns a
postive value.

This is wrong because acpi_table_parse_madt() return value only
represents the number of legal entries parsed. For example, LAPIC entry
with LAPIC ID 0xff is counted as a legal entry, but it doesn't describe
a valid CPU. And when all LAPIC entries have LAPIC ID 0xff, the return
value is positive but LAPIC does not contain any valid CPU. In this
case, kernel erroneously does strict X2APIC ID check and loses the CPUs
described in X2APIC entries.

Fix the problem by doing strict X2APIC ID check less aggressively, say
only when LAPIC contains enabled CPUs.

Fixes: 8e9c42d776d6 ("x86/acpi: Ignore invalid x2APIC entries")
Reported-by: John Sperbeck <jsperbeck@google.com>
Closes: https://lore.kernel.org/all/20231122221947.781812-1-jsperbeck@google.com/
Tested-by: John Sperbeck <jsperbeck@google.com>
Reported-by: Andres Freund <andres@anarazel.de>
Closes: https://lore.kernel.org/all/20231206065850.hs7k554v6wym7gw5@awork3.anarazel.de/
Tested-by: Andres Freund <andres@anarazel.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/acpi/boot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1a0dd80d81ac..c6495ebca91a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -266,6 +266,7 @@ static int __init
 acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 {
 	struct acpi_madt_local_apic *processor = NULL;
+	int cpu;
 
 	processor = (struct acpi_madt_local_apic *)header;
 
@@ -289,9 +290,13 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	acpi_register_lapic(processor->id,	/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	cpu = acpi_register_lapic(processor->id,	/* APIC ID */
+				  processor->processor_id, /* ACPI ID */
+				  processor->lapic_flags & ACPI_MADT_ENABLED);
+
+	/* Do strict X2APIC ID check only when LAPIC contains enabled CPUs */
+	if (cpu >= 0)
+		has_lapic_cpus = true;
 
 	return 0;
 }
@@ -1134,7 +1139,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	if (!count) {
 		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
 					acpi_parse_lapic, MAX_LOCAL_APIC);
-		has_lapic_cpus = count > 0;
 		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
 					acpi_parse_x2apic, MAX_LOCAL_APIC);
 	}
-- 
2.34.1


