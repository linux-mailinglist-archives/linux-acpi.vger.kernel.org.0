Return-Path: <linux-acpi+bounces-19504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3FFCB00C9
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 14:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66C9F3015AD9
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C4320A09;
	Tue,  9 Dec 2025 13:24:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C226ED33;
	Tue,  9 Dec 2025 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765286661; cv=none; b=Jf93/gB6wgvkUjF45ZiGamzzF6nAEL1unfVQrjrOXxEk9JPPB1XDKXjPqvOJRUNLy/4Pp8qR0AML0ikqu+dL3MjpIYMw8x4hW1qq0S4Ip74w5QAKXXtauq/lp9AZNjkz65I04hcfYRtHyM2X3lx0BWyf4/Bmhijp4aB9XbpUewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765286661; c=relaxed/simple;
	bh=uU/QqXrV88JX/gWVCDCvnBTmAcr8nkZh0mKv0YqcJf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uhwIPb38C9CcEIgSr2lwYh1iVgB0HvRZa7vDd+WDNV9IdOXTcE48kUY+e8dwmbCTVycV1NnG5K2kBJHSGXtyzB/yeENlZMq6t4KYKan23IINg//ltIU01i0vu6FvTchuBW7jRtryhALA+hCp6pKyUxtrbvGDQDveivyV6d4ogBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dQfh60dg6z1BFyf;
	Tue,  9 Dec 2025 21:24:06 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dQfcw70tnzcb1N;
	Tue,  9 Dec 2025 21:21:20 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 182F41401F0;
	Tue,  9 Dec 2025 21:24:00 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Dec
 2025 21:23:59 +0800
Message-ID: <347f2003-1efd-44be-89e3-080ab169599e@hisilicon.com>
Date: Tue, 9 Dec 2025 21:23:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks
 for non-PCC regs
To: Pierre Gondois <pierre.gondois@arm.com>, <viresh.kumar@linaro.org>,
	<rafael@kernel.org>, <ionela.voinescu@arm.com>, <beata.michalska@arm.com>,
	<zhenglifeng1@huawei.com>
CC: <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<yubowen8@huawei.com>, <lihuisong@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
 <20251203032422.3232957-4-zhanjie9@hisilicon.com>
 <270216de-e7d1-4552-a04f-8b0fd7b79552@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <270216de-e7d1-4552-a04f-8b0fd7b79552@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)



Hi Pierre,

On 12/8/2025 6:08 PM, Pierre Gondois wrote:
> Hello Jie Zhan,
> 
> 
> On 12/3/25 04:24, Jie Zhan wrote:
...
>> @@ -236,10 +265,8 @@ static void __init cppc_freq_invariance_init(void)
>>     static void cppc_freq_invariance_exit(void)
>>   {
>> -    if (fie_disabled)
>> -        return;
>> -
>> -    kthread_destroy_worker(kworker_fie);
>> +    if (kworker_fie)
>> +        kthread_destroy_worker(kworker_fie);
> 
> Shouldn't we have:
>   kworker_fie = NULL;
> here aswell ?
> 
I don't think it's needed.
This is where we unload the cppc_cpufreq module.  'kworker_fie' will no
longer be used after this, and it will be initialized to NULL again when
reloading the module.

I can't think of any other buggy scenarios.
>>   }
>>     #else
> 
> 
> Otherwise, for the 3 patches:
> 
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> 
Thanks!
Jie

