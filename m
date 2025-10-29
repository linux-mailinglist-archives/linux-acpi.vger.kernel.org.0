Return-Path: <linux-acpi+bounces-18303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C8C181AC
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 03:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65BD3B1F52
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 02:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E52D5A16;
	Wed, 29 Oct 2025 02:57:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731C29A309;
	Wed, 29 Oct 2025 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761706678; cv=none; b=JKiWmCfSkwA8/R36CS3EJr7A5L28w17fgldhGvRVEQaWxVk9NKHHoHs8tXGhpuvQKn+I4c8S5/CZYeYfniyt0LU0dsgJ59K0ZamyupRo5l6g8/L6Cxrn3dyS6yP0HeywGo4w9Fx326ON7q3A3xmWZMYInNYm5Ia97HFe6XfYsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761706678; c=relaxed/simple;
	bh=mep5AsfZ+dDh63QbAet0NjjS4x3Cwgihg7zVz53pHIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EAOSlohj6nyRabJHtiwhaXJZtddSfEWgg7vTUaqHjuw88sLtFm5pCWH0majNDJWLvhyvIXUKdVsPqFVb/5B6xP8dXMhCr3gA3cjR/Z1pufRKcw2Q9bf00pgxWfuQK8/KacT6XlkMn5XCLvU1UU41yE2kKnQ2W7qcDmofIDt+HGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cxBjD2TNmz1T4HJ;
	Wed, 29 Oct 2025 10:56:48 +0800 (CST)
Received: from kwepemr500004.china.huawei.com (unknown [7.202.195.141])
	by mail.maildlp.com (Postfix) with ESMTPS id CCBC514027A;
	Wed, 29 Oct 2025 10:57:51 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemr500004.china.huawei.com
 (7.202.195.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 10:57:51 +0800
Message-ID: <4f02fbba-dcdf-4133-9cad-eb4a75273f0f@hisilicon.com>
Date: Wed, 29 Oct 2025 10:57:50 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: Don't warn if FIE init fails to
 read counters
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <rafael@kernel.org>, <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
 <20250828110212.2108653-2-zhanjie9@hisilicon.com>
 <h2k4enovkvyasxkf3s6ceslpdnhhuvems3jmmv6a2q2zg4nsap@tlsqppgiszwo>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <h2k4enovkvyasxkf3s6ceslpdnhhuvems3jmmv6a2q2zg4nsap@tlsqppgiszwo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500004.china.huawei.com (7.202.195.141)



On 10/28/2025 1:10 PM, Viresh Kumar wrote:
> On 28-08-25, 19:02, Jie Zhan wrote:
>> During the CPPC FIE initialization, reading perf counters on offline cpus
>> should be expected to fail.  Don't warn on this case.
>>
>> Also, change the error log level to debug since FIE is optional.
>>
>> Co-developed-by: Bowen Yu <yubowen8@huawei.com>
>> Signed-off-by: Bowen Yu <yubowen8@huawei.com> # Changing loglevel to debug
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 4a17162a392d..7724318b3415 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -144,16 +144,10 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>>  		init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
>>  
>>  		ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
>> -		if (ret) {
>> -			pr_warn("%s: failed to read perf counters for cpu:%d: %d\n",
>> +		if (ret && cpu_online(cpu)) {
>> +			pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>>  				__func__, cpu, ret);
>> -
>> -			/*
>> -			 * Don't abort if the CPU was offline while the driver
>> -			 * was getting registered.
>> -			 */
>> -			if (cpu_online(cpu))
>> -				return;
>> +			return;
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7724318b3415..5a30c1ec0cdd 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -144,6 +144,11 @@ static void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>                 init_irq_work(&cppc_fi->irq_work, cppc_irq_work);
>  
>                 ret = cppc_get_perf_ctrs(cpu, &cppc_fi->prev_perf_fb_ctrs);
> +
> +               /*
> +                * Don't abort as the CPU was offline while the driver was
> +                * getting registered.
> +                */
>                 if (ret && cpu_online(cpu)) {
>                         pr_debug("%s: failed to read perf counters for cpu:%d: %d\n",
>                                 __func__, cpu, ret);
> 
> Applied with this diff.
> 
Sure, thanks!

