Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD2416E3D
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 10:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbhIXIxT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 04:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244904AbhIXIxS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Sep 2021 04:53:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B253DC061756;
        Fri, 24 Sep 2021 01:51:45 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so9118126pjb.2;
        Fri, 24 Sep 2021 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C9AKGBcju/7OuZ54S7xN7fDD10tqeR8+pDrgXCrPZoI=;
        b=dgnG5noeJrUkRZZJyAX7N8bdQQq21HqFsN22urpPIjj7WoMIpZQpJfBVTz8HBPaWSn
         peUkLqk4DksFIb0nBuG8yti4MS09Qkb/8x3M9t28FcI5g89TAFXPMMYNFjSGqEzuG326
         En9WNKLu9RlE2iT5u3DClbacrqu1ZPEwJ8Thsm0N8QU1daiR1Hgp2y6Na2eU3P4cQLH6
         k67vxVo1ZIYbLrKL9AJFXzMahWTx8P6Czi8E4JSUrxz6MEnF1VqnuMqKsvSSe1/LzRYo
         n28Uoeiw9hYN0FPO3mInyX55DmLtCvl5iyU3GXM/NvA/rBeVrO2PZqVE4CAJUtPkSGWv
         pT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C9AKGBcju/7OuZ54S7xN7fDD10tqeR8+pDrgXCrPZoI=;
        b=otJZE0MatQ7zAmyTB+Exw6BwUSRsMqiwAkMJs8FA7CYUJO0ctzO8nkRM54u1iVCGhy
         PNQAKgX2KRnY5qslliLFqPXCvkTOfocv4DMncm3U1jVw5EC9JLzUGXPMr9Zlr9FD6tqI
         plk+bEk+ctpG5zE2PFPvdWe2WptIqxbGWGzkupVoWQaTGW6k6aou5Et/+s+JbY6fJ3rF
         p1BmRO/rVBwCP+j7fHgocbGkrGx3wKWsAkykJswCrd0oj72yQQ65PdfcGh4x6JfjQiPV
         CXQL1DfpThoT2e8/NzhabsJCFN6IU0+CSLzG36iai8emN1JzwzSTGFnmxozLL9m/kAOD
         A1dw==
X-Gm-Message-State: AOAM531U2g66i1By/flcn0luFQdzHDyJGzVH6Gx4c/FMozCUAruCSINI
        DCMKy6knsnbL/4T/bz1or1Y=
X-Google-Smtp-Source: ABdhPJyq+axtfs1YDaWt+AEtE7iUzRDhu0osHvUtaCSQgiseyZzUEj1igcktTRNo4b+wLG10gqOLHQ==
X-Received: by 2002:a17:90a:de0f:: with SMTP id m15mr952452pjv.114.1632473505222;
        Fri, 24 Sep 2021 01:51:45 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8916:5000:cad3:ec9e:d66f:102d])
        by smtp.gmail.com with ESMTPSA id t15sm9188362pgi.80.2021.09.24.01.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 01:51:44 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     aubrey.li@linux.intel.com, bp@alien8.de, bristot@redhat.com,
        bsegall@google.com, catalin.marinas@arm.com,
        gregkh@linuxfoundation.org, guodong.xu@linaro.org, hpa@zytor.com,
        jonathan.cameron@huawei.com, juri.lelli@redhat.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        mark.rutland@arm.com, mgorman@suse.de, msys.mizuma@gmail.com,
        prime.zeng@hisilicon.com, rjw@rjwysocki.net, rostedt@goodmis.org,
        song.bao.hua@hisilicon.com, sudeep.holla@arm.com,
        tglx@linutronix.de, rafael@kernel.org, tim.c.chen@linux.intel.com,
        valentin.schneider@arm.com, will@kernel.org, x86@kernel.org,
        yangyicong@huawei.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH RESEND 1/3] topology: Represent clusters of CPUs within a die
