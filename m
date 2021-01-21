Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39782FF708
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 22:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbhAUVSo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 16:18:44 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39964 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbhAUVSY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 16:18:24 -0500
Received: by mail-pf1-f182.google.com with SMTP id i63so2288443pfg.7;
        Thu, 21 Jan 2021 13:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nCPV03LmtFFgNcmlSbKeR1ygTL47bRCqEh8UZyzy3+Q=;
        b=P04qPiUWgcgEPj12Dz+M/9rq/H5gR9gqN8VWQ+1NRZmjjgQN0QEdduUMrEURBnueh/
         7QU8EGByec6JaUjSziCpOZ6/42G9Lr3QwosAhqn71znFVsWsgvuwd1J1RN+5phrHGd6w
         d/R1p+Cr9b6zBlXbrJJkjAksYnJ1lqBO2nbgDYTpOmNMHgTY1vZbqm/hpeS6lW2yowdS
         qR40V2wMozFD6V+xNoAL0D1opbtL1N8jUA5F3yKf/hbnYILXxwddFwI0hKWr4NBeItNb
         wVppceIWiB03aPXK+uAiGXgrz6Y8iWnrIRuUaU/Q1R9LNJfgjXbUFaWp5QkGhL+chQn+
         1xvw==
X-Gm-Message-State: AOAM531IFzb5ASHjBJCoQ5i3rtgfw4e2Pg1nbANZYAv+HhXO3x8xIavn
        /v4KqpfzTvrkQwa2StAkjWHQIgupkWU=
X-Google-Smtp-Source: ABdhPJx4ZPV+AWlNMwICVk+gIH9l4TV9qGoMwij2g0OwOsYnUuQjDnNztMqliT7x8AdhiylRKEpAWw==
X-Received: by 2002:a63:f106:: with SMTP id f6mr1227988pgi.163.1611263860562;
        Thu, 21 Jan 2021 13:17:40 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id l12sm6575702pjq.7.2021.01.21.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 13:17:39 -0800 (PST)
Date:   Thu, 21 Jan 2021 13:17:38 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Moritz Fischer <mdf@kernel.org>, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        moritzf@google.com, sudeep.holla@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ACPI/IORT: Do not blindly trust DMA masks from firmware
Message-ID: <YAnvckodi9MOTrV4@epycbox.lan>
References: <20210121191612.90387-1-mdf@kernel.org>
 <faa089d5-48e3-d51d-0d14-849e5446dbf4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa089d5-48e3-d51d-0d14-849e5446dbf4@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Robin,

On Thu, Jan 21, 2021 at 08:08:42PM +0000, Robin Murphy wrote:
> On 2021-01-21 19:16, Moritz Fischer wrote:
> > Address issue observed on real world system with suboptimal IORT table
> > where DMA masks of PCI devices would get set to 0 as result.
> > 
> > iort_dma_setup() would query the root complex' IORT entry for a DMA
> > mask, and use that over the one the device has been configured with
> > earlier.
> > 
> > Ideally we want to use the minimum mask of what the IORT contains for
> > the root complex and what the device was configured with, but never 0.
> > 
> > Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > Hi all,
> > 
> > not sure I'm doing this right, but I think the current behavior (while a
> > corner case) seems to also fail for 32 bit devices if the IORT specifies
> > 64 bit. It works on my test system now with a 32 bit device.
> 
> I suppose it could go wrong if it's an old driver that doesn't explicitly
> set its own masks and assumes they will always be 32-bit. Technically we'd
> consider that the driver's fault these days, but there's a lot of legacy
> around still.

Huh, ok :) That's news to me. On my system I had three devices running
into this, so yeah I think it's quite common.

If that's the official stance I can send patches for the drivers in
question :)

> 
> > Open to suggestions for better solutions (and maybe the
> > nc_dma_get_range() should have the same sanity check?)
> 
> Honestly the more I come back to this, the more I think we should give up
> trying to be clever and just leave the default masks alone beyond the
> initial "is anything set up at all?" sanity checks. Setting the bus limit is
> what really matters these days, and should be sufficient to encode any
> genuine restriction. There's certainly no real need to widen the default
> masks above 32 bits just because firmware suggests so, since the driver
> should definitely be calling dma_set_mask() and friends later if it's
> >32-bit capable anyway.
> 
> > Thanks,
> > Moritz
> > 
> > ---
> >   drivers/acpi/arm64/iort.c | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index d4eac6d7e9fb..c48eabf8c121 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1126,6 +1126,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
> >   	rc = (struct acpi_iort_root_complex *)node->node_data;
> > +	if (!rc->memory_address_limit) {
> > +		dev_warn(dev, "Root complex has broken memory_address_limit\n");
> 
> Probably warrants a FW_BUG in there.
> 
> > +		return -EINVAL;
> > +	}
> > +
> >   	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> >   			1ULL<<rc->memory_address_limit;
> > @@ -1172,9 +1177,9 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >   		 */
> >   		end = dmaaddr + size - 1;
> >   		mask = DMA_BIT_MASK(ilog2(end) + 1);
> > -		dev->bus_dma_limit = end;
> > -		dev->coherent_dma_mask = mask;
> > -		*dev->dma_mask = mask;
> > +		dev->bus_dma_limit = min_not_zero(dev->bus_dma_limit, end);
> 
> This doesn't need to change, since the default bus limit is 0 anyway (and
> that means "no limit").
Ok, I'll drop this.
> 
> > +		dev->coherent_dma_mask = min_not_zero(dev->coherent_dma_mask, mask);
> > +		*dev->dma_mask = min_not_zero(*dev->dma_mask, mask);

I'll keep those two?
> AFAICS the only way an empty mask could get here now is from
> nc_dma_get_range(), so I'd rather see a consistent warning there than just
> silently start working around that too.

In my case the empty mask came from the pci dev branch returning a size
of 1. (1 << 0).

I'll replace the dev_warn() with a pr_warn(FW_BUG ...) for both
{nc,rc}_dma_get_range() cases then?

> 
> Of course IORT doesn't say these fields are optional (other than the lack of
> a root complex limit in older table versions), so we're giving bad firmware
> a pass to never be fixed, ho hum...

I think if we yell loud enough (like FW_BUG) that'll get people's
attention?

Thanks for the quick reply
- Moritz
