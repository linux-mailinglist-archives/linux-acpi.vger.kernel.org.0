Return-Path: <linux-acpi+bounces-2151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D47805049
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0FDCB20D7C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0F155C29
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 10:36:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1011490;
	Tue,  5 Dec 2023 02:18:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 105DE1007;
	Tue,  5 Dec 2023 02:19:14 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0A893F5A1;
	Tue,  5 Dec 2023 02:18:25 -0800 (PST)
Message-ID: <5cbe90e1-e140-455a-8cc7-c5ebece64170@arm.com>
Date: Tue, 5 Dec 2023 10:18:24 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/7] coresight: stm: Move ACPI support from AMBA driver
 to platform driver
Content-Language: en-US
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 James Clark <james.clark@arm.com>, linux-arm-kernel@lists.infradead.org,
 Sudeep Holla <Sudeep.Holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20231201062053.1268492-1-anshuman.khandual@arm.com>
 <20231201062053.1268492-7-anshuman.khandual@arm.com>
 <0adc3a16-0fc4-2a25-cd48-4667881b9490@arm.com>
 <e53cec31-9452-4c2a-a3a1-b6ef33be8e22@arm.com>
 <7825dcd4-94e1-7a5f-b388-90e748dfc47f@arm.com>
 <81cad3a6-a080-424c-ad0b-0f08c4fe51a2@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <81cad3a6-a080-424c-ad0b-0f08c4fe51a2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2023 05:20, Anshuman Khandual wrote:
> 
> 
> On 12/4/23 18:47, James Clark wrote:
>>
>>
>> On 04/12/2023 11:50, Anshuman Khandual wrote:
>>>
>>>
>>> On 12/4/23 15:53, James Clark wrote:
>>>>
>>>>
>>>> On 01/12/2023 06:20, Anshuman Khandual wrote:
>>>>> Add support for the stm devices in the platform driver, which can then be
>>>>> used on ACPI based platforms. This change would now allow runtime power
>>>>> management for ACPI based systems. The driver would try to enable the APB
>>>>> clock if available.
>>>>>
>>>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>>> Cc: James Clark <james.clark@arm.com>
>>>>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>>>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>>> Cc: linux-acpi@vger.kernel.org
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Cc: coresight@lists.linaro.org
>>>>> Cc: linux-stm32@st-md-mailman.stormreply.com
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> ---
>>>> [...]
>>>>>   
>>>>> -module_amba_driver(stm_driver);
>>>>> +static int stm_platform_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> +	int ret = 0;
>>>>> +
>>>>> +	pm_runtime_get_noresume(&pdev->dev);
>>>>> +	pm_runtime_set_active(&pdev->dev);
>>>>> +	pm_runtime_enable(&pdev->dev);
>>>>> +
>>>>> +	ret = __stm_probe(&pdev->dev, res, NULL);
>>>>
>>>> Very minor nit, but this used to print this:
>>>>
>>>>    coresight stm0: STM500 initialized
>>>>
>>>> And now it prints this:
>>>>
>>>>    coresight stm0: (null) initialized
>>>>
>>>> (null) kind of makes it look a little bit like something has gone wrong.
>>>> Maybe we could just put "initialised" if you don't have a string from ACPI?
>>>
>>> __stm_probe() gets called from both AMBA and platform driver paths. Even though
>>> a NULL check inside dev_info(..."%s initialized\n",...) could be added, but how
>>> to differentiate it from a scenario when coresight_get_uci_data() returns NULL ?
>>
>> Sudeep's suggestion seems ok, just add a hard coded string instead of
>> the NULL. And keep the coresight_get_uci_data() the same.
> 
> Something like this works ?
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 3387ebc9d8ab..2b6834c4cac6 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -906,7 +906,7 @@ static int __stm_probe(struct device *dev, struct resource *res, void *dev_caps)
>          pm_runtime_put(dev);
>   
>          dev_info(&drvdata->csdev->dev, "%s initialized\n",
> -                (char *)dev_caps);
> +                dev_caps ? (char *)dev_caps: "STM");
>          return 0;
>   

Please could stop abusing the private data for storing the name ? 
Instead, we could read the PID of the device and use a table to map
it to the name and use that instead ?

Suzuki


>   cs_unregister:
> 


