Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C74D203AD0
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 17:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFVP2G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 11:28:06 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39324 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgFVP2F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 11:28:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id g5so13358718otg.6;
        Mon, 22 Jun 2020 08:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i2c95N6ci/w7OThvHcf5Fy4XsnnDSG6ckQoNsGPl1eo=;
        b=f7vKEfOXl4WaAdH5q0JB9U8HDfCF6CPBxTeblqh57+TPvlampTHUIY7bwvNXwqklSW
         waBCl43ICIL8FfprfAyq5EQG8NbbaHzlB2o/OrDLPz6v4gsX+Ox+foy1Wsz+lh4A89ls
         SiEUIBbvHjxBzELGSqOWrzy8x7a4/iKMxGqQQl7wlgZHZXYYSThoqiqNEUAgCjJ0cEfa
         5ihyLa2DRzY4d2rtF8imVjRjFoNshZIeqwgtS85coVZYHbe4yu5Xv7v2oZiJ0v4kddFe
         gbB4//xCRGLa6gNVuhgZNqlHchqMluJvhhbJ5nxen826ZDVallCReJJJlc/LchAYmwbm
         ynKA==
X-Gm-Message-State: AOAM531cafPIiCs1bMyB/vpi1UFjH4He0txYcePvV4689kR4nZhhdP9+
        MEPaZo0itaJxHQq4e2NyPXZcOm+hrLW1I5twc04=
X-Google-Smtp-Source: ABdhPJwPycask6rXfFgrsgFmggHDR562yU+PZHy41snSPCHC1tppXmJo1aa1PK+69GQNrvfUgNROeNC4pvEbtPnx6sM=
X-Received: by 2002:a05:6830:10ca:: with SMTP id z10mr13946922oto.167.1592839684757;
 Mon, 22 Jun 2020 08:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <1821880.vZFEW4x2Ui@kreacher> <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com>
In-Reply-To: <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jun 2020 17:27:53 +0200
Message-ID: <CAJZ5v0hu9_TA0KAe=9ZCSG4_KijSYb=qnt8MYe9QYwGbz=pmBg@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 2/4] ACPI: OSL: Add support for deferred unmapping
 of ACPI memory
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 22, 2020 at 4:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jun 22, 2020 at 5:06 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Implement acpi_os_unmap_deferred() and
> > acpi_os_release_unused_mappings() and set ACPI_USE_DEFERRED_UNMAPPING
> > to allow ACPICA to use deferred unmapping of memory in
> > acpi_ex_system_memory_space_handler() so as to avoid RCU-related
> > performance issues with memory opregions.
>
> ...
>
> > +static bool acpi_os_drop_map_ref(struct acpi_ioremap *map, bool defer)
> >  {
> > -       unsigned long refcount = --map->refcount;
> > +       if (--map->track.refcount)
> > +               return true;
> >
> > -       if (!refcount)
> > -               list_del_rcu(&map->list);
> > -       return refcount;
> > +       list_del_rcu(&map->list);
> > +
>
> > +       if (defer) {
> > +               INIT_LIST_HEAD(&map->track.gc);
> > +               list_add_tail(&map->track.gc, &unused_mappings);
>
> > +               return true;
> > +       }
> > +
> > +       return false;
>
> A nit:
>
> Effectively it returns a value of defer.
>
>   return defer;
>
> >  }

Do you mean that one line of code could be saved?  Yes, it could.

>
> ...
>
> > @@ -416,26 +421,102 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
> >         }
> >
> >         mutex_lock(&acpi_ioremap_lock);
> > +
> >         map = acpi_map_lookup_virt(virt, size);
>
> A nit: should it be somewhere else (I mean in another patch)?

Do you mean the extra empty line?

No, I don't think so, or the code style after this patch would not
look consistent.

> >         if (!map) {
>
> ...
>
> > +       /* Release the unused mappings in the list. */
> > +       while (!list_empty(&list)) {
> > +               struct acpi_ioremap *map;
> > +
> > +               map = list_entry(list.next, struct acpi_ioremap, track.gc);
>
> A nt: if __acpi_os_map_cleanup() (actually acpi_unmap() according to
> the code) has no side effects, can we use list_for_each_entry_safe()
> here?

I actually prefer a do .. while version of this which saves the
initial check (which has been carried out already).

> > +               list_del(&map->track.gc);
> > +               __acpi_os_map_cleanup(map);
> > +       }
> > +}
>
> ...
>
> > @@ -472,16 +552,18 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
> >                 return;
> >
> >         mutex_lock(&acpi_ioremap_lock);
> > +
> >         map = acpi_map_lookup(addr, gas->bit_width / 8);
>
> A nit: should it be somewhere else (I mean in another patch)?

Nope.

Thanks!
