Return-Path: <linux-acpi+bounces-7777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944E95B52B
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D79A281124
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 12:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493EB1C9DCF;
	Thu, 22 Aug 2024 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdN4PAxV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD748181B87;
	Thu, 22 Aug 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330410; cv=none; b=g6rnf/aNP0iiFAL+wWNSUz4D3X7RZTjiTuMEgLORuyjzWwoxpW69AX7TmYoq3J7aBD38f5hFGpnu/ulpdClRx29e2VnH+kmXNXL79Fbs+UfzkUkVsW/L8WTt+cHOMKpOsgu6/quMyoCULulGSWPgRLOfHkgKFs6A0t0I3bfKa/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330410; c=relaxed/simple;
	bh=o8GaH3tn8yQHjvX1TbIRinqknzeRTVHuSafiEciVSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOkP4eXZE1dREZVSv6Le4dAyziTmoy977JMcr7CojjgxoKtSjY7j3SNUpGNgVAmta3L4aWPD+x9sZPKX0YFX5XyLuGBMhxsrw+Xi7ds4Ed9S66RUrrwdWX07Cag+vXEIutAdV/PCL+mBMKhzo5orCtnW57m+z+DNnxpzzsSGveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdN4PAxV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724330409; x=1755866409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o8GaH3tn8yQHjvX1TbIRinqknzeRTVHuSafiEciVSrc=;
  b=FdN4PAxVJHTdbxPXevO7D7Yv0eJHOg8Cvej6JLuQtWRWxHihPyG1KewW
   3qboVo/nhovJ6l0v2W7VJQXtsJVoIdIc26U+HefLKRpJbmNzly3tLFvJ9
   o2IGQocBqCJ7WyBLeXIBK0yGhfvXpuPV0+edDxzVy73nbvF1jLfv9175m
   8/hN8rp5HHuCbeEGycPUMDGCZfC+S1L5ZJT+p4NLX37lZtEKXzNna+Oo5
   6fogC3HnXwwxtkULhlteXyyrL34wYg+UdwRzghNbrMkUJXTmwCfuw1rKh
   GnxI4fL0zN3WT9Qy7hLBZ9ib2ZcUThri+Xq09PHqKKmlngW8VqqA1sBxb
   w==;
X-CSE-ConnectionGUID: tx5Nl5WYRqKkyblA150ZrQ==
X-CSE-MsgGUID: G09r91iOR1OOPeMvyZY6cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="25635669"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="25635669"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:40:08 -0700
X-CSE-ConnectionGUID: N+QYkLQWRQy3O0wBzY/BNA==
X-CSE-MsgGUID: 9JTr/ASpSguPvM1WMUyHYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="61443076"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 22 Aug 2024 05:40:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 17D592B3; Thu, 22 Aug 2024 15:40:02 +0300 (EEST)
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
Subject: [PATCHv4 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
Date: Thu, 22 Aug 2024 15:39:57 +0300
Message-ID: <20240822124000.1171321-2-kirill.shutemov@linux.intel.com>
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
2.43.0


