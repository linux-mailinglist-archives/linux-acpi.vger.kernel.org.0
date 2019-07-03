Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE215E785
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2019 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfGCPLx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Jul 2019 11:11:53 -0400
Received: from foss.arm.com ([217.140.110.172]:50472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfGCPLx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Jul 2019 11:11:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61CFE2B;
        Wed,  3 Jul 2019 08:11:52 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDA253F718;
        Wed,  3 Jul 2019 08:11:51 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20190628181457.6609-1-jeremy.linton@arm.com>
 <20190628181457.6609-2-jeremy.linton@arm.com>
 <CAJZ5v0jh0+WU5fpd9enq0UHrHzh+0Sgv-xoRiJM3jgu9dQFvdw@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1745d9ee-a4e0-9a6f-138c-c0d5b42b5281@arm.com>
Date:   Wed, 3 Jul 2019 10:11:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jh0+WU5fpd9enq0UHrHzh+0Sgv-xoRiJM3jgu9dQFvdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thanks for taking a look at this.

On 7/3/19 4:24 AM, Rafael J. Wysocki wrote:
> On Fri, Jun 28, 2019 at 8:15 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> ACPI 6.3 adds a flag to the CPU node to indicate whether
>> the given PE is a thread. Add a function to return that
>> information for a given linux logical CPU.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pptt.c  | 62 +++++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/acpi.h |  5 ++++
>>   2 files changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index b72e6afaa8fb..bb6196422fad 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -517,6 +517,52 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>>          return retval;
>>   }
>>
>> +/**
>> + * check_acpi_cpu_flag() - Determine if CPU node has a flag set
>> + * @cpu: Kernel logical CPU number
>> + * @rev: The PPTT revision defining the flag
>> + * @flag: The flag itself
>> + *
>> + * Check the node representing a CPU for a given flag.
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
>> + *        the table revision isn't new enough.
>> + *        1, any passed flag set
>> + *        0, flag unset
>> + */
>> +static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
> 
> Why not bool?

At least for the thread flag we need the three states so that we can 
fall back to the CPU's description of itself on machines without ACPI 
6.3 tables.

The ThunderX2 is threaded and without a firmware update a change like 
this will break it.

> 
>> +{
>> +       struct acpi_table_header *table;
>> +       acpi_status status;
>> +       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +       struct acpi_pptt_processor *cpu_node = NULL;
>> +       int ret = -ENOENT;
>> +       static int saved_pptt_rev = -1;
>> +
>> +       /* Cache the PPTT revision to avoid repeat table get/put on failure */
> 
> This is a rather questionable optimization.
> 
> Does the extra table get/put really matter?

AFAIK, Probably not.

> 
>> +       if (saved_pptt_rev > -1 && saved_pptt_rev < rev)
>> +               return -ENOENT;
> 
> It should be fine to return 'false' here, shouldn't it?

See bool, The alternative of course is a dedicated function to export 
this "error" but I think we want to avoid exporting what is effectively 
a version check into the reset of the kernel.

> 
>> +
>> +       status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
>> +       if (ACPI_FAILURE(status)) {
>> +               saved_pptt_rev = 0;
>> +               acpi_pptt_warn_missing();
>> +               return ret;
> 
> And here?
> 
>> +       }
>> +
>> +       saved_pptt_rev = table->revision;
>> +
>> +       if (saved_pptt_rev >= rev)
>> +               cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>> +
>> +       if (cpu_node)
>> +               ret = (cpu_node->flags & flag) != 0;
> 
> And this can be
> 
> ret = !!(cpu_node->flags & flag);

Ok, sure.


> 
>> +
>> +       acpi_put_table(table);
>> +
>> +       return ret;
>> +}
>> +
>>   /**
>>    * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
>>    * @cpu: Kernel logical CPU number
>> @@ -581,6 +627,21 @@ int cache_setup_acpi(unsigned int cpu)
>>          return status;
>>   }
>>
>> +/**
>> + * acpi_pptt_cpu_is_thread() - Determine if CPU is a thread
>> + * @cpu: Kernel logical CPU number
>> + *
>> + *
>> + * Return: 1, a thread
>> + *         0, not a thread
>> + *         -ENOENT ,if the PPTT doesn't exist, the CPU cannot be found or
>> + *         the table revision isn't new enough.
>> + */
>> +int acpi_pptt_cpu_is_thread(unsigned int cpu)
>> +{
>> +       return check_acpi_cpu_flag(cpu, 2, ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD);
>> +}
>> +
>>   /**
>>    * find_acpi_cpu_topology() - Determine a unique topology value for a given CPU
>>    * @cpu: Kernel logical CPU number
>> @@ -641,7 +702,6 @@ int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>>          return ret;
>>   }
>>
>> -
>>   /**
>>    * find_acpi_cpu_topology_package() - Determine a unique CPU package value
>>    * @cpu: Kernel logical CPU number
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index d315d86844e4..3e339375e213 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1301,10 +1301,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
>>   #endif
>>
>>   #ifdef CONFIG_ACPI_PPTT
>> +int acpi_pptt_cpu_is_thread(unsigned int cpu);
>>   int find_acpi_cpu_topology(unsigned int cpu, int level);
>>   int find_acpi_cpu_topology_package(unsigned int cpu);
>>   int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>>   #else
>> +static inline int acpi_pptt_cpu_is_thread(unsigned int cpu)
>> +{
>> +       return -EINVAL;
>> +}
>>   static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
>>   {
>>          return -EINVAL;
>> --
>> 2.21.0
>>

