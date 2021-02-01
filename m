Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9330A812
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 13:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhBAMyM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 07:54:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12376 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhBAMyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 07:54:06 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DTnry0dngz7fHl;
        Mon,  1 Feb 2021 20:52:02 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 20:53:12 +0800
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
Message-ID: <ddeae968-62c8-63ce-c531-035f6f9a9968@hisilicon.com>
Date:   Mon, 1 Feb 2021 20:53:12 +0800
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

Hi Jean,

I did not notice this before. Yes, if we need to support IOPF in vfio, we
need enable stall events on SSID 0.

> 
> Are you seeing an issue with stall events on ssid 0?  Normally there
> shouldn't be any fault on this context, but if they happen and no handler

It happened that there is bug in the test code of HiSilicon HPRE crypto driver.
We used a wrong iova which triggered a SMMU event with stall bit :)

> is registered, the SMMU driver will just abort them and report them like a
> non-stall event.

It will report event 0x10 with stall bit.

Best,
Zhou

> 
> Thanks,
> Jean
> 
> .
> 

