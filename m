Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAAA301030
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 23:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbhAVWmb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 17:42:31 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:40092 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbhAVToV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 14:44:21 -0500
Received: by mail-pg1-f173.google.com with SMTP id 15so4497086pgx.7;
        Fri, 22 Jan 2021 11:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATG0GXwb6cHOMUq0Deoow7zIfUyiL9nWB+7HYnwDTXA=;
        b=TfriNOBwYDmEoIFXqwsX+2TlcTN+fXn+ThmM6BA1GQlXB8g7VakXdWMlSbPYximhtk
         RJtzlBZ/CJfjw+LSkGge9HlOEMkHJWVnTyQueutoT+HDvb+4S+/Yr/0HrY56/7GERFik
         gxlB2Zfs11KkY25AC+rXMRbtzQ9lew5l15pO6AvyAzT2OqgPrOhzW2HAjcphbxXvz2EA
         812d9i4G2SH2EoyznFClnBBZHdNeMiIsHWGi+s0n/xktYxd8nBpWMOOXapFNyDZtL7+E
         91WZ3PrRy/Rg+M4MlQ2ddptLRnt+SVniQsxgSQzgV4F0uQvxB8WLYj2kR07VUL+uw6ru
         3O8A==
X-Gm-Message-State: AOAM533YesQZ9n8wgdXOO68lhEDD9pMzbIdbqfsopq+YFRp137oKx5X/
        S665J48E9AwuBOu0u6PC2kA=
X-Google-Smtp-Source: ABdhPJxYQr1Ch6qIKOrEYXGLMhs510aFr2+YqABRUXxW3HRV5y/SFkvSXB7CqcVBI21jxE2gabFISw==
X-Received: by 2002:a62:cf02:0:b029:1a4:6899:618e with SMTP id b2-20020a62cf020000b02901a46899618emr1068870pfg.70.1611344620089;
        Fri, 22 Jan 2021 11:43:40 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id i62sm6223677pfe.84.2021.01.22.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:43:38 -0800 (PST)
Date:   Fri, 22 Jan 2021 11:43:37 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Moritz Fischer <mdf@kernel.org>, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        moritzf@google.com, sudeep.holla@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI/IORT: Do not blindly trust DMA masks from
 firmware
Message-ID: <YAsq6XE4okZbPf9Z@archbook>
References: <20210122012419.95010-1-mdf@kernel.org>
 <e01e2fd6-7f78-354e-374c-f93a5d1b8fd6@arm.com>
 <YAsQcLqvi0Lh8PVv@archbook>
 <29575ef5-a1c1-16d7-5fed-7fc34d772a7a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29575ef5-a1c1-16d7-5fed-7fc34d772a7a@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 22, 2021 at 07:17:59PM +0000, Robin Murphy wrote:
> On 2021-01-22 17:50, Moritz Fischer wrote:
> > Hi Robin,
> > 
> > On Fri, Jan 22, 2021 at 02:42:05PM +0000, Robin Murphy wrote:
> > > On 2021-01-22 01:24, Moritz Fischer wrote:
> > > > Address issue observed on real world system with suboptimal IORT table
> > > > where DMA masks of PCI devices would get set to 0 as result.
> > > > 
> > > > iort_dma_setup() would query the root complex'/named component IORT
> > > > entry for a DMA mask, and use that over the one the device has been
> > > > configured with earlier.
> > > > 
> > > > Ideally we want to use the minimum mask of what the IORT contains for
> > > > the root complex and what the device was configured with.
> > > > 
> > > > Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
> > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > ---
> > > > 
> > > > Changes from v1:
> > > > - Changed warning to FW_BUG
> > > > - Warn for both Named Component or Root Complex
> > > > - Replaced min_not_zero() with min()
> > > > 
> > > > ---
> > > >    drivers/acpi/arm64/iort.c | 14 ++++++++++++--
> > > >    1 file changed, 12 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > > index d4eac6d7e9fb..2494138a6905 100644
> > > > --- a/drivers/acpi/arm64/iort.c
> > > > +++ b/drivers/acpi/arm64/iort.c
> > > > @@ -1107,6 +1107,11 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
> > > >    	ncomp = (struct acpi_iort_named_component *)node->node_data;
> > > > +	if (!ncomp->memory_address_limit) {
> > > > +		pr_warn(FW_BUG "Named component missing memory address limit\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > >    	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
> > > >    			1ULL<<ncomp->memory_address_limit;
> > > > @@ -1126,6 +1131,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
> > > >    	rc = (struct acpi_iort_root_complex *)node->node_data;
> > > > +	if (!rc->memory_address_limit) {
> > > > +		pr_warn(FW_BUG "Root complex missing memory address limit\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > >    	*size = rc->memory_address_limit >= 64 ? U64_MAX :
> > > >    			1ULL<<rc->memory_address_limit;
> > > > @@ -1173,8 +1183,8 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
> > > >    		end = dmaaddr + size - 1;
> > > >    		mask = DMA_BIT_MASK(ilog2(end) + 1);
> > > >    		dev->bus_dma_limit = end;
> > > > -		dev->coherent_dma_mask = mask;
> > > > -		*dev->dma_mask = mask;
> > > > +		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
> > > > +		*dev->dma_mask = min(*dev->dma_mask, mask);
> > > 
> > > Oops, I got so distracted by the "not_zero" aspect in v1 that I ended up
> > > thinking purely about smaller-than-default masks, but of course this *does*
> > > matter the other way round. And it is what we've always done on the DT side,
> > > so at least it makes us consistent.
> > > 
> > > FWIW I've already started writing up a patch to kill off this bit entirely,
> > > but either way we still can't meaningfully interpret a supposed DMA limit of
> > > 0 bits in a table describing DMA-capable devices, so for this patch as a
> > > fix,
> > > 
> > > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> > 
> > I think there's another issue the comparisons for revision should be
> > against < 2 not < 1.
> > 
> >  From what I could find DEN0049D (IORT) spec introduced the fields
> > (curiously the C doc seems to be missing).
> 
> I guess it got lost in the documentation system move. FWIW I still have a
> copy of issue C, and root complex nodes are unchanged at revision 0 there.
> 
> > DEN0049B specifies revision as '0', DEN0049C (missing?), DEN0049D
> > specifies new fields for memory_size_limit and both Named Component and
> > Root Complex nodes set revision to 2.
> 
> My copy of issue D says Root Complex nodes are at revision 1, with memory
> address size limit added.
> 
> (Note that Named Component nodes did bump to rev. 1 in issue C, then to rev.
> 2 in issue D)
> 
> Issue E bumped Root Complex nodes to revision 2 with the addition of the PRI
> flag, then E.a made a mess of everything by deprecating the revision numbers
> for individual tables - we probably need to deal with *that*, since
> otherwise we'll think new tables are back at rev. 0 again, but AFAICS the
> current check is correct for anything written against the first 5 releases.

Ok, yeah, I double checked this, you're right. Then patch should be fine
as is.

Thanks!
