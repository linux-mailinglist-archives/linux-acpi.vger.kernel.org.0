Return-Path: <linux-acpi+bounces-7572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30573951B1C
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E263C283ED1
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Aug 2024 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642031B1421;
	Wed, 14 Aug 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWaYXl/2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3651B0128;
	Wed, 14 Aug 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639584; cv=none; b=NwH6mMhi0QnXT9+i5QgaE/baO+EcGVNpMqe7VuS7H6jJr3tzENjuFqdZ9YuTlh0KGamg3JuTDsTUBt5edsypmlZhDyWPu7BCLZW5Bn0MlljI8deLKCnpolStw8TFdhPHgtWuB4Ngh6vKwZxBEgAz8R0u+K14thmxtjaPF/uKG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639584; c=relaxed/simple;
	bh=xqkr7/VA1/AeD7K6QlrSSsvf3Xe3T54LyIv+yVaaBsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaDd2udZ3IG96XYe+oH3NZurEuj57VzwYjDK4PzNT7j1alrnY37Zp8//xD+orXY8H2gUXzvFk+7czL851vHT3ZYOG9WSy4mlWZnzg8KDjlD0s9JgaVxuDzrfM0ubMkzwspUL/YFLRi8uMZ35OI0nqStWvqRlf1nCapRYnO0Mv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWaYXl/2; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723639582; x=1755175582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xqkr7/VA1/AeD7K6QlrSSsvf3Xe3T54LyIv+yVaaBsA=;
  b=ZWaYXl/2flLjg8UhzigbvOzjE8GdIuiSn3otxqP36eJ+IBlWlzKnvB9C
   +4elB8cMEX2XtqcaP3qIa+aR838kMmF8y2usIBk2kYuErqNk5tkWvprOy
   qaj+w2Mo3rfZqt0ZEr/hzOhdoTKXCwJskGC/RbbU8g6pG+AYTpXn/uzg5
   Ptsbh30KXzCDKCDGecgBA4Y11jXN67Mk5HnCxbzNwvGj6XV8+E6YxjbaW
   rgNsP82klXuNAn6pUUMcuvpQNdJlyQINxko4tJ0V9E7EesIOecXVfOoll
   5t83qM3Deoeq0QTsFgyXd6aAN8FJPYkjWXFUnexuoSVHa0XcisuGL2uhM
   w==;
X-CSE-ConnectionGUID: P3Kv6IDbTuiC/joT0z9X3w==
X-CSE-MsgGUID: fFaKSmsKTLaKG9io9CYlWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32426935"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="32426935"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 05:46:20 -0700
X-CSE-ConnectionGUID: /w30+m+1QsaptXoMwRK3nw==
X-CSE-MsgGUID: s8FVJj5TRgyPWT0YEqhS6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; 
   d="scan'208";a="58886410"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2024 05:46:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 720D017F; Wed, 14 Aug 2024 15:46:14 +0300 (EEST)
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
Subject: [PATCHv2 1/4] x86/mm/ident_map: Fix virtual address wrap to zero
Date: Wed, 14 Aug 2024 15:46:10 +0300
Message-ID: <20240814124613.2632226-2-kirill.shutemov@linux.intel.com>
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

Calculation of 'next' virtual address doesn't protect against wrapping
to zero. It can result in page table corruption and hang. The
problematic case is possible if user sets high x86_mapping_info::offset.

Replace manual 'next' calculation with p?d_addr_end() which handles
wrapping correctly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
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


