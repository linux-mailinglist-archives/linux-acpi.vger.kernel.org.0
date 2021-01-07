Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A22EE9AD
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbhAGXSk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 18:18:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:20102 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbhAGXSk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 18:18:40 -0500
IronPort-SDR: UaB+I8Q2kOrtAHdGn6DUYuVQsgXCZ/C+SruEEnZcDBIMYjpG2EIM3mp3NsnSMsBXs8GFedMy/X
 YeHMauuzzKOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="241585635"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="241585635"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 15:16:54 -0800
IronPort-SDR: 2Tr0ctpCHQ8p2W3bt4GNjJ6sRfyBtXHlTmP6rwxju8Ck9s9/P07uMhZ96mC15PPkQ1e8A0M8Sh
 khm5ESKyT4vA==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="351456963"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.75.205])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 15:16:53 -0800
Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
To:     Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        lenb@kernel.org, gregkh@linuxfoundation.org,
        jonathan.cameron@huawei.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@openeuler.org,
        xuwei5@huawei.com, prime.zeng@hisilicon.com, tiantao6@hisilicon.com
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
Date:   Thu, 7 Jan 2021 15:16:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 1/6/21 12:30 AM, Barry Song wrote:
> ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
> cluster has 4 cpus. All clusters share L3 cache data while each cluster
> has local L3 tag. On the other hand, each cluster will share some
> internal system bus. This means cache is much more affine inside one cluster
> than across clusters.
> 
>     +-----------------------------------+                          +---------+
>     |  +------+    +------+            +---------------------------+         |
>     |  | CPU0 |    | cpu1 |             |    +-----------+         |         |
>     |  +------+    +------+             |    |           |         |         |
>     |                                   +----+    L3     |         |         |
>     |  +------+    +------+   cluster   |    |    tag    |         |         |
>     |  | CPU2 |    | CPU3 |             |    |           |         |         |
>     |  +------+    +------+             |    +-----------+         |         |
>     |                                   |                          |         |
>     +-----------------------------------+                          |         |
>     +-----------------------------------+                          |         |
>     |  +------+    +------+             +--------------------------+         |
>     |  |      |    |      |             |    +-----------+         |         |
>     |  +------+    +------+             |    |           |         |         |
>     |                                   |    |    L3     |         |         |
>     |  +------+    +------+             +----+    tag    |         |         |
>     |  |      |    |      |             |    |           |         |         |
>     |  +------+    +------+             |    +-----------+         |         |
>     |                                   |                          |         |
>     +-----------------------------------+                          |   L3    |
>                                                                    |   data  |
>     +-----------------------------------+                          |         |
>     |  +------+    +------+             |    +-----------+         |         |
>     |  |      |    |      |             |    |           |         |         |
>     |  +------+    +------+             +----+    L3     |         |         |
>     |                                   |    |    tag    |         |         |
>     |  +------+    +------+             |    |           |         |         |
>     |  |      |    |      |            ++    +-----------+         |         |
>     |  +------+    +------+            |---------------------------+         |
>     +-----------------------------------|                          |         |
>     +-----------------------------------|                          |         |
>     |  +------+    +------+            +---------------------------+         |
>     |  |      |    |      |             |    +-----------+         |         |
>     |  +------+    +------+             |    |           |         |         |
>     |                                   +----+    L3     |         |         |
>     |  +------+    +------+             |    |    tag    |         |         |
>     |  |      |    |      |             |    |           |         |         |
>     |  +------+    +------+             |    +-----------+         |         |
>     |                                   |                          |         |
>     +-----------------------------------+                          |         |
>     +-----------------------------------+                          |         |
>     |  +------+    +------+             +--------------------------+         |
>     |  |      |    |      |             |   +-----------+          |         |
>     |  +------+    +------+             |   |           |          |         |
> 
> 

There is a similar need for clustering in x86.  Some x86 cores could share L2 caches that
is similar to the cluster in Kupeng 920 (e.g. on Jacobsville there are 6 clusters
of 4 Atom cores, each cluster sharing a separate L2, and 24 cores sharing L3).  
Having a sched domain at the L2 cluster helps spread load among 
L2 domains.  This will reduce L2 cache contention and help with
performance for low to moderate load scenarios.

The cluster detection mechanism will need
to be based on L2 cache sharing in this case.  I suggest making the 
cluster detection to be CPU architecture dependent so both ARM64 and x86 use cases
can be accommodated.

Attached below are two RFC patches for creating x86 L2
cache sched domain, sans the idle cpu selection on wake up code.  It is
similar enough in concept to Barry's patch that we should have a 
single patchset that accommodates both use cases.

Thanks.

Tim


From e0e7e42e1a033c9634723ff1dc80b426deeec1e9 Mon Sep 17 00:00:00 2001
Message-Id: <e0e7e42e1a033c9634723ff1dc80b426deeec1e9.1609970726.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1609970726.git.tim.c.chen@linux.intel.com>
References: <cover.1609970726.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Wed, 19 Aug 2020 16:22:35 -0700
Subject: [RFC PATCH 1/2] sched: Add L2 cache cpu mask

There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce
is shared among a group of cores instead of being exclusive
to one single core.

To prevent oversubscription of L2 cache, load could be
balanced between such L2 domains.

