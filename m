Return-Path: <linux-acpi+bounces-19401-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACDEC9E19D
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 08:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD753348533
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4313529AAEA;
	Wed,  3 Dec 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nkEpiCkE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7422068F;
	Wed,  3 Dec 2025 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764748548; cv=none; b=EO+rSpkPQdUIpVQQTf/C/iUwbX3Pfc3XKJSdUl8kbgCxzLHyYEmn2g/kgGoSQOwDwJcQ3zGZ4Swm+Uz9FLvjENr/bL6wEX6a+MBo/Om6qgqEw7W5EOVRcQR4AsOwq36IsGTq0ndrAjcBet5+wqHZ9EtFN/qJi/LWC4FYY0rKGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764748548; c=relaxed/simple;
	bh=N4pyd1q66x+ZLvGWFu4p+kpjqWrVnugAsPLolRhKR+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EWygrojZhKueR7bXRSVogDL8UQ4EpqEd9Yx3EEX7aDq37b7RUJ1+sebIk6+QEQHOUAYqHIoxQnGcEqLaRVodbBnRH/8N+LBvLU4raLHZVVcKS27v3AG4pgtYcdM/e3iupqo+NbkXN4aHnWwopbX1tWc2iE12keEPnm8JSceQumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nkEpiCkE; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PoNj/LLIwhw9nuV5TFzzwrV+/p2aGFUFYEq088oFcyg=;
	b=nkEpiCkEbQIhoIMJV6fAblP92FwHhgzsnXgsHrLTTEO/rawD6EZygaQJiKr+BhdSy+mgv1Rp0
	qH1u8oISG4+UvDwSnP0cbFCaDnbaL2dq1+looLkSioRCVEquJmBjfkJtL90pJeTLEQz9VsMXzcQ
	F2EKMlw0bjqfI19mzR7VSRQ=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dLqd80p4XzpSy3;
	Wed,  3 Dec 2025 15:53:16 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 60312140864;
	Wed,  3 Dec 2025 15:55:35 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Dec
 2025 15:55:34 +0800
Message-ID: <51dc71f8-8208-40c6-8ecd-50abd79a036a@huawei.com>
Date: Wed, 3 Dec 2025 15:55:34 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks
 for non-PCC regs
To: Jie Zhan <zhanjie9@hisilicon.com>, <viresh.kumar@linaro.org>,
	<rafael@kernel.org>, <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<pierre.gondois@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<yubowen8@huawei.com>, <lihuisong@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>

On 2025/12/3 11:24, Jie Zhan wrote:
> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
> scheduler tick but defers the update of arch_freq_scale to a separate
> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
> 
> However, this deferred update mechanism is unnecessary and introduces extra
> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
> accessing the regs won't sleep and can be safely performed from the tick
> context.
> 
> Furthermore, with the CPPC FIE registered, it throws repeated warnings of
> "cppc_scale_freq_workfn: failed to read perf counters" on our platform with
> the CPC regs in System Memory and a power-down idle state enabled.  That's
> because the remote CPU can be in a power-down idle state, and reading its
> perf counters returns 0.  Moving the FIE handling back to the scheduler
> tick process makes the CPU handle its own perf counters, so it won't be
> idle and the issue would be inherently solved.
> 
> To address the above issues, update arch_freq_scale directly in ticks for
> non-PCC regs and keep the deferred update mechanism for PCC regs.
> 
> We have tested this on Kunpeng SoCs with the CPC regs both in System Memory
> and FFH.  More tests on other platforms are welcome (typically with the
> regs in PCC).
> 
> Changelog:
> v4:
> - Allow either non-PCC or PCC scale_freq_tick callbacks to be registered
>   for each cpufreq policy.
> - Factor out cppc_perf_ctrs_in_pcc_cpu() and cppc_fie_kworker_init() for
>   the above change.
> 
> v3:
> https://lore.kernel.org/linux-pm/20251104065039.1675549-1-zhanjie9@hisilicon.com/
> - Stash the state of 'cppc_perf_ctrs_in_pcc' so it won't have to check the
>   CPC regs of all CPUs everywhere (Thanks to the suggestion from Beata
>   Michalska).
> - Update the commit log, explaining more on the warning issue caused by
>   accessing perf counters on remote CPUs.
> - Drop Patch 1 that has been accepted, and rebase Patch 2 on that.
> 
> v2:
> https://lore.kernel.org/linux-pm/20250828110212.2108653-1-zhanjie9@hisilicon.com/
> - Update the cover letter and the commit log based on v1 discussion
> - Update FIE arch_freq_scale in ticks for non-PCC regs
> 
> v1:
> https://lore.kernel.org/linux-pm/20250730032312.167062-1-yubowen8@huawei.com/
> 
> Jie Zhan (3):
>   ACPI: CPPC: Factor out and export per-cpu cppc_perf_ctrs_in_pcc_cpu()
>   cpufreq: CPPC: Factor out cppc_fie_kworker_init()
>   cpufreq: CPPC: Update FIE arch_freq_scale in ticks for non-PCC regs
> 
>  drivers/acpi/cppc_acpi.c       | 45 ++++++++--------
>  drivers/cpufreq/cppc_cpufreq.c | 96 ++++++++++++++++++++++------------
>  include/acpi/cppc_acpi.h       |  5 ++
>  3 files changed, 93 insertions(+), 53 deletions(-)
> 


