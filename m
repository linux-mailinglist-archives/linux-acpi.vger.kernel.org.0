Return-Path: <linux-acpi+bounces-19362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E529FC93892
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Nov 2025 07:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 56BC23460D3
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Nov 2025 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6346522259A;
	Sat, 29 Nov 2025 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2+EgnisD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B214A0C;
	Sat, 29 Nov 2025 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764396169; cv=none; b=s6NwnQbXmohgHmsZJr9N/5bfMRpY6tRMnuQJbAPa/yH1ikSDbv0ktOcsZR4Dhzw06abCW2NDt/dS6MGGc48A72g7fPBDYIvORYw6F1rGuMn+m7J+WCiWwWqpjzIsZHGVVfsxkO2yDlE9rM6nt4d4YIbKvrH9s+IbfTvDf8sJgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764396169; c=relaxed/simple;
	bh=17ycwNbljZml7BpV2pyATXWbnPeSdos01iSwJTVjSCY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YGbxN91EoMO072v5QvYzBb2b6rp41POzNo6o/13CnWc4ef7lAhZDH7gIiuOnMFBGg9HlV76dMAtBKZ0L+/SGDwcx2MQxYvVGchmpzFQ4b9sX8FSvcDLK52I+F93q6zL4YQA6LBwlXI90IakE5yR5rVGxiin2dHXvAKVOGJHRLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2+EgnisD; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RaRss7s/NaHW7Xe2tUJ5i4/pfOfpLaWqNS8gZXcWF5Q=;
	b=2+EgnisDLCPKI1JTbCmUzGDjlGP8day5M6UdWsryZYfghwWq/NPvcG0MAD8Qj2zlL+rayPoGm
	JHmC3oNfUoKth2zp3Hd2cV46k/8bfuKNaJzoo/FoZ6aG+OmmQdcv4keBe+xAaacLKkixxp06+pa
	BsFr3FE4Z5EHDYuo5U1fH2I=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dJKKD28z9z1K97f;
	Sat, 29 Nov 2025 14:00:48 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 548DF1800B2;
	Sat, 29 Nov 2025 14:02:36 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 29 Nov 2025 14:02:35 +0800
Subject: Re: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO
 timers
To: Will Deacon <will@kernel.org>
CC: Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>
References: <20251030110115.1842961-1-maz@kernel.org>
 <c1edd6cc-0542-8d22-6edc-60c619c9e162@huawei.com>
 <861plrsr1l.wl-maz@kernel.org>
 <5a742d2a-ac57-f060-913a-6bc9db1e71a2@huawei.com>
 <aShpQ4iDceJ7-Nzs@willie-the-truck>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <71cbdfbc-9281-b0d8-1590-ac666f4f5194@huawei.com>
Date: Sat, 29 Nov 2025 14:02:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aShpQ4iDceJ7-Nzs@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Hi Will,

On 2025/11/27 23:07, Will Deacon wrote:
> Hey Hanjun,
> 
> On Fri, Nov 21, 2025 at 09:14:04PM +0800, Hanjun Guo wrote:
>> On 2025/11/21 16:55, Marc Zyngier wrote:
>>> On Fri, 21 Nov 2025 02:53:17 +0000,
>>> Hanjun Guo <guohanjun@huawei.com> wrote:
>>>>
>>>> On 2025/10/30 19:01, Marc Zyngier wrote:
>>>>> Use the actual timer counter instead of the watchdog counter.
>>>>>
>>>>> Fixes: 5669d92f3efa4 ("ACPI: GTDT: Generate platform devices for MMIO timers")
>>>>> Reported-by: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
>>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>>> Cc: Hanjun Guo <guohanjun@huawei.com>
>>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>> ---
>>>>>     drivers/acpi/arm64/gtdt.c | 4 ++--
>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>>>>> index fd995a1d3d248..8cc8af8fd408c 100644
>>>>> --- a/drivers/acpi/arm64/gtdt.c
>>>>> +++ b/drivers/acpi/arm64/gtdt.c
>>>>> @@ -430,10 +430,10 @@ static int __init gtdt_platform_timer_init(void)
>>>>>     				continue;
>>>>>       			pdev = platform_device_register_data(NULL,
>>>>> "gtdt-arm-mmio-timer",
>>>>> -							     gwdt_count, &atm,
>>>>> +							     mmio_timer_count, &atm,
>>>>>     							     sizeof(atm));
>>>>>     			if (IS_ERR(pdev)) {
>>>>> -				pr_err("Can't register timer %d\n", gwdt_count);
>>>>> +				pr_err("Can't register timer %d\n", mmio_timer_count);
>>>>>     				continue;
>>>>>     			}
>>>>
>>>> "typo" I think :)
>>>>
>>>> Acked-by: Hanjun Guo <guohanjun@huawei.com>
>>>>
>>>> Will this go via ARM64 tree?
>>>
>>> Is that where the ACPI updates are routed to? This fixes a patch that
>>> was routed tip, so I'd have expected this to go via the same route.
>>>
>>> In any case, I've added Catalin and Will on Cc.
>>
>> Yes, ARM64 ACPI code merged via ARM64 tree.
> 
> Catalin and I were chatting the other day and we wondered whether it's
> worth adding something to MAINTAINERS so that we get CC'd on arm64 ACPI
> patches without you having to add us in manually? We wouldn't merge
> anything without an Ack from somebody listed under the "ACPI FOR ARM64"
> entry but it would mean that we get picked up by get_maintainer.pl.
> 
> What do you think?

Looks great to me!

> 
> I can't tell whether this would be best as an F: line under the arm64
> architecture entry, or adding us as R:/M: for the ACPI/arm64 entry.

How about adding M: for the ACPI/arm64 entry? I can send a patch
for this change if you and Catalin agree with it.

Thanks
Hanjun

