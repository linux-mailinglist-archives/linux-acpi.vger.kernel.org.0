Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD53557C8
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhDFP3U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 11:29:20 -0400
Received: from foss.arm.com ([217.140.110.172]:44650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhDFP3U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 11:29:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F045E1FB;
        Tue,  6 Apr 2021 08:29:11 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6EF3F792;
        Tue,  6 Apr 2021 08:29:08 -0700 (PDT)
Date:   Tue, 6 Apr 2021 16:29:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v14 09/10] ACPI/IORT: Enable stall support for platform
 devices
Message-ID: <20210406152903.GA28301@lpieralisi>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-10-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401154718.307519-10-jean-philippe@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 01, 2021 at 05:47:18PM +0200, Jean-Philippe Brucker wrote:
> Copy the "Stall supported" bit, that tells whether a named component
> supports stall, into the dma-can-stall device property.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/acpi/arm64/iort.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e..0828f70cb782 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -968,13 +968,15 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>  static void iort_named_component_init(struct device *dev,
>  				      struct acpi_iort_node *node)
>  {
> -	struct property_entry props[2] = {};
> +	struct property_entry props[3] = {};
>  	struct acpi_iort_named_component *nc;
>  
>  	nc = (struct acpi_iort_named_component *)node->node_data;
>  	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
>  				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
>  						nc->node_flags));
> +	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
> +		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
>  
>  	if (device_add_properties(dev, props))
>  		dev_warn(dev, "Could not add device properties\n");
> -- 
> 2.31.1
> 
