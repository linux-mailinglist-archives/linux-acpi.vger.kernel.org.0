Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8E415A96A
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 13:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgBLMsg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 07:48:36 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbgBLMsg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 07:48:36 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 9B87DB7AF1FFEF0F075A;
        Wed, 12 Feb 2020 12:48:34 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 12:48:33 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 12 Feb
 2020 12:48:34 +0000
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jeremy Linton <jeremy.linton@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
Date:   Wed, 12 Feb 2020 12:48:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200212115945.GA36981@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/02/2020 11:59, Sudeep Holla wrote:
> On Wed, Feb 12, 2020 at 11:20:12AM +0000, John Garry wrote:
>> Hi Jeremy,
>>

Hi Sudeep,


>> I have a question about $subject for you, since you wrote the code.
>>
>> This function returns a unique identifier for the package, but would not be
>> the logically indexed package id we would expect, like 0, 1, 2, ...
>>
> 
> Firstly, it must be physical socket number and not logical id.

That's really what I meant.

> 
>> It returns of the offset in the PPTT of the topology physical CPU node.
>>
> 
> Yes, intentionally. We don't want to generate a logical index for this.
> Simply not going to happen as we can't guarantee unique number always.
> We need to get that uniqueness from the firmware and hence the choice of
> offset. Remember that the offset is used only if firmware conveniently
> ignored all the optional properties including UID in the processor
> container representing the physical socket.
> 
>> So I may get something like this:
>>
>> john@ubuntu:~$ more
>> /sys/devices/system/cpu/cpu80/topology/physical_package_id
>> 5418
>>
> 
> Good, now the platform have a reason to fix it in the firmware if it is
> very hard to see and understand the above value.
> 
>> For sure, this does not violate the ABI in
>> Documentation/ABI/testing/sysfs-devices-system-cpu:
>>
> 
> Very good to see you are not disagreeing with that :)
> 
>> "physical_package_id: physical package id of cpu#. Typically	 corresponds to
>> a physical socket number, but the actual value is architecture and platform
>> dependent."
>>
>> Question: Is there any reason for which we cannot assign an indexed package
>> id to each package node?
>>
> 
> Yes, as mentioned above. We are not going to do extra work for lazy firmware.

I don't think it's reasonable to just label this as lazy. The table may 
just not have the flag set unintentionally. FW and software guys make 
mistakes, like the mistakes in PPTT, itself.

> Linux also will be lazy on such platform and provide weird unique numbers
> like in the above case you have mentioned.

Personally I think that the kernel can be do better than provide 
meaningless values like this, since it knows the processor IDs and which 
physical package they belong to.

If not, at least make the user know of potential deficiencies in the table.

> 
>> Some userspace tools rely on a sane meaningful package id, like perf:
>>
> 
> Good that you mention now. Time to update the firmware then.
> 
> 
> [...]
> 
>>
>> This can only deal with a socket id which fits in a byte. I'd rather not
>> change this code if possible.
>>
> 
> Agreed, add UID to the processor container, job done.
> 

Thanks,
John
