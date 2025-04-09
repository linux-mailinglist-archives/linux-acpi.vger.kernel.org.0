Return-Path: <linux-acpi+bounces-12890-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDAA81DD4
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 09:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 425597B1D71
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 07:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C3C22B5A8;
	Wed,  9 Apr 2025 07:03:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6F1189B84;
	Wed,  9 Apr 2025 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182204; cv=none; b=utZVM3BZQSs8NSxMyIzV77FaJt3ku1Yr92LYqix4rkQ8Rv9MVW5uSiQjednfYVtqxmoJVTJIX/R4BbWKq9rWNVpEaQtrGa9fisBjcm334KljoUiZlT0E55AIYuom245UyHo5T8aQBGTznSgISulm86Vahq57UuqtlYZs7J9L0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182204; c=relaxed/simple;
	bh=q39kQhDN49GLm/lEOP32rR1ke0TxfqFy3ziGaeITL1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TnPl1bjuoG1WizjEpEkr0Mz41O97PBgG27gUwkOlKDIu4/T4XhdoFIbaqfYkA7hToOLPO9Czm2JW6TMOieht/6oGazFACt+LKLmSoQberLZQo4KnC6uI33S/SZNgvW+5TOHnVPlGIw/JMPKHmtXc12548CZ8fCPv+ZLEObGMaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnR7yyG_Zn9W65Ew--.14899S2;
	Wed, 09 Apr 2025 15:03:14 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBnaoasG_ZnhURkAA--.7272S3;
	Wed, 09 Apr 2025 15:03:09 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	jiaxun.yang@flygoat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	Jonathan.Cameron@huawei.com,
	dave.hansen@linux.intel.com,
	dan.j.williams@intel.com,
	alison.schofield@intel.com
Cc: chenbaozi@phytium.com.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] LoongArch: Introduce the numa_memblks conversion
Date: Wed,  9 Apr 2025 15:02:50 +0800
Message-Id: <20250409070250.3225839-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBnaoasG_ZnhURkAA--.7272S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAPAWf1gRgDIgADsm
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFWxtrW7Gr45Ar4UJrW5ZFb_yoWrGF4rpF
	ZxCrs3Xr48Wr18Ja40kry29w15Kwn7KanxXa47GFyfZF12vryDZr40grn2vFyUt3y8ur40
	9rn5C3WavF4rJ3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

"mm: introduce numa_memblks"(87482708210f) has moved numa_memblks
from x86 to the generic code, but loongarch was left out of this
conversion.

This patch introduces the generic numa_memblks.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---

Background
----------
I am managed to land the patch[1] "mm: numa_memblks: introduce numa_add_reserved_memblk"
but kernel test CI noticed build errors[2] from loongarch64-linux-gcc.

Link:
[1]: https://lore.kernel.org/all/20250409040121.3212489-1-wangyuquan1236@phytium.com.cn/
[2]: https://lore.kernel.org/all/202503282026.QNaOAK79-lkp@intel.com/

 arch/loongarch/Kconfig            |  1 +
 arch/loongarch/include/asm/numa.h | 14 ----------
 arch/loongarch/kernel/numa.c      | 43 +------------------------------
 3 files changed, 2 insertions(+), 56 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 067c0b994648..5906ccd06705 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -186,6 +186,7 @@ config LOONGARCH
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select NUMA_MEMBLKS
 	select OF
 	select OF_EARLY_FLATTREE
 	select PCI
diff --git a/arch/loongarch/include/asm/numa.h b/arch/loongarch/include/asm/numa.h
index b5f9de9f102e..bbf9f70bd25f 100644
--- a/arch/loongarch/include/asm/numa.h
+++ b/arch/loongarch/include/asm/numa.h
@@ -22,20 +22,6 @@ extern int numa_off;
 extern s16 __cpuid_to_node[CONFIG_NR_CPUS];
 extern nodemask_t numa_nodes_parsed __initdata;
 
-struct numa_memblk {
-	u64			start;
-	u64			end;
-	int			nid;
-};
-
-#define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
-struct numa_meminfo {
-	int			nr_blks;
-	struct numa_memblk	blk[NR_NODE_MEMBLKS];
-};
-
-extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
-
 extern void __init early_numa_add_cpu(int cpuid, s16 node);
 extern void numa_add_cpu(unsigned int cpu);
 extern void numa_remove_cpu(unsigned int cpu);
diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 30a72fd528c0..0ed384635566 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -18,6 +18,7 @@
 #include <linux/efi.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/numa_memblks.h>
 #include <asm/bootinfo.h>
 #include <asm/loongson.h>
 #include <asm/numa.h>
@@ -145,48 +146,6 @@ void numa_remove_cpu(unsigned int cpu)
 	cpumask_clear_cpu(cpu, &cpus_on_node[nid]);
 }
 
-static int __init numa_add_memblk_to(int nid, u64 start, u64 end,
-				     struct numa_meminfo *mi)
-{
-	/* ignore zero length blks */
-	if (start == end)
-		return 0;
-
-	/* whine about and ignore invalid blks */
-	if (start > end || nid < 0 || nid >= MAX_NUMNODES) {
-		pr_warn("NUMA: Warning: invalid memblk node %d [mem %#010Lx-%#010Lx]\n",
-			   nid, start, end - 1);
-		return 0;
-	}
-
-	if (mi->nr_blks >= NR_NODE_MEMBLKS) {
-		pr_err("NUMA: too many memblk ranges\n");
-		return -EINVAL;
-	}
-
-	mi->blk[mi->nr_blks].start = PFN_ALIGN(start);
-	mi->blk[mi->nr_blks].end = PFN_ALIGN(end - PAGE_SIZE + 1);
-	mi->blk[mi->nr_blks].nid = nid;
-	mi->nr_blks++;
-	return 0;
-}
-
-/**
- * numa_add_memblk - Add one numa_memblk to numa_meminfo
- * @nid: NUMA node ID of the new memblk
- * @start: Start address of the new memblk
- * @end: End address of the new memblk
- *
- * Add a new memblk to the default numa_meminfo.
- *
- * RETURNS:
- * 0 on success, -errno on failure.
- */
-int __init numa_add_memblk(int nid, u64 start, u64 end)
-{
-	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
-}
-
 static void __init node_mem_init(unsigned int node)
 {
 	unsigned long start_pfn, end_pfn;
-- 
2.34.1


