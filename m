Return-Path: <linux-acpi+bounces-10677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC3A11CA9
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 10:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB5C169062
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16DA246A32;
	Wed, 15 Jan 2025 08:59:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD73246A18;
	Wed, 15 Jan 2025 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931542; cv=none; b=YcopZ2tupjzrjaWde68VzogUQp9IiN34qP3D62Rj8O8nYXqghx0RoV5iHBF/JSbsJKcn7xOacUUsf5Oj8u98spjQo2hiBGyMTnXErbrd+KHGQNc24XM7F2RY+eZ8lkuMZ1l7WwlvvsYAEyEUVcxah+yQHsTHJgWBOZQcfHTzaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931542; c=relaxed/simple;
	bh=W5jUnKHX3Bc96iYTkLtLx6tVDe56SPHqx1+paIKUr1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OsOs/fNBNrZoYH/94qWayRlcU0QUNvrwLP0PNeg+/kp7w/ZZTtp4JmDmaybRyaRhXDERg3rXh22H96GnqfgbQ0olrtX6PoBx9Tcw13JH9czk6Hqg02OwRKIGmK6h6I1TzU5UdHHMUrXcgsyYlx9FdPcGpUxEfcRBAKX8eIW5YEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YY0F56nfHzbdMn;
	Wed, 15 Jan 2025 16:55:05 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id EEB8618032E;
	Wed, 15 Jan 2025 16:58:56 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 15 Jan
 2025 16:58:56 +0800
Message-ID: <10a624c3-66c1-420c-860d-2ef9104b59d8@huawei.com>
Date: Wed, 15 Jan 2025 16:58:55 +0800
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
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <CAJZ5v0jwqZ4A=eeHSXGHKpj-g+KFNWvgLB_yjM55Yk37LryrwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh100008.china.huawei.com (7.202.181.93)

On 2025/1/15 1:58, Rafael J. Wysocki wrote:

> On Mon, Jan 13, 2025 at 1:21 PM Lifeng Zheng <zhenglifeng1@huawei.com> wrote:
>>
>> Add CPPC_REG_VAL_READ() to implement registers getting functions.
>>
>> Add CPPC_REG_VAL_WRITE() to implement registers setting functions.
>>
>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> 
> I don't particularly like these macros as they will generally make it
> harder to follow the code.
> 
>> ---
>>  drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 571f94855dce..6326a1536cda 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1279,6 +1279,20 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>>         return cpc_write(cpu, reg, val);
>>  }
>>
>> +#define CPPC_REG_VAL_READ(reg_name, reg_idx)           \
>> +int cppc_get_##reg_name(int cpu, u64 *val)             \
>> +{                                                      \
>> +       return cppc_get_reg_val(cpu, reg_idx, val);     \
>> +}                                                      \
>> +EXPORT_SYMBOL_GPL(cppc_get_##reg_name)
> 
> What about if defining something like
> 
> #define CPPC_READ_REG_VAL(cpu, reg_name, val)
> cppc_get_reg_val((cpu), CPPC_REG_IDX(reg_name), (val))
> 
> (and analogously for the WRITE_ part), where CPPC_REG_IDX(reg_name) is
> 
> #define CPPC_REG_IDX(reg_name)    CPPC_REG_##reg_name_IDX
> 
> and there are CPPC_REG_##reg_name_IDX macros defined for all register
> names in use?
> 
> For example
> 
> #define CPPC_REG_desired_perf_IDX   DESIRED_PERF

What about keeping these two macros but replace reg_idx with
CPPC_REG_IDX(reg_name)? With this, the only needed parameter for these two
macros is reg_name.


