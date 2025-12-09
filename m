Return-Path: <linux-acpi+bounces-19505-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 855CBCB015B
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 14:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44CA830B6214
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D4329E46;
	Tue,  9 Dec 2025 13:37:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49222C08DC;
	Tue,  9 Dec 2025 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287477; cv=none; b=ex5HwLS2adzIXDSoc+WZb0ocezmtGiQ1dx5PQu2gW3bnNdNFx+01c3nYfIx5zK44BvkndaSHS0CDVC3Cz7LZ58/fKiYyBeoa/O2bYlYQ0Jg2hSXex9/tgtiVXNvfEbQ94BYEkt6rzkSYMpnO01Jn7md3a73k6oykEj1GIYv4iyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287477; c=relaxed/simple;
	bh=wbweG4FctRNk+yt3RR0+CAPeM/y4INczATZ8NDMFh+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SNmjpkDdOhhwHNnA1N94cVyPJIrX/dkE6cwhdhbxfHawrLG/Je0jvBpqWMk2nAXMpiuHlCwVD6ujG1RIdOCd3OYQBNjgOKLW0/hosfbD/p4mUz4KfsqEXcLbleBIdAqlJzpTH++E7ehjpXIL/Zm2FWOHosyJNOBTZuOBFbtwc/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dQfwv6G51zcb2h;
	Tue,  9 Dec 2025 21:35:11 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 037CB1400C8;
	Tue,  9 Dec 2025 21:37:51 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Dec
 2025 21:37:50 +0800
Message-ID: <4e850664-f883-4a26-b8d6-f484a9114ed2@hisilicon.com>
Date: Tue, 9 Dec 2025 21:37:49 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] ACPI: CPPC: Factor out and export per-cpu
 cppc_perf_ctrs_in_pcc_cpu()
To: Beata Michalska <beata.michalska@arm.com>
CC: <viresh.kumar@linaro.org>, <rafael@kernel.org>, <ionela.voinescu@arm.com>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<yubowen8@huawei.com>, <lihuisong@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
 <20251203032422.3232957-2-zhanjie9@hisilicon.com> <aTb6Gvzvc9C7vnVP@arm.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <aTb6Gvzvc9C7vnVP@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 12/9/2025 12:17 AM, Beata Michalska wrote:
> On Wed, Dec 03, 2025 at 11:24:20AM +0800, Jie Zhan wrote:
>> Factor out cppc_perf_ctrs_in_pcc_cpu() for checking whether per-cpu CPC
>> regs are defined in PCC channels, and export it out for further use.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> ---
>>  drivers/acpi/cppc_acpi.c | 45 +++++++++++++++++++++-------------------
>>  include/acpi/cppc_acpi.h |  5 +++++
>>  2 files changed, 29 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 3bdeeee3414e..aa80dbcf42c0 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1422,6 +1422,29 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>  }
>>  EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
>>  
>> +bool cppc_perf_ctrs_in_pcc_cpu(unsigned int cpu)
>> +{
>> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +	struct cpc_register_resource *ref_perf_reg;
>> +
>> +	/*
>> +	 * If reference perf register is not supported then we should use the
>> +	 * nominal perf value
>> +	 */
>> +	ref_perf_reg = &cpc_desc->cpc_regs[REFERENCE_PERF];
>> +	if (!CPC_SUPPORTED(ref_perf_reg))
>> +		ref_perf_reg = &cpc_desc->cpc_regs[NOMINAL_PERF];
>> +
>> +	if (CPC_IN_PCC(&cpc_desc->cpc_regs[DELIVERED_CTR]) ||
>> +	    CPC_IN_PCC(&cpc_desc->cpc_regs[REFERENCE_CTR]) ||
>> +	    CPC_IN_PCC(&cpc_desc->cpc_regs[CTR_WRAP_TIME]) ||
>> +	    CPC_IN_PCC(ref_perf_reg))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_perf_ctrs_in_pcc_cpu);
> It is minor, but I would prefer the earlier version when we grab the reference
> performance reg only when none of the other regs is in the PCC.
Why?

It could return a little bit earlier for the PCC reg case, but this is only
called in initialization so efficiency is not that important I guess.
> 
> ---
> BR
> Beata

...

