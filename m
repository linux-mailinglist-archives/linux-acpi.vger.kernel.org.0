Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341EC2FDB26
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 21:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbhATUs1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 15:48:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:60530 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbhATUsU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Jan 2021 15:48:20 -0500
IronPort-SDR: 1rU1P64yCiKAZuw5iv+Lv31L30Myu6ihxmYy8K/abKr9cP4Hg1ggVa0m2emtK2y4Di7lsy/caL
 1EYmG3b23nDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158950365"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="158950365"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 12:47:28 -0800
IronPort-SDR: L/wl4gvZ7TdUoU8zWusXveudB72pqSFzK8Nfs/i5YpgujXfQRwJYLNxC7jdT2Q2FyyqoJIO0g8
 +oA8cmMfCEeA==
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="366509663"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.254.121.244]) ([10.254.121.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 12:47:26 -0800
Subject: Re: [PATCH v9 05/10] uacce: Enable IOMMU_DEV_FEAT_IOPF
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
Cc:     vivek.gautam@arm.com, guohanjun@huawei.com,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-acpi@vger.kernel.org, zhangfei.gao@linaro.org,
        lenb@kernel.org, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, eric.auger@redhat.com,
        vdumpa@nvidia.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rjw@rjwysocki.net, shameerali.kolothum.thodi@huawei.com,
        iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
        robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org,
        baolu.lu@linux.intel.com, Dan Williams <dan.j.williams@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-6-jean-philippe@linaro.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <e14f47bd-1b0c-1905-3bb7-62e1c5b096c7@intel.com>
Date:   Wed, 20 Jan 2021 13:47:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210108145217.2254447-6-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 1/8/2021 7:52 AM, Jean-Philippe Brucker wrote:
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
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>   drivers/misc/uacce/uacce.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index d07af4edfcac..41ef1eb62a14 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -385,6 +385,24 @@ static void uacce_release(struct device *dev)
>   	kfree(uacce);
>   }
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

Sorry to jump in a bit late on this and not specifically towards the 
intent of this patch. But I'd like to start a discussion on if we want 
to push the iommu dev feature enabling to the device driver itself 
rather than having UACCE control this? Maybe allow the device driver to 
manage the feature bits and UACCE only verify that they are enabled?

 1. The device driver knows what platform it's on and what specific
    feature bits its devices supports. Maybe in the future if there are
    feature bits that's needed on one platform and not on another?
 2. This allows the possibility of multiple uacce device registered to 1
    pci dev, which for a device with asymmetric queues (Intel DSA/idxd
    driver) that is desirable feature. The current setup forces a single
    uacce device per pdev. If additional uacce devs are registered, the
    first removal of uacce device will disable the feature bit for the
    rest of the registered devices. With uacce managing the feature bit,
    it would need to add device context to the parent pdev and ref
    counting. It may be cleaner to just allow device driver to manage
    the feature bits and the driver should have all the information on
    when the feature needs to be turned on and off.

- DaveJ


> +
> +	return flags | UACCE_DEV_SVA;
> +}
> +
>   /**
>    * uacce_alloc() - alloc an accelerator
>    * @parent: pointer of uacce parent device
> @@ -404,11 +422,7 @@ struct uacce_device *uacce_alloc(struct device *parent,
>   	if (!uacce)
>   		return ERR_PTR(-ENOMEM);
>   
> -	if (flags & UACCE_DEV_SVA) {
> -		ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_SVA);
> -		if (ret)
> -			flags &= ~UACCE_DEV_SVA;
> -	}
> +	flags = uacce_enable_sva(parent, flags);
>   
>   	uacce->parent = parent;
>   	uacce->flags = flags;
> @@ -432,8 +446,10 @@ struct uacce_device *uacce_alloc(struct device *parent,
>   	return uacce;
>   
>   err_with_uacce:
> -	if (flags & UACCE_DEV_SVA)
> +	if (flags & UACCE_DEV_SVA) {
>   		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
> +		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> +	}
>   	kfree(uacce);
>   	return ERR_PTR(ret);
>   }
> @@ -487,8 +503,10 @@ void uacce_remove(struct uacce_device *uacce)
>   	mutex_unlock(&uacce->queues_lock);
>   
>   	/* disable sva now since no opened queues */
> -	if (uacce->flags & UACCE_DEV_SVA)
> +	if (uacce->flags & UACCE_DEV_SVA) {
>   		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_SVA);
> +		iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
> +	}
>   
>   	if (uacce->cdev)
>   		cdev_device_del(uacce->cdev, &uacce->dev);
