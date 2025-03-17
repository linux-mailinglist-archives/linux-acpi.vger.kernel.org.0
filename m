Return-Path: <linux-acpi+bounces-12289-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DDCA6494D
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 11:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C370A3A477A
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Mar 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D5B2376E1;
	Mon, 17 Mar 2025 10:16:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A8221D8B;
	Mon, 17 Mar 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206578; cv=none; b=LhHME/Dd9/0DigdIFfGCToZmY8nuvvQnlWcpWY9iOlTYPM3g/uEMVDuX13NXjNxsy93/HJxodX2D3b/T6OjZrlQ2LCH5pFx0WNqZa7d1Q/u51fBlWXQqgiYStrUg63DTc1c/eybd07Zyd8mRRztZn5OHKNEpd7q2eDE2YGUIYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206578; c=relaxed/simple;
	bh=cOHiCkZ0kCvx9YP1VgRKpKS6XVggYgoU3Q211q7VYGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RyexEIA2ivQ9ZuCLDPFo2WUQ0sib1eBVKKaIl22kiM56o0X7CvDzVDopGQsvDNXba6TnzeFEYutaIZGUgC+/46dpBEQkjHKdb7l6aMc2KhP46DzhhYgCmsiIwLJcmkbSSv7MGCS79mqdBd1/xc4iB6DIJEAk0bWmWjePecUR3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3fGRf9tdn4HrGCg--.46665S2;
	Mon, 17 Mar 2025 18:15:59 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwDX2oZU9tdncdJLAA--.4190S3;
	Mon, 17 Mar 2025 18:15:49 +0800 (CST)
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
Subject: [PATCH v3 0/2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Date: Mon, 17 Mar 2025 18:15:31 +0800
Message-Id: <20250317101533.2582624-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDX2oZU9tdncdJLAA--.4190S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAJAWfTOa4IJAAPsJ
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCrWDCw13uryxWF15tw48Crg_yoW5WF15pF
	W3KFnxXFyxGr1xGw4fZr18t34ak3W8AFWDWFnrWrn3Zrs8Cry7Zr4UJF4fZFyUtrWUCr18
	Jr45Zrn8uw1jyaUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Changes in v3:
- Introduce numa_add_reserved_memblk()
- Use more explicit way to make sure CFMWs fake node >= 1 
- Replace numa_add_memblk() with numa_add_reserved_memblk() in acpi_parse_cfmws()

Problem
-------
The absence of SRAT would cause the fake_pxm to be -1 and increment
to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
ranges that are defined in the CFMWS and not already defined in the
SRAT, the new node (node0) for the CXL memory would be invalid, as
node0 is already in "used", and all CXL memory might be online on
node0.

Control cxl fake node value
---------------------------
This utilizes node_set(0, nodes_found_map) to set pxm&node map. With
this setting, acpi_map_pxm_to_node() could return the expected node
value even if no SRAT.

numa_add_memblk() problem on this issue
---------------------------------------
If SRAT is valid, the numa_memblks_init() would then utilize
numa_move_tail_memblk() to move the numa_memblk from numa_meminfo to
numa_reserved_meminfo in CFMWs fake node situation.

If SRAT is missing or bad, the numa_memblks_init() would fail since
init_func() would fail. And it causes that no numa_memblk in
numa_reserved_meminfo list and the following dax_cxl driver could
find the expected fake node.

numa_add_reserved_memblk()
--------------------------
Use numa_add_reserved_memblk() to replace numa_add_memblk(), since
the cxl numa_memblk added by numa_add_memblk() would finally be moved
to numa_reserved_meminfo, and numa_add_reserved_memblk() here could
add cxl numa_memblk into reserved list directly. Hence, no matter
SRAT is good or not, cxl numa_memblk could be allocated to reserved
list.

dax_kmem problem
----------------
The dax_kmem driver will fail if no SRAT because something wrong in
memory_group_register_static(). The good result is our cxl memory would
not be assigned to node0 anymore!

Discussion
----------
As papering these things looks like not easily, in v2 patch[1] I chose
to aggressively fail the acpi_parse_cfmws() in srat.c since it mainly
works for building cxl fake nodes and also fail the CXL init in
cxl_acpi_probe per the discussion from Jonathan[2]. Actually, I am not
sure if this(v3) is the best way to handle this issue, so hopes more
comments to guide me!

Link:
[1] https://lore.kernel.org/linux-cxl/Z9RfnXQlr9G1qz00@aschofie-mobl2.lan/T/#t
[2] https://lists.nongnu.org/archive/html/qemu-devel/2025-03/msg03668.html


Yuquan Wang (2):
  mm: numa_memblks: introduce numa_add_reserved_memblk
  ACPI: NUMA: debug invalid unused PXM value for CFMWs

 drivers/acpi/numa/srat.c     | 11 ++++++++---
 include/linux/numa_memblks.h |  1 +
 mm/numa_memblks.c            | 16 ++++++++++++++++
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.34.1


