Return-Path: <linux-acpi+bounces-19078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 351F0C6E71F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 13:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 841E94EEB90
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779133587C6;
	Wed, 19 Nov 2025 12:23:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5E43587D9;
	Wed, 19 Nov 2025 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555032; cv=none; b=BkLYu1elAxmd9UUBf/RdcLyuLrQVFEsjImLgQyg0l8zC7P+PBI7nOKb2qdlagLPxbsIFJmYfjeFS9PXrwmIqSJ5ER+SIeLzpVPM6Gwt4K7gCCDG/NtGAo0Wno4kbiVrUjg95d+/kwlGFk//9jz9ga9HhuOYmqiXNSMQ/4w4JEqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555032; c=relaxed/simple;
	bh=y6pGeAHvLapu5ea8BhBVvbLrQhzIAix950xBgd8FYbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXAjThxAYcezIOEL/K2HKrwTd5D7v9odJUN1//V/TT3qW2WblqJWC2Dmie7xORNEQD6FP6XYyyeqkTnuMajQgZa+z6YgIWmj+UGcdMBYSs8dd63eyjalsSs+QnHFef24WmUj+7epgHInOPwjl74krCG8qiety0AMEmk/01XXDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EBAA1758;
	Wed, 19 Nov 2025 04:23:42 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CC5933F740;
	Wed, 19 Nov 2025 04:23:44 -0800 (PST)
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH v6 04/34] ACPI / PPTT: Find cache level by cache-id
Date: Wed, 19 Nov 2025 12:22:34 +0000
Message-ID: <20251119122305.302149-5-ben.horgan@arm.com>
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

From: James Morse <james.morse@arm.com>

The MPAM table identifies caches by id. The MPAM driver also wants to know
the cache level to determine if the platform is of the shape that can be
managed via resctrl. Cacheinfo has this information, but only for CPUs that
are online.

Waiting for all CPUs to come online is a problem for platforms where
CPUs are brought online late by user-space.

Add a helper that walks every possible cache, until it finds the one
identified by cache-id, then return the level.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
---
Changes since v4:
Initialise acpi_cpu_id at declaration
Convert a for loop to do/while (Jonathan)
Use new version of acpi_pptt_cache_v1_full

Changes since v3:
Tags dropped due to rework
Fallout/simplification from adding acpi_pptt_cache_v1_full
Look for each cache type before incrementing level
---
 drivers/acpi/pptt.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  5 ++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index ef39b176dc00..da49b56a1ef2 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -932,3 +932,69 @@ void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
 				     entry->length);
 	}
 }
+
+/**
+ * find_acpi_cache_level_from_id() - Get the level of the specified cache
+ * @cache_id: The id field of the cache
+ *
+ * Determine the level relative to any CPU for the cache identified by
+ * cache_id. This allows the property to be found even if the CPUs are offline.
+ *
+ * The returned level can be used to group caches that are peers.
+ *
+ * The PPTT table must be rev 3 or later.
+ *
+ * If one CPU's L2 is shared with another CPU as L3, this function will return
+ * an unpredictable value.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, the revision isn't supported or
+ * the cache cannot be found.
+ * Otherwise returns a value which represents the level of the specified cache.
+ */
+int find_acpi_cache_level_from_id(u32 cache_id)
+{
+	int cpu;
+	struct acpi_table_header *table;
+
+	table = acpi_get_pptt();
+	if (!table)
+		return -ENOENT;
+
+	if (table->revision < 3)
+		return -ENOENT;
+
+	for_each_possible_cpu(cpu) {
+		bool empty;
+		int level = 1;
+		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		struct acpi_pptt_cache *cache;
+		struct acpi_pptt_processor *cpu_node;
+
+		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+		if (!cpu_node)
+			continue;
+
+		do {
+			int cache_type[] = {CACHE_TYPE_INST, CACHE_TYPE_DATA, CACHE_TYPE_UNIFIED};
+
+			empty = true;
+			for (int i = 0; i < ARRAY_SIZE(cache_type); i++) {
+				struct acpi_pptt_cache_v1_full *cache_v1;
+
+				cache = acpi_find_cache_node(table, acpi_cpu_id, cache_type[i],
+							     level, &cpu_node);
+				if (!cache)
+					continue;
+
+				empty = false;
+
+				cache_v1 = upgrade_pptt_cache(cache);
+				if (cache_v1 && cache_v1->cache_id == cache_id)
+					return level;
+			}
+			level++;
+		} while (!empty);
+	}
+
+	return -ENOENT;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4752ebd48132..be074bdfd4d1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1542,6 +1542,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
+int find_acpi_cache_level_from_id(u32 cache_id);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1565,6 +1566,10 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 }
 static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
 						     cpumask_t *cpus) { }
+static inline int find_acpi_cache_level_from_id(u32 cache_id)
+{
+	return -ENOENT;
+}
 #endif
 
 void acpi_arch_init(void);
-- 
2.43.0


