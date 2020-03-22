Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDD18EA61
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Mar 2020 17:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCVQ2t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Mar 2020 12:28:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:19657 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgCVQ2t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Mar 2020 12:28:49 -0400
IronPort-SDR: WNMCOkDXQHi6IFb3hZ7sKoFTS8fWMJFAX3dvSI8r46qqzb0zuJDG2S8hbdf9ElYNAHhAKyEMBN
 wq4nOXxFbdBA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:48 -0700
IronPort-SDR: 3s8iELj021j1FFAQUK4AG0Ur9DIcyl1ED2VlOZ9oPE0CcQIT7rGXig2NM2XwDInkLFYPARX2dC
 iX07GU8iB8aQ==
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200"; 
   d="scan'208";a="292367085"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 09:28:47 -0700
Subject: [PATCH v2 3/6] efi/fake_mem: Arrange for a resource entry per
 efi_fake_mem instance
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, peterz@infradead.org,
        dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, joao.m.martins@oracle.com
Date:   Sun, 22 Mar 2020 09:12:41 -0700
Message-ID: <158489356105.1457606.7319511363791228163.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
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
index c5399e80c59c..96babb3a6629 100644
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

