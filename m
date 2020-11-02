Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B2D2A3317
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgKBSgf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Nov 2020 13:36:35 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgKBSgf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 13:36:35 -0500
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5DA34F0A6D15097B8BB5;
        Mon,  2 Nov 2020 18:36:31 +0000 (GMT)
Received: from localhost (10.52.120.98) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 2 Nov 2020
 18:36:30 +0000
Date:   Mon, 2 Nov 2020 18:34:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     David Hildenbrand <david@redhat.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: Onlining CXL Type2 device coherent memory
Message-ID: <20201102183428.00005f4f@Huawei.com>
In-Reply-To: <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
        <CAPcyv4jWFf0=VoA2EiXPaQphA-5z9JFO8h0Agy0dO0w6nDyorw@mail.gmail.com>
        <451b2571-c3e8-97d8-bfd0-f8054a1b75c5@redhat.com>
        <CAPcyv4jX1tedjuU-vCSKgvhQeNFukyq9d0ddmsk7jAjWMX+iBQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.98]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 31 Oct 2020 09:51:23 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sat, Oct 31, 2020 at 3:21 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 30.10.20 21:37, Dan Williams wrote:  
> > > On Wed, Oct 28, 2020 at 4:06 PM Vikram Sethi <vsethi@nvidia.com> wrote:  
> > >>
> > >> Hello,
> > >>
> > >> I wanted to kick off a discussion on how Linux onlining of CXL [1] type 2 device
> > >> Coherent memory aka Host managed device memory (HDM) will work for type 2 CXL
> > >> devices which are available/plugged in at boot. A type 2 CXL device can be simply
> > >> thought of as an accelerator with coherent device memory, that also has a
> > >> CXL.cache to cache system memory.
> > >>
> > >> One could envision that BIOS/UEFI could expose the HDM in EFI memory map
> > >> as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However, at least
> > >> on some architectures (arm64) EFI conventional memory available at kernel boot
> > >> memory cannot be offlined, so this may not be suitable on all architectures.  
> > >
> > > That seems an odd restriction. Add David, linux-mm, and linux-acpi as
> > > they might be interested / have comments on this restriction as well.
> > >  
> >
> > I am missing some important details.
> >
> > a) What happens after offlining? Will the memory be remove_memory()'ed?
> > Will the device get physically unplugged?
> >
> > b) What's the general purpose of the memory and its intended usage when
> > *not* exposed as system RAM? What's the main point of treating it like
> > ordinary system RAM as default?
> >
> > Also, can you be sure that you can offline that memory? If it's
> > ZONE_NORMAL (as usually all system RAM in the initial map), there are no
> > such guarantees, especially once the system ran for long enough, but
> > also in other cases (e.g., shuffling), or if allocation policies change
> > in the future.
> >
> > So I *guess* you would already have to use kernel cmdline hacks like
> > "movablecore" to make it work. In that case, you can directly specify
> > what you *actually* want (which I am not sure yet I completely
> > understood) - e.g., something like "memmap=16G!16G" ... or something
> > similar.
> >
> > I consider offlining+removing *boot* memory to not physically unplug it
> > (e.g., a DIMM getting unplugged) abusing the memory hotunplug
> > infrastructure. It's a different thing when manually adding memory like
> > dax_kmem does via add_memory_driver_managed().
> >
> >
> > Now, back to your original question: arm64 does not support physically
> > unplugging DIMMs that were part of the initial map. If you'd reboot
> > after unplugging a DIMM, your system would crash. We achieve that by
> > disallowing to offline boot memory - we could also try to handle it in
> > ACPI code. But again, most uses of offlining+removing boot memory are
> > abusing the memory hotunplug infrastructure and should rather be solved
> > cleanly via a different mechanism (firmware, kernel cmdline, ...).
> >
> > Just recently discussed in
> >
> > https://lkml.kernel.org/r/de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org
> >  
> > >> Further, the device driver associated with the type 2 device/accelerator may
> > >> want to save off a chunk of HDM for driver private use.
> > >> So it seems the more appropriate model may be something like dev dax model
> > >> where the device driver probe/open calls add_memory_driver_managed, and
> > >> the driver could choose how much of the HDM it wants to reserve and how
> > >> much to make generally available for application mmap/malloc.  
> > >
> > > Sure, it can always be driver managed. The trick will be getting the
> > > platform firmware to agree to not map it by default, but I suspect
> > > you'll have a hard time convincing platform-firmware to take that
> > > stance. The BIOS does not know, and should not care what OS is booting
> > > when it produces the memory map. So I think CXL memory unplug after
> > > the fact is more realistic than trying to get the BIOS not to map it.
> > > So, to me it looks like arm64 needs to reconsider its unplug stance.  
> >
> > My personal opinion is, if memory isn't just "ordinary system RAM", then
> > let the system know early that memory is special (as we do with
> > soft-reserved).
> >
> > Ideally, you could configure the firmware (e.g., via BIOS setup) on what
> > to do, that's the cleanest solution, but I can understand that's rather
> > hard to achieve.  
> 
> Yes, my hope, which is about the most influence I can have on
> platform-firmware implementations, is that it marks CXL attached
> memory as soft-reserved by default and allow OS policy decide where it
> goes. Barring that, for the configuration that Vikram mentioned, the
> only other way to get this differentiated / not-ordinary system-ram
> back to being driver managed would be to unplug it. The soft-reserved
> path is cleaner.
> 

The whole reason that was introduced into UEFI the first place was to handle
this case.  SPM is still in the EFI_MEMORY_MAP but should not be used
for non moveable general purpose allocations.  It was intended for RAM
that you 'could' use for normal purpose if it wasn't being used for what
it was put there for (i.e. your GPU or similar isn't using it).

So agreed, soft-reserved / SPM.  

Jonathan



