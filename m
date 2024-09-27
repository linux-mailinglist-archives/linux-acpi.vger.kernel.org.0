Return-Path: <linux-acpi+bounces-8464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA6F9886F4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5828F1F225F7
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F313E41D;
	Fri, 27 Sep 2024 14:21:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB8413BAE2;
	Fri, 27 Sep 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446888; cv=none; b=PxaHX2ztwMeQdO2X9hmh16MgyIq249Uq9if7Py7fEjj0yFtIM8kNY77o47n91JINwws4u3XI/yxElb0JpExU2S7/SMJfA/4Qix0bHu3EBO9FvDLZqhi1BmrVFVdG/BBuufQjrWjLF3daSoDlssZ2orTq/xeeuDNKzpTIsfr+4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446888; c=relaxed/simple;
	bh=M5wmaOSVmFqYER+AYdFD/zdHq9k63cGay2sdlIqNpQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgEf7t5i3cOxuJDE9Tij/U5SNAO8TOGNv4neoZklgd0Ebpww/uBZF4YdDJqok5QXyhvmhqRvfKyrKHj/KEja2uhPV41x9LI5TxOtd7XMAWE9Va11IePToKBV9ro/ua8O7L1rLy3F/cPgQZWiGcUu5SB/uERJGxmQ0zok+RYsOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A84F8C4CEC6;
	Fri, 27 Sep 2024 14:21:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: rafael@kernel.org,
	bp@alien8.de,
	dan.j.williams@intel.com,
	tony.luck@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: [RFC PATCH 2/6] acpi: numa: Add support to enumerate and store extended linear address mode
Date: Fri, 27 Sep 2024 07:16:54 -0700
Message-ID: <20240927142108.1156362-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927142108.1156362-1-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the address mode as part of the cache attriutes. Export the mode
attribute to sysfs as all other cache attributes.

Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 7 +++++++
 drivers/acpi/numa/hmat.c                    | 3 +++
 drivers/base/node.c                         | 2 ++
 include/linux/node.h                        | 7 +++++++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 402af4b2b905..9016cc4f027c 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -177,6 +177,13 @@ Description:
 		The cache write policy: 0 for write-back, 1 for write-through,
 		other or unknown.
 
+What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/mode
+Date:		September 2024
+Contact:	Dave Jiang <dave.jiang@intel.com>
+Description:
+		The address mode: 0 for reserved, 1 for extended-lniear,
+		other unknown.
+
 What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
 Date:		November 2021
 Contact:	Jarkko Sakkinen <jarkko@kernel.org>
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 1a902a02390f..39524f36be5b 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -506,6 +506,9 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
 	case ACPI_HMAT_CA_DIRECT_MAPPED:
 		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
+		/* Extended Linear mode is only valid if cache is direct mapped */
+		if (cache->address_mode == ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR)
+			tcache->cache_attrs.mode = NODE_CACHE_MODE_EXTENDED_LINEAR;
 		break;
 	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
 		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e6..744be5470728 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -244,12 +244,14 @@ CACHE_ATTR(size, "%llu")
 CACHE_ATTR(line_size, "%u")
 CACHE_ATTR(indexing, "%u")
 CACHE_ATTR(write_policy, "%u")
+CACHE_ATTR(mode, "%u")
 
 static struct attribute *cache_attrs[] = {
 	&dev_attr_indexing.attr,
 	&dev_attr_size.attr,
 	&dev_attr_line_size.attr,
 	&dev_attr_write_policy.attr,
+	&dev_attr_mode.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cache);
diff --git a/include/linux/node.h b/include/linux/node.h
index 9a881c2208b3..589951c5e36f 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -57,6 +57,11 @@ enum cache_write_policy {
 	NODE_CACHE_WRITE_OTHER,
 };
 
+enum cache_mode {
+	NODE_CACHE_MODE_UNKOWN,
+	NODE_CACHE_MODE_EXTENDED_LINEAR,
+};
+
 /**
  * struct node_cache_attrs - system memory caching attributes
  *
@@ -65,6 +70,7 @@ enum cache_write_policy {
  * @size:		Total size of cache in bytes
  * @line_size:		Number of bytes fetched on a cache miss
  * @level:		The cache hierarchy level
+ * @mode:		The address mode
  */
 struct node_cache_attrs {
 	enum cache_indexing indexing;
@@ -72,6 +78,7 @@ struct node_cache_attrs {
 	u64 size;
 	u16 line_size;
 	u8 level;
+	u16 mode;
 };
 
 #ifdef CONFIG_HMEM_REPORTING
-- 
2.46.1


