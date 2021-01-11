Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAB22F0F19
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 10:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbhAKJ3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 04:29:05 -0500
Received: from foss.arm.com ([217.140.110.172]:51098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbhAKJ3F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 04:29:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88323101E;
        Mon, 11 Jan 2021 01:28:19 -0800 (PST)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E58003F70D;
        Mon, 11 Jan 2021 01:28:14 -0800 (PST)
Date:   Mon, 11 Jan 2021 10:28:11 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
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
Subject: Re: [RFC PATCH v3 0/2] scheduler: expose the topology of clusters
 and add cluster scheduler
Message-ID: <20210111092811.GB47324@e123083-lin>
References: <20210106083026.40444-1-song.bao.hua@hisilicon.com>
 <737932c9-846a-0a6b-08b8-e2d2d95b67ce@linux.intel.com>
 <20210108151241.GA47324@e123083-lin>
 <99c07bdf-02d1-153a-bd1e-2f4200cc67c5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c07bdf-02d1-153a-bd1e-2f4200cc67c5@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 08, 2021 at 12:22:41PM -0800, Tim Chen wrote:
> 
> 
> On 1/8/21 7:12 AM, Morten Rasmussen wrote:
> > On Thu, Jan 07, 2021 at 03:16:47PM -0800, Tim Chen wrote:
> >> On 1/6/21 12:30 AM, Barry Song wrote:
> >>> ARM64 server chip Kunpeng 920 has 6 clusters in each NUMA node, and each
> >>> cluster has 4 cpus. All clusters share L3 cache data while each cluster
> >>> has local L3 tag. On the other hand, each cluster will share some
> >>> internal system bus. This means cache is much more affine inside one cluster
> >>> than across clusters.
> >>
> >> There is a similar need for clustering in x86.  Some x86 cores could share L2 caches that
> >> is similar to the cluster in Kupeng 920 (e.g. on Jacobsville there are 6 clusters
> >> of 4 Atom cores, each cluster sharing a separate L2, and 24 cores sharing L3).  
> >> Having a sched domain at the L2 cluster helps spread load among 
> >> L2 domains.  This will reduce L2 cache contention and help with
> >> performance for low to moderate load scenarios.
> > 
> > IIUC, you are arguing for the exact opposite behaviour, i.e. balancing
> > between L2 caches while Barry is after consolidating tasks within the
> > boundaries of a L3 tag cache. One helps cache utilization, the other
> > communication latency between tasks. Am I missing something? 
> > 
> > IMHO, we need some numbers on the table to say which way to go. Looking
> > at just benchmarks of one type doesn't show that this is a good idea in
> > general.
> > 
> 
> I think it is going to depend on the workload.  If there are dependent
> tasks that communicate with one another, putting them together
> in the same cluster will be the right thing to do to reduce communication
> costs.  On the other hand, if the tasks are independent, putting them together on the same cluster
> will increase resource contention and spreading them out will be better.

Agree. That is exactly where I'm coming from. This is all about the task
placement policy. We generally tend to spread tasks to avoid resource
contention, SMT and caches, which seems to be what you are proposing to
extend. I think that makes sense given it can produce significant
benefits.

> 
> Any thoughts on what is the right clustering "tag" to use to clump
> related tasks together?
> Cgroup? Pid? Tasks with same mm?

I think this is the real question. I think the closest thing we have at
the moment is the wakee/waker flip heuristic. This seems to be related.
Perhaps the wake_affine tricks can serve as starting point?

Morten
