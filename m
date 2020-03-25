Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8F1933C8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 23:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYWdC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 18:33:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39482 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgCYWdB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2020 18:33:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id a43so4672816edf.6
        for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2020 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVCDmOk9HhsK80T8G7kVWe7YwLFbt+hHKP5is8X15Cc=;
        b=Uz8DEE88kRzzlSo4K0/OS7d3QvShBzx8HCRAWRfFe86MgzpfXcGq4vfKh+thh+jIPi
         K4h9SugnX3zdr7Ii7b7l/KQGZtYNZOw6oWMeH6ZeSBcOMk4d4OygCHTfs1O+k2n02G/8
         joLcuTcHQPoPmJAJx5kEpjdQx5HKQAYiCfWBAbwKccHw84BEeoGTocnCXCrAhvD8yB/z
         Bk5rdPvWZEs5LN4XInM9Ymu02ybdM5uJo95e1CWnrA2wmEw9oTJuIpYp9Z11P2wM1gWv
         ko1EP+wlPrH+M277pSdHqW9rXfxdPgt6KD1xRlrkK+l5fvbEKpnm9HjwFk+o/f4yXTdZ
         4zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVCDmOk9HhsK80T8G7kVWe7YwLFbt+hHKP5is8X15Cc=;
        b=MacOXY+CHBJj/DEGQDp86iAzjmBt0Q621IQGtXEYsCuZUU9mHgRnRe2fUbrndN5pgH
         j1v1FKjIpk0KAILj0jgn0BVpwI1YSZ01rxYGtz4jy5QMX8lACQONiZKPd4aZSV7OeBWi
         67Zc7tG4WMLK4XLt7lxMfUBC1r3DcceWENu1rN1JLEoCaKyicoaMBX/IxWqzkYZhlzzM
         dtzCQoruqMKWsaeIR3o3SuaxW044Uf44+LlWNpYLbfUtm1LOhlkBO7qDtH3K8RRjZnZy
         mF10czoYqoFjiTkavzBDsIffzk7viW33jNB4wVKKA5rNN2N9GdkkEUKSXNcUUmo/4/Vm
         KwZA==
X-Gm-Message-State: ANhLgQ2gq1Hj6ENx204xsAYmuWN9FH+/sB8qFURURpzXsEMJHIs4fKnM
        lbJMWKkbjErZPQccx6/NgoabPkSiZCAcaqwCm5Od8A==
X-Google-Smtp-Source: ADFU+vsCqAXZsXgnDkYvOWG3bR2wDWzsJ5qsWPjBfCL32pSGSnNmuWvylskZFSFSIbomy5pt3613yJZfFce1FytIomA=
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr5155925ejt.123.1585175579794;
 Wed, 25 Mar 2020 15:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489356692.1457606.1858427908360761594.stgit@dwillia2-desk3.amr.corp.intel.com>
 <f964eb62-5bc9-7e85-5c44-9027a6c08d4c@oracle.com> <CAPcyv4hgExDoKZg7QQ9JRkPEY2N56EjLgLQ2Q19tu3vnUdPqgA@mail.gmail.com>
