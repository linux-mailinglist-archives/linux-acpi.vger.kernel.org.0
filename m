Return-Path: <linux-acpi+bounces-536-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7C37BDC25
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BE01C20445
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 12:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E327199A7
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186E15AF8
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 12:29:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86692E4
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 05:29:52 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S3yv33wNrzVlVl;
	Mon,  9 Oct 2023 20:26:23 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 9 Oct 2023 20:29:50 +0800
Subject: Re: [PATCH v2] ACPI: bus: Consolidate all arm specific initialisation
 into acpi_arm_init()
To: D Scott Phillips <scott@os.amperecomputing.com>, Sudeep Holla
	<sudeep.holla@arm.com>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Robin
 Murphy <robin.murphy@arm.com>
References: <20230606093531.2746732-1-sudeep.holla@arm.com>
 <867cnzqojo.fsf@scott-ph-mail.amperecomputing.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <00dd9623-a131-53ed-5e73-1eccd626d2d7@huawei.com>
Date: Mon, 9 Oct 2023 20:29:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <867cnzqojo.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/10/7 8:11, D Scott Phillips wrote:
> Sudeep Holla <sudeep.holla@arm.com> writes:
> 
>> Move all of the ARM-specific initialization into one function namely
>> acpi_arm_init(), so it is not necessary to modify/update bus.c every
>> time a new piece of it is added.
>>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Rafael J. Wysocki <rafael@kernel.org>
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
>> Link: https://lore.kernel.org/r/CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/acpi/arm64/Makefile |  2 +-
>>   drivers/acpi/arm64/agdi.c   |  2 +-
>>   drivers/acpi/arm64/apmt.c   |  2 +-
>>   drivers/acpi/arm64/init.c   | 13 +++++++++++++
>>   drivers/acpi/arm64/init.h   |  6 ++++++
>>   drivers/acpi/arm64/iort.c   |  1 +
>>   drivers/acpi/bus.c          |  7 +------
>>   include/linux/acpi.h        |  6 ++++++
>>   include/linux/acpi_agdi.h   | 13 -------------
>>   include/linux/acpi_apmt.h   | 19 -------------------
>>   include/linux/acpi_iort.h   |  2 --
>>   11 files changed, 30 insertions(+), 43 deletions(-)
>>   create mode 100644 drivers/acpi/arm64/init.c
>>   create mode 100644 drivers/acpi/arm64/init.h
>>   delete mode 100644 include/linux/acpi_agdi.h
>>   delete mode 100644 include/linux/acpi_apmt.h
[...]
>> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
>> new file mode 100644
>> index 000000000000..d3ce53dda122
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/init.c
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <linux/acpi.h>
>> +#include "init.h"
>> +
>> +void __init acpi_arm_init(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_ACPI_AGDI))
>> +		acpi_agdi_init();
>> +	if (IS_ENABLED(CONFIG_ACPI_APMT))
>> +		acpi_apmt_init();
>> +	if (IS_ENABLED(CONFIG_ACPI_IORT))
>> +		acpi_iort_init();
>> +}
[...]
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index d161ff707de4..7a1eaf8c7bde 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -26,9 +26,6 @@
>>   #include <asm/mpspec.h>
>>   #include <linux/dmi.h>
>>   #endif
>> -#include <linux/acpi_agdi.h>
>> -#include <linux/acpi_apmt.h>
>> -#include <linux/acpi_iort.h>
>>   #include <linux/acpi_viot.h>
>>   #include <linux/pci.h>
>>   #include <acpi/apei.h>
>> @@ -1408,7 +1405,7 @@ static int __init acpi_init(void)
>>   	acpi_init_ffh();
>>
>>   	pci_mmcfg_late_init();
>> -	acpi_iort_init();
>> +	acpi_arm_init();
>>   	acpi_viot_early_init();
>>   	acpi_hest_init();
>>   	acpi_ghes_init();
>> @@ -1420,8 +1417,6 @@ static int __init acpi_init(void)
>>   	acpi_debugger_init();
>>   	acpi_setup_sb_notify_handler();
>>   	acpi_viot_init();
>> -	acpi_agdi_init();
>> -	acpi_apmt_init();
> 
> Hi Sudeep, this moves acpi_agdi_init() before acpi_ghes_init().
> sdei initialization currently happens from ghes_init, so agdi devices
> using SDEI can no longer probe:
> 
> | [    0.515864] sdei: Failed to create event 1073741825: -5
> | [    0.515866] agdi agdi.0: Failed to register for SDEI event 1073741825
> | [    0.515867] agdi: probe of agdi.0 failed with error -5
> | ...
> | [    0.516022] sdei: SDEIv1.0 (0x0) detected in firmware.

How about just move acpi_arm_init() to the place of after
acpi_ghes_init()?

I checked the functions in acpi_arm_init(), there are no other
dependencies except sdei_init().

Thanks
Hanjun

