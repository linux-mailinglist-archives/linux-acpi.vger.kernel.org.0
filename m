Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD421191BA7
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 22:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCXVE4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 17:04:56 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41071 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgCXVEz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2020 17:04:55 -0400
Received: by mail-oi1-f194.google.com with SMTP id k9so21455oia.8
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2020 14:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rqk9tFpnoHCGG96oXfSaBfuvdyqKexJKoEabwVhgS14=;
        b=eHBfaQvu40OiqzGwWMiCeIq2H+4TUXpLzVgGaW5jdzppmKsrX2Vf2k02azSZ2StsI7
         EUrFwvoFIrr6o5w0kbRCO9FI4gUe/HlKlk2YOIl13vcOqgR1ChdMkTHL8HraXT12Qj3i
         kIwTBkdG7dZMmd9Nqg4hDSR/VwyRXsVWjZaLp3VBYMw/bTlLkHb/S/MVmBV/hp/JBTux
         zWGU0sre2JXu78HNWRlwMMGKcVlUy3EcF2bi4rdgNLIhMnWAOJhSlXpUp0CXh3rcBkpY
         MUHXng3BGvoAc9dBPDRFk1SAy1M110d80hWHOL5uQVLR9nhrkRpfN4bltwKSQp15q07i
         k0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rqk9tFpnoHCGG96oXfSaBfuvdyqKexJKoEabwVhgS14=;
        b=WeoaIplvzEDb/3e2Ue55vWsQAmoh2CICJpmju3mnIr1i7qOMPjLfRAUWEN8LS8IbWn
         z2HpxquGiLYAB/FqVKSjczQJFQC86P56ueBhB4bdqj9HwzwggiO6dorUoqjZ8Yyo/siN
         m9px4QLLUCO4yNAARZRxizjB7qTAbk248WxzgNB54N3PZxSbh8SXc0TmOJFTYDooTN4k
         iiVCkByGkYYx/asz5foReJNpIvSQu7tgJCyVtmLEJjirO1ejA7KA5WVdv/rH5TW2w26X
         /C98c4i2IjMFXa8LdQOdTc1c4I1VtNZ2BdNKS87tusmBc3dPKapiZDPgXF/xcjGrbS6e
         OEfw==
X-Gm-Message-State: ANhLgQ0FMN9tEK38f3iGNF2PggIAaIsfs5+0r9KWbIAtM0vfunCHfESw
        vG/XJAo+0Rk0arWF70/iVXwb0tqeZudqyhbpAkUbuYsJ
X-Google-Smtp-Source: ADFU+vu8Y34XatTczyvc17L08jp5mXA4Gj8IvpURa0NIr6zfJzitzWOmIWznVDfVeD9quhDB39wMHBKcgtBInp/pcaw=
X-Received: by 2002:aca:ef82:: with SMTP id n124mr134196oih.73.1585083894878;
 Tue, 24 Mar 2020 14:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <158489354353.1457606.8327903161927980740.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158489356692.1457606.1858427908360761594.stgit@dwillia2-desk3.amr.corp.intel.com>
 <f964eb62-5bc9-7e85-5c44-9027a6c08d4c@oracle.com>
In-Reply-To: <f964eb62-5bc9-7e85-5c44-9027a6c08d4c@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 24 Mar 2020 14:04:44 -0700
Message-ID: <CAPcyv4hgExDoKZg7QQ9JRkPEY2N56EjLgLQ2Q19tu3vnUdPqgA@mail.gmail.com>
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

