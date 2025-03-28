Return-Path: <linux-acpi+bounces-12521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF911A74642
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 10:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ACD1B60CCA
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B532116ED;
	Fri, 28 Mar 2025 09:22:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264221149C;
	Fri, 28 Mar 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153736; cv=none; b=uOqPaaVYDG+0Oy4fkLAQy9AQB6Q1UAzqtroiJ0db6zuOIBzPiMoGRUj9qnO2sVxBpImV/ZHUq9RkR0oBYK94y2ESnVb/gk+v+MH/f689EBZvHpmmIi33uycCunx/u+yljQJK2fXIu/XjQauT1YNW7hPZ3FPVocZf4XuQiVL/nto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153736; c=relaxed/simple;
	bh=o0bgkl2VtmX892uUzGSAN8EBLvxFiy9rSZNcjph0/Io=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4g0BI318oRF2z1bwWiOXChW/XlBwMk1fKVwXn7P91YB2emTtlVC3CfYTvLhb/ujH7DHlUDP72OhhPxYQosrRaXyXLYsKB5kALBmBvyRCXfG3leQ39niaUMa7CC1kp3l7KLHh5LH9+0dfg2yREgJsJfyVYcVb2Q0cPUJXzyUI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwC3Rsk0auZnbk4hDw--.1979S2;
	Fri, 28 Mar 2025 17:21:56 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwB3e4cuauZn2txYAA--.2899S3;
	Fri, 28 Mar 2025 17:21:52 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rppt@kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	akpm@linux-foundation.org,
	alison.schofield@intel.com,
	rrichter@amd.com,
	bfaccini@nvidia.com,
	haibo1.xu@intel.com,
	david@redhat.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	chenbaozi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Date: Fri, 28 Mar 2025 17:21:32 +0800
Message-Id: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwB3e4cuauZn2txYAA--.2899S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWflrrMJuQABst
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCFyxZFyUXrW7Jw1xCFyUWrg_yoW5Zw18pa
	yUG3Z8XayxGr1xGw1xuryj9w1S93Z5KF1DGFZrGr43ZF4rWry2vr4jyFnxZr1DtrW7ur1r
	Wr4vy3W5uw1rAFUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

With numa_add_reserved_memblk(), kernel could add numa_memblk into
numa_reserved_meminfo directly.

acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
with the expectation that numa_cleanup_meminfo moves them to
numa_reserved_meminfo. There is no need for that indirection when it is
known in advance that these unpopulated ranges are meant for
numa_reserved_meminfo in suppot of future hotplug / CXL provisioning.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---

Changes in v2 (Thanks to Dan):
- Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
- Add comments to describe the usage of numa_add_reserved_memblk()
- Provide a more explicit commit message

 drivers/acpi/numa/srat.c     |  2 +-
 include/linux/numa_memblks.h |  1 +
 mm/numa_memblks.c            | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 00ac0d7bb8c9..70f1a7c6b54a 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -458,7 +458,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 		return -EINVAL;
 	}
 
-	if (numa_add_memblk(node, start, end) < 0) {
+	if (numa_add_reserved_memblk(node, start, end) < 0) {
 		/* CXL driver must handle the NUMA_NO_NODE case */
 		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
 			node, start, end);
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
index ff4054f4334d..541a99c4071a 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -200,6 +200,28 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
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
+ * Usage Case: numa_cleanup_meminfo() reconciles all numa_memblk instances
+ * against memblock_type information and moves any that intersect reserved
+ * ranges to numa_reserved_meminfo. However, when that information is known
+ * ahead of time, we use numa_add_reserved_memblk() to add the numa_memblk
+ * to numa_reserved_meminfo directly.
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


