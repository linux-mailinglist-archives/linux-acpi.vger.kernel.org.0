Return-Path: <linux-acpi+bounces-7647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EF956413
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 09:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30EA9B210FD
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 07:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2F15622E;
	Mon, 19 Aug 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7uMBitx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264541B960;
	Mon, 19 Aug 2024 07:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051317; cv=none; b=b85pO3aQOjlMe5iZAszqN7L2QxSE2NM1xLCg8cSmjQRBz9Xo4jWmfquxLn140EtRTnHSq+hV98fWUVGdyvDF3fW1yt9A/Dnu7JRKK0IggcdgqFsOkMIG0fGFzpCs5PRnIfZk2BRU2HiVI9XjM45JBgYwZ0bR61WDcQEBG3EKrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051317; c=relaxed/simple;
	bh=UWxjYETrwKYpnkeQWK7cdIq4YlS3gl5oLnqpqmIeIrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SX51M94XyDyGw0ShACHMXQkSeeiWC8oFqpo2RxhhqGKk7rNLC5jkflRIhdeYc1DA2Z31oWoYk9mINOk4fYi6d9vBn2wKgQ4cVj9w4iCi5p3FPNtLGxNJk1tMdCIyQCkdi1dRgQmgf1qMP8JC++o5+sh3FVfrz3pvDsngkUM/Ck8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7uMBitx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724051316; x=1755587316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWxjYETrwKYpnkeQWK7cdIq4YlS3gl5oLnqpqmIeIrc=;
  b=j7uMBitxb43s2OjlFqyjHkXMLxcs2SIuWS/0ci5A/z2Kd0PEvPcpKA5b
   ZTWnV1/3HOaJP2A8vVEIS1J+VKB1eLc3OoMujatxQeWjVeLJ1wGFwXdxi
   IRQEOj0XT6wyh9igTFnKKL6F5NnCzgs++Y2DxKNHqllmOkTH3AudWzvyP
   H1CUzI3RUx6TdXBl8QhF40yQC9i7X8uSWh1+M/UHiRqrEJ6Fda1SwfA4p
   /vZR4NoQp557+C0XrpW9hO9D+7FH4ccz+6WLtW1G7bKg5Q553h4KP8Vuj
   NBaTZe0qRoKnE9OAIV5aiT8oJ0vPtcIZKZVOxx1jhijbTLRQdykCGn34X
   Q==;
X-CSE-ConnectionGUID: XRULnYE9QgKhBbwfxCcqXw==
X-CSE-MsgGUID: SjyWQuPFT/mZLoOSq7A9hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="44804862"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="44804862"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:08:36 -0700
X-CSE-ConnectionGUID: HsZlm58LQPykTvOHDHNebA==
X-CSE-MsgGUID: dRm1BgzDRVK0PBZpSBNM6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65113230"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2024 00:08:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 72DC6452; Mon, 19 Aug 2024 10:08:30 +0300 (EEST)
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
Subject: [PATCHv3 3/4] x86/64/kexec: Map original relocate_kernel() in init_transition_pgtable()
Date: Mon, 19 Aug 2024 10:08:26 +0300
Message-ID: <20240819070827.3620020-4-kirill.shutemov@linux.intel.com>
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


