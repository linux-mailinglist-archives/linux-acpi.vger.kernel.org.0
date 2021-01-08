Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6262EF926
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Jan 2021 21:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbhAHUY3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Jan 2021 15:24:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:21882 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbhAHUY2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Jan 2021 15:24:28 -0500
IronPort-SDR: XLhZcQfpqO32TVQaUAghStaHXqBN7SIYGxgtnnhkotgOG8PhnmEWa91jd66WtWsV6e6nLxxjen
 SK0kNqbdoPmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="175073218"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="175073218"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 12:22:42 -0800
IronPort-SDR: qkTrf23l5JW13Vmuj4KCq4mHK3AZV+A/sIyb8Wpyuf8i9pwYTSRgCws/RgkJtEeahgU0TChbaQ
 Hu8qPjKuWs1Q==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="380241453"
Received: from schen9-mobl.amr.corp.intel.com ([10.252.142.111])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 12:22:42 -0800
Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters and
 add cluster scheduler
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        valentin.schneider@arm.com, catalin.marinas@arm.com,
        will@kernel.org, rjw@rjwysocki.net, vincent.guittot@linaro.org,
        lenb@kernel.org, gregkh@linuxfoundation.org,
        jonathan.cameron@huawei.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mark.rutland@arm.com, sudeep.holla@arm.com,
        aubrey.li@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@openeuler.org, xuwei5@huawei.com,
        prime.zeng@hisilicon.com, tiantao6@hisilicon.com
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <20210108151241.GA47324@e123083-lin>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <99c07bdf-02d1-153a-bd1e-2f4200cc67c5@linux.intel.com>
Date:   Fri, 8 Jan 2021 12:22:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210108151241.GA47324@e123083-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 1/8/21 7:12 AM, Morten Rasmussen wrote:
> On Thu, Jan 07, 2021 at 03:16:47PM -0800, Tim Chen wrote:
>> On 1/6/21 12:30 AM, Barry Song wrote:
>>> ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
>>> cluster has 4 cpus. All clusters share L3 cache data while each cluster
>>> has local L3 tag. On the other hand, each cluster will share some
>>> internal system bus. This means cache is much more affine inside one cluster
>>> than across clusters.
>>
>> There is a similar need for clustering in x86.  Some x86 cores could share L2 caches that
>> is similar to the cluster in Kupeng 920 (e.g. on Jacobsville there are 6 clusters
>> of 4 Atom cores, each cluster sharing a separate L2, and 24 cores sharing L3).  
>> Having a sched domain at the L2 cluster helps spread load among 
>> L2 domains.  This will reduce L2 cache contention and help with
>> performance for low to moderate load scenarios.
> 
> IIUC, you are arguing for the exact opposite behaviour, i.e. balancing
> between L2 caches while Barry is after consolidating tasks within the
> boundaries of a L3 tag cache. One helps cache utilization, the other
> communication latency between tasks. Am I missing something? 
> 
> IMHO, we need some numbers on the table to say which way to go. Looking
> at just benchmarks of one type doesn't show that this is a good idea in
> general.
> 

I think it is going to depend on the workload.  If there are dependent
tasks that communicate with one another, putting them together
in the same cluster will be the right thing to do to reduce communication
costs.  On the other hand, if the tasks are independent, putting them together on the same cluster
will increase resource contention and spreading them out will be better.

Any thoughts on what is the right clustering "tag" to use to clump related tasks together?
Cgroup? Pid? Tasks with same mm?

Tim 
