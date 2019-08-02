Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02DC7FDA8
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388182AbfHBPgs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 11:36:48 -0400
Received: from foss.arm.com ([217.140.110.172]:54120 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732454AbfHBPgr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Aug 2019 11:36:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8FEB1596;
        Fri,  2 Aug 2019 08:36:46 -0700 (PDT)
Received: from [192.168.122.164] (U201426.austin.arm.com [10.118.28.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27293F575;
        Fri,  2 Aug 2019 08:36:46 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Robert Richter <rric@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, sudeep.holla@arm.com, will@kernel.org,
        lenb@kernel.org
References: <20190801034634.26913-1-jeremy.linton@arm.com>
 <20190801034634.26913-2-jeremy.linton@arm.com>
 <20190802130510.rd4uyndtqlcfdhtm@rric.localdomain>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <488e9444-d01e-6bf4-770c-34091a8a8244@arm.com>
Date:   Fri, 2 Aug 2019 10:36:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190802130510.rd4uyndtqlcfdhtm@rric.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thanks for taking a look at this.

On 8/2/19 8:05 AM, Robert Richter wrote:
> On 31.07.19 22:46:33, Jeremy Linton wrote:
> 
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 9426b9aaed86..9d0e20a2ac83 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1302,11 +1302,16 @@ static inline int lpit_read_residency_count_address(u64 *address)
>>   #endif
>>   
>>   #ifdef CONFIG_ACPI_PPTT
>> +int acpi_pptt_cpu_is_thread(unsigned int cpu);
>>   int find_acpi_cpu_topology(unsigned int cpu, int level);
>>   int find_acpi_cpu_topology_package(unsigned int cpu);
>>   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>>   int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
> 
> All those functions (exept hetero_id) are used only in
> parse_acpi_topology(). So how about creating a struct with thread_id,
> core_id, and cache_id (and hetero_id (?)) and have a single pptt table
> parsing function that fills in all of this into that struct? This
> simplifies the api and also the code.
> 
> This also shows that hetid (see arm_pmu_acpi.c) better should be
> stored in cpu_topology[] too and thus being parsed with the other
> parameters as well and made accessible from there by a helper.


I think the idea here was to avoid an additional set of intermediate 
data structures between the PPTT table/structure and the final arch 
specific data structures (which themselves are used to feed other 
things, like the scheduler, note the llc parsing). Rather the attempt is 
to provide a set of tools to retrieve information and let the policy for 
how that information is used be dictated by the consumer.

In the future, if we can further unify the arch specific cpu_topology 
structures it would make sense to parse directly into them, but until 
that happens I don't think we should try. The existing code does parse 
directly into the cache structures, but the cpu topology is subtly arm64 
at the moment. If another arch decided to use this, i'm not sure they 
would want or need it parsed in exactly the same way.

