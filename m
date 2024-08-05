Return-Path: <linux-acpi+bounces-7280-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD59478F8
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 12:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96654280DBB
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CC8149E05;
	Mon,  5 Aug 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKvpQNn0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F4558BC;
	Mon,  5 Aug 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852228; cv=none; b=MhL3Ank8khGkXI+0JKDB3dhjGK9T62dBA0IJKRS+SPSKtQLglbcRbPIQJcsRQxwxC8ePdXuOb8FOCk/ggMvHYN7jqWNEIOpbVI82fGBhxLPU0qzIgHo+WZi5ZprUGvjbiNPU9EGNTvGvMJDh4evhmtOuqk834JD06IJwsAkGxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852228; c=relaxed/simple;
	bh=3JzwBnYSD+Hb1vRDh4StW026ZZ8e9bKSpdTeeDfvxjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lu6rdVj7C6cGDh9HbO/b8RreQrrRTRgnUHqt0N9OUW7CMRe+Ov0jZe/YxYUezVaIdX7wuRZlK/r1+fK7dupnwsiztlb+CSgUT3/z2R5Dnwt7S1k9upu6mzliHZQ01Moe+u6sp9IQ7ZtsQeHuPp1ivBsmcUZvzqpa/6g2G6jEgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKvpQNn0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722852227; x=1754388227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3JzwBnYSD+Hb1vRDh4StW026ZZ8e9bKSpdTeeDfvxjQ=;
  b=OKvpQNn0jL4bcRLwm9nAyyXRckaxNCDzUOiPmyVFcmJx2+8IJRuOq3bA
   OBLInpEMYmQvRNCwq1JpZdTXFe8S2A8Mr6aSbi8hNaJ/+FF9Eeatxmjot
   PrEx1GDsIZb5dpDr8MhB9f5pMwAZX+UaMreogiMO2AwIV6l7K9FyFpH3+
   1hA8OGdZzUnDqFJa9rWe5XXzqsrIywVIVDfStgBBUFrpD2LraP+ZyyoxO
   718UFa/agatL123db3/PkUG8QAIGlhs5lLiFdXsz4RVFYRbMMFkDDa1LY
   nqe1QHgg68XrCa916zQQbe5c9SwLrzgX5jOpKK8G1WFOpsAOir/uiRQ9O
   Q==;
X-CSE-ConnectionGUID: A3GlJiiyS6m8XkfFyL28BA==
X-CSE-MsgGUID: Hb7WVD/4QOG4XljMu6BG8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38308021"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="38308021"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 03:03:46 -0700
X-CSE-ConnectionGUID: KP7c6d6XR5m7u9g1Ggp78Q==
X-CSE-MsgGUID: U25pGm0IQVm5dwXx5S0jyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="56058533"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by fmviesa009.fm.intel.com with ESMTP; 05 Aug 2024 03:03:43 -0700
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
Subject: [PATCH RESEND v4] x86/acpi: fix panic while AP online later with kernel parameter maxcpus=1
Date: Mon,  5 Aug 2024 18:35:31 +0800
Message-Id: <20240805103531.1230635-1-zhiquan1.li@intel.com>
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

Current implementation doesn't consider the case that restricts boot
time CPU to 1 with the kernel parameter "maxcpus=1" and brings other
CPUs online later, the variable acpi_mp_wake_mailbox will be set as
read-only after init.  So when the first AP gets online after init, the
attempt to update the variable results in panic.

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

V4 RESEND note:
- No changes on this, just rebasing as v6.11-rc1 is out.

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

base-commit: 435dfff07e5b71ceecc35954645740ab91090fbb
-- 
2.25.1


