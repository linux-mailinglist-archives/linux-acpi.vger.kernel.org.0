Return-Path: <linux-acpi+bounces-19751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21970CD55D4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 10:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1EF0301671F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39747311C35;
	Mon, 22 Dec 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qMIOdepy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEA30DEDD;
	Mon, 22 Dec 2025 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396655; cv=none; b=u4JBCQi7mePgCRISWJUSS2N9ljrLTdk3Z3Symx1je6Kmf3I6ew81fwmVLWoW3uniFrdS54iPgMDNwaDg0Q2bsIe/94yoy/C2f+am14fAVYtV5OIzZmcTG/mIOW9a1hNaeUxgCq4wi7j2fOOtusgrrd+9rmW9HSI6XTHC0Wt6zEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396655; c=relaxed/simple;
	bh=eAZzCI5nkOPouHu8166myOihyvraqZfihihrLhdM7tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hgKt5L3xZZPekZdRf2pDT4UaRYDZdMIWcWu+B8zhyvLgNdcGpqYgRI8xsKaKW16CC9cGvQD/FgA8Njw/liKHQq6MUSQptMv8MjwM/8hd1Od4lZ7+RwRXrvnMTmilnZdTntaWR5JTxJoW0LqcZKZh26DQvIpCmA6qYfqphmwCRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qMIOdepy; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766396648; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4DCUNTo5xh9M5poTUAlPWmJCzg4ftKAmvhtmbMlI8n4=;
	b=qMIOdepyv/8nHqdk+EFBFITv27vO4Eyr5z7DY9sEogUIX7uifQI51ixKIOfzVdjOSFl9cg4lzwGczPcF+PZTW1UzPxDfg1wuxYTDMo6yO0ox7puQtuidj3rwJZCOvyte4bhOECFNWvsawZ7+/TwpCU/Wzv+A5+jx9pjgqK3oLno=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WvOU8Rx_1766396646 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 17:44:08 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	lpieralisi@kernel.org,
	guohanjun@huawei.com,
	sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	lenb@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	yazen.ghannam@amd.com,
	misono.tomohiro@fujitsu.com
Cc: tianruidong@linux.alibaba.com
Subject: [PATCH v4 03/17] ras: AEST: support different group format
Date: Mon, 22 Dec 2025 17:43:36 +0800
Message-Id: <20251222094351.38792-4-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
References: <20251222094351.38792-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for various AEST group formats allows for flexible configuration of
AEST node address space sizes and maximum record counts per group.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/aest/aest-core.c |  6 ++++--
 drivers/ras/aest/aest.h      | 39 +++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/ras/aest/aest-core.c b/drivers/ras/aest/aest-core.c
index c7ef6c13fd44..acebb293ac75 100644
--- a/drivers/ras/aest/aest-core.c
+++ b/drivers/ras/aest/aest-core.c
@@ -84,7 +84,7 @@ static int aest_node_set_errgsr(struct aest_device *adev,
 		return 0;
 
 	if (!(anode->interface_hdr->flags & AEST_XFACE_FLAG_ERROR_GROUP)) {
-		node->errgsr = node->base + ERXGROUP;
+		node->errgsr = node->base + node->group->errgsr_offset;
 		return 0;
 	}
 
@@ -112,10 +112,12 @@ static int aest_init_node(struct aest_device *adev, struct aest_node *node,
 		return -ENOMEM;
 	node->record_implemented = anode->record_implemented;
 	node->status_reporting = anode->status_reporting;
+	node->group = &aest_group_config[anode->interface_hdr->group_format];
 
 	address = anode->interface_hdr->address;
 	if (address) {
-		node->base = devm_ioremap(adev->dev, address, PAGE_SIZE);
+		node->base =
+			devm_ioremap(adev->dev, address, node->group->size);
 		if (!node->base)
 			return -ENOMEM;
 	}
diff --git a/drivers/ras/aest/aest.h b/drivers/ras/aest/aest.h
index d918240c3f57..3250675e99b7 100644
--- a/drivers/ras/aest/aest.h
+++ b/drivers/ras/aest/aest.h
@@ -37,7 +37,15 @@
 	dev_dbg((__record)->node->adev->dev, "%s: %s: " format, \
 		(__record)->node->name, (__record)->name, ##__VA_ARGS__)
 
-#define ERXGROUP 0xE00
+#define ERXGROUP_4K_OFFSET 0xE00
+#define ERXGROUP_16K_OFFSET 0x3800
+#define ERXGROUP_64K_OFFSET 0xE000
+#define ERXGROUP_4K_SIZE (4 * KB)
+#define ERXGROUP_16K_SIZE (16 * KB)
+#define ERXGROUP_64K_SIZE (64 * KB)
+#define ERXGROUP_4K_ERRGSR_NUM 1
+#define ERXGROUP_16K_ERRGSR_NUM 4
+#define ERXGROUP_64K_ERRGSR_NUM 14
 
 struct aest_record {
 	char *name;
@@ -57,6 +65,34 @@ struct aest_record {
 	struct aest_node *node;
 };
 
+struct aest_group {
+	int type;
+	int errgsr_num;
+	size_t size;
+	u64 errgsr_offset;
+};
+
+static const struct aest_group aest_group_config[] = {
+	[ACPI_AEST_NODE_GROUP_FORMAT_4K] = {
+		.type = ACPI_AEST_NODE_GROUP_FORMAT_4K,
+		.errgsr_num = ERXGROUP_4K_ERRGSR_NUM,
+		.size = ERXGROUP_4K_SIZE,
+		.errgsr_offset = ERXGROUP_4K_OFFSET,
+	},
+	[ACPI_AEST_NODE_GROUP_FORMAT_16K] = {
+		.type = ACPI_AEST_NODE_GROUP_FORMAT_16K,
+		.errgsr_num = ERXGROUP_16K_ERRGSR_NUM,
+		.size = ERXGROUP_16K_SIZE,
+		.errgsr_offset = ERXGROUP_16K_OFFSET,
+	},
+	[ACPI_AEST_NODE_GROUP_FORMAT_64K] = {
+		.type = ACPI_AEST_NODE_GROUP_FORMAT_64K,
+		.errgsr_num = ERXGROUP_64K_ERRGSR_NUM,
+		.size = ERXGROUP_64K_SIZE,
+		.errgsr_offset = ERXGROUP_64K_OFFSET,
+	},
+};
+
 struct aest_node {
 	char *name;
 	u8 type;
@@ -86,6 +122,7 @@ struct aest_node {
 	 */
 	unsigned long *status_reporting;
 
+	const struct aest_group *group;
 	struct aest_device *adev;
 	struct acpi_aest_node *info;
 
-- 
2.51.2.612.gdc70283dfc


