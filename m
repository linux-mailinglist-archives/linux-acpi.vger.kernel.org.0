Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB092F4229
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 03:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbhAMC7L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 21:59:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:16378 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbhAMC7L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 21:59:11 -0500
IronPort-SDR: TpII4ceYavZO0OC7cRwSy5O3Tr135D+PRBPO7tP9sJzODP8f2tOoSg5g+SA5L8VU/ZvnAExlPk
 WWJntulckZ8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157917559"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="157917559"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 18:57:50 -0800
IronPort-SDR: +X9T3MaFFO67nRlp0dxZ8TxMXkHxjJOAiOBc3En2s6MlrikQP6movdXK64uL82EtWckUi7GFJu
 VUrSsRsxGT6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="464751072"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2021 18:57:44 -0800
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, vdumpa@nvidia.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
Date:   Wed, 13 Jan 2021 10:49:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X/1o72DTmzdCMhDz@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 1/12/21 5:16 PM, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> On Tue, Jan 12, 2021 at 12:31:23PM +0800, Lu Baolu wrote:
>> Hi Jean,
>>
>> On 1/8/21 10:52 PM, Jean-Philippe Brucker wrote:
>>> Some devices manage I/O Page Faults (IOPF) themselves instead of relying
>>> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
>>> mandating IOMMU-managed IOPF. The other device drivers now need to first
>>> enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Cc: Zhou Wang <wangzhou1@hisilicon.com>
>>> ---
>>>    include/linux/iommu.h | 20 +++++++++++++++++---
>>>    1 file changed, 17 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 583c734b2e87..701b2eeb0dc5 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -156,10 +156,24 @@ struct iommu_resv_region {
>>>    	enum iommu_resv_type	type;
>>>    };
>>> -/* Per device IOMMU features */
>>> +/**
>>> + * enum iommu_dev_features - Per device IOMMU features
>>> + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
>>> + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
>>> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally using
>>> + *			 %IOMMU_DEV_FEAT_SVA requires %IOMMU_DEV_FEAT_IOPF, but
>>> + *			 some devices manage I/O Page Faults themselves instead
>>> + *			 of relying on the IOMMU. When supported, this feature
>>> + *			 must be enabled before and disabled after
>>> + *			 %IOMMU_DEV_FEAT_SVA.
>>
>> Is this only for SVA? We may see more scenarios of using IOPF. For
>> example, when passing through devices to user level, the user's pages
>> could be managed dynamically instead of being allocated and pinned
>> statically.
> 
> Hm, isn't that precisely what SVA does?  I don't understand the
> difference. That said FEAT_IOPF doesn't have to be only for SVA. It could
> later be used as a prerequisite some another feature. For special cases
> device drivers can always use the iommu_register_device_fault_handler()
> API and handle faults themselves.

 From the perspective of IOMMU, there is a little difference between
these two. For SVA, the page table is from CPU side, so IOMMU only needs
to call handle_mm_fault(); For above pass-through case, the page table
is from IOMMU side, so the device driver (probably VFIO) needs to
register a fault handler and call iommu_map/unmap() to serve the page
faults.

If we think about the nested mode (or dual-stage translation), it's more
complicated since the kernel (probably VFIO) handles the second level
page faults, while the first level page faults need to be delivered to
user-level guest. Obviously, this hasn't been fully implemented in any
IOMMU driver.

> 
>> If @IOMMU_DEV_FEAT_IOPF is defined as generic iopf support, the current
>> vendor IOMMU driver support may not enough.
> 
> IOMMU_DEV_FEAT_IOPF on its own doesn't do anything useful, it's mainly a
> way for device drivers to probe the IOMMU capability. Granted in patch
> 10 the SMMU driver registers the IOPF queue on enable() but that could be
> done by FEAT_SVA enable() instead, if we ever repurpose FEAT_IOPF.

I have no objection to split IOPF from SVA. Actually we must have this
eventually. My concern is that at this stage, the IOMMU drivers only
support SVA type of IOPF, a generic IOMMU_DEV_FEAT_IOPF feature might
confuse the device drivers which want to add other types of IOPF usage.

> 
> Thanks,
> Jean
> 

Best regards,
baolu
