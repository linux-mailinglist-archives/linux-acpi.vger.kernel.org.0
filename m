Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7570ACF7
	for <lists+linux-acpi@lfdr.de>; Sun, 21 May 2023 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjEUIX0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 04:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjEUIUd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 04:20:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D97D2
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684657219; x=1716193219;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4tC0SwKYETAOpGInrpsKtb0LbHOZuupDkjqNb8uXDAs=;
  b=cg9CloVYfcAMMDhQHz/1CUJh/esgy9C1mvNMG1aaFt+UYZafi0FOX8gJ
   NGsp/mSexw2wUhctrPnLpS3XdNNkmDnyXwgsKMwETc2B2emJCXZikuvHM
   Mb5ZRpxUyA5AVLqOdS9TulnNVALsQKknQ6gKFdGIDAJ+WnRuFs9GwDOGq
   m1Pe49I3qdGkjhZEjAMlD5yu3b2lRIBBkN6lyWSkUoysCvrTb2Opyl0JM
   exBh4RF+WEQBEbfbiDlDJU9ntZhDsvQ8d7jp+8WflzFwbulm0/oJ+eJGF
   MAqw84kbkMB7CD0UHqKMm98gGUCULOnjexk0T9pGM9Vt+m4bLtY+DSY5f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="350189311"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="350189311"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 01:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="792903662"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="792903662"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2023 01:20:16 -0700
Message-ID: <6676d850-f633-bacd-445b-44cf045a699c@linux.intel.com>
Date:   Sun, 21 May 2023 16:19:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 03/10] iommu: Inline iommu_group_get_for_dev() into
 __iommu_probe_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <3-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> This is the only caller, and it doesn't need the generality of the
> function. We already know there is no iommu_group, so it is simply two
> function calls.
> 
> Moving it here allows the following patches to split the logic in these
> functions.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 50 ++++++++-----------------------------------
>   1 file changed, 9 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35dadcc9999f8b..6177e01ced67ab 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -127,7 +127,6 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>   				      int target_type);
>   static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>   					       struct device *dev);
> -static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>   				      const char *buf, size_t count);
>   
> @@ -379,12 +378,18 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	if (ops->is_attach_deferred)
>   		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
>   
> -	group = iommu_group_get_for_dev(dev);
> +	group = ops->device_group(dev);
> +	if (WARN_ON_ONCE(group == NULL))
> +		group = ERR_PTR(-EINVAL);
>   	if (IS_ERR(group)) {
>   		ret = PTR_ERR(group);
>   		goto out_release;
>   	}
>   
> +	ret = iommu_group_add_device(group, dev);
> +	if (ret)
> +		goto err_put_group;
> +
>   	mutex_lock(&group->mutex);
>   	if (group_list && !group->default_domain && list_empty(&group->entry))
>   		list_add_tail(&group->entry, group_list);
> @@ -396,6 +401,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   	return 0;
>   
> +err_put_group:

nit: perhaps out_put_group?

> +	iommu_group_put(group);
>   out_release:
>   	if (ops->release_device)
>   		ops->release_device(dev);
> @@ -1670,45 +1677,6 @@ iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>   	return dom;
>   }

Others look good to me:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
