Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133AA28E441
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 18:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbgJNQSZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 12:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbgJNQSY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 12:18:24 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44FB4214D8;
        Wed, 14 Oct 2020 16:18:21 +0000 (UTC)
Date:   Wed, 14 Oct 2020 17:18:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
Message-ID: <20201014161818.GF3589@gaia>
References: <20201010093153.30177-1-ardb@kernel.org>
 <20201013110929.GB20319@e121166-lin.cambridge.arm.com>
 <CAMj1kXEbZ3cN1N2V6MfbUZsTot+9TsLTC_UMm5JP1OW8AwvuOw@mail.gmail.com>
 <20201013131346.GA20925@e121166-lin.cambridge.arm.com>
 <CAMj1kXGM937+C-4kasuPYp_X9r8ic56KVpZX2G0zW+FYn9NQ7w@mail.gmail.com>
 <20201013154100.GA22293@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013154100.GA22293@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Lorenzo,

On Tue, Oct 13, 2020 at 04:41:00PM +0100, Lorenzo Pieralisi wrote:
> On Tue, Oct 13, 2020 at 03:42:07PM +0200, Ard Biesheuvel wrote:
> > On Tue, 13 Oct 2020 at 15:13, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Tue, Oct 13, 2020 at 01:22:32PM +0200, Ard Biesheuvel wrote:
> > > > > > diff --git a/Documentation/arm64/arm-acpi.rst b/Documentation/arm64/arm-acpi.rst
> > > > > > index 47ecb9930dde..947f5b5c45ef 100644
> > > > > > --- a/Documentation/arm64/arm-acpi.rst
> > > > > > +++ b/Documentation/arm64/arm-acpi.rst
> > > > > > @@ -205,6 +205,13 @@ devices available.  This list of tables is not meant to be all inclusive;
> > > > > >  in some environments other tables may be needed (e.g., any of the APEI
> > > > > >  tables from section 18) to support specific functionality.
> > > > > >
> > > > > > +It is assumed that all DMA capable devices in the system are able to
> > > > > > +access the lowest 4 GB of system memory. If this is not the case, an
> > > > > > +IORT describing those limitations is mandatory, even if an IORT is not
> > > > > > +otherwise necessary to describe the I/O topology, and regardless of
> > > > > > +whether _DMA methods are used to describe the DMA limitations more
> > > > > > +precisely. Once the system has booted, _DMA methods will take precedence
> > > > > > +over DMA addressing limits described in the IORT.
> > > > >
> > > > > If this is a boot requirement it must be in ARM's official documentation,
> > > > > first, not the kernel one.
> > > > >
> > > > > I understand this is an urgent (well - no comments on why bootstrapping
> > > > > ACPI on Raspberry PI4 is causing all this fuss, honestly) fix but that's
> > > > > not a reason to rush through these guidelines.
> > > > >
> > > > > I would not add this paragraph to arm-acpi.rst, yet.
> > > >
> > > > Which documentation? ACPI compliance by itself is not sufficient for a
> > > > system to be able to boot Linux/arm64, which is why we documented the
> > > > requirements for ACPI boot on Linux/arm64 in this file. I don't think
> > > > we need endorsement from ARM to decide that odd platforms like this
> > > > need to abide by some additional rules if they want to boot in ACPI
> > > > mode.
> > >
> > > I think we do - if we don't we should not add this documentation either.
> > >
> > > ACPI on ARM64 software stack is based on standardized HW requirements.
> > > The sheer fact that we need to work around a HW deficiency shows that
> > > either this platform should have never been booted with ACPI or the _HW_
> > > design guidelines (BSA) are not tight enough.
> > >
> > > Please note that as you may have understood I asked if we can implement
> > > a workaround in IORT because that's information that must be there
> > > regardless (and an OEM ID match in arch code - though pragmatic -
> > > defeats the whole purpose), I don't think we should tell Linux kernel
> > > developers how firmware must be written to work around blatantly
> > > non-compliant systems.
> > 
> > This is not about systems being compliant or not, unless there is a
> > requirement somewhere that I missed that all masters in the system
> > must be able to access at least 32 bits of DMA.
> 
> I think there is in the SBSA (4.1.3 Memory Map) but regardless, this
> is clearly a design bug, that's not a feature.

I think in revision D of the SBSA 6.0 this was moved to 3.1.3. Anyway, I
guess you are referring to:

  All Non-secure on-chip masters in a base server system that are
  expected to be under the control of the operating system or hypervisor
  must be capable of addressing all of the Non-secure address space.

IIUC, this rules out 32-bit devices as well. Even if we look at the less
strict BSA (https://developer.arm.com/documentation/den0094/latest), the
requirements are the same.

So we can consider the bug either in the *BSA specs or in hardware. If
at least the 32-bit devices are acceptable, the specs should probably be
updated. Otherwise we just state that Linux has slightly different
requirements than *BSA (more relaxed or tightened in various areas) and
we describe them somewhere under Documentation/arm64/.

> > The problem here is that Linux/arm64 cannot deal with fully compliant
> > systems that communicate their [permitted] DMA limitations via a _DMA
> > method if this limitation happens to be that the address limit < 32
> > bits. The DMA subsystem can deal with this fine, only the default DMA
> > zone sizing policy creates an internal issue where the DMA subsystem
> > is not able to allocate memory that matches the DMA constraints.
> > 
> > So the 'correct' fix here would be to rework the memory allocator so
> > it can deal with arbitrary DMA limits at allocation time, so that any
> > limit returned by a _DMA method can be adhered to on the fly.
> > 
> > However, we all agree that the Raspberry Pi4 is not worth that effort,
> > and that in the general case, SoCs with such limitations, even if they
> > are compliant per the spec, are not worth the trouble of complicating
> > this even more. So as a compromise, I think it is perfectly reasonable
> > to require that systems that have such limitations communicate them
> > via the IORT, which we can parse early, regardless of whether _DMA
> > methods exist as well, and whether they return the same information.
> > 
> > So this is not a requirement on arm64 ACPI systems in general. It is a
> > requirement that expresses that we, as arm64
> > contributors/[co-]maintainers, are willing to cater for such systems
> > if they implement their firmware in a particular way.
> 
> I don't think they should implement their firmware in any particular
> way, that's my point, I don't want them to in the first place.

I haven't checked the *BBR specs, do they say anything about _DMA
methods or IORT tables for devices that can't access the full memory?

> To start with there is no spec I am aware of that defines when/how to
> use _DMA vs IORT address limits, maybe we should spell that out better
> somewhere and that's useful regardless.

I guess this answers my question above.

> My point is: either this workaround works with firmware written with
> guidelines valid for all arm64 systems (not as a special case: add an
> IORT table because we can't parse _DMA to workaround DMA address range
> shenanigans) or I am not willing to merge it - I prefer to add an OEM ID
> quirk and show what we are forced to do to make this work.

If the guidelines don't say anything about <=32-bit device masks, we can
make up our requirements for Linux. Currently it happens to work on some
kernel versions because we have a ZONE_DMA of 1GB but prior to this
change it wouldn't have worked. We might as well disable ZONE_DMA and
ZONE_DMA32 altogether because the BSA specs state that there are no such
limited devices, but some SoCs would no longer boot.

I think all this depends on whether 32-bit devices are also special and
need quirks. If they do, can we add both 32-bit and <32-bit devices in
the same "special" pot and require IORT tables? I agree it's not nice to
ignore the _DMA method alternative during zone setup but we could still
check the latter at run-time at warn if smaller than the minimum
ZONE_DMA available.

-- 
Catalin
