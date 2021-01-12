Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11462F2F68
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 13:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388767AbhALMyT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 07:54:19 -0500
Received: from foss.arm.com ([217.140.110.172]:45474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727907AbhALMyT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 07:54:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E38E71042;
        Tue, 12 Jan 2021 04:53:32 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C85B43F66E;
        Tue, 12 Jan 2021 04:53:27 -0800 (PST)
Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
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
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <20210108151241.GA47324@e123083-lin>
 <f15f8feb4e764c11a078ffd74f002a8d@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a5dfcbf6-84f4-0c72-3a88-62926f1f351d@arm.com>
Date:   Tue, 12 Jan 2021 13:53:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f15f8feb4e764c11a078ffd74f002a8d@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 08/01/2021 22:30, Song Bao Hua (Barry Song) wrote:
>  
>> -----Original Message-----
>> From: Morten Rasmussen [mailto:morten.rasmussen@arm.com]
>> Sent: Saturday, January 9, 2021 4:13 AM
>> To: Tim Chen <tim.c.chen@linux.intel.com>
>> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
>> valentin.schneider@arm.com; catalin.marinas@arm.com; will@kernel.org;
>> rjw@rjwysocki.net; vincent.guittot@linaro.org; lenb@kernel.org;
>> gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com;
>> dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.com;
>> mgorman@suse.de; mark.rutland@arm.com; sudeep.holla@arm.com;
>> aubrey.li@linux.intel.com; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
>> linuxarm@openeuler.org; xuwei (O) <xuwei5@huawei.com>; Zengtao (B)
>> <prime.zeng@hisilicon.com>; tiantao (H) <tiantao6@hisilicon.com>
>> Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
>> add cluster scheduler
>>
>> On Thu, Jan 07, 2021 at 03:16:47PM -0800, Tim Chen wrote:
>>> On 1/6/21 12:30 AM, Barry Song wrote:
>>>> ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
>>>> cluster has 4 cpus. All clusters share L3 cache data while each cluster
>>>> has local L3 tag. On the other hand, each cluster will share some
>>>> internal system bus. This means cache is much more affine inside one cluster
>>>> than across clusters.
>>>
>>> There is a similar need for clustering in x86.  Some x86 cores could share
>> L2 caches that
>>> is similar to the cluster in Kupeng 920 (e.g. on Jacobsville there are 6 clusters
>>> of 4 Atom cores, each cluster sharing a separate L2, and 24 cores sharing
>> L3).
>>> Having a sched domain at the L2 cluster helps spread load among
>>> L2 domains.  This will reduce L2 cache contention and help with
>>> performance for low to moderate load scenarios.
>>
>> IIUC, you are arguing for the exact opposite behaviour, i.e. balancing
>> between L2 caches while Barry is after consolidating tasks within the
>> boundaries of a L3 tag cache. One helps cache utilization, the other
>> communication latency between tasks. Am I missing something?
> 
> Morten, this is not true.
> 
> we are both actually looking for the same behavior. My patch also
> has done the exact same behavior of spreading with Tim's patch.

That's the case for the load-balance path because of the extra Sched
Domain (SD) (CLS/MC_L2) below MC.

But in wakeup you add code which leads to a different packing strategy.

It looks like that Tim's workload (SPECrate mcf) shows a performance
boost solely because of the changes the additional MC_L2 SD introduces
in load balance. The wakeup path is unchanged, i.e. llc-packing. IMHO we
have to carefully distinguish between packing vs. spreading in wakeup
and load-balance here.

> Considering the below two cases:
> Case 1. we have two tasks without any relationship running in a system with 2 clusters and 8 cpus.
> 
> Without the sched_domain of cluster, these two tasks might be put as below:
> +-------------------+            +-----------------+
> | +----+   +----+   |            |                 |
> | |task|   |task|   |            |                 |
> | |1   |   |2   |   |            |                 |
> | +----+   +----+   |            |                 |
> |                   |            |                 |
> |       cluster1    |            |     cluster2    |
> +-------------------+            +-----------------+
> With the sched_domain of cluster, load balance will spread them as below:
> +-------------------+            +-----------------+
> | +----+            |            | +----+          |
> | |task|            |            | |task|          |
> | |1   |            |            | |2   |          |
> | +----+            |            | +----+          |
> |                   |            |                 |
> |       cluster1    |            |     cluster2    |
> +-------------------+            +-----------------+
> 
> Then task1 and tasks2 get more cache and decrease cache contention.
> They will get better performance.
> 
> That is what my original patch also can make. And tim's patch
> is also doing. Once we add a sched_domain, load balance will
> get involved.
> 
> 
> Case 2. we have 8 tasks, running in a system with 2 clusters and 8 cpus.
> But they are working in 4 groups:
> Task1 wakes up task4
> Task2 wakes up task5
> Task3 wakes up task6
> Task4 wakes up task7
> 
> With my changing in select_idle_sibling, the WAKE_AFFINE mechanism will
> try to put task1 and 4, task2 and 5, task3 and 6, task4 and 7 in same clusters rather
> than putting all of them in the random one of the 8 cpus. However, the 8 tasks
> are still spreading among the 8 cpus with my change in select_idle_sibling
> as load balance is still working.
> 
> +---------------------------+    +----------------------+
> | +----+        +-----+     |    | +----+      +-----+  |
> | |task|        |task |     |    | |task|      |task |  |
> | |1   |        | 4   |     |    | |2   |      |5    |  |
> | +----+        +-----+     |    | +----+      +-----+  |
> |                           |    |                      |
> |       cluster1            |    |     cluster2         |
> |                           |    |                      |
> |                           |    |                      |
> | +-----+       +------+    |    | +-----+     +------+ |
> | |task |       | task |    |    | |task |     |task  | |
> | |3    |       |  6   |    |    | |4    |     |8     | |
> | +-----+       +------+    |    | +-----+     +------+ |
> +---------------------------+    +----------------------+

Your use-case (#tasks, runtime/period) seems to be perfectly crafted to
show the benefit of your patch on your specific system (cluster-size =
4). IMHO, this extra infrastructure especially in the wakeup path should
show benefits over a range of different benchmarks.

> Let's consider the 3rd case, that one would be more tricky:
> 
> task1 and task2 have close relationship and they are waker-wakee pair.
> With my current patch, select_idle_sidling() wants to put them in one
> cluster, load balance wants to put them in two clusters. Load balance will win. 
> Then maybe we need some same mechanism like adjusting numa imbalance:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/sched/fair.c?id=b396f52326de20
> if we permit a light imbalance between clusters, select_idle_sidling()
> will win. And task1 and task2 get better cache affinity.

This would look weird to allow this kind of imbalance on CLS (MC_L2) and
NUMA domains but not on the MC domain for example.
