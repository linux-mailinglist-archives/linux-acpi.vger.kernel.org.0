Return-Path: <linux-acpi+bounces-11406-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E853EA42B26
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 19:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8C93B8710
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2025 18:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D726619B;
	Mon, 24 Feb 2025 18:22:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9212D198A38;
	Mon, 24 Feb 2025 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421326; cv=none; b=gFzpXi2+cg3XKAJxZGmYBMDCPz+cIrlO63DzA6a/cpJABkQYkDAfV5HDwIBr301GcCN56HbxGxxizYMpyxq+mA+ENkTr79asfXn8a1utejti8b25bMg+iPcvOUMtGCNotDBEzNF1A7JZArfqrpsP0y2fCysC7zv43L9AzAvsJok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421326; c=relaxed/simple;
	bh=aEY/bN9x1tOMQoJp8nQDIFA13q6MSZ4/WJigrP88MIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cL1LVukM9kKL4At74TFdVkvpXXirBgM6VM2/3oplWxH5Ojj9+neBW0NzZSeTsWegey3QTGjpacLE5tAkGlsiY7VMYDJtSakSBrUdsT52GmnN+bo5WbXSDXIJu9korIvhvekAWSgbaYjQgHkh9b1Ktg2R/ISDw6mvB9NRLVYZBEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0405C4CED6;
	Mon, 24 Feb 2025 18:22:05 +0000 (UTC)
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
Subject: [PATCH v4 1/4] acpi: numa: Add support to enumerate and store extended linear address mode
Date: Mon, 24 Feb 2025 11:20:59 -0700
Message-ID: <20250224182202.1683380-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224182202.1683380-1-dave.jiang@intel.com>
References: <20250224182202.1683380-1-dave.jiang@intel.com>
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
index 402af4b2b905..a02707cb7cbc 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -177,6 +177,12 @@ Description:
 		The cache write policy: 0 for write-back, 1 for write-through,
 		other or unknown.
 
+What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/address_mode
+Date:		March 2025
+Contact:	Dave Jiang <dave.jiang@intel.com>
+Description:
+		The address mode: 0 for reserved, 1 for extended-linear.
+
 What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
 Date:		November 2021
 Contact:	Jarkko Sakkinen <jarkko@kernel.org>
diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index bfbb08b1e6af..2630511937f5 100644
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
2.48.1


