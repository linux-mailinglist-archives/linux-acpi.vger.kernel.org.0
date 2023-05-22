Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2899C70B33C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 04:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjEVCcK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 22:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjEVCcJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 22:32:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14BC2
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684722728; x=1716258728;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tbGJg+2i9U//neYjsXNAosrptASqysxnVwW7shFdYaA=;
  b=oElkN26AWkyW75y/QCbY/Gz32hjIHblWyjhTQZOz/KCQ1I+J5O6rqplw
   2W11mnQhkDeEVdz6NnK6Izjk9mwmiTYrxdD1EjrlT3VH0P96DqRwltxMi
   p5uqOGltgqQTzhGh/sriOX6qzey3A6ZAK4M9vXjuIU5Ls78cFodjMgne4
   EZpcUeeTJW3auVFEmHLwi9aVZafnILtfQQRSa3YugJZozhPDMfBXjW6QA
   n0PKYWisuk+gHCWBGhzrc75N55+ZUBTM5uAJ/Vlh2bFlU//qlgExySRmq
   TpKcGBtPDBGV/r3wmEzqyWKInA8fNf4Ctwa5qyJvVBhAdi8e607xUrWr7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416272431"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="416272431"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 19:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="793120183"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="793120183"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2023 19:31:44 -0700
Message-ID: <20654d71-1497-bd31-e2e8-a42c5e5a36e5@linux.intel.com>
Date:   Mon, 22 May 2023 10:31:04 +0800
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
 <5bcb5f03-77c9-116e-c436-9d0af21fa82a@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5bcb5f03-77c9-116e-c436-9d0af21fa82a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/21/23 7:31 PM, Baolu Lu wrote:
>>       for_each_group_device(group, device) {
>>           if (device->dev != dev)
>> @@ -510,44 +564,30 @@ static void __iommu_group_remove_device(struct 
>> device *dev)
>>           list_del(&device->list);
>>           __iommu_group_free_device(group, device);
>> -        /* Caller must put iommu_group */
>> -        return;
>> +        if (dev->iommu && dev->iommu->iommu_dev)
>> +            iommu_deinit_device(dev);
>> +        else
>> +            dev->iommu_group = NULL;
>> +        goto out;
>>       }
>>       WARN(true, "Corrupted iommu_group device_list");
>> +out:
>> +    mutex_unlock(&group->mutex);
>> +
>> +    /* Pairs with the get in iommu_group_add_device() */
>> +    iommu_group_put(group);
> 
> The group->devices_kobj was increased on the probe device path twice:
> 
> - iommu_init_device() - allocate the group
> - iommu_group_add_device() - add device to the group
> 
> But, on the release path, it seems that group->devices_kobj is only
> decreased once.
> 
> Did I overlook anything? Otherwise, the group will never be released,
> right?

I can answer this question by myself now. The
iommu_group_add/remove_device() helpers are only for external users.
They are not on the internal probe/release paths.

The code is fine. I can see below debug message during my test:

         pr_debug("Releasing group %d\n", group->id);

Sorry for the noise.

Best regards,
baolu
