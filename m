Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A52A319276C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 12:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYLns (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 07:43:48 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2595 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbgCYLns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Mar 2020 07:43:48 -0400
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F1F2032D53CE5C896598;
        Wed, 25 Mar 2020 11:43:46 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 25 Mar 2020 11:43:46 +0000
Received: from [127.0.0.1] (10.210.165.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 25 Mar
 2020 11:43:45 +0000
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
 <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
 <4a28fd33-9f48-c771-a5b1-0cbf263bca6a@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com>
Date:   Wed, 25 Mar 2020 11:43:31 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <4a28fd33-9f48-c771-a5b1-0cbf263bca6a@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.165.24]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>>>
>>>> If not, at least make the user know of potential deficiencies in the 
>>>> table.
>>>>
>>>
>>> How ? What are your suggestions ? Does adding a warning or note that UID
>>> is missing and offset is chosen help ? 
>>
>> I'd say so. I know now, but let's save others the potential hassle. 
>> And having this debate again.
>>
>> I am kind of fine with that.
>>
>> How about something like this:
>>
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
>> acpi_table_header *table,
>>    if (level == 0 || cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>>      return cpu_node->acpi_processor_id;
>> +   if (level == PPTT_ABORT_PACKAGE)
>> +    pr_warn_once("ACPI Processor ID valid not set for physical 
>> package node, will use node table offset as substitute for UID\n");
> 
> Level will probably never be PPTT_ABORT_PACKAGE, so.. you probably have 
> to have the warning higher up when it terminates the package search.
> 
> OTOH, just because this is set doesn't mean you get "nice" ids. I've had 
> complaints, because there is a firmware floating around which uses the 
> MPIDR value as the processor_id, so the cores come out with really weird 
> numbers too.
> 

JFYI, we got this working now (PPTT has proper physical package ID):

root@(none)$ pwd
/sys/devices/system/cpu/cpu0/topology
root@(none)$ more package_cpus_list
0-63
root@(none)$ more physical_package_id
0
root@(none)$ cd ../../cpu64/topology
root@(none)$ more package_cpus_list
64-127
root@(none)$ more physical_package_id
1
root@(none)$

We'll share the FW tables when ready, so you can check what we have done.

BTW, I still think that we can look to add the warning message when 
physical processor package id valid is not set

Cheers,
John

> 
> 
>>                  return ACPI_PTR_DIFF(cpu_node, table);
>>          }
>>          pr_warn_once("PPTT table found, but unable to locate core %d 
>> (%d)\n",
>>
>> Thanks,
>> John
> 
> .

