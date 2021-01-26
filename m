Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCA4303B09
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 12:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404761AbhAZLDk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 06:03:40 -0500
Received: from foss.arm.com ([217.140.110.172]:33680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbhAZLDY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 06:03:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D71C7D6E;
        Tue, 26 Jan 2021 03:02:38 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A9E3F66B;
        Tue, 26 Jan 2021 03:02:33 -0800 (PST)
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
 <99c07bdf-02d1-153a-bd1e-2f4200cc67c5@linux.intel.com>
 <20210111092811.GB47324@e123083-lin>
 <4fdc781e-7385-2ae6-d9c9-3ec165f473c4@arm.com>
 <076088f4daf64727b1587b162eb08dda@hisilicon.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <bf0edcb6-6dc7-5591-35ac-08e94bf7dce9@arm.com>
Date:   Tue, 26 Jan 2021 12:02:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <076088f4daf64727b1587b162eb08dda@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 25/01/2021 11:50, Song Bao Hua (Barry Song) wrote:
> 
>> -----Original Message-----
>> From: Dietmar Eggemann [mailto:dietmar.eggemann@arm.com]
>> Sent: Wednesday, January 13, 2021 12:00 AM
>> To: Morten Rasmussen <morten.rasmussen@arm.com>; Tim Chen
>> <tim.c.chen@linux.intel.com>
>> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
>> valentin.schneider@arm.com; catalin.marinas@arm.com; will@kernel.org;
>> rjw@rjwysocki.net; vincent.guittot@linaro.org; lenb@kernel.org;
>> gregkh@linuxfoundation.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
>> mingo@redhat.com; peterz@infradead.org; juri.lelli@redhat.com;
>> rostedt@goodmis.org; bsegall@google.com; mgorman@suse.de;
>> mark.rutland@arm.com; sudeep.holla@arm.com; aubrey.li@linux.intel.com;
>> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> linux-acpi@vger.kernel.org; linuxarm@openeuler.org; xuwei (O)
>> <xuwei5@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; tiantao (H)
>> <tiantao6@hisilicon.com>
>> Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
>> add cluster scheduler
>>
>> On 11/01/2021 10:28, Morten Rasmussen wrote:
>>> On Fri, Jan 08, 2021 at 12:22:41PM -0800, Tim Chen wrote:
>>>>
>>>>
>>>> On 1/8/21 7:12 AM, Morten Rasmussen wrote:
>>>>> On Thu, Jan 07, 2021 at 03:16:47PM -0800, Tim Chen wrote:
>>>>>> On 1/6/21 12:30 AM, Barry Song wrote:

[...]

>> wake_wide() switches between packing (select_idle_sibling(), llc_size
>> CPUs) and spreading (find_idlest_cpu(), all CPUs).
>>
>> AFAICS, since none of the sched domains set SD_BALANCE_WAKE, currently
>> all wakeups are (llc-)packed.
> 
> Sorry for late response. I was struggling with some other topology
> issues recently.
> 
> For "all wakeups are (llc-)packed",
> it seems you mean current want_affine is only affecting the new_cpu,
> and for wake-up path, we will always go to select_idle_sibling() rather
> than find_idlest_cpu() since nobody sets SD_WAKE_BALANCE in any
> sched_domain ?
> 
>>
>>  select_task_rq_fair()
>>
>>    for_each_domain(cpu, tmp)
>>
>>      if (tmp->flags & sd_flag)
>>        sd = tmp;
>>
>>
>> In case we would like to further distinguish between llc-packing and
>> even narrower (cluster or MC-L2)-packing, we would introduce a 2. level
>> packing vs. spreading heuristic further down in sis().
> 
> I didn't get your point on "2 level packing". Would you like
> to describe more? It seems you mean we need to have separate
> calculation for avg_scan_cost and sched_feat(SIS_) for cluster
> (or MC-L2) since cluster and llc are not in the same level
> physically?

By '1. level packing' I meant going sis() (i.e. sd=per_cpu(sd_llc,
target)) instead of routing WF_TTWU through find_idlest_cpu() which uses
a broader sd span (in case all sd's (or at least up to an sd > llc)
would have SD_BALANCE_WAKE set).
wake_wide() (wakee/waker flip heuristic) is currently used to make this
decision. But since no sd sets SD_BALANCE_WAKE we always go sis() for
WF_TTWU.

'2. level packing' would be the decision between cluster- and
llc-packing. The question was which heuristic could be used here.

>> IMHO, Barry's current implementation doesn't do this right now. Instead
>> he's trying to pack on cluster first and if not successful look further
>> among the remaining llc CPUs for an idle CPU.
> 
> Yes. That is exactly what the current patch is doing.

And this will be favoring cluster- over llc-packing for each task instead.
