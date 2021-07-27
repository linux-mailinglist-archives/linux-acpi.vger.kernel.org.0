Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB93D3D7B34
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jul 2021 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhG0Qix (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Jul 2021 12:38:53 -0400
Received: from foss.arm.com ([217.140.110.172]:41142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhG0Qiw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Jul 2021 12:38:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 653EC31B;
        Tue, 27 Jul 2021 09:38:52 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA32D3F70D;
        Tue, 27 Jul 2021 09:38:50 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:38:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] ACPI: Add memory semantics to acpi_os_map_memory()
Message-ID: <20210727163845.GA16478@lpieralisi>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <CAMj1kXEyjBxu_7mV2DNU=Maqx6JqTTWp3ZuHkJz3js0qRsJSHw@mail.gmail.com>
 <20210727100645.GA7108@lpieralisi>
 <CAMj1kXHwPXX9MxuF_cw1bq9v+qzH-M4-_ssES8WQq-YP3APthg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHwPXX9MxuF_cw1bq9v+qzH-M4-_ssES8WQq-YP3APthg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 27, 2021 at 12:09:47PM +0200, Ard Biesheuvel wrote:

[...]

> > > > +void __iomem __ref
> > > > +*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
> > >
> > > I am aware that this just duplicated the prototype above, but I think
> > > this should be
> > >
> > > void __iomem *__ref
> > >
> > > given that the __ref comes after the * in the prototype below.
> >
> > Yes I just moved/duplicated the prototype above but I believe this is
> > consistent with include/acpi/acpi_io.h unless I have not understood
> > what you meant ?
> >
> > It is probably worth changing it in both places to
> >
> > void __iomem *__ref
> >
> > ?
> >
> > I can do that with an additional patch.
> >
> 
> Yes, as long as they are all mutually consistent. The __ref is not
> part of the type at all, so it should not be between the void and the
> *, even if the compiler appears to allow it.

Updated into a small series, will repost next week when I am back.

Thanks,
Lorenzo

> > > > +{
> > > > +       return __acpi_os_map_iomem(phys, size, false);
> > > > +}
> > > >  EXPORT_SYMBOL_GPL(acpi_os_map_iomem);
> > > >
> > > >  void *__ref acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
> > > >  {
> > > > -       return (void *)acpi_os_map_iomem(phys, size);
> > > > +       return (void *)__acpi_os_map_iomem(phys, size, true);
> > >
> > > I think this should be (__force void *) to shut up sparse address
> > > space warnings.
> >
> > Yes I can add that attribute in an additional patch and rebase this one
> > on top of it.
> >
> > Thanks,
> > Lorenzo
> >
> > >
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(acpi_os_map_memory);
> > > >
> > > > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > > > index 027faa8883aa..a0212e67d6f4 100644
> > > > --- a/include/acpi/acpi_io.h
> > > > +++ b/include/acpi/acpi_io.h
> > > > @@ -14,6 +14,14 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > > >  }
> > > >  #endif
> > > >
> > > > +#ifndef acpi_os_memmap
> > > > +static inline void __iomem *acpi_os_memmap(acpi_physical_address phys,
> > > > +                                           acpi_size size)
> > > > +{
> > > > +       return ioremap_cache(phys, size);
> > > > +}
> > > > +#endif
> > > > +
> > > >  extern bool acpi_permanent_mmap;
> > > >
> > > >  void __iomem __ref
> > > > --
> > > > 2.31.0
> > > >
