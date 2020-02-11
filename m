Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7850515AC49
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgBLPod (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 10:44:33 -0500
Received: from foss.arm.com ([217.140.110.172]:34384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgBLPod (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 10:44:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FD01328;
        Wed, 12 Feb 2020 07:44:33 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081923F68F;
        Wed, 12 Feb 2020 07:44:33 -0800 (PST)
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
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
Date:   Tue, 11 Feb 2020 13:31:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/12/20 8:41 AM, John Garry wrote:
> On 12/02/2020 13:55, Sudeep Holla wrote:
>> On Wed, Feb 12, 2020 at 12:48:33PM +0000, John Garry wrote:
>>> On 12/02/2020 11:59, Sudeep Holla wrote:
>>
>> [...]
>>
> 
> Hi Sudeep,
> 
>>>> Yes, as mentioned above. We are not going to do extra work for lazy 
>>>> firmware.
>>>
>>> I don't think it's reasonable to just label this as lazy. The table 
>>> may just
>>> not have the flag set unintentionally. FW and software guys make 
>>> mistakes,
>>> like the mistakes in PPTT, itself.
>>>
>>
>> We are not talking about flags, it's UID and it is pretty important if
>> there are more than one objects of same time.
>>
> 
> I am talking about the Processor ID valid flag, which is specifically 
> related.
> 
>>>> Linux also will be lazy on such platform and provide weird unique 
>>>> numbers
>>>> like in the above case you have mentioned.
>>>
>>> Personally I think that the kernel can be do better than provide 
>>> meaningless
>>> values like this, since it knows the processor IDs and which physical
>>> package they belong to.
>>>
>>
>> This was discussed quite a lot, I can dig and point you to it. That's the
>> reason for choosing offset. We are *not going back* to this again. Fix 
>> the
>> firmware before it gets copied for all future platforms and Linux has to
>> deal with that *forever*.
> 
> I would liked to have been made aware earlier of the oversight. Quite 
> often we only find problems when someone or something complains.
> 
> It is a strange API to provide offsets like this, and I did not realize 
> that they were actually being exposed to userspace.
> 
>>
>>> If not, at least make the user know of potential deficiencies in the 
>>> table.
>>>
>>
>> How ? What are your suggestions ? Does adding a warning or note that UID
>> is missing and offset is chosen help ? 
> 
> I'd say so. I know now, but let's save others the potential hassle. And 
> having this debate again.
> 
> I am kind of fine with that.
> 
> How about something like this:
> 
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
> acpi_table_header *table,
>    if (level == 0 || cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>      return cpu_node->acpi_processor_id;
> +   if (level == PPTT_ABORT_PACKAGE)
> +    pr_warn_once("ACPI Processor ID valid not set for physical package 
> node, will use node table offset as substitute for UID\n");

To clarify my other email there, since I can't seem to type clearly..

Just note that find_acpi_cpu_topology_hetero_id() is also using a 
PPTT_ABORT_PACKAGE termination.


>                  return ACPI_PTR_DIFF(cpu_node, table);
>          }
>          pr_warn_once("PPTT table found, but unable to locate core %d 
> (%d)\n",
> 
> Thanks,
> John

