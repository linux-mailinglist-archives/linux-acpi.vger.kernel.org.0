Return-Path: <linux-acpi+bounces-18933-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4CC65644
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 232D635DBA5
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E3F30FC27;
	Mon, 17 Nov 2025 17:00:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C3430BF64;
	Mon, 17 Nov 2025 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398842; cv=none; b=tYEk/gdeEGbrtBDWRgIloWkAzkTEtP+gugdaZIUr+uN8zztlvlrJ3D6XbOkTErrs+brltt05RtQDslCk8SnY1e63/0TScmIngSWGrhGBJ8gDLT3dE59LQByD7TQtBrOsJrKertmEz4VIryPC8vTWkknX/Ek/Cks2/vPYJNJ8Wnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398842; c=relaxed/simple;
	bh=xAABhR6B59RAjcOP9UEFYxWvm15m1IHOLcve/EbLzDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPSFdG3LOA95K5L1IYCLBXQiNRumSVyDfYWApHsAk6mUm618OYiL6InUJSPD5je+0yielSDcIXZDlDTXhQMR8w/496+7G4yNTeUU3NpK9XBn+cmjzZGRr5h040L0WoUe5cZ4H3vedpJ2Fvs2h8JiLGaz5dgJFj4TW6GaQsb6Roo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE1ADFEC;
	Mon, 17 Nov 2025 09:00:31 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71A233F66E;
	Mon, 17 Nov 2025 09:00:34 -0800 (PST)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v5 02/34] ACPI / PPTT: Stop acpi_count_levels() expecting callers to clear levels
Date: Mon, 17 Nov 2025 16:59:41 +0000
Message-ID: <20251117170014.4113754-3-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117170014.4113754-1-ben.horgan@arm.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

In acpi_count_levels(), the initial value of *levels passed by the
caller is really an implementation detail of acpi_count_levels(), so it
is unreasonable to expect the callers of this function to know what to
pass in for this parameter.  The only sensible initial value is 0,
which is what the only upstream caller (acpi_get_cache_info()) passes.

Use a local variable for the starting cache level in acpi_count_levels(),
and pass the result back to the caller via the function return value.

Get rid of the levels parameter, which has no remaining purpose.

Fix acpi_get_cache_info() to match.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
s/starting_level/current_level/ (Jonathan)
---
 drivers/acpi/pptt.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index b8248c0092fe..2856254e29d7 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -177,14 +177,14 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
 }
 
 /**
- * acpi_count_levels() - Given a PPTT table, and a CPU node, count the cache
- * levels and split cache levels (data/instruction).
+ * acpi_count_levels() - Given a PPTT table, and a CPU node, count the
+ * total number of levels and split cache levels (data/instruction).
  * @table_hdr: Pointer to the head of the PPTT table
  * @cpu_node: processor node we wish to count caches for
- * @levels: Number of levels if success.
  * @split_levels:	Number of split cache levels (data/instruction) if
  *			success. Can by NULL.
  *
+ * Return: number of levels.
  * Given a processor node containing a processing unit, walk into it and count
  * how many levels exist solely for it, and then walk up each level until we hit
  * the root node (ignore the package level because it may be possible to have
@@ -192,14 +192,18 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
  * split cache levels (data/instruction) that exist at each level on the way
  * up.
  */
-static void acpi_count_levels(struct acpi_table_header *table_hdr,
-			      struct acpi_pptt_processor *cpu_node,
-			      unsigned int *levels, unsigned int *split_levels)
+static int acpi_count_levels(struct acpi_table_header *table_hdr,
+			     struct acpi_pptt_processor *cpu_node,
+			     unsigned int *split_levels)
 {
+	int current_level = 0;
+
 	do {
-		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
+		acpi_find_cache_level(table_hdr, cpu_node, &current_level, split_levels, 0, 0);
 		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
 	} while (cpu_node);
+
+	return current_level;
 }
 
 /**
@@ -645,7 +649,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
 	if (!cpu_node)
 		return -ENOENT;
 
-	acpi_count_levels(table, cpu_node, levels, split_levels);
+	*levels = acpi_count_levels(table, cpu_node, split_levels);
 
 	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
 		 *levels, split_levels ? *split_levels : -1);
-- 
2.43.0


