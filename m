Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6BC19C4F8
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbgDBOyg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 10:54:36 -0400
Received: from foss.arm.com ([217.140.110.172]:43852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388811AbgDBOyg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Apr 2020 10:54:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864DB31B;
        Thu,  2 Apr 2020 07:54:35 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 287C03F71E;
        Thu,  2 Apr 2020 07:54:35 -0700 (PDT)
Subject: Re: [PATCH] ACPI: PPTT: Inform user that table offset used for
 Physical processor node ID
To:     John Garry <john.garry@huawei.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com, linuxarm@huawei.com, wanghuiqiang@huawei.com
References: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
 <89f68a3c-264a-5d1b-e63a-d1147ea07320@arm.com>
 <0244dcc3-6006-2a67-e861-d2bcce4360f6@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ab0754b0-cb4b-dbe5-8d93-cc0df8fa4a39@arm.com>
Date:   Thu, 2 Apr 2020 09:54:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0244dcc3-6006-2a67-e861-d2bcce4360f6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/2/20 9:51 AM, John Garry wrote:
> On 02/04/2020 14:55, Jeremy Linton wrote:
>> Hi,
>>
>> On 4/2/20 7:22 AM, John Garry wrote:
>>> If the the Processor ID valid is not set for a Physical Processor 
>>> Package
>>> node, then the node table offset is used as a substitute. As such, we
>>> may get info like this from sysfs:
>>>
>>> root@(none)$ pwd
>>> /sys/devices/system/cpu/cpu0/topology
>>> root@(none)$ more physical_package_id
>>> 56
>>>
>>> Inform the user of this in the bootlog, as it is much less than 
>>> ideal, and
>>> they can remedy this in their FW.
>>>
>>> This topic was originally discussed in:
>>> https://lore.kernel.org/linux-acpi/c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com/T/#m0ec18637d8586f832084a8a6af22580e6174669a 
>>>
>>>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>
>>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>>> index 4ae93350b70d..b4ed3c818e00 100644
>>> --- a/drivers/acpi/pptt.c
>>> +++ b/drivers/acpi/pptt.c
>>> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
>>> acpi_table_header *table,
>>>           if (level == 0 ||
>>>               cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>>>               return cpu_node->acpi_processor_id;
>>> +        if (level == PPTT_ABORT_PACKAGE)
>>> +            pr_notice_once("Physical package node Processor ID valid 
>>> not set, will use table offset as substitute\n");
> 
> Hi Jeremy,
> 
>>
>> What happens in the find_acpi_cpu_topology_hetro_id() case, if the 
>> last IDENTICAL node isn't a socket/etc. Are we expecting to warn of a 
>> missing processor container there as well?
> 
> ok, I could just use this then:
> 
> if (flags & ACPI_PPTT_PHYSCIAL_PACKAGE)
>      pr_notice_once("Physical package node Processor ID ...")

I think that is a better plan.

> 
> As I recall, this tag for hetro id is not exposed to userspace (yet).

Correct.
