Return-Path: <linux-acpi+bounces-6723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A291EC1C
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 02:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021E31C218DA
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 00:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018FD4A29;
	Tue,  2 Jul 2024 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THXcN8xj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD53747F;
	Tue,  2 Jul 2024 00:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719881909; cv=none; b=o49IilA2mcRkblu03wAQNhYfNzUcejrvw0dm+ajLPMhKomJzIeM7CUW/N+QujCfx6utrIt80Snfp7tMLS1MFpag7/9yUVpSYmGSZJvCr8OlHfoZn64ImKExMZSoZeIKRToTugGIOdQy6rSpoaNdlM7pQA0YDxnnp88tOaStiLfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719881909; c=relaxed/simple;
	bh=Er1wpDGC44or5ssRI8CbjMXWiS2P/zgwLlcNysvBWPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fr5soYWpltHTTVB2jkzHIRmwN2e17/h/h6hG/H2bh7kjW2f78GNUbW6QLxk4rrBtR5vXFbP1woax2CM2H6yGSkKWkFe3xn60b1Zv3ogZVaEal5ZMrWNDGs6lk5qNxEu0EZU+pYv7RhYeczr6UOp6/zZz2CQxv5biUnrX2ySxJLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THXcN8xj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719881908; x=1751417908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Er1wpDGC44or5ssRI8CbjMXWiS2P/zgwLlcNysvBWPo=;
  b=THXcN8xjNCajsw4WotEsT3zFdPdIO019eG1LmoZARmJHhnRsv7UKVt1C
   YBnHjs75nqS7GBYgEBvOnNJIVTuexkX8u5ZAOPm7s9KqzxMQyMBX9wWDa
   IOvsLWK4X9RNMHBjY+H5hd2mVoeuO/98FntngSgths8otLT9OaVyzhyJI
   Z+Ii06P5lteyENSONIc2/eSSeLxs8aLVFf8IyUScyAwbXx3r2U6UioIRL
   QT8Rcfo3PlQWyY6JhBU0dY/OHm2BEpjr9YK+gC3T/zo8ayjRqOZkFWWX+
   i9OevttK0DThWKKaJJG0bRO6t36fDDFuXhnUBvhT5rR7w5uOwCXoutMW6
   A==;
X-CSE-ConnectionGUID: NJV8b953Qfa1/Dc1m9RFRw==
X-CSE-MsgGUID: e+yKjjFfTeioQut9MP1QKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12347424"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="12347424"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 17:58:27 -0700
X-CSE-ConnectionGUID: sCuDy8avTmucpIQG9+SxeQ==
X-CSE-MsgGUID: RfiTWdokQC63YJS2uTSC+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="46356983"
Received: from unknown (HELO zhiquan-linux-dev.bj.intel.com) ([10.238.156.102])
  by orviesa007.jf.intel.com with ESMTP; 01 Jul 2024 17:58:25 -0700
From: Zhiquan Li <zhiquan1.li@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	kirill.shutemov@linux.intel.com,
	x86@kernel.org
Cc: rafael@kernel.org,
	hpa@zytor.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v3] x86/acpi: fix panic while AP online later with kernel parameter maxcpus=1
Date: Tue,  2 Jul 2024 08:58:00 +0800
Message-Id: <20240702005800.622910-1-zhiquan1.li@intel.com>
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
encrypted guest.  When restrict boot time CPU to 1 with the kernel
parameter "maxcpus=1" and bring other CPUs online later, there will be
a kernel panic.

The variable acpi_mp_wake_mailbox, which holds the virtual address of
the MP Wakeup Structure mailbox, will be set as read-only after init.
If the first AP gets online later, after init, the attempt to update
the variable results in panic.

The memremap() call that initializes the variable cannot be moved into
acpi_parse_mp_wake() because memremap() is not functional at that point
in the boot process.

[1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
    the "Multiprocessor Wakeup Structure" section.

Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

---

V2: https://lore.kernel.org/all/20240628082119.357735-1-zhiquan1.li@intel.com/

Changes since V2:
- Modify the commit log as suggested by Kirill.
- Add Kirill's Reviewed-by tag.

V1: https://lore.kernel.org/all/20240626073920.176471-1-zhiquan1.li@intel.com/

Changes since V1:
- Amend the commit message as per Kirill's comments.
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

base-commit: ec6574a634db84f25e4eee6698d76fed5649e3bd
-- 
2.25.1


