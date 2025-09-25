Return-Path: <linux-acpi+bounces-17318-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57492BA1095
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 20:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBD7C16C423
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Sep 2025 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8A31A565;
	Thu, 25 Sep 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR2I3TF/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774E1DE3DC;
	Thu, 25 Sep 2025 18:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825197; cv=none; b=t2NZfD4mKKMAvLpMYIQBd46Pv+0C4r9EIpaqIpUHuRcsDfx9OVSgzjzmeDnBS5M772P1PZKJXFvz1qnXdIeG8Pn5tM1Z8M/hWjLgw/Eztm1+OiHwRHqhDrM6vx8VLyvnsmY9yPs9+NcphHuxf8R8Tx3r5pWsbtJD0uHsTfrn4hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825197; c=relaxed/simple;
	bh=2dXXjcfz6yo54Czf0POycwQADijPXlf9dzGU92OlDes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReZBggPD3sZHTm8pe1vdXfdMnmRMHXYU/xk5fHN9PoeTglAmuDo4MItNPgy2go++11yn3ODHx9EpDReNyAkrx81OD5VwcVF8Gy+kX/SxLIHKW2k2YQGCmDbEaT7S8uKXIKq5GtkqCCuEyR7HOQ/wUBRXRPDIJfCK+EKP6jsEn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR2I3TF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F44C4CEF0;
	Thu, 25 Sep 2025 18:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758825196;
	bh=2dXXjcfz6yo54Czf0POycwQADijPXlf9dzGU92OlDes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SR2I3TF/Ds/kHUzB2cy5A0+kI0XPezSj4XITnqaz80Zr4nCr8KunVC6s0hGMHjTHq
	 H9ZgYeBnUfY8h5c6JOu3tiZtnSWOWe5iXxewnmaj3sZBKesoQijO7C6w1DO+er+zcZ
	 AhLOpE2eXn1UpetqAbjrm8GB4mGF7zXf+JUAKeq0pNKuLozzWLDJy/vb/pKosHRHa9
	 +4z0njWLRykWfuvYKT5UgpsVFB50E/k3/ymX6pTxTcNRoHF2ML9djwSjys6Ma04hq9
	 J4ezQR+NbUmJAAZfn/FEowIyb4MQRe3YtwUwdyNIZbn7BekhY90XvfMdKUSsvPdjHV
	 4MknFy7pus1BQ==
