Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFBA364F70
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 02:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhDTA0d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 20:26:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16136 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhDTA0c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Apr 2021 20:26:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FPPXj076pzmdWf;
        Tue, 20 Apr 2021 08:23:01 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.79) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 20 Apr 2021 08:25:52 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <tim.c.chen@linux.intel.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rjw@rjwysocki.net>,
        <vincent.guittot@linaro.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <lenb@kernel.org>, <peterz@infradead.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <msys.mizuma@gmail.com>, <valentin.schneider@arm.com>,
        <gregkh@linuxfoundation.org>, <jonathan.cameron@huawei.com>,
        <juri.lelli@redhat.com>, <mark.rutland@arm.com>,
        <sudeep.holla@arm.com>, <aubrey.li@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <x86@kernel.org>, <xuwei5@huawei.com>, <prime.zeng@hisilicon.com>,
        <guodong.xu@linaro.org>, <yangyicong@huawei.com>,
        <liguozhu@hisilicon.com>, <linuxarm@openeuler.org>,
        <hpa@zytor.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [RFC PATCH v6 0/4] scheduler: expose the topology of clusters and add cluster scheduler
Date:   Tue, 20 Apr 2021 12:18:40 +1200
Message-ID: <20210420001844.9116-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.79]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ARM64 server chip Kunpeng 920 has 6 or 8 clusters in each NUMA node, and each
cluster has 4 cpus. All clusters share L3 cache data while each cluster has
local L3 tag. On the other hand, each cluster will share some internal system
bus. This means cache is much more affine inside one cluster than across
clusters.

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


There is a similar need for clustering in x86.  Some x86 cores could share L2 caches
that is similar to the cluster in Kupeng 920 (e.g. on Jacobsville there are 6 clusters
of 4 Atom cores, each cluster sharing a separate L2, and 24 cores sharing L3).  

Having a sched_domain for clusters will bring two aspects of improvement:
1. spreading unrelated tasks among clusters, which decreases the contention of resources
and improve the throughput.
unrelated tasks might be put randomly without cluster sched_domain:
+-------------------+            +-----------------+
| +----+   +----+   |            |                 |
| |task|   |task|   |            |                 |
| |1   |   |2   |   |            |                 |
| +----+   +----+   |            |                 |
|                   |            |                 |
|       cluster1    |            |     cluster2    |
+-------------------+            +-----------------+

but with cluster sched_domain, they are likely to spread due to LB:
+-------------------+            +-----------------+
| +----+            |            | +----+          |
| |task|            |            | |task|          |
| |1   |            |            | |2   |          |
| +----+            |            | +----+          |
|                   |            |                 |
|       cluster1    |            |     cluster2    |
+-------------------+            +-----------------+

2. gathering related tasks within a cluster, which improves the cache affinity of tasks
talking with each other.
Without cluster sched_domain, related tasks might be put randomly. In case task1-8 have
relationship as below:
Task1 talks with task5
Task2 talks with task6
Task3 talks with task7
Task4 talks with task8
With the tuning of select_idle_cpu() to scan local cluster first, those tasks might
get a chance to be gathered like:
+---------------------------+    +----------------------+
| +----+        +-----+     |    | +----+      +-----+  |
| |task|        |task |     |    | |task|      |task |  |
| |1   |        | 5   |     |    | |3   |      |7    |  |
| +----+        +-----+     |    | +----+      +-----+  |
|                           |    |                      |
|       cluster1            |    |     cluster2         |
|                           |    |                      |
|                           |    |                      |
| +-----+       +------+    |    | +-----+     +------+ |
| |task |       | task |    |    | |task |     |task  | |
| |2    |       |  6   |    |    | |4    |     |8     | |
| +-----+       +------+    |    | +-----+     +------+ |
+---------------------------+    +----------------------+
Otherwise, the result might be:
+---------------------------+    +----------------------+
| +----+        +-----+     |    | +----+      +-----+  |
| |task|        |task |     |    | |task|      |task |  |
| |1   |        | 2   |     |    | |5   |      |6    |  |
| +----+        +-----+     |    | +----+      +-----+  |
|                           |    |                      |
|       cluster1            |    |     cluster2         |
|                           |    |                      |
|                           |    |                      |
| +-----+       +------+    |    | +-----+     +------+ |
| |task |       | task |    |    | |task |     |task  | |
| |3    |       |  4   |    |    | |7    |     |8     | |
| +-----+       +------+    |    | +-----+     +------+ |
+---------------------------+    +----------------------+

