Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E762FF993
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 01:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbhAVAuO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 19:50:14 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:38550 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbhAVAuJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 19:50:09 -0500
Received: by mail-pl1-f177.google.com with SMTP id d4so2287225plh.5;
        Thu, 21 Jan 2021 16:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6AIhNuCe/1GTY8tOy/5C+s0wH6veWybr8jaw1m3E9Hg=;
        b=Lf+yh0oRASEEvnfQMIrlZtWko0D0nBdgSw7/mxFO6eewN5e6nMEc1eF7MoZPvDSlgr
         5ALbey8NL6QC1NshSqIOZGRn7mLCp8I6zcwW58QrEBDdxaTLKHTSGEe3suTvkUkh3NcG
         8POH2+CmFzTDvc+xl63X7N9gMDArckA82mPqIZ71wMr/0COMuu0u1LvmOtVmfiFWHfb6
         bSYWzUe+P2WuC+8kEZUjZGjOHM4qYNOQqDEGzpXIIYBpEIbv5IPKb7HEPBKwPUP6Ww62
         L1m/ZOaDrJxgydFzmwxvgfuynwUv1sCtD7Kh/+TPtAvB5to1vgR3NJB24iiSY1uYaN0K
         KdKQ==
X-Gm-Message-State: AOAM5301SqR1vyGVX8r24j9LhyYccszeg1wI3me4LnXFPjO7TOHwU12o
        1UIy0r+VQa4NrQIC4cxR430nd7ZyQFo=
X-Google-Smtp-Source: ABdhPJyckVCo7YfZkh7bWlgUT2Dd/TuGmMbOaeo7nbGqTHZoBJ4BpFQjb57/oG7YRMBwj4tzAFI4dA==
X-Received: by 2002:a17:90b:602:: with SMTP id gb2mr2284162pjb.170.1611276568552;
        Thu, 21 Jan 2021 16:49:28 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id q22sm5863545pgi.66.2021.01.21.16.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 16:49:27 -0800 (PST)
Date:   Thu, 21 Jan 2021 16:49:25 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Moritz Fischer <mdf@kernel.org>, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        moritzf@google.com, sudeep.holla@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ACPI/IORT: Do not blindly trust DMA masks from firmware
Message-ID: <YAohFd5g8qovkFwO@archbook>
References: <20210121191612.90387-1-mdf@kernel.org>
 <faa089d5-48e3-d51d-0d14-849e5446dbf4@arm.com>
 <YAnvckodi9MOTrV4@epycbox.lan>
 <e8eb32be-0aca-e8a3-046b-e280ea9c31d1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8eb32be-0aca-e8a3-046b-e280ea9c31d1@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Robin,

