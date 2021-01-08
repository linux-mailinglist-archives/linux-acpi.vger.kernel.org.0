Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F312EFAA0
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 22:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbhAHVbV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 8 Jan 2021 16:31:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2301 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbhAHVbU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Jan 2021 16:31:20 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DCGQ64N4hz67XP8;
        Sat,  9 Jan 2021 05:26:54 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 8 Jan 2021 22:30:37 +0100
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 8 Jan 2021 21:30:36 +0000
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Sat, 9 Jan 2021 05:30:34 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
CC:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
Thread-Topic: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters
 and add cluster scheduler
Thread-Index: AQHW5AbteiV+M51D3k+7bMDug+Sb86ocSCyAgAELFICAAOgS8A==
Date:   Fri, 8 Jan 2021 21:30:34 +0000
Message-ID: <f15f8feb4e764c11a078ffd74f002a8d@hisilicon.com>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <20210108151241.GA47324@e123083-lin>
In-Reply-To: <20210108151241.GA47324@e123083-lin>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.246]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Morten Rasmussen [mailto:morten.rasmussen@arm.com]
> Sent: Saturday, January 9, 2021 4:13 AM
> To: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> valentin.schneider@arm.com; catalin.marinas@arm.com; will@kernel.org;
> rjw@rjwysocki.net; vincent.guittot@linaro.org; lenb@kernel.org;
> gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com;
> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
> mgorman@suse.de; mark.rutland@arm.com; sudeep.holla@arm.com;
> aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> linuxarm@openeuler.org; xuwei (O) <xuwei5@huawei.com>; Zengtao (B)
> <prime.zeng@hisilicon.com>; tiantao (H) <tiantao6@hisilicon.com>
> Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
> add cluster scheduler
> 
> On Thu, Jan 07, 2021 at 03:16:47PM -0800, Tim Chen wrote:
> > On 1/6/21 12:30 AM, Barry Song wrote:
> > > ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
> > > cluster has 4 cpus. All clusters share L3 cache data while each cluster
> > > has local L3 tag. On the other hand, each cluster will share some
> > > internal system bus. This means cache is much more affine inside one cluster
> > > than across clusters.
> >
> > There is a similar need for clustering in x86.  Some x86 cores could share
> L2 caches that
> > is similar to the cluster in Kupeng 920 (e.g. on Jacobsville there are 6 clusters
> > of 4 Atom cores, each cluster sharing a separate L2, and 24 cores sharing
> L3).
> > Having a sched domain at the L2 cluster helps spread load among
> > L2 domains.  This will reduce L2 cache contention and help with
> > performance for low to moderate load scenarios.
> 
> IIUC, you are arguing for the exact opposite behaviour, i.e. balancing
> between L2 caches while Barry is after consolidating tasks within the
> boundaries of a L3 tag cache. One helps cache utilization, the other
> communication latency between tasks. Am I missing something?

Morten, this is not true.

we are both actually looking for the same behavior. My patch also
has done the exact same behavior of spreading with Tim's patch.

Considering the below two cases:
Case 1. we have two tasks without any relationship running in a system with 2 clusters and 8 cpus.

Without the sched_domain of cluster, these two tasks might be put as below:
+-------------------+            +-----------------+
| +----+   +----+   |            |                 |
| |task|   |task|   |            |                 |
| |1   |   |2   |   |            |                 |
| +----+   +----+   |            |                 |
|                   |            |                 |
|       cluster1    |            |     cluster2    |
+-------------------+            +-----------------+
With the sched_domain of cluster, load balance will spread them as below:
+-------------------+            +-----------------+
| +----+            |            | +----+          |
| |task|            |            | |task|          |
| |1   |            |            | |2   |          |
| +----+            |            | +----+          |
|                   |            |                 |
|       cluster1    |            |     cluster2    |
+-------------------+            +-----------------+

Then task1 and tasks2 get more cache and decrease cache contention.
They will get better performance.

That is what my original patch also can make. And tim's patch
is also doing. Once we add a sched_domain, load balance will
get involved.


Case 2. we have 8 tasks, running in a system with 2 clusters and 8 cpus.
But they are working in 4 groups:
Task1 wakes up task4
Task2 wakes up task5
Task3 wakes up task6
Task4 wakes up task7

With my changing in select_idle_sibling, the WAKE_AFFINE mechanism will
try to put task1 and 4, task2 and 5, task3 and 6, task4 and 7 in same clusters rather
than putting all of them in the random one of the 8 cpus. However, the 8 tasks
are still spreading among the 8 cpus with my change in select_idle_sibling
as load balance is still working.

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

Let's consider the 3rd case, that one would be more tricky:

task1 and task2 have close relationship and they are waker-wakee pair.
With my current patch, select_idle_sidling() wants to put them in one
cluster, load balance wants to put them in two clusters. Load balance will win. 
Then maybe we need some same mechanism like adjusting numa imbalance:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/sched/fair.c?id=b396f52326de20
if we permit a light imbalance between clusters, select_idle_sidling()
will win. And task1 and task2 get better cache affinity.

The 3rd case could be our goal for next step.


Thanks
Barry

