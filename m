Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAE292946
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 16:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgJSO1S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 10:27:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2991 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728311AbgJSO1S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 10:27:18 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id D268999E714A7DA46F91;
        Mon, 19 Oct 2020 15:27:16 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 19 Oct
 2020 15:27:16 +0100
Date:   Mon, 19 Oct 2020 15:27:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, <guohanjun@huawei.com>,
        Will Deacon <will@kernel.org>, <linuxarm@huawei.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
Message-ID: <20201019142715.00005fb1@huawei.com>
In-Reply-To: <jhjh7qqqqct.mognet@arm.com>
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com>
        <20201019103522.GK2628@hirez.programming.kicks-ass.net>
        <20201019123226.00006705@Huawei.com>
        <20201019131052.GC8004@e123083-lin>
        <jhjh7qqqqct.mognet@arm.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 19 Oct 2020 14:48:02 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> +Cc Jeremy
> 
> On 19/10/20 14:10, Morten Rasmussen wrote:
> > Hi Jonathan,
> > The problem I see is that the benefit of keeping tasks together due to
> > the interconnect layout might vary significantly between systems. So if
> > we introduce a new cpumask for cluster it has to have represent roughly
> > the same system properties otherwise generic software consuming this
> > information could be tricked.
> >
> > If there is a provable benefit of having interconnect grouping
> > information, I think it would be better represented by a distance matrix
> > like we have for NUMA.
> >
> > Morten  
> 
> That's my queue to paste some of that stuff I've been rambling on and off
> about!
> 
> With regards to cache / interconnect layout, I do believe that if we
> want to support in the scheduler itself then we should leverage some
> distance table rather than to create X extra scheduler topology levels.
> 
> I had a chat with Jeremy on the ACPI side of that sometime ago. IIRC given
> that SLIT gives us a distance value between any two PXM, we could directly
> express core-to-core distance in that table. With that (and if that still
> lets us properly discover NUMA node spans), we could let the scheduler
> build dynamic NUMA-like topology levels representing the inner quirks of
> the cache / interconnect layout.

You would rapidly run into the problem SLIT had for numa node description.
There is no consistent description of distance and except in the vaguest
sense or 'nearer' it wasn't any use for anything.   That is why HMAT
came along. It's far from perfect but it is a step up.

I can't see how you'd generalize those particular tables to do anything
for intercore comms without breaking their use for NUMA, but something
a bit similar might work.

A lot of thought has gone in (and meeting time) to try an improve the
situation for complex topology around NUMA.  Whilst there are differences
in representing the internal interconnects and caches it seems like a somewhat
similar problem.  The issue there is it is really really hard to describe
this stuff with enough detail to be useful, but simple enough to be usable.

https://lore.kernel.org/linux-mm/20181203233509.20671-1-jglisse@redhat.com/

> 
> It's mostly pipe dreams for now, but there seems to be more and more
> hardware where that would make sense; somewhat recently the PowerPC guys
> added something to their arch-specific code in that regards.

Pipe dream == something to work on ;)

ACPI has a nice code first model of updating the spec now, so we can discuss
this one in public, and propose spec changes only once we have an implementation
proven.

Note I'm not proposing we put the cluster stuff in the scheduler, just
provide it as a hint to userspace.

Jonathan

