Return-Path: <linux-acpi+bounces-18935-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC92C654FD
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 78A0328BC3
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFC3312824;
	Mon, 17 Nov 2025 17:00:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BEF312815;
	Mon, 17 Nov 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398855; cv=none; b=dPiW41hwaBXMw7cwedsuTRqODX3F6F7Zs7xshe6nkBaDWLAN90FBTu74q0XwXdWdZ7vGZjcXE+HyBynDlZxv2XdjToVgUcUm+DQPyrgmMIoBg+KQ9oUAtWqGKNdG0fFkreila1XEasC8204U356YqhEX1a6/68OcFoUfNkHIAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398855; c=relaxed/simple;
	bh=no4jrKGWzmD042tQwNAjeXEBywKdz2meweVDd1K9udI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTYFy5XqMbDFz9QaA5J/4/WTSO6rumxutMEntsSWjOZShZc9vxE6ZwiQHboNaUEvfLw5MemPEath4ncd2nA695MPM1ltcKsS5VsPRJSSTNYw4HikbP/U9lUsXbMb2hKzHRH439PZUhjY80fKk/7y+UGpflPGf6abHSjoJttEAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3880FEC;
	Mon, 17 Nov 2025 09:00:42 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 177143F66E;
	Mon, 17 Nov 2025 09:00:44 -0800 (PST)
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
	Ben Horgan <ben.horgan@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Zeng Heng <zengheng4@huawei.com>
Subject: [PATCH v5 04/34] ACPI / PPTT: Find cache level by cache-id
Date: Mon, 17 Nov 2025 16:59:43 +0000
Message-ID: <20251117170014.4113754-5-ben.horgan@arm.com>
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
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
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
index 53fde9bd8140..5b1e9e410204 100644
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


