Return-Path: <linux-acpi+bounces-6699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758091DFA4
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 14:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EB328321D
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0000158DAE;
	Mon,  1 Jul 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eh6xH8wH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5851113213D;
	Mon,  1 Jul 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837828; cv=none; b=O4VSeCj2/64S8D/FtePBMLkFAkzcHK6mO+dnY+KmJ+IcY6ndkSPxkB8uST+/g6f8byy8D7tgqwTTnVWLyzk3flaE1uJYgEOCQcIvF28189E6rj42yegi9nsC2vv6Mt2NUVDfO6OtHTkMGSq2r9Rc4DQ07idd3A3FQskYLMYegA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837828; c=relaxed/simple;
	bh=4dJPOn2wSzjYPHEtO815W8ilxheAN85kZevrftGA81Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzlVtBBNVWGeQy3e/c8jeTTI5g9Y1OnKUhNtl8Ddc2xZ1beadgJQIQBOZVE5ATdWD9ImFhfGVdbf+GHSdTcGCBlRDLSRJwFkICCEdpf7/txj7qTw59iF+pQ1wZV3HLsiFSdNjIgsOSFgx0nO1PcmL4VS8PS7Erg1uQXLh0Tt+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eh6xH8wH; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719837827; x=1751373827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4dJPOn2wSzjYPHEtO815W8ilxheAN85kZevrftGA81Q=;
  b=Eh6xH8wHzwQ2aD9QN1wVJul0slVt+96W7+KhpcazrN/epEw13wsnKiNx
   HWsGUbqj/oyYg81B4jiPvDGxN133ajeSBK/xQDJ+1Gm3fP+sf83J1R7dM
   0NuDZusSI6yB6DOC4lXF6REwdhdKNXJ6WS8fEWg4QaslrL6VOPyIJX7YR
   QFvCJ33MedmYufYo2WQ7USzes5DV9O4SUnbMzPWl+4CHXN8k3jQQKI7lE
   B3WKFh/xkFbJ+P5xsp+Wjp0IrpDc4hlyTWnHHMH5YTMlIR3/KKqERyiPT
   a4CUp6uAQXHL4wlh9YKSBAjrfbr5oB2wKlemJFQqZF36oUvYqkBzq5T25
   A==;
X-CSE-ConnectionGUID: RDBo2FdDQe62xWDFbinb8g==
X-CSE-MsgGUID: LEG5JaTLSuiILunrTwRlhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16797983"
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="16797983"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 05:43:46 -0700
X-CSE-ConnectionGUID: o4r0dtA6Q9aj4qTAi6Fxkw==
X-CSE-MsgGUID: 4+Ce8L5lRwmRcq5kDIRvfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,176,1716274800"; 
   d="scan'208";a="50469588"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 01 Jul 2024 05:43:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4BD70330; Mon, 01 Jul 2024 15:43:41 +0300 (EEST)
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
Subject: [PATCH 1/3] x86/mm/ident_map: Fix virtual address wrap to zero
Date: Mon,  1 Jul 2024 15:43:32 +0300
Message-ID: <20240701124334.1855981-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
References: <20240701124334.1855981-1-kirill.shutemov@linux.intel.com>
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

Replace manual 'next' calculation with p?d_addr_and() which handles
wrapping correctly.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/mm/ident_map.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index c45127265f2f..7422146b0dc9 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -100,10 +100,7 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
 
-		next = (addr & PUD_MASK) + PUD_SIZE;
-		if (next > end)
-			next = end;
-
+		next = pud_addr_end(addr, end);
 		if (info->direct_gbpages) {
 			pud_t pudval;
 
@@ -141,10 +138,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
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
@@ -186,10 +180,7 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
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


