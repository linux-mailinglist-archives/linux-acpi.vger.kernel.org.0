Return-Path: <linux-acpi+bounces-10743-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59531A155C2
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C8167A1723
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Jan 2025 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9A819ADA4;
	Fri, 17 Jan 2025 17:30:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172D165F01;
	Fri, 17 Jan 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135058; cv=none; b=mIXvbm6KzOQiZwtOnnIfm/H39CBhJuy2YrZBajaFWVp9UVK3bQAwfkxsbkmMHejYqIMKEckqfGdPixrIUWoddIlHnpHNB4V6mjfhC/JsR6JWSl74pMDt5Sh3TD4jRbu5ekPDg73CiXy+/V79j59MFSuHU+WHVcuq5wB+DvolU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135058; c=relaxed/simple;
	bh=f9u0f2BGuQnH0+kJIG35UcJ7aiqXMH4lMKDGriYXfAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y+bo6haQVzFgFaq4ANlim7EUVCS95RJE/Iylh6uwy7Y769wFjvRp1gND0YUi0zcBMXBSktKu066KK6/l03txwDa6gb8/gczTBo0/fEU4mNG5fjhUZo4GXTO6aHkqgvSfcAdHmjrpOxNb5LBhVoxGGAIoNEyDiBZTbk8b3OslZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50080C4CEDD;
	Fri, 17 Jan 2025 17:30:58 +0000 (UTC)
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
	ira.weiny@intel.com,
	ming.li@zohomail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 1/4] acpi: numa: Add support to enumerate and store extended linear address mode
Date: Fri, 17 Jan 2025 10:28:30 -0700
Message-ID: <20250117173054.4147877-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117173054.4147877-1-dave.jiang@intel.com>
References: <20250117173054.4147877-1-dave.jiang@intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-node | 6 ++++++
 drivers/acpi/numa/hmat.c                    | 5 +++++
 drivers/base/node.c                         | 2 ++
 include/linux/node.h                        | 7 +++++++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 402af4b2b905..c46b910dfe00 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -177,6 +177,12 @@ Description:
 		The cache write policy: 0 for write-back, 1 for write-through,
 		other or unknown.
 
+What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/address_mode
+Date:		December 2024
+Contact:	Dave Jiang <dave.jiang@intel.com>
+Description:
+		The address mode: 0 for reserved, 1 for extended-linear.
+
 What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
 Date:		November 2021
 Contact:	Jarkko Sakkinen <jarkko@kernel.org>
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 80a3481c0470..a9172cf90002 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -506,6 +506,11 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
 	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
 	case ACPI_HMAT_CA_DIRECT_MAPPED:
 		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
+		/* Extended Linear mode is only valid if cache is direct mapped */
+		if (cache->address_mode == ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR) {
+			tcache->cache_attrs.address_mode =
+				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR;
+		}
 		break;
 	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
 		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ea653fa3433..cd13ef287011 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -244,12 +244,14 @@ CACHE_ATTR(size, "%llu")
 CACHE_ATTR(line_size, "%u")
 CACHE_ATTR(indexing, "%u")
 CACHE_ATTR(write_policy, "%u")
+CACHE_ATTR(address_mode, "%#x")
 
 static struct attribute *cache_attrs[] = {
 	&dev_attr_indexing.attr,
 	&dev_attr_size.attr,
 	&dev_attr_line_size.attr,
 	&dev_attr_write_policy.attr,
+	&dev_attr_address_mode.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(cache);
diff --git a/include/linux/node.h b/include/linux/node.h
index 9a881c2208b3..2b7517892230 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -57,6 +57,11 @@ enum cache_write_policy {
 	NODE_CACHE_WRITE_OTHER,
 };
 
+enum cache_mode {
+	NODE_CACHE_ADDR_MODE_RESERVED,
+	NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR,
+};
+
 /**
  * struct node_cache_attrs - system memory caching attributes
  *
@@ -65,6 +70,7 @@ enum cache_write_policy {
  * @size:		Total size of cache in bytes
  * @line_size:		Number of bytes fetched on a cache miss
  * @level:		The cache hierarchy level
+ * @address_mode:		The address mode
  */
 struct node_cache_attrs {
 	enum cache_indexing indexing;
@@ -72,6 +78,7 @@ struct node_cache_attrs {
 	u64 size;
 	u16 line_size;
 	u8 level;
+	u16 address_mode;
 };
 
 #ifdef CONFIG_HMEM_REPORTING
-- 
2.47.1


