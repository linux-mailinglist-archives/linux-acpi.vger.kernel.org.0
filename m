Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC31B4EE
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2019 13:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfEMLbh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 May 2019 07:31:37 -0400
Received: from foss.arm.com ([217.140.101.70]:53270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfEMLbh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 May 2019 07:31:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EEAA374;
        Mon, 13 May 2019 04:31:36 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDCB63F703;
        Mon, 13 May 2019 04:31:33 -0700 (PDT)
Date:   Mon, 13 May 2019 12:31:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com,
        Hongbo Yao <yaohongbo@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v3 0/5] arm64: SPE ACPI enablement
Message-ID: <20190513113127.GA10384@e107155-lin>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
 <82032e5b-0cb5-e48f-ab51-ba5d5f9dceec@arm.com>
 <819de863-92ff-51c5-9c35-880db4f6a922@huawei.com>
 <20190508165149.GB21553@e107155-lin>
 <20190509092810.GC2667@brain-police>
 <20190509103559.GB8239@e107155-lin>
 <20190509141350.GF8239@e107155-lin>
 <20190513105631.GB6711@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513105631.GB6711@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 13, 2019 at 11:56:31AM +0100, Will Deacon wrote:
> Hi Sudeep,
> 
> On Thu, May 09, 2019 at 03:13:50PM +0100, Sudeep Holla wrote:
> > On Thu, May 09, 2019 at 11:35:59AM +0100, Sudeep Holla wrote:
> > > On Thu, May 09, 2019 at 10:28:11AM +0100, Will Deacon wrote:
> > 
> > [...]
> > 
> > > >
> > > > Since SPE uses virtual addressing, we don't really care about the underlying
> > > > page layout so there's no need to use higher-order allocations. I suppose we
> > > > could theoretically map them at the pmd level in some cases, but ignoring
> > > > them should also be harmless and I suspect you can delete the check.
> > > >
> > >
> > > Yes, I did a quick look to see if we can do that, but couldn't find a clue.
> > > Not sure if that's any optimisation, we can use order from page_private
> > > and set the values accordingly ?
> > >
> > And I forgot to add the diff that I mentioned above, something like the
> > patch below.
> > 
> > Regards,
> > Sudeep
> > 
> > -->8
> > 
> > diff --git i/drivers/perf/arm_spe_pmu.c w/drivers/perf/arm_spe_pmu.c
> > index 7cb766dafe85..45cd62517080 100644
> > --- i/drivers/perf/arm_spe_pmu.c
> > +++ w/drivers/perf/arm_spe_pmu.c
> > @@ -827,7 +827,7 @@ static void arm_spe_pmu_read(struct perf_event *event)
> >  static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
> >  				   int nr_pages, bool snapshot)
> >  {
> > -	int i, cpu = event->cpu;
> > +	int i, j, cpu = event->cpu;
> >  	struct page **pglist;
> >  	struct arm_spe_pmu_buf *buf;
> >  
> > @@ -859,11 +859,12 @@ static void *arm_spe_pmu_setup_aux(struct perf_event *event, void **pages,
> >  		struct page *page = virt_to_page(pages[i]);
> >  
> >  		if (PagePrivate(page)) {
> > -			pr_warn("unexpected high-order page for auxbuf!");
> > -			goto out_free_pglist;
> > +			for (j = 0; j < 1 << page_private(page); j++)
> > +				pglist[i + j] = page++;
> > +			i += j - 1;
> > +		} else {
> > +			pglist[i] = page;
> 
> Hmm. Given that vmap() doesn't do anything special for high-order pages
> and rb_alloc_aux()/rb_alloc_aux_page() already split the allocation up
> for the page array, what does your change accomplish on top of that?
> 

Not much, instead of computing page ptr for each page using virt_to_page,
we jump pointers automatically for all the pages that are private.

page_private(page) holds the order. i.e. for 2MB high order allocation
we can skip calling virt_to_page for 511 pages that are contiguous.

--
Regards,
Sudeep
