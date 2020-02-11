Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5E15AE95
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBLRRr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 12:17:47 -0500
Received: from foss.arm.com ([217.140.110.172]:35622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLRRq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 12:17:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F7330E;
        Wed, 12 Feb 2020 09:17:46 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DB953F68F;
        Wed, 12 Feb 2020 09:17:46 -0800 (PST)
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     John Garry <john.garry@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
 <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
 <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
 <bfc39a01-419a-9358-fd6d-c73fdcb9c881@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <eedbafc2-019c-517f-4623-4b6ad80f5438@arm.com>
Date:   Tue, 11 Feb 2020 15:12:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bfc39a01-419a-9358-fd6d-c73fdcb9c881@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/12/20 10:41 AM, John Garry wrote:
>>>
>>> How about something like this:
>>>
>>> --- a/drivers/acpi/pptt.c
>>> +++ b/drivers/acpi/pptt.c
>>> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
>>> acpi_table_header *table,
>>>    if (level == 0 || cpu_node->flags & 
>>> ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>>>      return cpu_node->acpi_processor_id;
>>> +   if (level == PPTT_ABORT_PACKAGE)
>>> +    pr_warn_once("ACPI Processor ID valid not set for physical 
>>> package node, will use node table offset as substitute for UID\n");
>>
> 
> Hi Jeremy,
> 
>> To clarify my other email there, since I can't seem to type clearly..
>>
>> Just note that find_acpi_cpu_topology_hetero_id() is also using a 
>> PPTT_ABORT_PACKAGE termination.
> 
> OK, so I may need to check the flag == ACPI_PPTT_PHYSICAL_PACKAGE also.

Without a lot of thought, it probably sufficient to only check the flag. 
The level is mostly noise, the ==0 check in there was to work around the 
verbiage in the first PPTT revision.

> 
> BTW, Is the value returned by find_acpi_cpu_topology_hetero_id() also  > exposed to userspace some way? Or any other PPTT offsets?

Not yet :)

> 
>>
>>
>>>                  return ACPI_PTR_DIFF(cpu_node, table);
>>>          }
>>>          pr_warn_once("PPTT table found, but unable to locate core %d 
>>> (%d)\n",
>>>
> 
> I'll validate Sudeep's suggestion to set the Processor ID valid flag and 
> appropriate processor id for the physical package cpu node with an 
> experimental firmware before sending any patch. There seems to be a bit 
> of doubt on your part regarding that.

Just pay attention to the definition of _UID/Acpi Processor UID, etc. 
The MADT says that ACPI processor UID is matched with a processor 
container with a matching numeric _UID. The processor container 
definition says that the _UID must be unique in the processor container 
hierarchy.

To me, this says that processor containers/ACPI processors UIDs must all 
be unique. AKA, you can't have both a processor with _UID=1 and a socket 
with _UID=1. Given that linux isn't matching the socket _UID, you can 
create a PPTT+DSDT that does what you want but likely violates the spec.


