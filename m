Return-Path: <linux-acpi+bounces-8808-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324CD9A049E
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 10:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BEA1C21458
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2024 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48614202F63;
	Wed, 16 Oct 2024 08:49:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268161865E2;
	Wed, 16 Oct 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068584; cv=none; b=jV16jkJjqb0j2PZPPFJ7Uede+l6kJKXcywNChKjUsWj6Jt1aDWafHuR3hYBUDh2tcfjBG26Sd2tWQrFfr3LwYtn2BaW48Zx9Keu9Msu4qhv+3gY1FA6BVia9N38An+puXk3uFUxYBFmzvnZlicdS2EeblWsNG/uWLDSjVeDa5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068584; c=relaxed/simple;
	bh=vkvuwCURHLuwXxOfCJFJX0cte944VNl4VhcckEIF+Kg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GGKXvzJ4WuBbd8gb2xXCxbd3EHRXwaPORe/dEm3U535pSVWeF7icPDmSBWYB91bqomIwH6RCKHXEDca1AoU8SW8hkysOO+gW7x3/O88jWD5EbTxsrPi/ZKIN0u/Ryd+ZojA5LqTusdwFYboIxnske24qm4wgqqEJWsGG42nzcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XT4Py1lmHz20q7J;
	Wed, 16 Oct 2024 16:48:54 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AC8C1A0188;
	Wed, 16 Oct 2024 16:49:38 +0800 (CST)
Received: from [10.174.162.134] (10.174.162.134) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 16 Oct 2024 16:49:37 +0800
Subject: Re: [PATCH v3] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: <guohanjun@huawei.com>, <sudeep.holla@arm.com>, <mark.rutland@arm.com>,
	<maz@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241015152602.184108-1-zhengzengkai@huawei.com>
 <Zw6b3V5Mk2tIGmy5@lpieralisi>
From: Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <4cea2a07-49b0-7703-4cdf-49ded9a2c9e4@huawei.com>
Date: Wed, 16 Oct 2024 16:49:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zw6b3V5Mk2tIGmy5@lpieralisi>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200010.china.huawei.com (7.221.188.124)

Hi Lorenzo,

ÔÚ 2024/10/16 0:44, Lorenzo Pieralisi Ð´µÀ:
> On Tue, Oct 15, 2024 at 11:26:02PM +0800, Zheng Zengkai wrote:
>> As suggested by Marc and Lorenzo, first we need to check whether the
> I would just describe the change, the tags and Link: are there to
> describe this patch history.


Do you mean that the previous patch below also need to be listed in this 
change log history?

https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/


>> platform_timer entry pointer is within gtdt bounds (< gtdt_end) before
>> de-referencing what it points at to detect the length of the platform
>> timer struct and then check that the length of current platform_timer
>> struct is also valid, i.e. the length is not zero and within gtdt_end.
>> Now next_platform_timer() only checks against gtdt_end for the entry of
>> subsequent platform timer without checking the length of it and will
>> not report error if the check failed and the existing check in function
>> acpi_gtdt_init() is also not enough.
>>
>> Modify the for_each_platform_timer() iterator and use it combined with
>> a dedicated check function platform_timer_valid() to do the check
>> against table length (gtdt_end) for each element of platform timer
>> array in function acpi_gtdt_init(), making sure that both their entry
>> and length actually fit in the table.
>>
>> Suggested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Co-developed-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
>> ---
>> Changes in v3:
>> - based on Marc's patch and reuse the for_each_platform_timer() loop
>>
>> Changes in v2:
>> - Check against gtdt_end for both entry and len of each array element
>> Link to v2: https://lore.kernel.org/linux-arm-kernel/20241012085343.6594-1-zhengzengkai@huawei.com/
>>
>> Link to v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
>> ---
>>   drivers/acpi/arm64/gtdt.c | 32 +++++++++++++++++++++-----------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index c0e77c1c8e09..3583c99afb0d 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -36,19 +36,25 @@ struct acpi_gtdt_descriptor {
>>   
>>   static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>>   
>> -static inline __init void *next_platform_timer(void *platform_timer)
>> +static __init bool platform_timer_valid(void *platform_timer)
>>   {
>>   	struct acpi_gtdt_header *gh = platform_timer;
>>   
>> -	platform_timer += gh->length;
>> -	if (platform_timer < acpi_gtdt_desc.gtdt_end)
>> -		return platform_timer;
>> +	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
>> +		platform_timer < acpi_gtdt_desc.gtdt_end &&
>> +		gh->length != 0 &&
>> +		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
>> +}
>> +
>> +static __init void *next_platform_timer(void *platform_timer)
>> +{
>> +	struct acpi_gtdt_header *gh = platform_timer;
>>   
>> -	return NULL;
>> +	return platform_timer + gh->length;
>>   }
>>   
>> -#define for_each_platform_timer(_g)				\
>> -	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
>> +#define for_each_platform_timer(_g, first_entry)	\
>> +	for (_g = first_entry; platform_timer_valid(_g);	\
>>   	     _g = next_platform_timer(_g))
>>   
>>   static inline bool is_timer_block(void *platform_timer)
>> @@ -155,8 +161,9 @@ bool __init acpi_gtdt_c3stop(int type)
>>   int __init acpi_gtdt_init(struct acpi_table_header *table,
>>   			  int *platform_timer_count)
>>   {
>> -	void *platform_timer;
>> +	void *platform_timer, *tmp;
> It makes more sense - thank you and Marc.
>
> Nit: you don't really need another pointer (ie tmp) but you may keep
> it if that makes the code clearer - all you need to do is using
> platform_timer as an iterator and initialize


Yes, the tmp pointer can be removed for conciseness.

Thanks!


>
> 	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>
> if all checks passed (you are using tmp just because after the loop
> platform_timer can't be used to initialize acpi_gtdt_desc.platform_timer).
>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>
> (now let's see if this survives GTDTs out there :))
>>   	struct acpi_table_gtdt *gtdt;
>> +	int cnt = 0;
>>   
>>   	gtdt = container_of(table, struct acpi_table_gtdt, header);
>>   	acpi_gtdt_desc.gtdt = gtdt;
>> @@ -177,7 +184,10 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>   	}
>>   
>>   	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
>> +	for_each_platform_timer(tmp, platform_timer)
>> +		cnt++;
>> +
>> +	if (cnt != gtdt->platform_timer_count) {
>>   		pr_err(FW_BUG "invalid timer data.\n");
>>   		return -EINVAL;
>>   	}
>> @@ -305,7 +315,7 @@ int __init acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem,
>>   	void *platform_timer;
>>   
>>   	*timer_count = 0;
>> -	for_each_platform_timer(platform_timer) {
>> +	for_each_platform_timer(platform_timer, acpi_gtdt_desc.platform_timer) {
>>   		if (is_timer_block(platform_timer)) {
>>   			ret = gtdt_parse_timer_block(platform_timer, timer_mem);
>>   			if (ret)
>> @@ -398,7 +408,7 @@ static int __init gtdt_sbsa_gwdt_init(void)
>>   	if (ret || !timer_count)
>>   		goto out_put_gtdt;
>>   
>> -	for_each_platform_timer(platform_timer) {
>> +	for_each_platform_timer(platform_timer, acpi_gtdt_desc.platform_timer) {
>>   		if (is_non_secure_watchdog(platform_timer)) {
>>   			ret = gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
>>   			if (ret)
>> -- 
>> 2.20.1
>>
> .
>

