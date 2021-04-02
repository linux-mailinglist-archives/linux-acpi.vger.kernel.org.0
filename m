Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9D352492
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Apr 2021 02:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhDBApt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 20:45:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15465 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhDBAps (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 20:45:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBLrr1dsLzwR3S;
        Fri,  2 Apr 2021 08:43:40 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 08:45:39 +0800
Subject: Re: [PATCH v14 09/10] ACPI/IORT: Enable stall support for platform
 devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <Jonathan.Cameron@huawei.com>,
        <eric.auger@redhat.com>, <iommu@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <jacob.jun.pan@linux.intel.com>, <kevin.tian@intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>,
        <zhukeqian1@huawei.com>, <wangzhou1@hisilicon.com>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-10-jean-philippe@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <15220cd4-8260-316b-6133-fec13a6604f8@huawei.com>
Date:   Fri, 2 Apr 2021 08:45:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210401154718.307519-10-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/4/1 23:47, Jean-Philippe Brucker wrote:
> Copy the "Stall supported" bit, that tells whether a named component
> supports stall, into the dma-can-stall device property.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/acpi/arm64/iort.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 3912a1f6058e..0828f70cb782 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -968,13 +968,15 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>   static void iort_named_component_init(struct device *dev,
>   				      struct acpi_iort_node *node)
>   {
> -	struct property_entry props[2] = {};
> +	struct property_entry props[3] = {};
>   	struct acpi_iort_named_component *nc;
>   
>   	nc = (struct acpi_iort_named_component *)node->node_data;
>   	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
>   				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
>   						nc->node_flags));
> +	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
> +		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
>   
>   	if (device_add_properties(dev, props))
>   		dev_warn(dev, "Could not add device properties\n");

Acked-by: Hanjun Guo <guohanjun@huawei.com>
