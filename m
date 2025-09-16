Return-Path: <linux-acpi+bounces-16979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5894FB58C1C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 04:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2A132154B
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 02:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A724DCE5;
	Tue, 16 Sep 2025 02:58:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774D22128B;
	Tue, 16 Sep 2025 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991531; cv=none; b=AzzQ8FnVcwYFnDveKJ/wpRKkuOZyStJb3KLozjHo46w9eHdzBiNzR/YT7xn72qJ1LPvf7RlbD2BAs2m9T70uoB4sXQoKHFS7YeBWTPca91I+YXyT3xrpXww4R/l1qjluEmW+7iXHQJNkzGEJI1Ova/fq3anVocuhnxV3QHWfryA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991531; c=relaxed/simple;
	bh=sg8s9gAeM92da5rvOBWf7Yz/aCr8ASn+gAuFWTHxS/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bPtkW62NVA2vDjqrr7RaEt45MZdquxDXkFEecZuiB6ntrCUkzDsyeI3AuoGtRTHdehispoDA98ER9/hCKpaNMKKhyM3XfOYJEmvFxevM04so4rk1uAaKrybOYfcwzakXPVuFOasIQkuvmNOgdg1CvkBn3RxESGJrK6v06/Dtoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cQmgw23fpzddML;
	Tue, 16 Sep 2025 10:54:04 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 503551401F4;
	Tue, 16 Sep 2025 10:58:39 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 10:58:38 +0800
Message-ID: <60f9cafb-2199-4c7b-ba97-7529d0ef5bf8@hisilicon.com>
Date: Tue, 16 Sep 2025 10:58:37 +0800
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
	<beata.michalska@arm.com>, <zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, Jie Zhan <zhanjie9@hisilicon.com>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500004.china.huawei.com (7.202.195.141)

A kindly ping on this.
Some feedback would be nice if anyone is not on holiday ;)

Jie

On 8/28/2025 7:02 PM, Jie Zhan wrote:
> Reading performance feedback counters on offline or low-power idle CPUs may
> return 0, which is interpreted as -EFAULT.
> 
> This leads to two issues related to the CPPC FIE:
> 
> 1. When booting a subset of CPUs in policy->related_cpus (some CPUs under
> the cpufreq policy is offline), there are warnings of "failed to read perf
> counters for cpu" during the CPPC FIE initialization.
> 
> 2. On our platform with the CPC regs in System Memory and a power-down idle
> state enabled, if the CPPC FIE is registered successfully, there are
> repeated warnings of "failed to read perf counters" because
> cppc_scale_freq_workfn() is trying to access the counters of remote CPUs
> that enters the idle state.
> 
> To solve the above issues:
> 
> Patch 1 removes the warning when the CPPC FIE initialization fails to read
> counters on offline CPUs and changes the log leve to debug.  This can be
> applied separately.
> 
> Patch 2 moves the update of FIE arch_freq_scale into ticks for non-PCC regs
> and maintains the existing mechanism for PCC regs, such that reading
> counters would be triggered on the local CPU only.  This inherently solves
> the issue in [1].  We have tested this on Kunpeng SoCs with the CPC regs
> both in System Memory and FFH.  More tests on other platforms are welcome
> though.
> [1] https://lore.kernel.org/linux-pm/20250730032312.167062-3-yubowen8@huawei.com/
> 
> Changelog:
> 
> v2:
> - Update the cover letter and the commit log based on v1 discussion
> - Update FIE arch_freq_scale in ticks for non-PCC regs
> 
> v1:
> https://lore.kernel.org/linux-pm/20250730032312.167062-1-yubowen8@huawei.com/
> 
> Jie Zhan (2):
>   cpufreq: CPPC: Don't warn if FIE init fails to read counters
>   cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
> 
>  drivers/cpufreq/cppc_cpufreq.c | 64 +++++++++++++++++++++-------------
>  1 file changed, 39 insertions(+), 25 deletions(-)
> 

