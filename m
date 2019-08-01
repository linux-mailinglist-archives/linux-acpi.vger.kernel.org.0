Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8307DFCC
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2019 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfHAQKh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Aug 2019 12:10:37 -0400
Received: from foss.arm.com ([217.140.110.172]:38588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfHAQKh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Aug 2019 12:10:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D029337;
        Thu,  1 Aug 2019 09:10:36 -0700 (PDT)
Received: from [192.168.122.164] (u201426.austin.arm.com [10.118.28.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31E693F694;
        Thu,  1 Aug 2019 09:10:36 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     lorenzo.pieralisi@arm.com, catalin.marinas@arm.com,
        rjw@rjwysocki.net, linux-acpi@vger.kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, lenb@kernel.org
References: <20190801034634.26913-1-jeremy.linton@arm.com>
 <20190801034634.26913-2-jeremy.linton@arm.com>
 <20190801155736.GD23424@e107155-lin>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <959c5297-a563-21b6-c38b-0cc50ffbce8b@arm.com>
Date:   Thu, 1 Aug 2019 11:10:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190801155736.GD23424@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


Thanks for looking at this.

On 8/1/19 10:57 AM, Sudeep Holla wrote:
> 
> Hi Jeremy,
> 
> On Wed, Jul 31, 2019 at 10:46:33PM -0500, Jeremy Linton wrote:
>> ACPI 6.3 adds a flag to the CPU node to indicate whether
>> the given PE is a thread. Add a function to return that
>> information for a given linux logical CPU.
>>
> 
> Apart from few minor nits,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> 
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pptt.c  | 54 +++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/acpi.h |  5 ++++
>>   2 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 1e7ac0bd0d3a..84718f6cb741 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -540,6 +540,44 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>>   	return retval;
>>   }
>>
>> +/**
>> + * check_acpi_cpu_flag() - Determine if CPU node has a flag set
>> + * @cpu: Kernel logical CPU number
>> + * @rev: The PPTT revision defining the flag
> 
> [nit] I would rather put it as minimum PPTT revision that supports the
> flag. It aligns with the code too as we are not looking for exact match.

Ok, sure.


> 
>> + * @flag: The flag itself
>> + *
>> + * Check the node representing a CPU for a given flag.
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
>> + *	   the table revision isn't new enough.
>> + *	   1, any passed flag set
>> + *	   0, flag unset
>> + */
>> +static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>> +{
>> +	struct acpi_table_header *table;
>> +	acpi_status status;
>> +	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +	struct acpi_pptt_processor *cpu_node = NULL;
>> +	int ret = -ENOENT;
>> +
>> +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>> +	if (ACPI_FAILURE(status)) {
>> +		acpi_pptt_warn_missing();
>> +		return ret;
>> +	}
>> +
>> +	if (table->revision >= rev)
>> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>> +
>> +	if (cpu_node)
>> +		ret = (cpu_node->flags & flag) != 0;
>> +
>> +	acpi_put_table(table);
>> +
>> +	return ret;
>> +}
>> +
>>   /**
>>    * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
>>    * @cpu: Kernel logical CPU number
>> @@ -604,6 +642,21 @@ int cache_setup_acpi(unsigned int cpu)
>>   	return status;
>>   }
>>
>> +/**
>> + * acpi_pptt_cpu_is_thread() - Determine if CPU is a thread
>> + * @cpu: Kernel logical CPU number
>> + *
> 
> [nit] If you spin the patch again, you can drop extra line space here.

Sure..


> 
> --
> Regards,
> Sudeep
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

