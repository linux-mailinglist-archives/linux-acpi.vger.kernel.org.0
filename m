Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2650D28FF15
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404561AbgJPH1c (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 03:27:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15303 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404514AbgJPH1c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 03:27:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BF5547CB1A9DC141914;
        Fri, 16 Oct 2020 15:27:29 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 15:27:22 +0800
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Len Brown" <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
 <20201015180340.GB2624@gaia>
 <35faab1c-5c32-6cd3-0a14-77057dd223f5@huawei.com>
 <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <89ed58a5-b3ca-e361-94d8-b6754ce5eb34@huawei.com>
Date:   Fri, 16 Oct 2020 15:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Ard,

On 2020/10/16 14:54, Ard Biesheuvel wrote:
> On Fri, 16 Oct 2020 at 08:51, Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> On 2020/10/16 2:03, Catalin Marinas wrote:
>>> On Thu, Oct 15, 2020 at 10:26:18PM +0800, Hanjun Guo wrote:
>>>> On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>
>>>>> We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
>>>>> incorporating masters that can address less than 32 bits of DMA, in
>>>>> particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
>>>>> peripherals that can only address up to 1 GB (and its PCIe host
>>>>> bridge can only access the bottom 3 GB)
>>>>>
>>>>> Instructing the DMA layer about these limitations is straight-forward,
>>>>> even though we had to fix some issues regarding memory limits set in
>>>>> the IORT for named components, and regarding the handling of ACPI _DMA
>>>>> methods. However, the DMA layer also needs to be able to allocate
>>>>> memory that is guaranteed to meet those DMA constraints, for bounce
>>>>> buffering as well as allocating the backing for consistent mappings.
>>>>>
>>>>> This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
>>>>> it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
>>>>> problems with kdump, and potentially in other places where allocations
>>>>> cannot cross zone boundaries. Therefore, we should avoid having two
>>>>> separate DMA zones when possible.
>>>>>
>>>>> So let's do an early scan of the IORT, and only create the ZONE_DMA
>>>>> if we encounter any devices that need it. This puts the burden on
>>>>> the firmware to describe such limitations in the IORT, which may be
>>>>> redundant (and less precise) if _DMA methods are also being provided.
>>>>> However, it should be noted that this situation is highly unusual for
>>>>> arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
>>>>> the _DMA method if implemented, and so we will not lose the ability to
>>>>> perform streaming DMA outside the ZONE_DMA if the _DMA method permits
>>>>> it.
>>>>
>>>> Sorry, I'm still a little bit confused. With this patch, if we have
>>>> a device which set the right _DMA method (DMA size >= 32), but with the
>>>> wrong DMA size in IORT, we still have the ZONE_DMA created which
>>>> is actually not needed?
>>>
>>> With the current kernel, we get a ZONE_DMA already with an arbitrary
>>> size of 1GB that matches what RPi4 needs. We are trying to eliminate
>>> such unnecessary ZONE_DMA based on some heuristics (well, something that
>>> looks "better" than a OEM ID based quirk). Now, if we learn that IORT
>>> for platforms in the field is that broken as to describe few bits-wide
>>> DMA masks, we may have to go back to the OEM ID quirk.
>>
>> Some platforms using 0 as the memory size limit, for example D05 [0] and
>> D06 [1], I think we need to go back to the OEM ID quirk.
>>
>> For D05/D06, there are multi interrupt controllers named as mbigen,
>> mbigen is using the named component to describe the mappings with
>> the ITS controller, and mbigen is using 0 as the memory size limit.
>>
>> Also since the memory size limit for PCI RC was introduced by later
>> IORT revision, so firmware people may think it's fine to set that
>> as 0 because the system works without it.
>>
> 
> Hello Hanjun,
> 
> The patch only takes the address limit field into account if its value > 0.

Sorry I missed the if (*->memory_address_limit) check, thanks
for the reminding.

> 
> Also, before commit 7fb89e1d44cb6aec ("ACPI/IORT: take _DMA methods
> into account for named components"), the _DMA method was not taken
> into account for named components at all, and only the IORT limit was
> used, so I do not anticipate any problems with that.

Then this patch is fine to me.

Thanks
Hanjun
