Return-Path: <linux-acpi+bounces-8818-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17D9A0828
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 13:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD5D282BD5
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4E6208210;
	Wed, 16 Oct 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joRgA+9Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25D2076DE;
	Wed, 16 Oct 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077310; cv=none; b=cYWb1pX7qfqch+TDEaDmfSUW3qAiULJR4fGlR2JKn6ft5MVlczuY1EDng/dJwUM5c26JxVDZkZgAi5SUQINQy7r1CaN+a6d1/drjiv9Vw+bJg3gVeluJ+DIqaA1wmQ2W8wWHRkTDEUFUGiqiZwRVQ6dlrZXMFRWbVBXQD39SqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077310; c=relaxed/simple;
	bh=Vsji7fvGKoZdggpdAR7OdUv+hIBMd4JgmdmhDh86f/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiI5tsm7v9pKQZDpowLF3we/Ycqf7Jug5S+0VhE6Ol6zSDzdrQw7kpw8nvbMXkignLFFMyLenB1Yb+Mf2+i1zLC9kQ1dpSMhVyscaUJsrDDR/54tnu80I77XBpSp6TaKyeflmcscd3FIUFg7+zxmwX71fs2vn8I6a/TW52gDwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joRgA+9Y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729077309; x=1760613309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vsji7fvGKoZdggpdAR7OdUv+hIBMd4JgmdmhDh86f/Y=;
  b=joRgA+9YVk2ua48mzggg30dePbba7bxBFvHXrzbQsAXYnzBJwPuDUYB5
   cMr+iTJfCJieDWFPNBOEx+PccbT3RRIuU88IgiNtQf0oSQoKW+CzMmyMd
   uA4V4NMR2Y4llT6hq6C2iQw22giUSAq40ZMKk4kfF98x7sMwCqcRGswgJ
   YhNYkNX1+ET9PELHcHQZ0a8JVtZcccDEltLqDlLRydE0y/qv90lxXVQpJ
   j3/ELpX+qqX1+zX5LKxYcIcqgfh2wjjSR0hYe/Uq+ypZ2xARp3eLwDzdX
   pHdWY8XkFXxjKWF5Ky6OaqyW76GTrdj33tyMM2g7klbQZ/ir25hlck5hC
   Q==;
X-CSE-ConnectionGUID: 2Qws6h3uT0uLntklBTrqiQ==
X-CSE-MsgGUID: nUFc0cADT/GmBiAVXpkYVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39066179"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39066179"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:15:06 -0700
X-CSE-ConnectionGUID: fqRJ8b2eRsif7EIGcZVWRg==
X-CSE-MsgGUID: 6kn2GzlQS16R7ueit9HN5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83005218"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 16 Oct 2024 04:15:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EE0D31AC; Wed, 16 Oct 2024 14:14:59 +0300 (EEST)
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
	Kai Huang <kai.huang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCHv4, REBASED 2/4] x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()
Date: Wed, 16 Oct 2024 14:14:56 +0300
Message-ID: <20241016111458.846228-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
References: <20241016111458.846228-1-kirill.shutemov@linux.intel.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
2.45.2


