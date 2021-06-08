Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF439F215
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 11:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFHJRG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 05:17:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8087 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhFHJRD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 05:17:03 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzkyn11srzYrlr;
        Tue,  8 Jun 2021 17:12:17 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 17:15:06 +0800
Received: from [127.0.0.1] (10.40.192.162) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 17:15:05 +0800
Subject: Re: [PATCH v5] ACPI / APEI: fix the regression of synchronous
 external aborts occur in user-mode
To:     James Morse <james.morse@arm.com>, <rafael@kernel.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <tony.luck@intel.com>,
        <bp@alien8.de>, <akpm@linux-foundation.org>, <jroedel@suse.de>,
        <peterz@infradead.org>
References: <1607602177-1507-1-git-send-email-tanxiaofei@huawei.com>
 <d57d786c-f9cb-46ba-78d0-3675666272f2@arm.com>
 <5b444714-aa45-517f-9595-fd5889d3c342@huawei.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <4e1416f4-7556-8885-6fa5-bdf8336ae9f6@huawei.com>
Date:   Tue, 8 Jun 2021 17:15:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <5b444714-aa45-517f-9595-fd5889d3c342@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi James,

On 2021/6/5 16:59, Xiaofei Tan wrote:
> Hi James,
>
> On 2021/6/4 22:19, James Morse wrote:

...

>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index fce7ade..0893968 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>
>>> +static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata, int sev)
>>> +{
>>> +    struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>>> +    struct cper_arm_err_info *err_info;
>>> +    bool queued = false;
>>> +    int sec_sev, i;
>>> +
>>> +    log_arm_hw_error(err);
>>> +
>>> +    sec_sev = ghes_severity(gdata->error_severity);
>>> +    if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
>>> +        return false;
>>> +
>>> +    err_info = (struct cper_arm_err_info *) (err + 1);
>>> +    for (i = 0; i < err->err_info_num; i++, err_info++) {
>>
>> err_info has a version and a length, so its expected to be made bigger at some point.
>
>
> Yes, but the table "ARM Processor Error Section" fixed the length of
> processor error information structure to fixed 32 bytes. Then the
> description of the UEFI spec need to update.
>
>> It would be better to use the length instead of 'err_info++', or at least to break out of
>> the loop if a length > sizeof(*err_info) is seen.
>>
>
> OK. Maybe check length != sizeof(*err_info) is better. I will add this.
>
>     if (err_info->length != sizeof(struct cper_arm_err_info)) {
>         pr_warn_ratelimited(FW_WARN GHES_PFX
>                     "Error info length %d is invalid\n",
>                     err_info->length);
>         break;
>     }
>

I considered this more carefully. It should be better to use the length instead of 'err_info', than
just break out. Because if we want to expand "ARM Processor Error Infomation Structure", the proper way
is just add some new member at the end of the structure. Then we have a chance to work well for the situation
of new firmware + old kernel.

>> With that:
>> Reviewed-by: James Morse <james.morse@arm.com>
>>
>>
>> The following nits would make this easier to read:
>>



>>
>
> Right.
>
>>
>> Thanks,
>>
>> James
>>
>> .
>>
>
>
> .
>

