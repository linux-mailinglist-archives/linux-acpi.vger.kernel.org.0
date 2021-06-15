Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82973A8B89
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jun 2021 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhFOWDW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Jun 2021 18:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhFOWDW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Jun 2021 18:03:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E08C061574
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 15:01:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o21so62026pll.6
        for <linux-acpi@vger.kernel.org>; Tue, 15 Jun 2021 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAW0zh0lnrneDmrUJXzBCI0coVLuVRYrnPiW+I/zDg8=;
        b=dUCqcuVG9dMBPasm8laBVdwM1G4BkryuVauvy6BFE6SqaWlfBSH0CxTSBQGVGaZcX+
         /rEday4Tyl8dGM2Dd/hedSpI/A+jd/Lv8lj4BLZjwXj1VgxBYhgkbvJRwhwZguZ/g1tQ
         IRmCRxBsqoprSSOjzBLpx++MdTDnvqpivoMb6LGOSS6aFndQGU18O9IyRstFPRTfr86D
         b4DMTMdUUyssRjdK+qQpNiE1xBVWa0Y+DEE1fhCLf7/6G3pLMh8URjWSIVCIHBEEnTrx
         bsaCJck5RYJ74jw8qK3Qb1LW8bZtQnvG6iH7IRM18qq6n4htUgORN/X4BFFO063YApke
         7BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAW0zh0lnrneDmrUJXzBCI0coVLuVRYrnPiW+I/zDg8=;
        b=Rw+7xqrYERXHzv6YCbf83bZlplSWlAA5aofit9x9422TVSjydR3bkYXSkbDOxn3soI
         bRtj8+y9ehsYKs3ysY4YKl0z7koQ+/3NKrtBJDBy5kVb8yh1uwhJqyjRs1BWhckR2YEq
         EF3KNKsNNfNMr9v9/b9E0tBFjcPjYkaWSnc78Je+NzudcD9UCOp57vPMERVfiSCiwOpG
         jF723GSOn3j4s3FX3q+tOhEkGe18Z+72YZ8zOEzPNWGGH3OZTzQfisfhBolb5RUhNbSU
         2XuBWthYYkhXd3+cUAQgfOhS8aECnZMud/YUXmEIa9ts12GaZzv6s8GlOor0RWZ6hx3T
         +n2g==
X-Gm-Message-State: AOAM533/5vpFwhYHDxkwgrAYXXBOvBsRb9Ld3eB9LpnyGO1OsSacJGaZ
        ffEqA3kPbv2XhgYs0fbR/iF01Co9qeboa4RWyX061/8QMdhVSQ==
X-Google-Smtp-Source: ABdhPJxVLbIa/upTKs14f5ukhtRdhj+iRvpV3ZgffOhIHJ/aX884+EuJPrDwe+iPKmTxWwkYMldjCnoBL1a2ZaYJ5CA=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr7230964pjb.13.1623794476682;
 Tue, 15 Jun 2021 15:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623705308.git.alison.schofield@intel.com>
 <0246fe923945ba2b8d885f45279d7d3956c46950.1623705308.git.alison.schofield@intel.com>
 <CAPcyv4houyD9PGG4PKiO7OiHkKEZD81=tVSzr_PTShHBzx956A@mail.gmail.com> <20210615210518.GA22172@alison-desk.jf.intel.com>
In-Reply-To: <20210615210518.GA22172@alison-desk.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jun 2021 15:01:06 -0700
Message-ID: <CAPcyv4jeaJwgOMWyCjQy_32gPhSq2T-7JfwRPAmDCg5qMEB+kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cxl/acpi: Use the ACPI CFMWS to create static decoder objects
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 15, 2021 at 2:09 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> Thanks for the review Dan...
>
> On Tue, Jun 15, 2021 at 11:48:43AM -0700, Dan Williams wrote:
> > [ add linu-acpi for variable length array question below ]
> >
> >
> > On Mon, Jun 14, 2021 at 3:57 PM Alison Schofield
> > <alison.schofield@intel.com> wrote:
> > >
> > > The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> > > resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> > > CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> > > for each memory resource.
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/acpi.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 106 insertions(+)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 16f60bc6801f..ac4b3e37e294 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -8,8 +8,112 @@
> > >  #include <linux/pci.h>
> > >  #include "cxl.h"
> > >
> > > +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > > +#define CFMWS_INTERLEAVE_WAYS(x)       (1 << (x)->interleave_ways)
> > > +#define CFMWS_INTERLEAVE_GRANULARITY(x)        ((x)->granularity + 8)
> > > +
> > > +/*
> > > + * CFMWS Restrictions mapped to CXL Decoder Flags
> > > + * Restrictions defined in CXL 2.0 ECN CEDT CFMWS
> > > + * Decoder Flags defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register
> > > + */
> > > +#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
> > > +#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
> > > +#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
> > > +#define CFMWS_TO_DECODE_PMEM(x)         ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
> > > +#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> > > +
> > > +#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
> > > +                                  CFMWS_TO_DECODE_TYPE3(x) | \
> > > +                                  CFMWS_TO_DECODE_RAM(x)   | \
> > > +                                  CFMWS_TO_DECODE_PMEM(x)  | \
> > > +                                  CFMWS_TO_DECODE_FIXED(x))
> >
> > I don't understand the approach taken above. It seems to assume that
> > the CXL_DECODER_F_* values are fixed. Those flag values are arbitrary
> > and mutable. There is no guarantee that today's CXL_DECODER_F_* values
> > match tomorrow's so I'd rather not have 2 places to check when / if
> > that happens.
> >
>
> Here's my next take - making the handling resilient.
> Not so sure on gracefulness. Open for suggestions.
>
> -#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
> -#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
> -#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
> -#define CFMWS_TO_DECODE_PMEM(x)         ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
> -#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> -
> -#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
> -                                  CFMWS_TO_DECODE_TYPE3(x) | \
> -                                  CFMWS_TO_DECODE_RAM(x)   | \
> -                                  CFMWS_TO_DECODE_PMEM(x)  | \
> -                                  CFMWS_TO_DECODE_FIXED(x))
> +#define FLAG_TYPE2(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) ? CXL_DECODER_F_TYPE2 : 0)
> +#define FLAG_TYPE3(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) ? CXL_DECODER_F_TYPE3 : 0)
> +#define FLAG_RAM(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) ? CXL_DECODER_F_RAM : 0)
> +#define FLAG_PMEM(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) ? CXL_DECODER_F_PMEM : 0)
> +#define FLAG_FIXED(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_FIXED) ? CXL_DECODER_F_LOCK : 0)
> +
> +#define CFMWS_TO_DECODER_FLAGS(x) (FLAG_TYPE2(x) | FLAG_TYPE3(x) | \
> +                                  FLAG_RAM(x) | FLAG_PMEM(x)| FLAG_FIXED(x))

Hmm, why the macros? Just make CFMWS_TO_DECODER_FLAGS a proper function.

if (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
    flags |= CXL_DECODER_F_TYPE2;

...etc

Unless you foresee where macros were going to be reused somewhere else
I would just as soon open code them like above.
