Return-Path: <linux-acpi+bounces-811-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A07D1420
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211691C20F66
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851A41EA66
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFE1DA32
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 16:05:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA8521BCA;
	Fri, 20 Oct 2023 09:05:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11851143D;
	Fri, 20 Oct 2023 09:06:29 -0700 (PDT)
Received: from [192.168.1.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2C63F5A1;
	Fri, 20 Oct 2023 09:05:41 -0700 (PDT)
Message-ID: <60497d6d-dfe3-4edc-9553-311fdd9c63d0@arm.com>
Date: Fri, 20 Oct 2023 18:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] cpufreq/cppc: set the frequency used for computing
 the capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 sudeep.holla@arm.com, gregkh@linuxfoundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
 lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
 ionela.voinescu@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linuxfoundation.org, conor.dooley@microchip.com,
 suagrfillet@gmail.com, ajones@ventanamicro.com, lftan@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-6-vincent.guittot@linaro.org>
 <CAJZ5v0hS7bdUv=-k4ut2Fw0LYfB7Hb1_rro7UOVTRq4=JLNchg@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAJZ5v0hS7bdUv=-k4ut2Fw0LYfB7Hb1_rro7UOVTRq4=JLNchg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Vincent,

On 10/18/23 19:26, Rafael J. Wysocki wrote:
> On Wed, Oct 18, 2023 at 6:25 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> Save the frequency associated to the performance that has been used when
>> initializing the capacity of CPUs.
>> Also, cppc cpufreq driver can register an artificial energy model. In such
>> case, it needs the frequency for this compute capacity.
>> We moved and renamed cppc_perf_to_khz and cppc_perf_to_khz to use them
>> outside cppc_cpufreq in topology_init_cpu_capacity_cppc().
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> 
> For the changes in drivers/acpi/cppc_acpi.c :
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
>> ---
>>   drivers/acpi/cppc_acpi.c       |  93 ++++++++++++++++++++++
>>   drivers/base/arch_topology.c   |  15 +++-
>>   drivers/cpufreq/cppc_cpufreq.c | 141 ++++++---------------------------
>>   include/acpi/cppc_acpi.h       |   2 +
>>   4 files changed, 133 insertions(+), 118 deletions(-)
>>

[snip]

>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 9a073c2d2086..2372ce791bb4 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -350,6 +350,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
>>   void topology_init_cpu_capacity_cppc(void)
>>   {
>>          struct cppc_perf_caps perf_caps;
>> +       u64 capacity, capacity_scale;

I think capacity_scale should be initialized to 0 here,
since it is used to find the max value of raw_capacity[cpu].

>>          int cpu;
>>
>>          if (likely(!acpi_cpc_valid()))
>> @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
>>                      (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
>>                      (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
>>                          raw_capacity[cpu] = perf_caps.highest_perf;
>> +                       capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
>> +
>> +                       per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);

I think capacity_ref_freq in in Hz, so the freq should be multiplied by 1000 .

With these two modifications, the patches worked well on a cppc-based platform.

Sorry I forgot to detail what it was. It's a modified Juno with CPPC enabled. AMUs are not
enabled, so the CPPC performance counters are not handled correctly and FIE cannot be enabled,
but it is possible to change frequencies.

The _CPC objects are setup as:
little CPUs:
- lowest_freq = 450 (MHz)
- nominal_freq = 800 (MHz)
- highest_perf = 383 * 1000
- nominal_perf = 322 * 1000
- lowest_perf = 181 * 1000
- lowest_nonlinear_perf = 181 * 1000

big CPUs:
- lowest_freq = 600 (MHz)
- nominal_freq = 1200 (MHz)
- highest_perf = 1024 * 1000
- nominal_perf = 833 * 1000
- lowest_perf = 512 * 1000
- lowest_nonlinear_perf = 512 * 1000

As a remainder, available frequencies are:
- little CPUs: 450, 800, 950 MHz
- big CPUs: 600, 1000, 1200 Mhz
So the platform is setup to have the last frequency as a boost frequency (for testing).

----

Just to make a note of 2 potential side-issues for later (independent from these patches):

- When testing with boosted/non-bossted frequencies, it didn't seem that cpu_overutilized()
   was taking the maximum frequency into consideration. This might mean that when lowering the
   maximum frequency of a policy, the maximum capacity of the CPUs of this policy is used
   to detect over-utilization.
   I would have thought that the over-utilization threshold would be lowered at the same time.

- Similarly for EAS, the energy computation doesn't take into account the maximum frequency
   of the policy. This should mean that EAS is taking into consideration frequencies that
   are not actually available.


Regards,
Pierre

