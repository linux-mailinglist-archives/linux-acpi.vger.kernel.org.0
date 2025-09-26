Return-Path: <linux-acpi+bounces-17333-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B53BA336B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 11:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACDA1B28363
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5428C009;
	Fri, 26 Sep 2025 09:46:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155772C181;
	Fri, 26 Sep 2025 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758879992; cv=none; b=CzjEJf+D3I3asaFMImYs+/QgMcu9Lr324w3Z5GgHjnXvxPspN+SvXBBmAu7TQ5l84J3DzUH5PjseoRo9Ck6X/vtsSyApfuXyRHY1BdOkNeBbhX61bf/BXr2iv+bueJxj5YXaSMwgwzc3Li+tjo7k0XKSyIaWt4Tq9OMIFCzA48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758879992; c=relaxed/simple;
	bh=7W08iLAB9tpqDqXOg5kUQRNRI02C9jkApAtavECG8Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JNuP4bfafqiazFuBAjEjY+wjdBSp/Ua+nJNp3uQfahCo5WWfzpvjxDdgH1V7ahe7MpqsluULCYTSuF2KXFMvPnk3iDHuFu83n8EgBppo1+ev+uGcDEzvD92QqR37QNh35OIvk3bTx36/MwFmC42a3MJP0nmqGM1ZqGgzaZ0XgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4cY5Gy1q7cz2TT1M;
	Fri, 26 Sep 2025 17:42:50 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id BC5021402CC;
	Fri, 26 Sep 2025 17:46:26 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 17:46:26 +0800
Message-ID: <4f5e0e2e-7754-4d29-9eba-c671f084fc45@hisilicon.com>
Date: Fri, 26 Sep 2025 17:46:25 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] cpufreq: Make drivers using CPUFREQ_ETERNAL
 specify transition latency
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>, Qais Yousef <qyousef@layalina.io>, LKML
	<linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Prashanth Prakash <pprakash@codeaurora.org>, Pierre Gondois
	<pierre.gondois@arm.com>, Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>
References: <8605612.T7Z3S40VBb@rafael.j.wysocki>
 <2346363.iZASKD2KPV@rafael.j.wysocki>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <2346363.iZASKD2KPV@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 9/25/2025 11:44 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit a755d0e2d41b ("cpufreq: Honour transition_latency over
> transition_delay_us") caused platforms where cpuinfo.transition_latency
> is CPUFREQ_ETERNAL to get a very large transition latency whereas
> previously it had been capped at 10 ms (and later at 2 ms).
> 
> This led to a user-observable regression between 6.6 and 6.12 as
> described by Shawn:
> 
> "The dbs sampling_rate was 10000 us on 6.6 and suddently becomes
>  6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these platforms
>  because the default transition delay was dropped [...].
> 
>  It slows down dbs governor's reacting to CPU loading change
>  dramatically.  Also, as transition_delay_us is used by schedutil
>  governor as rate_limit_us, it shows a negative impact on device
>  idle power consumption, because the device gets slightly less time
>  in the lowest OPP."
> 
> Evidently, the expectation of the drivers using CPUFREQ_ETERNAL as
> cpuinfo.transition_latency was that it would be capped by the core,
> but they may as well return a default transition latency value instead
> of CPUFREQ_ETERNAL and the core need not do anything with it.
> 
> Accordingly, introduce CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS and make
> all of the drivers in question use it instead of CPUFREQ_ETERNAL.
> 
> Fixes: a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
> Closes: https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
> Reported-by: Shawn Guo <shawnguo@kernel.org>
> Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Thanks, we've seen similar issues.

Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c          |    2 +-
>  drivers/cpufreq/imx6q-cpufreq.c       |    2 +-
>  drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
>  drivers/cpufreq/scmi-cpufreq.c        |    2 +-
>  drivers/cpufreq/scpi-cpufreq.c        |    2 +-
>  drivers/cpufreq/spear-cpufreq.c       |    2 +-
>  include/linux/cpufreq.h               |    3 +++
>  7 files changed, 9 insertions(+), 6 deletions(-)

