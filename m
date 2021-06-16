Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BD03AA7BB
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 01:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhFPXxJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Jun 2021 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhFPXxI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Jun 2021 19:53:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A84C061574
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 16:51:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y15so3516870pfl.4
        for <linux-acpi@vger.kernel.org>; Wed, 16 Jun 2021 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUKGZQ5t19Qy+tZDlwlkuIB63RRAOakgC6Mx9D2w6yU=;
        b=q37usVIc65VDGwEYlRnvalUQ1PX/52xHdou3EfQNrLSNVY5LxGD2YD2rNo2aqsl7ty
         TmD6AKPabKUwDuzOGBf9uyTXl+8bS92hZPy5+JjqJF+2Is+IoCxFrzAUY4WPXlTKcmrd
         7tX3yxsVY3aHgNaOTr70DJnRnftZbDKNuPs4ikEh6xBwgQ/i3PD/OWh/8JmDDO+LjO93
         z5qbn9HO2XmyA6auqlUvnOgKCkgGjSrD2zD7TYimFUjVQJB7m0Or183iGpn1Ij1tfGRg
         lXnl9kEHl0SED2Rxp92YuXXXVNn+/yuw6t5U2qjp5a05m0Ac79ECm+mJqhUc7EEhFK7R
         VsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUKGZQ5t19Qy+tZDlwlkuIB63RRAOakgC6Mx9D2w6yU=;
        b=sJC4lsa7bqlqSYyurvMbD7oWvI8c66A4d04sk0NzrcjrEAdOf1+kO1b2AcGDhzovRb
         PpFMhC5hf+mnMVWbjxCYaiYRg9iSCiIUfTBG3C4v1+Z0kb6WVXTSLnoVzzfeEvPsFN8v
         NGT5GioaGjk72Mpq/uOoF0wEwTcVrK4adNKsFeSHt7jdlUHyA11BKGArdM0z3FUc0mXd
         PfCpE2AS391kG0CuxRS4FgYAJvHczGCbWe+bR0En5CeRfj1zi2dYmHR0ZnAvogWd+eIk
         OUsxO2vwjn/VuqTDHPL3PcFoUKx4KfY9FuPP1OxCVqbaRUMUv8CJf4kx+MkYm4HTWCGc
         WPzA==
X-Gm-Message-State: AOAM530E6XRjUBF0ZNXU/WXlVePLVUUKBDO7mQNbK68zni6fzElBG4ZU
        4zKdRNAYoBBUPnNtIjZwkA9Jyh55f2OPJCb66JXRFw==
X-Google-Smtp-Source: ABdhPJx9w0rqkda+k8Hwa8eJjB+5o6ZaWSJXMtoVaQ8BM9HhG6qHPfnjWA9Svr0vC1inWXtvPWoEOvWeSZN6ysdLEkE=
X-Received: by 2002:a63:4653:: with SMTP id v19mr2163346pgk.240.1623887461396;
 Wed, 16 Jun 2021 16:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623800340.git.alison.schofield@intel.com>
 <e841b0283edcc281ff31e98e4d3512be3a131c6a.1623800340.git.alison.schofield@intel.com>
 <20210616171340.00005295@Huawei.com> <20210616231610.GB25185@alison-desk.jf.intel.com>
In-Reply-To: <20210616231610.GB25185@alison-desk.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Jun 2021 16:50:50 -0700
Message-ID: <CAPcyv4hzQiNP29d1NKki+WMFck_TtUfW_Mn-wxtJ5AzZLMBx=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cxl/acpi: Add the Host Bridge base address to CXL
 port objects
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 4:20 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
>
> Thanks for the review Jonathan -
>
> On Wed, Jun 16, 2021 at 05:13:40PM +0100, Jonathan Cameron wrote:
> > On Tue, 15 Jun 2021 17:20:38 -0700
> > Alison Schofield <alison.schofield@intel.com> wrote:
> >
> > > The base address for the Host Bridge port component registers is located
> > > in the CXL Host Bridge Structure (CHBS) of the ACPI CXL Early Discovery
> > > Table (CEDT). Retrieve the CHBS for each Host Bridge (ACPI0016 device)
> > > and include that base address in the port object.
> > >
> > > Co-developed-by: Vishal Verma <vishal.l.verma@intel.com>
> > > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> >
> > Hi Alison,
> >
> > A few small suggestions from me.
> >
> > > ---
> > >  drivers/cxl/acpi.c | 105 ++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 99 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index be357eea552c..b6d9cd45428c 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -8,6 +8,61 @@
> > >  #include <linux/pci.h>
> > >  #include "cxl.h"
> > >
> > > +static struct acpi_table_header *cedt_table;
> > > +
> > > +static struct acpi_cedt_chbs *cxl_acpi_match_chbs(struct device *dev, u32 uid)
> > > +{
> > > +   struct acpi_cedt_chbs *chbs, *chbs_match = NULL;
> > > +   acpi_size len, cur = 0;
> > > +   void *cedt_base;
> > > +   int rc = 0;
> > > +
> > > +   len = cedt_table->length - sizeof(*cedt_table);
> > > +   cedt_base = cedt_table + 1;
> > > +
> > > +   while (cur < len) {
> > > +           struct acpi_cedt_header *c = cedt_base + cur;
> > > +
> > > +           if (c->type != ACPI_CEDT_TYPE_CHBS) {
> > > +                   cur += c->length;
> > > +                   continue;
> > > +           }
> > > +
> > > +           chbs = cedt_base + cur;
> > > +
> > > +           if (chbs->header.length < sizeof(*chbs)) {
> > > +                   dev_err(dev, "Invalid CHBS header length: %u\n",
> > > +                           chbs->header.length);
> > > +                   rc = -EINVAL;
> >
> > As below, direct return would be more obvious to my eyes.
> >
>
> Well....I decided to warn & continue on this case. See the updated flow
> in v3.
>
> > > +                   break;
> > > +           }
> > > +
> > > +           if (chbs->uid == uid && !chbs_match) {
> > > +                   chbs_match = chbs;
> > > +                   cur += c->length;
> > > +                   continue;
> > > +           }
> > > +
> > > +           if (chbs->uid == uid && chbs_match) {
> > > +                   dev_err(dev, "Duplicate CHBS UIDs %u\n", uid);
> >
> > Do we actually care, or should we just drop out on first match?
> > I don't think think there is any obligation to catch broken tables.
> >
>
> Agree on the obligation part, but if things go wrong, this would be
> nice to know. I left it in as a dev warn once. If you think that's
> too strong - let me know.

I do think the driver should care about duplicate UID, but only if
"version, base, or length" mismatch. If the BIOS gives us ambiguous
answers about where the registers are located, the user should be
warned that the driver might be picking the "wrong" one by accident.
If they are identical, the BIOS is being repetitive, but no real harm
that the driver would care about. A dev_warn_once() sounds good as the
first duplicate should be sufficient to say something fishy is afoot,
but it's not an error. The warn_once will also re-trigger when / if
the module is reloaded.
