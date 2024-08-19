Return-Path: <linux-acpi+bounces-7650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAA956419
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 09:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA31C21614
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94D15852E;
	Mon, 19 Aug 2024 07:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+QJErcZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A6157476;
	Mon, 19 Aug 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051320; cv=none; b=fDweZbn+5L3lShy93VnwhwuDiX5sK8Y1men60jO4/8pHrCwNYQSvcuwy1P8UMgZaKLISOJXPU5v5fihkS68WgHGRx8eGDHnh6M2//QTXhyWER4GpUNwBPl93qESxjK8jU+sOTMqIpJkDlAp2wJspX8c2tzg85XammvJHfgTvvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051320; c=relaxed/simple;
	bh=6ucCkpB0mFmRt1asl9hiphBlkV+T4SErqOKVfRYggY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J82H8Jx4Tza2TGwjVciHl++0wzKFXyR09kMMe2rIpKVkrlSWuCRglYIWo+lrPs1OBi/W6jrIHDGhuZGaMd6vXcSRUOG+tOd+TjBiLyWyQ1PSpwl3t57Ez7MIKr8w+NhA4Q++eQZnQ+b3zPkpQfBLbmPYFCCBd98EyDztEGEjSYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+QJErcZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724051319; x=1755587319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ucCkpB0mFmRt1asl9hiphBlkV+T4SErqOKVfRYggY0=;
  b=I+QJErcZG3rBesTK/PhhT++PmiMTNgfZMvzPZPhvQHLHgTsp6IL3aUkh
   AUwweiPEVsLJozCVBpuYPufdvYqZfSnaT2h7RlskeoSXCpWgSGyXq4ZAn
   8yh5UaVKA3+rXNnqhvuXAlsORAoK5NNKDq9OFpgNF8QGgafs2wWPOWnnL
   EYFwHs79FSe2yBjuLHSzbWNFyQ2iLjy7zYNY/wkwDfjvFZK0ENMz1pogt
   sEZqrVSGpHB0Ez+jJtzUsCsVLKQ38TBaM8jlgthrWRxpPb3GPaG1OUdm2
   p5JS/p7T4ARsJEHd2NOmfa6/+A2g4L3FUaKDEjO0z6wS6NzbliVOYSr5w
   g==;
X-CSE-ConnectionGUID: 211MfnDiSZmuhUWWUwJY6Q==
X-CSE-MsgGUID: 5jS4wi/1TmiLViopEr0ioA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33697321"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33697321"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:08:36 -0700
X-CSE-ConnectionGUID: /yl4IsXARw+bgf++1seU4Q==
X-CSE-MsgGUID: /CIEJUubQg2w9xM+DvrIAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60273955"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 19 Aug 2024 00:08:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 641FC419; Mon, 19 Aug 2024 10:08:30 +0300 (EEST)
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
Subject: [PATCHv3 2/4] x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()
Date: Mon, 19 Aug 2024 10:08:25 +0300
Message-ID: <20240819070827.3620020-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
References: <20240819070827.3620020-1-kirill.shutemov@linux.intel.com>
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


