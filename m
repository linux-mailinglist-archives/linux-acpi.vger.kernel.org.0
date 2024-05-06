Return-Path: <linux-acpi+bounces-5627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40B8BC5EE
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 04:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27F51C21490
	for <lists+linux-acpi@lfdr.de>; Mon,  6 May 2024 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2237142;
	Mon,  6 May 2024 02:55:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCFC22075;
	Mon,  6 May 2024 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964117; cv=none; b=YbHnIPey6MIaVsvclrc/ysfxW9Pk/WhCEHuFenHeaYN3HprzangpX9IGnKG8am+PoS3hdPhX5+Lc8DyjRZFt9bJQBecnu2w5O2KiLH5jbIScyoOyZ9dIHye5Sj8Cjzouu2JlpPtwEzHZUZSz63fdAyGxtg8FqS035hNVuC2KRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964117; c=relaxed/simple;
	bh=KO15BVN2XvLxj8SVCAQLarwOrfH3EAsRaTUl+Hinxmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WKq4ZzaeYJHiej/zioLHeUa8xLFpDyQ2EDG8nn3JCjxzmTSONcfMjmD4rnta9C9RQLi9atMELrWtuUYUbM7HCubP7g765wXdgfSiNkhFMb1xXvUVPXDfnPGHEk84s4r5bSdJqrkxVj7g89loH3o9TT3W1Ah4YFCEjFQfALldhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VXmC65TdyzxNfp;
	Mon,  6 May 2024 10:51:46 +0800 (CST)
Received: from dggpemm500018.china.huawei.com (unknown [7.185.36.111])
	by mail.maildlp.com (Postfix) with ESMTPS id 52CAF140428;
	Mon,  6 May 2024 10:55:10 +0800 (CST)
Received: from [10.174.178.96] (10.174.178.96) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 6 May 2024 10:55:09 +0800
Message-ID: <df3d5556-30b1-42d9-aecc-1ad155f024bc@huawei.com>
Date: Mon, 6 May 2024 10:55:09 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/cppc: fix perf_to_khz conversion exception
To: Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-acpi@vger.kernel.org>, <rafael@kernel.org>,
	<linux-kernel@vger.kernel.org>, <lenb@kernel.org>, <liwei391@huawei.com>,
	<viresh.kumar@linaro.org>
References: <20240430101227.2133288-1-liwei728@huawei.com>
 <0f8ccc3d-46ca-4632-9ecf-5da596ad5a1a@arm.com>
From: "liwei (JK)" <liwei728@huawei.com>
In-Reply-To: <0f8ccc3d-46ca-4632-9ecf-5da596ad5a1a@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500018.china.huawei.com (7.185.36.111)

Hello Pierre,

Thanks for your reminder.

在 2024/5/3 15:42, Pierre Gondois 写道:
> Hello Liwei,
> 
> Thanks for the fix. I think there might be a similar issue
> in cppc_khz_to_perf(),
> 
> Regards,
> Pierre
> 

cppc_khz_to_perf() also has similar issue, I will modify the patch again.

Liwei

> On 4/30/24 12:12, liwei wrote:
>> When the nominal_freq recorded by the kernel is equal to lowest_freq and
>> the frequency reduction operation is triggered externally, there is a
>> conversion logic error in cppc_perf_to_khz(), causing the kernel to be
>> unable to feedback the true frequency.
>>
>> Fix this by adding the branch processing logic when nominal_freq is equal
>> to lowest_freq.
>>
>> Fixes: ec1c7ad47664 ("cpufreq: CPPC: Fix performance/frequency 
>> conversion")
>> Signed-off-by: liwei <liwei728@huawei.com>
>> ---
>>   drivers/acpi/cppc_acpi.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a40b6f3946ef..92aac6974e0e 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1869,9 +1869,15 @@ unsigned int cppc_perf_to_khz(struct 
>> cppc_perf_caps *caps, unsigned int perf)
>>       u64 mul, div;
>>       if (caps->lowest_freq && caps->nominal_freq) {
>> -        mul = caps->nominal_freq - caps->lowest_freq;
>> +        /* Avoid the special case when nominal_freq is equal to 
>> lowest_freq */
>> +        if (caps->lowest_freq == caps->nominal_freq) {
>> +            mul = caps->nominal_freq;
>> +            div = caps->nominal_perf;
>> +        } else {
>> +            mul = caps->nominal_freq - caps->lowest_freq;
>> +            div = caps->nominal_perf - caps->lowest_perf;
>> +        }
>>           mul *= KHZ_PER_MHZ;
>> -        div = caps->nominal_perf - caps->lowest_perf;
>>           offset = caps->nominal_freq * KHZ_PER_MHZ -
>>                div64_u64(caps->nominal_perf * mul, div);
>>       } else {

