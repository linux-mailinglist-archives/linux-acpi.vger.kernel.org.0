Return-Path: <linux-acpi+bounces-19915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAADCEBCFD
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Dec 2025 11:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26BF630281A0
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Dec 2025 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925327C84B;
	Wed, 31 Dec 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WNAkSFxD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B96225417;
	Wed, 31 Dec 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767178162; cv=none; b=BdDQNJNQn8TB3+mJoI7rbV/bt92Y3GGzSy2GUu76IJ6U/d36+F+nAjDyvbESIbNAeaKzZ5k27RP+KemuOPttq9gQT9nakxvKeLm22g7l2/IhLaOM9mJXf5L/nhg1JWGYEbxIr8uP+5HAplUEJVk+sqJjMWjwRhbO9UEPvXKpxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767178162; c=relaxed/simple;
	bh=wesGWpaFZfLfc/qcrebn5WJGQNMib4kGF7+MrpA0JXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MftRFR5M8N8WkvAmXe4lP2E/14E6V+5TX8KHUFfw1GP72xororNVYDG07DQw0WEby/ZHZNR65TgGQX1slk4nclc9ZazTQW5+0Lh4x51jctOe3E0DfsOouEY+7zLP5aMw+3G5vbGx4HMoko8UonHZjcMabZlJied9FiYrETI3O7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WNAkSFxD; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767178150; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Bb1n0ZhpW/PPrNYcQOofvr3GIFzDTWK4I+Gn+/f9wYo=;
	b=WNAkSFxDFhf3yZ4UGHXzxPyWChoPC6k+pP8faRZTxGKDWPkgCZmJx0Jvx4kbEdvsrFIyjXbx4GsqU5v/VoO45lNjj9C7RVhbeYCHN+crifpNJ0kIjNKcnHOTKOgf+SFUj6dfGVBTHCpumxB87CqLA/idG41XSg7nunwFyo6ObbU=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0Ww0smfC_1767178149 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 31 Dec 2025 18:49:10 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	James Morse <james.morse@arm.com>
Cc: Joanthan Cameron <Jonathan.Cameron@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
Date: Wed, 31 Dec 2025 18:49:09 +0800
Message-Id: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
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

To speedup debugging similar issues, dump the PPTT table, which makes
the warning more noticeable and helps bug hunting.

The dumped info format on a ARM server is like:

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

It provides a global and straightforward view of the hierarchy of the
processor and caches info of the platform, and from the offset info
(the 3rd column), the child-parent relation could be checked.

With this, the root cause of the original issue was pretty obvious,
that there were some caches items missing which caused the issue when
building up scheduler domain.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changelog:

  v2
  * rebase againt 6.19 and refine the commit log

 drivers/acpi/pptt.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index de5f8c018333..e00abedcd786 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -529,6 +529,79 @@ static void acpi_pptt_warn_missing(void)
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
@@ -565,6 +638,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
 	}
 	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
 		    cpu, acpi_cpu_id);
+
+	acpi_dump_pptt_table(table);
 	return -ENOENT;
 }
 

base-commit: c8ebd433459bcbf068682b09544e830acd7ed222
-- 
2.39.5 (Apple Git-154)


