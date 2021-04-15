Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA1360BD6
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Apr 2021 16:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhDOOcq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Apr 2021 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhDOOcp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Apr 2021 10:32:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F46C061756
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 07:32:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id x12so16420890ejc.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Apr 2021 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L82sLuZY0ugbSU18HFCt4zSNof75oOUHwMqo8db7PQo=;
        b=XC47iwRnhn5XxvNoHrSMRTYvMmyylMQea6n3cWehQolID7mQODwsyWFXqzyKtpD4cs
         y8lOrmekf/VJB7hm75G9IUitAhmx4d+XZd+tjHGu3aWmW+aDmt4abDn+Ynv/ewsMjD7A
         tB0toxYzfUjG+MkdueLYPSPI/1KP93N1NvBZrUlvpN5zAT23UL15VsLC7gUs3VSdkeGC
         ytoBapMgadlW/VJrxUHk3dQInzWu4OnHiXIZR9z98djB2162qBKMTn2JtUAfdO+7x8wF
         DNzNM51J/DAqBEYV3l6a7zY+vpSzDa8a1ysLpVwehMew50NF6/0lqnr/LH1SzT/P5/2l
         AkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L82sLuZY0ugbSU18HFCt4zSNof75oOUHwMqo8db7PQo=;
        b=UMEwQqxsis5F4zvZYZSyUeu35GdX8+oS2PozB3wKG3PR1hw3EQsYVGMZZv8M/cTTXJ
         auCmkx3ULIJ9m7TnntSBlpr+a5SQNt0Sd1v9si3uNZviBqsojs5O0sbrZGveeW9kU0PX
         7m44X6Phmllsr8xrhnlDmcd7f/1TwXr0PnmuxMmbowUQFjhWbm3qYj3MHqyAYtemc5Cm
         0363DtoJebBTU7y7yt37dcpVM6BbvID6o3YnyOA6JGYgZrOOoCaJVvhflWlTvyqDToCE
         ufbx5ClDuUwgUlfAJKyeJRN14Ee3dW+AXqzlRfqGaN+mTk0J8rVUAdzGwLzHB+tIADzI
         1Rfg==
X-Gm-Message-State: AOAM533iao7e39xQCVkd5NRHC1n8AuEM9DLwafb9rFrliYJ1ZKBjWvrx
        nP8x5twpmWhmdmmZpGjNjjn98w==
X-Google-Smtp-Source: ABdhPJz9xJvjMDtMrGsFu9juT6y5sozB8e2gd0vOrar2nkBQBIR6iW9LlDQfSnkGDtNTNQcx16PR0g==
X-Received: by 2002:a17:906:32d1:: with SMTP id k17mr3752201ejk.94.1618497139334;
        Thu, 15 Apr 2021 07:32:19 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id o17sm1975482edt.92.2021.04.15.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:32:18 -0700 (PDT)
Date:   Thu, 15 Apr 2021 16:31:59 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, kevin.tian@intel.com,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, will@kernel.org
Subject: Re: [PATCH 2/3] ACPI: Add driver for the VIOT table
Message-ID: <YHhOX6yZi1bxifDp@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-3-jean-philippe@linaro.org>
 <2f081b8f-98e2-2ce1-6be6-bb81aab8e153@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f081b8f-98e2-2ce1-6be6-bb81aab8e153@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 18, 2021 at 07:36:50PM +0000, Robin Murphy wrote:
