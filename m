Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CDC326065
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhBZJou (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 04:44:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13092 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhBZJoX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2021 04:44:23 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dn4S81Wj2z16D0R;
        Fri, 26 Feb 2021 17:42:00 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Feb 2021
 17:43:27 +0800
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
 <YBfij71tyYvh8LhB@myrica>
CC:     <joro@8bytes.org>, <will@kernel.org>, <vivek.gautam@arm.com>,
        <guohanjun@huawei.com>, <linux-acpi@vger.kernel.org>,
        <zhangfei.gao@linaro.org>, <lenb@kernel.org>,
        <devicetree@vger.kernel.org>, <kevin.tian@intel.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <rjw@rjwysocki.net>, <iommu@lists.linux-foundation.org>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <linux-accelerators@lists.ozlabs.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <fabffd28-7497-2758-c2bf-9d31aa562085@hisilicon.com>
Date:   Fri, 26 Feb 2021 17:43:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YBfij71tyYvh8LhB@myrica>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/1 19:14, Jean-Philippe Brucker wrote:
> Hi Zhou,
> 
> On Mon, Feb 01, 2021 at 09:18:42AM +0800, Zhou Wang wrote:
>>> @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>>>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>>>  			CTXDESC_CD_0_V;
>>>  
>>> -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
>>> -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>>> +		if (smmu_domain->stall_enabled)
>>
>> Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
>> The reason is if not CD.S will also be set when ssid is 0, which is not needed.
> 
> Some drivers may want to get stall events on SSID 0:
> https://lore.kernel.org/kvm/20210125090402.1429-1-lushenming@huawei.com/#t
> 
> Are you seeing an issue with stall events on ssid 0?  Normally there
> shouldn't be any fault on this context, but if they happen and no handler
> is registered, the SMMU driver will just abort them and report them like a
> non-stall event.

Hi Jean,

I notice that there is problem. In my case, I expect that CD0 is for kernel
and other CDs are for user space. Normally there shouldn't be any fault in
kernel, however, we have RAS case which is for some reason there may has
invalid address access from hardware device.

So at least there are two different address access failures: 1. hardware RAS problem;
2. software fault fail(e.g. kill process when doing DMA). Handlings for these
two are different: for 1, we should reset hardware device; for 2, stop related
DMA is enough.

Currently if SMMU returns the same signal(by SMMU resume abort), master device
driver can not tell these two kinds of cases.

From the basic concept, if a CD is used for kernel, its S bit should not be set.
How about we add iommu domain check here too, if DMA domain we do not set S bit for
CD0, if unmanaged domain we set S bit for all CDs?

Thanks,
Zhou

> 
> Thanks,
> Jean
> 
> .
> 

