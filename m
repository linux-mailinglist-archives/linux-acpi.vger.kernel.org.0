Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3225A19C4CA
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbgDBOwH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 10:52:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732598AbgDBOwH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Apr 2020 10:52:07 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 57434B94BE28AFBA3846;
        Thu,  2 Apr 2020 15:52:05 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.242) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Apr 2020
 15:52:03 +0100
Subject: Re: [PATCH] ACPI: PPTT: Inform user that table offset used for
 Physical processor node ID
To:     Jeremy Linton <jeremy.linton@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <linuxarm@huawei.com>,
        <wanghuiqiang@huawei.com>
References: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
 <89f68a3c-264a-5d1b-e63a-d1147ea07320@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0244dcc3-6006-2a67-e861-d2bcce4360f6@huawei.com>
Date:   Thu, 2 Apr 2020 15:51:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <89f68a3c-264a-5d1b-e63a-d1147ea07320@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.6.242]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02/04/2020 14:55, Jeremy Linton wrote:
> Hi,
> 
> On 4/2/20 7:22 AM, John Garry wrote:
>> If the the Processor ID valid is not set for a Physical Processor Package
>> node, then the node table offset is used as a substitute. As such, we
>> may get info like this from sysfs:
>>
>> root@(none)$ pwd
>> /sys/devices/system/cpu/cpu0/topology
>> root@(none)$ more physical_package_id
>> 56
>>
>> Inform the user of this in the bootlog, as it is much less than ideal, 
>> and
>> they can remedy this in their FW.
>>
>> This topic was originally discussed in:
>> https://lore.kernel.org/linux-acpi/c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com/T/#m0ec18637d8586f832084a8a6af22580e6174669a 
>>
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 4ae93350b70d..b4ed3c818e00 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
>> acpi_table_header *table,
>>           if (level == 0 ||
>>               cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>>               return cpu_node->acpi_processor_id;
>> +        if (level == PPTT_ABORT_PACKAGE)
>> +            pr_notice_once("Physical package node Processor ID valid 
>> not set, will use table offset as substitute\n");

Hi Jeremy,

> 
> What happens in the find_acpi_cpu_topology_hetro_id() case, if the last 
> IDENTICAL node isn't a socket/etc. Are we expecting to warn of a missing 
> processor container there as well?

ok, I could just use this then:

if (flags & ACPI_PPTT_PHYSCIAL_PACKAGE)
	pr_notice_once("Physical package node Processor ID ...")

As I recall, this tag for hetro id is not exposed to userspace (yet).

Thanks,
John
