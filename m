Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD32B3AC927
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 12:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhFRKws (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhFRKwr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 06:52:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2EC061574
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 03:50:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d7so8124494edx.0
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gqS2coF+gzzhxK8JdJrBsn/rp6+MnCzkmwD0939wTww=;
        b=v3Z/or0+7TlFehwd12i21NCIgEp+gh++voW/VIymTVtCQXMzQPvX/oBn0X2zo1xPR3
         KYQgE7FqiiWtiTUV6UUy5IulrfCwlajDLxWmG0ZJiFENdHhgrCjrnuuzIxc+V8YXIvnY
         pCtstbRSLOP/Q8jiqnCqY5PpkaPFLIt1BUODWANOsfuZnhXS7OPVGux5kJgw1mQkUoDi
         QIXJFcMJInFoRgQ3rF0aQ6bRrB1o+zhbn4WWPITxYMutZ4hAYOn0OgEiuYyuYMsawbdT
         VSpigMs9jVQPRW+PksLyNwzH8mNxk1lDYzlF5KJAd51X/ZOLJZaP9AEh7l6Hj7hzCPDa
         umBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gqS2coF+gzzhxK8JdJrBsn/rp6+MnCzkmwD0939wTww=;
        b=YSc++7rdFrhuBkUCYP5iIyLzGI3v/5FKt0NhF5p9Gc3mm2UycXMssvi4Inc1CjK0o8
         i4rEMCK/6LOvKBHsjyMX4AVdYksDnKWwpcmr45xuZdrB2RIRlhew5ySwJlBEnRHVTYRS
         ARR7eef3SWmWvnD2EjqA+rcvZoOUQi4cKCpRo/FyyT6El2MvIlbp21R0AUJdtbsm0LHU
         tspslHij4VK8iIcHpApvx+8TQzf37wKVNpBNUrkeAv2UwO09DMffpJu5kPxD3VSuNeA0
         BYWq3S+G+6obP/ExmF8DiSH5HQCGnSvuHiOxN6DTRxrIZe6FiBIwN+mEHarl043Zf+aR
         yS0w==
X-Gm-Message-State: AOAM5336LTHgWFEv1LF+rAAZd82B7sAnJaNNocIbrX/lJ53tbkd0dyWv
        DXq+8YNgJXE0L3jwYF2fpGHJiA==
X-Google-Smtp-Source: ABdhPJwkwm0gLmvdkXKWZF4fjbq4g0GvgTenhMIDaNXRpOJoIOA8Ok+A/PIFx3v90WjMUVBRLplXvg==
X-Received: by 2002:a05:6402:42cb:: with SMTP id i11mr4009322edc.242.1624013436164;
        Fri, 18 Jun 2021 03:50:36 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id m17sm863059ejg.96.2021.06.18.03.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 03:50:35 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:50:15 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, catalin.marinas@arm.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v4 5/6] iommu/dma: Simplify calls to iommu_setup_dma_ops()
Message-ID: <YMx6Z8aWBOrFiEcV@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-6-jean-philippe@linaro.org>
 <6ce5fecb-fc81-5bf1-3577-6a09437b243e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce5fecb-fc81-5bf1-3577-6a09437b243e@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 06:02:39PM +0100, Robin Murphy wrote:
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index c62e19bed302..175f8eaeb5b3 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -1322,7 +1322,9 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
> >   	if (domain->type == IOMMU_DOMAIN_DMA) {
> >   		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
> >   			goto out_err;
> > -		dev->dma_ops = &iommu_dma_ops;
> > +		set_dma_ops(dev, &iommu_dma_ops);
> > +	} else {
> > +		set_dma_ops(dev, NULL);
> 
> I'm not keen on moving this here, since iommu-dma only knows that its own
> ops are right for devices it *is* managing; it can't assume any particular
> ops are appropriate for devices it isn't. The idea here is that
> arch_setup_dma_ops() may have already set the appropriate ops for the
> non-IOMMU case, so if the default domain type is passthrough then we leave
> those in place.
> 
> For example, I do still plan to revisit my conversion of arch/arm someday,
> at which point I'd have to undo this for that reason.

Makes sense, I'll remove this bit.

> Simplifying the base and size arguments is of course fine, but TBH I'd say
> rip the whole bloody lot out of the arch_setup_dma_ops() flow now. It's a
> considerable faff passing them around for nothing but a tenuous sanity check
> in iommu_dma_init_domain(), and now that dev->dma_range_map is a common
> thing we should expect that to give us any relevant limitations if we even
> still care.

So I started working on this but it gets too bulky for a preparatory
patch. Dropping the parameters from arch_setup_dma_ops() seems especially
complicated because arm32 does need the size parameter for IOMMU mappings
and that value falls back to the bus DMA mask or U32_MAX in the absence of
dma-ranges. I could try to dig into this for a separate series.

Even only dropping the parameters from iommu_setup_dma_ops() isn't
completely trivial (8 files changed, 55 insertions(+), 36 deletions(-)
because we still need the lower IOVA limit from dma_range_map), so I'd
rather send it separately and have it sit in -next for a while.

Thanks,
Jean

> 
> That said, those are all things which can be fixed up later if the series is
> otherwise ready to go and there's still a chance of landing it for 5.14. If
> you do have any other reason to respin, then I think the x86 probe_finalize
> functions simply want an unconditional set_dma_ops(dev, NULL) before the
> iommu_setup_dma_ops() call.
> 
> Cheers,
> Robin.
> 
> >   	}
> >   	return;
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 85f18342603c..8d866940692a 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5165,15 +5165,7 @@ static void intel_iommu_release_device(struct device *dev)
> >   static void intel_iommu_probe_finalize(struct device *dev)
> >   {
> > -	dma_addr_t base = IOVA_START_PFN << VTD_PAGE_SHIFT;
> > -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> > -	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > -
> > -	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> > -		iommu_setup_dma_ops(dev, base,
> > -				    __DOMAIN_MAX_ADDR(dmar_domain->gaw));
> > -	else
> > -		set_dma_ops(dev, NULL);
> > +	iommu_setup_dma_ops(dev, 0, U64_MAX);
> >   }
> >   static void intel_iommu_get_resv_regions(struct device *device,
> > 