Date:   Fri, 24 Sep 2021 20:51:02 +1200
Message-Id: <20210924085104.44806-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924085104.44806-1-21cnbao@gmail.com>
References: <20210924085104.44806-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For example Kunpeng 920 has 6 or 8 clusters in each NUMA node, and each
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

That means spreading tasks among clusters will bring more bandwidth
while packing tasks within one cluster will lead to smaller cache
synchronization latency. So both kernel and userspace will have
a chance to leverage this topology to deploy tasks accordingly to
achieve either smaller cache latency within one cluster or an even
distribution of load among clusters for higher throughput.

This patch exposes cluster topology to both kernel and userspace.
Libraried like hwloc will know cluster by cluster_cpus and related
sysfs attributes. PoC of HWLOC support at [2].

Note this patch only handle the ACPI case.

Special consideration is needed for SMT processors, where it is
necessary to move 2 levels up the hierarchy from the leaf nodes
(thus skipping the processor core level).

Note that arm64 / ACPI does not provide any means of identifying
a die level in the topology but that may be unrelate to the cluster
level.

[1] ACPI Specification 6.3 - section 5.2.29.1 processor hierarchy node
    structure (Type 0)
[2] https://github.com/hisilicon/hwloc/tree/linux-cluster

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 Documentation/ABI/stable/sysfs-devices-system-cpu | 15 +++++
 Documentation/admin-guide/cputopology.rst         | 12 ++--
 arch/arm64/kernel/topology.c                      |  2 +
 drivers/acpi/pptt.c                               | 67 +++++++++++++++++++++++
 drivers/base/arch_topology.c                      | 14 +++++
 drivers/base/topology.c                           | 10 ++++
 include/linux/acpi.h                              |  5 ++
 include/linux/arch_topology.h                     |  5 ++
 include/linux/topology.h                          |  6 ++
 9 files changed, 132 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
index 516dafe..3965ce5 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-cpu
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -42,6 +42,12 @@ Description:    the CPU core ID of cpuX. Typically it is the hardware platform's
                 architecture and platform dependent.
 Values:         integer
 
