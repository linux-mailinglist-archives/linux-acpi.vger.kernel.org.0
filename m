Return-Path: <linux-acpi+bounces-17331-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B969BA3260
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 11:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7C83B5435
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 09:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F622836A6;
	Fri, 26 Sep 2025 09:30:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32C19FA8D;
	Fri, 26 Sep 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879053; cv=none; b=WY9IK7yHRfiw9bZUt4Pa1SMVvcTNtm0QG1ub8DCf+IqWQn3hJVtom8NySCdxzh0XEVh59Fdc6e5RTwNzuKWGKDD4kBmre7cjB9Wxtyz/RuLq+U4ukamfdRhOD9eiHD8OSbyrjFkIPXW43iMW9fjVfCV+ohFqnQkW0BwuwKL4JYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879053; c=relaxed/simple;
	bh=46zt7pchOFaqIFp+O1QJr3oHps/b3B4lW+YW5IqNivI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D0hEgSXsGnSdsB8FttVpIIo1lzhdUsHLn6gw8hx/LbyTrYg4AdLgUBmO7cm4lVrUlqNkWanoHApPN52DT8J6vjx17VArkOX/QKM327zDswuZfUgvM82UvdLmNXeAK41zD5orWTpLC9vhWxUNXsvHuvC58OwrGex+RM9SrKC9EiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cY502616qztTlr;
	Fri, 26 Sep 2025 17:29:54 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 4233E180087;
	Fri, 26 Sep 2025 17:30:47 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 17:30:46 +0800
Message-ID: <9637c2c2-823d-457f-b9bd-c7acd762bf88@hisilicon.com>
Date: Fri, 26 Sep 2025 17:30:45 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ACPI: CPPC: Do not use CPUFREQ_ETERNAL as an error
 value
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
CC: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>, LKML
	<linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>, Linux ACPI
	<linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <3925838.kQq0lBPeGt@rafael.j.wysocki> <12773788.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <12773788.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 9/26/2025 1:23 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using CPUFREQ_ETERNAL for signaling an error condition
> in cppc_get_transition_latency(), change the return value type of
> that function to int and make it return a proper negative error
> code on failures.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
A minor comment inline.  Other than that,
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
> 
> v1 -> v2:
>    * Change cppc_get_transition_latency() return value data type to int
>    * Make it return -ENODATA on errors (Mario)
>    * Update its callers accordingly
>    * Adjust the subject and changelog
>    * Add a missing empty code line to cppc_get_transition_latency()
> 
> The modifications of this patch don't affect any other patches in the series:
> 
> https://lore.kernel.org/linux-pm/8605612.T7Z3S40VBb@rafael.j.wysocki/
> 
> ---
>  drivers/acpi/cppc_acpi.c       |   15 ++++++++-------
>  drivers/cpufreq/amd-pstate.c   |    8 ++++----
>  drivers/cpufreq/cppc_cpufreq.c |    4 ++--
>  include/acpi/cppc_acpi.h       |    6 +++---
>  4 files changed, 17 insertions(+), 16 deletions(-)
> 
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1876,7 +1876,7 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
>   * If desired_reg is in the SystemMemory or SystemIo ACPI address space,
>   * then assume there is no latency.
>   */
> -unsigned int cppc_get_transition_latency(int cpu_num)
> +int cppc_get_transition_latency(int cpu_num)
>  {
>  	/*
>  	 * Expected transition latency is based on the PCCT timing values
> @@ -1889,31 +1889,32 @@ unsigned int cppc_get_transition_latency
>  	 *              completion of a command before issuing the next command,
>  	 *              in microseconds.
>  	 */
> -	unsigned int latency_ns = 0;
>  	struct cpc_desc *cpc_desc;
>  	struct cpc_register_resource *desired_reg;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu_num);
>  	struct cppc_pcc_data *pcc_ss_data;
> +	int latency_ns = 0;
>  
>  	cpc_desc = per_cpu(cpc_desc_ptr, cpu_num);
>  	if (!cpc_desc)
> -		return CPUFREQ_ETERNAL;
> +		return -ENODATA;
>  
>  	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>  	if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired_reg))
>  		return 0;
> +
An extra line here.

Alternatively, can we cleanup a bit:

if (!CPC_IN_PCC(desired_reg) || pcc_ss_id < 0)
	return -ENODATA;

>  	else if (!CPC_IN_PCC(desired_reg))
> -		return CPUFREQ_ETERNAL;
> +		return -ENODATA;
>  
>  	if (pcc_ss_id < 0)
> -		return CPUFREQ_ETERNAL;
> +		return -ENODATA;
>  
>  	pcc_ss_data = pcc_data[pcc_ss_id];
>  	if (pcc_ss_data->pcc_mpar)
>  		latency_ns = 60 * (1000 * 1000 * 1000 / pcc_ss_data->pcc_mpar);
>  
> -	latency_ns = max(latency_ns, pcc_ss_data->pcc_nominal * 1000);
> -	latency_ns = max(latency_ns, pcc_ss_data->pcc_mrtt * 1000);
> +	latency_ns = max_t(int, latency_ns, pcc_ss_data->pcc_nominal * 1000);
> +	latency_ns = max_t(int, latency_ns, pcc_ss_data->pcc_mrtt * 1000);
>  
>  	return latency_ns;
>  }
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -872,10 +872,10 @@ static void amd_pstate_update_limits(str
>   */
>  static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
>  {
> -	u32 transition_delay_ns;
> +	int transition_delay_ns;
>  
>  	transition_delay_ns = cppc_get_transition_latency(cpu);
> -	if (transition_delay_ns == CPUFREQ_ETERNAL) {
> +	if (transition_delay_ns < 0) {
>  		if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
>  			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
>  		else
> @@ -891,10 +891,10 @@ static u32 amd_pstate_get_transition_del
>   */
>  static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>  {
> -	u32 transition_latency;
> +	int transition_latency;
>  
>  	transition_latency = cppc_get_transition_latency(cpu);
> -	if (transition_latency  == CPUFREQ_ETERNAL)
> +	if (transition_latency < 0)
>  		return AMD_PSTATE_TRANSITION_LATENCY;
>  
>  	return transition_latency;
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -310,9 +310,9 @@ static int cppc_verify_policy(struct cpu
>  
>  static unsigned int get_transition_latency_from_cppc(unsigned int cpu)
>  {
> -	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
> +	int transition_latency_ns = cppc_get_transition_latency(cpu);
>  
> -	if (transition_latency_ns == CPUFREQ_ETERNAL)
> +	if (transition_latency_ns < 0)
>  		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
>  
>  	return transition_latency_ns / NSEC_PER_USEC;
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -160,7 +160,7 @@ extern unsigned int cppc_khz_to_perf(str
>  extern bool acpi_cpc_valid(void);
>  extern bool cppc_allow_fast_switch(void);
>  extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> -extern unsigned int cppc_get_transition_latency(int cpu);
> +extern int cppc_get_transition_latency(int cpu);
>  extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> @@ -216,9 +216,9 @@ static inline bool cppc_allow_fast_switc
>  {
>  	return false;
>  }
> -static inline unsigned int cppc_get_transition_latency(int cpu)
> +static inline int cppc_get_transition_latency(int cpu)
>  {
> -	return CPUFREQ_ETERNAL;
> +	return -ENODATA;
>  }
>  static inline bool cpc_ffh_supported(void)
>  {
> 
> 
> 
> 

