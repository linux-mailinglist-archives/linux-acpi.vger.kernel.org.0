Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A65638BE9
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 15:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfFGNsD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jun 2019 09:48:03 -0400
Received: from foss.arm.com ([217.140.110.172]:40404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbfFGNsD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jun 2019 09:48:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 617BF337;
        Fri,  7 Jun 2019 06:48:02 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAE143F718;
        Fri,  7 Jun 2019 06:48:00 -0700 (PDT)
Date:   Fri, 7 Jun 2019 14:47:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 3/5] ACPI/PPTT: Modify node flag detection to find
 last IDENTICAL
Message-ID: <20190607134758.GB15577@e107155-lin>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-4-jeremy.linton@arm.com>
 <20190607095353.GC2429@e107155-lin>
 <1db40fa0-9834-5607-ec1c-794480e5c514@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1db40fa0-9834-5607-ec1c-794480e5c514@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 07, 2019 at 08:15:50AM -0500, Jeremy Linton wrote:
> Hi,
> 
> Thanks for taking a look at this.
> 
> On 6/7/19 4:53 AM, Sudeep Holla wrote:
> > On Fri, May 03, 2019 at 06:24:05PM -0500, Jeremy Linton wrote:
> > > The ACPI specification implies that the IDENTICAL flag should be
> > > set on all non leaf nodes where the children are identical.
> > > This means that we need to be searching for the last node with
> > > the identical flag set rather than the first one.
> > > 
> > > Since this flag is also dependent on the table revision, we
> > > need to add a bit of extra code to verify the table revision,
> > > and the next node's state in the traversal. Since we want to
> > > avoid function pointers here, lets just special case
> > > the IDENTICAL flag.
> > > 
> > > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > > ---
> > >   drivers/acpi/pptt.c | 28 +++++++++++++++++++++++++---
> > >   1 file changed, 25 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > > index 1865515297ca..456e1c0a35ae 100644
> > > --- a/drivers/acpi/pptt.c
> > > +++ b/drivers/acpi/pptt.c
> > > @@ -432,17 +432,39 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
> > >   	}
> > >   }
> > > +static bool flag_identical(struct acpi_table_header *table_hdr,
> > > +			  struct acpi_pptt_processor *cpu)
> > 
> > Not sure if it's email client problem, but I see quite a few mis-alignment
> > with parenthesis like above one.
> 
> It looks fine in the original editor/text patch, but yes in my email client
> I see it off by one (or two/three now that i'm replying). Its a mix of
> tabs/spaces and I've seen this happen before in my email client due to the
> leading "[>+]"?
>

No I have configured(hopefully correctly) my client, but if you not seeing
issue with patch, that's fine.

> 
> > 
> > > +{
> > > +	struct acpi_pptt_processor *next;
> > > +
> > > +	/* heterogeneous machines must use PPTT revision > 1 */
> > > +	if (table_hdr->revision < 2)
> > > +		return false;
> > > +
> > > +	/* Locate the last node in the tree with IDENTICAL set */
> > > +	if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
> > > +		next = fetch_pptt_node(table_hdr, cpu->parent);
> > > +		if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
> > > +			return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > >   /* Passing level values greater than this will result in search termination */
> > >   #define PPTT_ABORT_PACKAGE 0xFF
> > > -static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
> > > +static struct acpi_pptt_processor *acpi_find_processor_tag_id(struct acpi_table_header *table_hdr,
> > >   								  struct acpi_pptt_processor *cpu,
> > >   								  int level, int flag)
> > >   {
> > >   	struct acpi_pptt_processor *prev_node;
> > >   	while (cpu && level) {
> > > -		if (cpu->flags & flag)
> > > +		if (flag == ACPI_PPTT_ACPI_IDENTICAL) {
> > 
> > flag_identical anyways check the flag, so I assume you can drop the above
> > check.
> 
> ? I think that would be a bug because then we would always be returning the
> value of the IDENTICAL flag rather than the other flags passed into this
> routine. This is the special case I think Raphael was asking for rather than
> the function pointer/callback interface.
>

Ah OK, got it. Worth a comment ? I am sure I will forget next time I see this.

--
Regards,
Sudeep

