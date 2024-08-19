Return-Path: <linux-acpi+bounces-7649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B9956416
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C521F21634
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990A2157A5A;
	Mon, 19 Aug 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAPhoRaD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE973155A59;
	Mon, 19 Aug 2024 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724051319; cv=none; b=ek0Ke7Xf6MHjtAro5aVsIKB5I3ZFk568C8jd58+tVhEeWR499BP06oVTYaHry+p8benpIbv6OPopVjCP2u3gktl30X2k/lJ6IvDJiIcw3BqXCLz0Jtbnaz4YgpU1Y1QuZRtHXwCOC/dNtbd7XjEHAXcDOjxJWzAccil2Xqdwito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724051319; c=relaxed/simple;
	bh=o8GaH3tn8yQHjvX1TbIRinqknzeRTVHuSafiEciVSrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWafnRWYJVCBdRS6HVzpR6np0CK3qqzPSisOb8tZOIznvjRJZM46565Yqhzt90N39O2f0qp7HNUYwgJNQ48VLMO2RIVjB0BwXQfL3rY+kk5mFhBH7JCyipA+4cz7Ic3UtVMk53SsS5zDkc98adbivx3Tppc+929uoFKFa6Knc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAPhoRaD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724051318; x=1755587318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o8GaH3tn8yQHjvX1TbIRinqknzeRTVHuSafiEciVSrc=;
  b=RAPhoRaDk/dM+YNGmjbRKg/oM8SblBVvqRilUZE9bpACwmgh90UImsxv
   3n2Kv1KygUp9ITUhF8RKfz0PcgZ0t7i1JdwLj4czxC+6tKfZ3I99Gyfwx
   OaUbNZ+PfFzOYRThWVQv6u3dNg0zLC70lublC3wzDlgUMkMW+UYK8Pd2g
   QmD0XfJBh6QHJx9lPxst4IGSiZnpNIwnyKOJu0tAQtxNW1rklyOJCHmFi
   SqVie8M0PyRsDTOOK8gqojk7V26XK+UdwxWFo0agR/Amimq7QGUyVTUow
   s2T0r8tMKyIE+yu7zWzt7VhZew2Udqusov7JRhpyBfabeXiUrq1xPcd8p
   Q==;
X-CSE-ConnectionGUID: 6oeQ3to2SWuYidpyFjwHXQ==
X-CSE-MsgGUID: XD2Nv/pFS+CgjzQsC7Sfhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="44804870"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="44804870"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 00:08:36 -0700
X-CSE-ConnectionGUID: 6z43RZPDSAmG0nk/NB0Uag==
X-CSE-MsgGUID: TErgdoC5SSGjb2fepMwr/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="65113280"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2024 00:08:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5300C252; Mon, 19 Aug 2024 10:08:30 +0300 (EEST)
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
Subject: [PATCHv3 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
Date: Mon, 19 Aug 2024 10:08:24 +0300
Message-ID: <20240819070827.3620020-2-kirill.shutemov@linux.intel.com>
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


