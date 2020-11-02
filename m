Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF52A31ED
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgKBRrZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 12:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKBRrZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Nov 2020 12:47:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F90C0617A6
        for <linux-acpi@vger.kernel.org>; Mon,  2 Nov 2020 09:47:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so14092469edv.11
        for <linux-acpi@vger.kernel.org>; Mon, 02 Nov 2020 09:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V4wLdButXyc+1Eb8bFrf8nQwDzP26JReH8M9WtyD/YQ=;
        b=ZLrhjOc7VGG4u1FcRlStqQ6C+lYJMLuxl+wSam+nSelhoflQKZFNH4NIlWuO+a/5Oa
         2zYhlJWuSS1/FyLnuyml/Vlth60X48hXJXln8J7hgFI/zF6MiLlQgpGvJoHhw8w8pccr
         dg/XUKF5Kne8aNORb/WU8diM92OjOx8bSZ7zimohpl1uL7AVCAGg4Rst3cxdMCHqY5Ea
         zo82UIregs8WuCGDi194J24I/dctzC2okDLrRHdbbkh0O6eQ1A07/LDjrm7Rqb1sXQ4S
         qVhuRbt+FI5FBhtEcjEWDDM0Pp39m7Yz+kahPHk69OT2nXcg/FqyDvKCaM3qD2U2vpw+
         cC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4wLdButXyc+1Eb8bFrf8nQwDzP26JReH8M9WtyD/YQ=;
        b=Vzl0ighK0Gqqa24GwPRSFHK0Lr4L0eKGpNIN6kthoxx1yhnt8My66hG6mgKVULi0BW
         bP2ljMt6CGwekmzu2AONrA2epWL8woVwl51yE3ukO02TWxu3vtU5kD5REm+pa+eCnShw
         TL0J+CZ2yTKDqcwj9vJnoIYLQgR0aItQBhZ85oRPmod/kxu0sIcRA+Au0PqkcNzH2Cti
         GOVl5ZZWl475YbE7qD4mRMpqpVevjheWfAou2jNWR9X/YuV9HGLdrlr2FkuE5GGAwGbY
         L/ngsF+tHIUY0RnGQyywMfPoKmcC5zCT+9ds12FD9BKAXCyWjg1uJXhohl2av9POVtfX
         O5Aw==
X-Gm-Message-State: AOAM530cq5x3mHAg5r6dfqpdqbM22yeC0izVsHToMf+DVlU7CLgYlICr
        mRV7V8RbIjQS+QHqoHULWTOCLHJDNi+AQmH8+hZKPQ==
X-Google-Smtp-Source: ABdhPJwM1r88OldayVm4GhZX5F1+f4Q4gRWw7jgrzoBJeb+vkuiz+Wd1U6wbZ+0cTWhd8yYaTzTjxyRNZA/YbLYfua4=
X-Received: by 2002:a50:871d:: with SMTP id i29mr17882067edb.300.1604339243804;
 Mon, 02 Nov 2020 09:47:23 -0800 (PST)
MIME-Version: 1.0
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
 <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com> <BL0PR12MB2532DDE990282976888108D2BD150@BL0PR12MB2532.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB2532DDE990282976888108D2BD150@BL0PR12MB2532.namprd12.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 2 Nov 2020 09:47:11 -0800
