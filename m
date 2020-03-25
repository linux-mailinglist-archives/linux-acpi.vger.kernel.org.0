Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5681928E4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 13:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCYMvg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 08:51:36 -0400
Received: from foss.arm.com ([217.140.110.172]:48004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgCYMvg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Mar 2020 08:51:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 495FC31B;
        Wed, 25 Mar 2020 05:51:35 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.20.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F43B3F71F;
        Wed, 25 Mar 2020 05:51:30 -0700 (PDT)
Date:   Wed, 25 Mar 2020 12:51:18 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        robin.murphy@arm.com, ard.biesheuvel@linaro.org,
        ioana.ciornei@nxp.com, diana.craciun@oss.nxp.com, maz@kernel.org,
        jon@solid-run.com, pankaj.bansal@nxp.com, makarand.pawagi@nxp.com,
        calvin.johnson@nxp.com, V.Sethi@nxp.com, cristian.sovaiala@nxp.com,
        Stuart.Yoder@arm.com, jeremy.linton@arm.com, joro@8bytes.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Message-ID: <20200325125109.GA5430@red-moon.cambridge.arm.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> The devices on this bus are not discovered by way of device tree
> but by queries to the firmware. It makes little sense to trick the
> generic of layer into thinking that these devices are of related so
> that we can get our dma configuration. Instead of doing that, add
> our custom dma configuration implementation.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 36eb25f82c8e..eafaa0e0b906 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>  static int fsl_mc_dma_configure(struct device *dev)
>  {
>  	struct device *dma_dev = dev;
> +	struct iommu_fwspec *fwspec;
> +	const struct iommu_ops *iommu_ops;
> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> +	int ret;
> +	u32 icid;
>  
>  	while (dev_is_fsl_mc(dma_dev))
>  		dma_dev = dma_dev->parent;
>  
> -	return of_dma_configure(dev, dma_dev->of_node, 0);
> +	fwspec = dev_iommu_fwspec_get(dma_dev);
> +	if (!fwspec)
> +		return -ENODEV;
> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
> +	if (!iommu_ops)
> +		return -ENODEV;
> +
> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
> +	if (ret)
> +		return ret;
> +
> +	icid = mc_dev->icid;
> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);

I see. So with this patch we would use the MC named component only to
retrieve the iommu_ops - the streamid are injected directly here
bypassing OF/IORT bindings translations altogether. Am I reading this
code correctly ?

Thanks,
Lorenzo

> +	if (ret)
> +		return ret;
> +
> +	if (!device_iommu_mapped(dev)) {
> +		ret = iommu_probe_device(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	arch_setup_dma_ops(dev, 0, *dma_dev->dma_mask + 1, iommu_ops, true);
> +
> +	return 0;
>  }
>  
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> -- 
> 2.17.1
> 
