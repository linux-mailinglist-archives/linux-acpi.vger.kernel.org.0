Return-Path: <linux-acpi+bounces-1791-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3BF7F61BF
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A03FB213A7
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE52F33CD0
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Nov 2023 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA081B3;
	Thu, 23 Nov 2023 06:32:51 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SbgV61xj0zsR57;
	Thu, 23 Nov 2023 22:29:18 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 Nov 2023 22:32:48 +0800
Subject: Re: [Patch v7] ACPI: processor: reduce CPUFREQ thermal reduction pctg
 for Tegra241
To: Sudeep Holla <sudeep.holla@arm.com>, Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <rui.zhang@intel.com>, <lenb@kernel.org>,
	<lpieralisi@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <bbasu@nvidia.com>, <sanjayc@nvidia.com>,
	<ksitaraman@nvidia.com>, <srikars@nvidia.com>, <jbrasen@nvidia.com>
References: <20231123121433.12089-1-sumitg@nvidia.com>
 <ZV9bGtUsjF1v1oIW@bogus>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <6ccd1598-3c8b-1290-9494-01a3cdbb3003@huawei.com>
Date: Thu, 23 Nov 2023 22:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZV9bGtUsjF1v1oIW@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected

On 2023/11/23 22:00, Sudeep Holla wrote:
> On Thu, Nov 23, 2023 at 05:44:33PM +0530, Sumit Gupta wrote:
>> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>>
>> Current implementation of processor_thermal performs software throttling
>> in fixed steps of "20%" which can be too coarse for some platforms.
>> We observed some performance gain after reducing the throttle percentage.
>> Change the CPUFREQ thermal reduction percentage and maximum thermal steps
>> to be configurable. Also, update the default values of both for Nvidia
>> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
>> and accordingly the maximum number of thermal steps are increased as they
>> are derived from the reduction percentage.
>>
>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>
>> Sending this patch separately as the other patch in the series is
>> applied by Rafael in v6[1]. Revision history before this version is
>> in the cover letter of v6[1].
>>
>> Please review and provide ACK if looks fine.
>>
> 
> For arm64 specific changes(a minor nit below though),
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> 
> [...]
> 
>> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
>> new file mode 100644
>> index 000000000000..d524f2cd6044
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
>> @@ -0,0 +1,20 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <linux/acpi.h>
>> +
>> +#include "../internal.h"
>> +
>> +#define SMCCC_SOC_ID_T241      0x036b0241
>> +
> 
> [nit] We really need to find better place to define this globally and not
> locally at each usage site like this. We already have it in GICv3 driver.
> But that can come as a cleanup later if it causes issue for merging this
> change.

Agreed.

Looks good to me as well.

Acked-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

