Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E423AA76E
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 01:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbhFPX2E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 19:28:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:36881 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234567AbhFPX2C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Jun 2021 19:28:02 -0400
IronPort-SDR: RtXxcDWhcxXSZ66fUoHQ+NlY139/rn0KVsW3WIIwfl3L3CsIz8+3t9dbJMrYSFodtiFl0PYb9o
 K4xyCL9lTKGg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="227779859"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="227779859"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 16:25:56 -0700
IronPort-SDR: 3cRE5Tui5GBfKWOAu7cW2A0ttwMJ2m71Cos/ouf6iZUfuDK13f3Z1hsV/rcINsJAaMO4AVcCvh
 bbuAVeEMbKpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="479269041"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2021 16:25:56 -0700
Date:   Wed, 16 Jun 2021 16:21:40 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/acpi: Use the ACPI CFMWS to create static
 decoder objects
Message-ID: <20210616232140.GC25185@alison-desk.jf.intel.com>
References: <cover.1623800340.git.alison.schofield@intel.com>
 <48f1b59105e46f04b38347fc1555bb5c8d654cff.1623800340.git.alison.schofield@intel.com>
 <20210616161740.k4nxeh3bmem56gwa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616161740.k4nxeh3bmem56gwa@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Thanks for the review Ben -

On Wed, Jun 16, 2021 at 09:17:40AM -0700, Ben Widawsky wrote:
> On 21-06-15 17:20:39, Alison Schofield wrote:

snip

> > +static unsigned long cfmws_to_decoder_flags(int restrictions)
> > +{
> > +	unsigned long flags = 0;
> > +
> > +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> > +		flags |= CXL_DECODER_F_TYPE2;
> > +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> > +		flags |= CXL_DECODER_F_TYPE3;
> > +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> > +		flags |= CXL_DECODER_F_RAM;
> > +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> > +		flags |= CXL_DECODER_F_PMEM;
> > +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> > +		flags |= CXL_DECODER_F_LOCK;
> > +
> > +	return flags;
> > +}
> 
> I know these flags aren't introduced by this patch, but I'm wondering if it
> makes sense to not just use the spec definitions rather than defining our own.
> It doesn't do much harm, but it's extra typing everytime the spec adds new flags
> and I don't really see the upside.
> 

I think Dan's email in this thread covered this.

snip
> > +
> > +static int cxl_acpi_cfmws_verify(struct device *dev,
> > +				 struct acpi_cedt_cfmws *cfmws)
> > +{

snip

> > +
> > +
> > +	expected_len = struct_size((cfmws), interleave_targets,
> > +				   CFMWS_INTERLEAVE_WAYS(cfmws));
> > +
> > +	if (expected_len != cfmws->header.length) {
> 
> I'd switch this to:
> if (expected_len < cfmws->header.length)
> 
> If it's too big, just print a dev_dbg.
> 

Got it. 

snip

> > +	void *cedt_base;
> > +	int rc;
> > +
> > +	len = cedt_table->length - sizeof(*cedt_table);
> > +	cedt_base = cedt_table + 1;
> 
> naming suggestions per previous patch... up to you though.
>

Ditto w previous patch.

snip
> > +
> > +		}
> > +
> > +		cxld = devm_cxl_add_decoder(dev, root_port,
> > +				CFMWS_INTERLEAVE_WAYS(cfmws),
> > +				cfmws->base_hpa, cfmws->window_size,
> > +				CFMWS_INTERLEAVE_WAYS(cfmws),
> 
> Interesting... this made me question, how can we have a different number of
> targets and ways?
> 

Dan explained this previously:

"nr_targets is the number of possible targets that this decoder can
target. For CFMWS it just equals interleave_ways because the target
list can't be changed. A switch on the other hand could support up to
16 possible targets, but be dynamically configured to only do a 1-way
interleave. So this is an artifact of 'struct cxl_decoder'
representing both fixed CFMWS entries and dynamically programmable
switch entries. nr_targets tells devm_cxl_add_decoder() how much
memory to allocate for its target list, interleave_ways tells
devm_cxl_add_decoder() what the decoder is currently programmed to
decode."


> 
snip
> 
