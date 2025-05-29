Return-Path: <linux-acpi+bounces-13921-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45BAC78AB
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 08:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FC51C03876
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058E2254B09;
	Thu, 29 May 2025 06:29:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D770410E3;
	Thu, 29 May 2025 06:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500149; cv=none; b=dKVnBlNsrFL1PKw30dmspzW1zr4lMsIOoHAR5xDurQ41TZwF9wXYe5kASClTjzPnV0JEjWcHxh7reav8/ARdhfQvlQ5KVclHFnHTNuWDqyIHD/1dOnPrJlzc9HiwkLQYfGvZYE7uOcBZ1kTNcTM+YNGFHxcbEfonv9qaRv1hD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500149; c=relaxed/simple;
	bh=nEZFeDhMbKm8P6aZ9Z6p0YQJ3z8YaMzgK9SpR1wNv50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BI7u2A50q/bRpptXZ1eDUIBfBWhbc5d1cVFq3/ESf9JQTjCgIVKwW17Sh2L23f3z9bQBVU4Pt9S4fcJ3url35gJeLokUAA4DFzcdWLe6a9x9wm2W1Pm3hxDAFNtnLT/Feb4evG/iusM0Xs/XOyBgCi1d9j0Ms0YbRt3R9XKLv04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4b7GdQ3CC0z1f1pM;
	Thu, 29 May 2025 14:27:54 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C65D1A016C;
	Thu, 29 May 2025 14:28:57 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 May
 2025 14:28:56 +0800
Message-ID: <69327669-155d-415b-a218-2b4806a90890@huawei.com>
Date: Thu, 29 May 2025 14:28:56 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
To: Pierre Gondois <pierre.gondois@arm.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <robert.moore@intel.com>, <lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<cenxinghai@h-partners.com>, <yubowen8@huawei.com>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
 <237e957e-82fa-41ea-9f6e-bd37f51003aa@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <237e957e-82fa-41ea-9f6e-bd37f51003aa@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/5/28 21:26, Pierre Gondois wrote:

> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

Thanks!

> 
> On 5/26/25 13:30, Lifeng Zheng wrote:
>> This patch series makes some minor optimizations for cppc_cpufreq.c to
>> makes codes cleaner.
>>
>> Lifeng Zheng (3):
>>    cpufreq: CPPC: Remove cpu_data_list
>>    cpufreq: CPPC: Return void in populate_efficiency_class()
>>    cpufreq: CPPC: Remove forward declaration of
>>      cppc_cpufreq_register_em()
>>
>>   drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
>>   include/acpi/cppc_acpi.h       |  1 -
>>   2 files changed, 15 insertions(+), 45 deletions(-)
>>


