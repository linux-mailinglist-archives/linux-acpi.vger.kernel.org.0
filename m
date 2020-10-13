Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7728D16F
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 17:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgJMPpZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 11:45:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbgJMPpY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 11:45:24 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49BC251F8;
        Tue, 13 Oct 2020 15:45:21 +0000 (UTC)
Date:   Tue, 13 Oct 2020 16:45:19 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
Message-ID: <20201013154518.GO10778@gaia>
References: <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
 <CAMj1kXE6mQAnDigp_+nqEj0f+=kBht2Xoqd8S2L1QfPzjL9gog@mail.gmail.com>
 <20201012112453.GD9844@gaia>
 <CAMj1kXEmAxytDjcAgpGpCqWcEuO0HijLVuTZcz-vywW=a74mmA@mail.gmail.com>
 <20201012154954.GB6493@gaia>
 <CAMj1kXFKRZ-eHtvqxZ84RSVcY8LQgkv1Vh6w8CvsWyOO-qJcuA@mail.gmail.com>
 <20201012162238.GC6493@gaia>
 <CAMj1kXFpbVUjOHWEcyzzUR2q7SEWpkiQi3nB+OCLySDHhYY+Fw@mail.gmail.com>
 <20201012165933.GD6493@gaia>
 <bd0015dd37df6397767bda2ab8cdff7f805ee4f4.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd0015dd37df6397767bda2ab8cdff7f805ee4f4.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 13, 2020 at 04:42:36PM +0200, Nicolas Saenz Julienne wrote:
> On Mon, 2020-10-12 at 17:59 +0100, Catalin Marinas wrote:
> > On Mon, Oct 12, 2020 at 06:35:37PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 12 Oct 2020 at 18:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > On Mon, Oct 12, 2020 at 05:55:45PM +0200, Ard Biesheuvel wrote:
> > > > > On Mon, 12 Oct 2020 at 17:50, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > > > > On Mon, Oct 12, 2020 at 12:43:05PM +0200, Ard Biesheuvel wrote:
> > > > > > > > > Also, could someone give an executive summary of why it matters where
> > > > > > > > > the crashkernel is loaded? As far as I can tell, reserve_crashkernel()
> > > > > > > > > only allocates memory for the kernel's executable image itself, which
> > > > > > > > > can usually be loaded anywhere in memory. I could see how a
> > > > > > > > > crashkernel might need some DMA'able memory if it needs to use the
> > > > > > > > > hardware, but I don't think that is what is going on here.
> > > > [...]
> > > > > > However, the crashkernel=... range is meant for sufficiently large
> > > > > > reservation to be able to run the kdump kernel, not just load the image.
> > > > > 
> > > > > Sure. But I was referring to the requirement that it is loaded low in
> > > > > memory. Unless I am misunderstanding something, all we need for the
> > > > > crashkernel to be able to operate is some ZONE_DMA memory in case it
> > > > > is needed by the hardware, and beyond that, it could happily live
> > > > > anywhere in memory.
> > > > 
> > > > Yes, the crash kernel doesn't need to be loaded in the low memory. But
> > > > some low memory needs to end up in its perceived System RAM. That's what
> > > > Chen is trying to do with this series:
> > > > 
> > > > https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-1-chenzhou10@huawei.com/
> > > > 
> > > > It reserves the normal crashkernel memory at some high address range
> > > > with a small block (currently proposed as 256MB similar to x86) in the
> > > > "low" range.
> > > > 
> > > > This "low" range for arm64 currently means below 1GB but it's only RPi4
> > > > that needs it this low, all other platforms are fine with the full low
> > > > 32-bit range.
> > > > 
> > > > If it's not doable in a nice way, we'll just leave with this permanent
> > > > 1GB ZONE_DMA and hope we won't get platforms requiring an even smaller
> > > > one. There's also the option of ignoring kdump on RPi4, make ZONE_DMA
> > > > depend on !CRASH_DUMP and the "low" reservations can use the full 32-bit
> > > > range since the kdump kernel won't need <30-bit addresses.
> > > 
> > > Are you aware of any reason why we cannot defer the call to
> > > reserve_crashkernel() to the start of bootmem_init()? That way, we
> > > have access to the unflattened DT as well as the IORT, and so we can
> > > tweak the zone limits based on the h/w description, but before
> > > allocating the crashkernel.
> > 
> > Not really, as long as memblock_reserve/alloc() still works.
> 
> I had a look at this myself, and IIUC we're free to call reserve_crashkernel()
> anytime as long as it's before memblock_free_all().
> 
> So, should I add a patch in my series taking care of that? or you'd rather take
> care of it yourselves?

Please add it to your series, it wouldn't be needed without your (and
Ard's) patches anyway.

-- 
Catalin
