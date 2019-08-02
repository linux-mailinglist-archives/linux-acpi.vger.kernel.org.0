Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845DE7FE10
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2019 18:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbfHBQFC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Aug 2019 12:05:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbfHBQFB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 2 Aug 2019 12:05:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C09515A2;
        Fri,  2 Aug 2019 09:05:00 -0700 (PDT)
Received: from [192.168.122.164] (U201426.austin.arm.com [10.118.28.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5C13F575;
        Fri,  2 Aug 2019 09:05:00 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] arm64: topology: Use PPTT to determine if PE is a
 thread
To:     Robert Richter <rric@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, rjw@rjwysocki.net,
        linux-acpi@vger.kernel.org, sudeep.holla@arm.com, will@kernel.org,
        lenb@kernel.org
References: <20190801034634.26913-1-jeremy.linton@arm.com>
 <20190801034634.26913-3-jeremy.linton@arm.com>
 <20190802134427.dmclik66zcgxapy3@rric.localdomain>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <f481feb9-faa9-ca7f-89b9-e23141129561@arm.com>
Date:   Fri, 2 Aug 2019 11:04:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190802134427.dmclik66zcgxapy3@rric.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


On 8/2/19 8:44 AM, Robert Richter wrote:
> On 31.07.19 22:46:34, Jeremy Linton wrote:
> 
>> @@ -358,6 +356,10 @@ static int __init parse_acpi_topology(void)
>>   		if (topology_id < 0)
>>   			return topology_id;
>>   
>> +		is_threaded = acpi_pptt_cpu_is_thread(cpu);
>> +		if (is_threaded < 0)
>> +			is_threaded = read_cpuid_mpidr() & MPIDR_MT_BITMASK;
>> +
> 
> I think the return code handling is error-prone, as in the kernel such
> functions are typically used like:
> 
> 	if (something_is_thread) { ... }

I don't really understand why this keeps getting repeated. The negative 
error code return is used by huge swaths of the kernel API. A couple 
lines up the exact same paradigm is used in get_cpu_for_node() and a few 
other places.

> 
> I see this is due to acpi and arch code separation so we cannot simply
> move the fallback to pptt code.

Right, the PPTT->arch data structure translation is arch specific. 
During the initial PPTT drop a lot of discussion when into how arm64 was 
doing that translation, as well as the corresponding translation to the 
core scheduler/etc.

> 
> So maybe we have a static function cpu_is_thread() in this file that
> handles all the logic and directly use check_acpi_cpu_flag() from
> there. However, code may change here in case of a rework as I
> suggested in patch #1. In both cases the acpi api is more straight
> then.

I'm ok with that, it effectively only moves those three lines to a 
standalone single call-site function. To be clear, that isn't a generic 
routine for anyone to call. Functions that need to know if the core is a 
threaded should be checking the topology thread_id directly rather than 
re-coding the acpi/dt/mpidr logic which populates it.


> 
> -Robert
> 
>>   		if (is_threaded) {
>>   			cpu_topology[cpu].thread_id = topology_id;
>>   			topology_id = find_acpi_cpu_topology(cpu, 1);

