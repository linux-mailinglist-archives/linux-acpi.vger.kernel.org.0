Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1422628BD8C
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 18:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbgJLQWo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 12:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390114AbgJLQWn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Oct 2020 12:22:43 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D7A5206CB;
        Mon, 12 Oct 2020 16:22:41 +0000 (UTC)
Date:   Mon, 12 Oct 2020 17:22:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
Message-ID: <20201012162238.GC6493@gaia>
References: <20201010093153.30177-1-ardb@kernel.org>
 <20201012092821.GB9844@gaia>
 <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
 <CAMj1kXE6mQAnDigp_+nqEj0f+=kBht2Xoqd8S2L1QfPzjL9gog@mail.gmail.com>
 <20201012112453.GD9844@gaia>
 <CAMj1kXEmAxytDjcAgpGpCqWcEuO0HijLVuTZcz-vywW=a74mmA@mail.gmail.com>
 <20201012154954.GB6493@gaia>
 <CAMj1kXFKRZ-eHtvqxZ84RSVcY8LQgkv1Vh6w8CvsWyOO-qJcuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFKRZ-eHtvqxZ84RSVcY8LQgkv1Vh6w8CvsWyOO-qJcuA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 12, 2020 at 05:55:45PM +0200, Ard Biesheuvel wrote:
> On Mon, 12 Oct 2020 at 17:50, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > On Mon, Oct 12, 2020 at 12:43:05PM +0200, Ard Biesheuvel wrote:
> > > > > Also, could someone give an executive summary of why it matters where
> > > > > the crashkernel is loaded? As far as I can tell, reserve_crashkernel()
> > > > > only allocates memory for the kernel's executable image itself, which
> > > > > can usually be loaded anywhere in memory. I could see how a
> > > > > crashkernel might need some DMA'able memory if it needs to use the
> > > > > hardware, but I don't think that is what is going on here.
[...]
> > However, the crashkernel=... range is meant for sufficiently large
> > reservation to be able to run the kdump kernel, not just load the image.
> 
> Sure. But I was referring to the requirement that it is loaded low in
> memory. Unless I am misunderstanding something, all we need for the
> crashkernel to be able to operate is some ZONE_DMA memory in case it
> is needed by the hardware, and beyond that, it could happily live
> anywhere in memory.

Yes, the crash kernel doesn't need to be loaded in the low memory. But
some low memory needs to end up in its perceived System RAM. That's what
Chen is trying to do with this series:

https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-1-chenzhou10@huawei.com/

It reserves the normal crashkernel memory at some high address range
with a small block (currently proposed as 256MB similar to x86) in the
"low" range.

This "low" range for arm64 currently means below 1GB but it's only RPi4
that needs it this low, all other platforms are fine with the full low
32-bit range.

If it's not doable in a nice way, we'll just leave with this permanent
1GB ZONE_DMA and hope we won't get platforms requiring an even smaller
one. There's also the option of ignoring kdump on RPi4, make ZONE_DMA
depend on !CRASH_DUMP and the "low" reservations can use the full 32-bit
range since the kdump kernel won't need <30-bit addresses.

-- 
Catalin