Add CPU masks of CPUs sharing the L2 cache so we can build such
L2 scheduler domain for load balancing at the L2 level.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index f4234575f3fd..e35f5f55cb15 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -103,6 +103,7 @@ static inline void setup_node_to_cpumask_map(void) { }
 #include <asm-generic/topology.h>
 
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
+extern const struct cpumask *cpu_l2group_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 27aa04a95702..8ba0b505f020 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -56,6 +56,7 @@
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
+#include <linux/cacheinfo.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -643,6 +644,17 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return cpu_llc_shared_mask(cpu);
 }
 
+const struct cpumask *cpu_l2group_mask(int cpu)
+{
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+
+	/* Sanity check for presence of L2, leaf index 2 */
+	if (ci->num_leaves < 3)
+		return topology_sibling_cpumask(cpu);
+
+	return &ci->info_list[2].shared_cpu_map;
+}
+
 static void impress_friends(void)
 {
 	int cpu;
-- 
2.20.1



From bdc17e2c46bfa5a96edeafde06ead46308bf73e3 Mon Sep 17 00:00:00 2001
Message-Id: <bdc17e2c46bfa5a96edeafde06ead46308bf73e3.1609970726.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1609970726.git.tim.c.chen@linux.intel.com>
References: <cover.1609970726.git.tim.c.chen@linux.intel.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Fri, 21 Aug 2020 17:01:22 -0700
Subject: [RFC PATCH 2/2] sched: Build L2 cache scheduler domain for x86

To prevent oversubscription of the L2 cache, load should be balanced
between L2 cache domains.

Add new scheduler domain at the L2 cache level for x86.

On benchmark such as SPECrate mcf test, this change provides a
boost to performance on medium load system on Jacobsville.

Note that this added domain level will increase migrations
between CPUs.  So this is not necessarily a universal win if
the migration cost of balancing L2 load outweigh the benefit
from reduced L2 contention.  This change tends to benefit CPU bound
threads that get moved around much less.

Note also that if the L2 sched domain is the same as the SMT sched domain
(i.e. 1 core), it will be degenerate and not be added unnecessarily when
sched domains are being built at the cpu_attach_domain phase.  This new
sched domain will only be added when L2 is shared among CPU cores.

The L2 cache information is detected after the initial build of scheduler
domains during boot.  So it is necessary to rebuild the sched domains
after all the CPUs have been fully brought up.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/Kconfig                | 15 +++++++++++++++
 arch/x86/kernel/cpu/cacheinfo.c |  3 +++
 arch/x86/kernel/smpboot.c       | 14 ++++++++++++++
 init/main.c                     |  3 +++
 4 files changed, 35 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..97775ec16e72 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1014,6 +1014,21 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
+config SCHED_MC_L2
+	def_bool n
+	prompt "Multi-core scheduler L2 scheduler domain support"
+	depends on SCHED_MC && SMP
+	help
+	  Adding level 2 cache scheduler domain will have CPU scheduler
+	  balance load between L2 caches. This reduces oversubscription
+	  of L2 cahce on system that has multiple CPU cores sharing
+	  a L2 cache.  This option benefits system with mostly CPU
+	  bound tasks.	For tasks that wake up and sleep frequently,
+	  this option does increase the frequency of task migraions and
+	  increased load balancing latency.
+
+	  If unsure say N here.
+
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
 	depends on SCHED_MC && CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c7503be92f35..fb3facab58d0 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1030,6 +1030,9 @@ static int __populate_cache_leaves(unsigned int cpu)
 		__cache_cpumap_setup(cpu, idx, &id4_regs);
 	}
 	this_cpu_ci->cpu_map_populated = true;
+#ifdef CONFIG_SCHED_MC_L2
+	x86_topology_update = true;
+#endif
 
 	return 0;
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8ba0b505f020..80cdccd1bcab 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -528,6 +528,14 @@ static int x86_core_flags(void)
 {
 	return cpu_core_flags() | x86_sched_itmt_flags();
 }
+
+#ifdef CONFIG_SCHED_MC_L2
+static int x86_l2mc_flags(void)
+{
+	return cpu_core_flags() | x86_sched_itmt_flags();
+}
+#endif
+
 #endif
 #ifdef CONFIG_SCHED_SMT
 static int x86_smt_flags(void)
@@ -542,6 +550,9 @@ static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
 #ifdef CONFIG_SCHED_MC
+#ifdef CONFIG_SCHED_MC_L2
+	{ cpu_l2group_mask, x86_l2mc_flags, SD_INIT_NAME(L2MC) },
+#endif
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
 	{ NULL, },
@@ -552,6 +563,9 @@ static struct sched_domain_topology_level x86_topology[] = {
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
 #ifdef CONFIG_SCHED_MC
+#ifdef CONFIG_SCHED_MC_L2
+	{ cpu_l2group_mask, x86_l2mc_flags, SD_INIT_NAME(L2MC) },
+#endif
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
 	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
diff --git a/init/main.c b/init/main.c
index ae78fb68d231..f4f814f8a127 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1405,6 +1405,9 @@ static int __ref kernel_init(void *unused)
 	ftrace_free_init_mem();
 	free_initmem();
 	mark_readonly();
+#ifdef CONFIG_SCHED_MC_L2
+	rebuild_sched_domains();
+#endif
 
 	/*
 	 * Kernel mappings are now finalized - update the userspace page-table
-- 
2.20.1

