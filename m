Return-Path: <linux-acpi+bounces-8800-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A0E99F01B
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 16:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEF428121E
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Oct 2024 14:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F171C4A0C;
	Tue, 15 Oct 2024 14:50:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6171B2188;
	Tue, 15 Oct 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003821; cv=none; b=bU/GrGsnkxkU4Ak3EtT+b3fwail8apElwRhOWRwl/x7ecMRJac/dhsMxRO4yYG2xr3bEjR4wCRCdULFd87gAO4pRIVwO2m+YOng9BAPYFOT16qV0WlbvSFCtz52N/8jPlrlzyWPm67X3fXp5SdqCDcm6ZKAYmUyeV8bU+TB3Y1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003821; c=relaxed/simple;
	bh=thdxTZMDAG8U7X9+iq8AZRYrXlpkl2sYnuB79twbLeY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CrMYyP78Cuk6EUT777sEKsbF/x8lyCxfrYq5V48w3f10iE6+t3lTxhDAB4BTGoj+UQ7WkESR5j4B97/1Wf9CzbAOrWUsmz1oX9QY+mlacsI1ESi+5XyQY1UtKzl5puBLGj8ZfhAFSnZhLC9qEOmTze3TVm48GSLyjgL9wO2DmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XScRp0Ky9zyTJ1;
	Tue, 15 Oct 2024 22:48:54 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C6961401F4;
	Tue, 15 Oct 2024 22:50:17 +0800 (CST)
Received: from [10.174.162.134] (10.174.162.134) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 15 Oct 2024 22:50:15 +0800
Subject: Re: [PATCH v2] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
To: Marc Zyngier <maz@kernel.org>
CC: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<mark.rutland@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241012085343.6594-1-zhengzengkai@huawei.com>
 <8734l1usxe.wl-maz@kernel.org>
 <f316e8b5-c4c9-da6f-26e8-395cb7500f1d@huawei.com>
 <868quq69ro.wl-maz@kernel.org>
From: Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <4333e8bd-89ed-f1cc-2f1d-ec539362a704@huawei.com>
Date: Tue, 15 Oct 2024 22:50:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <868quq69ro.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200010.china.huawei.com (7.221.188.124)

Hi Marc,

在 2024/10/14 22:26, Marc Zyngier 写道:
> On Mon, 14 Oct 2024 13:22:26 +0100,
> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>> Hi Marc,
>>
>> 在 2024/10/13 1:34, Marc Zyngier 写道:
>>> On Sat, 12 Oct 2024 09:53:43 +0100,
>>> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>>>> As suggested by Marc and Lorenzo, first we need to check whether the
>>>> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
>>>> de-referencing what it points at to detect the length of the platform
>>>> timer struct and then check that the length of current platform_timer
>>>> struct is within gtdt_end too. Now next_platform_timer() only checks
>>>> against gtdt_end for the entry of subsequent platform timer without
>>>> checking the length of it and will not report error if the check failed.
>>>>
>>>> Add check against table length (gtdt_end) for each element of platform
>>>> timer array in acpi_gtdt_init() early, making sure that both their entry
>>>> and length actually fit in the table.
>>>>
>>>> For the first platform timer, keep the check against the end of the
>>>> acpi_table_gtdt struct, it is unnecessary for subsequent platform timer.
>>> Really?
>>>
>>>> Suggested-by: Marc Zyngier <maz@kernel.org>
>>>> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
>>>> ---
>>>> Changes in v2:
>>>> - Check against gtdt_end for both entry and len of each array element
>>>>
>>>> v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
>>>> ---
>>>>    drivers/acpi/arm64/gtdt.c | 19 +++++++++++++++----
>>>>    1 file changed, 15 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>>>> index c0e77c1c8e09..f5f62643899d 100644
>>>> --- a/drivers/acpi/arm64/gtdt.c
>>>> +++ b/drivers/acpi/arm64/gtdt.c
>>>> @@ -157,6 +157,8 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>>>    {
>>>>    	void *platform_timer;
>>>>    	struct acpi_table_gtdt *gtdt;
>>>> +	struct acpi_gtdt_header *gh;
>>>> +	void *struct_end;
>>>>      	gtdt = container_of(table, struct acpi_table_gtdt, header);
>>>>    	acpi_gtdt_desc.gtdt = gtdt;
>>>> @@ -177,11 +179,20 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>>>    	}
>>>>      	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>>>> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
>>>> -		pr_err(FW_BUG "invalid timer data.\n");
>>>> -		return -EINVAL;
>>>> +	struct_end = (void *)table + sizeof(struct acpi_table_gtdt);
>>>> +	for (int i = 0; i < gtdt->platform_timer_count; i++) {
>>>> +		gh = platform_timer;
>>>> +		if (((i == 0 && platform_timer >= struct_end) || i != 0) &&
>>> Why is only index 0 checked against the end of the table? Shouldn't
>>> int be an invariant that all timer descriptions must not intersect
>>> with the non-variable part of the GTDT table?
>>
>> AFAICS, after checking against the end of the acpi_table_gtdt struct for the
>> first platform timer, the subsequent platform_timer pointer value
>> computed via "platform_timer + gh->length" will also pass the check,
>> as the gh->length is of u16 type.
> But this is something that isn't obvious to the casual reader of this
> code, and you want to keep validation code simple and localised, with
> as few separate cases as you can. This isn't performance critical
> code, and there is nothing to be gained by "optimising" this.


OK


>>
>>>> +			platform_timer < acpi_gtdt_desc.gtdt_end &&
>>>> +			platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end) {
>>> Surely, assuming that length isn't zero, if the last term is true, the
>>> previous one also is? And what if it is 0?
>>
>> Agree , the length should also be checked against 0,
>> but I think we should first check the platform_timer entry pointer,
>> then check the size of the same platform_timer structure,
>> not check them in the opposite order.
> Correct, that's something that needs fixing. Run with it.
>
> 	M.


OK,  I will do that.

Thanks!



