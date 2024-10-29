Return-Path: <linux-acpi+bounces-9076-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE89B4BEF
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 15:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD0283FDC
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D95206E81;
	Tue, 29 Oct 2024 14:16:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293BB206E65;
	Tue, 29 Oct 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211415; cv=none; b=SIbglT1DhVYmbrOI7pE4eobO0eJlb4pme4ue7r8s07plenKEsZYZQWfNfih7s+q17WU4XnnzXmJen7CMzTJMzeXTLdThtpaaAz+iesLQ3f3xcZHOti9O7Q805M5oWkqF0X0h0T+4UZ5AulO8gMDzyeUWPJ2w2tynPjaR9WEr8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211415; c=relaxed/simple;
	bh=frx8sGu1rwCpvPaSoX5EhggfnwG/IG6G9kp99x8qhoo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HRzhJ1n9wjalbqv3pgXRNOcTk2aN8zUPNfg3P74WSuWM9GuaVXTNcJfnGU5R2pmWuB2dQ+/+4TVidlFRC9LIizFim9JALP/zbs2tYi15Cq3NmoRujV8EC3+s/VqBqpE5on6o2FX40yami1qIExxUJEEwgEZ3yIgP0wgY6JlrSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XdC343RtGzQsBc;
	Tue, 29 Oct 2024 22:15:44 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CCAF140157;
	Tue, 29 Oct 2024 22:16:43 +0800 (CST)
Received: from [10.174.162.134] (10.174.162.134) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 29 Oct 2024 22:16:42 +0800
Subject: Re: [PATCH v4] ACPI: GTDT: Tighten the check for the array of
 platform timer structures
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: <guohanjun@huawei.com>, <sudeep.holla@arm.com>, <mark.rutland@arm.com>,
	<maz@kernel.org>, <rafael@kernel.org>, <lenb@kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241016095458.34126-1-zhengzengkai@huawei.com>
 <Zw+O4nZisbkdvNtz@lpieralisi>
From: Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <3bf1fe29-e135-c1ba-2774-d1e98c8b92b3@huawei.com>
Date: Tue, 29 Oct 2024 22:16:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zw+O4nZisbkdvNtz@lpieralisi>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200010.china.huawei.com (7.221.188.124)


Gentle ping.

This patch still can be applied to upstream now.

Thanks!


ÔÚ 2024/10/16 18:01, Lorenzo Pieralisi Ð´µÀ:
> On Wed, Oct 16, 2024 at 05:54:58PM +0800, Zheng Zengkai wrote:
>> As suggested by Marc and Lorenzo, first we need to check whether the
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
>> Changes in v4:
>> - remove the tmp pointer to make the code more concise.
>>
>> Changes in v3:
>> - based on Marc's patch and reuse the for_each_platform_timer() loop
>> Link to v3: https://lore.kernel.org/linux-arm-kernel/20241015152602.184108-1-zhengzengkai@huawei.com/
>>
>> Changes in v2:
>> - Check against gtdt_end for both entry and len of each array element
>> Link to v2: https://lore.kernel.org/linux-arm-kernel/20241012085343.6594-1-zhengzengkai@huawei.com/
>>
>> Link to v1: https://lore.kernel.org/all/20241010144703.113728-1-zhengzengkai@huawei.com/
>>
>> Link to previous related patches:
>> https://lore.kernel.org/all/20241008082429.33646-1-zhengzengkai@huawei.com/
>> https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/
>> ---
>>   drivers/acpi/arm64/gtdt.c | 29 ++++++++++++++++++++---------
>>   1 file changed, 20 insertions(+), 9 deletions(-)
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index c0e77c1c8e09..d7c4e1b9915b 100644
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
>>   #define for_each_platform_timer(_g)				\
>> -	for (_g = acpi_gtdt_desc.platform_timer; _g;	\
>> +	for (_g = acpi_gtdt_desc.platform_timer; platform_timer_valid(_g);\
>>   	     _g = next_platform_timer(_g))
>>   
>>   static inline bool is_timer_block(void *platform_timer)
>> @@ -157,6 +163,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>   {
>>   	void *platform_timer;
>>   	struct acpi_table_gtdt *gtdt;
>> +	int cnt = 0;
>>   
>>   	gtdt = container_of(table, struct acpi_table_gtdt, header);
>>   	acpi_gtdt_desc.gtdt = gtdt;
>> @@ -176,12 +183,16 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>>   		return 0;
>>   	}
>>   
>> -	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
>> +	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>> +	for_each_platform_timer(platform_timer)
>> +		cnt++;
>> +
>> +	if (cnt != gtdt->platform_timer_count) {
>> +		acpi_gtdt_desc.platform_timer = NULL;
>>   		pr_err(FW_BUG "invalid timer data.\n");
>>   		return -EINVAL;
>>   	}
>> -	acpi_gtdt_desc.platform_timer = platform_timer;
>> +
>>   	if (platform_timer_count)
>>   		*platform_timer_count = gtdt->platform_timer_count;
>>   
>> -- 
>> 2.20.1
>>
> .
>

