Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1AF2A9A6D
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 18:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgKFRJZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 12:09:25 -0500
Received: from foss.arm.com ([217.140.110.172]:42352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFRJZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 12:09:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 090FC1474;
        Fri,  6 Nov 2020 09:09:24 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76B013F66E;
        Fri,  6 Nov 2020 09:09:21 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
To:     Steven Price <steven.price@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devel@acpica.org" <devel@acpica.org>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <f389e864-3d7a-3c96-8f51-c04f92759df1@arm.com>
 <36e3a0e58e334e6aa3c051000d742543@huawei.com>
 <ca4a8e2d-40d9-b08d-7ec9-6a50d37f9126@arm.com>
 <ad2f8ea7821f4b728ab32b61e4a6121e@huawei.com>
 <5ce01d8d-c2dc-8c13-0f48-b3b35254c810@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fa51fe8a-9c69-6800-7ccc-9b7f6ef52790@arm.com>
Date:   Fri, 6 Nov 2020 17:09:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5ce01d8d-c2dc-8c13-0f48-b3b35254c810@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-11-06 16:26, Steven Price wrote:
> On 06/11/2020 16:17, Shameerali Kolothum Thodi wrote:
>>
>>
>>> -----Original Message-----
>>> From: Steven Price [mailto:steven.price@arm.com]
>>> Sent: 06 November 2020 15:22
>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>>> iommu@lists.linux-foundation.org; devel@acpica.org
>>> Cc: lorenzo.pieralisi@arm.com; joro@8bytes.org; Jonathan Cameron
>>> <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>>> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Sami Mujawar
>>> <Sami.Mujawar@arm.com>; robin.murphy@arm.com; wanghuiqiang
>>> <wanghuiqiang@huawei.com>
>>> Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
>>>
>>> On 28/10/2020 18:24, Shameerali Kolothum Thodi wrote:
>>>> Hi Steve,
>>>>
>>>>> -----Original Message-----
>>>>> From: Steven Price [mailto:steven.price@arm.com]
>>>>> Sent: 28 October 2020 16:44
>>>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>>>>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>>>>> iommu@lists.linux-foundation.org; devel@acpica.org
>>>>> Cc: lorenzo.pieralisi@arm.com; joro@8bytes.org; Jonathan Cameron
>>>>> <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>>>>> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>>> robin.murphy@arm.com;
>>>>> wanghuiqiang <wanghuiqiang@huawei.com>; Sami Mujawar
>>>>> <Sami.Mujawar@arm.com>
>>>>> Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
>>>>>
>>>>> On 27/10/2020 11:26, Shameer Kolothum wrote:
>>>>>> The series adds support to IORT RMR nodes specified in IORT
>>>>>> Revision E -ARM DEN 0049E[0]. RMR nodes are used to describe memory
>>>>>> ranges that are used by endpoints and require a unity mapping
>>>>>> in SMMU.
>>>>>
>>>>> Hi Shameer,
>>>>>
>>>>> I've also been taking a look at RMR, and Sami is helping me get set up
>>>>> so that I can do some testing. We're hoping to be able to test an EFI
>>>>> framebuffer or splash screen - which has the added complication of the
>>>>> unity mapping becoming redundant if a native display driver takes over
>>>>> the display controller.
>>>>>
>>>>> I've looked through your series and the code looks correct to me.
>>>>
>>>> Thanks for taking a look and the details.
>>>>
>>>>> Hopefully I'll be able to give it some testing soon.
>>>>
>>>> Cool. Please update once you get a chance run the tests.
>>>
>>> Hi Shameer,
>>
>> Hi Steve,
>>
>>> Just to update on this, for the EFI framebuffer use case I hit exactly
>>> the issue that Robin has mentioned in another thread - the RMR is
>>> effectively ignored because the display controller isn't being handled
>>> by Linux (so there's no device to link it to).
>>
>> Thanks for the update. Here, by "ignored "you meant get_resv_regions()
>> is not called or not?
> 
> get_resv_regions() isn't called.

Right, AIUI the EFI framebuffer "device" pretty much just represents a 
magic region of RAM, whose existence is based on EFI services - see 
register_gop_device() - regardless of whether the underlying physical 
hardware is described in DSDT and IORT such that a tangential 
iommu_probe_device() call might happen at all.

Robin.

>>   The splash screen might
>>> similarly flicker as the SMMU reset will initially block the traffic
>>> before the RMR region is enabled.
>>
>> Does that mean you somehow managed to make the unity
>> mapping but there was flicker during the SMMU reset to
>> unity mapping setup period. Sorry I am trying to understand
>> the exact behavior observed in this case.
> 
> I haven't yet got this completely working (on the board which I'm 
> testing the display controller doesn't have any existing ACPI bindings). 
> However from what I understand the SMMU reset would block all memory 
> access for the display controller before the RMR region would be setup. 
> I'm going to try to get the display controller working with ACPI so I 
> can test this properly.
> 
> Steve
