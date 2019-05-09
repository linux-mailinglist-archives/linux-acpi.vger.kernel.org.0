Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDDD187BC
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEIJ2W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 05:28:22 -0400
Received: from foss.arm.com ([217.140.101.70]:35800 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfEIJ2W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 May 2019 05:28:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60260374;
        Thu,  9 May 2019 02:28:21 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B72A3F575;
        Thu,  9 May 2019 02:28:17 -0700 (PDT)
Date:   Thu, 9 May 2019 10:28:11 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com,
        Hongbo Yao <yaohongbo@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v3 0/5] arm64: SPE ACPI enablement
Message-ID: <20190509092810.GC2667@brain-police>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
 <82032e5b-0cb5-e48f-ab51-ba5d5f9dceec@arm.com>
 <819de863-92ff-51c5-9c35-880db4f6a922@huawei.com>
 <20190508165149.GB21553@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508165149.GB21553@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 08, 2019 at 05:51:49PM +0100, Sudeep Holla wrote:
> On Wed, May 08, 2019 at 05:35:51PM +0800, Hanjun Guo wrote:
> > +Cc Alexander.
> >
> > On 2019/5/8 1:58, Jeremy Linton wrote:
> > > Hi,
> > >
> > > On 5/4/19 6:06 AM, Hanjun Guo wrote:
> > >> Hi Jeremy, Mark,
> > >>
> > >> On 2019/5/4 7:24, Jeremy Linton wrote:
> > >>> This patch series enables the Arm Statistical Profiling
> > >>> Extension (SPE) on ACPI platforms.
> > >>>
> > >>> This is possible because ACPI 6.3 uses a previously
> > >>> reserved field in the MADT to store the SPE interrupt
> > >>> number, similarly to how the normal PMU is described.
> > >>> If a consistent valid interrupt exists across all the
> > >>> cores in the system, a platform device is registered.
> > >>> That then triggers the SPE module, which runs as normal.
> > >>>
> > >>> We also add the ability to parse the PPTT for IDENTICAL
> > >>> cores. We then use this to sanity check the single SPE
> > >>> device we create. This creates a bit of a problem with
> > >>> respect to the specification though. The specification
> > >>> says that its legal for multiple tree's to exist in the
> > >>> PPTT. We handle this fine, but what happens in the
> > >>> case of multiple tree's is that the lack of a common
> > >>> node with IDENTICAL set forces us to assume that there
> > >>> are multiple non-IDENTICAL cores in the machine.
> > >>
> > >> Adding this patch set on top of latest mainline kernel,
> > >> and tested on D06 which has the SPE feature, in boot message
> > >> shows it was probed successfully:
> > >>
> > >> arm_spe_pmu arm,spe-v1: probed for CPUs 0-95 [max_record_sz 128, align 4, features 0x7]
> > >>
> > >> but when I test it with spe events such as
> > >>
> > >> perf record -c 1024 -e arm_spe_0/branch_filter=0/ -o spe ls
> > >>
> > >> it fails with:
> > >> failed to mmap with 12 (Cannot allocate memory),
> > >>
> > >> Confirmed that patch [0] is merged and other perf events are working
> > >> fine.
> > >
> > > Its pretty easy to get into the weeds with this driver, does it work with examples like:
> > >
> > > https://lkml.org/lkml/2018/1/14/122
> >
> > No, not work at all.
> >
> > SPE works on 5.0, but not work after 5.1-rc1, bisected to this commit:
> >
> > 5768402fd9c6 perf/ring_buffer: Use high order allocations for AUX buffers optimistically
> >
> 
> Indeed this patch breaks SPE. As mentioned in the patch, it uses high
> order allocations for AUX buffers and SPE PMU setup_aux explicitly
> fails with the warning "unexpected high-order page for auxbuf!" if
> it encounters one.
> 
> I don't know the intention of that check in SPE. Will ?

Since SPE uses virtual addressing, we don't really care about the underlying
page layout so there's no need to use higher-order allocations. I suppose we
could theoretically map them at the pmd level in some cases, but ignoring
them should also be harmless and I suspect you can delete the check.

Does the patch below fix the problem?

Will

--->8

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 7cb766dafe85..e120f933412a 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -855,16 +855,8 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
 	if (!pglist)
 		goto out_free_buf;
 
-	for (i = 0; i < nr_pages; ++i) {
-		struct page *page = virt_to_page(pages[i]);
-
-		if (PagePrivate(page)) {
-			pr_warn("unexpected high-order page for auxbuf!");
-			goto out_free_pglist;
-		}
-
+	for (i = 0; i < nr_pages; ++i)
 		pglist[i] = virt_to_page(pages[i]);
-	}
 
 	buf->base = vmap(pglist, nr_pages, VM_MAP, PAGE_KERNEL);
 	if (!buf->base)
