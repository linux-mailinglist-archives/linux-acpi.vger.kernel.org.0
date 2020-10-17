Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D6E291035
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Oct 2020 08:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437168AbgJQGn6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 17 Oct 2020 02:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437167AbgJQGn5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 17 Oct 2020 02:43:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 594302074A;
        Sat, 17 Oct 2020 06:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602917036;
        bh=a6zcUKlSgSys512jNLN6WswG7+wX08wIvpptFrELGwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URdAqCglk8hMKDvBnAqd72tRBYV5G+VJ++lmRLx1WQjkFLIdXI6Yo/3kpuZqpR92w
         4hOaFHhAjy7ygCldVjCv8LQ4ikTjN0lPhXi23x9a8CjahLJgyuAvaHQyWBdlSJZ+Xr
         rRZuRSL6WxH7tuIhgihS7Y/kNz5O4KF++SGSK6cw=
Date:   Sat, 17 Oct 2020 08:44:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Len Brown <len.brown@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>, guohanjun@huawei.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201017064425.GB1883987@kroah.com>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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
> This patch simply exposes this information to userspace libraries
> like hwloc by providing cluster_cpus and related sysfs attributes.
> PoC of HWLOC support at [2].
> 
> Note this patch only handle the ACPI case.
> 
> Special consideration is needed for SMT processors, where it is
> necessary to move 2 levels up the hierarchy from the leaf nodes
> (thus skipping the processor core level).
> 
> Currently the ID provided is the offset of the Processor
> Hierarchy Nodes Structure within PPTT.  Whilst this is unique
> it is not terribly elegant so alternative suggestions welcome.
> 
> Note that arm64 / ACPI does not provide any means of identifying
> a die level in the topology but that may be unrelate to the cluster
> level.
> 
> RFC questions:
> 1) Naming
> 2) Related to naming, do we want to represent all potential levels,
>    or this enough?  On Kunpeng920, the next level up from cluster happens
>    to be covered by llc cache sharing, but in theory more than one
>    level of cluster description might be needed by some future system.
> 3) Do we need DT code in place? I'm not sure any DT based ARM64
>    systems would have enough complexity for this to be useful.
> 4) Other architectures?  Is this useful on x86 for example?
> 
> [1] ACPI Specification 6.3 - section 5.2.29.1 processor hierarchy node
>     structure (Type 0)
> [2] https://github.com/hisilicon/hwloc/tree/linux-cluster
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
>  Documentation/admin-guide/cputopology.rst | 26 ++++++++--

You are adding new sysfs files here, but not adding Documentation/ABI/
entries as well?  This cputopology document is nice, but no one knows to
look there for sysfs stuff :)

thanks,

greg k-h
