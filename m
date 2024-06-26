Return-Path: <linux-acpi+bounces-6614-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398379179E9
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 09:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4569B24AF0
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Jun 2024 07:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9415CD63;
	Wed, 26 Jun 2024 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpCtWEqR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE951FBB;
	Wed, 26 Jun 2024 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387613; cv=none; b=l8U0K+GFqjyHoaB/JYTNjmHs/D2pxdKTLalo8/gY6/hBVU3mwDJ9ryPeJDT1hDorKOw0BfNzlRgAayODHyVd0wJ4Mbld4Gaj4Ftif+okhOtTWc1pOVT7Uqo4kzsRHExrtWCbd8tucNSVXOA5OWHack/xStj2u7w9f94x2NYaW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387613; c=relaxed/simple;
	bh=/mEnjOuNB484h5qzjDemSgISTr4DI31TAi1M46X2jyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QnCgCrYpupJsMCqpCwhlizSgIdqryy51SVZUCaf9Uvg9dzHtFEtwDiaE472guiGeOo71rzRiPXSdbrvz6Ccpsh2VsC1OA6jziFiCnBZS5EbDHgIsLkphGa3DiZeA+7p+oxjH3tYVU8ijIx8uSsiAdjSbpLGtrFPjHsLLjQgjI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpCtWEqR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719387611; x=1750923611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/mEnjOuNB484h5qzjDemSgISTr4DI31TAi1M46X2jyU=;
  b=bpCtWEqRAANHX6dGst5WuNXKa1vymBOLYgDzQx63Bk6q0lJZ4+7HWWVP
   Rx8uZdOz8Jclci9mucaW1Uvvm1slav72w3dfIhMKMr44Vo6XzsGM64uK0
   7ewfPgNgqQ/5f+4FQwcrIDjdHny4JH6pLqC1dbofEdm37HhZ/c9eftup5
   B0CzBCow2vkh3gpmKo2MntIvKjZ8kwkh2VyPjCm94pqpx1h36WA+TSvls
   zXncyodBSWc0cY4fIs4L9lZa4xWDO5EdfALpuvrISZQbVJXouxo+9O9Qo
   aBiy9l3kWt9RBaONFwJli6jjGSnFiYNDNFCZ8s4rZ7xIk9doWQVskrCqK
   A==;
X-CSE-ConnectionGUID: +Qt0hPT9Rzy3zBrYRSXzBw==
X-CSE-MsgGUID: xOEweSvKRVCeP4CzhD20lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16123697"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16123697"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 00:40:11 -0700
X-CSE-ConnectionGUID: /xPkeCTqRYOpD3q2awHX8w==
X-CSE-MsgGUID: yVL0NG1xS7m/y5pLj2xNag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="48509823"
Received: from unknown (HELO zhiquan-linux-dev.bj.intel.com) ([10.238.156.102])
  by fmviesa004.fm.intel.com with ESMTP; 26 Jun 2024 00:40:08 -0700
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
Subject: [PATCH] x86/acpi: fix panic while AP online later with kernel parameter maxcpus=1
Date: Wed, 26 Jun 2024 15:39:20 +0800
Message-Id: <20240626073920.176471-1-zhiquan1.li@intel.com>
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
encrypted guest.   When restrict boot time CPU to 1 with the kernel
parameter "maxcpus=1" and bring other CPUs online later, there will be
a kernel panic as below.

The variable acpi_mp_wake_mailbox to hold the virtual address of MP
Wakeup Structure mailbox will be set as readonly after initialization.
If the first AP is brought online laster, the attemption to update it
results in panic.

Not like the physical address of MP Wakeup Structure mailbox, the
readonly attribute is not necessary for its virtual address.

[1] Details about the MP Wakeup structure can be found in ACPI v6.4, in
    the "Multiprocessor Wakeup Structure" section.

  BUG: unable to handle page fault for address: ffffffff83086978
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0003) - permissions violation
  PGD 3832067 P4D 3833067 PUD 3834063 PMD 80000000030001a1
  Oops: Oops: 0003 [#1] PREEMPT SMP NOPTI
  CPU: 0 PID: 175 Comm: systemd-udevd Not tainted 6.10.0-rc4+ #14
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
  RIP: 0010:acpi_wakeup_cpu+0xb2/0xe0
  Call Trace:
   <TASK>
   ? __die+0x20/0x70
   ? page_fault_oops+0x80/0x140
   ? exc_page_fault+0xdc/0x180
   ? asm_exc_page_fault+0x22/0x30
   ? _raw_read_unlock+0x18/0x40
   ? acpi_wakeup_cpu+0xb2/0xe0
   do_boot_cpu+0xeb/0x1f0
   native_kick_ap+0xcb/0x150
   ? __pfx_cpuhp_kick_ap_alive+0x10/0x10
   cpuhp_invoke_callback+0x2d0/0x480
   ? __pfx_trace_rb_cpu_prepare+0x10/0x10
   __cpuhp_invoke_callback_range+0x78/0xe0
   cpuhp_up_callbacks+0x28/0x100
   _cpu_up+0xb9/0x120
   cpu_up+0x91/0xe0
   cpu_subsys_online+0x4d/0xe0
   device_online+0x5f/0x80
   online_store+0x8f/0xc0
   kernfs_fop_write_iter+0x125/0x1c0
   vfs_write+0x35c/0x480
   ksys_write+0x5f/0xe0
   do_syscall_64+0x63/0x170
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
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

base-commit: 4fe5c16f5e5e0bd1a71a5ac79b5870f91b6b8e81
-- 
2.25.1


