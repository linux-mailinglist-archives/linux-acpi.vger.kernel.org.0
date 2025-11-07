Return-Path: <linux-acpi+bounces-18630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A3AC3FE9B
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 13:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E05534B8FD
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DA246327;
	Fri,  7 Nov 2025 12:35:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DC826B0B3;
	Fri,  7 Nov 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762518956; cv=none; b=aEANAUmMZ9LkGG63QklkspgP6OXia5uP7Hatk6tVRQu4FwDBAkaCRNU/BJ0Gi8WMoVacGcvhtbXcd0l6yxjGXaaxGp2ffCNwQL+THBIe8iibtI8bmn31gwD4p/b8HiV06p1la9aO1EXCcq2pXeAEyU2EMYZPNookJKaHEaIbCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762518956; c=relaxed/simple;
	bh=F4c825uMyazkZVzS7TZndg2LBSfJMNaqFm0PNPFW1rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOHxX5j/d7L29SoAVf4STzGLbjWE0R112MNFsEoyXrlbgsHJ/+UqtvkYfHyH4U41hbHBUhpInVHBYh4Ka+VaGXYl8qtYnvdshMhzYwVd4nkrb5Rw3/L5qVGU8BIxnrghAmzJnNAgByeKAxlo9mI02nDqTliJHOL+CvXWlcGVUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876B4153B;
	Fri,  7 Nov 2025 04:35:46 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62A543F66E;
	Fri,  7 Nov 2025 04:35:49 -0800 (PST)
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
	Rohit Mathew <Rohit.Mathew@arm.com>,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH 05/33] ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
Date: Fri,  7 Nov 2025 12:34:22 +0000
Message-ID: <20251107123450.664001-6-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

MPAM identifies CPUs by the cache_id in the PPTT cache structure.

The driver needs to know which CPUs are associated with the cache.
The CPUs may not all be online, so cacheinfo does not have the
information.

Add a helper to pull this information out of the PPTT.

CC: Rohit Mathew <Rohit.Mathew@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v3:
Equivalent changes to the previous patch:
 Tags dropped due to rework
 Fallout/simplification from adding acpi_pptt_cache_v1_full
 Look for each cache type before incrementing level
---
 drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  6 +++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 71841c106020..7b4cb17c12c0 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -981,3 +981,65 @@ int find_acpi_cache_level_from_id(u32 cache_id)
 
 	return -ENOENT;
 }
+
+/**
+ * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
+ *					   specified cache
+ * @cache_id: The id field of the cache
+ * @cpus: Where to build the cpumask
+ *
+ * Determine which CPUs are below this cache in the PPTT. This allows the property
+ * to be found even if the CPUs are offline.
+ *
+ * The PPTT table must be rev 3 or later,
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
+ * Otherwise returns 0 and sets the cpus in the provided cpumask.
+ */
+int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
+{
+	int cpu;
+	struct acpi_table_header *table;
+
+	cpumask_clear(cpus);
+
+	table = acpi_get_pptt();
+	if (!table)
+		return -ENOENT;
+
+	if (table->revision < 3)
+		return -ENOENT;
+
+	for_each_possible_cpu(cpu) {
+		bool not_empty = true;
+		u32 acpi_cpu_id;
+		struct acpi_pptt_cache_v1_full *cache;
+		struct acpi_pptt_processor *cpu_node;
+
+		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+		if (!cpu_node)
+			continue;
+
+		for (int level = 1; not_empty; level++) {
+			int cache_type[] = {CACHE_TYPE_INST, CACHE_TYPE_DATA, CACHE_TYPE_UNIFIED};
+
+			not_empty = false;
+			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
+				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
+							     level, &cpu_node);
+
+				if (!cache)
+					continue;
+
+				not_empty = true;
+
+				if (acpi_pptt_cache_id_is_valid(cache) &&
+				    cache->extra.cache_id == cache_id)
+					cpumask_set_cpu(cpu, cpus);
+			}
+		}
+	}
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index be074bdfd4d1..a9dbacabdf89 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1543,6 +1543,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
 int find_acpi_cache_level_from_id(u32 cache_id);
+int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1570,6 +1571,11 @@ static inline int find_acpi_cache_level_from_id(u32 cache_id)
 {
 	return -ENOENT;
 }
+static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
+						      cpumask_t *cpus)
+{
+	return -ENOENT;
+}
 #endif
 
 void acpi_arch_init(void);
-- 
2.43.0


