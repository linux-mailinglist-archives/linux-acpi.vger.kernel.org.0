Return-Path: <linux-acpi+bounces-8817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 596049A0827
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 13:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E51A1F228DB
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF91207A3C;
	Wed, 16 Oct 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dg2i3tSq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587012076CC;
	Wed, 16 Oct 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077309; cv=none; b=rE+Ldi6yfacmy7FRaHmh46yu3OzmQDsx5D/Ysmo3YIJFMXmGM8UG82kTJlbLF+x+q1xYHFp96ZAOSC6SB9OEGUfwdBs4QsIGnTu/zZehQy+VJlvICYtHlpJnvaozPIGPWl04KzeeWqcwZnVHwooS4XYs837mjTB2q5118kQsa7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077309; c=relaxed/simple;
	bh=2G12tmQBMRi94wiYlnzPggyN9sb1W4iSnDlgG9gAd9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=injQlmof7nGXhfaWe4xKUtFiKatohfQI5IYeFKVxtNvw0wkZP4wtqF1QJxeOwiUBXpRjzg5I0C7TJeD/o6xQj7CMlT0Hk3eU0c1kjZVSh5SlRVqAlMJFz8dznCfnbp3Ntlqr45c0kujkpgwwzVvUBmCA/u9gUYmiVBQFstmkITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dg2i3tSq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729077309; x=1760613309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2G12tmQBMRi94wiYlnzPggyN9sb1W4iSnDlgG9gAd9I=;
  b=Dg2i3tSqi9qGiAudUVI+DZpGAmUJUkl4Xy0+wvQoEe6+xQhONkTTxiLV
   oMFWpKuCVdUSHSHSilMvwhUFqrqHoRA6Jy+lm5J6bg56ZJXUxyhDqBMo5
   YNQUemV0hcsSjbjpWsSfXJ8YekhdAx2Jo5GEC36qgAd+diZzF9AKf/jgl
   7URdiKDVUodnA+5f+VHEo+4hYQhsQtE4l0WBvgwh04pbLrrE24fRSGNQD
   XViIrLKP5OOMZOJtsQjqOmnQ/N3gYh/JJtTHUvUGp9xey8m0qUG/+FvIA
   rcJruJWRAYEPl/zOFfCPIjDJuQ3d4LFaC3hbm1+X74GOx6L+hpDQCsE1M
   A==;
X-CSE-ConnectionGUID: R/zfUpSDRvKQDrMswyya+A==
X-CSE-MsgGUID: EFSqUkQ1RMWQImD5z/Cwvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39066168"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39066168"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 04:15:06 -0700
X-CSE-ConnectionGUID: OSZnxQsVTTqIzlqFj+V4Sg==
X-CSE-MsgGUID: q9Bkae3YSLiVD3IOv6T/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83005216"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 16 Oct 2024 04:15:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E3F9FCB; Wed, 16 Oct 2024 14:14:59 +0300 (EEST)
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
Subject: [PATCHv4, REBASED 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
Date: Wed, 16 Oct 2024 14:14:55 +0300
Message-ID: <20241016111458.846228-2-kirill.shutemov@linux.intel.com>
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

Calculation of 'next' virtual address doesn't protect against wrapping
to zero. It can result in page table corruption and hang. The
problematic case is possible if user sets high x86_mapping_info::offset.

The wrapping to zero only occurs if the top PGD entry is accessed.
There are no such users in the upstream. Only hibernate_64.c uses
x86_mapping_info::offset, and it operates on the direct mapping range,
which is not the top PGD entry.

Replace manual 'next' calculation with p?d_addr_end() which handles
wrapping correctly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/mm/ident_map.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 437e96fb4977..5872f3ee863c 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -101,9 +101,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		pmd_t *pmd;
 		bool use_gbpage;
 
-		next = (addr & PUD_MASK) + PUD_SIZE;
-		if (next > end)
-			next = end;
+		next = pud_addr_end(addr, end);
 
 		/* if this is already a gbpage, this portion is already mapped */
 		if (pud_leaf(*pud))
@@ -154,10 +152,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		p4d_t *p4d = p4d_page + p4d_index(addr);
 		pud_t *pud;
 
-		next = (addr & P4D_MASK) + P4D_SIZE;
-		if (next > end)
-			next = end;
-
+		next = p4d_addr_end(addr, end);
 		if (p4d_present(*p4d)) {
 			pud = pud_offset(p4d, 0);
 			result = ident_pud_init(info, pud, addr, next);
@@ -199,10 +194,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		pgd_t *pgd = pgd_page + pgd_index(addr);
 		p4d_t *p4d;
 
-		next = (addr & PGDIR_MASK) + PGDIR_SIZE;
-		if (next > end)
-			next = end;
-
+		next = pgd_addr_end(addr, end);
 		if (pgd_present(*pgd)) {
 			p4d = p4d_offset(pgd, 0);
 			result = ident_p4d_init(info, p4d, addr, next);
-- 
2.45.2


