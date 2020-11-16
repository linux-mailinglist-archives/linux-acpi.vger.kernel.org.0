Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EF22B54DA
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 00:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKPXTy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 18:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPXTy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 18:19:54 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC644C0613CF
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2020 15:19:53 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f20so26833706ejz.4
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2020 15:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDdIk6WlWEtTD2Qka3gH6AjvLJ6me8YyVBGtt6+aSYw=;
        b=tOVwTthF+oRBzodNyAt892de12QeK9YVh1NmdZDEO+ofR5XYuXmTL3i9RBUf1+aETa
         RFVLgVUdfHsJXcJtqXevWAzkAtkndhrk79ZB22Fl8dcQotGg81UcrLrkDgUhpDOaSjHh
         qf30FSMAco1R758G8XGSN9+HqOguswlRzXbLpMVGufhvficKr1nnXpS/BeLzuW5kOZ6H
         uijgCE4hItLT9gGhIkQTXdNWeJkMYVAtXYtoOwJfCr6bcEYae5leuL9ItdATzLxakHVQ
         4Rgjwz3eq5uaVsvwQM3cUacE/x49Pg3gkJjvuwNG3Ko7T9/bynZN8PNor+wMDpL/mDkz
         6ZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDdIk6WlWEtTD2Qka3gH6AjvLJ6me8YyVBGtt6+aSYw=;
        b=kTi3oB0cH/YatP77/aWvmrkaEXh/5QUVrGWzbVvE+6jQrTvcWa+lk0IU69tRi8KKT9
         chhxJfttwwd4uJNVpWk7PwdtpFgltYy7A58ZG5DUiW/NqubLFG32w0Gw+fvlLDzxPJK8
         XhGGsIbUu5U3GfUbz49rdSU0EIXzdifBv4eOc6IrYmQJTbPKYawdPpQqFMBkMmr0EG8K
         0/OxLSzyFdC2GstOR6HngK+q1hWAkmrMOlaozomnaaD1XXYai0WC1qV/gbvKiO2PDgck
         AqXbiqWQNIQuxPG9XDH57EsutmNXUrGe7K89Hk1YdxQtZVVQEh/XhD/+n6iWI+rSre+F
         CMnw==
X-Gm-Message-State: AOAM5314sJ9/f1BcWTrTt/D5iUcAOdPeqEMdN6TaWvUyTBdLaYY0tTSi
        uhlo5nX8osyh4yVfsEXvVuEUwHFsf0BDnatE/z1Bcg==
X-Google-Smtp-Source: ABdhPJzPQBGGcW9pfRJd5nLo2pEUfKE5CqOYKsFWCIec639zZd/SeYHb1n/2m2TEOfzs9ZAm9D9yHborvu9fdysdK2A=
X-Received: by 2002:a17:906:241b:: with SMTP id z27mr16049093eja.418.1605568792690;
 Mon, 16 Nov 2020 15:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-5-ben.widawsky@intel.com>
 <20201113181732.GA1121121@bjorn-Precision-5520> <20201114011225.lzhrbk3sszw2a7m6@intel.com>
