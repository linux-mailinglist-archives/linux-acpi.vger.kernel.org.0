Return-Path: <linux-acpi+bounces-14303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C91AD78C1
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 19:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB51188DBA8
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235E429B773;
	Thu, 12 Jun 2025 17:14:13 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D11E5B68
	for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2025 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748453; cv=none; b=pwqEhlNPFL4QexjWbmMlLNZ9P7PmkqnCQgmE/iYpwbbpZGy0tm68pdtKUHp/jMHqAqYnlixdQUCGkFf8erivedoieteEoPjBDJtLFUZx767PcDEguOjCo4XhcwCdFpfbMs54mLjda0MtXWKpmCE8u44rwoPZSxi9k1wfE5TFJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748453; c=relaxed/simple;
	bh=OQZFRvVHIwxHfRxW5AJVHtpN2QcJ4qff+VU6a5UufO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yq4HSA7ovGAsCvT+UC3r1hMfOF4m4hlRTNAqxdUSrvejXjwdWka+ubtHiugF21gGWlF7BxLbtrLQiIdJ/f4L5qALgFJDVUjAfVTEwJ11MyStfjR5RKc5jH+I65JnSROVPvfAiSnVkLC2VogArYmwKJf3rBhWipQ0MtEoh2dYE/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 633A11C25;
	Thu, 12 Jun 2025 10:13:50 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EC393F59E;
	Thu, 12 Jun 2025 10:14:09 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	sudeep.holla@arm.com,
	jeremy.linton@arm.com,
	James Morse <james.morse@arm.com>,
	Rohit Mathew <Rohit.Mathew@arm.com>
Subject: [PATCH 4/4] ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
Date: Thu, 12 Jun 2025 17:13:36 +0000
Message-Id: <20250612171336.4858-5-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250612171336.4858-1-james.morse@arm.com>
References: <20250612171336.4858-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPAM identifies CPUs by the cache_id in the PPTT cache structure.

The driver needs to know which CPUs are associated with the cache,
the CPUs may not all be online, so cacheinfo does not have the
information.

Add a helper to pull this information out of the PPTT.

CC: Rohit Mathew <Rohit.Mathew@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/pptt.c  | 70 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  6 ++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 09be7d52d7ac..0ecb9378787a 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -983,3 +983,73 @@ int find_acpi_cache_level_from_id(u32 cache_id)
 	acpi_put_table(table);
 	return -ENOENT;
 }
+
+/**
+ * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
+ *					   specified cache
+ * @cache_id: The id field of the unified cache
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
+	u32 acpi_cpu_id;
+	acpi_status status;
+	int level, cpu, num_levels;
+	struct acpi_pptt_cache *cache;
+	struct acpi_table_header *table;
+	struct acpi_pptt_cache_v1 *cache_v1;
+	struct acpi_pptt_processor *cpu_node;
+
+	cpumask_clear(cpus);
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return -ENOENT;
+	}
+
+	if (table->revision < 3) {
+		acpi_put_table(table);
+		return -ENOENT;
+	}
+
+	/*
+	 * If we found the cache first, we'd still need to walk from each cpu.
+	 */
+	for_each_possible_cpu(cpu) {
+		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+		if (!cpu_node)
+			break;
+		acpi_count_levels(table, cpu_node, &num_levels, NULL);
+
+		/* Start at 1 for L1 */
+		for (level = 1; level <= num_levels; level++) {
+			cache = acpi_find_cache_node(table, acpi_cpu_id,
+						     ACPI_PPTT_CACHE_TYPE_UNIFIED,
+						     level, &cpu_node);
+			if (!cache)
+				continue;
+
+			cache_v1 = ACPI_ADD_PTR(struct acpi_pptt_cache_v1,
+						cache,
+						sizeof(struct acpi_pptt_cache));
+
+			if (cache->flags & ACPI_PPTT_CACHE_ID_VALID &&
+			    cache_v1->cache_id == cache_id) {
+				cpumask_set_cpu(cpu, cpus);
+			}
+		}
+	}
+
+	acpi_put_table(table);
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 82947f6d2a43..61ac3d1de1e8 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1543,6 +1543,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
 int find_acpi_cache_level_from_id(u32 cache_id);
+int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1573,6 +1574,11 @@ static inline int find_acpi_cache_level_from_id(u32 cache_id)
 {
 	return -EINVAL;
 }
+static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
+						      cpumask_t *cpus)
+{
+	return -EINVAL;
+}
 #endif
 
 void acpi_arch_init(void);
-- 
2.39.5