On Thu, Jan 21, 2021 at 11:15:05PM +0000, Robin Murphy wrote:
> On 2021-01-21 21:17, Moritz Fischer wrote:
> > Robin,
> > 
> > On Thu, Jan 21, 2021 at 08:08:42PM +0000, Robin Murphy wrote:
> > > On 2021-01-21 19:16, Moritz Fischer wrote:
> > > > Address issue observed on real world system with suboptimal IORT table
> > > > where DMA masks of PCI devices would get set to 0 as result.
> > > > 
> > > > iort_dma_setup() would query the root complex' IORT entry for a DMA
> > > > mask, and use that over the one the device has been configured with
> > > > earlier.
> > > > 
> > > > Ideally we want to use the minimum mask of what the IORT contains for
> > > > the root complex and what the device was configured with, but never 0.
> > > > 
> > > > Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
> > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > ---
> > > > Hi all,
> > > > 
> > > > not sure I'm doing this right, but I think the current behavior (while a
> > > > corner case) seems to also fail for 32 bit devices if the IORT specifies
> > > > 64 bit. It works on my test system now with a 32 bit device.
> > > 
> > > I suppose it could go wrong if it's an old driver that doesn't explicitly
> > > set its own masks and assumes they will always be 32-bit. Technically we'd
> > > consider that the driver's fault these days, but there's a lot of legacy
> > > around still.
> > 
> > Huh, ok :) That's news to me. On my system I had three devices running
> > into this, so yeah I think it's quite common.
> 
> Indeed, I'm sure there are plenty of drivers that haven't been touched in
> decades because they're complete and working, and back then they were
> allowed to make that assumption.
> 
> > If that's the official stance I can send patches for the drivers in
> > question :)
> 
> It's certainly good practice, especially for older devices that are still
> popular enough to see use on the increasing variety of new systems. Some
> people are still using the infamous arm64 platform where all the RAM is
> above 40 bits, for instance, and who knows how creative system designers
> might continue to be, so better to give the driver a chance to bail out of
> probing in the rare event that explicitly setting its 32-bit masks *does*
> fail, rather than let it assume DMA should work then get confused when it
> doesn't.
> 
> > > > Open to suggestions for better solutions (and maybe the
> > > > nc_dma_get_range() should have the same sanity check?)
> > > 
> > > Honestly the more I come back to this, the more I think we should give up
> > > trying to be clever and just leave the default masks alone beyond the
> > > initial "is anything set up at all?" sanity checks. Setting the bus limit is
> > > what really matters these days, and should be sufficient to encode any
> > > genuine restriction. There's certainly no real need to widen the default
> > > masks above 32 bits just because firmware suggests so, since the driver
> > > should definitely be calling dma_set_mask() and friends later if it's
> > > > 32-bit capable anyway.
> > > 
> > > > Thanks,
> > > > Moritz
> > > > 
> > > > ---
> > > >    drivers/acpi/arm64/iort.c | 11 ++++++++---
> > > >    1 file changed, 8 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > > index d4eac6d7e9fb..c48eabf8c121 100644
> > > > --- a/drivers/acpi/arm64/iort.c
> > > > +++ b/drivers/acpi/arm64/iort.c
> > > > @@ -1126,6 +1126,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
> > > >    	rc = (struct acpi_iort_root_complex *)node->node_data;
> > > > +	if (!rc->memory_address_limit) {
> > > > +		dev_warn(dev, "Root complex has broken memory_address_limit\n");
> > > 
> > > Probably warrants a FW_BUG in there.
> > > 
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > >    	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> > > >    			1ULL<<rc->memory_address_limit;
> > > > @@ -1172,9 +1177,9 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> > > >    		 */
> > > >    		end = dmaaddr + size - 1;
> > > >    		mask = DMA_BIT_MASK(ilog2(end) + 1);
> > > > -		dev->bus_dma_limit = end;
> > > > -		dev->coherent_dma_mask = mask;
> > > > -		*dev->dma_mask = mask;
> > > > +		dev->bus_dma_limit = min_not_zero(dev->bus_dma_limit, end);
> > > 
> > > This doesn't need to change, since the default bus limit is 0 anyway (and
> > > that means "no limit").
> > Ok, I'll drop this.
> > > 
> > > > +		dev->coherent_dma_mask = min_not_zero(dev->coherent_dma_mask, mask);
> > > > +		*dev->dma_mask = min_not_zero(*dev->dma_mask, mask);
> > 
> > I'll keep those two?
> 
> Well...
> 
> > > AFAICS the only way an empty mask could get here now is from
> > > nc_dma_get_range(), so I'd rather see a consistent warning there than just
> > > silently start working around that too.
> > 
> > In my case the empty mask came from the pci dev branch returning a size
> > of 1. (1 << 0).
> 
> In fact I think I was too hasty in saying even that - it actually looks like
> you can't get a mask of 0 either way. If memory_address_limit is 0, then
> size is 1, dmaaddr is 0 (since acpi_dma_get_range() had to fail in the first
> place), so end is 0, so mask is DMA_BIT_MASK(0 + 1), which is 1. So
> min_not_zero() still does nothing :/

The min_not_zero() is to not go from 32 to > 32 if firmware sets it to
say 33? If you prefer we can change it to min() instead?

IMHO we should never widen the mask only narrow it, agreed?
> 
> > I'll replace the dev_warn() with a pr_warn(FW_BUG ...) for both
> > {nc,rc}_dma_get_range() cases then?
> 
> Yes, I think it's worth being consistent. And then we can't ever get past
> the "if (!ret)" condition without a valid size, so we definitely don't need
> to touch anything inside it. And by "valid" I mean that if someone goes to
> the effort of filling in that field with even a 1, then by 'eck we're
> givin'em the 1-bit DMA limit they asked for!
> 
> > > Of course IORT doesn't say these fields are optional (other than the lack of
> > > a root complex limit in older table versions), so we're giving bad firmware
> > > a pass to never be fixed, ho hum...
> > 
> > I think if we yell loud enough (like FW_BUG) that'll get people's
> > attention?
> 
> Ha! I've got a machine where MSIs don't work (let alone SMMU translation...)
> because some of the device mapping offsets are pointing into random parts of
> the IORT like the middle of other nodes' headers. If it boots to a prompt at
> all, someone somewhere will be happy to ship it ;)
Whoa :D

Thanks for the feedback,

Moritz