In-Reply-To: <20201114011225.lzhrbk3sszw2a7m6@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 16 Nov 2020 15:19:41 -0800
Message-ID: <CAPcyv4j+zbns+WhnxWXCdoxa=QN40BFXUpmb=04q36H1sX-aBw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] cxl/mem: Map memory device registers
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 13, 2020 at 5:12 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 20-11-13 12:17:32, Bjorn Helgaas wrote:
> > On Tue, Nov 10, 2020 at 09:43:51PM -0800, Ben Widawsky wrote:
> > > All the necessary bits are initialized in order to find and map the
> > > register space for CXL Memory Devices. This is accomplished by using the
> > > Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
> > > use, and how much of an offset from that BAR should be added.
> >
> > "Initialize the necessary bits ..." to use the usual imperative
> > sentence structure, as you did in the subject.
> >
> > > If the memory device registers are found and mapped a new internal data
> > > structure tracking device state is allocated.
> >
> > "Allocate device state if we find device registers" or similar.
> >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > ---
> > >  drivers/cxl/mem.c | 68 +++++++++++++++++++++++++++++++++++++++++++----
> > >  drivers/cxl/pci.h |  6 +++++
> > >  2 files changed, 69 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index aa7d881fa47b..8d9b9ab6c5ea 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -7,9 +7,49 @@
> > >  #include "pci.h"
> > >
> > >  struct cxl_mem {
> > > +   struct pci_dev *pdev;
> > >     void __iomem *regs;
> > >  };
> > >
> > > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi)
> > > +{
> > > +   struct device *dev = &pdev->dev;
> > > +   struct cxl_mem *cxlm;
> > > +   void __iomem *regs;
> > > +   u64 offset;
> > > +   u8 bar;
> > > +   int rc;
> > > +
> > > +   offset = ((u64)reg_hi << 32) | (reg_lo & 0xffff0000);
> > > +   bar = reg_lo & 0x7;
> > > +
> > > +   /* Basic sanity check that BAR is big enough */
> > > +   if (pci_resource_len(pdev, bar) < offset) {
> > > +           dev_err(dev, "bar%d: %pr: too small (offset: %#llx)\n",
> > > +                           bar, &pdev->resource[bar], (unsigned long long) offset);
> >
> > s/bar/BAR/
> >
> > > +           return ERR_PTR(-ENXIO);
> > > +   }
> > > +
> > > +   rc = pcim_iomap_regions(pdev, 1 << bar, pci_name(pdev));
> > > +   if (rc != 0) {
> > > +           dev_err(dev, "failed to map registers\n");
> > > +           return ERR_PTR(-ENXIO);
> > > +   }
> > > +
> > > +   cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > > +   if (!cxlm) {
> > > +           dev_err(dev, "No memory available\n");
> > > +           return ERR_PTR(-ENOMEM);
> > > +   }
> > > +
> > > +   regs = pcim_iomap_table(pdev)[bar];
> > > +   cxlm->pdev = pdev;
> > > +   cxlm->regs = regs + offset;
> > > +
> > > +   dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > > +   return cxlm;
> > > +}
> > > +
> > >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > >  {
> > >     int pos;
> > > @@ -34,9 +74,9 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > >
> > >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > > +   struct cxl_mem *cxlm = ERR_PTR(-ENXIO);
> > >     struct device *dev = &pdev->dev;
> > > -   struct cxl_mem *cxlm;
> >
> > The order was better before ("dev", then "clxm").  Oh, I suppose this
> > is a "reverse Christmas tree" thing.
> >
>
> I don't actually care either way as long as it's consistent. I tend to do
> reverse Christmas tree for no particular reason.

Yeah, reverse Christmas tree for no particular reason.

>
> > > -   int rc, regloc;
> > > +   int rc, regloc, i;
> > >
> > >     rc = cxl_bus_prepared(pdev);
> > >     if (rc != 0) {
> > > @@ -44,15 +84,33 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >             return rc;
> > >     }
> > >
> > > +   rc = pcim_enable_device(pdev);
> > > +   if (rc)
> > > +           return rc;
> > > +
> > >     regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> > >     if (!regloc) {
> > >             dev_err(dev, "register location dvsec not found\n");
> > >             return -ENXIO;
> > >     }
> > > +   regloc += 0xc; /* Skip DVSEC + reserved fields */
> > > +
> > > +   for (i = regloc; i < regloc + 0x24; i += 8) {
> > > +           u32 reg_lo, reg_hi;
> > > +
> > > +           pci_read_config_dword(pdev, i, &reg_lo);
> > > +           pci_read_config_dword(pdev, i + 4, &reg_hi);
> > > +
> > > +           if (CXL_REGLOG_IS_MEMDEV(reg_lo)) {
> > > +                   cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > > +                   break;
> > > +           }
> > > +   }
> > > +
> > > +   if (IS_ERR(cxlm))
> > > +           return -ENXIO;
> >
> > I think this would be easier to read if cxl_mem_create() returned NULL
> > on failure (it prints error messages and we throw away
> > -ENXIO/-ENOMEM distinction here anyway) so you could do:
> >
> >   struct cxl_mem *cxlm = NULL;
> >
> >   for (...) {
> >     if (...) {
> >       cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> >       break;
> >     }
> >   }
> >
> >   if (!cxlm)
> >     return -ENXIO;  /* -ENODEV might be more natural? */
> >
>
> I agree on both counts. Both of these came from Dan, so I will let him explain.

I'm not attached to differentiating -ENOMEM from -ENXIO and am ok to
drop the ERR_PTR() return. I do tend to use -ENXIO for failure to
perform an initialization action vs failure to even find the device,
but if -ENODEV seems more idiomatic to Bjorn, I won't argue.
