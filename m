Return-Path: <linux-acpi+bounces-12878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7890AA81BBC
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 06:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB217B1C9B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 04:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C514F117;
	Wed,  9 Apr 2025 04:02:45 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C4D3D76;
	Wed,  9 Apr 2025 04:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744171365; cv=none; b=Ldn17isHl+CxKhiUYlH4u6TvMybqAYmINAa6mfgdt3hUhFAbGJOwEPIiRlYA3C5bcn2PtAk7O7ZQxim9TKvKHnEjfpMY4VpCK+JrpmUziZNSkbCLUxnXCXP7+uenREf2yO+4nxEdfIngH9dF4QkYb99GuuWSHSIu3Dyb/V/HauQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744171365; c=relaxed/simple;
	bh=ltVOTq6OdODO4CeVRkToE7me66wnLAqvC9n9gxVv1iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pqjsK7epY04eD1WMIG7iP5Ni7RJ8R/32eNgqggxBClwEfelUpIisc7/ge5DLafORgkRmsAqdZqwQbNP5J7393Ox3dAv4Ul+amPRx6qrDVgEbFrFQWG4Ku40JAxRqqq4ATw8jUtMJQZx5qYEnIyfp92KpDB3UPpcBkL6i9J4quqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn76c08fVnBtCwEw--.12678S2;
	Wed, 09 Apr 2025 12:01:56 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwBHSoYw8fVnOyxkAA--.72S3;
	Wed, 09 Apr 2025 12:01:53 +0800 (CST)
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
Cc: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	chenbaozi@phytium.com.cn,
	loongarch@lists.linux.dev,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Date: Wed,  9 Apr 2025 12:01:21 +0800
Message-Id: <20250409040121.3212489-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwBHSoYw8fVnOyxkAA--.72S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAOAWf0L0IFaAAfsC
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFW7Ar4xuF4DCr48Xr47Jwb_yoW5Zw4rpa
	yUG3Z8XF4xGw1xGw1xuryj9w1S93WrKr1DJFZrGr13ZF4rWry2vr4UtFsxZr1DtrW7ur1r
	Wr4vyw15uw1rAFUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
with the expectation that numa_cleanup_meminfo moves them to
numa_reserved_meminfo. There is no need for that indirection when it is
known in advance that these unpopulated ranges are meant for
numa_reserved_meminfo in support of future hotplug / CXL provisioning.

Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
ranges directly.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---

Changes in v2 (Thanks to Dan & Alison):
- Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
- Add comments to describe the usage of numa_add_reserved_memblk()
- Updating the commit message to clarify the purpose of the patch

 drivers/acpi/numa/srat.c     |  2 +-
 include/linux/numa_memblks.h |  1 +
 mm/numa_memblks.c            | 22 ++++++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 0a725e46d017..751774f0b4e5 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -453,7 +453,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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


