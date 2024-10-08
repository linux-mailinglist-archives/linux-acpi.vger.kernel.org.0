Return-Path: <linux-acpi+bounces-8608-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C719950FF
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC431F26643
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD51DFD81;
	Tue,  8 Oct 2024 14:05:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA31DF25D;
	Tue,  8 Oct 2024 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396317; cv=none; b=CghKuY9Uct5TyLSLazXKPuQ8Mn+0NuedCf7Z+2GqtbBDKV2zyfYxDi9VkhuJyOBfUeTIVYLIr773sZq1jOuOlHJ5A+c9N899DJBzqKccQ7z6WpE2dG75PywVqapHSflE5uOvU8sVbXABr+mG2BNwvdTvKHQC90D4RRueQTVdFrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396317; c=relaxed/simple;
	bh=PTNke107SXU71vG2qIJWjzH/i2LTHqtJyFWHIFg7khM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iUFNZM2QRK0lqrOSUOjCw/C0/Ll2u2f0r5fpnZ1i8MyAI3y8fjrzlN1X5n21kmLyWaXAuPVo40F6Fry7iiwB+VuTc3E8nWCb3QN1ekUJPAzu8Yn1szREUMThFbLRSuVPXG7V3KNRWnIiuL/dkO+e+XS9Tzr4AGxWcVC94ZGCIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XNHpd1FTXz1ymTW;
	Tue,  8 Oct 2024 22:05:13 +0800 (CST)
Received: from kwepemd200010.china.huawei.com (unknown [7.221.188.124])
	by mail.maildlp.com (Postfix) with ESMTPS id D91CA1402C6;
	Tue,  8 Oct 2024 22:05:08 +0800 (CST)
Received: from [10.174.162.134] (10.174.162.134) by
 kwepemd200010.china.huawei.com (7.221.188.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 8 Oct 2024 22:05:07 +0800
Subject: Re: [PATCH v2] ACPI: GTDT: simplify acpi_gtdt_init() implementation
To: Marc Zyngier <maz@kernel.org>
CC: <lpieralisi@kernel.org>, <guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<mark.rutland@arm.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241008082429.33646-1-zhengzengkai@huawei.com>
 <86v7y355zr.wl-maz@kernel.org>
From: Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <57e9adb8-a34a-6d63-24b8-4ad0abb74bf9@huawei.com>
Date: Tue, 8 Oct 2024 22:04:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86v7y355zr.wl-maz@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200010.china.huawei.com (7.221.188.124)


ÔÚ 2024/10/8 16:55, Marc Zyngier Ð´µÀ:
> On Tue, 08 Oct 2024 09:24:29 +0100,
> Zheng Zengkai <zhengzengkai@huawei.com> wrote:
>> According to GTDT Table Structure of ACPI specification, the result of
>> expression '(void *)gtdt + gtdt->platform_timer_offset' will be same
>> with the expression '(void *)table + sizeof(struct acpi_table_gtdt)'
> There is no such language in the spec. It simply says "Offset to the
> Platform Timer Structure[] array from the start of this table".
OK, I mean that in current code, the condition of this check is redundant.
>> in function acpi_gtdt_init(), so the condition of the "invalid timer
>> data" check will never be true, remove the EINVAL error check branch
>> and change to void return type for acpi_gtdt_init() to simplify the
>> function implementation and error handling by callers.
> And ACPI tables are well known to be always correct, right?
Not always, check is needed, but should be changed.
>> Besides, after commit c2743a36765d ("clocksource: arm_arch_timer: add
>> GTDT support for memory-mapped timer"), acpi_gtdt_init() currently will
>> not be called with parameter platform_timer_count set to NULL and we
>> can explicitly initialize the integer variable which is used for storing
>> the number of platform timers by caller to zero, so there is no need to
>> do null pointer check for platform_timer_count in acpi_gtdt_init(),
>> remove it to make code a bit more concise.
>>
>> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
>> ---
>> Changes in v2:
>> - initialize 'ret' in gtdt_sbsa_gwdt_init() to silence build warning
>>
>> v1: https://lore.kernel.org/all/20240930030716.179992-1-zhengzengkai@huawei.com/
>> ---
>>   drivers/acpi/arm64/gtdt.c            | 31 +++++++---------------------
>>   drivers/clocksource/arm_arch_timer.c |  6 ++----
>>   include/linux/acpi.h                 |  2 +-
>>   3 files changed, 11 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
>> index c0e77c1c8e09..7fe27c0edde7 100644
>> --- a/drivers/acpi/arm64/gtdt.c
>> +++ b/drivers/acpi/arm64/gtdt.c
>> @@ -147,45 +147,30 @@ bool __init acpi_gtdt_c3stop(int type)
>>    * @table:			The pointer to GTDT table.
>>    * @platform_timer_count:	It points to a integer variable which is used
>>    *				for storing the number of platform timers.
>> - *				This pointer could be NULL, if the caller
>> - *				doesn't need this info.
>> - *
>> - * Return: 0 if success, -EINVAL if error.
>>    */
>> -int __init acpi_gtdt_init(struct acpi_table_header *table,
>> +void __init acpi_gtdt_init(struct acpi_table_header *table,
>>   			  int *platform_timer_count)
>>   {
>> -	void *platform_timer;
>>   	struct acpi_table_gtdt *gtdt;
>>   
>>   	gtdt = container_of(table, struct acpi_table_gtdt, header);
>>   	acpi_gtdt_desc.gtdt = gtdt;
>>   	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>>   	acpi_gtdt_desc.platform_timer = NULL;
>> -	if (platform_timer_count)
>> -		*platform_timer_count = 0;
>>   
>>   	if (table->revision < 2) {
>>   		pr_warn("Revision:%d doesn't support Platform Timers.\n",
>>   			table->revision);
>> -		return 0;
>> +		return;
>>   	}
>>   
>>   	if (!gtdt->platform_timer_count) {
>>   		pr_debug("No Platform Timer.\n");
>> -		return 0;
>> +		return;
>>   	}
>>   
>> -	platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
>> -	if (platform_timer < (void *)table + sizeof(struct acpi_table_gtdt)) {
>> -		pr_err(FW_BUG "invalid timer data.\n");
>> -		return -EINVAL;
>> -	}
>> -	acpi_gtdt_desc.platform_timer = platform_timer;
>> -	if (platform_timer_count)
>> -		*platform_timer_count = gtdt->platform_timer_count;
>> -
>> -	return 0;
>> +	acpi_gtdt_desc.platform_timer = (void *)gtdt + gtdt->platform_timer_offset;
> And now you are trusting something that potentially points to some
> unexpected location, blindly using it. It is bad enough that the
> current checks are pretty poor (no check against the end of the
> table for the first timer entry), but you are making it worse.
>
> 	M.

Can I use the second and third bytes (the length) of platform timer 
structure to

check against the end of the table ?

Thanks!


