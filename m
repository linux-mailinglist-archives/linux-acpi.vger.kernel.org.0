Return-Path: <linux-acpi+bounces-2136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A3804A29
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 07:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EFF1C20CDA
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 06:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323E12E63
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 06:34:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA86E101;
	Mon,  4 Dec 2023 21:20:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 339731007;
	Mon,  4 Dec 2023 21:21:14 -0800 (PST)
Received: from [10.163.35.139] (unknown [10.163.35.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F30B3F762;
	Mon,  4 Dec 2023 21:20:23 -0800 (PST)
Message-ID: <81cad3a6-a080-424c-ad0b-0f08c4fe51a2@arm.com>
Date: Tue, 5 Dec 2023 10:50:19 +0530
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
To: James Clark <james.clark@arm.com>, linux-arm-kernel@lists.infradead.org,
 suzuki.poulose@arm.com, Sudeep Holla <Sudeep.Holla@arm.com>
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
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <7825dcd4-94e1-7a5f-b388-90e748dfc47f@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/4/23 18:47, James Clark wrote:
> 
> 
> On 04/12/2023 11:50, Anshuman Khandual wrote:
>>
>>
>> On 12/4/23 15:53, James Clark wrote:
>>>
>>>
>>> On 01/12/2023 06:20, Anshuman Khandual wrote:
>>>> Add support for the stm devices in the platform driver, which can then be
>>>> used on ACPI based platforms. This change would now allow runtime power
>>>> management for ACPI based systems. The driver would try to enable the APB
>>>> clock if available.
>>>>
>>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
>>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>> Cc: James Clark <james.clark@arm.com>
>>>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>> Cc: linux-acpi@vger.kernel.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: coresight@lists.linaro.org
>>>> Cc: linux-stm32@st-md-mailman.stormreply.com
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>> [...]
>>>>  
>>>> -module_amba_driver(stm_driver);
>>>> +static int stm_platform_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	int ret = 0;
>>>> +
>>>> +	pm_runtime_get_noresume(&pdev->dev);
>>>> +	pm_runtime_set_active(&pdev->dev);
>>>> +	pm_runtime_enable(&pdev->dev);
>>>> +
>>>> +	ret = __stm_probe(&pdev->dev, res, NULL);
>>>
>>> Very minor nit, but this used to print this:
>>>
>>>   coresight stm0: STM500 initialized
>>>
>>> And now it prints this:
>>>
>>>   coresight stm0: (null) initialized
>>>
>>> (null) kind of makes it look a little bit like something has gone wrong.
>>> Maybe we could just put "initialised" if you don't have a string from ACPI?
>>
>> __stm_probe() gets called from both AMBA and platform driver paths. Even though
>> a NULL check inside dev_info(..."%s initialized\n",...) could be added, but how
>> to differentiate it from a scenario when coresight_get_uci_data() returns NULL ?
> 
> Sudeep's suggestion seems ok, just add a hard coded string instead of
> the NULL. And keep the coresight_get_uci_data() the same.

Something like this works ?

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 3387ebc9d8ab..2b6834c4cac6 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -906,7 +906,7 @@ static int __stm_probe(struct device *dev, struct resource *res, void *dev_caps)
        pm_runtime_put(dev);
 
        dev_info(&drvdata->csdev->dev, "%s initialized\n",
-                (char *)dev_caps);
+                dev_caps ? (char *)dev_caps: "STM");
        return 0;
 
 cs_unregister:


