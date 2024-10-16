Return-Path: <linux-acpi+bounces-8816-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4869A0823
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 13:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2171B2815A5
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7B207A0E;
	Wed, 16 Oct 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bpq2Stdk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B472076C0;
	Wed, 16 Oct 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077309; cv=none; b=dUdmTAUgXzTqIYrsdRwtV2LeqzkkU5pgMKqP0sFzKU+zwtdOsPk/IzNXSYwdJFIC4QaAGBwSaEjuqwCBQnHjN462zaRzdzuVEKOwLAVdsi/ZLFokowOHDd9QRv+rbqeJeIisZB/TyIIjJdtMMkcuoAK4E2bvDnqxKi/DIJYk2xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077309; c=relaxed/simple;
	bh=OGHaZPLBCwVGgyYZNgzO+oCLSrdJlWpxHavpfRhGxYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2FYnOiNMgdhafQLabX7QhM9QRbEOC45JEsj+PIl863JEdzzMin/CXaFWJ00eH8b1dXMjEfJt4C4oD0YNC/Pp3nVuYt2hj6A2XmEASpnw+OcwF4xfglqTKBmaH1KsjvhkrxBPZsyYb4ELED8tehXctsJR1H5bjLfBtr52FjNmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bpq2Stdk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729077308; x=1760613308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGHaZPLBCwVGgyYZNgzO+oCLSrdJlWpxHavpfRhGxYY=;
  b=Bpq2StdkNNTlFFrQJhmA/H1hVQm/VJiU1n2X6Sdx/MYX0EbYdj676M1O
   yNaBQxuJDyiB5AsFu0b6zfjS9Id4Nok5hhE5yKPT7ooNasMtUwJBSx2O4
   wdYBMvFNMXW0DP9ptNviUnzHwrLPFfty3zV+8YqahIJBZ0cKN/OAv7AhQ
   A49MiWoYjt19l9vS4WOC/QGcpTQyyeniBjVIHGJdCchr2bS6tDdVIu6QA
   yDJ0CYMdf1cvSsO9sVOm6Bx8BOL9A+/NY4KC5KWU4TupuDkq/XBb5AKuh
   szkTQMefQ5iY1DZmflyIGQxrY8iQkilyTZp3CBYZj7QClz/dpGh7a4xsA
   A==;
X-CSE-ConnectionGUID: GP3IlmV7QwKSvfu/AbRuuQ==
X-CSE-MsgGUID: twdGYvDZQ5iLl7uGfdgdIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51054363"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51054363"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:15:06 -0700
X-CSE-ConnectionGUID: fRGWWL1eRASml4rdXnlnCQ==
X-CSE-MsgGUID: nDhgLP/jQJ+f8s/32X3ciw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="108937914"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2024 04:15:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0D4572AC; Wed, 16 Oct 2024 14:15:00 +0300 (EEST)
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
Subject: [PATCHv4, REBASED 3/4] x86/64/kexec: Map original relocate_kernel() in init_transition_pgtable()
Date: Wed, 16 Oct 2024 14:14:57 +0300
Message-ID: <20241016111458.846228-4-kirill.shutemov@linux.intel.com>
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
2.45.2