-v6:
  * added topology_cluster_cpumask() for x86, code provided by Tim.

  * emulated a two-level spreading/packing heuristic by only scanning cluster
    in wake_affine path for tasks running in same LLC(also NUMA).

    This partially addressed Dietmar's comment in RFC v3:
    "In case we would like to further distinguish between llc-packing and
     even narrower (cluster or MC-L2)-packing, we would introduce a 2. level
     packing vs. spreading heuristic further down in sis().
   
     IMHO, Barry's current implementation doesn't do this right now. Instead
     he's trying to pack on cluster first and if not successful look further
     among the remaining llc CPUs for an idle CPU."

  * adjusted the hackbench parameter to make relatively low and high load.
    previous patchsets with "-f 10" ran under an extremely high load with
    hundreds of threads, which seems not real use cases.

    This also addressed Vincent's question in RFC v4:
    "In particular, I'm still not convinced that the modification of the wakeup
    path is the root of the hackbench improvement; especially with g=14 where
    there should not be much idle CPUs with 14*40 tasks on at most 32 CPUs."

-v5:
  * split "add scheduler level for clusters" into two patches to evaluate the
    impact of spreading and gathering separately;
  * add a tracepoint of select_idle_cpu for debug purpose; add bcc script in
    commit log;
  * add cluster_id = -1 in reset_cpu_topology()
  * rebased to tip/sched/core

-v4:
  * rebased to tip/sched/core with the latest unified code of select_idle_cpu
  * added Tim's patch for x86 Jacobsville
  * also added benchmark data of spreading unrelated tasks
  * avoided the iteration of sched_domain by moving to static_key(addressing
    Vincent's comment
  * used acpi_cpu_id for acpi_find_processor_node(addressing Masa's comment)

Barry Song (2):
  scheduler: add scheduler level for clusters
  scheduler: scan idle cpu in cluster for tasks within one LLC

Jonathan Cameron (1):
  topology: Represent clusters of CPUs within a die

Tim Chen (1):
  scheduler: Add cluster scheduler level for x86

 Documentation/admin-guide/cputopology.rst | 26 +++++++++++--
 arch/arm64/Kconfig                        |  7 ++++
 arch/arm64/kernel/topology.c              |  2 +
 arch/x86/Kconfig                          |  8 ++++
 arch/x86/include/asm/smp.h                |  7 ++++
 arch/x86/include/asm/topology.h           |  2 +
 arch/x86/kernel/cpu/cacheinfo.c           |  1 +
 arch/x86/kernel/cpu/common.c              |  3 ++
 arch/x86/kernel/smpboot.c                 | 43 ++++++++++++++++++++-
 block/blk-mq.c                            |  2 +-
 drivers/acpi/pptt.c                       | 63 +++++++++++++++++++++++++++++++
 drivers/base/arch_topology.c              | 15 ++++++++
 drivers/base/topology.c                   | 10 +++++
 include/linux/acpi.h                      |  5 +++
 include/linux/arch_topology.h             |  5 +++
 include/linux/sched/cluster.h             | 19 ++++++++++
 include/linux/sched/sd_flags.h            |  9 +++++
 include/linux/sched/topology.h            | 12 +++++-
 include/linux/topology.h                  | 13 +++++++
 kernel/sched/core.c                       | 29 ++++++++++++--
 kernel/sched/fair.c                       | 51 +++++++++++++++----------
 kernel/sched/sched.h                      |  4 ++
 kernel/sched/topology.c                   | 18 +++++++++
 23 files changed, 324 insertions(+), 30 deletions(-)
 create mode 100644 include/linux/sched/cluster.h

-- 
1.8.3.1

