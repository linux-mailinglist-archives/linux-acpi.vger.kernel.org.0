Return-Path: <linux-acpi+bounces-17743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 880AABD8489
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Oct 2025 10:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 183743502B4
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Oct 2025 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDA52D876F;
	Tue, 14 Oct 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Lf4wq/qR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2E202997;
	Tue, 14 Oct 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431921; cv=none; b=uHXJYaSqSaD/+WJ6Rlv3oe6ISlRYR2T2n7xRo73AyApGI9FJM1b/dPfFnTFeWu8/AUvASXjbjfOFz/DfnjDLvIWL7P0ESeiE1EJSa8LgLjhLqHMUXRcEXFKXezV3ayfKJEZVzLAI6i5PyZWpO2tGn5P0bf6IY/8eqzN4N76WI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431921; c=relaxed/simple;
	bh=UvFLM1o3OjuPR2iY1LxjT+Kl0BLl/LRWqiF/qrAzLL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IkXLrd64XYdn9VU/57ZY4ym+aXu5yMgSf/oPTwFB6wcYYqIdyxxbgOTbaUrkr03rBhIgt+nSEt6q+xM07vYCtsY5z8LpjqAgzV2ff6+7I/ctwY6071CNQbzYX+ktl39+ulyKLa8jvIECebT+++CkcB3arPcJuo4sTYgiyVXoJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Lf4wq/qR; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760431915; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XBiiaHIBGRhT/NrQaIL2/d1EaMcD+fFzzlxI8lq56dM=;
	b=Lf4wq/qRrm5xWLXi2i4qbAAbo0EiENHJggYEh25oVsHznw1cu3BmQB6TbBRAdGhFbS0HS8g4CU/vQ9iUgJ62aKcowNa0EUk8cAymLWSfyY5iCh31LtjF1wcfvEnFeJ7XXVqaNT2fbCnTxIGWahJyF7OtOs+ry4R0OGi94VdcgR0=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WqBFY4T_1760431914 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 16:51:54 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	James Morse <james.morse@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] ACPI: PPTT: Dump PPTT table when error detected
Date: Tue, 14 Oct 2025 16:51:54 +0800
Message-Id: <20251014085154.59557-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was warning message about PPTT table:
"ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
and it in turn caused scheduler warnings when building up the system.
It took a while to root cause the problem be related a broken PPTT
table which has wrong cache information.

To speedup debugging similar issues, dump the PPTT table when there
is warning about it.

The dumped info on a ARM server is like:

    ACPI PPTT: Processors:
    P[  0][0x0024]: parent=0x0000 acpi_proc_id=  0 num_res=1 flags=0x11(package)
    P[  1][0x005a]: parent=0x0024 acpi_proc_id=  0 num_res=1 flags=0x12()
    P[  2][0x008a]: parent=0x005a acpi_proc_id=  0 num_res=3 flags=0x1a(leaf)
    P[  3][0x00f2]: parent=0x005a acpi_proc_id=  1 num_res=3 flags=0x1a(leaf)
    P[  4][0x015a]: parent=0x005a acpi_proc_id=  2 num_res=3 flags=0x1a(leaf)
    ...
    ACPI PPTT: Caches:
    C[   0][0x0072]: flags=0x7f next_level=0x0000 size=0x4000000  sets=65536  way=16 attribute=0xa  line_size=64
    C[   1][0x00aa]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x4  line_size=64
    C[   2][0x00c2]: flags=0x7f next_level=0x00da size=0x10000    sets=256    way=4  attribute=0x2  line_size=64
    C[   3][0x00da]: flags=0x7f next_level=0x0000 size=0x100000   sets=2048   way=8  attribute=0xa  line_size=64
    ...

From it, we can see the processor/cache info and the hierarchy relation
between them.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/acpi/pptt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 54676e3d82dd..e7b48a77a12f 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -498,6 +498,79 @@ static void acpi_pptt_warn_missing(void)
 	pr_warn_once("No PPTT table found, CPU and cache topology may be inaccurate\n");
 }
 
+static void acpi_dump_pptt_table(struct acpi_table_header *table_hdr)
+{
+	struct acpi_subtable_header *entry, *entry_start;
+	unsigned long end;
+	struct acpi_pptt_processor *cpu;
+	struct acpi_pptt_cache *cache;
+	u32 entry_sz, i;
+	u8 len;
+	static bool dumped;
+
+	/* PPTT table could be pretty big, no need to dump it twice */
+	if (dumped)
+		return;
+	dumped = true;
+
+	end = (unsigned long)table_hdr + table_hdr->length;
+	entry_start = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+			     sizeof(struct acpi_table_pptt));
+
+	pr_info("Processors:\n");
+	entry_sz = sizeof(struct acpi_pptt_processor);
+	entry = entry_start;
+	i = 0;
+	while ((unsigned long)entry + entry_sz <= end) {
+		len = entry->length;
+		if (!len) {
+			pr_warn("Invalid zero length subtable\n");
+			return;
+		}
+
+		cpu = (struct acpi_pptt_processor *)entry;
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
+
+		if (cpu->header.type != ACPI_PPTT_TYPE_PROCESSOR)
+			continue;
+
+		printk(KERN_INFO "P[%3d][0x%04lx]: parent=0x%04x acpi_proc_id=%3d num_res=%d flags=0x%02x(%s%s%s)\n",
+			i++, (unsigned long)cpu - (unsigned long)table_hdr,
+			cpu->parent, cpu->acpi_processor_id,
+			cpu->number_of_priv_resources, cpu->flags,
+			cpu->flags & ACPI_PPTT_PHYSICAL_PACKAGE ? "package" : "",
+			cpu->flags & ACPI_PPTT_ACPI_LEAF_NODE ? "leaf" : "",
+			cpu->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD ? ", thread" : ""
+			);
+
+	}
+
+	pr_info("Caches:\n");
+	entry_sz = sizeof(struct acpi_pptt_cache);
+	entry = entry_start;
+	i = 0;
+	while ((unsigned long)entry + entry_sz <= end) {
+		len = entry->length;
+		if (!len) {
+			pr_warn("Invalid zero length subtable\n");
+			return;
+		}
+
+		cache = (struct acpi_pptt_cache *)entry;
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry, len);
+
+		if (cache->header.type != ACPI_PPTT_TYPE_CACHE)
+			continue;
+
+		printk(KERN_INFO "C[%4d][0x%04lx]: flags=0x%02x next_level=0x%04x size=0x%-8x sets=%-6d way=%-2d attribute=0x%-2x line_size=%d\n",
+			i++, (unsigned long)cache - (unsigned long)table_hdr,
+			cache->flags, cache->next_level_of_cache, cache->size,
+			cache->number_of_sets, cache->associativity,
+			cache->attributes, cache->line_size
+			);
+	}
+}
+
 /**
  * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
  * @table: Pointer to the head of the PPTT table
@@ -534,6 +607,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 	}
 	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
 		    cpu, acpi_cpu_id);
+
+	acpi_dump_pptt_table(table);
 	return -ENOENT;
 }
 
-- 
2.43.5


