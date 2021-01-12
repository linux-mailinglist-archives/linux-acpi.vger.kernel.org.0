Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EC2F2D59
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 12:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbhALLBQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 06:01:16 -0500
Received: from foss.arm.com ([217.140.110.172]:43970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhALLBP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 06:01:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 950FC1042;
        Tue, 12 Jan 2021 03:00:29 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B980C3F66E;
        Tue, 12 Jan 2021 03:00:24 -0800 (PST)
Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
To:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        lenb@kernel.org, gregkh@linuxfoundation.org,
        jonathan.cameron@huawei.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, mark.rutland@arm.com,
        sudeep.holla@arm.com, aubrey.li@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@openeuler.org,
        xuwei5@huawei.com, prime.zeng@hisilicon.com, tiantao6@hisilicon.com
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <20210108151241.GA47324@e123083-lin>
 <99c07bdf-02d1-153a-bd1e-2f4200cc67c5@linux.intel.com>
 <20210111092811.GB47324@e123083-lin>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <4fdc781e-7385-2ae6-d9c9-3ec165f473c4@arm.com>
Date:   Tue, 12 Jan 2021 12:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210111092811.GB47324@e123083-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/01/2021 10:28, Morten Rasmussen wrote:
> On Fri, Jan 08, 2021 at 12:22:41PM -0800, Tim Chen wrote:
>>
>>
>> On 1/8/21 7:12 AM, Morten Rasmussen wrote:
>>> On Thu, Jan 07, 2021 at 03:16:47PM -0800, Tim Chen wrote:
>>>> On 1/6/21 12:30 AM, Barry Song wrote:

[...]

>> I think it is going to depend on the workload.  If there are dependent
>> tasks that communicate with one another, putting them together
>> in the same cluster will be the right thing to do to reduce communication
>> costs.  On the other hand, if the tasks are independent, putting them together on the same cluster
>> will increase resource contention and spreading them out will be better.
> 
> Agree. That is exactly where I'm coming from. This is all about the task
> placement policy. We generally tend to spread tasks to avoid resource
> contention, SMT and caches, which seems to be what you are proposing to
> extend. I think that makes sense given it can produce significant
> benefits.
> 
>>
>> Any thoughts on what is the right clustering "tag" to use to clump
>> related tasks together?
>> Cgroup? Pid? Tasks with same mm?
> 
> I think this is the real question. I think the closest thing we have at
> the moment is the wakee/waker flip heuristic. This seems to be related.
> Perhaps the wake_affine tricks can serve as starting point?

wake_wide() switches between packing (select_idle_sibling(), llc_size
CPUs) and spreading (find_idlest_cpu(), all CPUs).

AFAICS, since none of the sched domains set SD_BALANCE_WAKE, currently
all wakeups are (llc-)packed.

 select_task_rq_fair()

   for_each_domain(cpu, tmp)

     if (tmp->flags & sd_flag)
       sd = tmp;


In case we would like to further distinguish between llc-packing and
even narrower (cluster or MC-L2)-packing, we would introduce a 2. level
packing vs. spreading heuristic further down in sis().

IMHO, Barry's current implementation doesn't do this right now. Instead
he's trying to pack on cluster first and if not successful look further
among the remaining llc CPUs for an idle CPU.
