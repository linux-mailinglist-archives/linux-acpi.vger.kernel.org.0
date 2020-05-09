Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD301CC01D
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 11:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgEIJre (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 9 May 2020 05:47:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52554 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbgEIJre (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 9 May 2020 05:47:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 593F2EC5C2C35F6F3F1A;
        Sat,  9 May 2020 17:47:33 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 17:47:30 +0800
Subject: Re: [PATCH 7/9] ACPI: EC: Put the ACPI table after using it
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, <linux-acpi@vger.kernel.org>
References: <1588842561-32907-1-git-send-email-guohanjun@huawei.com>
 <1588842561-32907-8-git-send-email-guohanjun@huawei.com>
 <5004179.babTvPOIzi@kreacher> <3522798.RuaxqmcMED@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <532f9e9e-7f91-bfe4-3276-2c3c6da39ed8@huawei.com>
Date:   Sat, 9 May 2020 17:47:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3522798.RuaxqmcMED@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/9 17:30, Rafael J. Wysocki wrote:
> On Saturday, May 9, 2020 11:11:26 AM CEST Rafael J. Wysocki wrote:
>> On Thursday, May 7, 2020 11:09:19 AM CEST Hanjun Guo wrote:
>>> The embedded controller boot resources table needs to be
>>> released after using it.
>>>
>>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>>> ---
>>>   drivers/acpi/ec.c | 14 ++++++++++----
>>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>> index b4c0152e..281a9bf 100644
>>> --- a/drivers/acpi/ec.c
>>> +++ b/drivers/acpi/ec.c
>>> @@ -1784,12 +1784,15 @@ static void __init acpi_ec_ecdt_start(void)
>>>   
>>>   	status = acpi_get_handle(NULL, ecdt_ptr->id, &handle);
>>>   	if (ACPI_FAILURE(status))
>>> -		return;
>>> +		goto out;
>>>   
>>
>> So to avoid adding a new label I would prefer
>>
>> if (ACPI_SUCCESS(status)) {
>> 	boot_ec->handle = handle;
>>
>> 	/* Add a special ACPI device object to represent the boot EC. */
>> 	acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
>> }
>>
>>>   	boot_ec->handle = handle;
>>>   
>>>   	/* Add a special ACPI device object to represent the boot EC. */
>>>   	acpi_bus_register_early_device(ACPI_BUS_TYPE_ECDT_EC);
>>> +
>>> +out:
>>> +	acpi_put_table((struct acpi_table_header *)ecdt_ptr);
>>>   }
>>>   
> 
> I've made the above change manually and applied the whole series as 5.8
> material.

Thank you very much!

