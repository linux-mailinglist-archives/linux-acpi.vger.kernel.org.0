Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE03AA74D
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 01:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhFPXSR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 19:18:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:36141 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234364AbhFPXSR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 19:18:17 -0400
IronPort-SDR: mCrqcvpDm0KodAI/3lrFE/+rt9N+ailDaHwtjPenv9e//bce8Ztb9NSwIyC+/GoOeTRQyHDet5
 Q3sRPZW3WP0w==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="227778821"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="227778821"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 16:16:10 -0700
IronPort-SDR: QEB0nCtcQDbfd2iL9XbdtZmiPBj3V+5e+bpkDfzovMfKb1y4dKe/IUcJ65uFG5hfDAqPPG68Y+
 WibriOKCa5yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="472210731"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga004.fm.intel.com with ESMTP; 16 Jun 2021 16:16:10 -0700
Date:   Wed, 16 Jun 2021 16:11:54 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/acpi: Add the Host Bridge base address to CXL
 port objects
Message-ID: <20210616231154.GA25185@alison-desk.jf.intel.com>
References: <cover.1623800340.git.alison.schofield@intel.com>
 <e841b0283edcc281ff31e98e4d3512be3a131c6a.1623800340.git.alison.schofield@intel.com>
 <20210616160816.ollsqeyhpnjm5oq2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616160816.ollsqeyhpnjm5oq2@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Thanks for the review Ben -

On Wed, Jun 16, 2021 at 09:08:16AM -0700, Ben Widawsky wrote:
> On 21-06-15 17:20:38, Alison Schofield wrote:
> > The base address for the Host Bridge port component registers is located
> > in the CXL Host Bridge Structure (CHBS) of the ACPI CXL Early Discovery
> > Table (CEDT). Retrieve the CHBS for each Host Bridge (ACPI0016 device)
> > and include that base address in the port object.
> > 
> > Co-developed-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/acpi.c | 105 ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 99 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index be357eea552c..b6d9cd45428c 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -8,6 +8,61 @@
> >  #include <linux/pci.h>
> >  #include "cxl.h"
> >  
> > +static struct acpi_table_header *cedt_table;
> 
> cedt_header would really be a better name. "Table" is redundant as the 't' in
> CEDT is table.
> 

Agree. Renamed to acpi_cedt in v3. See if you like.

> > +
> > +static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
> > +{
> > +	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
> > +	acpi_size len, cur = 0;
> > +	void *cedt_base;
> 
> maybe "cedt_body", or "cedt_subtables"

got it in v3.

> 
> > +	int rc = 0;
> > +
> > +	len = cedt_table->length - sizeof(*cedt_table);
> > +	cedt_base = cedt_table + 1;
> 
> As per naming recommendation above, this looks really funny...
> 
:)
> > +
> > +	while (cur < len) {
> > +		struct acpi_cedt_header *c = cedt_base + cur;
> 
> Okay, now I see why you may have not called the previous thing a header.
> 
> > +
> > +		if (c->type != ACPI_CEDT_TYPE_CHBS) {
> > +			cur += c->length;
> > +			continue;
> > +		}
> > +
> > +		chbs = cedt_base + cur;
> > +
> > +		if (chbs->header.length < sizeof(*chbs)) {
> > +			dev_err(dev, "Invalid CHBS header length: %u\n",
> > +				chbs->header.length);
> > +			rc = -EINVAL;
> > +			break;
> > +		}
> 
> I'd just continue here. Maybe there will be another chbs with the correct size.
>

Got it.

> > +
> > +		if (chbs->uid == uid && !chbs_match) {
> > +			chbs_match = chbs;
> > +			cur += c->length;
> > +			continue;
> > +		}
> > +
> > +		if (chbs->uid == uid && chbs_match) {
> > +			dev_err(dev, "Duplicate CHBS UIDs %u\n", uid);
> > +			rc = -EINVAL;
> > +			break;
> > +		}
> 
> I'd also just continue here. I think if we have a match, we can just use it and
> ignore BIOS bugs. I'd probably write it like this:
> 
> if (chbs->uid == uid) {
> 	dev_WARN_ONCE(dev, chbs_match, "Duplicate CHBS UIDs %u\n", uid);
> 	chbs_match = chbs; /* last one wins */
> 	cur += c->length;
> 	continue;
> }
> 
> Up to you how you actually write it, but do consider not failing here.
>

Thanks for the snippet. I added the dev_WARN_ONCE to both the length
mismatch and duplicate cases. 


> > +		cur += c->length;
> > +	}
> > +	if (!chbs_match)
> > +		rc = -EINVAL;
> 
> Maybe ENODEV or something like it is more appropriate?

Got it.

> 
snip