> On 2021-03-16 19:16, Jean-Philippe Brucker wrote:
> > The ACPI Virtual I/O Translation Table describes topology of
> > para-virtual platforms. For now it describes the relation between
> > virtio-iommu and the endpoints it manages. Supporting that requires
> > three steps:
> > 
> > (1) acpi_viot_init(): parse the VIOT table, build a list of endpoints
> >      and vIOMMUs.
> > 
> > (2) acpi_viot_set_iommu_ops(): when the vIOMMU driver is loaded and the
> >      device probed, register it to the VIOT driver. This step is required
> >      because unlike similar drivers, VIOT doesn't create the vIOMMU
> >      device.
> 
> Note that you're basically the same as the DT case in this regard, so I'd
> expect things to be closer to that pattern than to that of IORT.
> 
> [...]
> > @@ -1506,12 +1507,17 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> >   {
> >   	const struct iommu_ops *iommu;
> >   	u64 dma_addr = 0, size = 0;
> > +	int ret;
> >   	if (attr == DEV_DMA_NOT_SUPPORTED) {
> >   		set_dma_ops(dev, &dma_dummy_ops);
> >   		return 0;
> >   	}
> > +	ret = acpi_viot_dma_setup(dev, attr);
> > +	if (ret)
> > +		return ret > 0 ? 0 : ret;
> 
> I think things could do with a fair bit of refactoring here. Ideally we want
> to process a possible _DMA method (acpi_dma_get_range()) regardless of which
> flavour of IOMMU table might be present, and the amount of duplication we
> fork into at this point is unfortunate.
> 
> > +
> >   	iort_dma_setup(dev, &dma_addr, &size);
> 
> For starters I think most of that should be dragged out to this level here -
> it's really only the {rc,nc}_dma_get_range() bit that deserves to be the
> IORT-specific call.

Makes sense, though I'll move it to drivers/acpi/arm64/dma.c instead of
here, because it has only ever run on CONFIG_ARM64. I don't want to
accidentally break some x86 platform with an invalid _DMA method (same
reason 7ad426398082 and 18b709beb503 kept this code in IORT)

> 
> >   	iommu = iort_iommu_configure_id(dev, input_id);
> 
> Similarly, it feels like it's only the table scan part in the middle of that
> that needs dispatching between IORT/VIOT, and its head and tail pulled out
> into a common path.

Agreed

> 
> [...]
> > +static const struct iommu_ops *viot_iommu_setup(struct device *dev)
> > +{
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct viot_iommu *viommu = NULL;
> > +	struct viot_endpoint *ep;
> > +	u32 epid;
> > +	int ret;
> > +
> > +	/* Already translated? */
> > +	if (fwspec && fwspec->ops)
> > +		return NULL;
> > +
> > +	mutex_lock(&viommus_lock);
> > +	list_for_each_entry(ep, &viot_endpoints, list) {
> > +		if (viot_device_match(dev, &ep->dev_id, &epid)) {
> > +			epid += ep->endpoint_id;
> > +			viommu = ep->viommu;
> > +			break;
> > +		}
> > +	}
> > +	mutex_unlock(&viommus_lock);
> > +	if (!viommu)
> > +		return NULL;
> > +
> > +	/* We're not translating ourself */
> > +	if (viot_device_match(dev, &viommu->dev_id, &epid))
> > +		return NULL;
> > +
> > +	/*
> > +	 * If we found a PCI range managed by the viommu, we're the one that has
> > +	 * to request ACS.
> > +	 */
> > +	if (dev_is_pci(dev))
> > +		pci_request_acs();
> > +
> > +	if (!viommu->ops || WARN_ON(!viommu->dev))
> > +		return ERR_PTR(-EPROBE_DEFER);
> 
> Can you create (or look up) a viommu->fwnode when initially parsing the VIOT
> to represent the IOMMU devices to wait for, such that the
> viot_device_match() lookup can resolve to that and let you fall into the
> standard iommu_ops_from_fwnode() path? That's what I mean about following
> the DT pattern - I guess it might need a bit of trickery to rewrite things
> if iommu_device_register() eventually turns up with a new fwnode, so I doubt
> we can get away without *some* kind of private interface between
> virtio-iommu and VIOT, but it would be nice for the common(ish) DMA paths to
> stay as unaware of the specifics as possible.

Yes I can reuse iommu_ops_from_fwnode(). Turns out it's really easy: if we
move the VIOT initialization after acpi_scan_init(), we can use
pci_get_domain_bus_and_slot() directly and create missing fwnodes. That
gets rid of any need for a private interface between virtio-iommu and
VIOT.

> 
> > +
> > +	ret = iommu_fwspec_init(dev, viommu->dev->fwnode, viommu->ops);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	iommu_fwspec_add_ids(dev, &epid, 1);
> > +
> > +	/*
> > +	 * If we have reason to believe the IOMMU driver missed the initial
> > +	 * add_device callback for dev, replay it to get things in order.
> > +	 */
> > +	if (dev->bus && !device_iommu_mapped(dev))
> > +		iommu_probe_device(dev);
> > +
> > +	return viommu->ops;
> > +}
> > +
> > +/**
> > + * acpi_viot_dma_setup - Configure DMA for an endpoint described in VIOT
> > + * @dev: the endpoint
> > + * @attr: coherency property of the endpoint
> > + *
> > + * Setup the DMA and IOMMU ops for an endpoint described by the VIOT table.
> > + *
> > + * Return:
> > + * * 0 - @dev doesn't match any VIOT node
> > + * * 1 - ops for @dev were successfully installed
> > + * * -EPROBE_DEFER - ops for @dev aren't yet available
> > + */
> > +int acpi_viot_dma_setup(struct device *dev, enum dev_dma_attr attr)
> > +{
> > +	const struct iommu_ops *iommu_ops = viot_iommu_setup(dev);
> > +
> > +	if (IS_ERR_OR_NULL(iommu_ops)) {
> > +		int ret = PTR_ERR(iommu_ops);
> > +
> > +		if (ret == -EPROBE_DEFER || ret == 0)
> > +			return ret;
> > +		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
> > +		return 0;
> > +	}
> > +
> > +#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> > +	arch_setup_dma_ops(dev, 0, ~0ULL, iommu_ops, attr == DEV_DMA_COHERENT);
> > +#else
> > +	iommu_setup_dma_ops(dev, 0, ~0ULL);
> > +#endif
> 
> Duplicating all of this feels particularly wrong... :(

Right, I still don't have a good solution for this last part. Ideally I'd
implement arch_setup_dma_ops() on x86 but virtio-iommu alone isn't enough
justification and changing DMAR and IVRS to use it is too much work. For
the next version I added a probe_finalize() method in virtio-iommu that
does the same as Vt-d and AMD IOMMU on x86. Hopefully the only wart in the
series.

Thanks,
Jean