Message-ID: <CAPcyv4i5S5Bb6118GxxF=-5LxZ2h1ecz25-LHnAHWX2hLDteeA@mail.gmail.com>
Subject: Re: Onlining CXL Type2 device coherent memory
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 30, 2020 at 3:40 PM Vikram Sethi <vsethi@nvidia.com> wrote:
>
> Hi Dan,
> > From: Dan Williams <dan.j.williams@intel.com>
> > On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:
> > >
> > > Hello,
> > >
> > > I wanted to kick off a discussion on how Linux onlining of CXL [1] type 2 device
> > > Coherent memory aka Host managed device memory (HDM) will work for type 2
> > CXL
> > > devices which are available/plugged in at boot. A type 2 CXL device can be
> > simply
> > > thought of as an accelerator with coherent device memory, that also has a
> > > CXL.cache to cache system memory.
> > >
> > > One could envision that BIOS/UEFI could expose the HDM in EFI memory map
> > > as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However, at least
> > > on some architectures (arm64) EFI conventional memory available at kernel boot
> > > memory cannot be offlined, so this may not be suitable on all architectures.
> >
> > That seems an odd restriction. Add David, linux-mm, and linux-acpi as
> > they might be interested / have comments on this restriction as well.
> >
> > > Further, the device driver associated with the type 2 device/accelerator may
> > > want to save off a chunk of HDM for driver private use.
> > > So it seems the more appropriate model may be something like dev dax model
> > > where the device driver probe/open calls add_memory_driver_managed, and
> > > the driver could choose how much of the HDM it wants to reserve and how
> > > much to make generally available for application mmap/malloc.
> >
> > Sure, it can always be driver managed. The trick will be getting the
> > platform firmware to agree to not map it by default, but I suspect
> > you'll have a hard time convincing platform-firmware to take that
> > stance. The BIOS does not know, and should not care what OS is booting
> > when it produces the memory map. So I think CXL memory unplug after
> > the fact is more realistic than trying to get the BIOS not to map it.
> > So, to me it looks like arm64 needs to reconsider its unplug stance.
>
> Agree. Cc Anshuman, Will, Catalin, Ard, in case I missed something in
> Anshuman's patches adding arm64 memory remove, or if any plans to remove
> the limitation.
>
> > > Another thing to think about is whether the kernel relies on UEFI having fully
> > > described NUMA proximity domains and end-end NUMA distances for HDM,
> > > or whether the kernel will provide some infrastructure to make use of the
> > > device-local affinity information provided by the device in the Coherent Device
> > > Attribute Table (CDAT) via a mailbox, and use that to add a new NUMA node ID
> > > for the HDM, and with the NUMA distances calculated by adding to the NUMA
> > > distance of the host bridge/Root port with the device local distance. At least
> > > that's how I think CDAT is supposed to work when kernel doesn't want to rely
> > > on BIOS tables.
> >
> > The kernel can supplement the NUMA configuration from CDAT, but not if
> > the memory is already enumerated in the EFI Memory Map and ACPI
> > SRAT/HMAT. At that point CDAT is a nop because the BIOS has precluded
> > the OS from consuming it.
>
> That makes sense.
>
> > > A similar question on NUMA node ID and distances for HDM arises for CXL
> > hotplug.
> > > Will the kernel rely on CDAT, and create its own NUMA node ID and patch up
> > > distances, or will it rely on BIOS providing PXM domain reserved at boot in
> > > SRAT to be used later on hotplug?
> >
> > I don't expect the kernel to merge any CDAT data into the ACPI tables.
> > Instead the kernel will optionally use CDAT as an alternative method
> > to generate Linux NUMA topology independent of ACPI SRAT. Think of it
> > like Linux supporting both ACPI and Open Firmware NUMA descriptions at
> > the same time. CDAT is its own NUMA description domain unless BIOS has
> > blurred the lines and pre-incorporated it into SRAT/HMAT. That said I
> > think the CXL attached memory not described by EFI / ACPI is currently
> > the NULL set.
>
> What I meant by patch/merge was if on a dual socket system with distance 40
> between the sockets (not getting into HMAT vs SLIT description of latency),
> if you hotplugged in a CXL type2/3 device whose CDAT says device local 'distance'
> is 80, then the kernel is still merging that 80 in with the 40 to the remote socket
> to say 120 from remote socket CPU to this socket's CXL device i.e whether the
> 40 came from SLIT or HMAT, it is still merged into the data kernel had obtained
> from ACPI. I think you're saying the same thing in a different way:
> that the device local part is not being merged with anything ACPI provided for
> the device, example _SLI at time of hotplug (which I agree with).

Thankfully CDAT abandons the broken and gamed system of distance
values (i.e. firmware sometimes reverse engineering OS behavior) in
favor of nominal performance values like HMAT. With that in hand I
think it simplifies the kernel's responsibility to worry less about
"distance" values and instead identify whether the memory range is
"Linux-local" or "Linux-remote" and where to order it in the
allocation fallback lists.

As Dave implemented in his "migrate in lieu of discard" series [1],
find_next_best_node() establishes this ordering for memory tiering, so
the rough plan is to teach each CXL supporting arch how to incorporate
CDAT data into its find_next_best_node() implementation.

[1]: https://lore.kernel.org/linux-mm/20201007161736.ACC6E387@viggo.jf.intel.com/
