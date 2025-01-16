Return-Path: <linux-acpi+bounces-10717-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CEFA13082
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 02:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FF6188877E
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 01:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D85672;
	Thu, 16 Jan 2025 01:12:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0718EAB;
	Thu, 16 Jan 2025 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736989960; cv=none; b=BGTFUDOpF8UjyoqH8VU6bZrCRlkOx22a3aQ2iuEdY+dzYJ/EHF7cjQbM9ucsy+SidMxptkYRoF3e6dZTFCL4P4grcaAwPwWz6yCwp7cUfg043kmpx2zW9Eb0cvVn8tK4KvWdAKWnVR59cGPOFHFHVirrkHoIJ1S3oTLAajG9KXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736989960; c=relaxed/simple;
	bh=p9xH1LWjbCz5EIUUEUVDixoHMwduCie9Gyqncolw9/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fudb/UgTADS3kTMOzADR5xcNIsvOaWzfXTXoVrwCQnf1e9dFahX2yzanr37DUP/QF032FDPexk0jD96SHuilmvIYym6QNpN95pSejRn2oImiYRQJ9JUfJE5Bfn2sftVA+6FsxVgJDmDwkB8aKyQDEqiLGW5YsKGkIGm0Pz0O7sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YYPrR4Kw2z1W4DZ;
	Thu, 16 Jan 2025 09:08:39 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 3977E1400CD;
	Thu, 16 Jan 2025 09:12:31 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Jan
 2025 09:12:30 +0800
Message-ID: <f9eedd4b-b7a7-4f95-90c8-09871e2cda57@huawei.com>
Date: Thu, 16 Jan 2025 09:12:29 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] ACPI: CPPC: Add macros to generally implement
 registers getting and setting functions
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <viresh.kumar@linaro.org>,
	<mario.limonciello@amd.com>, <gautham.shenoy@amd.com>, <ray.huang@amd.com>,
	<pierre.gondois@arm.com>, <acpica-devel@lists.linux.dev>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <hepeng68@huawei.com>, <fanghao11@huawei.com>
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-4-zhenglifeng1@huawei.com>
 <CAJZ5v0jwqZ4A=eeHSXGHKpj-g+KFNWvgLB_yjM55Yk37LryrwQ@mail.gmail.com>
 <10a624c3-66c1-420c-860d-2ef9104b59d8@huawei.com>
 <CAJZ5v0jmZy0tNO7Btc9-A0rfzL5jPp2ZEH99bEX00cEi3z+XcQ@mail.gmail.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0jmZy0tNO7Btc9-A0rfzL5jPp2ZEH99bEX00cEi3z+XcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/15 19:12, Rafael J. Wysocki wrote:

> On Wed, Jan 15, 2025 at 9:59 AM zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
>>
>> On 2025/1/15 1:58, Rafael J. Wysocki wrote:
>>
>>> On Mon, Jan 13, 2025 at 1:21 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>>>
>>>> Add CPPC_REG_VAL_READ() to implement registers getting functions.
>>>>
>>>> Add CPPC_REG_VAL_WRITE() to implement registers setting functions.
>>>>
>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>
>>> I don't particularly like these macros as they will generally make it
>>> harder to follow the code.
>>>
>>>> ---
>>>>  drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index 571f94855dce..6326a1536cda 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -1279,6 +1279,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>>>>         return cpc_write(cpu, reg, val);
>>>>  }
>>>>
>>>> +#define CPPC_REG_VAL_READ(reg_name, reg_idx)           \
>>>> +int cppc_get_##reg_name(int cpu, u64 *val)             \
>>>> +{                                                      \
>>>> +       return cppc_get_reg_val(cpu, reg_idx, val);     \
>>>> +}                                                      \
>>>> +EXPORT_SYMBOL_GPL(cppc_get_##reg_name)
>>>
>>> What about if defining something like
>>>
>>> #define CPPC_READ_REG_VAL(cpu, reg_name, val)
>>> cppc_get_reg_val((cpu), CPPC_REG_IDX(reg_name), (val))
>>>
>>> (and analogously for the WRITE_ part), where CPPC_REG_IDX(reg_name) is
>>>
>>> #define CPPC_REG_IDX(reg_name)    CPPC_REG_##reg_name_IDX
>>>
>>> and there are CPPC_REG_##reg_name_IDX macros defined for all register
>>> names in use?
>>>
>>> For example
>>>
>>> #define CPPC_REG_desired_perf_IDX   DESIRED_PERF
>>
>> What about keeping these two macros but replace reg_idx with
>> CPPC_REG_IDX(reg_name)? With this, the only needed parameter for these two
>> macros is reg_name.
> 
> The problem is that looking up functions defined through macros is
> hard when somebody wants to know what they do, so I'd prefer to avoid
> doing that.

I see your point. Let's just remove these.

> 
> 


