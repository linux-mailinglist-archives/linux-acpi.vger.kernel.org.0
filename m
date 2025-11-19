Return-Path: <linux-acpi+bounces-19077-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB18C6E710
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 284A34ED7D2
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD76357A51;
	Wed, 19 Nov 2025 12:23:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553533C51A;
	Wed, 19 Nov 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555027; cv=none; b=HNnJ4ATYUZvGSmCnCjy5ehYd9VBcoC6D3TnhgGiTWgyvhKFyzSOdh344GLsuDcJsU2YQdaldkiq8eTKyM0Y0Cz/lUcOz9vRVxKStBJUl1s2+WMOyAE0Wqpbae6kysclMWY/Uh0y3M5Glp37RLXEd4Fbt8KprZkpEL7G0QjKtxMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555027; c=relaxed/simple;
	bh=Ov42eBE/KIeKih/Tl55pw9qJHbrpLyl3xXss/BK8bX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3rGH7aPZrIFTziYRMG2TlWeWuefeHSbjC5wTLwUz9+3CMUeHw7RuJ8fcjkwRsxes7VulO0+Y6M+4U7/C3umdiIueXg7a+FXbSaoBLDe8w23wiT2hbIdrSOzjsQ5mKLCqSSiDlPu+N61hwx5IkJj0SL0cW3aP08jjre+tn2tTBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6E21713;
	Wed, 19 Nov 2025 04:23:36 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 794B03F740;
	Wed, 19 Nov 2025 04:23:39 -0800 (PST)
From: Ben Horgan <ben.horgan@arm.com>
To: james.morse@arm.com
Cc: amitsinght@marvell.com,
	baisheng.gao@unisoc.com,
	baolin.wang@linux.alibaba.com,
	bobo.shaobowang@huawei.com,
	carl@os.amperecomputing.com,
	catalin.marinas@arm.com,
	dakr@kernel.org,
	dave.martin@arm.com,
	david@redhat.com,
	dfustini@baylibre.com,
	fenghuay@nvidia.com,
	gregkh@linuxfoundation.org,
	gshan@redhat.com,
	guohanjun@huawei.com,
	jeremy.linton@arm.com,
	jonathan.cameron@huawei.com,
	kobak@nvidia.com,
	lcherian@marvell.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	peternewman@google.com,
	quic_jiles@quicinc.com,
	rafael@kernel.org,
	robh@kernel.org,
	rohit.mathew@arm.com,
	scott@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	sudeep.holla@arm.com,
	tan.shaopeng@fujitsu.com,
	will@kernel.org,
	xhao@linux.alibaba.com,
	reinette.chatre@intel.com,
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v6 03/34] ACPI / PPTT: Add acpi_pptt_cache_v1_full to use pptt cache as one structure
Date: Wed, 19 Nov 2025 12:22:33 +0000
Message-ID: <20251119122305.302149-4-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119122305.302149-1-ben.horgan@arm.com>
References: <20251119122305.302149-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In actbl2.h, acpi_pptt_cache describes the fields in the original
Cache Type Structure. In PPTT table version 3 a new field was added at the
end, cache_id. This is described in acpi_pptt_cache_v1 but rather than
including all v1 fields it just includes this one.

In lieu of this being fixed in acpica, introduce acpi_pptt_cache_v1_full to
contain all the fields of the Cache Type Structure . Update the existing
code to use this new struct. This simplifies the code and removes a
non-standard use of ACPI_ADD_PTR.

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
I have opened a pull request to acpica to update acpi_pptt_cache_v1 to
include all fields. https://github.com/acpica/acpica/pull/1059

Changes since v5:
Add __packed
Formatting

Change since v4:
Use fields directly in acpi_pptt_cache_v1_full
Delay the casting

Changes since v3:
New patch
---
 drivers/acpi/pptt.c | 45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 2856254e29d7..ef39b176dc00 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -21,6 +21,25 @@
 #include <linux/cacheinfo.h>
 #include <acpi/processor.h>
 
+/*
+ * The acpi_pptt_cache_v1 in actbl2.h, which is imported from acpica,
+ * only contains the cache_id field rather than all the fields of the
+ * Cache Type Structure. Use this alternative structure until it is
+ * resolved in acpica.
+ */
+struct acpi_pptt_cache_v1_full {
+	struct acpi_subtable_header header;
+	u16 reserved;
+	u32 flags;
+	u32 next_level_of_cache;
+	u32 size;
+	u32 number_of_sets;
+	u8 associativity;
+	u8 attributes;
+	u16 line_size;
+	u32 cache_id;
+} __packed;
+
 static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
 							u32 pptt_ref)
 {
@@ -56,6 +75,18 @@ static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_
 	return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
 }
 
+static struct acpi_pptt_cache_v1_full *upgrade_pptt_cache(struct acpi_pptt_cache *cache)
+{
+	if (cache->header.length < sizeof(struct acpi_pptt_cache_v1_full))
+		return NULL;
+
+	/* No use for v1 if the only additional field is invalid */
+	if (!(cache->flags & ACPI_PPTT_CACHE_ID_VALID))
+		return NULL;
+
+	return (struct acpi_pptt_cache_v1_full *)cache;
+}
+
 static struct acpi_subtable_header *acpi_get_pptt_resource(struct acpi_table_header *table_hdr,
 							   struct acpi_pptt_processor *node,
 							   int resource)
@@ -355,7 +386,6 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
  * @this_leaf: Kernel cache info structure being updated
  * @found_cache: The PPTT node describing this cache instance
  * @cpu_node: A unique reference to describe this cache instance
- * @revision: The revision of the PPTT table
  *
  * The ACPI spec implies that the fields in the cache structures are used to
  * extend and correct the information probed from the hardware. Lets only
@@ -365,10 +395,9 @@ static struct acpi_pptt_cache *acpi_find_cache_node(struct acpi_table_header *ta
  */
 static void update_cache_properties(struct cacheinfo *this_leaf,
 				    struct acpi_pptt_cache *found_cache,
-				    struct acpi_pptt_processor *cpu_node,
-				    u8 revision)
+				    struct acpi_pptt_processor *cpu_node)
 {
-	struct acpi_pptt_cache_v1* found_cache_v1;
+	struct acpi_pptt_cache_v1_full *found_cache_v1;
 
 	this_leaf->fw_token = cpu_node;
 	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
@@ -418,9 +447,8 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 	    found_cache->flags & ACPI_PPTT_CACHE_TYPE_VALID)
 		this_leaf->type = CACHE_TYPE_UNIFIED;
 
-	if (revision >= 3 && (found_cache->flags & ACPI_PPTT_CACHE_ID_VALID)) {
-		found_cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
-	                                      found_cache, sizeof(struct acpi_pptt_cache));
+	found_cache_v1 = upgrade_pptt_cache(found_cache);
+	if (found_cache_v1) {
 		this_leaf->id = found_cache_v1->cache_id;
 		this_leaf->attributes |= CACHE_ID;
 	}
@@ -445,8 +473,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 		pr_debug("found = %p %p\n", found_cache, cpu_node);
 		if (found_cache)
 			update_cache_properties(this_leaf, found_cache,
-						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)),
-						table->revision);
+						ACPI_TO_POINTER(ACPI_PTR_DIFF(cpu_node, table)));
 
 		index++;
 	}
-- 
2.43.0


