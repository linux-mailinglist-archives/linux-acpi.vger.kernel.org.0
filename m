Return-Path: <linux-acpi+bounces-1368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96067E6559
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 09:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D751C208B8
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 08:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490710956
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E463B8
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 07:50:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9E268D;
	Wed,  8 Nov 2023 23:50:39 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SQvJM5PHSzfb3j;
	Thu,  9 Nov 2023 15:50:27 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 9 Nov 2023 15:50:32 +0800
Subject: Re: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
To: Sumit Gupta <sumitg@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	<lpieralisi@kernel.org>, <sudeep.holla@arm.com>
CC: <rui.zhang@intel.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <bbasu@nvidia.com>,
	<sanjayc@nvidia.com>, <ksitaraman@nvidia.com>, <srikars@nvidia.com>,
	<jbrasen@nvidia.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20231014105426.26389-1-sumitg@nvidia.com>
 <20231014105426.26389-3-sumitg@nvidia.com>
 <CAJZ5v0ivZd-+wRtCNE4t1P=SjJSEJmW6s7GyuYELWg-v87Tw2w@mail.gmail.com>
 <4fd879be-ae89-45a7-9607-b55606cfb3ac@nvidia.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7f17a560-f26a-eae5-f8d5-1f6602ed8f7c@huawei.com>
Date: Thu, 9 Nov 2023 15:50:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4fd879be-ae89-45a7-9607-b55606cfb3ac@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected

On 2023/10/20 16:30, Sumit Gupta wrote:
> 
>>> Current implementation of processor_thermal performs software throttling
>>> in fixed steps of "20%" which can be too coarse for some platforms.
>>> We observed some performance gain after reducing the throttle 
>>> percentage.
>>> Change the CPUFREQ thermal reduction percentage and maximum thermal 
>>> steps
>>> to be configurable. Also, update the default values of both for Nvidia
>>> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to 
>>> "5%"
>>> and accordingly the maximum number of thermal steps are increased as 
>>> they
>>> are derived from the reduction percentage.
>>>
>>> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
>>> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>>   drivers/acpi/arm64/Makefile          |  1 +
>>>   drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
>>>   drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
>>>   include/linux/acpi.h                 |  9 +++++++
>>>   4 files changed, 62 insertions(+), 3 deletions(-)
>>>   create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
>>>
>>> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
>>> index 143debc1ba4a..3f181d8156cc 100644
>>> --- a/drivers/acpi/arm64/Makefile
>>> +++ b/drivers/acpi/arm64/Makefile
>>> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT)         += gtdt.o
>>>   obj-$(CONFIG_ACPI_APMT)        += apmt.o
>>>   obj-$(CONFIG_ARM_AMBA)         += amba.o
>>>   obj-y                          += dma.o init.o
>>> +obj-$(CONFIG_ACPI)             += thermal_cpufreq.o
>>> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c 
>>> b/drivers/acpi/arm64/thermal_cpufreq.c
>>> new file mode 100644
>>> index 000000000000..de834fb013e7
>>> --- /dev/null
>>> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
>>> @@ -0,0 +1,20 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +#include <linux/acpi.h>
>>> +
>>> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
>>> +#define SMCCC_SOC_ID_T241      0x036b0241
>>> +
>>> +int acpi_thermal_cpufreq_pctg(void)
>>> +{
>>> +       s32 soc_id = arm_smccc_get_soc_id_version();
>>> +
>>> +       /*
>>> +        * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
>>> +        * reduce the CPUFREQ Thermal reduction percentage to 5%.
>>> +        */
>>> +       if (soc_id == SMCCC_SOC_ID_T241)
>>> +               return 5;
>>> +
>>> +       return 0;
>>> +}
>>> +#endif
>>
>> This part needs an ACK from the ARM folks.
>>
> Sorry, missed adding 'ACPI arm64' maintainers. Added Lorenzo, Sudeep and 
> Hanjun.

Sorry for the late reply, would mind giving me the link which the ID
(SMCCC_SOC_ID_T241) is documented?

Thanks
Hanjun

