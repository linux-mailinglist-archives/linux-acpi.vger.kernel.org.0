Return-Path: <linux-acpi+bounces-19182-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A499C792BD
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 14:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E2D4E440E
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Nov 2025 13:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503472F363E;
	Fri, 21 Nov 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0JK4E4bw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984912F0696;
	Fri, 21 Nov 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730859; cv=none; b=s3WAmfVRIcLb4G9h6r9h/aEr4G7dUbDSM/INoGvxUE/WFlMQ1dy9oUL972Y5LqWZK6hLgO8vD7zkgSc4mudDxr+K7YI66zvkolCnhzBwdOnE36d6b0AIAos3RPuiS/pzlbXtAmOLyN1uM6w5WZnJCmOu8c0rh3x9Vp8taqqysFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730859; c=relaxed/simple;
	bh=t+FL0Vzg8LZUNfVMzm1/qKK5KV+qrzm8EQUg5vgLqYE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HsM4q4H9R5gQ50lMWmIcbGoFXkzMSsFJzO6ZExCtxEWlTVYTm9/wwuqSrHAHgcPYQkemZaU+2/F2Rt85IGTdvHG5wO3e/N7U5MGyzgA47KQnCg8fNy+MJNfsajI4MZoAREVlGpaLseDqUttdYB9Dy77K9s8pQyyVz6PYvvbKEfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0JK4E4bw; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lZPLXYPf5pxiZF5gN1ikjGYuRqtfFHZPNhqlAnTmMGU=;
	b=0JK4E4bwnxZheqFQwbA9g7Rf5lPzF+PMFGSdgCjE3rzG6gIeHSBlbBVhfXEuaHv5XNzgFIAKh
	5Z9XTRYQAq9wLxGxjjI0C/OvgN+7JFmDjhhN+CimnIv1wa6CP7xJ7913ryvCwFwYluSNKdEBibu
	OsIcJaW4XhaMmqhm38IW0FA=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dCbGv0bcWz1K96F;
	Fri, 21 Nov 2025 21:12:23 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F3011A0188;
	Fri, 21 Nov 2025 21:14:06 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Nov 2025 21:14:05 +0800
Subject: Re: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO
 timers
To: Marc Zyngier <maz@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Pavan
 Kondeti <pavan.kondeti@oss.qualcomm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251030110115.1842961-1-maz@kernel.org>
 <c1edd6cc-0542-8d22-6edc-60c619c9e162@huawei.com>
 <861plrsr1l.wl-maz@kernel.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5a742d2a-ac57-f060-913a-6bc9db1e71a2@huawei.com>
Date: Fri, 21 Nov 2025 21:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <861plrsr1l.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/21 16:55, Marc Zyngier wrote:
> On Fri, 21 Nov 2025 02:53:17 +0000,
> Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> On 2025/10/30 19:01, Marc Zyngier wrote:
>>> Use the actual timer counter instead of the watchdog counter.
>>>
>>> Fixes: 5669d92f3efa4 ("ACPI: GTDT: Generate platform devices for MMIO timers")
>>> Reported-by: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> Cc: Hanjun Guo <guohanjun@huawei.com>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> ---
>>>    drivers/acpi/arm64/gtdt.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>>> index fd995a1d3d248..8cc8af8fd408c 100644
>>> --- a/drivers/acpi/arm64/gtdt.c
>>> +++ b/drivers/acpi/arm64/gtdt.c
>>> @@ -430,10 +430,10 @@ static int __init gtdt_platform_timer_init(void)
>>>    				continue;
>>>      			pdev = platform_device_register_data(NULL,
>>> "gtdt-arm-mmio-timer",
>>> -							     gwdt_count, &atm,
>>> +							     mmio_timer_count, &atm,
>>>    							     sizeof(atm));
>>>    			if (IS_ERR(pdev)) {
>>> -				pr_err("Can't register timer %d\n", gwdt_count);
>>> +				pr_err("Can't register timer %d\n", mmio_timer_count);
>>>    				continue;
>>>    			}
>>
>> "typo" I think :)
>>
>> Acked-by: Hanjun Guo <guohanjun@huawei.com>
>>
>> Will this go via ARM64 tree?
> 
> Is that where the ACPI updates are routed to? This fixes a patch that
> was routed tip, so I'd have expected this to go via the same route.
> 
> In any case, I've added Catalin and Will on Cc.

Yes, ARM64 ACPI code merged via ARM64 tree.

Thanks
Hanjun

