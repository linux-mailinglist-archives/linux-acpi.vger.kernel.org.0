Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B972EBB24
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 09:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbhAFIge (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 03:36:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9717 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIgd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 03:36:33 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D9jN01szrzl10Q;
        Wed,  6 Jan 2021 16:34:40 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 16:35:40 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <valentin.schneider@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rjw@rjwysocki.net>,
        <vincent.guittot@linaro.org>, <lenb@kernel.org>,
        <gregkh@linuxfoundation.org>, <jonathan.cameron@huawei.com>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <mark.rutland@arm.com>, <sudeep.holla@arm.com>,
        <aubrey.li@linux.intel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@openeuler.org>, <xuwei5@huawei.com>,
        <prime.zeng@hisilicon.com>, <tiantao6@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [RFC PATCH v3 1/2] topology: Represent clusters of CPUs within a die.
Date:   Wed, 6 Jan 2021 21:30:25 +1300
Message-ID: <20210106083026.40444-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Both ACPI and DT provide the ability to describe additional layers of
topology between that of individual cores and higher level constructs
such as the level at which the last level cache is shared.
In ACPI this can be represented in PPTT as a Processor Hierarchy
Node Structure [1] that is the parent of the CPU cores and in turn
has a parent Processor Hierarchy Nodes Structure representing
a higher level of topology.

For example Kunpeng 920 has 6 clusters in each NUMA node, and each
cluster has 4 cpus. All clusters share L3 cache data, but each cluster
has local L3 tag. On the other hand, each clusters will share some
internal system bus.

+-----------------------------------+                          +---------+
|  +------+    +------+            +---------------------------+         |
|  | CPU0 |    | cpu1 |             |    +-----------+         |         |
|  +------+    +------+             |    |           |         |         |
|                                   +----+    L3     |         |         |
|  +------+    +------+   cluster   |    |    tag    |         |         |
|  | CPU2 |    | CPU3 |             |    |           |         |         |
|  +------+    +------+             |    +-----------+         |         |
|                                   |                          |         |
+-----------------------------------+                          |         |
+-----------------------------------+                          |         |
|  +------+    +------+             +--------------------------+         |
|  |      |    |      |             |    +-----------+         |         |
|  +------+    +------+             |    |           |         |         |
|                                   |    |    L3     |         |         |
|  +------+    +------+             +----+    tag    |         |         |
|  |      |    |      |             |    |           |         |         |
|  +------+    +------+             |    +-----------+         |         |
|                                   |                          |         |
+-----------------------------------+                          |   L3    |
                                                               |   data  |
+-----------------------------------+                          |         |
|  +------+    +------+             |    +-----------+         |         |
|  |      |    |      |             |    |           |         |         |
|  +------+    +------+             +----+    L3     |         |         |
|                                   |    |    tag    |         |         |
|  +------+    +------+             |    |           |         |         |
|  |      |    |      |            ++    +-----------+         |         |
|  +------+    +------+            |---------------------------+         |
+-----------------------------------|                          |         |
+-----------------------------------|                          |         |
|  +------+    +------+            +---------------------------+         |
|  |      |    |      |             |    +-----------+         |         |
|  +------+    +------+             |    |           |         |         |
|                                   +----+    L3     |         |         |
|  +------+    +------+             |    |    tag    |         |         |
|  |      |    |      |             |    |           |         |         |
|  +------+    +------+             |    +-----------+         |         |
|                                   |                          |         |
+-----------------------------------+                          |         |
+-----------------------------------+                          |         |
|  +------+    +------+             +--------------------------+         |
|  |      |    |      |             |   +-----------+          |         |
|  +------+    +------+             |   |           |          |         |
|                                   |   |    L3     |          |         |
|  +------+    +------+             +---+    tag    |          |         |
|  |      |    |      |             |   |           |          |         |
|  +------+    +------+             |   +-----------+          |         |
|                                   |                          |         |
+-----------------------------------+                          |         |
+-----------------------------------+                         ++         |
|  +------+    +------+             +--------------------------+         |
|  |      |    |      |             |  +-----------+           |         |
|  +------+    +------+             |  |           |           |         |
|                                   |  |    L3     |           |         |
|  +------+    +------+             +--+    tag    |           |         |
|  |      |    |      |             |  |           |           |         |
|  +------+    +------+             |  +-----------+           |         |
|                                   |                          +---------+
+-----------------------------------+

That means the cost to transfer ownership of a cacheline between CPUs
within a cluster is lower than between CPUs in different clusters on
the same die. Hence, it can make sense to tell the scheduler to use
the cache affinity of the cluster to make better decision on thread
migration.

This patch simply exposes this information to userspace libraries
like hwloc by providing cluster_cpus and related sysfs attributes.
PoC of HWLOC support at [2].

Note this patch only handle the ACPI case.

Special consideration is needed for SMT processors, where it is
necessary to move 2 levels up the hierarchy from the leaf nodes
(thus skipping the processor core level).

Currently the ID provided is the offset of the Processor
Hierarchy Nodes Structure within PPTT.  Whilst this is unique
it is not terribly elegant so alternative suggestions welcome.

Note that arm64 / ACPI does not provide any means of identifying
a die level in the topology but that may be unrelate to the cluster
level.

[1] ACPI Specification 6.3 - section 5.2.29.1 processor hierarchy node
    structure (Type 0)
[2] https://github.com/hisilicon/hwloc/tree/linux-cluster

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3:
 * no real change(v2 comments not addressed);
 * rebased againest 5.11-rc2;

 Documentation/admin-guide/cputopology.rst | 26 +++++++++++---
 arch/arm64/kernel/topology.c              |  2 ++
 drivers/acpi/pptt.c                       | 60 +++++++++++++++++++++++++++++++
 drivers/base/arch_topology.c              | 14 ++++++++
 drivers/base/topology.c                   | 10 ++++++
 include/linux/acpi.h                      |  5 +++
 include/linux/arch_topology.h             |  5 +++
 include/linux/topology.h                  |  6 ++++
 8 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index b90dafc..f9d3745 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -24,6 +24,12 @@ core_id:
 	identifier (rather than the kernel's).  The actual value is
 	architecture and platform dependent.
 
+cluster_id:
+
+	the Cluster ID of cpuX.  Typically it is the hardware platform's
+	identifier (rather than the kernel's).  The actual value is
+	architecture and platform dependent.
+
 book_id:
 
 	the book ID of cpuX. Typically it is the hardware platform's
@@ -56,6 +62,14 @@ package_cpus_list:
 	human-readable list of CPUs sharing the same physical_package_id.
 	(deprecated name: "core_siblings_list")
 
+cluster_cpus:
+
+	internal kernel map of CPUs within the same cluster.
+
+cluster_cpus_list:
+
+	human-readable list of CPUs within the same cluster.
+
 die_cpus:
 
 	internal kernel map of CPUs within the same die.
@@ -96,11 +110,13 @@ these macros in include/asm-XXX/topology.h::
 
 	#define topology_physical_package_id(cpu)
 	#define topology_die_id(cpu)
+	#define topology_cluster_id(cpu)
 	#define topology_core_id(cpu)
 	#define topology_book_id(cpu)
 	#define topology_drawer_id(cpu)
 	#define topology_sibling_cpumask(cpu)
 	#define topology_core_cpumask(cpu)
+	#define topology_cluster_cpumask(cpu)
 	#define topology_die_cpumask(cpu)
 	#define topology_book_cpumask(cpu)
 	#define topology_drawer_cpumask(cpu)
@@ -116,10 +132,12 @@ not defined by include/asm-XXX/topology.h:
 
 1) topology_physical_package_id: -1
 2) topology_die_id: -1
-3) topology_core_id: 0
-4) topology_sibling_cpumask: just the given CPU
-5) topology_core_cpumask: just the given CPU
-6) topology_die_cpumask: just the given CPU
+3) topology_cluster_id: -1
+4) topology_core_id: 0
+5) topology_sibling_cpumask: just the given CPU
+6) topology_core_cpumask: just the given CPU
+7) topology_cluster_cpumask: just the given CPU
+8) topology_die_cpumask: just the given CPU
 
 For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
 default definitions for topology_book_id() and topology_book_cpumask().
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index f6faa69..fe076b3 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -103,6 +103,8 @@ int __init parse_acpi_topology(void)
 			cpu_topology[cpu].thread_id  = -1;
 			cpu_topology[cpu].core_id    = topology_id;
 		}
