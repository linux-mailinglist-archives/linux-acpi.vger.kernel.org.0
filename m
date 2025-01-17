Return-Path: <linux-acpi+bounces-10735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C79A14ABC
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 09:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0296F3A4DB4
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421041F868A;
	Fri, 17 Jan 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QweNCHrf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC521F6690;
	Fri, 17 Jan 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737101612; cv=none; b=lySbhKubL575rP5JQA+b+OZnP0jKGszvv4/qe4bhbs6yK791FEBjLOQ6ltQkAU8XoW25bsaHJ1N1AOCvhM13flb1Woaa0v7LyUit8zTX9HmU9KNBlMC3nxh6IzUWkdZ7hkGq2hZMk7BIXXKwMMlNHLx2r1Luu+OiKy7W3IF3eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737101612; c=relaxed/simple;
	bh=tOwORoT+ekC5F0FtPYmVRhc9L3HyViUNWRKZMXnC5nM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0lV/FCW8MGWUHD8AJELM7K9knLRfcNJBPUDFZKSp8y2oGUge96OMDjuqqmfoOyiIQ88kdiBxZml6F10UrHgIjR4Mv6genbADNKvCEflcp0Ss2Wah7pMQOGBTC1oKZoP1SVk/u8yivyXCdVoI8lUyqm1Hd/CK3Dvv9W1n2bCOnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QweNCHrf; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737101611; x=1768637611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tOwORoT+ekC5F0FtPYmVRhc9L3HyViUNWRKZMXnC5nM=;
  b=QweNCHrfyKzZbkxOz/ObxC35bEDtq+8+w28is5Zx17MY4jtwKFuIhDny
   SePxlWD1EPTQSgW6SXn6hC/xqb0ckMMJF7nigYe+M2MFdsyvhgEp56ZwT
   ZCZhjDmkPKHdCnWrv1Q4z1W3gqAuExuv24vmvxKcJ5O2C1iPzGwuWzBp/
   cW2iERMBTrYPpszg0u9OO5P8JHJ2zmPHisWDtJGjmb5aV4MmneH+2woN7
   xpFtbdhmgVxQP1aEdR+huP6ah9/fZpV9djAaB7ZLOLDUp5ABappRbRV92
   Hlb208FgWG2F3VAk8B1pOhjpJkJu0kh42ZbKaV4bOMDARhMNPK8uceet/
   w==;
X-CSE-ConnectionGUID: 1nyQnfDtTneRIP/XeDzfog==
X-CSE-MsgGUID: d+oT73vOTnSixwmtqBCR/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37219975"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="37219975"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 00:13:30 -0800
X-CSE-ConnectionGUID: eBfGnS5vQpWqvMSk8NkA/Q==
X-CSE-MsgGUID: PG9Qdf8SSkaOp8nEeLP+nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105582964"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa010.jf.intel.com with ESMTP; 17 Jan 2025 00:13:27 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: rui.zhang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jmattson@google.com
Subject: [PATCH V2] x86/acpi: Fix LAPIC/x2APIC parsing order
Date: Fri, 17 Jan 2025 16:14:20 +0800
Message-ID: <20250117081420.4046737-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems, the same CPU (with the same APIC ID) is assigned a
different logical CPU id after commit ec9aedb2aa1a ("x86/acpi: Ignore
invalid x2APIC entries").

This means that Linux enumerates the CPUs in a different order, which
violates ACPI specification[1] that states:

  "OSPM should initialize processors in the order that they appear in
   the MADT"

The problematic commit parses all LAPIC entries before any x2APIC
entries, aiming to ignore x2APIC entries with APIC ID < 255 when valid
LAPIC entries exist. However, it disrupts the CPU enumeration order on
systems where x2APIC entries precede LAPIC entries in the MADT.

Fix this problem by:
    1) Parsing LAPIC entries first without registering them in the
       topology to evaluate whether valid LAPIC entries exist.
    2) Restoring the MADT in order parser which invokes either the LAPIC
       or the X2APIC parser function depending on the entry type.

The X2APIC parser still ignores entries < 0xff in case that #1 found
valid LAPIC entries independent of their position in the MADT table.

1. https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#madt-processor-local-apic-sapic-structure-entry-order

Cc: stable@vger.kernel.org
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20241010213136.668672-1-jmattson@google.com/
Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Tested-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
Changes in V2:
 - Add Reviewed-by tag from Thomas
 - Improve changelog based on Thomas' comment 
---
 arch/x86/kernel/acpi/boot.c | 50 +++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3a44a9dc3fb7..18485170d51b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -226,6 +226,28 @@ acpi_parse_x2apic(union acpi_subtable_headers *header, const unsigned long end)
 	return 0;
 }
 
+static int __init
+acpi_check_lapic(union acpi_subtable_headers *header, const unsigned long end)
+{
+	struct acpi_madt_local_apic *processor = NULL;
+
+	processor = (struct acpi_madt_local_apic *)header;
+
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
+	/* Ignore invalid ID */
+	if (processor->id == 0xff)
+		return 0;
+
+	/* Ignore processors that can not be onlined */
+	if (!acpi_is_processor_usable(processor->lapic_flags))
+		return 0;
+
+	has_lapic_cpus = true;
+	return 0;
+}
+
 static int __init
 acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 {
@@ -257,7 +279,6 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
 			       processor->processor_id, /* ACPI ID */
 			       processor->lapic_flags & ACPI_MADT_ENABLED);
 
-	has_lapic_cpus = true;
 	return 0;
 }
 
@@ -1029,6 +1050,8 @@ static int __init early_acpi_parse_madt_lapic_addr_ovr(void)
 static int __init acpi_parse_madt_lapic_entries(void)
 {
 	int count, x2count = 0;
+	struct acpi_subtable_proc madt_proc[2];
+	int ret;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return -ENODEV;
@@ -1037,10 +1060,27 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
-					acpi_parse_lapic, MAX_LOCAL_APIC);
-		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
-					acpi_parse_x2apic, MAX_LOCAL_APIC);
+		/* Check if there are valid LAPIC entries */
+		acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC, acpi_check_lapic, MAX_LOCAL_APIC);
+
+		/*
+		 * Enumerate the APIC IDs in the order that they appear in the
+		 * MADT, no matter LAPIC entry or x2APIC entry is used.
+		 */
+		memset(madt_proc, 0, sizeof(madt_proc));
+		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
+		madt_proc[0].handler = acpi_parse_lapic;
+		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
+		madt_proc[1].handler = acpi_parse_x2apic;
+		ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+				sizeof(struct acpi_table_madt),
+				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
+		if (ret < 0) {
+			pr_err("Error parsing LAPIC/X2APIC entries\n");
+			return ret;
+		}
+		count = madt_proc[0].count;
+		x2count = madt_proc[1].count;
 	}
 	if (!count && !x2count) {
 		pr_err("No LAPIC entries present\n");
-- 
2.43.0


