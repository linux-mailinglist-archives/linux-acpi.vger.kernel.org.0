Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2262FB91B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 15:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403848AbhASOTP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 09:19:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2377 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391131AbhASM3q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2021 07:29:46 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKnqj5cwwz67cwg;
        Tue, 19 Jan 2021 20:23:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 13:28:40 +0100
Received: from localhost (10.47.77.36) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 12:28:39 +0000
Date:   Tue, 19 Jan 2021 12:27:59 +0000
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
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
Message-ID: <20210119122759.000048f9@Huawei.com>
In-Reply-To: <20210108145217.2254447-6-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
        <20210108145217.2254447-6-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.36]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 Jan 2021 15:52:13 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> The IOPF (I/O Page Fault) feature is now enabled independently from the
> SVA feature, because some IOPF implementations are device-specific and
> do not require IOMMU support for PCIe PRI or Arm SMMU stall.
> 
> Enable IOPF unconditionally when enabling SVA for now. In the future, if
> a device driver implementing a uacce interface doesn't need IOPF
> support, it will need to tell the uacce module, for example with a new
> flag.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Hi Jean-Philippe,

A minor suggestion inline but I'm not that bothered so either way
looks good to me.

> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/misc/uacce/uacce.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index d07af4edfcac..41ef1eb62a14 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -385,6 +385,24 @@ static void uacce_release(struct device *dev)
>  	kfree(uacce);
>  }
>  
> +static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
> +{
> +	if (!(flags & UACCE_DEV_SVA))
> +		return flags;
> +
> +	flags &= ~UACCE_DEV_SVA;
> +
> +	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF))
> +		return flags;
> +
> +	if (iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA)) {
> +		iommu_dev_disable_feature(parent, IOMMU_DEV_FEAT_IOPF);
> +		return flags;
> +	}
> +
> +	return flags | UACCE_DEV_SVA;
> +}

I'm a great fan of paired enable / disable functions.
Whilst it would be trivial, maybe it is worth introducing

uacce_disable_sva()?
Also make that do the flags check internally to make it match
up with the enable path.


> +
>  /**
>   * uacce_alloc() - alloc an accelerator
>   * @parent: pointer of uacce parent device
> @@ -404,11 +422,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>  	if (!uacce)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (flags & UACCE_DEV_SVA) {
> -		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
> -		if (ret)
> -			flags &= ~UACCE_DEV_SVA;
> -	}
> +	flags = uacce_enable_sva(parent, flags);
>  
>  	uacce->parent = parent;
>  	uacce->flags = flags;
> @@ -432,8 +446,10 @@ struct uacce_device *uacce_alloc(struct device *parent,
>  	return uacce;
>  
>  err_with_uacce:
> -	if (flags & UACCE_DEV_SVA)
> +	if (flags & UACCE_DEV_SVA) {
>  		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
> +		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> +	}
>  	kfree(uacce);
>  	return ERR_PTR(ret);
>  }
> @@ -487,8 +503,10 @@ void uacce_remove(struct uacce_device *uacce)
>  	mutex_unlock(&uacce->queues_lock);
>  
>  	/* disable sva now since no opened queues */
> -	if (uacce->flags & UACCE_DEV_SVA)
> +	if (uacce->flags & UACCE_DEV_SVA) {
>  		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
> +		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> +	}
>  
>  	if (uacce->cdev)
>  		cdev_device_del(uacce->cdev, &uacce->dev);

