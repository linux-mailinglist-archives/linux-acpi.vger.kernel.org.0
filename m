Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C6326B70
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Feb 2021 04:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhB0Dkx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 22:40:53 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12214 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhB0Dkw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2021 22:40:52 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DnXKn0znNzlQ5K;
        Sat, 27 Feb 2021 11:38:05 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Feb 2021
 11:40:01 +0800
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
 <YBfij71tyYvh8LhB@myrica>
 <fabffd28-7497-2758-c2bf-9d31aa562085@hisilicon.com>
 <YDkh8qR7csPB68sC@myrica>
CC:     <joro@8bytes.org>, <will@kernel.org>, <vivek.gautam@arm.com>,
        <guohanjun@huawei.com>, <linux-acpi@vger.kernel.org>,
        <zhangfei.gao@linaro.org>, <lenb@kernel.org>,
        <devicetree@vger.kernel.org>, <kevin.tian@intel.com>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <rjw@rjwysocki.net>, <iommu@lists.linux-foundation.org>,
        <sudeep.holla@arm.com>, <robin.murphy@arm.com>,
        <linux-accelerators@lists.ozlabs.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <22fa4120-eadf-20d5-0d0a-9935aa0f1fb5@hisilicon.com>
Date:   Sat, 27 Feb 2021 11:40:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YDkh8qR7csPB68sC@myrica>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/27 0:29, Jean-Philippe Brucker wrote:
> Hi Zhou,
> 
> On Fri, Feb 26, 2021 at 05:43:27PM +0800, Zhou Wang wrote:
>> On 2021/2/1 19:14, Jean-Philippe Brucker wrote:
>>> Hi Zhou,
>>>
>>> On Mon, Feb 01, 2021 at 09:18:42AM +0800, Zhou Wang wrote:
>>>>> @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>>>>>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>>>>>  			CTXDESC_CD_0_V;
>>>>>  
>>>>> -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
>>>>> -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>>>>> +		if (smmu_domain->stall_enabled)
>>>>
>>>> Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
>>>> The reason is if not CD.S will also be set when ssid is 0, which is not needed.
>>>
>>> Some drivers may want to get stall events on SSID 0:
>>> https://lore.kernel.org/kvm/20210125090402.1429-1-lushenming@huawei.com/#t
>>>
>>> Are you seeing an issue with stall events on ssid 0?  Normally there
>>> shouldn't be any fault on this context, but if they happen and no handler
>>> is registered, the SMMU driver will just abort them and report them like a
>>> non-stall event.
>>
>> Hi Jean,
>>
>> I notice that there is problem. In my case, I expect that CD0 is for kernel
>> and other CDs are for user space. Normally there shouldn't be any fault in
>> kernel, however, we have RAS case which is for some reason there may has
>> invalid address access from hardware device.
>>
>> So at least there are two different address access failures: 1. hardware RAS problem;
>> 2. software fault fail(e.g. kill process when doing DMA). Handlings for these
>> two are different: for 1, we should reset hardware device; for 2, stop related
>> DMA is enough.
> 
> Right, and in case 2 there should be no report printed since it can be
> triggered by user, while you probably want to be loud in case 1.
> 
>> Currently if SMMU returns the same signal(by SMMU resume abort), master device
>> driver can not tell these two kinds of cases.
> 
> This part I don't understand. So the SMMU sends a RESUME(abort) command,
> and then the master reports the DMA error to the device driver, which
> cannot differentiate 1 from 2?  (I guess there is no SSID in this report?)
> But how does disabling stall change this?  The invalid DMA access will
> still be aborted by the SMMU.

This is about the hardware design. In D06 board, an invalid DMA access from
accelerator devices will be aborted, and an hardware error signal will be
returned to accelerator devices, which reports it as a RAS error irq.
while for the stall case, error signal triggered by SMMU resume abort is
also reported as same RAS error irq. This is problem in D60 board.

In next generation of hardware, a new irq will be added to report SMMU resume
abort information, it works with related registers in accelerator devices to
get related hardware queue, which need to be stopped.

So if CD0.S is 1, invalid DMA access in kernel will be reported into above
new added irq, which has not enough information to tell RAS errors(there are 10+
hardware RAS errors) from SMMU resume abort.

> 
> Hypothetically, would it work if all stall events that could not be
> handled went to the device driver?  Those reports would contain the SSID
> (or lack thereof), so you could reset the device in case 1 and ignore case
> 2. Though resetting the device in the middle of a stalled transaction

As above, it is hard to tell RAS errors and SMMU resume abort in SMMU resume abort
now :(

> probably comes with its own set of problems.
> 
>> From the basic concept, if a CD is used for kernel, its S bit should not be set.
>> How about we add iommu domain check here too, if DMA domain we do not set S bit for
>> CD0, if unmanaged domain we set S bit for all CDs?
> 
> I think disabling stall for CD0 of a DMA domain makes sense in general,
> even though I don't really understand how that fixes your issue. But

As above, if disabling stall for CD0, an invalid DMA access will be handled
by RAS error irq.

> someone might come up with a good use-case for receiving stall events on

If A DMA access in kernel fails, I think there should be a RAS issue :)
So better to disable CD0 stall for DMA domain.

Best,
Zhou

> DMA mappings, so I'm wondering whether the alternative solution where we
> report unhandled stall events to the device driver would also work for
> you.
> 
> Thanks,
> Jean
> 
> .
> 