In-Reply-To: <CAPcyv4hgExDoKZg7QQ9JRkPEY2N56EjLgLQ2Q19tu3vnUdPqgA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 25 Mar 2020 15:32:48 -0700
Message-ID: <CAPcyv4gjTmZuvqkV_r3_FuGrjK=a-CVGOnLEDZ0Fpiyg2h_Lag@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ACPI: HMAT: Refactor hmat_register_target_device
 to hmem_register_device
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 24, 2020 at 2:04 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Mar 24, 2020 at 12:41 PM Joao Martins <joao.m.martins@oracle.com> wrote:
> >
> >
> > On 3/22/20 4:12 PM, Dan Williams wrote:
> > > In preparation for exposing "Soft Reserved" memory ranges without an
> > > HMAT, move the hmem device registration to its own compilation unit and
> > > make the implementation generic.
> > >
> > > The generic implementation drops usage acpi_map_pxm_to_online_node()
> > > that was translating ACPI proximity domain values and instead relies on
> > > numa_map_to_online_node() to determine the numa node for the device.
> > >
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Link: https://lore.kernel.org/r/158318761484.2216124.2049322072599482736.stgit@dwillia2-desk3.amr.corp.intel.com
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/acpi/numa/hmat.c  |   68 ++++-----------------------------------------
> > >  drivers/dax/Kconfig       |    4 +++
> > >  drivers/dax/Makefile      |    3 +-
> > >  drivers/dax/hmem.c        |   56 -------------------------------------
> > >  drivers/dax/hmem/Makefile |    5 +++
> > >  drivers/dax/hmem/device.c |   64 ++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/dax/hmem/hmem.c   |   56 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/dax.h       |    8 +++++
> > >  8 files changed, 144 insertions(+), 120 deletions(-)
> > >  delete mode 100644 drivers/dax/hmem.c
> > >  create mode 100644 drivers/dax/hmem/Makefile
> > >  create mode 100644 drivers/dax/hmem/device.c
> > >  create mode 100644 drivers/dax/hmem/hmem.c
> > >
> > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > index a12e36a12618..134bcb40b2af 100644
> > > --- a/drivers/acpi/numa/hmat.c
> > > +++ b/drivers/acpi/numa/hmat.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/node.h>
> > >  #include <linux/sysfs.h>
> > > +#include <linux/dax.h>
> > >
> > >  static u8 hmat_revision;
> > >  static int hmat_disable __initdata;
> > > @@ -640,66 +641,6 @@ static void hmat_register_target_perf(struct memory_target *target)
> > >       node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
> > >  }
> > >
> > > -static void hmat_register_target_device(struct memory_target *target,
> >           ^^^^ int ?
> >
> > > -             struct resource *r)
> > > -{
> > > -     /* define a clean / non-busy resource for the platform device */
> > > -     struct resource res = {
> > > -             .start = r->start,
> > > -             .end = r->end,
> > > -             .flags = IORESOURCE_MEM,
> > > -     };
> > > -     struct platform_device *pdev;
> > > -     struct memregion_info info;
> > > -     int rc, id;
> > > -
> > > -     rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> > > -                     IORES_DESC_SOFT_RESERVED);
> > > -     if (rc != REGION_INTERSECTS)
> > > -             return;
> >                 ^ return -ENXIO;
> >
> > > -
> > > -     id = memregion_alloc(GFP_KERNEL);
> > > -     if (id < 0) {
> > > -             pr_err("memregion allocation failure for %pr\n", &res);
> > > -             return;
> >                 ^ return -ENOMEM;
> >
> > > -     }
> > > -
> > > -     pdev = platform_device_alloc("hmem", id);
> > > -     if (!pdev) {
> >
> >                 rc = -ENOMEM;
> >
> > > -             pr_err("hmem device allocation failure for %pr\n", &res);
> > > -             goto out_pdev;
> > > -     }
> > > -
> > > -     pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> > > -     info = (struct memregion_info) {
> > > -             .target_node = acpi_map_pxm_to_node(target->memory_pxm),
> > > -     };
> > > -     rc = platform_device_add_data(pdev, &info, sizeof(info));
> > > -     if (rc < 0) {
> > > -             pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> > > -             goto out_pdev;
> > > -     }
> > > -
> > > -     rc = platform_device_add_resources(pdev, &res, 1);
> > > -     if (rc < 0) {
> > > -             pr_err("hmem resource allocation failure for %pr\n", &res);
> > > -             goto out_resource;
> > > -     }
> > > -
> > > -     rc = platform_device_add(pdev);
> > > -     if (rc < 0) {
> > > -             dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> > > -             goto out_resource;
> > > -     }
> > > -
> > > -     return;
> >         ^^^^^^ return 0;
> > > -
> > > -out_resource:
> > > -     put_device(&pdev->dev);
> > > -out_pdev:
> > > -     memregion_free(id);
> >
> >         return rc;
> >
> > > -}
> > > -
> > >  static void hmat_register_target_devices(struct memory_target *target)
> > >  {
> > >       struct resource *res;
> > > @@ -711,8 +652,11 @@ static void hmat_register_target_devices(struct memory_target *target)
> > >       if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> > >               return;
> > >
> > > -     for (res = target->memregions.child; res; res = res->sibling)
> > > -             hmat_register_target_device(target, res);
> > > +     for (res = target->memregions.child; res; res = res->sibling) {
> > > +             int target_nid = acpi_map_pxm_to_node(target->memory_pxm);
> > > +
> > > +             hmem_register_device(target_nid, res);
> > > +     }
> > >  }
> > >
> >
> > If it makes sense to propagate error to hmem_register_device (as noted above),
> > then here perhaps a pr_err() if hmem registration fails mainly for reporting
> > purposes?
>
> Yeah, I guess it makes sense to at least log that something went wrong
> if someone wonders where their memory device went. I'll add that
> rework as a follow-on.

Now that I look again hmat_register_target_device() already has
multiple pr_err() indicating that something went wrong. The error code
would not go anywhere useful.
