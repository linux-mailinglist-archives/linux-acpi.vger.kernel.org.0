Return-Path: <linux-acpi+bounces-8891-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 268EA9A949E
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 02:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968491F235BC
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 00:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00F617991;
	Tue, 22 Oct 2024 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9x6GQ5T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F09323D;
	Tue, 22 Oct 2024 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556258; cv=none; b=drYxmgLWhiAzjt8ISboZJBDES0Z0nw9y6+EZJDg1W3IKxRpdPLW780GnkQKeieOfFztM/UBIuD2tNpCCgFNZ9rI7qkzT7GWgfoIgEJQC/MANQG9hNvE/gZU+onZ0x1pj3AJgeT+bm63NWeVfDyizjxgzn25y8choM6xmSb0SNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556258; c=relaxed/simple;
	bh=8foRClbi0ov1PrOIWtTzAzLs+dOjfgrS1ihOVOBOuKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QFSYl9XpwUhA7PMqu30tpX802c3ab2zoIK3iuAeoM+c94YebWppKvBckdkjrLFRTatXzt1OMnVyEpDNTUXMomKs6aK9jBV4n7bmtWn2RMIKRTUMx3h8Gp+DsfKxk0UoKYqkvVa0C+iMyOg7DPEaiKzNRvQumnLiQq5QnTZyU3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9x6GQ5T; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729556257; x=1761092257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8foRClbi0ov1PrOIWtTzAzLs+dOjfgrS1ihOVOBOuKM=;
  b=H9x6GQ5TKyypsNGi40PAlUvHuY9isUDPpcjR1YUfS89BtOftPaGO1AqD
   kaBxfWEQztzA6YfqzpFqFL/QIiYlSodf0Rvj5Z3sFxvEP+ljnZJqUC+zq
   Gt64srxithH8I2H2I/BrdfMkQ1FnpMBlaucnf2s1Lg33Nn17/O68R6ECv
   gu2lSgdgEHi7L95TdgSKDHg0rXvDX5aSmSonHnb/hLiGraKoby9xVfSGf
   ywgZ1vqb2T9YDQBqkeiOSsLRIqeVfyaUB4Tep36BWaHVmyIxqzYux6nWF
   kTacFlL/DXcahN8FdM64UllskuVGWCstDwhvQEbhWZxyejX6xS+iKRj18
   w==;
X-CSE-ConnectionGUID: Bs0WXJWdRAmO9ebABBMffQ==
X-CSE-MsgGUID: cszAtTfxQGiTv56ktLxEmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40454332"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="40454332"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:17:36 -0700
X-CSE-ConnectionGUID: TFyYhElHSGKAmhjR7QALnw==
X-CSE-MsgGUID: n0VVFdrdRYWs1zDR7t2CCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="110514238"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:17:31 -0700
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
Subject: [PATCH] x86/acpi: Fix LAPIC/x2APIC parsing order
Date: Tue, 22 Oct 2024 08:17:12 +0800
Message-Id: <20241022001712.9218-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
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

Fix the problem by separately checking LAPIC entries before parsing any
LAPIC or x2APIC entries.

1. https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#madt-processor-local-apic-sapic-structure-entry-order

Cc: stable@vger.kernel.org
Reported-by: Jim Mattson <jmattson@google.com>
Closes: https://lore.kernel.org/all/20241010213136.668672-1-jmattson@google.com/
Fixes: ec9aedb2aa1a ("x86/acpi: Ignore invalid x2APIC entries")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Tested-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kernel/acpi/boot.c | 50 +++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 4efecac49863..c70b86f1f295 100644
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
2.34.1