Message-ID: <3b982e8d-4ce7-4186-b5f0-f7495be3a3ed@kernel.org>
Date: Thu, 25 Sep 2025 13:33:14 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ACPI: CPPC: Do not use CPUFREQ_ETERNAL as an error
 value
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
 LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <3925838.kQq0lBPeGt@rafael.j.wysocki> <12773788.O9o76ZdvQC@rafael.j.wysocki>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <12773788.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/2025 12:23 PM, Rafael J. Wysocki wrote:
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

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
> 
> v1 -> v2:
>     * Change cppc_get_transition_latency() return value data type to int
>     * Make it return -ENODATA on errors (Mario)
>     * Update its callers accordingly
>     * Adjust the subject and changelog
>     * Add a missing empty code line to cppc_get_transition_latency()
> 
> The modifications of this patch don't affect any other patches in the series:
> 
> https://lore.kernel.org/linux-pm/8605612.T7Z3S40VBb@rafael.j.wysocki/
> 
> ---
>   drivers/acpi/cppc_acpi.c       |   15 ++++++++-------
>   drivers/cpufreq/amd-pstate.c   |    8 ++++----
>   drivers/cpufreq/cppc_cpufreq.c |    4 ++--
>   include/acpi/cppc_acpi.h       |    6 +++---
>   4 files changed, 17 insertions(+), 16 deletions(-)
> 
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1876,7 +1876,7 @@ EXPORT_SYMBOL_GPL(cppc_set_perf);
>    * If desired_reg is in the SystemMemory or SystemIo ACPI address space,
>    * then assume there is no latency.
>    */
> -unsigned int cppc_get_transition_latency(int cpu_num)
> +int cppc_get_transition_latency(int cpu_num)
>   {
>   	/*
>   	 * Expected transition latency is based on the PCCT timing values
> @@ -1889,31 +1889,32 @@ unsigned int cppc_get_transition_latency
>   	 *              completion of a command before issuing the next command,
>   	 *              in microseconds.
>   	 */
> -	unsigned int latency_ns = 0;
>   	struct cpc_desc *cpc_desc;
>   	struct cpc_register_resource *desired_reg;
>   	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu_num);
>   	struct cppc_pcc_data *pcc_ss_data;
> +	int latency_ns = 0;
>   
>   	cpc_desc = per_cpu(cpc_desc_ptr, cpu_num);
>   	if (!cpc_desc)
> -		return CPUFREQ_ETERNAL;
> +		return -ENODATA;
>   
>   	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
>   	if (CPC_IN_SYSTEM_MEMORY(desired_reg) || CPC_IN_SYSTEM_IO(desired_reg))
>   		return 0;
> +
>   	else if (!CPC_IN_PCC(desired_reg))
> -		return CPUFREQ_ETERNAL;
> +		return -ENODATA;
>   
>   	if (pcc_ss_id < 0)
> -		return CPUFREQ_ETERNAL;
> +		return -ENODATA;
>   
>   	pcc_ss_data = pcc_data[pcc_ss_id];
>   	if (pcc_ss_data->pcc_mpar)
>   		latency_ns = 60 * (1000 * 1000 * 1000 / pcc_ss_data->pcc_mpar);
>   
> -	latency_ns = max(latency_ns, pcc_ss_data->pcc_nominal * 1000);
> -	latency_ns = max(latency_ns, pcc_ss_data->pcc_mrtt * 1000);
> +	latency_ns = max_t(int, latency_ns, pcc_ss_data->pcc_nominal * 1000);
> +	latency_ns = max_t(int, latency_ns, pcc_ss_data->pcc_mrtt * 1000);
>   
>   	return latency_ns;
>   }
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -872,10 +872,10 @@ static void amd_pstate_update_limits(str
>    */
>   static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
>   {
> -	u32 transition_delay_ns;
> +	int transition_delay_ns;
>   
>   	transition_delay_ns = cppc_get_transition_latency(cpu);
> -	if (transition_delay_ns == CPUFREQ_ETERNAL) {
> +	if (transition_delay_ns < 0) {
>   		if (cpu_feature_enabled(X86_FEATURE_AMD_FAST_CPPC))
>   			return AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY;
>   		else
> @@ -891,10 +891,10 @@ static u32 amd_pstate_get_transition_del
>    */
>   static u32 amd_pstate_get_transition_latency(unsigned int cpu)
>   {
> -	u32 transition_latency;
> +	int transition_latency;
>   
>   	transition_latency = cppc_get_transition_latency(cpu);
> -	if (transition_latency  == CPUFREQ_ETERNAL)
> +	if (transition_latency < 0)
>   		return AMD_PSTATE_TRANSITION_LATENCY;
>   
>   	return transition_latency;
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -310,9 +310,9 @@ static int cppc_verify_policy(struct cpu
>   
>   static unsigned int get_transition_latency_from_cppc(unsigned int cpu)
>   {
> -	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
> +	int transition_latency_ns = cppc_get_transition_latency(cpu);
>   
> -	if (transition_latency_ns == CPUFREQ_ETERNAL)
> +	if (transition_latency_ns < 0)
>   		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
>   
>   	return transition_latency_ns / NSEC_PER_USEC;
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -160,7 +160,7 @@ extern unsigned int cppc_khz_to_perf(str
>   extern bool acpi_cpc_valid(void);
>   extern bool cppc_allow_fast_switch(void);
>   extern int acpi_get_psd_map(unsigned int cpu, struct cppc_cpudata *cpu_data);
> -extern unsigned int cppc_get_transition_latency(int cpu);
> +extern int cppc_get_transition_latency(int cpu);
>   extern bool cpc_ffh_supported(void);
>   extern bool cpc_supported_by_cpu(void);
>   extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> @@ -216,9 +216,9 @@ static inline bool cppc_allow_fast_switc
>   {
>   	return false;
>   }
> -static inline unsigned int cppc_get_transition_latency(int cpu)
> +static inline int cppc_get_transition_latency(int cpu)
>   {
> -	return CPUFREQ_ETERNAL;
> +	return -ENODATA;
>   }
>   static inline bool cpc_ffh_supported(void)
>   {
> 
> 
> 


