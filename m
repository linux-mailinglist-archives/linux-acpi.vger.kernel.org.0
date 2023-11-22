Return-Path: <linux-acpi+bounces-1759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733917F4FC7
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D641C203BC
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1506A5CD0B
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EB901A5;
	Wed, 22 Nov 2023 09:15:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230001FB;
	Wed, 22 Nov 2023 09:16:01 -0800 (PST)
Received: from [10.57.42.32] (unknown [10.57.42.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA273F73F;
	Wed, 22 Nov 2023 09:15:12 -0800 (PST)
Message-ID: <4de2b664-b7c8-4216-bb57-6f887bd751d2@arm.com>
Date: Wed, 22 Nov 2023 17:15:11 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] coresight: tmc: Move ACPI support from AMBA driver to
 platform driver
Content-Language: en-GB
To: Sudeep Holla <sudeep.holla@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
 <20231027072943.3418997-6-anshuman.khandual@arm.com> <ZV40itsgT5OSJmdC@bogus>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <ZV40itsgT5OSJmdC@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2023 17:04, Sudeep Holla wrote:
> On Fri, Oct 27, 2023 at 12:59:41PM +0530, Anshuman Khandual wrote:
>> Add support for the tmc devices in the platform driver, which can then be
>> used on ACPI based platforms. This change would now allow runtime power
>> management for ACPI based systems. The driver would try to enable the APB
>> clock if available.
>>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: linux-acpi@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: coresight@lists.linaro.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/acpi/arm64/amba.c                     |   2 -
>>   .../hwtracing/coresight/coresight-tmc-core.c  | 127 +++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tmc.h   |   1 +
>>   3 files changed, 113 insertions(+), 17 deletions(-)
> 
> [...]
> 
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 7ec5365e2b64..618bc0b7a1a5 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> 
> [...]
> 
>> @@ -573,9 +579,9 @@ static void tmc_shutdown(struct amba_device *adev)
>>   	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>   }
>>   
>> -static void tmc_remove(struct amba_device *adev)
>> +static void __tmc_remove(struct device *dev)
>>   {
>> -	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
>>   
>>   	/*
>>   	 * Since misc_open() holds a refcount on the f_ops, which is
>> @@ -586,6 +592,11 @@ static void tmc_remove(struct amba_device *adev)
>>   	coresight_unregister(drvdata->csdev);
>>   }
>>   
>> +static void tmc_remove(struct amba_device *adev)
>> +{
>> +	__tmc_remove(&adev->dev);
>> +}
>> +
>>   static const struct amba_id tmc_ids[] = {
>>   	CS_AMBA_ID(0x000bb961),
>>   	/* Coresight SoC 600 TMC-ETR/ETS */
>> @@ -613,6 +624,92 @@ static struct amba_driver tmc_driver = {
>>   
>>   module_amba_driver(tmc_driver);
>>   
>> +static int tmc_platform_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	struct tmc_drvdata *drvdata;
>> +	int ret = 0;
>> +
>> +	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +
>> +	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
>> +	if (IS_ERR(drvdata->pclk))
>> +		return -ENODEV;
>> +
> 
> --->8
>> +	if (res) {
>> +		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>> +		if (IS_ERR(drvdata->base)) {
>> +			clk_put(drvdata->pclk);
>> +			return PTR_ERR(drvdata->base);
>> +		}
>> +	}
>> +
> ---
> 
> You need drop the above hunk as _tmc_probe() already takes care of that.
> This is the root cause for the issue I reported in the other thread. Also
> sorry for the confusion, I had to refer to coresight-tmc-core.c and post
> the patch to unify module_init/exit but completely mixed up the file/patch
> and referred coresight-tpiu-core.c instead as that patch was dealing with
> it.

Thank you Sudeep for getting to the bottom of the problem !

Suzuki
> 


