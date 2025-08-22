Return-Path: <linux-acpi+bounces-15912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B1B31EBC
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 17:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666775E067E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Aug 2025 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63EB225793;
	Fri, 22 Aug 2025 15:31:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F9221714;
	Fri, 22 Aug 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755876685; cv=none; b=It0ftigCLqDWHxpR84dA9ViouHjce/qgKCRP2J3hp0Vr6DmHdcOz47iGfgjFx7+DmholAWwXGtzF5ixWn0YkXXsUc104931RI3IWX4NgJiWoEh0xDuHroYP+pW55bSLl6tcCAIwERmnJ8f90t8D5nhwJEGdgRJMsmjma+Iycths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755876685; c=relaxed/simple;
	bh=gEyQcZZsP23ow9G5sDRvS21MvQKVxhDWe31++cbp5L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sP8oyJMfPQm6+n7shkHVrsMHnAHnRictJjImCglzBYzFQoBKiK0qdB/pHibzMgJpqcKcjBqpIZ9dXzJ6YmJMCKFttcznJeFS1VJxPp2CEJDtFKPjAqkrtcGaLvny10swd+DTKGZ7I13B5Gt+XPOyLyP7v+8onlbPUhooK0vmZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F6E327DC;
	Fri, 22 Aug 2025 08:31:15 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDF8F3F63F;
	Fri, 22 Aug 2025 08:31:17 -0700 (PDT)
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 03/33] ACPI / PPTT: Add a helper to fill a cpumask from a processor container
Date: Fri, 22 Aug 2025 15:29:44 +0000
Message-Id: <20250822153048.2287-4-james.morse@arm.com>
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

The PPTT describes CPUs and caches, as well as processor containers.
The ACPI table for MPAM describes the set of CPUs that can access an MSC
with the UID of a processor container.

Add a helper to find the processor container by its id, then walk
the possible CPUs to fill a cpumask with the CPUs that have this
processor container as a parent.

CC: Dave Martin <dave.martin@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since RFC:
 * Dropped has_leaf_flag dodging of acpi_pptt_leaf_node()
 * Added missing : in kernel-doc
 * Made helper return void as this never actually returns an error.
---
 drivers/acpi/pptt.c  | 86 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  3 ++
 2 files changed, 89 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 54676e3d82dd..4791ca2bdfac 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -298,6 +298,92 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
 	return NULL;
 }
 
+/**
+ * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT processor node
+ * @table_hdr:		A reference to the PPTT table.
+ * @parent_node:	A pointer to the processor node in the @table_hdr.
+ * @cpus:		A cpumask to fill with the CPUs below @parent_node.
+ *
+ * Walks up the PPTT from every possible CPU to find if the provided
+ * @parent_node is a parent of this CPU.
+ */
+static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
+				     struct acpi_pptt_processor *parent_node,
+				     cpumask_t *cpus)
+{
+	struct acpi_pptt_processor *cpu_node;
+	u32 acpi_id;
+	int cpu;
+
+	cpumask_clear(cpus);
+
+	for_each_possible_cpu(cpu) {
+		acpi_id = get_acpi_id_for_cpu(cpu);
+		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
+
+		while (cpu_node) {
+			if (cpu_node == parent_node) {
+				cpumask_set_cpu(cpu, cpus);
+				break;
+			}
+			cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
+		}
+	}
+}
+
+/**
+ * acpi_pptt_get_cpus_from_container() - Populate a cpumask with all CPUs in a
+ *                                       processor containers
+ * @acpi_cpu_id:	The UID of the processor container.
+ * @cpus:		The resulting CPU mask.
+ *
+ * Find the specified Processor Container, and fill @cpus with all the cpus
+ * below it.
+ *
+ * Not all 'Processor' entries in the PPTT are either a CPU or a Processor
+ * Container, they may exist purely to describe a Private resource. CPUs
+ * have to be leaves, so a Processor Container is a non-leaf that has the
+ * 'ACPI Processor ID valid' flag set.
+ *
+ * Return: 0 for a complete walk, or an error if the mask is incomplete.
+ */
+void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
+{
+	struct acpi_pptt_processor *cpu_node;
+	struct acpi_table_header *table_hdr;
+	struct acpi_subtable_header *entry;
+	unsigned long table_end;
+	acpi_status status;
+	bool leaf_flag;
+	u32 proc_sz;
+
+	cpumask_clear(cpus);
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table_hdr);
+	if (ACPI_FAILURE(status))
+		return;
+
+	table_end = (unsigned long)table_hdr + table_hdr->length;
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+			     sizeof(struct acpi_table_pptt));
+	proc_sz = sizeof(struct acpi_pptt_processor);
+	while ((unsigned long)entry + proc_sz <= table_end) {
+		cpu_node = (struct acpi_pptt_processor *)entry;
+		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
+		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
+			leaf_flag = acpi_pptt_leaf_node(table_hdr, cpu_node);
+			if (!leaf_flag) {
+				if (cpu_node->acpi_processor_id == acpi_cpu_id)
+					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
+			}
+		}
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
+				     entry->length);
+	}
+
+	acpi_put_table(table_hdr);
+}
+
 static u8 acpi_cache_type(enum cache_type type)
 {
 	switch (type) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1c5bb1e887cd..f97a9ff678cc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1541,6 +1541,7 @@ int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
+void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1562,6 +1563,8 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 {
 	return -EINVAL;
 }
+static inline void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
+						     cpumask_t *cpus) { }
 #endif
 
 void acpi_arch_init(void);
-- 
2.20.1


