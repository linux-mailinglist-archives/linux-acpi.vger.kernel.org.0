Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3784340E65
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Mar 2021 20:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhCRTh1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Mar 2021 15:37:27 -0400
Received: from foss.arm.com ([217.140.110.172]:47522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhCRTg7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Mar 2021 15:36:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7F8ED1;
        Thu, 18 Mar 2021 12:36:58 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39423F70D;
        Thu, 18 Mar 2021 12:36:56 -0700 (PDT)
Subject: Re: [PATCH 2/3] ACPI: Add driver for the VIOT table
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     kevin.tian@intel.com, virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, will@kernel.org
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-3-jean-philippe@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f081b8f-98e2-2ce1-6be6-bb81aab8e153@arm.com>
Date:   Thu, 18 Mar 2021 19:36:50 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316191652.3401335-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-03-16 19:16, Jean-Philippe Brucker wrote:
> The ACPI Virtual I/O Translation Table describes topology of
> para-virtual platforms. For now it describes the relation between
> virtio-iommu and the endpoints it manages. Supporting that requires
> three steps:
> 
> (1) acpi_viot_init(): parse the VIOT table, build a list of endpoints
>      and vIOMMUs.
> 
> (2) acpi_viot_set_iommu_ops(): when the vIOMMU driver is loaded and the
>      device probed, register it to the VIOT driver. This step is required
>      because unlike similar drivers, VIOT doesn't create the vIOMMU
>      device.

Note that you're basically the same as the DT case in this regard, so 
I'd expect things to be closer to that pattern than to that of IORT.

[...]
> @@ -1506,12 +1507,17 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
>   {
>   	const struct iommu_ops *iommu;
>   	u64 dma_addr = 0, size = 0;
> +	int ret;
>   
>   	if (attr == DEV_DMA_NOT_SUPPORTED) {
>   		set_dma_ops(dev, &dma_dummy_ops);
>   		return 0;
>   	}
>   
> +	ret = acpi_viot_dma_setup(dev, attr);
> +	if (ret)
> +		return ret > 0 ? 0 : ret;

I think things could do with a fair bit of refactoring here. Ideally we 
want to process a possible _DMA method (acpi_dma_get_range()) regardless 
of which flavour of IOMMU table might be present, and the amount of 
duplication we fork into at this point is unfortunate.

> +
>   	iort_dma_setup(dev, &dma_addr, &size);

For starters I think most of that should be dragged out to this level 
here - it's really only the {rc,nc}_dma_get_range() bit that deserves to 
be the IORT-specific call.

>   	iommu = iort_iommu_configure_id(dev, input_id);

Similarly, it feels like it's only the table scan part in the middle of 
that that needs dispatching between IORT/VIOT, and its head and tail 
pulled out into a common path.

[...]
> +static const struct iommu_ops *viot_iommu_setup(struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct viot_iommu *viommu = NULL;
> +	struct viot_endpoint *ep;
> +	u32 epid;
> +	int ret;
> +
> +	/* Already translated? */
> +	if (fwspec && fwspec->ops)
> +		return NULL;
> +
> +	mutex_lock(&viommus_lock);
> +	list_for_each_entry(ep, &viot_endpoints, list) {
> +		if (viot_device_match(dev, &ep->dev_id, &epid)) {
> +			epid += ep->endpoint_id;
> +			viommu = ep->viommu;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&viommus_lock);
> +	if (!viommu)
> +		return NULL;
> +
> +	/* We're not translating ourself */
> +	if (viot_device_match(dev, &viommu->dev_id, &epid))
> +		return NULL;
> +
> +	/*
> +	 * If we found a PCI range managed by the viommu, we're the one that has
> +	 * to request ACS.
> +	 */
> +	if (dev_is_pci(dev))
> +		pci_request_acs();
> +
> +	if (!viommu->ops || WARN_ON(!viommu->dev))
> +		return ERR_PTR(-EPROBE_DEFER);

Can you create (or look up) a viommu->fwnode when initially parsing the 
VIOT to represent the IOMMU devices to wait for, such that the 
viot_device_match() lookup can resolve to that and let you fall into the 
standard iommu_ops_from_fwnode() path? That's what I mean about 
following the DT pattern - I guess it might need a bit of trickery to 
rewrite things if iommu_device_register() eventually turns up with a new 
fwnode, so I doubt we can get away without *some* kind of private 
interface between virtio-iommu and VIOT, but it would be nice for the 
common(ish) DMA paths to stay as unaware of the specifics as possible.

> +
> +	ret = iommu_fwspec_init(dev, viommu->dev->fwnode, viommu->ops);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	iommu_fwspec_add_ids(dev, &epid, 1);
> +
> +	/*
> +	 * If we have reason to believe the IOMMU driver missed the initial
> +	 * add_device callback for dev, replay it to get things in order.
> +	 */
> +	if (dev->bus && !device_iommu_mapped(dev))
> +		iommu_probe_device(dev);
> +
> +	return viommu->ops;
> +}
> +
> +/**
> + * acpi_viot_dma_setup - Configure DMA for an endpoint described in VIOT
> + * @dev: the endpoint
> + * @attr: coherency property of the endpoint
> + *
> + * Setup the DMA and IOMMU ops for an endpoint described by the VIOT table.
> + *
> + * Return:
> + * * 0 - @dev doesn't match any VIOT node
> + * * 1 - ops for @dev were successfully installed
> + * * -EPROBE_DEFER - ops for @dev aren't yet available
> + */
> +int acpi_viot_dma_setup(struct device *dev, enum dev_dma_attr attr)
> +{
> +	const struct iommu_ops *iommu_ops = viot_iommu_setup(dev);
> +
> +	if (IS_ERR_OR_NULL(iommu_ops)) {
> +		int ret = PTR_ERR(iommu_ops);
> +
> +		if (ret == -EPROBE_DEFER || ret == 0)
> +			return ret;
> +		dev_err(dev, "error %d while setting up virt IOMMU\n", ret);
> +		return 0;
> +	}
> +
> +#ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> +	arch_setup_dma_ops(dev, 0, ~0ULL, iommu_ops, attr == DEV_DMA_COHERENT);
> +#else
> +	iommu_setup_dma_ops(dev, 0, ~0ULL);
> +#endif

Duplicating all of this feels particularly wrong... :(

Robin.

> +	return 1;
> +}