+		topology_id = find_acpi_cpu_topology_cluster(cpu);
+		cpu_topology[cpu].cluster_id = topology_id;
 		topology_id = find_acpi_cpu_topology_package(cpu);
 		cpu_topology[cpu].package_id = topology_id;
 
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index 4ae9335..8646a93 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -737,6 +737,66 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
 }
 
 /**
+ * find_acpi_cpu_topology_cluster() - Determine a unique CPU cluster value
+ * @cpu: Kernel logical CPU number
+ *
+ * Determine a topology unique cluster ID for the given CPU/thread.
+ * This ID can then be used to group peers, which will have matching ids.
+ *
+ * The cluster, if present is the level of topology above CPUs. In a
+ * multi-thread CPU, it will be the level above the CPU, not the thread.
+ * It may not exist in single CPU systems. In simple multi-CPU systems,
+ * it may be equal to the package topology level.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found
+ * or there is no toplogy level above the CPU..
+ * Otherwise returns a value which represents the package for this CPU.
+ */
+
+int find_acpi_cpu_topology_cluster(unsigned int cpu)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+	struct acpi_pptt_processor *cpu_node, *cluster_node;
+	int retval;
+	int is_thread;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return -ENOENT;
+	}
+	cpu_node = acpi_find_processor_node(table, cpu);
+	if (cpu_node == NULL || !cpu_node->parent) {
+		retval = -ENOENT;
+		goto put_table;
+	}
+
+	is_thread = cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD;
+	cluster_node = fetch_pptt_node(table, cpu_node->parent);
+	if (cluster_node == NULL) {
+		retval = -ENOENT;
+		goto put_table;
+	}
+	if (is_thread) {
+		if (!cluster_node->parent) {
+			retval = -ENOENT;
+			goto put_table;
+		}
+		cluster_node = fetch_pptt_node(table, cluster_node->parent);
+		if (cluster_node == NULL) {
+			retval = -ENOENT;
+			goto put_table;
+		}
+	}
+	retval = ACPI_PTR_DIFF(cluster_node, table);
+put_table:
+	acpi_put_table(table);
+
+	return retval;
+}
+
+/**
  * find_acpi_cpu_topology_hetero_id() - Get a core architecture tag
  * @cpu: Kernel logical CPU number
  *
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index de8587c..3079232 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -506,6 +506,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return core_mask;
 }
 
+const struct cpumask *cpu_clustergroup_mask(int cpu)
+{
+	return &cpu_topology[cpu].cluster_sibling;
+}
+
 void update_siblings_masks(unsigned int cpuid)
 {
 	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
@@ -523,6 +528,11 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
+		if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
+			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
+			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
+		}
+
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
 
@@ -541,6 +551,9 @@ static void clear_cpu_topology(int cpu)
 	cpumask_clear(&cpu_topo->llc_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
 
+	cpumask_clear(&cpu_topo->cluster_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->cluster_sibling);
+
 	cpumask_clear(&cpu_topo->core_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
 	cpumask_clear(&cpu_topo->thread_sibling);
@@ -571,6 +584,7 @@ void remove_cpu_topology(unsigned int cpu)
 		cpumask_clear_cpu(cpu, topology_core_cpumask(sibling));
 	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+
 	for_each_cpu(sibling, topology_llc_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_llc_cpumask(sibling));
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 4d254fc..7157ac0 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -46,6 +46,9 @@ static DEVICE_ATTR_RO(physical_package_id);
 define_id_show_func(die_id);
 static DEVICE_ATTR_RO(die_id);
 
+define_id_show_func(cluster_id);
+static DEVICE_ATTR_RO(cluster_id);
+
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
 
@@ -61,6 +64,10 @@ define_siblings_show_func(core_siblings, core_cpumask);
 static DEVICE_ATTR_RO(core_siblings);
 static DEVICE_ATTR_RO(core_siblings_list);
 
+define_siblings_show_func(cluster_cpus, cluster_cpumask);
+static DEVICE_ATTR_RO(cluster_cpus);
+static DEVICE_ATTR_RO(cluster_cpus_list);
+
 define_siblings_show_func(die_cpus, die_cpumask);
 static DEVICE_ATTR_RO(die_cpus);
 static DEVICE_ATTR_RO(die_cpus_list);
@@ -88,6 +95,7 @@ static DEVICE_ATTR_RO(drawer_siblings_list);
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
 	&dev_attr_die_id.attr,
+	&dev_attr_cluster_id.attr,
 	&dev_attr_core_id.attr,
 	&dev_attr_thread_siblings.attr,
 	&dev_attr_thread_siblings_list.attr,
@@ -95,6 +103,8 @@ static struct attribute *default_attrs[] = {
 	&dev_attr_core_cpus_list.attr,
 	&dev_attr_core_siblings.attr,
 	&dev_attr_core_siblings_list.attr,
+	&dev_attr_cluster_cpus.attr,
+	&dev_attr_cluster_cpus_list.attr,
 	&dev_attr_die_cpus.attr,
 	&dev_attr_die_cpus_list.attr,
 	&dev_attr_package_cpus.attr,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 2630c2e..8f603cd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1325,6 +1325,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
+int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
@@ -1337,6 +1338,10 @@ static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
 {
 	return -EINVAL;
 }
+static inline int find_acpi_cpu_topology_cluster(unsigned int cpu)
+{
+	return -EINVAL;
+}
 static inline int find_acpi_cpu_topology_package(unsigned int cpu)
 {
 	return -EINVAL;
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 0f6cd6b..987c7ea 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -49,10 +49,12 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
 struct cpu_topology {
 	int thread_id;
 	int core_id;
+	int cluster_id;
 	int package_id;
 	int llc_id;
 	cpumask_t thread_sibling;
 	cpumask_t core_sibling;
+	cpumask_t cluster_sibling;
 	cpumask_t llc_sibling;
 };
 
@@ -60,13 +62,16 @@ struct cpu_topology {
 extern struct cpu_topology cpu_topology[NR_CPUS];
 
 #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
+#define topology_cluster_id(cpu)	(cpu_topology[cpu].cluster_id)
 #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
+#define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
 #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
 void init_cpu_topology(void);
 void store_cpu_topology(unsigned int cpuid);
 const struct cpumask *cpu_coregroup_mask(int cpu);
+const struct cpumask *cpu_clustergroup_mask(int cpu);
 void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
diff --git a/include/linux/topology.h b/include/linux/topology.h
index ad03df1..bf2cc3c 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -185,6 +185,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_die_id
 #define topology_die_id(cpu)			((void)(cpu), -1)
 #endif
+#ifndef topology_cluster_id
+#define topology_cluster_id(cpu)		((void)(cpu), -1)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
@@ -194,6 +197,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_core_cpumask
 #define topology_core_cpumask(cpu)		cpumask_of(cpu)
 #endif
+#ifndef topology_cluster_cpumask
+#define topology_cluster_cpumask(cpu)		cpumask_of(cpu)
+#endif
 #ifndef topology_die_cpumask
 #define topology_die_cpumask(cpu)		cpumask_of(cpu)
 #endif
-- 
2.7.4

