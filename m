Return-Path: <linux-acpi+bounces-7779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA6095B52F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51470281458
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33641C9EBB;
	Thu, 22 Aug 2024 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AURBxX6P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36A1C9DCC;
	Thu, 22 Aug 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330411; cv=none; b=UH7K2LkdqZi9Zk6kWr9BHjJC28ZkrauyfCEJkgvFVqHiUMdi3j/4Dz61Rxec+xJ1HSYCTfZhUsxKlZgxR+k8+CsVdJxU1Ip8ROLSZlw6K1mfIxn93hZ5lEHCt/hqPAhYV4dwFaOFGdlnBRoujoqzpjmQp0YsaD1Xmn9hOZRgsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330411; c=relaxed/simple;
	bh=vy3STgE3PjnKqGO0pLDMgzAb6NmQRTblv+6S2nmqiFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2feco1MYCVlrOmG9kQAjhdI/dIZRnimysAL15EEMjHx7MD+wMxjn+GGLU5UYDBfEh71iX2l3N1knAuJdc1uFw4kIWdNKiaqZugX8Mpw3ka3sHvsnmLnpS9DIgzDEkavhMQX7EOANpmYxsPwivODyPMK8bNAwhdKIcCGrSdHdVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AURBxX6P; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724330410; x=1755866410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vy3STgE3PjnKqGO0pLDMgzAb6NmQRTblv+6S2nmqiFo=;
  b=AURBxX6PjtGQpJ0Ld3B48a81VnBHlCAwF5dBgXq5LY80ERlI1uv5kSP+
   zUNbl1UMvHSB6/M16e6ml5R3XtC12mXS1iuiMmsKVOrHcHTNIEWDzLU2W
   6PfW9/FpwciLCV4tEs0YeRuDY7mUUUdV96C25DAt6e/OVc32nBZ/eIEcl
   qGKdkWl7CFZiaX7I1k4gt82koKy4YBv+veFnh8EgxDz6BZx48ty+WTwkM
   3EQWbyAoSSzlsdkNa4lQYXM2kk2AlFN88hZIdmBpByWAhGbwKIDQIc6AX
   ARcJYRUP2yqGbl0FMShHJYfh6AB4YUUIdhGwN7s1Qu/W1mL0/2CtVmh6F
   g==;
X-CSE-ConnectionGUID: tdSgkcPPReKMiqP5+aXhXg==
X-CSE-MsgGUID: BU1PtdsvSjitFnEz1hRuPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22554218"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22554218"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:40:07 -0700
X-CSE-ConnectionGUID: DGNdl5xGTEmpkwyYoIpGgA==
X-CSE-MsgGUID: gmvAVoE3Qp6CdEb7/7tIEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66320995"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 22 Aug 2024 05:40:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 29DF2331; Thu, 22 Aug 2024 15:40:02 +0300 (EEST)
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
Subject: [PATCHv4 2/4] x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()
Date: Thu, 22 Aug 2024 15:39:58 +0300
Message-ID: <20240822124000.1171321-3-kirill.shutemov@linux.intel.com>
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

The function init_transition_pgtable() maps the page with
asm_acpi_mp_play_dead() into an identity mapping.

Replace manual page table initialization with kernel_ident_mapping_init()
to avoid code duplication. Use x86_mapping_info::offset to get the page
mapped at the correct location.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/acpi/madt_wakeup.c | 73 ++++++------------------------
 1 file changed, 15 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d5ef6215583b..f36f28405dcc 100644
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
+	 * function must be present at the same spot in the virtual address space
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


