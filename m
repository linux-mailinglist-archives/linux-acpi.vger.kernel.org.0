Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7E2EBB1D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jan 2021 09:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbhAFIg3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jan 2021 03:36:29 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9716 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIg2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jan 2021 03:36:28 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D9jMv1QVgzl0mh;
        Wed,  6 Jan 2021 16:34:35 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 16:35:34 +0800
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
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and add cluster scheduler
Date:   Wed, 6 Jan 2021 21:30:24 +1300
Message-ID: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
cluster has 4 cpus. All clusters share L3 cache data while each cluster
has local L3 tag. On the other hand, each cluster will share some
internal system bus. This means cache is much more affine inside one cluster
than across clusters.

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



Through the following small program, you can see the performance impact of
running it in one cluster and across two clusters:

struct foo {
        int x;
        int y;
} f;

void *thread1_fun(void *param)
{
        int s = 0;
        for (int i = 0; i < 0xfffffff; i++)
                s += f.x;
}

void *thread2_fun(void *param)
{
        int s = 0;
        for (int i = 0; i < 0xfffffff; i++)
                f.y++;
}

int main(int argc, char **argv)
{
        pthread_t tid1, tid2;

        pthread_create(&tid1, NULL, thread1_fun, NULL);
        pthread_create(&tid2, NULL, thread2_fun, NULL);
        pthread_join(tid1, NULL);
        pthread_join(tid2, NULL);
}

While running this program in one cluster, it takes:
$ time taskset -c 0,1 ./a.out 
real	0m0.832s
user	0m1.649s
sys	0m0.004s

As a contrast, it takes much more time if we run the same program
in two clusters:
$ time taskset -c 0,4 ./a.out 
real	0m1.133s
user	0m1.960s
sys	0m0.000s

0.832/1.133 = 73%, it is a huge difference.

Also, hackbench running on 4 cpus in single one cluster and 4 cpus in
different clusters also shows a large contrast:
* inside a cluster:
root@ubuntu:~# taskset -c 0,1,2,3 hackbench -p -T -l 20000 -g 1
Running in threaded mode with 1 groups using 40 file descriptors each
(== 40 tasks)
Each sender will pass 20000 messages of 100 bytes
Time: 4.285

* across clusters:
root@ubuntu:~# taskset -c 0,4,8,12 hackbench -p -T -l 20000 -g 1
Running in threaded mode with 1 groups using 40 file descriptors each
(== 40 tasks)
Each sender will pass 20000 messages of 100 bytes
Time: 5.524

The score is 4.285 vs 5.524, shorter time means better performance.

All these testing implies that we should let the Linux scheduler use
this topology to make better load balancing and WAKE_AFFINE decisions.
However, the current scheduler totally has no idea of clusters.

This patchset exposed the cluster topology first, then added the sched
domain for cluster. While it is named as "cluster", architectures and
machines can define the exact meaning of cluster as long as they have
some resources sharing under llc and they can leverage the affinity
of this resource to achive better scheduling performance.

-v3:
 - rebased againest 5.11-rc2
 - with respect to the comments of Valentin Schneider, Peter Zijlstra,
   Vincent Guittot and Mel Gorman etc.
  * moved the scheduler changes from arm64 to the common place for all
    architectures.
  * added SD_SHARE_CLS_RESOURCES sd_flags specifying the sched_domain
    where select_idle_cpu() should begin to scan from
  * removed redundant select_idle_cluster() function since all code is
    in select_idle_cpu() now. it also avoided scanning cluster cpus
    twice in v2 code;
  * redo the hackbench in one numa after the above changes

Valentin suggested that select_idle_cpu() could begin to scan from
domain with SD_SHARE_PKG_RESOURCES. Changing like this might be too
aggressive and limit the spreading of tasks. Thus, this patch lets
the architectures and machines to decide where to start by adding
a new SD_SHARE_CLS_RESOURCES.

Barry Song (1):
  scheduler: add scheduler level for clusters

Jonathan Cameron (1):
  topology: Represent clusters of CPUs within a die.

 Documentation/admin-guide/cputopology.rst | 26 +++++++++++---
 arch/arm64/Kconfig                        |  7 ++++
 arch/arm64/kernel/topology.c              |  2 ++
 drivers/acpi/pptt.c                       | 60 +++++++++++++++++++++++++++++++
 drivers/base/arch_topology.c              | 14 ++++++++
 drivers/base/topology.c                   | 10 ++++++
 include/linux/acpi.h                      |  5 +++
 include/linux/arch_topology.h             |  5 +++
 include/linux/sched/sd_flags.h            |  9 +++++
 include/linux/sched/topology.h            |  7 ++++
 include/linux/topology.h                  | 13 +++++++
 kernel/sched/fair.c                       | 27 ++++++++++----
 kernel/sched/topology.c                   |  6 ++++
 13 files changed, 181 insertions(+), 10 deletions(-)

-- 
2.7.4

