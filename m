Return-Path: <linux-acpi+bounces-15999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1E5B32CA7
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Aug 2025 02:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8904B3A5819
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Aug 2025 00:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF21A41;
	Sun, 24 Aug 2025 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SS6KRbjr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92A728E7;
	Sun, 24 Aug 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755994092; cv=none; b=lkVSvkWYsjrZZTexOAYK90kO/SgEuqAcNHOLsAe/9pJeOSShEo7M8uNRJVbcmHUl0Z9AHBA5V+6oZ22zUrrgvHbOOtQTrt3GH0G4UZ1Ext6VUW3PvDSaUam8sHCOoi+MIBpovNHP3dm7Jh64CxF63f6Fw4NOjXo0f2hDy0+McTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755994092; c=relaxed/simple;
	bh=p6tdH8tBUzTt3XM9QotbHtv99ePeCk312qZmjfd1qS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAD8+jIHWKUKwVUoALQU/6JKGt7qNIzs4pKUUCcK7CZjaWAVBvErvCY8D4g5SBpFZt0SWC+sILpJdUqGK3jW69QISGpZhE9fwPoAKBw0P1ywsY1cRkuVfMgvlANuW7UUj7iMFpPrqiBNQL8+avc9Y/ZOqahLbob0kPisBZsPZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SS6KRbjr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ht26JN6V8aJTQSiAdIEAXi691XkBeaZpaNivjGEiewE=; b=SS6KRbjrVcqOSsWL5xnae64XvZ
	lhA1rbp/6RT3BrbzxWLxiiqbhKyln8qBquir2RAOdfq5NmNvargMVGKQxzMBauHfkLcbOJx/P0h45
	8+Yp0dpURrNab+GT+ulQoYCvOMMFvOIbG87uAYik2in3/TTTL7QIK0kDX0ZHKYEvKv76MsZao/DHZ
	nILNaJlsAr1xlWYl5WP8CRRt7x/uaVZME4GyHPduFZefxoZBW4CAxBkMGVw5AiNcbdt6UiMFdCvdp
	UBDwHLgQgjuLIPB/1UOR7/bVNqMl9B3YaggYND54f4Z+wY0fp4wItmk5cIyD+shRKJAGOBjMQwrWc
	h8TIli3g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upyHG-00000005U69-021J;
	Sun, 24 Aug 2025 00:08:06 +0000
Message-ID: <d35459bc-cf52-4fd5-886a-e9f6db7fda5e@infradead.org>
Date: Sat, 23 Aug 2025 17:08:05 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com
References: <20250823200121.1320197-1-sumitg@nvidia.com>
 <20250823200121.1320197-8-sumitg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250823200121.1320197-8-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/23/25 1:01 PM, Sumit Gupta wrote:
> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
> autonomous performance selection at system startup. When autonomous mode
> is enabled, the hardware automatically adjusts CPU performance based on
> workload demands using Energy Performance Preference (EPP) hints from
> the OS.
> 
> This parameter allows to configure the autonomous mode on all CPUs
> without requiring runtime sysfs manipulation if the 'auto_sel' register
> is present.
> 
> When auto_sel_mode=1:
> - All CPUs are configured for autonomous operation during driver init
> - EPP is set to performance preference (0x0) by default
> - Min/max performance bounds use defaults
> - CPU frequency scaling is handled by hardware rather than OS
> 
> Also ensure that when autonomous mode is active, the set_target callback
> returns early since hardware controls frequency scaling directly.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>



> ---
>  .../admin-guide/kernel-parameters.txt         |  12 ++
>  drivers/cpufreq/cppc_cpufreq.c                | 171 ++++++++++++++++--
>  2 files changed, 168 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 86f395f2933b..ea58deb88c36 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -911,6 +911,18 @@
>  			Format:
>  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
>  
> +	cppc_cpufreq.auto_sel_mode=
> +			[CPU_FREQ] Autonomous Performance Level Selection.
> +			When Autonomous selection is enabled, then the hardware is
> +			allowed to autonomously select the CPU frequency.
> +			In Autonomous mode, Energy Performance Preference(EPP)
> +			provides input to the hardware to favour performance (0x0)
> +			or energy efficiency (0xff).
> +			Format: <bool>
> +			Default: disabled.
> +			0: force disabled
> +			1: force enabled
> +
>  	cpuidle.off=1	[CPU_IDLE]
>  			disable the cpuidle sub-system
>  
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 5e1bbb5f67b8..bbf654c56ff9 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c

[snip]

>  
> +module_param(auto_sel_mode, bool, 0000);

Hm. Is this changed to readable at some point or
does it stay invisible?

> +MODULE_PARM_DESC(auto_sel_mode, "Enable Autonomous Performance Level Selection");
> +
>  module_exit(cppc_cpufreq_exit);
>  MODULE_AUTHOR("Ashwin Chaugule");
>  MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");

For Documentation/:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

