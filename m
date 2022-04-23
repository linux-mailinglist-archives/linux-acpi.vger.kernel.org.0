Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8038050C7D5
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Apr 2022 08:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiDWGmW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Apr 2022 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDWGmV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Apr 2022 02:42:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873CE12
        for <linux-acpi@vger.kernel.org>; Fri, 22 Apr 2022 23:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650695965; x=1682231965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gVRIdH50VRkkOoW7Ed2DisHM8rizLUoP6GWfszv/o78=;
  b=b7rMpcThT5Z6uuQuU9y01NQ4urUV+ETrScJg9toZyA7Cc1SYu+hZm8gg
   xeim0o827+zrpi47yeVk0HjZP6NB4rzKzGrmuW8exOvBd0vtBqNZDUuTe
   bsqDlpPGsAfb/9/LMQiik7SrAUCQNLDhHxO4K1VbZ1K8zJ3DyK6ip8vRB
   //JKnH25ZYSbWbmsCOeQSHK3JYE7qCkRoUpOqHbCjIBC70MFnZO68f740
   8bLgPS1tfYo5LgNau9WFU5G583HBJ4nHqEau5NEtzH8JD0PqUNHZozuWG
   laHuf/Uj3uZGQPn/wkbUa1lQU+xV/ja+gN2iN8KMmELRtyL6Dg5m/syLo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246768633"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="246768633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 23:39:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="578293638"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217]) ([10.255.31.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 23:39:17 -0700
Message-ID: <675db27a-94d4-f933-1fa1-0960d64f3ff2@linux.intel.com>
Date:   Sat, 23 Apr 2022 14:39:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 1/9] iommu: Introduce a callback to struct
 iommu_resv_region
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, robin.murphy@arm.com,
        jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
 <20220422162907.1276-2-shameerali.kolothum.thodi@huawei.com>
 <03e94ba9-f558-954f-e84b-cd8a9e693aea@linux.intel.com>
 <YmOLGsaMa7hCjMzx@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YmOLGsaMa7hCjMzx@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/4/23 13:14, Christoph Hellwig wrote:
> On Sat, Apr 23, 2022 at 10:04:39AM +0800, Lu Baolu wrote:
>> The generic_iommu_put_resv_regions() itself is a callback. Why bothering
>> adding another callback from the same iommu driver in it? Or, you are
>> going to remove the put_resv_regions from the iommu ops?
> 
> It is a driver method, but these reserved entries are not actually
> allocated by the driver.  And I do have a patch pending removing this
> driver method that should never have been a driver method, check
> the iomm list archives for
> 
>      iommu: remove the put_resv_regions method
> 

Yeah! That's a good idea.

Best regards,
baolu
