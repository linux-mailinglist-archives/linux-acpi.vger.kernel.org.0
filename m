Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B09C955864
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 22:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFYUHx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 16:07:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44667 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfFYUHx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jun 2019 16:07:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id b7so98036otl.11
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jun 2019 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hz9yXC3QNEKUxR5NqsfjpYt0w2H6D1TiaLMOifo9FM=;
        b=BHXCyOrnUPs1hcuNYqPdDyL0ToAMrbN9ViFj0sViQfWhcY+WaxbwLDLLsBRGcL1wDm
         t3lfMFeGwI46lg1cwGJBaRgZw9p8SiIFDItqnan8ooR9XhrpNLCW896m7GwEWcvFFA3N
         8GgaFhN9kYqm55WMYhO68qiG0wGUHkhzji2N90zT0ZrSW2OKsc6z3usXybjA10lpy30q
         k5JO9cOEjomxiLzDLIsN9EolEnh8150XpLGrO0fDSV4cTg9oVMXRe2x8zmLVsbBe37CR
         KjVPHMd7cocz3AklmLtGfxY6jxfNOxEHMtxVWpvZLY0Y1/dGn4fCKSgodlr/FlqYJQky
         bcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hz9yXC3QNEKUxR5NqsfjpYt0w2H6D1TiaLMOifo9FM=;
        b=mK1MiZ6fpdWqUijBagPIDYtQm275n7E3/f6aAaF1PQz68UKnm032Uxd8NXrk9vUrR+
         MkDZBBoZnh1LIzAGU1Pi4qPULylPa+YzKQmuNHI1k4ICD39O8EM0RX3CymHwaL45TGWp
         lVFsL+iY6NWshBgg2yB4t1+Ie5UqH56tTvXB7gZaELOFOoiXX7xnpRvX2QCpE5zeymyP
         M92iU9j12n+3+xr8fKON2+2BO9hoWWF+fENtoG5Ozq7cOZLOndG+HPf2wOr2BxoMz54t
         cinX6HvXI9NvOE3u7AU8wOM2CQPG0IShYKRCCjSGwEwx26zlHaoBtQHCKRGiber9SDPY
         3qsw==
X-Gm-Message-State: APjAAAVLTAHNFqOYDRr8cvc/AoYfWmMo8i1I5EmHGyz73Nf1F4ingb50
        ewvIiPYMYqZjfO+aQs6UDDpM8KkpAq9EplV1v75DpA==
X-Google-Smtp-Source: APXvYqxJ+5tJ19ECFTc2Qxizf7PywDomA0IWMoGVRvLQnJR3/+gCpyn7LCQ8KtbmtVITTBei/TRQEvldm8pdmv5LAEQ=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr102089otn.247.1561493272423;
 Tue, 25 Jun 2019 13:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140041177.2951909.8582567579750505172.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190625163756.00001a85@huawei.com>
