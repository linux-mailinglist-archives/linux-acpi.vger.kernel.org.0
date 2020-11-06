Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C8E2A9871
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Nov 2020 16:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgKFPWH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Nov 2020 10:22:07 -0500
Received: from foss.arm.com ([217.140.110.172]:40668 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbgKFPWH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 6 Nov 2020 10:22:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1C2914BF;
        Fri,  6 Nov 2020 07:22:06 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 419073F66E;
        Fri,  6 Nov 2020 07:22:03 -0800 (PST)
Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
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
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20201027112646.44680-1-shameerali.kolothum.thodi@huawei.com>
 <f389e864-3d7a-3c96-8f51-c04f92759df1@arm.com>
 <36e3a0e58e334e6aa3c051000d742543@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ca4a8e2d-40d9-b08d-7ec9-6a50d37f9126@arm.com>
Date:   Fri, 6 Nov 2020 15:22:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <36e3a0e58e334e6aa3c051000d742543@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28/10/2020 18:24, Shameerali Kolothum Thodi wrote:
> Hi Steve,
> 
>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 28 October 2020 16:44
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org; devel@acpica.org
>> Cc: lorenzo.pieralisi@arm.com; joro@8bytes.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>;
>> Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; robin.murphy@arm.com;
>> wanghuiqiang <wanghuiqiang@huawei.com>; Sami Mujawar
>> <Sami.Mujawar@arm.com>
>> Subject: Re: [RFC PATCH 0/4] ACPI/IORT: Support for IORT RMR node
>>
>> On 27/10/2020 11:26, Shameer Kolothum wrote:
>>> The series adds support to IORT RMR nodes specified in IORT
>>> Revision E -ARM DEN 0049E[0]. RMR nodes are used to describe memory
>>> ranges that are used by endpoints and require a unity mapping
>>> in SMMU.
>>
>> Hi Shameer,
>>
>> I've also been taking a look at RMR, and Sami is helping me get set up
>> so that I can do some testing. We're hoping to be able to test an EFI
>> framebuffer or splash screen - which has the added complication of the
>> unity mapping becoming redundant if a native display driver takes over
>> the display controller.
>>
>> I've looked through your series and the code looks correct to me.
> 
> Thanks for taking a look and the details.
> 
>> Hopefully I'll be able to give it some testing soon.
> 
> Cool. Please update once you get a chance run the tests.

Hi Shameer,

Just to update on this, for the EFI framebuffer use case I hit exactly 
the issue that Robin has mentioned in another thread - the RMR is 
effectively ignored because the display controller isn't being handled 
by Linux (so there's no device to link it to). The splash screen might 
similarly flicker as the SMMU reset will initially block the traffic 
before the RMR region is enabled.

Steve
