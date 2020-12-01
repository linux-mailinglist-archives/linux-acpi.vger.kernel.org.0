Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D06D2C9586
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 04:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgLADE7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Nov 2020 22:04:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8539 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgLADE7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Nov 2020 22:04:59 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ClRkv3CD7zhXtD;
        Tue,  1 Dec 2020 11:03:51 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.198) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 11:04:07 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <valentin.schneider@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <gregkh@linuxfoundation.org>, <Jonathan.Cameron@huawei.com>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <prime.zeng@hisilicon.com>, Barry Song <song.bao.hua@hisilicon.com>
Subject: [RFC PATCH v2 0/2] scheduler: expose the topology of clusters and add cluster scheduler
Date:   Tue, 1 Dec 2020 15:59:42 +1300
Message-ID: <20201201025944.18260-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.198]
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


The presented illustration is still a simplification of what is actually
going on, but is a more accurate model than currently presented.

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

This implies that we should let the Linux scheduler use cluster topology to
make better load balancing and WAKE_AFFINE decisions. Unfortuantely, right
now, all cpu0-23 are treated equally in the current kernel running on
Kunpeng 920.

This patchset first exposes the topology, then add a new sched_domain
between smt and mc. The new sched_domain will influence the load balance
and wake_affine of the scheduler.

The code is still pretty much a proof-of-concept and need lots of benchmark
and tuning. However, a rough hackbench result shows

While running hackbench on one numa node(cpu0-cpu23), we may achieve 5%+
performance improvement with the new sched_domain.
While running hackbench on two numa nodes(cpu0-cpu47), we may achieve 49%+
performance improvement with the new sched_domain.

Although I believe there is still a lot to do, sending a RFC to get feedbacks
of community experts might be helpful for the next step.

Barry Song (1):
  scheduler: add scheduler level for clusters

Jonathan Cameron (1):
  topology: Represent clusters of CPUs within a die.

 Documentation/admin-guide/cputopology.rst | 26 +++++++++++---
 arch/arm64/Kconfig                        |  7 ++++
 arch/arm64/kernel/smp.c                   | 17 +++++++++
 arch/arm64/kernel/topology.c              |  2 ++
 drivers/acpi/pptt.c                       | 60 +++++++++++++++++++++++++++++++
 drivers/base/arch_topology.c              | 14 ++++++++
 drivers/base/topology.c                   | 10 ++++++
 include/linux/acpi.h                      |  5 +++ 
 include/linux/arch_topology.h             |  5 +++ 
 include/linux/topology.h                  | 13 +++++++
 kernel/sched/fair.c                       | 35 ++++++++++++++++++
 11 files changed, 190 insertions(+), 4 deletions(-)

-- 
2.7.4

