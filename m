Return-Path: <linux-acpi+bounces-6883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C658E9311FE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 12:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2CC285BDE
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jul 2024 10:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD6E187336;
	Mon, 15 Jul 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwE1qXGb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A6187323;
	Mon, 15 Jul 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038150; cv=none; b=lYmlGgeCpO28zqMTctkrGVglzTU3uklb4QS0xPrjAFIf3AY2qnQIWcpqVkki8WOArmuupxHD3tKORKoB17hv4gX1093uU1SExaaTJ4TUhTi2fC3fOo+BKUVMeukNVsdHXqQy1GIhVgj5bgCYxSMBuK29WyC5aF0Hd7qzfOdgbQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038150; c=relaxed/simple;
	bh=BlPnXXaG0MPVBPZx1o0DOll7X8gCj7KLAbpU80OhlvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5wXQW5HZCsfOyZA6uQMbZLHAlgZBMAp6tG8WqQk3xb1uODfu5vIrT/rrSbdJLCfdc4V1zER3Zw2oGZTJw0mEk9TDVz1LmwPH4HBc/D0Uckb0S4MNs9CpKcDQVKkrcPSLwp+4idgVnUj16spmvjPH3dy9jLHGHWW4R6VMkKe2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwE1qXGb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721038149; x=1752574149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BlPnXXaG0MPVBPZx1o0DOll7X8gCj7KLAbpU80OhlvE=;
  b=iwE1qXGbysYlU4j0j6JvOADJjyfpCxw2OPdoIwHQj0M/vC3bZ1rW7MPo
   j/x3NhVM2TpEh93t4tTKEw6I3QchmQRCR8aVB5G4D7EF096JjUy3Fwoq9
   0yXcskQqCeDZG/PQrJin3xjCy0g4ajmjnX87xjq1hdZu3E4tStA7sLGb+
   +8LNd1OnQoAxPLldLP1yFeTiiABionumAL6jgP6Qa5vpXfjoZfPNDxMWe
   USaSX/o4P4gjXKlqrjbyaB9PLrAfZ3tbORWAOQ6+IMC7KEx/smPRQNaFU
   c7BCzZuEVBoSMZ6uQhOY9ermWGjcVDs0+/zb9L7GrmTDhL7VqvO6iKuQq
   w==;
X-CSE-ConnectionGUID: gEtHNMDfRvm7s0bkZDYFdA==
X-CSE-MsgGUID: hMjJ3VrHThSehJUvbQoywQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18524485"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18524485"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:09:08 -0700
X-CSE-ConnectionGUID: JGyEEKk/R/qkbfvZ3mdaPQ==
X-CSE-MsgGUID: zpGyAoR9R+euIeoX4wrDeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49663398"
Received: from unknown (HELO zhiquan-linux-dev.bj.intel.com) ([10.238.156.102])
  by fmviesa010.fm.intel.com with ESMTP; 15 Jul 2024 03:09:04 -0700
From: Zhiquan Li <zhiquan1.li@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com,
	x86@kernel.org
Cc: rafael@kernel.org,
	hpa@zytor.com,
	kai.huang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v4] x86/acpi: fix panic while AP online later with kernel parameter maxcpus=1
Date: Mon, 15 Jul 2024 18:08:35 +0800
Message-Id: <20240715100835.1817344-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue was found on the platform that using "Multiprocessor Wakeup
Structure"[1] to startup secondary CPU, which is usually used by
encrypted guest.  Before waking up the APs, BSP should memremap() the
physical address of the MP Wakeup Structure mailbox to the variable
acpi_mp_wake_mailbox, which holds the virtual address of mailbox.  When
BSP needs to wake up the APs, it writes the APIC ID of APs, wakeup
vector, and the ACPI_MP_WAKE_COMMAND_WAKEUP command into the mailbox.

Current implementation doesn't consider the case that restrict boot time
CPU to 1 with the kernel parameter "maxcpus=1" and bring other CPUs
online later, the variable acpi_mp_wake_mailbox will be set as read-only
after init.  So when the first AP gets online after init, the attempt to
update the variable results in panic.

The memremap() call that initializes the variable cannot be moved into
acpi_parse_mp_wake() because memremap() is not functional at that point
in the boot process.  Moreover, the APs might never be brought up, keep
the memremap() call in acpi_wakeup_cpu() so that the operation only
takes place on demand.

[1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
    the "Multiprocessor Wakeup Structure" section.

Fixes: 24dd05da8c79 ("x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init")
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

---

V3: https://lore.kernel.org/all/20240702005800.622910-1-zhiquan1.li@intel.com/

Changes since V3:
- Add Fixes tag for the commit found by Kai.
- Extend the commit message for the root cause and solution.

V2: https://lore.kernel.org/all/20240628082119.357735-1-zhiquan1.li@intel.com/

Changes since V2:
- Modify the commit log as suggested by Kirill.
- Add Kirill's Reviewed-by tag.

V1: https://lore.kernel.org/all/20240626073920.176471-1-zhiquan1.li@intel.com/

Changes since V1:
- Amend the commit message as per Kirill's comments.
- Remove the oops message.
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6cfe762be28b..d5ef6215583b 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -19,7 +19,7 @@
 static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
 
 static u64 acpi_mp_pgd __ro_after_init;
 static u64 acpi_mp_reset_vector_paddr __ro_after_init;

base-commit: c1ef42a985f0244201ca589f9e5b814b1dc63a07
-- 
2.25.1


