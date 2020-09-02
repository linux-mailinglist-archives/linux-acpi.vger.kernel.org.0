Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D5425A877
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Sep 2020 11:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBJR4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Sep 2020 05:17:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgIBJRz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 2 Sep 2020 05:17:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A46FE76BC740ABAE0AE1;
        Wed,  2 Sep 2020 17:17:53 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 2 Sep 2020
 17:17:43 +0800
Subject: Re: [PATCH v2 0/2] ACPI/IORT: Code cleanups
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Zenghui Yu <yuzenghui@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Will Deacon <will@kernel.org>
References: <20200818063625.980-1-yuzenghui@huawei.com>
 <12667629-5c3f-4606-ec27-72e5ef19f35a@huawei.com>
Message-ID: <3142b38e-fef0-a7cf-319e-96c5da04967c@huawei.com>
Date:   Wed, 2 Sep 2020 17:17:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <12667629-5c3f-4606-ec27-72e5ef19f35a@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

+Cc Will

On 2020/8/18 17:16, Hanjun Guo wrote:
> On 2020/8/18 14:36, Zenghui Yu wrote:
>> * From v1 [1]:
>>    - As pointed out by Hanjun, remove two now unused inline functions.
>>      Compile tested with CONFIG_IOMMU_API is not selected.
>>
>> [1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com
>>
>> Zenghui Yu (2):
>>    ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
>>    ACPI/IORT: Remove the unused inline functions
>>
>>   drivers/acpi/arm64/iort.c | 10 ++--------
>>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> Nice cleanup.
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Will, would you mind taking this patch set via ARM64 tree?

Thanks
Hanjun