+What:           /sys/devices/system/cpu/cpuX/topology/cluster_id
+Description:    the cluster ID of cpuX.  Typically it is the hardware platform's
+                identifier (rather than the kernel's). The actual value is
+                architecture and platform dependent.
+Values:         integer
+
 What:           /sys/devices/system/cpu/cpuX/topology/book_id
 Description:    the book ID of cpuX. Typically it is the hardware platform's
                 identifier (rather than the kernel's). The actual value is
@@ -85,6 +91,15 @@ Description:    human-readable list of CPUs within the same die.
                 The format is like 0-3, 8-11, 14,17.
 Values:         decimal list.
 
+What:           /sys/devices/system/cpu/cpuX/topology/cluster_cpus
+Description:    internal kernel map of CPUs within the same cluster.
+Values:         hexadecimal bitmask.
+
+What:           /sys/devices/system/cpu/cpuX/topology/cluster_cpus_list
+Description:    human-readable list of CPUs within the same cluster.
+                The format is like 0-3, 8-11, 14,17.
+Values:         decimal list.
+
 What:           /sys/devices/system/cpu/cpuX/topology/book_siblings
 Description:    internal kernel map of cpuX's hardware threads within the same
                 book_id. it's only used on s390.
diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
index b085dba..6b62e18 100644
--- a/Documentation/admin-guide/cputopology.rst
+++ b/Documentation/admin-guide/cputopology.rst
@@ -19,11 +19,13 @@ these macros in include/asm-XXX/topology.h::
 
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
@@ -39,10 +41,12 @@ not defined by include/asm-XXX/topology.h:
 
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
index 4dd14a6..9ab78ad 100644
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
index fe69dc5..701f61c 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -747,6 +747,73 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
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
+	u32 acpi_cpu_id;
+	int retval;
+	int is_thread;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		acpi_pptt_warn_missing();
+		return -ENOENT;
+	}
+
+	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
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
+	if (cluster_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
+		retval = cluster_node->acpi_processor_id;
+	else
+		retval = ACPI_PTR_DIFF(cluster_node, table);
+
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
index 4340766..7cb31d9 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -600,6 +600,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
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
@@ -617,6 +622,11 @@ void update_siblings_masks(unsigned int cpuid)
 		if (cpuid_topo->package_id != cpu_topo->package_id)
 			continue;
 
+		if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
+			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
+			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
+		}
+
 		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
 		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
 
@@ -635,6 +645,9 @@ static void clear_cpu_topology(int cpu)
 	cpumask_clear(&cpu_topo->llc_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
 
+	cpumask_clear(&cpu_topo->cluster_sibling);
+	cpumask_set_cpu(cpu, &cpu_topo->cluster_sibling);
+
 	cpumask_clear(&cpu_topo->core_sibling);
 	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
 	cpumask_clear(&cpu_topo->thread_sibling);
@@ -650,6 +663,7 @@ void __init reset_cpu_topology(void)
 
 		cpu_topo->thread_id = -1;
 		cpu_topo->core_id = -1;
+		cpu_topo->cluster_id = -1;
 		cpu_topo->package_id = -1;
 		cpu_topo->llc_id = -1;
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 43c0940..8f2b641 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -48,6 +48,9 @@
 define_id_show_func(die_id);
 static DEVICE_ATTR_RO(die_id);
 
+define_id_show_func(cluster_id);
+static DEVICE_ATTR_RO(cluster_id);
+
 define_id_show_func(core_id);
 static DEVICE_ATTR_RO(core_id);
 
@@ -63,6 +66,10 @@
 static BIN_ATTR_RO(core_siblings, 0);
 static BIN_ATTR_RO(core_siblings_list, 0);
 
+define_siblings_read_func(cluster_cpus, cluster_cpumask);
+static BIN_ATTR_RO(cluster_cpus, 0);
+static BIN_ATTR_RO(cluster_cpus_list, 0);
+
 define_siblings_read_func(die_cpus, die_cpumask);
 static BIN_ATTR_RO(die_cpus, 0);
 static BIN_ATTR_RO(die_cpus_list, 0);
@@ -94,6 +101,8 @@
 	&bin_attr_thread_siblings_list,
 	&bin_attr_core_siblings,
 	&bin_attr_core_siblings_list,
+	&bin_attr_cluster_cpus,
+	&bin_attr_cluster_cpus_list,
 	&bin_attr_die_cpus,
 	&bin_attr_die_cpus_list,
 	&bin_attr_package_cpus,
@@ -112,6 +121,7 @@
 static struct attribute *default_attrs[] = {
 	&dev_attr_physical_package_id.attr,
 	&dev_attr_die_id.attr,
+	&dev_attr_cluster_id.attr,
 	&dev_attr_core_id.attr,
 #ifdef CONFIG_SCHED_BOOK
 	&dev_attr_book_id.attr,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 974d497..fbc2146 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1353,6 +1353,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
 #ifdef CONFIG_ACPI_PPTT
 int acpi_pptt_cpu_is_thread(unsigned int cpu);
 int find_acpi_cpu_topology(unsigned int cpu, int level);
+int find_acpi_cpu_topology_cluster(unsigned int cpu);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
@@ -1365,6 +1366,10 @@ static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
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
index f180240..b97cea8 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -62,10 +62,12 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
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
 
@@ -73,13 +75,16 @@ struct cpu_topology {
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
index 7634cd7..80d27d7 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -186,6 +186,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_die_id
 #define topology_die_id(cpu)			((void)(cpu), -1)
 #endif
+#ifndef topology_cluster_id
+#define topology_cluster_id(cpu)		((void)(cpu), -1)
+#endif
 #ifndef topology_core_id
 #define topology_core_id(cpu)			((void)(cpu), 0)
 #endif
@@ -195,6 +198,9 @@ static inline int cpu_to_mem(int cpu)
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
1.8.3.1

