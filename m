Return-Path: <linux-acpi+bounces-8752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9D99C9FC
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 14:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6480CB24235
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033EF19F43B;
	Mon, 14 Oct 2024 12:22:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F707E574;
	Mon, 14 Oct 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908553; cv=none; b=D10Y2/TJGV+0Mx8xyAa5Wk6cM104xD1t6AkMuPibdO+KZ1WveoAOO+nLPHx7ZdjJMU8IxU+DapeTY+j+NQoZPIBXU7uACiLltfP333QhCbvzzz6/B2VI4eaa9LcAsmG3xkp7RAtyQOWBbcZ+WGZ6+nhLpsAG/LELMpxu5DDq4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908553; c=relaxed/simple;
	bh=KYuZko1HpxDoLSWLWeZMeIWV/ky/H3yVkCUVxDuGZxQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ur4Ye6FvL9sFbM6+dB32zodmLr1yLgg2yqcjznumsNyHY7xrO1mr7ANUsWKhLXqjGX/9aqSOTnkkc9CJVDomGKwCOmqVp4v/sLF2aLjc7zNIBbkKa4VZuOGcJL9wnMdQYue4VayNSkcFyO6ZHIeDq5RUorkJx5rpWmg+RFp0Als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XRxBV4zQKzkWhL;
	Mon, 14 Oct 2024 20:20:02 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id CE3451402CA;
	Mon, 14 Oct 2024 20:22:28 +0800 (CST)
Received: from [10.174.162.134] (10.174.162.134) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 14 Oct 2024 20:22:27 +0800
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
From: Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <f316e8b5-c4c9-da6f-26e8-395cb7500f1d@huawei.com>
Date: Mon, 14 Oct 2024 20:22:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8734l1usxe.wl-maz@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200010.china.huawei.com (7.221.188.124)

Hi Marc,

ÔÚ 2024/10/13 1:34, Marc Zyngier Ð´µÀ:
> On Sat, 12 Oct 2024 09:53:43 +0100,
> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>> As suggested by Marc and Lorenzo, first we need to check whether the
>> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
>> de-referencing what it points at to detect the length of the platform
>> timer struct and then check that the length of current platform_timer
>> struct is within gtdt_end too. Now next_platform_timer() only checks
>> against gtdt_end for the entry of subsequent platform timer without
>> checking the length of it and will not report error if the check failed.
>>
>> Add check against table length (gtdt_end) for each element of platform
>> timer array in acpi_gtdt_init() early, making sure that both their entry
>> and length actually fit in the table.
>>
>> For the first platform timer, keep the check against the end of the
>> acpi_table_gtdt struct, it is unnecessary for subsequent platform timer.
> Really?
>
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
>> ---
>> Changes in v2:
>> - Check against gtdt_end for both entry and len of each array element
>>
>> v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
>> ---
>>   drivers/acpi/arm64/gtdt.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index c0e77c1c8e09..f5f62643899d 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -157,6 +157,8 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>   {
>>   	void *platform_timer;
>>   	struct acpi_table_gtdt *gtdt;
>> +	struct acpi_gtdt_header *gh;
>> +	void *struct_end;
>>   
>>   	gtdt = container_of(table, struct acpi_table_gtdt, header);
>>   	acpi_gtdt_desc.gtdt = gtdt;
>> @@ -177,11 +179,20 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>   	}
>>   
>>   	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
>> -		pr_err(FW_BUG "invalid timer data.\n");
>> -		return -EINVAL;
>> +	struct_end = (void *)table + sizeof(struct acpi_table_gtdt);
>> +	for (int i = 0; i < gtdt->platform_timer_count; i++) {
>> +		gh = platform_timer;
>> +		if (((i == 0 && platform_timer >= struct_end) || i != 0) &&
> Why is only index 0 checked against the end of the table? Shouldn't
> int be an invariant that all timer descriptions must not intersect
> with the non-variable part of the GTDT table?


AFAICS, after checking against the end of the acpi_table_gtdt struct for the

first platform timer, the subsequent platform_timer pointer value

computed via "platform_timer + gh->length" will also pass the check,

as the gh->length is of u16 type.


>> +			platform_timer < acpi_gtdt_desc.gtdt_end &&
>> +			platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end) {
> Surely, assuming that length isn't zero, if the last term is true, the
> previous one also is? And what if it is 0?


Agree , the length should also be checked against 0,

but I think we should first check the platform_timer entry pointer,

then check the size of the same platform_timer structure,

not check them in the opposite order.


> Again, you cannot trust *anything* you find in the ACPI table.
>
>> +			platform_timer += gh->length;
> You are also reinventing the wheel, and repeating some of the worse
> constructs in this code. It would be much better to build on (and
> augment) the existing primitives to make the code *readable* instead
> of being this pointer soup. Believe it or not, there is some value in
> abstracting things.


Yes. Abstract things common and reuse it is better.


> I came up with the patchlet below, very lightly tested on my
> Synquacer. It may not be optimal, but given that this is used exactly
> once per boot, I'm sure we can afford a few extra comparisons. It
> makes the iterator robust, and then uses that to implement the checks.
>
> 	M.
>
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index c0e77c1c8e09d..dca814183cc5c 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -36,15 +36,24 @@ struct acpi_gtdt_descriptor {
>   
>   static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>   
> -static inline __init void *next_platform_timer(void *platform_timer)
> +static __init bool platform_timer_valid(void *platform_timer)
>   {
>   	struct acpi_gtdt_header *gh = platform_timer;
>   
> -	platform_timer += gh->length;
> -	if (platform_timer < acpi_gtdt_desc.gtdt_end)
> -		return platform_timer;
> +	return (gh->length != 0 &&


Shall we first check against gtdt_end for the platform_timer entry?

making sure that platform timer entry(the gh) is within gtdt_end

and valid


Thanks!


> +		platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
> +		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
> +}
> +
> +static __init void *next_platform_timer(void *platform_timer)
> +{
> +	struct acpi_gtdt_header *gh = platform_timer;
>   
> -	return NULL;
> +	if (!platform_timer_valid(platform_timer) ||
> +	    !platform_timer_valid(platform_timer + gh->length))
> +		return NULL;
> +
> +	return platform_timer + gh->length;
>   }
>   
>   #define for_each_platform_timer(_g)				\
> @@ -155,8 +164,9 @@ bool __init acpi_gtdt_c3stop(int type)
>   int __init acpi_gtdt_init(struct acpi_table_header *table,
>   			  int *platform_timer_count)
>   {
> -	void *platform_timer;
> +	void *platform_timer, *tmp;
>   	struct acpi_table_gtdt *gtdt;
> +	int cnt = 0;
>   
>   	gtdt = container_of(table, struct acpi_table_gtdt, header);
>   	acpi_gtdt_desc.gtdt = gtdt;
> @@ -177,7 +187,12 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>   	}
>   
>   	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
> +	for (tmp = platform_timer;
> +	     tmp && platform_timer_valid(tmp);
> +	     tmp = next_platform_timer(tmp))
> +		cnt++;
> +
> +	if (cnt != gtdt->platform_timer_count) {
>   		pr_err(FW_BUG "invalid timer data.\n");
>   		return -EINVAL;
>   	}
>

