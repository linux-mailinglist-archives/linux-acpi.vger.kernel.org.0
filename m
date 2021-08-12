Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6153E9F11
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhHLG7z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 02:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234259AbhHLG7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 02:59:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 380286101E;
        Thu, 12 Aug 2021 06:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628751569;
        bh=ZQav6dV8arUW7JrdFYQDuwE6wrSwrjaeQEiFGD8y5Ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ub06Kjl0JOvhrwSvBoL2gmy7C5V9LcaLfJX4yihafiq4jwaM9ed18Mqq07gCxmmRc
         dBUACRxsjGNMUuPesEXB4NM6qhtbBc3iff2dr+pWlD3uXacnNjvXrSXOv2GQeEZaQk
         T5EjPvN6qf91Si5gNiyLWnmmqBhSVLnbq0cD1UTlLeu8DwjjPJIufFz/H/4NiX3LdV
         098Di3iHP3zb+sqspU8kt0rfVgMlCmHe6Mbha1VoXncA3Ntyr0cfpysaIXYyiVNUNf
         vyT317LfJl4oR3bkN1wEHq7OrIKJEGS3w+j+XOUsNEphrtv2u0D2L1lGU/XncCVEfF
         bZZ9cTh4OS0cw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Len Brown <lenb@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v4 1/2] x86/mm: memory_map_top_down: remove spurious reservation of upper 2M
Date:   Thu, 12 Aug 2021 09:59:06 +0300
Message-Id: <20210812065907.20046-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210812065907.20046-1-rppt@kernel.org>
References: <20210812065907.20046-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

memory_map_top_down() function skips the upper 2M in the beginning and maps
them in the end because

	"xen has big range in reserved near end of ram, skip it at first"

It appears, though, that the root cause was that there was not enough
memory in the range [min_pfn_mapped, max_pfn_mapped] to allocate page
tables from that range in alloc_low_pages() because min_pfn_mapped didn't
reflect that actual minimal pfn that was already mapped but remained close
to the end of the range being mapped by memory_map_top_down().

This happened because min_pfn_mapped is updated at every iteration of the
loop in memory_map_top_down(), but there is another loop in
init_range_memory_mapping() that maps several regions below the current
min_pfn_mapped without updating this variable.

Move the update of min_pfn_mapped to add_pfn_range_mapped() next to the
update of max_pfn_mapped so that every time a new range is mapped both
limits will be updated accordingly, and remove the spurious "reservation"
of upper 2M.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/mm/init.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 75ef19aa8903..87150961fdca 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -486,6 +486,7 @@ static void add_pfn_range_mapped(unsigned long start_pfn, unsigned long end_pfn)
 	nr_pfn_mapped = clean_sort_range(pfn_mapped, E820_MAX_ENTRIES);
 
 	max_pfn_mapped = max(max_pfn_mapped, end_pfn);
+	min_pfn_mapped = min(min_pfn_mapped, start_pfn);
 
 	if (start_pfn < (1UL<<(32-PAGE_SHIFT)))
 		max_low_pfn_mapped = max(max_low_pfn_mapped,
@@ -605,20 +606,14 @@ static unsigned long __init get_new_step_size(unsigned long step_size)
 static void __init memory_map_top_down(unsigned long map_start,
 				       unsigned long map_end)
 {
-	unsigned long real_end, last_start;
-	unsigned long step_size;
-	unsigned long addr;
+	unsigned long real_end = ALIGN_DOWN(map_end, PMD_SIZE);
+	unsigned long last_start = real_end;
+	/* step_size need to be small so pgt_buf from BRK could cover it */
+	unsigned long step_size = PMD_SIZE;
 	unsigned long mapped_ram_size = 0;
 
-	/* xen has big range in reserved near end of ram, skip it at first.*/
-	addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
-
-	/* step_size need to be small so pgt_buf from BRK could cover it */
-	step_size = PMD_SIZE;
 	max_pfn_mapped = 0; /* will get exact value next */
 	min_pfn_mapped = real_end >> PAGE_SHIFT;
-	last_start = real_end;
 
 	/*
 	 * We start from the top (end of memory) and go to the bottom.
@@ -638,7 +633,6 @@ static void __init memory_map_top_down(unsigned long map_start,
 		mapped_ram_size += init_range_memory_mapping(start,
 							last_start);
 		last_start = start;
-		min_pfn_mapped = last_start >> PAGE_SHIFT;
 		if (mapped_ram_size >= step_size)
 			step_size = get_new_step_size(step_size);
 	}
-- 
2.28.0

