Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 114C238B5D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2019 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfFGNPw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Jun 2019 09:15:52 -0400
Received: from foss.arm.com ([217.140.110.172]:39980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbfFGNPw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 7 Jun 2019 09:15:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51106346;
        Fri,  7 Jun 2019 06:15:51 -0700 (PDT)
Received: from [192.168.100.221] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C20FE3F96A;
        Fri,  7 Jun 2019 06:15:50 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] ACPI/PPTT: Modify node flag detection to find last
 IDENTICAL
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        linuxarm@huawei.com, john.garry@huawei.com
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <20190503232407.37195-4-jeremy.linton@arm.com>
 <20190607095353.GC2429@e107155-lin>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1db40fa0-9834-5607-ec1c-794480e5c514@arm.com>
Date:   Fri, 7 Jun 2019 08:15:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607095353.GC2429@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thanks for taking a look at this.

On 6/7/19 4:53 AM, Sudeep Holla wrote:
> On Fri, May 03, 2019 at 06:24:05PM -0500, Jeremy Linton wrote:
>> The ACPI specification implies that the IDENTICAL flag should be
>> set on all non leaf nodes where the children are identical.
>> This means that we need to be searching for the last node with
>> the identical flag set rather than the first one.
>>
>> Since this flag is also dependent on the table revision, we
>> need to add a bit of extra code to verify the table revision,
>> and the next node's state in the traversal. Since we want to
>> avoid function pointers here, lets just special case
>> the IDENTICAL flag.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pptt.c | 28 +++++++++++++++++++++++++---
>>   1 file changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 1865515297ca..456e1c0a35ae 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -432,17 +432,39 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>>   	}
>>   }
>>   
>> +static bool flag_identical(struct acpi_table_header *table_hdr,
>> +			  struct acpi_pptt_processor *cpu)
> 
> Not sure if it's email client problem, but I see quite a few mis-alignment
> with parenthesis like above one.

It looks fine in the original editor/text patch, but yes in my email 
client I see it off by one (or two/three now that i'm replying). Its a 
mix of tabs/spaces and I've seen this happen before in my email client 
due to the leading "[>+]"?


> 
>> +{
>> +	struct acpi_pptt_processor *next;
>> +
>> +	/* heterogeneous machines must use PPTT revision > 1 */
>> +	if (table_hdr->revision < 2)
>> +		return false;
>> +
>> +	/* Locate the last node in the tree with IDENTICAL set */
>> +	if (cpu->flags & ACPI_PPTT_ACPI_IDENTICAL) {
>> +		next = fetch_pptt_node(table_hdr, cpu->parent);
>> +		if (!(next && next->flags & ACPI_PPTT_ACPI_IDENTICAL))
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>   /* Passing level values greater than this will result in search termination */
>>   #define PPTT_ABORT_PACKAGE 0xFF
>>   
>> -static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
>> +static struct acpi_pptt_processor *acpi_find_processor_tag_id(struct acpi_table_header *table_hdr,
>>   								  struct acpi_pptt_processor *cpu,
>>   								  int level, int flag)
>>   {
>>   	struct acpi_pptt_processor *prev_node;
>>   
>>   	while (cpu && level) {
>> -		if (cpu->flags & flag)
>> +		if (flag == ACPI_PPTT_ACPI_IDENTICAL) {
> 
> flag_identical anyways check the flag, so I assume you can drop the above
> check.

? I think that would be a bug because then we would always be returning 
the value of the IDENTICAL flag rather than the other flags passed into 
this routine. This is the special case I think Raphael was asking for 
rather than the function pointer/callback interface.

> 
>> +			if (flag_identical(table_hdr, cpu))
>> +				break;
>> +		} else if (cpu->flags & flag)
>>   			break;
>>   		pr_debug("level %d\n", level);
>>   		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
>> @@ -480,7 +502,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>>   
>>   	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>>   	if (cpu_node) {
>> -		cpu_node = acpi_find_processor_package_id(table, cpu_node,
>> +		cpu_node = acpi_find_processor_tag_id(table, cpu_node,
>>   							  level, flag);
> 
> 
> Again misaligned, may be that's because of renaming.
> 
> --
> Regards,
> Sudeep
> 

