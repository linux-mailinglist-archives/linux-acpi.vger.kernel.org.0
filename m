Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC779292783
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 14:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgJSMkd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 19 Oct 2020 08:40:33 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbgJSMkd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 08:40:33 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 43F26A2699A4B1467DC1;
        Mon, 19 Oct 2020 13:40:32 +0100 (IST)
Received: from localhost (10.52.126.130) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 13:40:31 +0100
Date:   Mon, 19 Oct 2020 13:38:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Brice Goglin <Brice.Goglin@inria.fr>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019123836.00004877@Huawei.com>
In-Reply-To: <942b4d68-8d19-66d8-c84b-d17eba837e9a@inria.fr>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
        <942b4d68-8d19-66d8-c84b-d17eba837e9a@inria.fr>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.126.130]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 19 Oct 2020 12:00:15 +0200
Brice Goglin <Brice.Goglin@inria.fr> wrote:

> Le 16/10/2020 à 17:27, Jonathan Cameron a écrit :
> > Both ACPI and DT provide the ability to describe additional layers of
> > topology between that of individual cores and higher level constructs
> > such as the level at which the last level cache is shared.
> > In ACPI this can be represented in PPTT as a Processor Hierarchy
> > Node Structure [1] that is the parent of the CPU cores and in turn
> > has a parent Processor Hierarchy Nodes Structure representing
> > a higher level of topology.
> >
> > For example Kunpeng 920 has clusters of 4 CPUs.  These do not share
> > any cache resources, but the interconnect topology is such that
> > the cost to transfer ownership of a cacheline between CPUs within
> > a cluster is lower than between CPUs in different clusters on the same
> > die.   Hence, it can make sense to deliberately schedule threads
> > sharing data to a single cluster.
> >
> > This patch simply exposes this information to userspace libraries
> > like hwloc by providing cluster_cpus and related sysfs attributes.
> > PoC of HWLOC support at [2].
> >
> > Note this patch only handle the ACPI case.
> >
> > Special consideration is needed for SMT processors, where it is
> > necessary to move 2 levels up the hierarchy from the leaf nodes
> > (thus skipping the processor core level).
> >
> > Currently the ID provided is the offset of the Processor
> > Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> > it is not terribly elegant so alternative suggestions welcome.
> >
> > Note that arm64 / ACPI does not provide any means of identifying
> > a die level in the topology but that may be unrelate to the cluster
> > level.
> >
> > RFC questions:
> > 1) Naming
> > 2) Related to naming, do we want to represent all potential levels,
> >    or this enough?  On Kunpeng920, the next level up from cluster happens
> >    to be covered by llc cache sharing, but in theory more than one
> >    level of cluster description might be needed by some future system.
> > 3) Do we need DT code in place? I'm not sure any DT based ARM64
> >    systems would have enough complexity for this to be useful.
> > 4) Other architectures?  Is this useful on x86 for example?  
> 
> 
> Hello Jonathan

Hi Brice,

> 
> Intel has CPUID registers to describe "tiles" and "modules" too (not
> used yet as far as I know). The list of levels could become quite long
> if any processor ever exposes those. If having multiple cluster levels
> is possible, maybe it's time to think about introducing some sort of
> generic levels:

I've been wondering what tiles and modules are... Looking back and
naming over time, I'm going to guess tiles are the closest to the
particular case I was focusing on here.

> 
> cluster0_id = your cluster_id
> cluster0_cpus/cpulist = your cluster_cpus/cpulis
> cluster0_type = would optionally contain hardware-specific info such as
> "module" or "tile" on x86
> cluster_levels = 1

I wondered exactly the same question.  At this point, perhaps we just
statically introduce an 0 index, but with the assumption we would extend
that as / when necessary in future.

> 
> hwloc already does something like this for some "rare" levels such as
> s390 book/drawers (by the way, thanks a lot for the hwloc PoC, very good
> job), we call them "Groups" instead of "cluster" above.

Given we definitely have a 'naming' issue here, perhaps group0 etc is a good
generic choice? 

> 
> However I don't know if the Linux scheduler would like that. Is it
> better to have 10+ levels with static names, or a dynamic number of levels?

So far our 'general' experiments with adding clusters into the kernel
scheduler have been a typical mixed bunch.  Hence the proposal
to just expose the structure to userspace where we should at least know
what the workload is.   Hopefully we'll gain more experience with using
it and use that to drive possible kernel scheduler changes.

> 
> Brice

Thanks,

Jonathan


