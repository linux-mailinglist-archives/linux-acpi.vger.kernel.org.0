Return-Path: <linux-acpi+bounces-7776-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB5795B529
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4A81F23BFE
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3091C9DCB;
	Thu, 22 Aug 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOGmcJ0y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60423146A6E;
	Thu, 22 Aug 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330410; cv=none; b=cTn5/rfXVKMXIHmdNcFsLvkVsQG1/6GSFL09BKIOufNJ7Gx3n0W+rPJIXW0OVWkyrVkO0jfkAckoJKZSjawVG55TlckeIOePvMro5CmQiPxfilFO1keFQkxwLS220XrFr4GBJLKUVxS/ibYQJPaw0/zBaUh9rArq+VjC5tpHFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330410; c=relaxed/simple;
	bh=UJSYe9Co8WtZ1/D2W+TpdPAS7LIZhmBIyvDdCVYV3gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwpymHgB/oxkBGrqjMVQvzoIQe6+lY9UhU0P0NageNl1i6G8Y/EVxSB/Vn49Q+lq7RUAY9bbNnfdV5u9BKYoUb3ULH+5Lk7ojGe+7/a27AuFsApdE7+8xn3DCx5IeMar6dxJ+Bs7lLq/64iMazqUaQBzNTRCBprS9i9vmhyhZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOGmcJ0y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724330408; x=1755866408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJSYe9Co8WtZ1/D2W+TpdPAS7LIZhmBIyvDdCVYV3gI=;
  b=fOGmcJ0y4eJqAUdG0ub3TAHKi5ZrnlxF0b/KlL06c8b71mJnwqdiKqRD
   q6EZ5YIDSCMpNYvog3PiLqoRTpmmdyxMlQnqO1Vz8W2v3PDqonXWO4O7c
   VNhNJMXhVqJvpFzhLptMDRGF7CBlXBr5YXH18DWIro1rE3N/TdmX7yAyw
   cV26etSBFMjiI0ABbT0IGahKEsVPTpdoxWif7e2i0CpubOOK6KZliFvPc
   NHf5SRnSaCqdjCc2hqdwem2ctgWQMXdNJjCFsgv6/4hZzQWLHOjIXm6A4
   3hzGMdDBMq0FpPZzq/9sHXROBmAotD6RzFlRlmVIKyAFzEwvg/20wwS76
   g==;
X-CSE-ConnectionGUID: 7TaaYo0CQCKVRgR4XbSIFQ==
X-CSE-MsgGUID: BKkteXmSRPqtrpnNC2SsgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22554207"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="22554207"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:40:07 -0700
X-CSE-ConnectionGUID: +vB+UJC6SUiseNdT72z9Ew==
X-CSE-MsgGUID: PueyqbE5TUmfgVndqRXc+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="66320992"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 22 Aug 2024 05:40:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5035B6CC; Thu, 22 Aug 2024 15:40:02 +0300 (EEST)
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
Subject: [PATCHv4 4/4] x86/64/kexec: Rewrite init_transition_pgtable() with kernel_ident_mapping_init()
Date: Thu, 22 Aug 2024 15:40:00 +0300
Message-ID: <20240822124000.1171321-5-kirill.shutemov@linux.intel.com>
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
2.43.0


