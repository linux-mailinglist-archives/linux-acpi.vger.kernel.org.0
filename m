Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A479097AA4
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2019 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfHUNZk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Aug 2019 09:25:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728007AbfHUNZk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Aug 2019 09:25:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DCD092B94FEB0D757D6D;
        Wed, 21 Aug 2019 21:25:38 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 21 Aug 2019
 21:25:30 +0800
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190808204007.30110-1-jeremy.linton@arm.com>
 <20190808204007.30110-2-jeremy.linton@arm.com>
 <20190808222518.5q4fhd2tvs4lb6aw@rric.localdomain>
 <CAJZ5v0imn0X=M38LJcwe76gfLafWGU+MgyGd=NuKAeDtNZ+1DQ@mail.gmail.com>
 <20190812115907.kugk57jvv3g2r66a@willie-the-truck>
 <a2960c68-d422-3cdb-4354-6f357433ad6c@huawei.com>
 <72ee16ea-1038-37a1-25b1-f28b5c6b6edb@arm.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <896bb13c-c2fc-ab17-6a98-bddfb041b36e@huawei.com>
Date:   Wed, 21 Aug 2019 14:25:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <72ee16ea-1038-37a1-25b1-f28b5c6b6edb@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 21/08/2019 14:20, Jeremy Linton wrote:
> Hi,
>
> On 8/20/19 4:01 AM, John Garry wrote:
>> On 12/08/2019 12:59, Will Deacon wrote:
>>> On Mon, Aug 12, 2019 at 11:06:07AM +0200, Rafael J. Wysocki wrote:
>>>> On Fri, Aug 9, 2019 at 12:25 AM Robert Richter
>>>> <rrichter@marvell.com> wrote:
>>>>>
>>>>> On 08.08.19 15:40:06, Jeremy Linton wrote:
>>>>>> ACPI 6.3 adds a flag to the CPU node to indicate whether
>>>>>> the given PE is a thread. Add a function to return that
>>>>>> information for a given linux logical CPU.
>>>>>>
>>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>>> ---
>>>>>>  drivers/acpi/pptt.c  | 53
>>>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>>>  include/linux/acpi.h |  5 +++++
>>>>>>  2 files changed, 57 insertions(+), 1 deletion(-)
>>>>>
>>>>> Reviewed-by: Robert Richter <rrichter@marvell.com>
>>>>
>>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> and please push it through ARM64 along with the second patch.
>>>
>>> Thanks. I'll push these into -next shortly.
>>
>>
>> Hi Jeremy,
>>
>> We're considering requesting this support is backported to stable. We
>> have a platform which incorrectly sets the MT bit. To update our
>> firmware to PPTT v2, we need the kernel to support PPTT v2 also.
>>
>> Please let me know if you anticipate an issue in this.
>
> No I don't see any issues with that once it lands.
>
> I believe the ball is rolling in the case of some older distro kernel's
> as well.

Cool.

Cheers,
John

>
> Thanks,
>
> .
>


