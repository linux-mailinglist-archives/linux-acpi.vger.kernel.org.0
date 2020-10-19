Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00A29236F
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgJSIKx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 04:10:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2984 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728142AbgJSIKw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 04:10:52 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B68E437F098303526F95;
        Mon, 19 Oct 2020 09:10:50 +0100 (IST)
Received: from localhost (10.52.126.130) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 09:10:50 +0100
Date:   Mon, 19 Oct 2020 09:08:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>, <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>, <linuxarm@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019080854.00001a9f@Huawei.com>
In-Reply-To: <20201017064425.GB1883987@kroah.com>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
        <20201017064425.GB1883987@kroah.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.130]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 17 Oct 2020 08:44:25 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Oct 16, 2020 at 11:27:02PM +0800, Jonathan Cameron wrote:
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
> > 
> > [1] ACPI Specification 6.3 - section 5.2.29.1 processor hierarchy node
> >     structure (Type 0)
> > [2] https://github.com/hisilicon/hwloc/tree/linux-cluster
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> >  Documentation/admin-guide/cputopology.rst | 26 ++++++++--  
> 
> You are adding new sysfs files here, but not adding Documentation/ABI/
> entries as well?  This cputopology document is nice, but no one knows to
> look there for sysfs stuff :)
Hi Greg,

Ah.  I'd assumed there wasn't a current doc as the patch adding
die description didn't touch it.   Turns out it was just missing from
that patch. (Documentation/ABI/testing/sysfs-devices-system-cpu)
Seems those docs are missing quite a bit of more recent stuff such as
die and more package related parts.  I'll bring it up to date as a
precursor to v2 of this series.

Thanks,

Jonathan

> 
> thanks,
> 
> greg k-h


