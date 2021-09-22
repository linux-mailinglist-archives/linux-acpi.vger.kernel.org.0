Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CFB41475F
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhIVLNL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Sep 2021 07:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235424AbhIVLNI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Sep 2021 07:13:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B91A3611C0;
        Wed, 22 Sep 2021 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632309098;
        bh=NnGf5aanVMI9Q2QeFfrZ/JPAh/XVIHVqkQ7T6ebXJJ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Dcx93AOYCAeK8ldIhELD+2bl1FpqFopZnW1zfXEiMvH6KCjgcCIVnV/or16NekSUp
         4oa+rED5QWprtkKiPzTIbOKpl5HNmDsQp2iAwwfxQkV7XiG5q6JajCqznDg4BK7KbV
         eB0BMXS9FcHrT0x6uQC7qQkSPTZOxFGAJ1lT0p4zWrDSVlPBKo5NZykeltOsKh6IEX
         Y1fcqJ4cSSnI6WoJaeAZBX5jMMuYDJtwip9onLBSAHemGrpGs5fCow3fId5ErAbWW1
         ZmPULABxQTemNn6QrtiopM6d5zOXhsxtG1XAbynXUfPvjGNCxwOfJvG6Rh6tTrDO5U
         6XfB8HMYCIdww==
Received: by mail-oi1-f178.google.com with SMTP id s69so3773182oie.13;
        Wed, 22 Sep 2021 04:11:38 -0700 (PDT)
X-Gm-Message-State: AOAM5334OrtXBehHgTsFgml2/W/64m6NBmHym842APlr9MACSNBcV/hS
        UrQ/guPhM4c/W+RPc5brejlskwruNoAtm2HtX4g=
X-Google-Smtp-Source: ABdhPJzJvgOHyvJicZBojo9bYixY+cEKhOBhFtrhxS1EKJMkgSw+57QEW/X1hg6rjKvRCqFzh+f1xZ7CatYX+GZ0qrA=
X-Received: by 2002:aca:3114:: with SMTP id x20mr7585573oix.174.1632309098052;
 Wed, 22 Sep 2021 04:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210910122820.26886-1-justin.he@arm.com> <20210910143223.6705-1-justin.he@arm.com>
 <CAMj1kXG6Gu=g8P902NB2b+OvzqwJQPqQewYX5UwMiXALYAFkDw@mail.gmail.com>
 <20210916160827.GA4525@lpieralisi> <20210920170055.GA13861@lpieralisi>
 <CAJZ5v0iee2j=NoPFpNstEZYJXWvFYfv22hK7QeH6+kdP6+MhLw@mail.gmail.com> <20210921100512.GA28390@lpieralisi>
