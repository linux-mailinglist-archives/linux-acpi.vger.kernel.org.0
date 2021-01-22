Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86934300A7F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 19:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbhAVR7F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 12:59:05 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:51297 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbhAVRvb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 12:51:31 -0500
Received: by mail-pj1-f46.google.com with SMTP id a20so1302835pjs.1;
        Fri, 22 Jan 2021 09:51:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+6tbIaVmVydfUOxunVkBD+uE/c035INEbGofWx3LmuY=;
        b=nMgdO6SpY1bs3Es22hg5/01h/eWcidW4nlHMu0lud3swVE4eHYkUNJ8P3CttrmLYu1
         lpoB/bnN6CrNNAmESLKEZZu6/Og08wr2uasx7GUFhqnNEMPS3KwuMfu08tIiXFT3db8z
         EGk4OO5j4WWGRiBxi0LI9TZR5N3FI1eO5LPuY/5rcYPTlf/1KACP6f/NDxE+47t+YwfW
         t2xfYsh2cGq9vAPdSYlV0kohYaWSpGMy3UoP95YOIfdVaBg4mGiUToz0gOiqrLiclILt
         XkO04h/r6LxGZLGkGBt32T3SfaTajZMdo1JeIgWpn8UVulMlbj+t/tUi+76RWCJm81Qy
         e4KA==
X-Gm-Message-State: AOAM532BszS/iPXCCwEbPMJFMqEqgM/QobT3RLzjLV7b/YrfH6qf9LTB
        u1xGReBp87d4oCDSCMueKzs=
X-Google-Smtp-Source: ABdhPJwl1ImD4+FbMec5wOTo5OrxWV7FJQFgogfslczPKz1oDhsMYMekZw/oHBQS1M61wGNp9MBEJg==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr6889308pjb.211.1611337845501;
        Fri, 22 Jan 2021 09:50:45 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id j6sm9362292pfg.159.2021.01.22.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 09:50:43 -0800 (PST)
Date:   Fri, 22 Jan 2021 09:50:40 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Moritz Fischer <mdf@kernel.org>, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        moritzf@google.com, sudeep.holla@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI/IORT: Do not blindly trust DMA masks from
 firmware
Message-ID: <YAsQcLqvi0Lh8PVv@archbook>
References: <20210122012419.95010-1-mdf@kernel.org>
 <e01e2fd6-7f78-354e-374c-f93a5d1b8fd6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01e2fd6-7f78-354e-374c-f93a5d1b8fd6@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Robin,

On Fri, Jan 22, 2021 at 02:42:05PM +0000, Robin Murphy wrote:
> On 2021-01-22 01:24, Moritz Fischer wrote:
> > Address issue observed on real world system with suboptimal IORT table
> > where DMA masks of PCI devices would get set to 0 as result.
> > 
> > iort_dma_setup() would query the root complex'/named component IORT
> > entry for a DMA mask, and use that over the one the device has been
> > configured with earlier.
> > 
> > Ideally we want to use the minimum mask of what the IORT contains for
> > the root complex and what the device was configured with.
> > 
> > Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > 
> > Changes from v1:
> > - Changed warning to FW_BUG
> > - Warn for both Named Component or Root Complex
> > - Replaced min_not_zero() with min()
> > 
> > ---
> >   drivers/acpi/arm64/iort.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index d4eac6d7e9fb..2494138a6905 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1107,6 +1107,11 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
> >   	ncomp = (struct acpi_iort_named_component *)node->node_data;
> > +	if (!ncomp->memory_address_limit) {
> > +		pr_warn(FW_BUG "Named component missing memory address limit\n");
> > +		return -EINVAL;
> > +	}
> > +
> >   	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
> >   			1ULL<<ncomp->memory_address_limit;
> > @@ -1126,6 +1131,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
> >   	rc = (struct acpi_iort_root_complex *)node->node_data;
> > +	if (!rc->memory_address_limit) {
> > +		pr_warn(FW_BUG "Root complex missing memory address limit\n");
> > +		return -EINVAL;
> > +	}
> > +
> >   	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> >   			1ULL<<rc->memory_address_limit;
> > @@ -1173,8 +1183,8 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> >   		end = dmaaddr + size - 1;
> >   		mask = DMA_BIT_MASK(ilog2(end) + 1);
> >   		dev->bus_dma_limit = end;
> > -		dev->coherent_dma_mask = mask;
> > -		*dev->dma_mask = mask;
> > +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> > +		*dev->dma_mask = min(*dev->dma_mask, mask);
> 
> Oops, I got so distracted by the "not_zero" aspect in v1 that I ended up
> thinking purely about smaller-than-default masks, but of course this *does*
> matter the other way round. And it is what we've always done on the DT side,
> so at least it makes us consistent.
> 
> FWIW I've already started writing up a patch to kill off this bit entirely,
> but either way we still can't meaningfully interpret a supposed DMA limit of
> 0 bits in a table describing DMA-capable devices, so for this patch as a
> fix,
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I think there's another issue the comparisons for revision should be
against < 2 not < 1.

From what I could find DEN0049D (IORT) spec introduced the fields
(curiously the C doc seems to be missing).

DEN0049B specifies revision as '0', DEN0049C (missing?), DEN0049D
specifies new fields for memory_size_limit and both Named Component and
Root Complex nodes set revision to 2.

so I think it should be:

if (!node || node->revision < 2)
	return -ENODEV;

Only if we go past this and there is no address limit is it really a
firmware bug.
> 
> Thanks,
> Robin.
> 
> >   	}
> >   	*dma_addr = dmaaddr;
> > 

- Moritz
