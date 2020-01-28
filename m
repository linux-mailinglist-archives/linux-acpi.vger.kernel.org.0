Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E643314BD5F
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 16:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA1P7U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 10:59:20 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbgA1P7T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 10:59:19 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E78718A7A67860777529;
        Tue, 28 Jan 2020 15:59:16 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 15:59:16 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 15:59:16 +0000
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <jeremy.linton@arm.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <20200128152040.GC47557@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ff2ebe43-639d-085b-d043-55c402513390@huawei.com>
Date:   Tue, 28 Jan 2020 15:59:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200128152040.GC47557@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28/01/2020 15:20, Sudeep Holla wrote:
> (commenting on other parts though I am not sure if we want to add this
> despite it being deprecated)
> 
> On Tue, Jan 28, 2020 at 07:14:19PM +0800, John Garry wrote:
>> Add a generic driver for platforms which populate their ACPI PPTT
>> processor package ID Type Structure according to suggestion in the ACPI
>> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
>>
>> The soc_id is from member LEVEL_2_ID.
>>
>> For this, we need to use a whitelist of platforms which are known to
>> populate the structure as suggested.
>>
>> For now, only the vendor and soc_id fields are exposed.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>> ---
>>   drivers/soc/Makefile       |   1 +
>>   drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 103 insertions(+)
>>   create mode 100644 drivers/soc/acpi_generic.c
>>
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>> index 8b49d782a1ab..2a59a30a22cd 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -3,6 +3,7 @@
>>   # Makefile for the Linux Kernel SOC specific device drivers.
>>   #
>>
>> +obj-$(CONFIG_ACPI_PPTT)		+= acpi_generic.o
>>   obj-$(CONFIG_ARCH_ACTIONS)	+= actions/
>>   obj-$(CONFIG_SOC_ASPEED)	+= aspeed/
>>   obj-$(CONFIG_ARCH_AT91)		+= atmel/
>> diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
>> new file mode 100644
>> index 000000000000..34a1f5f8e063
>> --- /dev/null
>> +++ b/drivers/soc/acpi_generic.c
>> @@ -0,0 +1,102 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) John Garry,john.garry@huawei.com
>> + */
>> +
>> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/sys_soc.h>
>> +
>> +/*
>> + * Known platforms that fill in PPTT package ID structures according to
>> + * ACPI spec examples, that being:
>> + * - Custom driver attribute is in ID Type Structure VENDOR_ID member
>> + * - SoC id is in ID Type Structure LEVEL_2_ID member
>> + *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
>> + */
>> +static struct acpi_platform_list plat_list[] = {
>> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},

Hi Sudeep,

> What do you want to match this ? The same silicon can end up with
> different OEMs and this list just blows up soon for single SoC if
> used by different OEM/ODMs. I assume we get all the required info
> from the Type 2 table entry and hence can just rely on that. If
> PPTT has type 2 entry, just initialise this soc driver and expose
> the relevant information from the table entry.

As before, the LEVEL_1_ID and LEVEL_2_ID table members are too open to 
interpretation in the spec to generate a consistent form soc_id and 
family_id for all platforms.

As such, I was trying to limit to known PPTT implementations and how 
they should be interpreted. Obviously that's *far* from ideal.

So what's your idea? Just always put LEVEL_1_ID and LEVEL_2_ID in soc 
driver family_id and soc_id fields, respectively?

Thanks,
John
