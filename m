Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9B729251E
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 12:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgJSKBg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 06:01:36 -0400
Received: from foss.arm.com ([217.140.110.172]:53888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgJSKBg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 06:01:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BCF030E;
        Mon, 19 Oct 2020 03:01:36 -0700 (PDT)
Received: from bogus (unknown [10.57.13.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412C33F66E;
        Mon, 19 Oct 2020 03:01:34 -0700 (PDT)
Date:   Mon, 19 Oct 2020 11:01:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Len Brown <len.brown@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        guohanjun@huawei.com, Will Deacon <will@kernel.org>,
        linuxarm@huawei.com, Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019100100.GA12908@bogus>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Morten

On Fri, Oct 16, 2020 at 11:27:02PM +0800, Jonathan Cameron wrote:
> Both ACPI and DT provide the ability to describe additional layers of
> topology between that of individual cores and higher level constructs
> such as the level at which the last level cache is shared.
> In ACPI this can be represented in PPTT as a Processor Hierarchy
> Node Structure [1] that is the parent of the CPU cores and in turn
> has a parent Processor Hierarchy Nodes Structure representing
> a higher level of topology.
>
> For example Kunpeng 920 has clusters of 4 CPUs.  These do not share
> any cache resources, but the interconnect topology is such that
> the cost to transfer ownership of a cacheline between CPUs within
> a cluster is lower than between CPUs in different clusters on the same
> die.   Hence, it can make sense to deliberately schedule threads
> sharing data to a single cluster.
>

This is very SoC specific and hard to generalise, hence LLC is chosen
as one of the main factor to decide.

Are there any scheduler topology related changes to achieve the same ?
If so, we need their opinion on that.

> This patch simply exposes this information to userspace libraries
> like hwloc by providing cluster_cpus and related sysfs attributes.
> PoC of HWLOC support at [2].
>

OK, cluster is too Arm specific with no definition for it whatsoever.
How do you plan to support clusters of clusters or higher level of
hierarchy present in PPTT.

> Note this patch only handle the ACPI case.
>

If we decide to add this to sysfs, I prefer to keep DT implementation
also in sync. The bindings are in sync, just matter of implementation.

> Special consideration is needed for SMT processors, where it is
> necessary to move 2 levels up the hierarchy from the leaf nodes
> (thus skipping the processor core level).
>
> Currently the ID provided is the offset of the Processor
> Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> it is not terribly elegant so alternative suggestions welcome.
>

That is firmware choice. May be your firmware just fills in mandatory
fields and doesn't care about anything and everything optional. We do
check for valid UID fields and if that is not set, offset is used as
unique ID in kernel implementation. So if you enhance the firmware, the
kernel sysfs will become elegant as you expect 😉 

> Note that arm64 / ACPI does not provide any means of identifying
> a die level in the topology but that may be unrelate to the cluster
> level.
>

Indeed. It can be cluster of clusters on some platform. If we need that
info, we should add it. My assumption was that generally each die forms
a NUMA node and hence the information is available there. I may be wrong.

> RFC questions:
> 1) Naming
> 2) Related to naming, do we want to represent all potential levels,
>    or this enough?  On Kunpeng920, the next level up from cluster happens
>    to be covered by llc cache sharing, but in theory more than one
>    level of cluster description might be needed by some future system.

That is my question above. Can't recall the terminology used in ACPI
PPTT, but IIRC "cluster" is not used to keep it generic. May be we need
to do the same here as the term "cluster" is ill-defined on Arm and I
would avoid using it if possible.

> 3) Do we need DT code in place? I'm not sure any DT based ARM64
>    systems would have enough complexity for this to be useful.

I prefer to keep the implementation in sync

> 4) Other architectures?  Is this useful on x86 for example?
>

AMD had multi-die within socket IIRC. IIUC, cpuid will provide the info
and nothing more is needed from ACPI ? I may be wrong, just guessing/asking.

--
Regards,
Sudeep
