Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9002FF46F
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 20:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbhAUT3I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 14:29:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2397 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbhAUTSs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 14:18:48 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMBRF3rJgz67Yc3;
        Fri, 22 Jan 2021 02:55:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 19:58:32 +0100
Received: from localhost (10.47.68.198) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 21 Jan
 2021 18:58:31 +0000
Date:   Thu, 21 Jan 2021 18:57:50 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <jacob.jun.pan@linux.intel.com>, <kevin.tian@intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>
Subject: Re: [PATCH v10 09/10] ACPI/IORT: Enable stall support for platform
 devices
Message-ID: <20210121185750.000006d8@Huawei.com>
In-Reply-To: <20210121123623.2060416-10-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
        <20210121123623.2060416-10-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.68.198]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 21 Jan 2021 13:36:23 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Copy the "Stall supported" bit, that tells whether a named component
> supports stall, into the dma-can-stall device property.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

FWIW given how simple this is :
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/arm64/iort.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index c9a8bbb74b09..42820d7eb869 100644
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

