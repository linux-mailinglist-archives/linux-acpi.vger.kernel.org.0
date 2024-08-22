Return-Path: <linux-acpi+bounces-7778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C41695B52E
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8401C2316D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE51C9DFA;
	Thu, 22 Aug 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mM6FDNtr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26741C9452;
	Thu, 22 Aug 2024 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330411; cv=none; b=noWqGY65ogSAR/NL3SvL1fMQbMCLi3GzruIYvHU91G4Z+RhaWtrE29VrLC2A97crr8+wbldEqDix5nBUo41/xbeOmmjn4GRiGtbuLiP8qaoKDNJko/GTdd/9OJki2x3cHSA1b2I8hobVB/s7jC9qjRSQkWYdDncesQGhR6JPvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330411; c=relaxed/simple;
	bh=QQ0UbpyqdIB6+YfJjPDDx6eJHiL0EplzplL8JUqBi1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P69T4lUkHpl+CtRZhuI3QgEAW+lTObbS8Ju3eDgt3jk4PDEgzXu8zjuXs2cN3E1/g5rqEYl5wL0WSvm9GSvIdY5LibUaQqWVt2tosqJpe+qq5C2XV5Gfgpb2rlFPOLGrmtq/UB5OND/b/BSzFPWD2LGUIXbcGBt9fkkp3t3GFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mM6FDNtr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724330410; x=1755866410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QQ0UbpyqdIB6+YfJjPDDx6eJHiL0EplzplL8JUqBi1Y=;
  b=mM6FDNtrX3g2cWoEB2Y6UX3PpTnvIRjNdJay5l2L7X+HDbxPv/Hwt3hE
   kWKIxpd1g7p6Q2tC5KSqJPwaDcQEWSX9iZxDhhXPJ6bXl2ynoiriwDt1z
   ug9REs27zSJTTwgq1L6HUKFm77pjxaE/IoS0IyqO2WFTYSrqFCdADOZEM
   GNnURKOM6wKWz24lXkZ8oo15dFhZHFmsKKtNqevsYKXf750VANmw7UJAh
   FSSHx2pPt3POME32lOKY7dYXd5VtGLRzB2l2gKBiOV4kb5qs2opf4MKYz
   fmBonY0EtMyck1TiZFO5A5cRWf19eoLxbolpn5yeQEgJtYqmkrRVG5Nnw
   g==;
X-CSE-ConnectionGUID: aBfRq49DTcGhxyoeuojZeA==
X-CSE-MsgGUID: EyWXIhf/R5+0QzxnGDBKnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="25635649"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="25635649"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:40:07 -0700
X-CSE-ConnectionGUID: /8lyXqRMRoWLnT3KU/uRSg==
X-CSE-MsgGUID: T6DzAN3XT52XnPEN5X1CJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61443073"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2024 05:40:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3FC324D7; Thu, 22 Aug 2024 15:40:02 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Baoquan He <bhe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCHv4 3/4] x86/64/kexec: Map original relocate_kernel() in init_transition_pgtable()
Date: Thu, 22 Aug 2024 15:39:59 +0300
Message-ID: <20240822124000.1171321-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822124000.1171321-1-kirill.shutemov@linux.intel.com>
References: <20240822124000.1171321-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The init_transition_pgtable() function sets up transitional page tables.
It ensures that the relocate_kernel() function is present in the
identity mapping at the same location as in the kernel page tables.
relocate_kernel() switches to the identity mapping, and the function
must be present at the same location in the virtual address space before
and after switching page tables.

init_transition_pgtable() maps a copy of relocate_kernel() in
image->control_code_page at the relocate_kernel() virtual address, but
the original physical address of relocate_kernel() would also work.

It is safe to use original relocate_kernel() physical address cannot be
overwritten until swap_pages() is called, and the relocate_kernel()
virtual address will not be used by then.

Map the original relocate_kernel() at the relocate_kernel() virtual
address in the identity mapping. It is preparation to replace the
init_transition_pgtable() implementation with a call to
kernel_ident_mapping_init().

Note that while relocate_kernel() switches to the identity mapping, it
does not flush global TLB entries (CR4.PGE is not cleared). This means
that in most cases, the kernel still runs relocate_kernel() from the
original physical address before the change.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/machine_kexec_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e..645690e81c2d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -157,7 +157,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	pte_t *pte;
 
 	vaddr = (unsigned long)relocate_kernel;
-	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
+	paddr = __pa(relocate_kernel);
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
 		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
-- 
2.43.0


