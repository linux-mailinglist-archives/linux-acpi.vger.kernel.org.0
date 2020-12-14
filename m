Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C045E2D980C
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Dec 2020 13:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgLNMeh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Dec 2020 07:34:37 -0500
Received: from foss.arm.com ([217.140.110.172]:46664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbgLNMeg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Dec 2020 07:34:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B8C9D6E;
        Mon, 14 Dec 2020 04:33:48 -0800 (PST)
Received: from [10.57.33.60] (unknown [10.57.33.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B4FF3F66B;
        Mon, 14 Dec 2020 04:33:46 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Steven Price <steven.price@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
Cc:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>
References: <20201119121150.3316-1-shameerali.kolothum.thodi@huawei.com>
 <e9837ba5-deeb-c64c-2261-d0ab82eebfac@arm.com>
 <67cb563d19114f609348dc9f8b4307e9@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8f92d0b3-360b-5d47-10a7-83d09e75d993@arm.com>
Date:   Mon, 14 Dec 2020 12:33:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <67cb563d19114f609348dc9f8b4307e9@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-12-14 10:55, Shameerali Kolothum Thodi wrote:
> Hi Steve,
> 
>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 10 December 2020 10:26
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org; devel@acpica.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; wanghuiqiang
>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; Sami.Mujawar@arm.com
>> Subject: Re: [RFC PATCH v2 0/8] ACPI/IORT: Support for IORT RMR node
>>
>> On 19/11/2020 12:11, Shameer Kolothum wrote:
>>> RFC v1 --> v2:
>>>    - Added a generic interface for IOMMU drivers to retrieve all the
>>>      RMR info associated with a given IOMMU.
>>>    - SMMUv3 driver gets the RMR list during probe() and installs
>>>      bypass STEs for all the SIDs in the RMR list. This is to keep
>>>      the ongoing traffic alive(if any) during SMMUv3 reset. This is
>>>      based on the suggestions received for v1 to take care of the
>>>      EFI framebuffer use case. Only sanity tested for now.
>>
>> Hi Shameer,
>>
>> Sorry for not looking at this before.
>>
>> Do you have any plans to implement support in the SMMUv2 driver? The
>> platform I've been testing the EFI framebuffer support on has the
>> display controller behind SMMUv2, so as it stands this series doesn't
>> work. I did hack something up for SMMUv2 so I was able to test the first
>> 4 patches.
> 
> Thanks for taking a look. Sure, I can look into adding the support for SMMUv2.
> 
>>
>>>    - During the probe/attach device, SMMUv3 driver reserves any
>>>      RMR region associated with the device such that there is a unity
>>>      mapping for them in SMMU.
>>
>> For the EFI framebuffer use case there is no device to attach so I
>> believe we are left with just the stream ID in bypass mode - which is
>> definitely an improvement (the display works!)
> 
> Cool. That’s good to know.
> 
>   but not actually a unity
>> mapping of the RMR range. I'm not sure whether it's worth fixing this or
>> not, but I just wanted to point out there's still a need for a driver
>> for the device before the bypass mode is replaced with the unity mapping.
> 
> I am not sure either. My idea was we will have bypass STE setup for all devices
> with RMR initially and when the corresponding driver takes over(if that happens)
> we will have the unity mapping setup properly for the RMR regions. And for cases
> like the above, it will remain in the bypass mode.
> 
> Do you see any problem(security?) if the dev streams remain in bypass mode for
> this dev? Or is it possible to have a stub driver for this dev, so that we will have
> the probe/attach invoked and everything will fall in place?

The downside is that if a driver never binds to that device, it remains 
bypassed. If some other externally-controlled malicious device could 
manage to spoof that device's requester ID, that could potentially be 
exploited.

> TBH, I haven't looked into creating a temp domain for these types of the devices
> and also not sure how we benefit from that compared to the STE bypass mode.

That said, setting up temporary translation contexts that ensure any 
access can *only* be to RMR regions until a driver takes over is an 
awful lot more work. I'm inclined to be pragmatic here and say we should 
get things working at all with the simple bypass STE/S2CR method, then 
look at adding the higher-security effort on top.

Right now systems that need this are either broken (but effectively 
secure) or using default bypass with SMMUv2. People who prefer to 
maintain security over functionality in the interim can maintain that 
status quo by simply continuing to not describe any RMRs.

Robin.
