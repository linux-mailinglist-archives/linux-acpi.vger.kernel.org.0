Return-Path: <linux-acpi+bounces-14300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C5FAD78BE
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 19:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FA1161A7F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA53299A83;
	Thu, 12 Jun 2025 17:14:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E751E5B68
	for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748448; cv=none; b=rl8/NOCrpzBdjFYUBaFPfpGI9axurza5kQAI7TrihK9r93lhBA38ldjDGF6qVoR1NLYSFv2j8KRsIsgw1kQfwBnxK1YmySDdisPq2WJ23wkakQIMLIEO/D4TTXpix/iMCylg7q8A4t0uaToLKj8s4QN5AUlY4wcveT94+6zTdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748448; c=relaxed/simple;
	bh=Tj4s9GzqrA6SKhaqaQEt9gcQS5buZO7MlFe+jr9Dx7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R/kl7FFjYMt0n2vQZzjLjaTNi/WZM+VaxlGiRUheVLlIrZ6z3uVxJx9z+ByS9IvRKG+2KR0aa/ImkMI4XDjkjdRe9f3hd9Vl1QQT+is0ai9g1IfHgL6vsLJcu5FyssoSw40BsGoddms9NL0BsIk49dbBzYK6dISfRQ8qUlPUX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95BAB153B;
	Thu, 12 Jun 2025 10:13:45 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DABE33F59E;
	Thu, 12 Jun 2025 10:14:04 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Rafael Wysocki <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	sudeep.holla@arm.com,
	jeremy.linton@arm.com,
	James Morse <james.morse@arm.com>
Subject: [PATCH 1/4] ACPI / PPTT: Add a helper to fill a cpumask from a processor container
Date: Thu, 12 Jun 2025 17:13:33 +0000
Message-Id: <20250612171336.4858-2-james.morse@arm.com>
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

The PPTT describes CPUs and caches, as well as processor containers.
The ACPI table for MPAM describes the set of CPUs that can access an MSC
with the UID of a processor container.

Add a helper to find the processor container by its id, then walk
the possible CPUs to fill a cpumask with the CPUs that have this
processor container as a parent.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/pptt.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  6 +++
 2 files changed, 97 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 54676e3d82dd..aaf9b5a26d07 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -298,6 +298,97 @@ static struct acpi_pptt_processor *acpi_find_processor_node(struct acpi_table_he
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
+ * @cpus		The resulting CPU mask.
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
+int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus)
+{
+	struct acpi_pptt_processor *cpu_node;
+	struct acpi_table_header *table_hdr;
+	struct acpi_subtable_header *entry;
+	bool leaf_flag, has_leaf_flag = false;
+	unsigned long table_end;
+	acpi_status status;
+	u32 proc_sz;
+	int ret = 0;
+
+	cpumask_clear(cpus);
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table_hdr);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	if (table_hdr->revision > 1)
+		has_leaf_flag = true;
+
+	table_end = (unsigned long)table_hdr + table_hdr->length;
+	entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr,
+			     sizeof(struct acpi_table_pptt));
+	proc_sz = sizeof(struct acpi_pptt_processor);
+	while ((unsigned long)entry + proc_sz < table_end) {
+		cpu_node = (struct acpi_pptt_processor *)entry;
+		if (entry->type == ACPI_PPTT_TYPE_PROCESSOR &&
+		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID) {
+			leaf_flag = cpu_node->flags & ACPI_PPTT_ACPI_LEAF_NODE;
+			if ((has_leaf_flag && !leaf_flag) ||
+			    (!has_leaf_flag && !acpi_pptt_leaf_node(table_hdr, cpu_node))) {
+				if (cpu_node->acpi_processor_id == acpi_cpu_id)
+					acpi_pptt_get_child_cpus(table_hdr, cpu_node, cpus);
+			}
+		}
+		entry = ACPI_ADD_PTR(struct acpi_subtable_header, entry,
+				     entry->length);
+	}
+
+	acpi_put_table(table_hdr);
+
+	return ret;
+}
+
 static u8 acpi_cache_type(enum cache_type type)
 {
 	switch (type) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f102c0fe3431..8c3165c2b083 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1541,6 +1541,7 @@ int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
+int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id, cpumask_t *cpus);
 #else
 static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
 {
@@ -1562,6 +1563,11 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
 {
 	return -EINVAL;
 }
+static inline int acpi_pptt_get_cpus_from_container(u32 acpi_cpu_id,
+						    cpumask_t *cpus)
+{
+	return -EINVAL;
+}
 #endif
 
 void acpi_arch_init(void);
-- 
2.39.5