In-Reply-To: <20210921100512.GA28390@lpieralisi>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 22 Sep 2021 13:11:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFz=bsm+Jx-iWB17tYNfi+twSh-uSZfnoDnUf2CMXYodw@mail.gmail.com>
Message-ID: <CAMj1kXFz=bsm+Jx-iWB17tYNfi+twSh-uSZfnoDnUf2CMXYodw@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "ACPI: Add memory semantics to acpi_os_map_memory()"
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jia He <justin.he@arm.com>, Will Deacon <will@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Harb Abdulhamid <harb@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 21 Sept 2021 at 12:05, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Sep 20, 2021 at 07:32:56PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Sep 20, 2021 at 7:03 PM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Thu, Sep 16, 2021 at 05:08:27PM +0100, Lorenzo Pieralisi wrote:
> > > > On Fri, Sep 10, 2021 at 07:28:49PM +0200, Ard Biesheuvel wrote:
> > > > > On Fri, 10 Sept 2021 at 16:32, Jia He <justin.he@arm.com> wrote:
> > > > > >
> > > > > > This reverts commit 437b38c51162f8b87beb28a833c4d5dc85fa864e.
> > > > > >
> > > > > > After this commit, a boot panic is alway hit on an Ampere EMAG server
> > > > > > with call trace as follows:
> > > > > >  Internal error: synchronous external abort: 96000410 [#1] SMP
> > > > > >  Modules linked in:
> > > > > >  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.14.0+ #462
> > > > > >  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
> > > > > >  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > > [...snip...]
> > > > > >  Call trace:
> > > > > >   acpi_ex_system_memory_space_handler+0x26c/0x2c8
> > > > > >   acpi_ev_address_space_dispatch+0x228/0x2c4
> > > > > >   acpi_ex_access_region+0x114/0x268
> > > > > >   acpi_ex_field_datum_io+0x128/0x1b8
> > > > > >   acpi_ex_extract_from_field+0x14c/0x2ac
> > > > > >   acpi_ex_read_data_from_field+0x190/0x1b8
> > > > > >   acpi_ex_resolve_node_to_value+0x1ec/0x288
> > > > > >   acpi_ex_resolve_to_value+0x250/0x274
> > > > > >   acpi_ds_evaluate_name_path+0xac/0x124
> > > > > >   acpi_ds_exec_end_op+0x90/0x410
> > > > > >   acpi_ps_parse_loop+0x4ac/0x5d8
> > > > > >   acpi_ps_parse_aml+0xe0/0x2c8
> > > > > >   acpi_ps_execute_method+0x19c/0x1ac
> > > > > >   acpi_ns_evaluate+0x1f8/0x26c
> > > > > >   acpi_ns_init_one_device+0x104/0x140
> > > > > >   acpi_ns_walk_namespace+0x158/0x1d0
> > > > > >   acpi_ns_initialize_devices+0x194/0x218
> > > > > >   acpi_initialize_objects+0x48/0x50
> > > > > >   acpi_init+0xe0/0x498
> > > > > >
> > > > > > As mentioned by Lorenzo:
> > > > > >   "We are forcing memory semantics mappings to PROT_NORMAL_NC, which
> > > > > >   eMAG does not like at all and I'd need to understand why. It looks
> > > > > >   like the issue happen in SystemMemory Opregion handler."
> > > > > >
> > > > > > Hence just revert it before everything is clear.
> > > > > >
> > > > >
> > > > > Can we try to find the root cause first? -rc1 is not even out yet, and
> > > > > reverting it now means we can not resubmit it until the next merge
> > > > > window.
> > > >
> > > > I am waiting to debug this on an eMAG but I noticed something that
> > > > I wanted to bring up.
> > > >
> > > > SystemMemory Operation region handler - ie
> > > >
> > > > acpi_ex_system_memory_space_handler()
> > > >
> > > > maps the Operation Region (that AFAICS is MMIO, it is _not_ memory)
> > > > with acpi_os_map_memory() and I believe that's what is causing this
> > > > bug.
> > > >
> > > > On the other hand, acpi_os_map_generic_address(), to handle spaceid
> > > > ACPI_ADR_SPACE_SYSTEM_MEMORY, uses acpi_os_map_iomem() that is more
> > > > in line with my expectations.
> > >
> > > Hi Rafael,
> > >
> > > I wanted to ask please if you have any insights on why
> > >
> > > (1) acpi_ex_system_memory_space_handler()
> > > (2) acpi_os_map_generic_address()
> > >
> > > Use two different calls to map memory for the _same_ address space ID
> > > (SystemMemory).
> > >
> > > (3) acpi_os_map_memory()
> > > vs
> > > (4) acpi_os_map_iomem()
> >
> > I don't really have a good answer here.
> >
> > On x86 this doesn't really matter and that's where
> > acpi_ex_system_memory_space_handler() was first introduced.  It is not
> > only used for IOMEM (there are SystemMemory operation regions in RAM),
> > but since it may be in IOMEM, it should assume so.
> >
> > > I am struggling to understand why (1) uses (3) ("memory semantics") when
> > > (2) uses (4) - it is actually unclear how the distinction between
> > > the two mapping APIs is to be drawn and on what basis one should
> > > choose which one to use.
> > >
> > > I am still waiting to grab some HW to debug this report but the issue
> > > here is that we are mapping an OpRegion SystemMemory with (3) in the
> > > memory space handler and given the patch we are reverting we end up
> > > mapping the operation region with normal non-cacheable memory attributes
> > > that probably the physical address range behind the OpRegion does not
> > > support.
> >
> > If that is the case, there needs to be a mechanism to decide what kind
> > of mapping to use for SystemMemory operation regions based on the type
> > of physical memory the address range in question is located in.
>
> Thank you Rafael. The mechanism we are currently relying on is the EFI
> memory map but if the Opregion address is not described there then we
> are left with a default choice to make (theoretically I may also parse
> all _CRS in the namespace to find whether a resource include the
> Opregion and I may infer attributes from the _CRS resource entry).
>

I'm not sure that would help, as I would expected the memory described
by _CRS to be mostly mutually exclusive from memory used by OpRegions.

> Maybe we should update the ACPI specs to enforce it; with current
> firmware the idea of using the OS expected *usage* of memory (ie
> memory vs IO) described by the mapping function prototype can't work
> as this revert shows (even though it would be better if I manage
> to find what the precise issue is).
>
> We can't map something with specific attributes if we don't know
> whether the physical address space backing the region supports it.
>

We don't have a a safe default in either direction, so I agree this is
a hole in the specs.

> I am left with little choice: I assume the best thing I could do
> to fix the original bug is to use ioremap_* in acpi_data_show()
> instead of acpi_os_map/unmap_memory() to map that memory with
> specific attributes (for BERT error regions, they must be RAM
> so, _hopefully_, we know it can be mapped with eg normal memory
> mappings).
>
> Thoughts ?
>

One thing I just realized is that the EFI memory map is not a complete
solution to begin with, as it may not cover hot/coldplugged memory
regions that are only described via ACPI.

Did you make any progress with the eMAG?
