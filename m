Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12E93AA75D
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 01:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhFPXWd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 19:22:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:36377 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234476AbhFPXWc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 19:22:32 -0400
IronPort-SDR: d4EpS/lH6Fy1KkpAgVZZtHEtGJLy4tOSf0ZXvpi933qAZXzgHr7NcEZQUGS53cOSNP7CTTh1al
 FkkgmOk2DQgQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="227779360"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="227779360"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 16:20:26 -0700
IronPort-SDR: pjY7FIAdQh0dp9coSjHRg2+VttGYFEZ0zoV7gU2XDsJ3RMTO9XwdHbAb86j2gNlIWShPtjCops
 t8BZX1u4mLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479267847"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 16:20:25 -0700
Date:   Wed, 16 Jun 2021 16:16:10 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/acpi: Add the Host Bridge base address to CXL
 port objects
Message-ID: <20210616231610.GB25185@alison-desk.jf.intel.com>
References: <cover.1623800340.git.alison.schofield@intel.com>
 <e841b0283edcc281ff31e98e4d3512be3a131c6a.1623800340.git.alison.schofield@intel.com>
 <20210616171340.00005295@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616171340.00005295@Huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Thanks for the review Jonathan -

On Wed, Jun 16, 2021 at 05:13:40PM +0100, Jonathan Cameron wrote:
> On Tue, 15 Jun 2021 17:20:38 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > The base address for the Host Bridge port component registers is located
> > in the CXL Host Bridge Structure (CHBS) of the ACPI CXL Early Discovery
> > Table (CEDT). Retrieve the CHBS for each Host Bridge (ACPI0016 device)
> > and include that base address in the port object.
> > 
> > Co-developed-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Hi Alison,
> 
> A few small suggestions from me.
> 
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
> > +
> > +static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
> > +{
> > +	struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
> > +	acpi_size len, cur = 0;
> > +	void *cedt_base;
> > +	int rc = 0;
> > +
> > +	len = cedt_table->length - sizeof(*cedt_table);
> > +	cedt_base = cedt_table + 1;
> > +
> > +	while (cur < len) {
> > +		struct acpi_cedt_header *c = cedt_base + cur;
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
> 
> As below, direct return would be more obvious to my eyes.
> 

Well....I decided to warn & continue on this case. See the updated flow
in v3.

> > +			break;
> > +		}
> > +
> > +		if (chbs->uid == uid && !chbs_match) {
> > +			chbs_match = chbs;
> > +			cur += c->length;
> > +			continue;
> > +		}
> > +
> > +		if (chbs->uid == uid && chbs_match) {
> > +			dev_err(dev, "Duplicate CHBS UIDs %u\n", uid);
> 
> Do we actually care, or should we just drop out on first match?
> I don't think think there is any obligation to catch broken tables.
> 

Agree on the obligation part, but if things go wrong, this would be
nice to know. I left it in as a dev warn once. If you think that's 
too strong - let me know.


> > +			rc = -EINVAL;
> 
> Direct return might be easier to follow.
> 			return ERR_PTR(-EINVAL);
> 
> > +			break;
> > +		}
> 
> Maybe more readable as (your option is fine if you prefer it).
> 
> 		if (chbs->uuid != uid) {
> 			cur += c->length;
> 			continue;
> 		}
> 
> 		if (chbs_match) {
> 			dev_err(dev, "D...");
> 			return ERR_PTR(-EINVAL);
> 		}
> 
> 		chbs_match = chbs;
> 
> 

Thanks, I reworked the flow along these lines.


snip
> > +
> > +	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
> > +				 root_port);
> > +
> 
> Nitpick, no blank line before error handling block.
> 

Got it. Thanks!

snip
