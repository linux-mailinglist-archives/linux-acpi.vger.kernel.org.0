Return-Path: <linux-acpi+bounces-8466-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8519886F6
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5936A28137A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55228149C6D;
	Fri, 27 Sep 2024 14:21:31 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD75136663;
	Fri, 27 Sep 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446891; cv=none; b=FJm8eX+JkFEFo2BNl2kPqLfNd8cFgPZW6CcJXm3TcnWuvSmS6o3bNBlSCzEUt+TOjLQVr5fm+rfZX4abze+gYVyvMxAWARiGJHvgosjgGvu2FQfL22vdJGLeTjPEtnx+zHtI2fml0J9BQztDSFEpEjLQW49ew+vwYBbRAI/3PWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446891; c=relaxed/simple;
	bh=+wJblkzFJhX4Kh4BgSUg6zKsdPlDfLrf6cLrqJxyKvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIvHlzqJd6hydOy6UxyawdQaw9KBPmlgiczwmfO/KhLUmTo4kzLnbUNaRUe1w1tMzZmFNxREqCYhpgGNYD2e5M+E56CvamW93kwiU/JdmFMDeMZq8YSl9ezFBfTnTgl+oEggcV2oFoKRd1H/8vYiqkNKs5nFSWXfkVEpO3qBLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67C3C4CECE;
	Fri, 27 Sep 2024 14:21:30 +0000 (UTC)
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
Subject: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide extended linear cache translation
Date: Fri, 27 Sep 2024 07:16:56 -0700
Message-ID: <20240927142108.1156362-5-dave.jiang@intel.com>
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

Add helper functions to help do address translation for either the address
of the extended linear cache or its alias address. The translation function
attempt to detect an I/O hole in the proximity domain and adjusts the address
if the hole impacts the aliasing of the address. The range of the I/O hole
is retrieved by walking through the associated memory target resources.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c | 136 +++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  14 ++++
 2 files changed, 150 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index d299f8d7af8c..834314582f4c 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -152,6 +152,142 @@ int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
 }
 EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
 
+static int alias_address_find_iohole(struct memory_target *target,
+				     u64 address, u64 alias, struct range *hole)
+{
+	struct resource *alias_res = NULL;
+	struct resource *res, *prev;
+
+	*hole = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+
+	/* First find the resource that the address is in */
+	prev = target->memregions.child;
+	for (res = target->memregions.child; res; res = res->sibling) {
+		if (alias >= res->start && alias <= res->end) {
+			alias_res = res;
+			break;
+		}
+		prev = res;
+	}
+	if (!alias_res)
+		return -EINVAL;
+
+	/* No memory hole */
+	if (alias_res == prev)
+		return 0;
+
+	/* If address is within the current resource, no need to deal with memory hole */
+	if (address >= alias_res->start)
+		return 0;
+
+	*hole = (struct range) {
+		.start = prev->end + 1,
+		.end = alias_res->start - 1,
+	};
+
+	return 0;
+}
+
+int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid)
+{
+	unsigned int pxm = node_to_pxm(nid);
+	struct memory_target *target;
+	struct range iohole;
+	int rc;
+
+	target = find_mem_target(pxm);
+	if (!target)
+		return -EINVAL;
+
+	rc = alias_address_find_iohole(target, address, *alias, &iohole);
+	if (rc)
+		return rc;
+
+	if (!range_len(&iohole))
+		return 0;
+
+	if (address < iohole.start) {
+		if (*alias > iohole.start) {
+			*alias = *alias + range_len(&iohole);
+			return 0;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_alias_xlat, CXL);
+
+static int target_address_find_iohole(struct memory_target *target,
+				      u64 address, u64 alias,
+				      struct range *hole)
+{
+	struct resource *addr_res = NULL;
+	struct resource *res, *next;
+
+	*hole = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+
+	/* First find the resource that the address is in */
+	for (res = target->memregions.child; res; res = res->sibling) {
+		if (address >= res->start && address <= res->end) {
+			addr_res = res;
+			break;
+		}
+	}
+	if (!addr_res)
+		return -EINVAL;
+
+	next = res->sibling;
+	/* No memory hole after the region */
+	if (!next)
+		return 0;
+
+	/* If alias is within the current resource, no need to deal with memory hole */
+	if (alias <= addr_res->end)
+		return 0;
+
+	*hole = (struct range) {
+		.start = addr_res->end + 1,
+		.end = next->start - 1,
+	};
+
+	return 0;
+}
+
+int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid)
+{
+	unsigned int pxm = node_to_pxm(nid);
+	struct memory_target *target;
+	struct range iohole;
+	int rc;
+
+	target = find_mem_target(pxm);
+	if (!target)
+		return -EINVAL;
+
+	rc = target_address_find_iohole(target, *address, alias, &iohole);
+	if (rc)
+		return rc;
+
+	if (!range_len(&iohole))
+		return 0;
+
+	if (alias > iohole.end) {
+		if (*address < iohole.end) {
+			*address = *address - range_len(&iohole);
+			return 0;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_address_xlat, CXL);
+
 static struct memory_target *acpi_find_genport_target(u32 uid)
 {
 	struct memory_target *target;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8ed72d431dca..704bdfc79f85 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -437,6 +437,8 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
 int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
 					resource_size_t *size);
+int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid);
+int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid);
 #else
 static inline int acpi_get_genport_coordinates(u32 uid,
 					       struct access_coordinate *coord)
@@ -449,6 +451,18 @@ static inline int hmat_get_extended_linear_cache_size(struct resource *backing_r
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int hmat_extended_linear_cache_alias_xlat(u64 address,
+							u64 *alias, int nid)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int hmat_extended_linear_cache_address_xlat(u64 *address,
+							  u64 alias, int nid)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_ACPI_NUMA
-- 
2.46.1


