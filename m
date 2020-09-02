Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D575325AA99
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Sep 2020 13:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgIBL4F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Sep 2020 07:56:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10797 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgIBL4B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Sep 2020 07:56:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62FD375B707AA335712F;
        Wed,  2 Sep 2020 19:55:57 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 19:55:49 +0800
Subject: Re: [PATCH v2 0/2] ACPI/IORT: Code cleanups
To:     Will Deacon <will@kernel.org>
CC:     Zenghui Yu <yuzenghui@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <3142b38e-fef0-a7cf-319e-96c5da04967c@huawei.com>
 <20200902094806.GA5567@willie-the-truck>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bcbc099d-8a50-95c1-ad72-709368e326b2@huawei.com>
Date:   Wed, 2 Sep 2020 19:55:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200902094806.GA5567@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/9/2 17:48, Will Deacon wrote:
> On Wed, Sep 02, 2020 at 05:17:43PM +0800, Hanjun Guo wrote:
>> +Cc Will
>>
>> On 2020/8/18 17:16, Hanjun Guo wrote:
>>> On 2020/8/18 14:36, Zenghui Yu wrote:
>>>> * From v1 [1]:
>>>>     - As pointed out by Hanjun, remove two now unused inline functions.
>>>>       Compile tested with CONFIG_IOMMU_API is not selected.
>>>>
>>>> [1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com
>>>>
>>>> Zenghui Yu (2):
>>>>     ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
>>>>     ACPI/IORT: Remove the unused inline functions
>>>>
>>>>    drivers/acpi/arm64/iort.c | 10 ++--------
>>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> Nice cleanup.
>>>
>>> Acked-by: Hanjun Guo <guohanjun@huawei.com>
>>
>> Will, would you mind taking this patch set via ARM64 tree?
> 
> Sure, no problem. I'll queue this for 5.10 later this week.

Thanks!

Hanjun

