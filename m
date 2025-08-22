Return-Path: <linux-acpi+bounces-15949-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F62B31F4E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9A93AE37E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD2631E115;
	Fri, 22 Aug 2025 15:34:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B63128C7;
	Fri, 22 Aug 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876894; cv=none; b=bQ3umHLQiVtLnxp9N9Hg+pq5o7XpzOaNZb7hFe1sMaNEFnIUxEPev5VlojEiRfgq6IsJ2IgHAtgKnZVUOGg+osP7ybnFTU7S4rPMhdF/1fIBHKizcumrlWbY1sjJ23gpb5uMYKsCcwDw0T9+qow1RdBOwJjr/mm17QPGXEL0S0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876894; c=relaxed/simple;
	bh=DQbYWzAz7EinACFpXFh81z5VUFibq+peZuSz3p4d5N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UybSMDtDX4lJZofwvh8D+rTxY1VnW9QBEP3EMPf5tWsDbCa1VaBk9n5gaagD11KXq/Wnd5pxcAT1PYQ0psm4knpCXnPfgr5kX9oD4+Ve+75Jhj6qg4SkvnSyfyaDSQyjvLEt36qbQrjtmthO4jMWisQKOybZFR+A1hDLngVAg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D2B8F15A1;
	Fri, 22 Aug 2025 08:34:43 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3F6E3F63F;
	Fri, 22 Aug 2025 08:34:46 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>,
	Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rohit Mathew <Rohit.Mathew@arm.com>
Subject: [PATCH 06/33] ACPI / PPTT: Add a helper to fill a cpumask from a cache_id
Date: Fri, 22 Aug 2025 15:30:21 +0000
Message-Id: <20250822153048.2287-41-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250822153048.2287-1-james.morse@arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
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
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
Changes since RFC:
 * acpi_count_levels() now returns a value.
 * Converted the table-get stuff to use Jonathan's cleanup helper.
 * Dropped Sudeep's Review tag due to the cleanup change.
---
 drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  6 +++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 660457644a5b..cb93a9a7f9b6 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -971,3 +971,65 @@ int find_acpi_cache_level_from_id(u32 cache_id)
 
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
+	int level, cpu, num_levels;
+	struct acpi_pptt_cache *cache;
+	struct acpi_pptt_cache_v1 *cache_v1;
+	struct acpi_pptt_processor *cpu_node;
+	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_PPTT, 0);
+
+	cpumask_clear(cpus);
+
+	if (IS_ERR(table))
+		return -ENOENT;
+
+	if (table->revision < 3)
+		return -ENOENT;
+
+	/*
+	 * If we found the cache first, we'd still need to walk from each cpu.
+	 */
+	for_each_possible_cpu(cpu) {
+		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+		if (!cpu_node)
+			return 0;
+		num_levels = acpi_count_levels(table, cpu_node, NULL);
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
+			    cache_v1->cache_id == cache_id)
+				cpumask_set_cpu(cpu, cpus);
+		}
+	}
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 30c10b1dcdb2..4ad08f5f1d83 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1555,6 +1555,7 @@ int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
 int find_acpi_cache_level_from_id(u32 cache_id);
+int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1582,6 +1583,11 @@ static inline int find_acpi_cache_level_from_id(u32 cache_id)
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
2.20.1


