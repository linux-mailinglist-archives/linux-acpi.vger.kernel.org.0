Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087703B7322
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 15:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbhF2NZ2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 09:25:28 -0400
Received: from foss.arm.com ([217.140.110.172]:51046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233625AbhF2NZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 09:25:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43A0D106F;
        Tue, 29 Jun 2021 06:22:58 -0700 (PDT)
Received: from [10.57.46.146] (unknown [10.57.46.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 906FD3F718;
        Tue, 29 Jun 2021 06:22:56 -0700 (PDT)
Subject: Re: [PATCH v5 7/8] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Linuxarm <linuxarm@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>, Sami.Mujawar@arm.com,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-8-shameerali.kolothum.thodi@huawei.com>
 <2bc3ae21-f2af-ee2c-5e9d-d47633e0439e@arm.com>
 <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <b33c1525-5a74-a985-fd39-f4df8614f210@arm.com>
Date:   Tue, 29 Jun 2021 14:22:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABdtJHtpN7s2gTwUkeWcachOnk6djgMaJLGtnKq5SExA82bDDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-06-29 08:03, Jon Nettleton wrote:
> On Mon, Jun 14, 2021 at 12:06 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2021-05-24 12:02, Shameer Kolothum wrote:
>>> From: Jon Nettleton <jon@solid-run.com>
>>>
>>> Check if there is any RMR info associated with the devices behind
>>> the SMMU and if any, install bypass SMRs for them. This is to
>>> keep any ongoing traffic associated with these devices alive
>>> when we enable/reset SMMU during probe().
>>>
>>> Signed-off-by: Jon Nettleton <jon@solid-run.com>
>>> Signed-off-by: Steven Price <steven.price@arm.com>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu/arm-smmu.c | 65 +++++++++++++++++++++++++++
>>>    1 file changed, 65 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 6f72c4d208ca..56db3d3238fc 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -2042,6 +2042,67 @@ err_reset_platform_ops: __maybe_unused;
>>>        return err;
>>>    }
>>>
>>> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
>>> +{
>>> +     struct list_head rmr_list;
>>> +     struct iommu_resv_region *e;
>>> +     int i, cnt = 0;
>>> +     u32 smr;
>>> +     u32 reg;
>>> +
>>> +     INIT_LIST_HEAD(&rmr_list);
>>> +     if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
>>> +             return;
>>> +
>>> +     reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
>>> +
>>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
>>> +             /*
>>> +              * SMMU is already enabled and disallowing bypass, so preserve
>>> +              * the existing SMRs
>>> +              */
>>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
>>> +                     smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
>>
>> To reiterate, just because a bootloader/crashed kernel/whatever may have
>> left some configuration behind doesn't mean that it matters (e.g. what
>> if these SMRs are pointing at translation contexts?). All we should be
>> doing here is setting the relevant RMR accommodations in our "clean
>> slate" software state before the reset routine applies it to the
>> hardware, just like patch #5 does for SMMUv3.
>>
>> Trying to safely reset an SMMU when we discover it with CLIENTPD=0 is
>> really another issue entirely, and I'd say is beyond the scope of this
>> series
>>
>>> +                     if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
>>> +                             continue;
>>
>> Note that that's not even necessarily correct (thanks to EXIDS).
>>
>>> +                     smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
>>> +                     smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
>>> +                     smmu->smrs[i].valid = true;
>>> +             }
>>> +     }
>>> +
>>> +     list_for_each_entry(e, &rmr_list, list) {
>>> +             u32 sid = e->fw_data.rmr.sid;
>>> +
>>> +             i = arm_smmu_find_sme(smmu, sid, ~0);
>>> +             if (i < 0)
>>> +                     continue;
>>> +             if (smmu->s2crs[i].count == 0) {
>>> +                     smmu->smrs[i].id = sid;
>>> +                     smmu->smrs[i].mask = ~0;
>>
>> This is very wrong (as has now already been pointed out).
>>
>>> +                     smmu->smrs[i].valid = true;
>>> +             }
>>> +             smmu->s2crs[i].count++;
>>> +             smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
>>> +             smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
>>> +             smmu->s2crs[i].cbndx = 0xff;
>>
>> Nit: cbndx is left uninitialised for bypass/fault entries elsewhere, so
>> there's little point touching it here.
>>
>>> +
>>> +             cnt++;
>>> +     }
>>> +
>>> +     if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
>>> +             /* Remove the valid bit for unused SMRs */
>>> +             for (i = 0; i < smmu->num_mapping_groups; i++) {
>>> +                     if (smmu->s2crs[i].count == 0)
>>> +                             smmu->smrs[i].valid = false;
>>> +             }
>>
>> If this dance is only about avoiding stream match conflicts when trying
>> to reprogram live SMRs, simply turning the SMMU off beforehand would be
>> a lot simpler.
> 
> Robin,
> 
> I am not sure what you mean here, and maybe Steve wants to jump in and
> help clarify.
> 
> My understanding is that "dance" is required for regions that need to
> continue to work
> throughout the boot process.  I think the example I have seen the most
> is for GOP drivers that
> use system memory rather than dedicated VRAM.

All that is required is to install bypass SMEs for the relevant streams 
before enabling the SMMU. That much is achieved by the 
list_for_each_entry(e, &rmr_list, list) loop setting up initial state 
followed by arm_smmu_device_reset(). The "dance" I'm referring to is the 
additional reading out of (possibly nonsense) SMR state beforehand to 
pre-bias the SMR allocator, then trying to clean up the remnants afterwards.

If we're going to pretend to be robust against finding the SMMU already 
enabled *with* live traffic ongoing, there's frankly an awful lot more 
care we'd need to take beyond here (and for some aspects there's still 
no right answer). If on the other hand we're implicitly assuming that 
any boot-time enabled SMRs exactly match the RMR configuration anyway, 
then simply disabling the SMMU until we enable it again in the reset 
routine still preserves the necessary bypass behaviour for RMR streams 
while sidestepping any issues related to reprogramming live SMMU state.

Robin.

>>> +     }
>>> +
>>> +     dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
>>> +                cnt == 1 ? "" : "s");
>>> +     iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
>>> +}
>>> +
>>>    static int arm_smmu_device_probe(struct platform_device *pdev)
>>>    {
>>>        struct resource *res;
>>> @@ -2168,6 +2229,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>        }
>>>
>>>        platform_set_drvdata(pdev, smmu);
>>> +
>>> +     /* Check for RMRs and install bypass SMRs if any */
>>> +     arm_smmu_rmr_install_bypass_smr(smmu);
>>> +
>>>        arm_smmu_device_reset(smmu);
>>>        arm_smmu_test_smr_masks(smmu);
>>>
>>>
