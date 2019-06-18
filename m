Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 563B74AD59
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 23:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfFRV2e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 17:28:34 -0400
Received: from foss.arm.com ([217.140.110.172]:33068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730368AbfFRV2d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 17:28:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAFCE360;
        Tue, 18 Jun 2019 14:28:32 -0700 (PDT)
Received: from [192.168.122.164] (u201426.austin.arm.com [10.118.28.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84843F718;
        Tue, 18 Jun 2019 14:28:32 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     John Garry <john.garry@huawei.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        sudeep.holla@arm.com, lenb@kernel.org
References: <20190614223158.49575-1-jeremy.linton@arm.com>
 <20190614223158.49575-2-jeremy.linton@arm.com>
 <667f95c0-5aa9-f460-a49a-e6dfefc027d8@arm.com>
 <2d1b547f-f9ee-391c-c4f3-0232a08a86bc@arm.com>
 <718438d0-8648-897a-83e8-801146a0af86@arm.com>
 <f6f7f9bb-547d-3fd3-f3f8-1d55181f63d7@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <11fb712f-b3c2-5491-89ee-ea7efb18ddd8@arm.com>
Date:   Tue, 18 Jun 2019 16:28:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f6f7f9bb-547d-3fd3-f3f8-1d55181f63d7@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/18/19 12:23 PM, John Garry wrote:
> On 18/06/2019 15:40, Valentin Schneider wrote:
>> On 18/06/2019 15:21, Jeremy Linton wrote:
>> [...]
>>>>> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be 
>>>>> found or
>>>>> + *       the table revision isn't new enough.
>>>>> + * Otherwise returns flag value
>>>>> + */
>>>>
>>>> Nit: strictly speaking we're not returning the flag value but its mask
>>>> applied to the flags field. I don't think anyone will care about 
>>>> getting
>>>> the actual flag value, but it should be made obvious in the doc:
>>>
>>> Or I clarify the code to actually do what the comments says. Maybe 
>>> that is what John G was also pointing out too?
>>>
> 
> No, I was just saying that the kernel topology can be broken without 
> this series.
> 
>>
>> Mmm I didn't find any reply from John regarding this in v1, but I 
>> wouldn't
>> mind either way, as long as the doc & code are aligned.
>>
> 
> BTW, to me, function acpi_pptt_cpu_is_thread() seems to try to do too 
> much, i.e. check if the PPTT is new enough to support the thread flag 
> and also check if it is set for a specific cpu. I'd consider separate 
> functions here.

? Your suggesting replacing the


if (table->revision >= rev)
	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);

check with

if (revision_check(table, rev))
	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);


and a function like

static int revision_check(acpixxxx *table, int rev)
{
	return (table->revision >= rev);
}

Although, frankly if one were to do this, it should probably be a macro 
with the table type, and used in the dozen or so other places I found 
doing similar checks (spcr, iort, etc).

Or something else?




> 
> thanks,
> John
> 
>> [...]
>>
>> .
>>
> 
> 

