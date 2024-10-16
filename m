Return-Path: <linux-acpi+bounces-8815-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E4C9A0822
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 13:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39AE1F2283A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514112076C9;
	Wed, 16 Oct 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmR8ihbi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05BD1B0F0D;
	Wed, 16 Oct 2024 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077308; cv=none; b=eCRsZQcMiCzxG1zfr7cxFLjuBGm1kkplg7qDgiBKbEdDeOPrgWrOCijuh5sSPvrtTAVaNP1pHrYaATTBWc7M9Cu7pCUgWw2FhL1UZ0WpLK8Jv3waupkRB0X/TnuhJ1T2ej2feOCCnawR9lqFJcvom5Mg09PUAXqC3TEb585qPm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077308; c=relaxed/simple;
	bh=S1yqy8Rerz6Navb8umTvjQcz44gY1prjsxSQoXtS/R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pvuqt/+OY/ASmmk0ClgmI03homV8fsBBD161rKw+MaJL5LjbKo4DUmnUjWxW1W3RN6NPNZU7Ov/zNZgwsd7MFu3pjkTXOSlKT6hZf64lXG6PgbRikE2lrLmgrqLNVXdHgL0yKBGyY2rZDZbg75oEldOPdXkQk+TdWohJIT+p+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmR8ihbi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729077307; x=1760613307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S1yqy8Rerz6Navb8umTvjQcz44gY1prjsxSQoXtS/R4=;
  b=HmR8ihbiRstVUoBeZHErN+7vGJUqFGaMemkXMiOtMlz/hJLtR23RWkAQ
   z5DjutdqXdmeAbn5HBLkUyoGNDzj9JyPfZkoF7M2dyPtrOpA6FluXcq6v
   l0YP8uDAh7XJwXlKgwL+1YMVS/ro9UQBYzf4uRyrNBwWmHBUDP+t3Hu8z
   1cW6PFvUQj/61VvgoL3bw78WIK5G/pw7EgZ8RtXMqEIHS+OPgy8j4KK11
   Mg4WQwcP9I6KewW1Al7WZF37DrotFtMClu0u93v11zqt4osbiWS0xn7wY
   vO2R2AK4InE4pfOrXOrbEt0og2zGpeqJFBndCbD9SLafK9gIZLlbxFkpT
   w==;
X-CSE-ConnectionGUID: R2Pvzz4cSp+zr9mUK3CPPg==
X-CSE-MsgGUID: PlvM/eJ+TM+ih8ZPYv+C1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39066149"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39066149"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:15:06 -0700
X-CSE-ConnectionGUID: wPSTL9YUR+G/WFX0N1JpsA==
X-CSE-MsgGUID: U4Aom/kyRymfNYaI9qzXvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83005215"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 16 Oct 2024 04:15:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 16FE51C4; Wed, 16 Oct 2024 14:15:00 +0300 (EEST)
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
Subject: [PATCHv4, REBASED 4/4] x86/64/kexec: Rewrite init_transition_pgtable() with kernel_ident_mapping_init()
Date: Wed, 16 Oct 2024 14:14:58 +0300
Message-ID: <20241016111458.846228-5-kirill.shutemov@linux.intel.com>
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

init_transition_pgtable() sets up transitional page tables. Rewrite it
using kernel_ident_mapping_init() to avoid code duplication.

Change struct kimage_arch to track allocated page tables as a list, not
linking them to specific page table levels.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/include/asm/kexec.h       |  5 +-
 arch/x86/kernel/machine_kexec_64.c | 89 +++++++++++-------------------
 2 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index ae5482a2f0ca..7f9287f371e6 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -145,10 +145,7 @@ struct kimage_arch {
 };
 #else
 struct kimage_arch {
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	struct list_head pages;
 };
 #endif /* CONFIG_X86_32 */
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 645690e81c2d..fb350372835c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -134,71 +134,42 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
 	return 0;
 }
 
+static void *alloc_transition_pgt_page(void *data)
+{
+	struct kimage *image = (struct kimage *)data;
+	unsigned long virt;
+
+	virt = get_zeroed_page(GFP_KERNEL);
+	if (!virt)
+		return NULL;
+
+	list_add(&virt_to_page(virt)->lru, &image->arch.pages);
+	return (void *)virt;
+}
+
 static void free_transition_pgtable(struct kimage *image)
 {
-	free_page((unsigned long)image->arch.p4d);
-	image->arch.p4d = NULL;
-	free_page((unsigned long)image->arch.pud);
-	image->arch.pud = NULL;
-	free_page((unsigned long)image->arch.pmd);
-	image->arch.pmd = NULL;
-	free_page((unsigned long)image->arch.pte);
-	image->arch.pte = NULL;
+	struct page *page, *tmp;
+
+	list_for_each_entry_safe(page, tmp, &image->arch.pages, lru) {
+		list_del(&page->lru);
+		free_page((unsigned long)page_address(page));
+	}
 }
 
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 {
-	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
-	unsigned long vaddr, paddr;
-	int result = -ENOMEM;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
+	struct x86_mapping_info info = {
+		.alloc_pgt_page	= alloc_transition_pgt_page,
+		.context	= image,
+		.page_flag	= __PAGE_KERNEL_LARGE_EXEC,
+		.kernpg_flag	= _KERNPG_TABLE_NOENC,
+		.offset = __START_KERNEL_map - phys_base,
+	};
+	unsigned long mstart = PAGE_ALIGN_DOWN(__pa(relocate_kernel));
+	unsigned long mend = mstart + PAGE_SIZE;
 
-	vaddr = (unsigned long)relocate_kernel;
-	paddr = __pa(relocate_kernel);
-	pgd += pgd_index(vaddr);
-	if (!pgd_present(*pgd)) {
-		p4d = (p4d_t *)get_zeroed_page(GFP_KERNEL);
-		if (!p4d)
-			goto err;
-		image->arch.p4d = p4d;
-		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
-	}
-	p4d = p4d_offset(pgd, vaddr);
-	if (!p4d_present(*p4d)) {
-		pud = (pud_t *)get_zeroed_page(GFP_KERNEL);
-		if (!pud)
-			goto err;
-		image->arch.pud = pud;
-		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
-	}
-	pud = pud_offset(p4d, vaddr);
-	if (!pud_present(*pud)) {
-		pmd = (pmd_t *)get_zeroed_page(GFP_KERNEL);
-		if (!pmd)
-			goto err;
-		image->arch.pmd = pmd;
-		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
-	}
-	pmd = pmd_offset(pud, vaddr);
-	if (!pmd_present(*pmd)) {
-		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
-		if (!pte)
-			goto err;
-		image->arch.pte = pte;
-		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
-	}
-	pte = pte_offset_kernel(pmd, vaddr);
-
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		prot = PAGE_KERNEL_EXEC;
-
-	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
-	return 0;
-err:
-	return result;
+	return kernel_ident_mapping_init(&info, pgd, mstart, mend);
 }
 
 static void *alloc_pgt_page(void *data)
@@ -299,6 +270,8 @@ int machine_kexec_prepare(struct kimage *image)
 	unsigned long start_pgtable;
 	int result;
 
+	INIT_LIST_HEAD(&image->arch.pages);
+
 	/* Calculate the offsets */
 	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
 
-- 
2.45.2


