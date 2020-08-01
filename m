Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F72234FE8
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 05:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgHADlh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 23:41:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:47954 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgHADlg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 23:41:36 -0400
IronPort-SDR: od5A5c/RkbEpVp6JeWtRmFYeWjsaa//yx5FyUGiok5uOZuN3cCk8BuYu3cGni6zWkNQvrTteBB
 jUaIPeMkWVwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9699"; a="131470778"
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="131470778"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:36 -0700
IronPort-SDR: G8c5guRR8LeOP2swzcWsPlPUeVPP4jj1ULXz8yClVEj1fNfgxb6m/aXAd0SWagzDzkJNdaUTat
 ujZ2gFOfWxpA==
X-IronPort-AV: E=Sophos;i="5.75,420,1589266800"; 
   d="scan'208";a="273434900"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 20:41:36 -0700
Subject: [PATCH v3 03/23] efi/fake_mem: Arrange for a resource entry per
 efi_fake_mem instance
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, peterz@infradead.org,
        vishal.l.verma@intel.com, dave.hansen@linux.intel.com,
        ard.biesheuvel@linaro.org, vishal.l.verma@intel.com,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        joao.m.martins@oracle.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Fri, 31 Jul 2020 20:25:17 -0700
Message-ID: <159625231789.3040297.11578515658095829859.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In preparation for attaching a platform device per iomem resource teach
the efi_fake_mem code to create an e820 entry per instance. Similar to
E820_TYPE_PRAM, bypass merging resource when the e820 map is sanitized.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/kernel/e820.c              |   16 +++++++++++++++-
 drivers/firmware/efi/x86_fake_mem.c |   12 +++++++++---
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 983cd53ed4c9..22aad412f965 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -305,6 +305,20 @@ static int __init cpcompare(const void *a, const void *b)
 	return (ap->addr != ap->entry->addr) - (bp->addr != bp->entry->addr);
 }
 
+static bool e820_nomerge(enum e820_type type)
+{
+	/*
+	 * These types may indicate distinct platform ranges aligned to
+	 * numa node, protection domain, performance domain, or other
+	 * boundaries. Do not merge them.
+	 */
+	if (type == E820_TYPE_PRAM)
+		return true;
+	if (type == E820_TYPE_SOFT_RESERVED)
+		return true;
+	return false;
+}
+
 int __init e820__update_table(struct e820_table *table)
 {
 	struct e820_entry *entries = table->entries;
@@ -380,7 +394,7 @@ int __init e820__update_table(struct e820_table *table)
 		}
 
 		/* Continue building up new map based on this information: */
-		if (current_type != last_type || current_type == E820_TYPE_PRAM) {
+		if (current_type != last_type || e820_nomerge(current_type)) {
 			if (last_type != 0)	 {
 				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
 				/* Move forward only if the new size was non-zero: */
diff --git a/drivers/firmware/efi/x86_fake_mem.c b/drivers/firmware/efi/x86_fake_mem.c
index e5d6d5a1b240..0bafcc1bb0f6 100644
--- a/drivers/firmware/efi/x86_fake_mem.c
+++ b/drivers/firmware/efi/x86_fake_mem.c
@@ -38,7 +38,7 @@ void __init efi_fake_memmap_early(void)
 		m_start = mem->range.start;
 		m_end = mem->range.end;
 		for_each_efi_memory_desc(md) {
-			u64 start, end;
+			u64 start, end, size;
 
 			if (md->type != EFI_CONVENTIONAL_MEMORY)
 				continue;
@@ -58,11 +58,17 @@ void __init efi_fake_memmap_early(void)
 			 */
 			start = max(start, m_start);
 			end = min(end, m_end);
+			size = end - start + 1;
 
 			if (end <= start)
 				continue;
-			e820__range_update(start, end - start + 1, E820_TYPE_RAM,
-					E820_TYPE_SOFT_RESERVED);
+
+			/*
+			 * Ensure each efi_fake_mem instance results in
+			 * a unique e820 resource
+			 */
+			e820__range_remove(start, size, E820_TYPE_RAM, 1);
+			e820__range_add(start, size, E820_TYPE_SOFT_RESERVED);
 			e820__update_table(e820_table);
 		}
 	}

