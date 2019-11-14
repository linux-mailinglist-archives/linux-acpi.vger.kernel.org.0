Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51191FC055
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 07:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfKNGp3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 01:45:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43136 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbfKNGp3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 01:45:29 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8463BDDCDDA6BFBF7016;
        Thu, 14 Nov 2019 14:45:26 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 14 Nov 2019
 14:45:16 +0800
Subject: Re: [PATCH] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <8bdc7a86-e464-9c46-3d40-4f3c75111ce6@huawei.com>
 <2931286.GRae9fBGx2@kreacher>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <2af56bf7-aff8-b4f5-b4cf-06743e906695@huawei.com>
Date:   Thu, 14 Nov 2019 14:45:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2931286.GRae9fBGx2@kreacher>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2019/11/14 7:21, Rafael J. Wysocki wrote:
> On Tuesday, November 5, 2019 3:35:25 PM CET Yunfeng Ye wrote:
>> There are two problems after commit 0f27cff8597d ("ACPI: sysfs: Make
>> ACPI GPE mask kernel parameter cover all GPEs"):
>>
>> 1. ACPI_MASKABLE_GPE_MAX is changed from 0x80 to 0xff, so the check
>> condition "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of
>> gpe is u8.
>>
>> 2. The size of bitmap is ACPI_MASKABLE_GPE_MAX, so it is not support the
>> num 255 for gpe.
>>
>> Update the macro ACPI_MASKABLE_GPE_MAX to 0x100, and change the type of
>> gpe to u32, also modify the checking condition for gpe.
>>
>> Bye the way, update the docs for kernel parameter acpi_mask_gpe.
>>
>> Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> AFAICS this really is about supporting the masking of GPE 0xFF.
>>> ---
>>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>>  drivers/acpi/sysfs.c                            | 8 ++++----
>>  2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a84a83f8881e..dd878e2491e1 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -114,6 +114,7 @@
>>  			This facility can be used to prevent such uncontrolled
>>  			GPE floodings.
>>  			Format: <int>
>> +			Support masking of GPEs numbered from 0x00 to 0xff
> 
> Why not just say "Format: <byte>" ?
> 
ok, thanks.

>>
>>  	acpi_no_auto_serialize	[HW,ACPI]
>>  			Disable auto-serialization of AML methods
>> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
>> index 75948a3f1a20..3c3302583d78 100644
>> --- a/drivers/acpi/sysfs.c
>> +++ b/drivers/acpi/sysfs.c
>> @@ -819,14 +819,14 @@ static ssize_t counter_set(struct kobject *kobj,
>>   * interface:
>>   *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
>>   */
>> -#define ACPI_MASKABLE_GPE_MAX	0xFF
>> +#define ACPI_MASKABLE_GPE_MAX	0x100
> 
> So this is the only change that's necessary AFAICS.
> 
>>  static DECLARE_BITMAP(acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) __initdata;
>>
>>  static int __init acpi_gpe_set_masked_gpes(char *val)
>>  {
>> -	u8 gpe;
>> +	u32 gpe;
>>
>> -	if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
> 
> And here you can drop the ACPI_MASKABLE_GPE_MAX check and the rest can remain
> as is.
> 
I will modify as your suggestion, thanks.

>> +	if (kstrtouint(val, 0, &gpe) || gpe >= ACPI_MASKABLE_GPE_MAX)
>>  		return -EINVAL;
>>  	set_bit(gpe, acpi_masked_gpes_map);
>>
>> @@ -838,7 +838,7 @@ void __init acpi_gpe_apply_masked_gpes(void)
>>  {
>>  	acpi_handle handle;
>>  	acpi_status status;
>> -	u8 gpe;
>> +	u32 gpe;
>>
>>  	for_each_set_bit(gpe, acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) {
>>  		status = acpi_get_gpe_device(gpe, &handle);
>>
> 
> 
> 
> 
> 
> .
> 

