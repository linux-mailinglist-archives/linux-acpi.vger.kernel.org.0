Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77BA1B48D
	for <lists+linux-acpi@lfdr.de>; Mon, 13 May 2019 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfEMLMI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 May 2019 07:12:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728713AbfEMLMH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 May 2019 07:12:07 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2AE843B18879504E3740;
        Mon, 13 May 2019 19:12:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 May 2019
 19:11:57 +0800
Subject: Re: [PATCH v3 0/5] arm64: SPE ACPI enablement
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <catalin.marinas@arm.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, Hongbo Yao <yaohongbo@huawei.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
 <82032e5b-0cb5-e48f-ab51-ba5d5f9dceec@arm.com>
 <819de863-92ff-51c5-9c35-880db4f6a922@huawei.com>
 <20190508165149.GB21553@e107155-lin> <20190509092810.GC2667@brain-police>
 <20190509103559.GB8239@e107155-lin>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <c70b242a-9c6c-aaee-d60a-1114d9bfb666@huawei.com>
Date:   Mon, 13 May 2019 19:10:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190509103559.GB8239@e107155-lin>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/5/9 18:35, Sudeep Holla wrote:
> On Thu, May 09, 2019 at 10:28:11AM +0100, Will Deacon wrote:
>> On Wed, May 08, 2019 at 05:51:49PM +0100, Sudeep Holla wrote:
>>> On Wed, May 08, 2019 at 05:35:51PM +0800, Hanjun Guo wrote:
[...]
>>>>>>
>>>>>> Adding this patch set on top of latest mainline kernel,
>>>>>> and tested on D06 which has the SPE feature, in boot message
>>>>>> shows it was probed successfully:
>>>>>>
>>>>>> arm_spe_pmu arm,spe-v1: probed for CPUs 0-95 [max_record_sz 128, align 4, features 0x7]
>>>>>>
>>>>>> but when I test it with spe events such as
>>>>>>
>>>>>> perf record -c 1024 -e arm_spe_0/branch_filter=0/ -o spe ls
>>>>>>
>>>>>> it fails with:
>>>>>> failed to mmap with 12 (Cannot allocate memory),
>>>>>>
>>>>>> Confirmed that patch [0] is merged and other perf events are working
>>>>>> fine.
>>>>>
>>>>> Its pretty easy to get into the weeds with this driver, does it work with examples like:
>>>>>
>>>>> https://lkml.org/lkml/2018/1/14/122
>>>>
>>>> No, not work at all.
>>>>
>>>> SPE works on 5.0, but not work after 5.1-rc1, bisected to this commit:
>>>>
>>>> 5768402fd9c6 perf/ring_buffer: Use high order allocations for AUX buffers optimistically
>>>>
>>>
>>> Indeed this patch breaks SPE. As mentioned in the patch, it uses high
>>> order allocations for AUX buffers and SPE PMU setup_aux explicitly
>>> fails with the warning "unexpected high-order page for auxbuf!" if
>>> it encounters one.
>>>
>>> I don't know the intention of that check in SPE. Will ?
>>
>> Since SPE uses virtual addressing, we don't really care about the underlying
>> page layout so there's no need to use higher-order allocations. I suppose we
>> could theoretically map them at the pmd level in some cases, but ignoring
>> them should also be harmless and I suspect you can delete the check.
>>
> 
> Yes, I did a quick look to see if we can do that, but couldn't find a clue.
> Not sure if that's any optimisation, we can use order from page_private
> and set the values accordingly ?
> 
>> Does the patch below fix the problem?
>>
> 
> Yes it should help, I tried exactly the same thing yesterday and it does
> fix the issue.

Works for me too, thank you Sudeep and Will for looking into this issue.

Best Regards
Hanjun

