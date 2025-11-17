Return-Path: <linux-acpi+bounces-18932-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B440DC6558A
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 18:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45F654F0DED
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Nov 2025 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F730BF72;
	Mon, 17 Nov 2025 17:00:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBBE309EED;
	Mon, 17 Nov 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398837; cv=none; b=o/6FQXVm2u1AyeXtimm864FenDxegU3em/nId4zVqIGtxsVe3PewIGDcmDRfpemQEnfO6RC0ZURiH1O79VDk30HZA4a3UpiSRtXuKxZsQbPXMtkoFRs7QQTOYEihOdC/1y4MD5BYXsr6/nb8y2g4Wn0MLJImnM95PURo3RdLpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398837; c=relaxed/simple;
	bh=aLien5MxtDJQTuxCi6SUwxUpRz9Ler3X/b+bhR9FCYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8/Rel1pQRsa+xira1V4K4LXMtYgff2vM5/EST9xAlFCjp89+2YrAZNW+PG03KxfI+ubFHxWREt+qJ53DAYXViWZyHv3O1/0yrzTXsBHJsW23MviZ5jN94qbDxaTt39/db0bWoIhuI6jEgU5WGijdMgLi/NU91zxbo8pGtCB+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0891007;
	Mon, 17 Nov 2025 09:00:26 -0800 (PST)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 150303F66E;
	Mon, 17 Nov 2025 09:00:28 -0800 (PST)
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
Subject: [PATCH v5 01/34] ACPI / PPTT: Add a helper to fill a cpumask from a processor container
Date: Mon, 17 Nov 2025 16:59:40 +0000
Message-ID: <20251117170014.4113754-2-ben.horgan@arm.com>
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

The ACPI MPAM table uses the UID of a processor container specified in
the PPTT to indicate the subset of CPUs and cache topology that can
access each MPAM System Component (MSC).

This information is not directly useful to the kernel. The equivalent
cpumask is needed instead.

Add a helper to find the processor container by its id, then walk
the possible CPUs to fill a cpumask with the CPUs that have this
processor container as a parent.

CC: Dave Martin <dave.martin@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Tested-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
Changes since v4:
Remove blank line

Changes since v3:
Refer to processor hierarchy in comments (Jonathan)
Fix indent (Jonathan)
---
 drivers/acpi/pptt.c  | 84 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  3 ++
 2 files changed, 87 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 54676e3d82dd..b8248c0092fe 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -817,3 +817,87 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
 					  ACPI_PPTT_ACPI_IDENTICAL);
 }
+
+/**
+ * acpi_pptt_get_child_cpus() - Find all the CPUs below a PPTT
+ * processor hierarchy node
+ *
+ * @table_hdr:		A reference to the PPTT table
+ * @parent_node:	A pointer to the processor hierarchy node in the
+ *			table_hdr
+ * @cpus:		A cpumask to fill with the CPUs below @parent_node
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
+ *                                       processor container
+ * @acpi_cpu_id:	The UID of the processor container
+ * @cpus:		The resulting CPU mask
+ *
+ * Find the specified Processor Container, and fill @cpus with all the cpus
+ * below it.
+ *
+ * Not all 'Processor Hierarchy' entries in the PPTT are either a CPU
+ * or a Processor Container, they may exist purely to describe a
+ * Private resource. CPUs have to be leaves, so a Processor Container
+ * is a non-leaf that has the 'ACPI Processor ID valid' flag set.
+ */
+void acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
+{
+	struct acpi_table_header *table_hdr;
+	struct acpi_subtable_header *entry;
+	unsigned long table_end;
+	u32 proc_sz;
+
+	cpumask_clear(cpus);
+
+	table_hdr = acpi_get_pptt();
+	if (!table_hdr)
+		return;
+
+	table_end = (unsigned long)table_hdr + table_hdr->length;
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+			     sizeof(struct acpi_table_pptt));
+	proc_sz = sizeof(struct acpi_pptt_processor);
+	while ((unsigned long)entry + proc_sz <= table_end) {
+		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR) {
+			struct acpi_pptt_processor *cpu_node;
+
+			cpu_node = (struct acpi_pptt_processor *)entry;
+			if (cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID &&
+			    !acpi_pptt_leaf_node(table_hdr, cpu_node) &&
+			    cpu_node->acpi_processor_id == acpi_cpu_id) {
+				acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
+				break;
+			}
+		}
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
+				     entry->length);
+	}
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99f6ead..4752ebd48132 100644
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
2.43.0


