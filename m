Return-Path: <linux-acpi+bounces-7574-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8426951B20
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 14:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BAD1F23E46
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5CE1B1502;
	Wed, 14 Aug 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aeke90bB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E981B1424;
	Wed, 14 Aug 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639585; cv=none; b=LIbL+4K8DB/SW2qJtW7J3h5pLvL2NOMgnjlEwcoOgOKQ/bUXE0/sA4CGq0jDvO1iM3CHlgoRB3su0XFgVA0make1uWTQH6Mdu8jdxM2fi2XmxsWDEQ+NAHSERqN8IaokOM0DXu+rBk10/3Bv8z2FS62fw6BjPNPPOyVrRB2WZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639585; c=relaxed/simple;
	bh=UWxjYETrwKYpnkeQWK7cdIq4YlS3gl5oLnqpqmIeIrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGkxpnxNVsCM5I21rwLuU0ZAQGJZzS9HGLT2Ux9lUd4IXIySJMqFCnm2WDFLwAsbR8wVLzREe+IeQ4QzsM68qUaNyUPCjIl3tL89kaBvhvhl4ENITGzDyFwtlivKKojX7I/eV8VJJ6yQFbIPXoKAspFIuJuLns1yF4hKiKxGyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aeke90bB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723639584; x=1755175584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWxjYETrwKYpnkeQWK7cdIq4YlS3gl5oLnqpqmIeIrc=;
  b=aeke90bBZF/vGpSOY2euadbD+UabrMTQDeSRVOUR+0n0kPPFsw9bkRlV
   rq3zBIg2qmC+nOVYf9tEmClub3L8g2tFbdJHkfVxrepwS2+x5WyUlXDuX
   DTlsC7mp7rBc+MSgv5M4ePmbWtAKYEEXsE+uRHTajNAdmMxgAC3A/1g7O
   jMomCBcVJOCZXvJv8+wk8p8ibMJgjYlWUTwIpyqC5hQtrOyBmkCA2K2Ya
   /z7n4dsSOja5dEjTK3wDwrb5roYD4vjQD86uy0BQCofPzwohvIvEAdz+3
   rBg9jEJ83SY4z5zwhjuLdaIBIF/hrmoUe5j27tQCdd1CZxxwlZLVuKo/h
   Q==;
X-CSE-ConnectionGUID: F1ObqZOPTPeLxE4sM8H86w==
X-CSE-MsgGUID: OX6Iw//0ToucqEqm6mwTEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32426974"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="32426974"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:46:20 -0700
X-CSE-ConnectionGUID: nNw7kFyaQiiiioFI5c8XyQ==
X-CSE-MsgGUID: C0Yp4WoaQzmKtT+9oxYNuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="58886400"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2024 05:46:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8A8153BC; Wed, 14 Aug 2024 15:46:14 +0300 (EEST)
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 3/4] x86/64/kexec: Map original relocate_kernel() in init_transition_pgtable()
Date: Wed, 14 Aug 2024 15:46:12 +0300
Message-ID: <20240814124613.2632226-4-kirill.shutemov@linux.intel.com>
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