In-Reply-To: <20190625163756.00001a85@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Jun 2019 13:07:41 -0700
Message-ID: <CAPcyv4jXVroB3j6VQ2iCzjAhuL4wExHQvNqa4KMep2o2-2ihEQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] device-dax: Add a driver for "hmem" devices
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     X86 ML <x86@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 25, 2019 at 8:39 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Mon, 24 Jun 2019 11:20:16 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Platform firmware like EFI/ACPI may publish "hmem" platform devices.
> > Such a device is a performance differentiated memory range likely
> > reserved for an application specific use case. The driver gives access
> > to 100% of the capacity via a device-dax mmap instance by default.
> >
> > However, if over-subscription and other kernel memory management is
> > desired the resulting dax device can be assigned to the core-mm via the
> > kmem driver.
> >
> > This consumes "hmem" devices the producer of "hmem" devices is saved for
> > a follow-on patch so that it can reference the new CONFIG_DEV_DAX_HMEM
> > symbol to gate performing the enumeration work.
> >
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> No need to have a remove function at all.  Otherwise this looks good to me.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > ---
> >  drivers/dax/Kconfig    |   27 +++++++++++++++++++----
> >  drivers/dax/Makefile   |    2 ++
> >  drivers/dax/hmem.c     |   57 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/ioport.h |    4 +++
> >  4 files changed, 85 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/dax/hmem.c
> >
> > diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> > index f33c73e4af41..1a59ef86f148 100644
> > --- a/drivers/dax/Kconfig
> > +++ b/drivers/dax/Kconfig
> > @@ -32,19 +32,36 @@ config DEV_DAX_PMEM
> >
> >         Say M if unsure
> >
> > +config DEV_DAX_HMEM
> > +     tristate "HMEM DAX: direct access to 'specific purpose' memory"
> > +     depends on EFI_APPLICATION_RESERVED
> > +     default DEV_DAX
> > +     help
> > +       EFI 2.8 platforms, and others, may advertise 'specific purpose'
> > +       memory.  For example, a high bandwidth memory pool. The
> > +       indication from platform firmware is meant to reserve the
> > +       memory from typical usage by default.  This driver creates
> > +       device-dax instances for these memory ranges, and that also
> > +       enables the possibility to assign them to the DEV_DAX_KMEM
> > +       driver to override the reservation and add them to kernel
> > +       "System RAM" pool.
> > +
> > +       Say M if unsure.
> > +
> >  config DEV_DAX_KMEM
> >       tristate "KMEM DAX: volatile-use of persistent memory"
> >       default DEV_DAX
> >       depends on DEV_DAX
> >       depends on MEMORY_HOTPLUG # for add_memory() and friends
> >       help
> > -       Support access to persistent memory as if it were RAM.  This
> > -       allows easier use of persistent memory by unmodified
> > -       applications.
> > +       Support access to persistent, or other performance
> > +       differentiated memory as if it were System RAM. This allows
> > +       easier use of persistent memory by unmodified applications, or
> > +       adds core kernel memory services to heterogeneous memory types
> > +       (HMEM) marked "reserved" by platform firmware.
> >
> >         To use this feature, a DAX device must be unbound from the
> > -       device_dax driver (PMEM DAX) and bound to this kmem driver
> > -       on each boot.
> > +       device_dax driver and bound to this kmem driver on each boot.
> >
> >         Say N if unsure.
> >
> > diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
> > index 81f7d54dadfb..80065b38b3c4 100644
> > --- a/drivers/dax/Makefile
> > +++ b/drivers/dax/Makefile
> > @@ -2,9 +2,11 @@
> >  obj-$(CONFIG_DAX) += dax.o
> >  obj-$(CONFIG_DEV_DAX) += device_dax.o
> >  obj-$(CONFIG_DEV_DAX_KMEM) += kmem.o
> > +obj-$(CONFIG_DEV_DAX_HMEM) += dax_hmem.o
> >
> >  dax-y := super.o
> >  dax-y += bus.o
> >  device_dax-y := device.o
> > +dax_hmem-y := hmem.o
> >
> >  obj-y += pmem/
> > diff --git a/drivers/dax/hmem.c b/drivers/dax/hmem.c
> > new file mode 100644
> > index 000000000000..62f9e3c80e21
> > --- /dev/null
> > +++ b/drivers/dax/hmem.c
> > @@ -0,0 +1,57 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/platform_device.h>
> > +#include <linux/ioport.h>
> > +#include <linux/module.h>
> > +#include <linux/pfn_t.h>
> > +#include "bus.h"
> > +
> > +static int dax_hmem_probe(struct platform_device *pdev)
> > +{
> > +     struct dev_pagemap pgmap = { NULL };
> > +     struct device *dev = &pdev->dev;
> > +     struct dax_region *dax_region;
> > +     struct memregion_info *mri;
> > +     struct dev_dax *dev_dax;
> > +     struct resource *res;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -ENOMEM;
> > +
> > +     mri = dev->platform_data;
> > +     pgmap.dev = dev;
> > +     memcpy(&pgmap.res, res, sizeof(*res));
> > +
> > +     dax_region = alloc_dax_region(dev, pdev->id, res, mri->target_node,
> > +                     PMD_SIZE, PFN_DEV|PFN_MAP);
> > +     if (!dax_region)
> > +             return -ENOMEM;
> > +
> > +     dev_dax = devm_create_dev_dax(dax_region, 0, &pgmap);
> > +     if (IS_ERR(dev_dax))
> > +             return PTR_ERR(dev_dax);
> > +
> > +     /* child dev_dax instances now own the lifetime of the dax_region */
> > +     dax_region_put(dax_region);
> > +     return 0;
> > +}
> > +
> > +static int dax_hmem_remove(struct platform_device *pdev)
> > +{
> > +     /* devm handles teardown */
> > +     return 0;
>
> Why have a remove at all?  driver/base/platform.c has
> the appropriate protections to allow you to not provide one.
> If you want the comment, just put it after .probe =
> below.

True, that's a good cleanup.
