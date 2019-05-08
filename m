Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD117E65
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2019 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfEHQpP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 May 2019 12:45:15 -0400
Received: from foss.arm.com ([217.140.101.70]:40336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbfEHQpP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 May 2019 12:45:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE71374;
        Wed,  8 May 2019 09:45:14 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55D523F238;
        Wed,  8 May 2019 09:45:12 -0700 (PDT)
Date:   Wed, 8 May 2019 17:45:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 0/5] arm64: SPE ACPI enablement
Message-ID: <20190508164506.GA21553@e107155-lin>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, May 04, 2019 at 07:06:19PM +0800, Hanjun Guo wrote:
> Hi Jeremy, Mark,
>
> On 2019/5/4 7:24, Jeremy Linton wrote:
> > This patch series enables the Arm Statistical Profiling
> > Extension (SPE) on ACPI platforms.
> >
> > This is possible because ACPI 6.3 uses a previously
> > reserved field in the MADT to store the SPE interrupt
> > number, similarly to how the normal PMU is described.
> > If a consistent valid interrupt exists across all the
> > cores in the system, a platform device is registered.
> > That then triggers the SPE module, which runs as normal.
> >
> > We also add the ability to parse the PPTT for IDENTICAL
> > cores. We then use this to sanity check the single SPE
> > device we create. This creates a bit of a problem with
> > respect to the specification though. The specification
> > says that its legal for multiple tree's to exist in the
> > PPTT. We handle this fine, but what happens in the
> > case of multiple tree's is that the lack of a common
> > node with IDENTICAL set forces us to assume that there
> > are multiple non-IDENTICAL cores in the machine.
>
> Adding this patch set on top of latest mainline kernel,
> and tested on D06 which has the SPE feature, in boot message
> shows it was probed successfully:
>
> arm_spe_pmu arm,spe-v1: probed for CPUs 0-95 [max_record_sz 128, align 4, features 0x7]
>
> but when I test it with spe events such as
>
> perf record -c 1024 -e arm_spe_0/branch_filter=0/ -o spe ls
>
> it fails with:
> failed to mmap with 12 (Cannot allocate memory),
>
> Confirmed that patch [0] is merged and other perf events are working
> fine.
>
> I narrowed this issue down that mmap() failed to alloc 4M memory
> in perf tool but seems have no relationship with this SPE patch set,
> then I'm lost, could you take look please?
>

Thanks for pointing this out. I had last tested SPE only with v5.0 and
missed completely to check on v5.1. FWIW, I can reproduce this issue
on v5.1

--
Regards,
Sudeep
