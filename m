Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80D315BE07
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgBMLwM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 06:52:12 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2421 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgBMLwM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Feb 2020 06:52:12 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 9A8F23DE5F73DE8278D2;
        Thu, 13 Feb 2020 11:52:10 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Feb 2020 11:52:10 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 13 Feb
 2020 11:52:10 +0000
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
 <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
 <bfc39a01-419a-9358-fd6d-c73fdcb9c881@huawei.com>
 <eedbafc2-019c-517f-4623-4b6ad80f5438@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b9ca7718-3834-b42d-a36e-63c81f677a78@huawei.com>
Date:   Thu, 13 Feb 2020 11:52:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <eedbafc2-019c-517f-4623-4b6ad80f5438@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/02/2020 21:12, Jeremy Linton wrote:
> Hi,
> 
> On 2/12/20 10:41 AM, John Garry wrote:
>>>>
>>>> How about something like this:
>>>>
>>>> --- a/drivers/acpi/pptt.c
>>>> +++ b/drivers/acpi/pptt.c
>>>> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
>>>> acpi_table_header *table,
>>>>    if (level == 0 || cpu_node->flags & 
>>>> ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>>>>      return cpu_node->acpi_processor_id;
>>>> +   if (level == PPTT_ABORT_PACKAGE)
>>>> +    pr_warn_once("ACPI Processor ID valid not set for physical 
>>>> package node, will use node table offset as substitute for UID\n");
>>>
>>
>> Hi Jeremy,
>>
>>> To clarify my other email there, since I can't seem to type clearly..
>>>
>>> Just note that find_acpi_cpu_topology_hetero_id() is also using a 
>>> PPTT_ABORT_PACKAGE termination.
>>
>> OK, so I may need to check the flag == ACPI_PPTT_PHYSICAL_PACKAGE also.
> 
> Without a lot of thought, it probably sufficient to only check the flag. 
> The level is mostly noise, the ==0 check in there was to work around the 
> verbiage in the first PPTT revision.
> 
>>
>> BTW, Is the value returned by find_acpi_cpu_topology_hetero_id() also  
>> > exposed to userspace some way? Or any other PPTT offsets?
> 
> Not yet :)
> 
>>
>>>
>>>
>>>>                  return ACPI_PTR_DIFF(cpu_node, table);
>>>>          }
>>>>          pr_warn_once("PPTT table found, but unable to locate core 
>>>> %d (%d)\n",
>>>>
>>
>> I'll validate Sudeep's suggestion to set the Processor ID valid flag 
>> and appropriate processor id for the physical package cpu node with an 
>> experimental firmware before sending any patch. There seems to be a 
>> bit of doubt on your part regarding that.
> 
> Just pay attention to the definition of _UID/Acpi Processor UID, etc. 
> The MADT says that ACPI processor UID is matched with a processor 
> container with a matching numeric _UID. The processor container 
> definition says that the _UID must be unique in the processor container 
> hierarchy.
> 
> To me, this says that processor containers/ACPI processors UIDs must all 
> be unique. AKA, you can't have both a processor with _UID=1 and a socket 
> with _UID=1. Given that linux isn't matching the socket _UID, you can 
> create a PPTT+DSDT that does what you want but likely violates the spec.

I've spoken to our FW guys, and they say that they do not set the ACPI 
Processor ID valid flag for non-leaf nodes as we have "no Socket, DIE, 
class information". I think that this means that there is no associated 
processor container.

So the spec reads "ACPI Processor ID entry can relate to a Processor 
container in the namespace" and "The processor container will have a 
matching ID value returned through the _UID method"; followed by "As not 
every processor hierarchy node structure in PPTT may have a matching 
processor container, this flag indicates whether the ACPI processor ID 
points to valid entry".

So I take this to mean that if the valid flag is set for a non-leaf 
cell, then the ACPI processor ID will match the UID of the associated 
processor container.

As for when it's not set, it's unclear. My understanding is that the 
ACPI processor id should still be used as the non-leaf node identifier, 
but it would not match a UID for a processor container (as it may not 
exist).

The kernel does have behave according to this.

So how I am misinterpreting this?

Thanks,
John
