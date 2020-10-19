Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B7292886
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgJSNsJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 09:48:09 -0400
Received: from foss.arm.com ([217.140.110.172]:57948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbgJSNsI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 09:48:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E5A1D6E;
        Mon, 19 Oct 2020 06:48:08 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ACF33F66E;
        Mon, 19 Oct 2020 06:48:06 -0700 (PDT)
References: <20201016152702.1513592-1-Jonathan.Cameron@huawei.com> <20201019103522.GK2628@hirez.programming.kicks-ass.net> <20201019123226.00006705@Huawei.com> <20201019131052.GC8004@e123083-lin>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>, guohanjun@huawei.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Jeremy Linton <Jeremy.Linton@arm.com>
Subject: Re: [RFC PATCH] topology: Represent clusters of CPUs within a die.
In-reply-to: <20201019131052.GC8004@e123083-lin>
Date:   Mon, 19 Oct 2020 14:48:02 +0100
Message-ID: <jhjh7qqqqct.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


+Cc Jeremy

On 19/10/20 14:10, Morten Rasmussen wrote:
> Hi Jonathan,
> The problem I see is that the benefit of keeping tasks together due to
> the interconnect layout might vary significantly between systems. So if
> we introduce a new cpumask for cluster it has to have represent roughly
> the same system properties otherwise generic software consuming this
> information could be tricked.
>
> If there is a provable benefit of having interconnect grouping
> information, I think it would be better represented by a distance matrix
> like we have for NUMA.
>
> Morten

That's my queue to paste some of that stuff I've been rambling on and off
about!

With regards to cache / interconnect layout, I do believe that if we
want to support in the scheduler itself then we should leverage some
distance table rather than to create X extra scheduler topology levels.

I had a chat with Jeremy on the ACPI side of that sometime ago. IIRC given
that SLIT gives us a distance value between any two PXM, we could directly
express core-to-core distance in that table. With that (and if that still
lets us properly discover NUMA node spans), we could let the scheduler
build dynamic NUMA-like topology levels representing the inner quirks of
the cache / interconnect layout.

It's mostly pipe dreams for now, but there seems to be more and more
hardware where that would make sense; somewhat recently the PowerPC guys
added something to their arch-specific code in that regards.
