Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73534141A
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Mar 2021 05:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhCSEXq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Mar 2021 00:23:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13203 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSEXJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Mar 2021 00:23:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F1rKd3fhwzmZbk;
        Fri, 19 Mar 2021 12:20:37 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.211) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 19 Mar 2021 12:22:54 +0800
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
Subject: [RFC PATCH v5 0/4] scheduler: expose the topology of clusters and add cluster scheduler 
Date:   Fri, 19 Mar 2021 17:16:14 +1300
Message-ID: <20210319041618.14316-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.211]
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
Task1 wakes up task4
Task2 wakes up task5
Task3 wakes up task6
Task4 wakes up task7
With the tuning of select_idle_cpu() to scan local cluster first, those tasks might
get a chance to be gathered like:
+---------------------------+    +----------------------+
| +----+        +-----+     |    | +----+      +-----+  |
| |task|        |task |     |    | |task|      |task |  |
| |1   |        | 4   |     |    | |2   |      |5    |  |
| +----+        +-----+     |    | +----+      +-----+  |
|                           |    |                      |
|       cluster1            |    |     cluster2         |
|                           |    |                      |
|                           |    |                      |
| +-----+       +------+    |    | +-----+     +------+ |
| |task |       | task |    |    | |task |     |task  | |
| |3    |       |  6   |    |    | |4    |     |8     | |
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
  scheduler: scan idle cpu in cluster before scanning the whole llc

Jonathan Cameron (1):
  topology: Represent clusters of CPUs within a die

Tim Chen (1):
  scheduler: Add cluster scheduler level for x86

 Documentation/admin-guide/cputopology.rst | 26 +++++++++++--
 arch/arm64/Kconfig                        |  7 ++++
 arch/arm64/kernel/topology.c              |  2 +
 arch/x86/Kconfig                          |  8 ++++
 arch/x86/include/asm/smp.h                |  7 ++++
 arch/x86/include/asm/topology.h           |  1 +
 arch/x86/kernel/cpu/cacheinfo.c           |  1 +
 arch/x86/kernel/cpu/common.c              |  3 ++
 arch/x86/kernel/smpboot.c                 | 43 ++++++++++++++++++++-
 drivers/acpi/pptt.c                       | 63 +++++++++++++++++++++++++++++++
 drivers/base/arch_topology.c              | 15 ++++++++
 drivers/base/topology.c                   | 10 +++++
 include/linux/acpi.h                      |  5 +++
 include/linux/arch_topology.h             |  5 +++
 include/linux/sched/cluster.h             | 19 ++++++++++
 include/linux/sched/topology.h            |  7 ++++
 include/linux/topology.h                  | 13 +++++++
 include/trace/events/sched.h              | 22 +++++++++++
 kernel/sched/core.c                       | 20 ++++++++++
 kernel/sched/fair.c                       | 36 +++++++++++++++++-
 kernel/sched/sched.h                      |  1 +
 kernel/sched/topology.c                   |  5 +++
 22 files changed, 313 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/sched/cluster.h

-- 
1.8.3.1