On Tue, Mar 24, 2020 at 12:41 PM Joao Martins <joao.m.martins@oracle.com> wrote:
>
>
> On 3/22/20 4:12 PM, Dan Williams wrote:
> > In preparation for exposing "Soft Reserved" memory ranges without an
> > HMAT, move the hmem device registration to its own compilation unit and
> > make the implementation generic.
> >
> > The generic implementation drops usage acpi_map_pxm_to_online_node()
> > that was translating ACPI proximity domain values and instead relies on
> > numa_map_to_online_node() to determine the numa node for the device.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Link: https://lore.kernel.org/r/158318761484.2216124.2049322072599482736.stgit@dwillia2-desk3.amr.corp.intel.com
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/acpi/numa/hmat.c  |   68 ++++-----------------------------------------
> >  drivers/dax/Kconfig       |    4 +++
> >  drivers/dax/Makefile      |    3 +-
> >  drivers/dax/hmem.c        |   56 -------------------------------------
> >  drivers/dax/hmem/Makefile |    5 +++
> >  drivers/dax/hmem/device.c |   64 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/dax/hmem/hmem.c   |   56 +++++++++++++++++++++++++++++++++++++
> >  include/linux/dax.h       |    8 +++++
> >  8 files changed, 144 insertions(+), 120 deletions(-)
> >  delete mode 100644 drivers/dax/hmem.c
> >  create mode 100644 drivers/dax/hmem/Makefile
> >  create mode 100644 drivers/dax/hmem/device.c
> >  create mode 100644 drivers/dax/hmem/hmem.c
> >
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index a12e36a12618..134bcb40b2af 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/node.h>
> >  #include <linux/sysfs.h>
> > +#include <linux/dax.h>
> >
> >  static u8 hmat_revision;
> >  static int hmat_disable __initdata;
> > @@ -640,66 +641,6 @@ static void hmat_register_target_perf(struct memory_target *target)
> >       node_set_perf_attrs(mem_nid, &target->hmem_attrs, 0);
> >  }
> >
> > -static void hmat_register_target_device(struct memory_target *target,
>           ^^^^ int ?
>
> > -             struct resource *r)
> > -{
> > -     /* define a clean / non-busy resource for the platform device */
> > -     struct resource res = {
> > -             .start = r->start,
> > -             .end = r->end,
> > -             .flags = IORESOURCE_MEM,
> > -     };
> > -     struct platform_device *pdev;
> > -     struct memregion_info info;
> > -     int rc, id;
> > -
> > -     rc = region_intersects(res.start, resource_size(&res), IORESOURCE_MEM,
> > -                     IORES_DESC_SOFT_RESERVED);
> > -     if (rc != REGION_INTERSECTS)
> > -             return;
>                 ^ return -ENXIO;
>
> > -
> > -     id = memregion_alloc(GFP_KERNEL);
> > -     if (id < 0) {
> > -             pr_err("memregion allocation failure for %pr\n", &res);
> > -             return;
>                 ^ return -ENOMEM;
>
> > -     }
> > -
> > -     pdev = platform_device_alloc("hmem", id);
> > -     if (!pdev) {
>
>                 rc = -ENOMEM;
>
> > -             pr_err("hmem device allocation failure for %pr\n", &res);
> > -             goto out_pdev;
> > -     }
> > -
> > -     pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> > -     info = (struct memregion_info) {
> > -             .target_node = acpi_map_pxm_to_node(target->memory_pxm),
> > -     };
> > -     rc = platform_device_add_data(pdev, &info, sizeof(info));
> > -     if (rc < 0) {
> > -             pr_err("hmem memregion_info allocation failure for %pr\n", &res);
> > -             goto out_pdev;
> > -     }
> > -
> > -     rc = platform_device_add_resources(pdev, &res, 1);
> > -     if (rc < 0) {
> > -             pr_err("hmem resource allocation failure for %pr\n", &res);
> > -             goto out_resource;
> > -     }
> > -
> > -     rc = platform_device_add(pdev);
> > -     if (rc < 0) {
> > -             dev_err(&pdev->dev, "device add failed for %pr\n", &res);
> > -             goto out_resource;
> > -     }
> > -
> > -     return;
>         ^^^^^^ return 0;
> > -
> > -out_resource:
> > -     put_device(&pdev->dev);
> > -out_pdev:
> > -     memregion_free(id);
>
>         return rc;
>
> > -}
> > -
> >  static void hmat_register_target_devices(struct memory_target *target)
> >  {
> >       struct resource *res;
> > @@ -711,8 +652,11 @@ static void hmat_register_target_devices(struct memory_target *target)
> >       if (!IS_ENABLED(CONFIG_DEV_DAX_HMEM))
> >               return;
> >
> > -     for (res = target->memregions.child; res; res = res->sibling)
> > -             hmat_register_target_device(target, res);
> > +     for (res = target->memregions.child; res; res = res->sibling) {
> > +             int target_nid = acpi_map_pxm_to_node(target->memory_pxm);
> > +
> > +             hmem_register_device(target_nid, res);
> > +     }
> >  }
> >
>
> If it makes sense to propagate error to hmem_register_device (as noted above),
> then here perhaps a pr_err() if hmem registration fails mainly for reporting
> purposes?

Yeah, I guess it makes sense to at least log that something went wrong
if someone wonders where their memory device went. I'll add that
rework as a follow-on.

> Regardless of the error nits, looks good overall. So, for what is worth:
>
>   Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

Thanks.
