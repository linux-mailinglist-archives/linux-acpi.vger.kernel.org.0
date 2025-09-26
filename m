Return-Path: <linux-acpi+bounces-17332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D33BA333B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 11:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DA64A1D02
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C042B28E5F3;
	Fri, 26 Sep 2025 09:41:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15D26C391;
	Fri, 26 Sep 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879678; cv=none; b=NQ3yhzK5VvsR8oJIyVxLzpA5Cyl+BLIf5msDvsTKYTDuFG8JT9mcGJdIBfpHseu8Yyga2XP1hBSF/HHZ5KPsmvg/JrRVEaPtod7X2Y9Ik5pBFt2uZZ/WQXb9dZ3ZW2talFZ70voAovK99mA85jQgFhcpHmOt1yfgK5PfVrDbgA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879678; c=relaxed/simple;
	bh=VACKunmSgWGIegqrjvsKz7Yahv49ulYM3NKnwvZtZrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fY65CNweFDY4BDz0TDjLlr1i8vLkqjKwRxOIG7f3mnO017UaNamdnilzhcyCWAZgFdLwcvJNfIwaxzEcrRmrKEUVUToFpcd7yxibLL2RZN8/m8BRbpa6ggL8dRwKrqwdZSM8V2eS90le4kaZtibK0//py4YLp0+UIQULj7FrPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cY5Dh3MXGzvX1j;
	Fri, 26 Sep 2025 17:40:52 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id E8874180491;
	Fri, 26 Sep 2025 17:41:12 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 17:41:12 +0800
Message-ID: <08e83a78-d2d8-46b7-9062-15c898ef85c8@hisilicon.com>
Date: Fri, 26 Sep 2025 17:41:11 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] cpufreq: CPPC: Avoid using CPUFREQ_ETERNAL as
 transition delay
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>, LKML
	<linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Prashanth Prakash <pprakash@codeaurora.org>, Pierre Gondois
	<pierre.gondois@arm.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <22867781.EfDdHjke4D@rafael.j.wysocki>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <22867781.EfDdHjke4D@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 9/25/2025 11:44 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If cppc_get_transition_latency() returns CPUFREQ_ETERNAL to indicate a
> failure to retrieve the transition latency value from the platform
> firmware, the CPPC cpufreq driver will use that value (converted to
> microseconds) as the policy transition delay, but it is way too large
> for any practical use.
> 
> Address this by making the driver use the cpufreq's default
> transition latency value (in microseconds) as the transition delay
> if CPUFREQ_ETERNAL is returned by cppc_get_transition_latency().
> 
> Fixes: d4f3388afd48 ("cpufreq / CPPC: Set platform specific transition_delay_us")
> Cc: 5.19+ <stable@vger.kernel.org> # 5.19
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -308,6 +308,16 @@ static int cppc_verify_policy(struct cpu
>  	return 0;
>  }
>  
> +static unsigned int get_transition_latency_from_cppc(unsigned int cpu)
Minor bit:
Can we name it as __cppc_cpufreq_get_transition_delay_us() because:
1. 'get_xxx' naming looks a bit different from other funcs in cppc_cpufreq.c
2. This is actually the main routine of cppc_cpufreq_get_transition_delay_us().
It's factored out just for the qualcomm workaround.
> +{
> +	unsigned int transition_latency_ns = cppc_get_transition_latency(cpu);
> +
> +	if (transition_latency_ns == CPUFREQ_ETERNAL)
> +		return CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS / NSEC_PER_USEC;
> +
> +	return transition_latency_ns / NSEC_PER_USEC;
> +}
> +
>  /*
>   * The PCC subspace describes the rate at which platform can accept commands
>   * on the shared PCC channel (including READs which do not count towards freq
> @@ -330,12 +340,12 @@ static unsigned int cppc_cpufreq_get_tra
>  			return 10000;
>  		}
>  	}
> -	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> +	return get_transition_latency_from_cppc(cpu);
>  }
>  #else
>  static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
>  {
> -	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
> +	return get_transition_latency_from_cppc(cpu);
>  }
>  #endif
>  

