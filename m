Return-Path: <linux-acpi+bounces-7570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CB951B18
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 14:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4C71C20D7E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E471AAE15;
	Wed, 14 Aug 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z828fAo4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978971AE031;
	Wed, 14 Aug 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639582; cv=none; b=VKMbxIawIwLu4d1Pt0JwaJuz7q9cntfX/mlmGJ+QKg0dWr5CGpi8Et/sXON+7d2OxSMtrmqD1/5+jtdwIiezEkcuRTT4n1x1NHcHTvh0c4hzEvmupBGx2E0n0xEPIhoBp3O9FiFnnvhi26C822QDsBJj0TfmRoIofXWGlOHj00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639582; c=relaxed/simple;
	bh=e8I9dH2wta/XPWgq7/e9Fe7qGFYPRMmzhUeSyca75Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7JPnwi9roh+eqiUdoFMSnKZEVJKrX79O3o9ohLfLAckclNqZxQ0QNacbOfwnvMHxMnGEKlKhV2mJmxSnM1vIxDKO2fdo+MIR0p6rjHLfTEdrqZaGSuH10GJ9lCwCLkTdMnaWle7ZFWwBgdGcoZDSiwIBd4K+uTk9TmZTHkRku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z828fAo4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723639581; x=1755175581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e8I9dH2wta/XPWgq7/e9Fe7qGFYPRMmzhUeSyca75Gk=;
  b=Z828fAo4NJzbtoaUftX5/GxWVgdYMqCG0BOJyOZa25zs/JTuBGKFsC6s
   wQfzOtZgpCV+n1ZQPm1Foy0uOje5PZnVbAxfPmdrRaf98fDIoiQewZmPu
   4K8S7GU3uzxbm4VVaGDhWPXYb08xygiNpy+WxA2WBw42vQ6nXrtKPN4nd
   WZ+qmOGdM0zqXV8cGMNkr3HZin5IqvRBfl1pXvXfkxUaFTT8ew4Y5M5N0
   55ZghVwvP3fOQsBb1TWmWPg4EMUU3cpZeud9x9Gz0ULYYI+rfdyrjRi6X
   L14WkO+ZO3hppqSIuprCHig3Qhio+tnorwJAAal8b+SaBHHh0aHe4n08n
   A==;
X-CSE-ConnectionGUID: VWbkvbawSw2JO9rDP6rXIA==
X-CSE-MsgGUID: +D4vUDnUSSuK8OObytZnEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33004021"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="33004021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:46:20 -0700
X-CSE-ConnectionGUID: /nIWwkbrTJqRn0PlQafndQ==
X-CSE-MsgGUID: XmqTijlLRiG21kMJHOOH4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="59568671"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2024 05:46:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7CCE639D; Wed, 14 Aug 2024 15:46:14 +0300 (EEST)
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
Subject: [PATCHv2 2/4] x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()
Date: Wed, 14 Aug 2024 15:46:11 +0300
Message-ID: <20240814124613.2632226-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
References: <20240814124613.2632226-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function init_transition_pgtable() maps the page with
asm_acpi_mp_play_dead() into an identity mapping.

Replace manual page table initialization with kernel_ident_mapping_init()
to avoid code duplication. Use x86_mapping_info::offset to get the page
mapped at the correct location.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 73 ++++++------------------------
 1 file changed, 15 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d5ef6215583b..78960b338be9 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -70,58 +70,6 @@ static void __init free_pgt_page(void *pgt, void *dummy)
 	return memblock_free(pgt, PAGE_SIZE);
 }
 
-/*
- * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
- * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
- * to the identity mapping and the function has be present at the same spot in
- * the virtual address space before and after switching page tables.
- */
-static int __init init_transition_pgtable(pgd_t *pgd)
-{
-	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
-	unsigned long vaddr, paddr;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	vaddr = (unsigned long)asm_acpi_mp_play_dead;
-	pgd += pgd_index(vaddr);
-	if (!pgd_present(*pgd)) {
-		p4d = (p4d_t *)alloc_pgt_page(NULL);
-		if (!p4d)
-			return -ENOMEM;
-		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
-	}
-	p4d = p4d_offset(pgd, vaddr);
-	if (!p4d_present(*p4d)) {
-		pud = (pud_t *)alloc_pgt_page(NULL);
-		if (!pud)
-			return -ENOMEM;
-		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
-	}
-	pud = pud_offset(p4d, vaddr);
-	if (!pud_present(*pud)) {
-		pmd = (pmd_t *)alloc_pgt_page(NULL);
-		if (!pmd)
-			return -ENOMEM;
-		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
-	}
-	pmd = pmd_offset(pud, vaddr);
-	if (!pmd_present(*pmd)) {
-		pte = (pte_t *)alloc_pgt_page(NULL);
-		if (!pte)
-			return -ENOMEM;
-		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
-	}
-	pte = pte_offset_kernel(pmd, vaddr);
-
-	paddr = __pa(vaddr);
-	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
-
-	return 0;
-}
-
 static int __init acpi_mp_setup_reset(u64 reset_vector)
 {
 	struct x86_mapping_info info = {
@@ -130,6 +78,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
 		.kernpg_flag    = _KERNPG_TABLE_NOENC,
 	};
+	unsigned long mstart, mend;
 	pgd_t *pgd;
 
 	pgd = alloc_pgt_page(NULL);
@@ -137,8 +86,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 		return -ENOMEM;
 
 	for (int i = 0; i < nr_pfn_mapped; i++) {
-		unsigned long mstart, mend;
-
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 		if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
@@ -147,14 +94,24 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 		}
 	}
 
-	if (kernel_ident_mapping_init(&info, pgd,
-				      PAGE_ALIGN_DOWN(reset_vector),
-				      PAGE_ALIGN(reset_vector + 1))) {
+	mstart = PAGE_ALIGN_DOWN(reset_vector);
+	mend = mstart + PAGE_SIZE;
+	if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
 		kernel_ident_mapping_free(&info, pgd);
 		return -ENOMEM;
 	}
 
-	if (init_transition_pgtable(pgd)) {
+	/*
+	 * Make sure asm_acpi_mp_play_dead() is present in the identity mapping
+	 * at the same place as in the kernel page tables.
+	 * asm_acpi_mp_play_dead() switches to the identity mapping and the
+	 * function has be present at the same spot in the virtual address space
+	 * before and after switching page tables.
+	 */
+	info.offset = __START_KERNEL_map - phys_base;
+	mstart = PAGE_ALIGN_DOWN(__pa(asm_acpi_mp_play_dead));
+	mend = mstart + PAGE_SIZE;
+	if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
 		kernel_ident_mapping_free(&info, pgd);
 		return -ENOMEM;
 	}
-- 
2.43.0


