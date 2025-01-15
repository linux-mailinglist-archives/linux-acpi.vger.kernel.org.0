Return-Path: <linux-acpi+bounces-10669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04EA11B50
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 08:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C903A326D
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5822C22F152;
	Wed, 15 Jan 2025 07:52:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E332080E3;
	Wed, 15 Jan 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736927534; cv=none; b=lOXVUXlHtcug88HGIKu7D9LTHxJZbcsogyceQFvF7zcpS7k+0ws900FF7iVzKiYxBkvW+10rU3eKXZ/K4W5Trcs1c0xjw+bSDiFziCnP3mENDdS32n6/+vb74dKMX5kb7HSW6ULTi480y0XYTD4n96vWY72gg4lfrWEEEutC3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736927534; c=relaxed/simple;
	bh=7gkfamUWxmOO3n7dI9pQM1/SuXoCMLQQCsK1t8MFF6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z2B0QaZ/anZ8aptmKCCZPiR6tVMIH6JGhXnPArPjl6cQD9d6ibBxCaXLvpRGRibcLoXEYnTkYzgOoClEvzROnPVd4PvaqDiWwHeAkkLImUmiDo9QFHjCidqu0yPhj9uo33dEBJjfHgJMW2UL4rCHlw7QAFZed0q1NaMPeFXaQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YXymm5GxQz1wn5t;
	Wed, 15 Jan 2025 15:48:56 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 743AB140119;
	Wed, 15 Jan 2025 15:52:07 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Jan
 2025 15:52:06 +0800
Message-ID: <c021a12a-ce3c-4266-8bc1-dc8b20525b9a@huawei.com>
Date: Wed, 15 Jan 2025 15:52:05 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>, <acpica-devel@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-2-zhenglifeng1@huawei.com>
 <CAJZ5v0ja7AaJza0PeNgutebXRV3tsgxZRwZUBcFksD9thyKg1Q@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0ja7AaJza0PeNgutebXRV3tsgxZRwZUBcFksD9thyKg1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/14 21:27, Rafael J. Wysocki wrote:

> On Mon, Jan 13, 2025 at 1:21 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Add IS_OPTIONAL_CPC_REG macro to judge if a cpc_reg is an optional one.
> 
> This requires a bit more explanation, especially what's the purpose of
> it (ie. the "why").

Will add more explanation. Thanks.

> 
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index f193e713825a..6454b469338f 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -129,6 +129,12 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>  #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?         \
>>                                 !!(cpc)->cpc_entry.int_value :          \
>>                                 !IS_NULL_REG(&(cpc)->cpc_entry.reg))
>> +
>> +/* These indicate optional of the per-cpu cpc_regs[]. */
> 
> Again, you need to say more here, like how this is supposed to work.

Will add it. Thanks.

> 
>> +#define REG_OPTIONAL (0b111111100011111010000)
> 
> A hex literal would work too AFAICS.

Will change it. Thanks.

> 
>> +
>> +#define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
> 
> You need to explain what reg_idx is.

Will add more annotations. Thanks.

> 
>> +
>>  /*
>>   * Arbitrary Retries in case the remote processor is slow to respond
>>   * to PCC commands. Keeping it high enough to cover emulators where
>> --


