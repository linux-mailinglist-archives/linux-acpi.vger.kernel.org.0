Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DAB3A8D2B
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 02:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFPAHo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 20:07:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:36266 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhFPAHo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 15 Jun 2021 20:07:44 -0400
IronPort-SDR: hf4S2uovZeXw2cn4Bx41emCSDXqffMrutKfxUddfnYHHZ9DvWvJrE+IBqCA3fEs5OuSVwMnODf
 6I27X0C6AR3w==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204259375"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="204259375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:05:39 -0700
IronPort-SDR: ywOH5o7yatpSr79y6YjYml2p0nnSnpreYa0jvlJR9+rHcj8nV1uI5ya35favoSXdokE0TWmfee
 nrbKApEHWY4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="554619307"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2021 17:05:38 -0700
Date:   Tue, 15 Jun 2021 17:01:26 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/acpi: Use the ACPI CFMWS to create static
 decoder objects
Message-ID: <20210616000126.GA22435@alison-desk.jf.intel.com>
References: <cover.1623705308.git.alison.schofield@intel.com>
 <0246fe923945ba2b8d885f45279d7d3956c46950.1623705308.git.alison.schofield@intel.com>
 <CAPcyv4houyD9PGG4PKiO7OiHkKEZD81=tVSzr_PTShHBzx956A@mail.gmail.com>
 <20210615210518.GA22172@alison-desk.jf.intel.com>
 <CAPcyv4jeaJwgOMWyCjQy_32gPhSq2T-7JfwRPAmDCg5qMEB+kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jeaJwgOMWyCjQy_32gPhSq2T-7JfwRPAmDCg5qMEB+kg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 15, 2021 at 03:01:06PM -0700, Dan Williams wrote:
> On Tue, Jun 15, 2021 at 2:09 PM Alison Schofield
> <alison.schofield@intel.com> wrote:
> >
> > Thanks for the review Dan...
> >
> > On Tue, Jun 15, 2021 at 11:48:43AM -0700, Dan Williams wrote:
> > > [ add linu-acpi for variable length array question below ]
> > >
> > >
> > > On Mon, Jun 14, 2021 at 3:57 PM Alison Schofield
> > > <alison.schofield@intel.com> wrote:
> > > >
> > > > The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> > > > resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> > > > CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> > > > for each memory resource.
> > > >
> > > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > > ---
> > > >  drivers/cxl/acpi.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 106 insertions(+)
> > > >
> > > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > > index 16f60bc6801f..ac4b3e37e294 100644
> > > > --- a/drivers/cxl/acpi.c
> > > > +++ b/drivers/cxl/acpi.c
> > > > @@ -8,8 +8,112 @@
> > > >  #include <linux/pci.h>
> > > >  #include "cxl.h"
> > > >
> > > > +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > > > +#define CFMWS_INTERLEAVE_WAYS(x)       (1 << (x)->interleave_ways)
> > > > +#define CFMWS_INTERLEAVE_GRANULARITY(x)        ((x)->granularity + 8)
> > > > +
> > > > +/*
> > > > + * CFMWS Restrictions mapped to CXL Decoder Flags
> > > > + * Restrictions defined in CXL 2.0 ECN CEDT CFMWS
> > > > + * Decoder Flags defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register
> > > > + */
> > > > +#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
> > > > +#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
> > > > +#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
> > > > +#define CFMWS_TO_DECODE_PMEM(x)         ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
> > > > +#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> > > > +
> > > > +#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
> > > > +                                  CFMWS_TO_DECODE_TYPE3(x) | \
> > > > +                                  CFMWS_TO_DECODE_RAM(x)   | \
> > > > +                                  CFMWS_TO_DECODE_PMEM(x)  | \
> > > > +                                  CFMWS_TO_DECODE_FIXED(x))
> > >
> > > I don't understand the approach taken above. It seems to assume that
> > > the CXL_DECODER_F_* values are fixed. Those flag values are arbitrary
> > > and mutable. There is no guarantee that today's CXL_DECODER_F_* values
> > > match tomorrow's so I'd rather not have 2 places to check when / if
> > > that happens.
> > >
> >
> > Here's my next take - making the handling resilient.
> > Not so sure on gracefulness. Open for suggestions.
> >
> > -#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
> > -#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
> > -#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
> > -#define CFMWS_TO_DECODE_PMEM(x)         ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
> > -#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> > -
> > -#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
> > -                                  CFMWS_TO_DECODE_TYPE3(x) | \
> > -                                  CFMWS_TO_DECODE_RAM(x)   | \
> > -                                  CFMWS_TO_DECODE_PMEM(x)  | \
> > -                                  CFMWS_TO_DECODE_FIXED(x))
> > +#define FLAG_TYPE2(x) \
> > +       ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) ? CXL_DECODER_F_TYPE2 : 0)
> > +#define FLAG_TYPE3(x) \
> > +       ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) ? CXL_DECODER_F_TYPE3 : 0)
> > +#define FLAG_RAM(x) \
> > +       ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) ? CXL_DECODER_F_RAM : 0)
> > +#define FLAG_PMEM(x) \
> > +       ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) ? CXL_DECODER_F_PMEM : 0)
> > +#define FLAG_FIXED(x) \
> > +       ((x & ACPI_CEDT_CFMWS_RESTRICT_FIXED) ? CXL_DECODER_F_LOCK : 0)
> > +
> > +#define CFMWS_TO_DECODER_FLAGS(x) (FLAG_TYPE2(x) | FLAG_TYPE3(x) | \
> > +                                  FLAG_RAM(x) | FLAG_PMEM(x)| FLAG_FIXED(x))
> 
> Hmm, why the macros? Just make CFMWS_TO_DECODER_FLAGS a proper function.
> 
> if (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
>     flags |= CXL_DECODER_F_TYPE2;
> 
> ...etc
> 
> Unless you foresee where macros were going to be reused somewhere else
> I would just as soon open code them like above.

Open code it is!
Thanks
