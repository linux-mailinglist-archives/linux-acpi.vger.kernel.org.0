Return-Path: <linux-acpi+bounces-12392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7837A6B30A
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E0B3A6238
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Mar 2025 02:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA461E5713;
	Fri, 21 Mar 2025 02:37:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC08208A7;
	Fri, 21 Mar 2025 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742524639; cv=none; b=bGGtqtH97LAZDBzY6/MrP7wdE+zFmjEyOznC2xLt6/kGv+iWAd80vKgABIVatritHWqb75DIsV2z49OUeko69l9UFZYQNgp+gb2SJ6i+dZGy5aTC3ZgyhKxrCMclp6Y9HOjOvmx5h0mkfbGpvY5F+94gOjs92/wnESsLeZTwllI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742524639; c=relaxed/simple;
	bh=gNa9WH3CbpnyjD0jwvZJ/5xvl2hPG86rsEve7RWuBlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKdJ5qnBeXizf4JKaI/YBYYOATZfaHS8dj64d8tlGpeXuP/3YgUVk99HTEJ/b4X7bYaI3moq99EREbVU0bYAuo8MiYo1yAjnzEOZdFIedyyLAtoXvH3L+Lto4h3meTLS2WDZdREz2wzpzvO2sI9eeSgdCyQpsoKpTUUVfKnkcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAnLa3R0NxnLZ27Cw--.15429S2;
	Fri, 21 Mar 2025 10:37:05 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwB3fIii0NxnWXpPAA--.1469S5;
	Fri, 21 Mar 2025 10:36:57 +0800 (CST)
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
Subject: [RFC PATCH v3 2/2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Date: Fri, 21 Mar 2025 10:36:02 +0800
Message-Id: <20250321023602.2609614-3-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
References: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwB3fIii0NxnWXpPAA--.1469S5
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWfcdA4BvAAAss
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kry7JrWxXFW5Zw43ZrWfAFb_yoW5JFWxpF
	WIkF95JryxGrWxCa4Ivr4jv34fC3WxCFZ8KF9rCry3ZanxWry3Zr47JF9IvFyjy3y8ur10
	vr4vvF15ua48ZFDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

The absence of SRAT would cause the fake_pxm to be -1 and increment
to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
ranges that are defined in the CFMWS and not already defined in the
SRAT, the new node (node0) for the CXL memory would be invalid, as
node0 is already in "used", and all CXL memory might be online on
node0.

This utilizes node_set(0, nodes_found_map) to set pxm&node map. With
this setting, acpi_map_pxm_to_node() could return the expected node
value even if no SRAT.

If SRAT is valid, the numa_memblks_init() would then utilize
numa_move_tail_memblk() to move the numa_memblk from numa_meminfo to
numa_reserved_meminfo in CFMWs fake node situation.

If SRAT is missing or bad, the numa_memblks_init() would fail since
init_func() would fail. And it causes that no numa_memblk in
numa_reserved_meminfo list and the following dax_cxl driver could
find the expected fake node.

Use numa_add_reserved_memblk() to replace numa_add_memblk(), since
the cxl numa_memblk added by numa_add_memblk() would finally be moved
to numa_reserved_meminfo, and numa_add_reserved_memblk() here could
add cxl numa_memblk into reserved list directly. Hence, no matter
SRAT is good or not, cxl numa_memblk could be allocated to reserved
list.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 drivers/acpi/numa/srat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 00ac0d7bb8c9..50bfecfb9c16 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -458,11 +458,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 		return -EINVAL;
 	}
 
-	if (numa_add_memblk(node, start, end) < 0) {
+	if (numa_add_reserved_memblk(node, start, end) < 0) {
 		/* CXL driver must handle the NUMA_NO_NODE case */
 		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
 			node, start, end);
 	}
+
 	node_set(node, numa_nodes_parsed);
 
 	/* Set the next available fake_pxm value */
@@ -646,8 +647,12 @@ int __init acpi_numa_init(void)
 		if (node_to_pxm_map[i] > fake_pxm)
 			fake_pxm = node_to_pxm_map[i];
 	}
-	last_real_pxm = fake_pxm;
-	fake_pxm++;
+
+	/* Make sure CFMWs fake node >= 1 */
+	fake_pxm = max(fake_pxm, 0);
+	last_real_pxm = fake_pxm++;
+	node_set(0, nodes_found_map);
+
 	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
 			      &fake_pxm);
 
-- 
2.34.1


