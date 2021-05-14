Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48019380144
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 02:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhENAny (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 May 2021 20:43:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2480 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhENAny (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 May 2021 20:43:54 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fh8nC3ZDxzBtT2;
        Fri, 14 May 2021 08:39:59 +0800 (CST)
Received: from [10.174.179.71] (10.174.179.71) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 08:42:37 +0800
Subject: Re: [PATCH] ACPI/IORT: Handle device properties with software node
 API
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210511125528.18525-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0iQA91927-OXWVRu2_yNgTS-7b8ew4uvo+qk8q86vzOsg@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9026d9a3-9f17-6686-d64e-009326ec6e90@huawei.com>
Date:   Fri, 14 May 2021 08:42:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iQA91927-OXWVRu2_yNgTS-7b8ew4uvo+qk8q86vzOsg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.71]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/5/11 21:51, Rafael J. Wysocki wrote:
> On Tue, May 11, 2021 at 2:55 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com>  wrote:
>> The older device property API is going to be removed.
>> Replacing the device_add_properties() call with software
>> node API equivalent device_create_managed_software_node().
>>
>> Fixes: 434b73e61cc6 ("iommu/arm-smmu-v3: Use device properties for pasid-num-bits")
>> Signed-off-by: Heikki Krogerus<heikki.krogerus@linux.intel.com>
>> ---
>>   drivers/acpi/arm64/iort.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 3912a1f6058e5..e34937e11186a 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -976,7 +976,7 @@ static void iort_named_component_init(struct device *dev,
>>                                        FIELD_GET(ACPI_IORT_NC_PASID_BITS,
>>                                                  nc->node_flags));
>>
>> -       if (device_add_properties(dev, props))
>> +       if (device_create_managed_software_node(dev, props, NULL))
>>                  dev_warn(dev, "Could not add device properties\n");
>>   }
>>
>> --
> Thanks!
> 
> I can take this through the ACPI tree if there are no objections.

Since this is related to device property API refactor, I'm
fine with it.

Lorenzo, what's your position?

Thanks
Hanjun
