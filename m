Return-Path: <linux-acpi+bounces-12290-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E89A64952
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBE03A8498
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB15233D85;
	Mon, 17 Mar 2025 10:16:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A930233727;
	Mon, 17 Mar 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206584; cv=none; b=Iwt6h5Fp4bmedQ3ztgTh/vveg9ORvTYeGc4yuDPhmW8Auqgexrs1GMls4a4U8oOhBsNFJ9TuysXcm/JidXwWsCXzDfw1/cVefR1aNCvjrB3HgHihcS7zok7F9SfmEAsfelCqezzlIQ/KJVr2c0DnrM3unT1lkvp9knPXIpr6B3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206584; c=relaxed/simple;
	bh=bSSPfp5wQHv84WQnZjxG+HqfSddAKKTcsknWCc99ZRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l8Xxa8ueUTH4Q5vLgLYvSkPhjcj6q/dcTZBKYiMlSB6JVTeU/4G0HaNAkXHIgkWV28jPy75lOIwHV8+vHXgRR8taAb+5ltLyJfizH0vLF8NriXdtlMHAPNkqJqGvcP3VV5MENpRzJ1CmDBfuoZ7eLznt4F4QPP0eAMYT3vTdFaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXH69o9tdnVnzGCg--.46584S2;
	Mon, 17 Mar 2025 18:16:09 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDX2oZU9tdncdJLAA--.4190S4;
	Mon, 17 Mar 2025 18:15:58 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	bfaccini@nvidia.com,
	rafael@kernel.org,
	lenb@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	haibo1.xu@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v3 1/2] mm: numa_memblks: introduce numa_add_reserved_memblk
Date: Mon, 17 Mar 2025 18:15:32 +0800
Message-Id: <20250317101533.2582624-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317101533.2582624-1-wangyuquan1236@phytium.com.cn>
References: <20250317101533.2582624-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDX2oZU9tdncdJLAA--.4190S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAMAWfXLewE-wAAsG
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7ZF1xXFyfZw48Jw15ZF1kZrb_yoW8CF1Dpa
	1DG3W5Wa18Gw4xWw1xury0kw1Sg3WFkFyDJry7Gr43Zr1Fqry2vr4UAFs3Zrn0yrW2kr1r
	Gr4vyr15uw1rGFUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

With numa_add_reserved_memblk(), kernel could add numa_memblk into
numa_reserved_meminfo directly.

In previous, such process relies on numa_add_memblk() adding to
numa_meminfo list first and then uses numa_move_tail_memblk() to
move one from numa_meminfo to numa_reserved_meminfo.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 include/linux/numa_memblks.h |  1 +
 mm/numa_memblks.c            | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index dd85613cdd86..991076cba7c5 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -22,6 +22,7 @@ struct numa_meminfo {
 };
 
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
+int __init numa_add_reserved_memblk(int nid, u64 start, u64 end);
 void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
 
 int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index ff4054f4334d..e70c76cc46dd 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -200,6 +200,22 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
 	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
 }
 
+/**
+ * numa_add_reserved_memblk - Add one numa_memblk to numa_reserved_meminfo
+ * @nid: NUMA node ID of the new memblk
+ * @start: Start address of the new memblk
+ * @end: End address of the new memblk
+ *
+ * Add a new memblk to the numa_reserved_meminfo.
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int __init numa_add_reserved_memblk(int nid, u64 start, u64 end)
+{
+	return numa_add_memblk_to(nid, start, end, &numa_reserved_meminfo);
+}
+
 /**
  * numa_cleanup_meminfo - Cleanup a numa_meminfo
  * @mi: numa_meminfo to clean up
-- 
2.34.1


