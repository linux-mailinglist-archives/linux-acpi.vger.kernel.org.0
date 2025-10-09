Return-Path: <linux-acpi+bounces-17664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2791BC785E
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 08:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 845DE4F0158
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 06:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8C29A9E9;
	Thu,  9 Oct 2025 06:19:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBF9296BBA;
	Thu,  9 Oct 2025 06:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990760; cv=none; b=Td8bKL8izc2fSsb5sgnA8ycIystaxmY535xvdnmpDWr8Ev0fdN5jms6Xk9wQ1wQthZfUvgJTkIk5lpaV59V9qwMFB5dawMHZOgHZzXAjT1YPkjKTGMEZnUFrPXj8JY5/VuJlHGH1wnmMURuFkikaKcbjPGE5SmsxmPSBc+kNgdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990760; c=relaxed/simple;
	bh=D+Rpim04uRYSosMNek/Y8Z/MaSS/5imcokP5FdEqlYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jlj9OiZmBJPJFdyUgD0zqbGYL+dqTgbbKLTaXSpVPBLXEh4ISMABCnUZuCh6davHE/ewxA8EBwcZ7IyF5b0FhfMQ461u0BrH0PHFS7Kssq31qcmeomG1/XvX9VE5D8mdFWM7nGKmVl56KFF1k67i2sNGJrSdEkPa4RKzZeTZ1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cj07j4Z5hz1prKc;
	Thu,  9 Oct 2025 14:18:57 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 7059F1402C1;
	Thu,  9 Oct 2025 14:19:14 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 14:19:13 +0800
Message-ID: <477505bc-ce6d-409a-820d-55a46c72ab7d@hisilicon.com>
Date: Thu, 9 Oct 2025 14:19:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cpufreq: CPPC: Rework FIE warning prints and
 cppc_scale_freq_tick()
To: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<beata.michalska@arm.com>, <zhenglifeng1@huawei.com>, Prashant Malani
	<pmalani@google.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
 <60f9cafb-2199-4c7b-ba97-7529d0ef5bf8@hisilicon.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <60f9cafb-2199-4c7b-ba97-7529d0ef5bf8@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500004.china.huawei.com (7.202.195.141)

Hi All,

I'm still looking forward to some feedback or tests on this series.

Cheers,
Jie

On 9/16/2025 10:58 AM, Jie Zhan wrote:
> A kindly ping on this.
> Some feedback would be nice if anyone is not on holiday ;)
> 
> Jie
> 
> On 8/28/2025 7:02 PM, Jie Zhan wrote:
>> Reading performance feedback counters on offline or low-power idle CPUs may
>> return 0, which is interpreted as -EFAULT.
>>
>> This leads to two issues related to the CPPC FIE:
>>
>> 1. When booting a subset of CPUs in policy->related_cpus (some CPUs under
>> the cpufreq policy is offline), there are warnings of "failed to read perf
>> counters for cpu" during the CPPC FIE initialization.
>>
>> 2. On our platform with the CPC regs in System Memory and a power-down idle
>> state enabled, if the CPPC FIE is registered successfully, there are
>> repeated warnings of "failed to read perf counters" because
>> cppc_scale_freq_workfn() is trying to access the counters of remote CPUs
>> that enters the idle state.
>>
>> To solve the above issues:
>>
>> Patch 1 removes the warning when the CPPC FIE initialization fails to read
>> counters on offline CPUs and changes the log leve to debug.  This can be
>> applied separately.
>>
>> Patch 2 moves the update of FIE arch_freq_scale into ticks for non-PCC regs
>> and maintains the existing mechanism for PCC regs, such that reading
>> counters would be triggered on the local CPU only.  This inherently solves
>> the issue in [1].  We have tested this on Kunpeng SoCs with the CPC regs
>> both in System Memory and FFH.  More tests on other platforms are welcome
>> though.
>> [1] https://lore.kernel.org/linux-pm/20250730032312.167062-3-yubowen8@huawei.com/
>>
>> Changelog:
>>
>> v2:
>> - Update the cover letter and the commit log based on v1 discussion
>> - Update FIE arch_freq_scale in ticks for non-PCC regs
>>
>> v1:
>> https://lore.kernel.org/linux-pm/20250730032312.167062-1-yubowen8@huawei.com/
>>
>> Jie Zhan (2):
>>   cpufreq: CPPC: Don't warn if FIE init fails to read counters
>>   cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
>>
>>  drivers/cpufreq/cppc_cpufreq.c | 64 +++++++++++++++++++++-------------
>>  1 file changed, 39 insertions(+), 25 deletions(-)
>>

