Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C9E6E8916
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDTEZY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 00:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjDTEZX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 00:25:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7274220
        for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2023 21:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681964720; x=1713500720;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uGkJDuCA5roZl+Gwls4r+YKtHGHUCchxEOme/jljAmg=;
  b=fwuQWWg1JB8O9tq5xoYD8IHB+nMCBcLUNK9T3kmMbL6KvWuugyXNp4sv
   RMiWSaMTxuVouGW9VRe2aVym7ZA92Kq7XQZYQrCRSE0ZZUEI9WfiH1o+T
   z+aYMxVeU3gnnZgIgYk5HFZfjVExF219ejp6W2RwSKuozTszXWMAuNXKt
   3PRhLHN7/VCLXpSvRulY/+B8lY8Yqzp0b48SPcru/NmBg75IPOmnxX1+8
   eOtOa2T8zsz2VaHfKwvLov5Lnv5Qr2Tjc7FDXiiCjWFHIx4TVrTaS5+ds
   wuE9LSd3t34MFwBiDruSSDJqocQzEKJP9huhMCNwYvW48u5c/Y1uqhykX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="347489829"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="347489829"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 21:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="760994039"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="760994039"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2023 21:25:16 -0700
Message-ID: <132ceb1f-4559-5a99-af47-1a86a677eae7@linux.intel.com>
Date:   Thu, 20 Apr 2023 12:25:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 10/11] iommu: Split iommu_group_add_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <10-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/20/23 12:11 AM, Jason Gunthorpe wrote:
> @@ -451,16 +454,17 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   		goto out_unlock;
>   
>   	group = dev->iommu_group;
> -	ret = iommu_group_add_device(group, dev);
> +	gdev = iommu_group_alloc_device(group, dev);
>   	mutex_lock(&group->mutex);
> -	if (ret)
> +	if (IS_ERR(gdev)) {
> +		ret = PTR_ERR(gdev);
>   		goto err_put_group;
> +	}
>   
> +	list_add_tail(&gdev->list, &group->devices);

Do we need to put

	dev->iommu_group = group;

here?

>   	if (group_list && !group->default_domain && list_empty(&group->entry))
>   		list_add_tail(&group->entry, group_list);
>   	mutex_unlock(&group->mutex);
> -	iommu_group_put(group);
> -
>   	mutex_unlock(&iommu_probe_device_lock);
>   
>   	return 0;

Best regards,
baolu
