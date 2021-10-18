Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B9643136C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Oct 2021 11:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhJRJ1z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Oct 2021 05:27:55 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3994 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbhJRJ1x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Oct 2021 05:27:53 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HXrx04n41z67yHr;
        Mon, 18 Oct 2021 17:21:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 18 Oct 2021 11:25:40 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 18 Oct
 2021 10:25:39 +0100
Date:   Mon, 18 Oct 2021 10:25:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Add a node and memblk for each CFMWS not in
 SRAT
Message-ID: <20211018102538.00007023@Huawei.com>
In-Reply-To: <CAPcyv4hziy_+aHz7SSJ0441saDwfHeNyHsB1DMsPjPg7aFHzeg@mail.gmail.com>
References: <20211009015339.400383-1-alison.schofield@intel.com>
        <20211015175943.000070b8@Huawei.com>
        <CAPcyv4hziy_+aHz7SSJ0441saDwfHeNyHsB1DMsPjPg7aFHzeg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 15 Oct 2021 11:58:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Fri, Oct 15, 2021 at 10:00 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 8 Oct 2021 18:53:39 -0700
> > <alison.schofield@intel.com> wrote:
> >  
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > During NUMA init, CXL memory defined in the SRAT Memory Affinity
> > > subtable may be assigned to a NUMA node. Since there is no
> > > requirement that the SRAT be comprehensive for CXL memory another
> > > mechanism is needed to assign NUMA nodes to CXL memory not identified
> > > in the SRAT.
> > >
> > > Use the CXL Fixed Memory Window Structure's (CFMWS) of the ACPI CXL
> > > Early Discovery Table (CEDT) to find all CXL memory ranges. Create a
> > > NUMA node for each range that is not already assigned to a NUMA node.
> > > Add a memblk attaching its host physical address range to the node.
> > >
> > > Note that these ranges may not actually map any memory at boot time.
> > > They may describe persistent capacity or may be present to enable
> > > hot-plug.
> > >
> > > Consumers can use phys_to_target_node() to discover the NUMA node.
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>  
> > Hi Alison,
> >
> > I'm not sure that a CFMWS entry should map to a single NUMA node...
> >
> > Each entry corresponds to a contiguous HPA range into which CXL devices
> > below a set of ports (if interleaved) or one port should be mapped.
> >
> > That could be multiple devices, each with it's own performance characteristics,
> > or potentially a mix of persistent and volatile memory on a system with limited
> > qtg groups.
> >
> > Maybe it's the best we can do though given information available
> > before any devices are present.
> >  
> 
> Regardless of the performance of the individual devices they can only
> map to one of the available CFMWS entries. So the maximum number of
> degrees of freedom is one node per CFMWS. Now if you have only one
> entry to pick from, but have interleave sets with widely different
> performance characteristics to online it becomes a policy decision
> about whether to force map those interleave sets into the same node,
> and that policy can be maintained outside the kernel.
> 
> The alternative is to rework NUMA nodes to be something that can be
> declared dynamically as currently there are assumptions throughout the
> kernel that num_possible_nodes() is statically determined early in
> boot. I am not seeing strong evidence that complexity needs to be
> tackled in the near term, and "NUMA-node per CFMWS" should (famous
> last words) serve CXL needs for the foreseeable future.

I'm less optimistic we won't end up revisiting this in the medium
term but can tackle that when we have better visibility of what
people are actually building.

Jonathan

