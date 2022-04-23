Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128BA50C656
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 04:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiDWCHz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Apr 2022 22:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiDWCHy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Apr 2022 22:07:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50613F22
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 19:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650679498; x=1682215498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SgvVuK7l6aZvlPJGCsW/d8rxkK2pzgLzH+13/+UoEGw=;
  b=RqM5FjnhMWZh/7bGCLpdDXg7Yjz+DxPVqEwGfrjgpoUbQz2t5a0R3OZM
   Xh14t84f6CXmSUj6Q46oPGZDbTXOgSQQfNR3o2GPgVUgqwph1VKWJDRGV
   wzxA30v24g0EHcYyfTolAgCvznnGqklraqepRXwSC7UpdmN4OzUA3P+mm
   7UYFTLuTHcFkK7j/NHFd7gOL/Q/jrwNpZ/cEJiWMD/piDneC3E7b+gJc9
   Mbt1a2sJFND8TKQ4WDVzpgeT8mTLbzI1cx/+FZBPNHrUip9J3RebTmfvU
   n5OQEZpIlcudBYftKnEqWzrXVtphZI1ftKRJCp5gSLJbwaWpKDSW6dfnP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="351283321"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="351283321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 19:04:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="578208051"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217]) ([10.255.31.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 19:04:54 -0700
Message-ID: <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
Date:   Sat, 23 Apr 2022 10:04:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Content-Language: en-US
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
        steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
        Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/4/23 00:28, Shameer Kolothum via iommu wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2c45b85b9fc..ffcfa684e80c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2597,16 +2597,22 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>    * @list: reserved region list for device
>    *
>    * IOMMU drivers can use this to implement their .put_resv_regions() callback
> - * for simple reservations. Memory allocated for each reserved region will be
> - * freed. If an IOMMU driver allocates additional resources per region, it is
> - * going to have to implement a custom callback.
> + * for simple reservations. If a per region callback is provided that will be
> + * used to free all memory allocations associated with the reserved region or
> + * else just free up the memory for the regions. If an IOMMU driver allocates
> + * additional resources per region, it is going to have to implement a custom
> + * callback.
>    */
>   void generic_iommu_put_resv_regions(struct device *dev, struct list_head *list)
>   {
>   	struct iommu_resv_region *entry, *next;
>   
> -	list_for_each_entry_safe(entry, next, list, list)
> -		kfree(entry);
> +	list_for_each_entry_safe(entry, next, list, list) {
> +		if (entry->free)
> +			entry->free(dev, entry);
> +		else
> +			kfree(entry);
> +	}
>   }
>   EXPORT_SYMBOL(generic_iommu_put_resv_regions);

The generic_iommu_put_resv_regions() itself is a callback. Why bothering
adding another callback from the same iommu driver in it? Or, you are
going to remove the put_resv_regions from the iommu ops?

Best regards,
baolu
