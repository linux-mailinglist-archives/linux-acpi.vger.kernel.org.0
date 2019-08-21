Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A9797A92
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2019 15:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfHUNUW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Aug 2019 09:20:22 -0400
Received: from foss.arm.com ([217.140.110.172]:57504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfHUNUW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Aug 2019 09:20:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84568337;
        Wed, 21 Aug 2019 06:20:21 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8ED3F706;
        Wed, 21 Aug 2019 06:20:21 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
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
References: <20190808204007.30110-1-jeremy.linton@arm.com>
 <20190808204007.30110-2-jeremy.linton@arm.com>
 <20190808222518.5q4fhd2tvs4lb6aw@rric.localdomain>
 <CAJZ5v0imn0X=M38LJcwe76gfLafWGU+MgyGd=NuKAeDtNZ+1DQ@mail.gmail.com>
 <20190812115907.kugk57jvv3g2r66a@willie-the-truck>
 <a2960c68-d422-3cdb-4354-6f357433ad6c@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <72ee16ea-1038-37a1-25b1-f28b5c6b6edb@arm.com>
Date:   Wed, 21 Aug 2019 08:20:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a2960c68-d422-3cdb-4354-6f357433ad6c@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/20/19 4:01 AM, John Garry wrote:
> On 12/08/2019 12:59, Will Deacon wrote:
>> On Mon, Aug 12, 2019 at 11:06:07AM +0200, Rafael J. Wysocki wrote:
>>> On Fri, Aug 9, 2019 at 12:25 AM Robert Richter <rrichter@marvell.com> 
>>> wrote:
>>>>
>>>> On 08.08.19 15:40:06, Jeremy Linton wrote:
>>>>> ACPI 6.3 adds a flag to the CPU node to indicate whether
>>>>> the given PE is a thread. Add a function to return that
>>>>> information for a given linux logical CPU.
>>>>>
>>>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>> ---
>>>>>  drivers/acpi/pptt.c  | 53 
>>>>> +++++++++++++++++++++++++++++++++++++++++++-
>>>>>  include/linux/acpi.h |  5 +++++
>>>>>  2 files changed, 57 insertions(+), 1 deletion(-)
>>>>
>>>> Reviewed-by: Robert Richter <rrichter@marvell.com>
>>>
>>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> and please push it through ARM64 along with the second patch.
>>
>> Thanks. I'll push these into -next shortly.
> 
> 
> Hi Jeremy,
> 
> We're considering requesting this support is backported to stable. We 
> have a platform which incorrectly sets the MT bit. To update our 
> firmware to PPTT v2, we need the kernel to support PPTT v2 also.
> 
> Please let me know if you anticipate an issue in this.

No I don't see any issues with that once it lands.

I believe the ball is rolling in the case of some older distro kernel's 
as well.

Thanks,
