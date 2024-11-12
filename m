Return-Path: <linux-acpi+bounces-9517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A449C6419
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 23:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A20284F3E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778DF21A6FD;
	Tue, 12 Nov 2024 22:13:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A21FEFD9;
	Tue, 12 Nov 2024 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731449622; cv=none; b=RrlYQqp7IaNNN/JDg9+TQb1mIelWLpnSOmTZqWg06n1r9xq3YCFYUEs/3rOjPaaikVAHFoYOZEkipG/yHxfwTEhcgejPck9ft7j/WXynjDzr2Xh+FscHQmjpMIGIdjcwSALF931cCCrc0x+tY+zgd5w/8UtFZYPr5/BU0VUif8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731449622; c=relaxed/simple;
	bh=VssElxjnE2tuG4N9D3B/eRoL6mKBI/zskcx26r9cgwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxRUWJEyekcrHL/XWrxLwGNMBdYQF3G5jmBztCv7lxfEm2qS6bozHV1u2Q3ISUAL01Q9R7dEnnioj3+5B3EHKHV39nX4/FR7LpBYc8X8CViSwTsr9IZy7knks/+nHPEGlugYataPCfwY9q4gOHPo4dcYnN+IlgSD02Q0fq5CDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE527C4CECD;
	Tue, 12 Nov 2024 22:13:41 +0000 (UTC)
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
Subject: [RFC PATCH v2 3/5] acpi/hmat: Add helper functions to provide extended linear cache translation
Date: Tue, 12 Nov 2024 15:12:35 -0700
Message-ID: <20241112221335.432583-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112221335.432583-1-dave.jiang@intel.com>
References: <20241112221335.432583-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper functions to help do address translation for either the address
of the extended linear cache or its alias address. The translation function
attempt to detect an I/O hole in the proximity domain and adjusts the
address if the hole impacts the aliasing of the address. The range of the
I/O hole is retrieved by walking through the associated memory target
resources.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Drop extra variable and use 'res' from the loop. (Jonathan)
- Break up multiple if statements into single blocks and add comments. (Jonathan)
---
 drivers/acpi/numa/hmat.c | 148 +++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  14 ++++
 2 files changed, 162 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 92b818b72ecc..6c686d3c7266 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -152,6 +152,154 @@ int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
 }
 EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
 
+static int alias_address_find_iohole(struct memory_target *target,
+				     u64 address, u64 alias, struct range *hole)
+{
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
+		if (alias >= res->start && alias <= res->end)
+			break;
+		prev = res;
+	}
+	if (!res)
+		return -EINVAL;
+
+	/* No memory hole */
+	if (res == prev)
+		return 0;
+
+	/* If address is within the current resource, no need to deal with memory hole */
+	if (address >= res->start)
+		return 0;
+
+	*hole = (struct range) {
+		.start = prev->end + 1,
+		.end = res->start - 1,
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
+	/*
+	 * If the cache start (address) is behind the MMIO I/O hole then there
+	 * is no change to the passed in CXL address (alias).
+	 */
+	if (address >= iohole.start)
+		return 0;
+
+	/*
+	 * If the aliased CXL address is before the MMIO I/O hole start then
+	 * CXL address (alias) is also not impacted.
+	 */
+	if (*alias <= iohole.start)
+		return 0;
+
+	*alias += range_len(&iohole);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_alias_xlat, CXL);
+
+static int target_address_find_iohole(struct memory_target *target,
+				      u64 address, u64 alias,
+				      struct range *hole)
+{
+	struct resource *res, *next;
+
+	*hole = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+
+	/* First find the resource that the address is in */
+	for (res = target->memregions.child; res; res = res->sibling) {
+		if (address >= res->start && address <= res->end)
+			break;
+	}
+	if (!res)
+		return -EINVAL;
+
+	next = res->sibling;
+	/* No memory hole after the region */
+	if (!next)
+		return 0;
+
+	/* If alias is within the current resource, no need to deal with memory hole */
+	if (alias <= res->end)
+		return 0;
+
+	*hole = (struct range) {
+		.start = res->end + 1,
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
+	 /*
+	  * If the CXL address is before the MMIO hole then there is no change
+	  * to the passed in cache address.
+	  */
+	if (alias <= iohole.end)
+		return 0;
+
+	/*
+	 * If the calculated cache address is after the MMIO hole then there
+	 * is no change to the passed in cache address.
+	 */
+	if (*address >= iohole.end)
+		return 0;
+
+	*address -= range_len(&iohole);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_address_xlat, CXL);
+
 static struct memory_target *acpi_find_genport_target(u32 uid)
 {
 	struct memory_target *target;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 10ffba7cb9ad..18a94d382d40 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -438,6 +438,8 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
 int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
 int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
 					resource_size_t *size);
+int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid);
+int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid);
 #else
 static inline int acpi_get_genport_coordinates(u32 uid,
 					       struct access_coordinate *coord)
@@ -450,6 +452,18 @@ static inline int hmat_get_extended_linear_cache_size(struct resource *backing_r
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
2.47.0


