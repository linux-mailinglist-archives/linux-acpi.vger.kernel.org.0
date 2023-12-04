Return-Path: <linux-acpi+bounces-2112-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8078032D6
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7110EB20985
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E5B24207
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Dec 2023 12:34:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50013C3;
	Mon,  4 Dec 2023 02:50:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47520139F;
	Mon,  4 Dec 2023 02:51:34 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D08A3F6C4;
	Mon,  4 Dec 2023 02:50:43 -0800 (PST)
Message-ID: <d24b5a25-1a1b-4de5-95ff-c49ca8f8101c@arm.com>
Date: Mon, 4 Dec 2023 10:50:42 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/7] coresight: tmc: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To: James Clark <james.clark@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-6-anshuman.khandual@arm.com>
 <12a9c5da-4b96-78de-4007-211989bdcfa3@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <12a9c5da-4b96-78de-4007-211989bdcfa3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/12/2023 10:42, James Clark wrote:
> 
> 
> On 01/12/2023 06:20, Anshuman Khandual wrote:
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
>>   .../hwtracing/coresight/coresight-tmc-core.c  | 130 +++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tmc.h   |   1 +
>>   3 files changed, 115 insertions(+), 18 deletions(-)
>>
> [...]
>> -static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>> +static int __tmc_probe(struct device *dev, struct resource *res, void *dev_caps)
>>   {
>>   	int ret = 0;
>>   	u32 devid;
>>   	void __iomem *base;
>> -	struct device *dev = &adev->dev;
>>   	struct coresight_platform_data *pdata = NULL;
>> -	struct tmc_drvdata *drvdata;
>> -	struct resource *res = &adev->res;
>> +	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
>>   	struct coresight_desc desc = { 0 };
>>   	struct coresight_dev_list *dev_list = NULL;
>>   
>>   	ret = -ENOMEM;
>> -	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> -	if (!drvdata)
>> -		goto out;
>> -
>> -	dev_set_drvdata(dev, drvdata);
>>   
>>   	/* Validity for the resource is already checked by the AMBA core */
>>   	base = devm_ioremap_resource(dev, res);
>> @@ -487,8 +482,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>   		desc.type = CORESIGHT_DEV_TYPE_SINK;
>>   		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
>>   		desc.ops = &tmc_etr_cs_ops;
>> -		ret = tmc_etr_setup_caps(dev, devid,
>> -					 coresight_get_uci_data(id));
>> +		ret = tmc_etr_setup_caps(dev, devid, dev_caps);
>>   		if (ret)
>>   			goto out;
> [...]
>> -module_amba_driver(tmc_driver);
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
>> +	dev_set_drvdata(&pdev->dev, drvdata);
>> +	pm_runtime_get_noresume(&pdev->dev);
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +
>> +	ret = __tmc_probe(&pdev->dev, res, NULL);
> 
> What effect does passing NULL here have? It seems like the dev_caps did
> something useful when it's set to CORESIGHT_SOC_600_ETR_CAPS. Maybe
> Suzuki knows as he added it?

That was supposed to initialise the capabilities of the TMC-ETR, which
are not discoverable by ID registers. (e.g., SAVE restore of RRP/RWP).
I guess, we could get rid of that cap and use the "PID" register match
to figure out the capabilities.

Suzuki



