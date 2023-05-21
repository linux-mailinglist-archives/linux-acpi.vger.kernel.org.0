Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABB70AD9E
	for <lists+linux-acpi@lfdr.de>; Sun, 21 May 2023 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEULgX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjEULgT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 07:36:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C669107
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 04:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684668741; x=1716204741;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H6xD/kT2DjThbjaCMtS6oZnjUoDogpfQPzsk+0v/FCg=;
  b=CXrGaHYU6FacgreI/+9g71HGptuRTLGMpRkIMK3KP/NhOFSM7CNpT10H
   cGmNwXZWCehPa6cgCsLIuWSUb+PqhORhzoy5LHjUr/nyPeWS6F0iCGzgD
   I2A+PYxuhCfUHmLTBRsevdqTt2crIy3Of2atRY1ifYWfgHSFxHKzjr+sk
   h2yu20s/EwsGYJLGrApdmjqls856G7dbO3j5K381PnZtgHgga5l8zl+dS
   poclDeF7TBQyd49k1xw0PEq4MkMnkQ9F3SxJBWonJsKndBhHFq3n6dfCS
   kYrH1qZrBy0ybqHAFxdeSUk0sa/2Q7TI832aEgJTA1o5XKl/VHs7cJtdK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="439048222"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="439048222"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 04:32:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="949708586"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="949708586"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 21 May 2023 04:32:17 -0700
Message-ID: <5bcb5f03-77c9-116e-c436-9d0af21fa82a@linux.intel.com>
Date:   Sun, 21 May 2023 19:31:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 05/10] iommu: Add iommu_init/deinit_device() paired
 functions
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <5-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I revisited this patch. And I still have some questions.

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> -/*
> - * Remove the iommu_group from the struct device. The attached group must be put
> - * by the caller after releaseing the group->mutex.
> - */
> +/* Remove the iommu_group from the struct device. */
>   static void __iommu_group_remove_device(struct device *dev)
>   {
>   	struct iommu_group *group = dev->iommu_group;
>   	struct group_device *device;
>   
> +	mutex_lock(&group->mutex);
>   	lockdep_assert_held(&group->mutex);

By moving mutex_lock/unlock into this helper, above
lockdep_assert_held() is unnecessary.

>   	for_each_group_device(group, device) {
>   		if (device->dev != dev)
> @@ -510,44 +564,30 @@ static void __iommu_group_remove_device(struct device *dev)
>   
>   		list_del(&device->list);
>   		__iommu_group_free_device(group, device);
> -		/* Caller must put iommu_group */
> -		return;
> +		if (dev->iommu && dev->iommu->iommu_dev)
> +			iommu_deinit_device(dev);
> +		else
> +			dev->iommu_group = NULL;
> +		goto out;
>   	}
>   	WARN(true, "Corrupted iommu_group device_list");
> +out:
> +	mutex_unlock(&group->mutex);
> +
> +	/* Pairs with the get in iommu_group_add_device() */
> +	iommu_group_put(group);

The group->devices_kobj was increased on the probe device path twice:

- iommu_init_device() - allocate the group
- iommu_group_add_device() - add device to the group

But, on the release path, it seems that group->devices_kobj is only
decreased once.

Did I overlook anything? Otherwise, the group will never be released,
right?

>   }
>   
>   static void iommu_release_device(struct device *dev)
>   {
>   	struct iommu_group *group = dev->iommu_group;
> -	const struct iommu_ops *ops;
>   
>   	if (!dev->iommu || !group)
>   		return;
>   
>   	iommu_device_unlink(dev->iommu->iommu_dev, dev);
>   
> -	mutex_lock(&group->mutex);
>   	__iommu_group_remove_device(dev);
> -
> -	/*
> -	 * release_device() must stop using any attached domain on the device.
> -	 * If there are still other devices in the group they are not effected
> -	 * by this callback.
> -	 *
> -	 * The IOMMU driver must set the device to either an identity or
> -	 * blocking translation and stop using any domain pointer, as it is
> -	 * going to be freed.
> -	 */
> -	ops = dev_iommu_ops(dev);
> -	if (ops->release_device)
> -		ops->release_device(dev);
> -	mutex_unlock(&group->mutex);
> -
> -	/* Pairs with the get in iommu_group_add_device() */
> -	iommu_group_put(group);
> -
> -	module_put(ops->owner);
> -	dev_iommu_free(dev);
>   }

Best regards,
baolu
